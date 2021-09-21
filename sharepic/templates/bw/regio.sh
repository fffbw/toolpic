#!/bin/bash
curl "https://api.fffutu.re/v1/localGroups/?state=Baden-W%C3%BCrttemberg" | sed -r -e 's/"state[^}]*}/\n/g' | sed -e 's/^[^:]*:[^:]*://' -e'/]/d' > regiotemp.txt
ogs=$(cat regiotemp.txt | sed -n '$=')
echo "Download erfolgreich, $ogs OGs vorhanden"
echo "{
  \"name\": \"Bw-Karte\",
  \"root\": \"https://sanojkl.ddns.net/toolpic/sharepic/templates/bw/template.json\",
  \"preview\": \"sharepic/templates/bw/preview.jpg\",
  \"documents\": [
    {
      \"width\": 1200,
      \"height\": 1200,
      \"src\": \"sharepic/templates/bw/1200x1200.svg\",
      \"alias\": \"Facebook, Instagram\"
    }
  ],
  \"fonts\": [
    {
      \"name\": \"Jost\",
      \"src\": \"fonts/Jost/Jost-600-Semi.ttf\",
      \"mime\": \"font/truetype\"
    },
    {
      \"name\": \"Jost-400\",
      \"src\": \"fonts/Jost/Jost-400-Book.ttf\",
      \"mime\": \"font/truetype\"
    },
    {
      \"name\": \"Jost-300\",
      \"src\": \"fonts/Jost/Jost-300-Light.ttf\",
      \"mime\": \"font/truetype\"
    },
    {
      \"name\": \"Jost-700\",
      \"src\": \"fonts/Jost/Jost-700-Bold.ttf\",
      \"mime\": \"font/truetype\"
    },
    {
      \"name\": \"Jost-500\",
      \"src\": \"fonts/Jost/Jost-500-Medium.ttf\",
      \"mime\": \"font/truetype\"
    }
  ],
  \"fields\": [
    {
      \"type\": \"selection\",
      \"description\": \"Background\",
      \"key\": \"backgroundImage\",
      \"default\": {
        \"value\": \"sharepic/templates/bw/bg.jpg\"
      },
      \"properties\": {
        \"items\": [
          {
            \"type\": \"file\"
          }
        ]
      }
    },
    {
      \"type\": \"number\",
      \"description\": \"Position\",
      \"key\": \"pos\",
      \"default\": 0,
      \"properties\": {
        \"value\": 0,
        \"max\": 1,
        \"min\": -1,
        \"step\": 0.05,
        \"kind\": \"slider\"
      }
    },
	{
      \"type\": \"line\",
      \"description\": \"Datum\",
      \"key\": \"date\",
      \"default\": \"01.01.\",
      \"properties\": {

      }
    },
	{
      \"type\": \"checklist\",
      \"description\": \"Orte:\",
      \"key\": \"locations\",
      \"default\": [" >template.json
for ((i=1;i<$ogs;i++)); do echo "true,";  done >>template.json
echo "true],
      \"properties\": {
        \"fields\": [" >>template.json
cat regiotemp.txt | sed -r -e 's/^"([^"]*)".*/"\1",/g' -e '$s/,/ /g' >>template.json
echo "        ]
      }
    }
  ]
}" >>template.json
echo template.json generiert
echo "<svg xmlns=\"http://www.w3.org/2000/svg\"
     xmlns:xlink=\"http://www.w3.org/1999/xlink\"
     viewBox=\"0 0 1200 1200\"
     version=\"1.1\">
 <g class=\"main\">
    <image v-if=\"typeof backgroundImage == 'object'\" v-bind:xlink:href=\"backgroundImage.value\" v-fitimage v-bind:data-image-pos=\"pos\" style=\"transform-origin: 50% 50%;\" />
	<g>
	    <image xlink:href=\"sharepic/resources/logobw.png\" x=\"80\" y=\"250\" height=\"260\" width=\"260\" />
        </g>
	<g>
	 <text x=\"45\" y=\"160\" style=\"fill: #1DA64A; font-family: 'Jost'; font-size: 130px;\" >Demos am</text>
	 </g><g>
	 <text x=\"700\" y=\"160\" style=\"fill: #1DA64A; font-family: 'Jost'; font-size: 130px;\" >{{ date }}</text>
	</g>" > 1200x1200.svg

cat regiotemp.txt | sed -r 's/^[^:]*:([^,]*),"lon":([^,]*),/\1 \2 /g' | sed = | sed 'N;s/\n/ /' | sed -r 's/^(\S*)\s(\S*)\s(\S*)/\2 \3 \1/g' | sort -r | sed -r -e 's/^(\S*)\s(\S*)\s(\S*).*/(echo \"\1 * (-412.672) + 20748.16 \" | bc ; echo \" \2 * 277.655 - 1907.038  \" | bc ; echo \3 - 1 | bc )/ge' -e  's/\n/ /' -e  's/\n/ /'  -e 's/^(\S*)\s(\S*)\s(\S*).*/<g v-if="locations\[\3\]"><image xlink:href="sharepic\/resources\/marker50.png" x="\2" y="\1" height="50" width="32" \/><\/g>/' >>1200x1200.svg
echo "  </g>
</svg>" >>1200x1200.svg
echo 1200x1200.svg generiert
rm regiotemp.txt
echo finish
