Return-Path: <linux-pci+bounces-17238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1939D6C68
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 02:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322D7B21405
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 01:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC165684;
	Sun, 24 Nov 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hhWBRh1/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA92F26;
	Sun, 24 Nov 2024 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732411991; cv=none; b=G5F+eXrScBDtU6SJ6mSBl+bOY9h9CEp91Foxt9SAyn3A/aUj5W7AS9FJ+i4CyRlQ2/TsooWVdqHl90/cscTYzxJPBRFPUItM53xcAcpE44Kmue7yGCHI/aE2uTv7uvSvGeL0AuYIblPgPvqdkIUquQw0z2N7cvDn1Jc7YRPah1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732411991; c=relaxed/simple;
	bh=2zQK/Q+/7cCbNAPctNHIdqVIsa1TS5j/jUc3aee/g8I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=G5rwViCYQtGkBIVI2i4dIXM6mZLj3vizGCm+6aK9HD8Xt9gN+G8yVkf47tUre/bfQAQWuH0KlMEPbWv/IHEXhB6J2Xdro/YC7dwPpkXaeQMflAEGhe4pQiSKmcBrId2yyn6jz0lc5AK5xEtnJyj+pQtUqCAYOiTBieeRL+X7870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hhWBRh1/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AO1Qb11026353;
	Sun, 24 Nov 2024 01:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FU/U6id/Ki5t3ZxV3e3qtC+ramqdPcgRJ5/5KPNd6kg=; b=hhWBRh1/qtkpXuLR
	enegWNfiK8lI7owZrmFrsVduKhBi2p0VHPecD/cG488tn2sZEnotNMTJOcDGR4Yd
	fZajOwRbhB5iDITqG6u5nVZbVHvu1IeouQtQAAATYgVUWuEN2NTNePOfGMCfHoVh
	o86Nv8nqFbtTXRpo1/cStAqKiuhZRBufGCetrsBm2pEXebF4+Q9c5Jdia4ma+42g
	VjFxd59RiQE9qy+2vfMxffcE+97/pKJOs+L/JiwOckV5YAtl95YEtHpp5oIYiAy8
	xKp6DK1z/Tp+vRbds2q19tSfLr77MlApBXK5TbWOaOsCZvWbWWGSMuTz9Sdi97CS
	fWhYYg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4334dmsrf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 01:32:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AO1Wv32029039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 01:32:57 GMT
Received: from [10.216.29.212] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 23 Nov
 2024 17:32:51 -0800
Message-ID: <74eaef67-18f2-c2a1-1b9c-ac97cefecc54@quicinc.com>
Date: Sun, 24 Nov 2024 07:02:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
To: Rob Herring <robh@kernel.org>
CC: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <20241115161848.GA2961450-robh@kernel.org>
Content-Language: en-US
In-Reply-To: <20241115161848.GA2961450-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d37GbwAzDkKpdo557FeC5HaXBX8cpn2n
X-Proofpoint-ORIG-GUID: d37GbwAzDkKpdo557FeC5HaXBX8cpn2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411240011



On 11/15/2024 9:48 PM, Rob Herring wrote:
> On Tue, Nov 12, 2024 at 08:31:33PM +0530, Krishna chaitanya chundru wrote:
>> Add binding describing the Qualcomm PCIe switch, QPS615,
>> which provides Ethernet MAC integrated to the 3rd downstream port
>> and two downstream PCIe ports.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,qps615.yaml       | 205 +++++++++++++++++++++
>>   1 file changed, 205 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>> new file mode 100644
>> index 000000000000..e6a63a0bb0f3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>> @@ -0,0 +1,205 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QPS615 PCIe switch
>> +
>> +maintainers:
>> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm QPS615 PCIe switch has one upstream and three downstream
>> +  ports. The 3rd downstream port has integrated endpoint device of
>> +  Ethernet MAC. Other two downstream ports are supposed to connect
>> +  to external device.
>> +
>> +  The QPS615 PCIe switch can be configured through I2C interface before
>> +  PCIe link is established to change FTS, ASPM related entry delays,
>> +  tx amplitude etc for better power efficiency and functionality.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - pci1179,0623
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  i2c-parent:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
> 
> Don't need '|' if no formatting to preserve.
> 
ack
>> +      A phandle to the parent I2C node and the slave address of the device
>> +      used to do configure qps615 to change FTS, tx amplitude etc.
>> +    items:
>> +      - description: Phandle to the I2C controller node
>> +      - description: I2C slave address
>> +
>> +  vdd18-supply: true
>> +
>> +  vdd09-supply: true
>> +
>> +  vddc-supply: true
>> +
>> +  vddio1-supply: true
>> +
>> +  vddio2-supply: true
>> +
>> +  vddio18-supply: true
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO controlling the RESX# pin.
> 
> Is the PERST# or something else?
> 
it is not PERST GPIO, it is similar to PERST in terms
of functionality which brings switch out from reset.
>> +
>> +  qps615,axi-clk-freq-hz:
> 
> qps615 is not a vendor prefix.
> 
>> +    description:
>> +      AXI clock rate which is internal bus of the switch
>> +      The switch only runs in two frequencies i.e 250MHz and 125MHz.
>> +    enum: [125000000, 250000000]
>> +
>> +allOf:
>> +  - $ref: "#/$defs/qps615-node"
>> +
>> +patternProperties:
>> +  "@1?[0-9a-f](,[0-7])?$":
> 
> You have 3 ports. So isn't this fixed and limited to 0-2?
> 
sure I will change it to below as suggested
"@1?[0-3](,[0-1])?$"
>> +    description: child nodes describing the internal downstream ports
>> +      the qps615 switch.
> 
> Please be consistent with starting after the ':' or on the next line.
> 
> And start with capital C.
> 
>
ack

>> +    type: object
>> +    $ref: "#/$defs/qps615-node"
>> +    unevaluatedProperties: false
>> +
>> +$defs:
>> +  qps615-node:
>> +    type: object
>> +
>> +    properties:
>> +      qcom,l0s-entry-delay-ns:
>> +        description: Aspm l0s entry delay.
>> +
>> +      qcom,l1-entry-delay-ns:
>> +        description: Aspm l1 entry delay.
> 
> These should probably be common being standard PCIe things. Though, why
> are they needed? I'm sure the timing is defined by the PCIe spec, so
> they are not compliant?
> 
Usually the firmware in the endpoints/switches should do this these
configurations. But the qps615 PCIe switch doesn't have any firmware
running to configure these. So the hardware exposes i2c interface to
configure these before link training.
>> +
>> +      qcom,tx-amplitude-millivolt:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: Change Tx Margin setting for low power consumption.
>> +
>> +      qcom,no-dfe-support:
>> +        type: boolean
>> +        description: Disable DFE (Decision Feedback Equalizer), which mitigates
>> +          intersymbol interference and some reflections caused by impedance mismatches.
>> +
>> +      qcom,nfts:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          Number of Fast Training Sequence (FTS) used during L0s to L0 exit
>> +          for bit and Symbol lock.
> 
> Also something common.
> 
> The problem I have with all these properties is you are using them on
> both the upstream and downstream sides of the PCIe links. They belong in
> either the device's node (downstream) or the bus's node (upstream).
> 
This switch allows us to configure both upstream, downstream ports and
also embedded Ethernet port which is internal to the switch. These
properties are applicable for all of those.
>> +
>> +    allOf:
>> +      - $ref: /schemas/pci/pci-bus.yaml#
> 
> pci-pci-bridge.yaml is more specific and closer to what this device is.
> 
I tried this now, I was getting warning saying the compatible
/local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb: 
pcie@0,0: compatible: ['pci1179,0623'] does not contain items matching 
the given schema
         from schema $id: 
http://devicetree.org/schemas/pci/qcom,qps615.yaml#
/local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb: 
pcie@0,0: Unevaluated properties are not allowed ('#address-cells', 
'#size-cells', 'bus-range', 'device_type', 'ranges' were unexpected)

I think pci-pci-bridge is expecting the compatible string in this format
only "pciclass,0604".

>> +
>> +unevaluatedProperties: false
>> +
>> +required:
>> +  - vdd18-supply
>> +  - vdd09-supply
>> +  - vddc-supply
>> +  - vddio1-supply
>> +  - vddio2-supply
>> +  - vddio18-supply
>> +  - i2c-parent
>> +  - reset-gpios
>> +
>> +examples:
>> +  - |
>> +
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    pcie {
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +
>> +        pcie@0 {
>> +            device_type = "pci";
>> +            reg = <0x0 0x0 0x0 0x0 0x0>;
>> +
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            ranges;
>> +            bus-range = <0x01 0xff>;
>> +
>> +            pcie@0,0 {
>> +                compatible = "pci1179,0623";
>> +                reg = <0x10000 0x0 0x0 0x0 0x0>;
>> +                device_type = "pci";
>> +                #address-cells = <3>;
>> +                #size-cells = <2>;
>> +                ranges;
>> +                bus-range = <0x02 0xff>;
>> +
>> +                i2c-parent = <&qup_i2c 0x77>;
>> +
>> +                vdd18-supply = <&vdd>;
>> +                vdd09-supply = <&vdd>;
>> +                vddc-supply = <&vdd>;
>> +                vddio1-supply = <&vdd>;
>> +                vddio2-supply = <&vdd>;
>> +                vddio18-supply = <&vdd>;
>> +
>> +                reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
>> +
>> +                pcie@1,0 {
>> +                    reg = <0x20800 0x0 0x0 0x0 0x0>;
>> +                    #address-cells = <3>;
>> +                    #size-cells = <2>;
>> +                    device_type = "pci";
>> +                    ranges;
>> +                    bus-range = <0x03 0xff>;
>> +
>> +                    qcom,no-dfe-support;
>> +                };
>> +
>> +                pcie@2,0 {
>> +                    reg = <0x21000 0x0 0x0 0x0 0x0>;
>> +                    #address-cells = <3>;
>> +                    #size-cells = <2>;
>> +                    device_type = "pci";
>> +                    ranges;
>> +                    bus-range = <0x04 0xff>;
>> +
>> +                    qcom,nfts = <10>;
>> +                };
>> +
>> +                pcie@3,0 {
>> +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
>> +                    #address-cells = <3>;
>> +                    #size-cells = <2>;
>> +                    device_type = "pci";
>> +                    ranges;
>> +                    bus-range = <0x05 0xff>;
>> +
>> +                    qcom,tx-amplitude-millivolt = <10>;
>> +                    pcie@0,0 {
>> +                        reg = <0x50000 0x0 0x0 0x0 0x0>;
>> +                        #address-cells = <3>;
>> +                        #size-cells = <2>;
>> +                        device_type = "pci";
> 
> There's a 2nd PCI-PCI bridge?
This the embedded ethernet port which is as part of DSP3.

- Krishna Chaitanya.
> 
>> +                        ranges;
>> +
>> +                        qcom,l1-entry-delay-ns = <10>;
>> +                    };
>> +
>> +                    pcie@0,1 {
>> +                        reg = <0x50100 0x0 0x0 0x0 0x0>;
>> +                        #address-cells = <3>;
>> +                        #size-cells = <2>;
>> +                        device_type = "pci";
>> +                        ranges;
>> +
>> +                        qcom,l0s-entry-delay-ns = <10>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>>
>> -- 
>> 2.34.1
>>

