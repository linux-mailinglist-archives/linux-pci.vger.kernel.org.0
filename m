Return-Path: <linux-pci+bounces-11261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C41947449
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 06:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB441C20BF8
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 04:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A1F55887;
	Mon,  5 Aug 2024 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fNJRapgF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E3033FE;
	Mon,  5 Aug 2024 04:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722831411; cv=none; b=LxAnUgCjBWyRq2MDdV3Ix+DbdiK5CGl9z/iIXM3gs8wzrOlDEUAkK12q9ylPwcQI/dcLK1v/l1OzDI0MxRvZXIHIOESy47ClNX3ooaYh7KCaeXw8o6K7rst6QziZkgB/2j1tAUnn7Z+fXYWDKLC584QH+MbpQGW8PZnEZvbcRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722831411; c=relaxed/simple;
	bh=JNPqz+u25aB5bmidpHtQ1/jSMgxl97ObY5Uv/1+OFAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FgKyuUPgS+ca+4hF3AIyCqo2sguM986HXUV/h94Mk59j2rC9yuP1vTVJ13khr1SGvlO5OMRpiYG5B2aIb4r4pIQUHmjBt97FVAgJKisAcVDVvDUU9YgyhysOlLTjlCp19xjm6ZFCDFyNLC65h5XE42oQxnK4X5D4eGDuuQnRJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fNJRapgF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752VVwQ023707;
	Mon, 5 Aug 2024 04:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	94MZmYCB/VLNFHTo6ZI0abJBbuzl9VP4BIewwybPPRQ=; b=fNJRapgFaruIFPXV
	zXdbnwCSXaSsxvd+6AsWKJq2pAnrRQ+ayfQH3QU2vHf5QhSexetes4qyx94wBlbL
	xXHE/5U/96hfvrb5viLr8NKHrUUFcFTUhZqECyzYouc2FxIVP/OdEiPogT4bqrJj
	Ghg/MG3sbUQvidJ8AGAO6tUiVHAlMURURJuP2QwPBjJW78Rg2sfjFcCAy/Va7Ntj
	VjRcC/VQBmvR5GDZZ6kF7bv7LT6yYBDfgpgev1n8Z2HK4BH55+HcMSH5/aaFW5AR
	6mB1TDT9CEF+dX4BgA0XENI+iiztxYxk/xlvYnbk0haBIJI7EGVjR/DZ5fXUwyeg
	loLMHw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sbgrtugq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 04:16:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4754GdRM021772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 04:16:40 GMT
Received: from [10.216.50.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 21:16:34 -0700
Message-ID: <9eb517ff-7b50-57b2-dd8a-382480bd2ffa@quicinc.com>
Date: Mon, 5 Aug 2024 09:46:30 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
 <pku3ayi76246jmixuqdylkuqpb3k5z3ykn4hj2rjvcrhqrj3hb@yig6as3cph6p>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <pku3ayi76246jmixuqdylkuqpb3k5z3ykn4hj2rjvcrhqrj3hb@yig6as3cph6p>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QYXfCVJKJbx65vxPOGd2FD849NGf6D_g
X-Proofpoint-GUID: QYXfCVJKJbx65vxPOGd2FD849NGf6D_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050028



On 8/3/2024 4:30 PM, Dmitry Baryshkov wrote:
> On Sat, Aug 03, 2024 at 08:52:47AM GMT, Krishna chaitanya chundru wrote:
>> Add binding describing the Qualcomm PCIe switch, QPS615,
>> which provides Ethernet MAC integrated to the 3rd downstream port
>> and two downstream PCIe ports.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 +++++++++++++++++++++
>>   1 file changed, 191 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>> new file mode 100644
>> index 000000000000..ea0c953ee56f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>> @@ -0,0 +1,191 @@
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
>> +  qcom,qps615-controller:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Reference to the I2C client used to do configure qps615
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
>> +
>> +  qps615,axi-clk-freq-hz:
>> +    description:
>> +      AXI clock which internal bus of the switch.
> 
> Is it a clock or clock rate?
It is clock ony.
> 
>> +
>> +  qcom,l0s-entry-delay-ns:
>> +    description: Aspm l0s entry delay in nanoseconds.
> 
> I'd say, from the property name it is obvious that it comes in
> nanoseconds.
> 
I will remove the description from these properties.
>> +
>> +  qcom,l1-entry-delay-ns:
>> +    description: Aspm l1 entry delay in nanoseconds.
>> +
>> +  qcom,tx-amplitude-millivolt:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Change Tx Margin setting for low power consumption.
>> +
>> +  qcom,no-dfe:
>> +    type: boolean
>> +    description: Disables DFE (Decision Feedback Equalizer).
>> +
>> +  qcom,nfts:
>> +    $ref: /schemas/types.yaml#/definitions/uint8
>> +    description:
>> +      Fast Training Sequence (FTS) is the mechanism that
>> +      is used for bit and Symbol lock.
> 
> Doesn't help to understand what it is and what the value means.
> 
I will update the description, this property represents number
of fast training sequence needs to be used for link transition
from L0s to L0.

- Krishna Chaitanya.
>>  >> +allOf:
>> +  - $ref: /schemas/pci/pci-bus-common.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: pci1179,0623
>> +      required:
>> +        - compatible
>> +    then:
>> +      required:
>> +        - vdd18-supply
>> +        - vdd09-supply
>> +        - vddc-supply
>> +        - vddio1-supply
>> +        - vddio2-supply
>> +        - vddio18-supply
>> +        - qcom,qps615-controller
>> +        - reset-gpios
>> +
>> +patternProperties:
>> +  "@1?[0-9a-f](,[0-7])?$":
>> +    type: object
>> +    $ref: qcom,qps615.yaml#
>> +    additionalProperties: true
>> +
>> +additionalProperties: true
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
>> +
>> +            pcie@0,0 {
>> +                compatible = "pci1179,0623";
>> +                reg = <0x10000 0x0 0x0 0x0 0x0>;
>> +                device_type = "pci";
>> +                #address-cells = <3>;
>> +                #size-cells = <2>;
>> +                ranges;
>> +
>> +                qcom,qps615-controller = <&qps615_controller>;
> 
> Where is the corresponding device?
> 
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
>> +
>> +                    qcom,no-dfe;
>> +                };
>> +
>> +                pcie@2,0 {
>> +                    reg = <0x21000 0x0 0x0 0x0 0x0>;
>> +                    #address-cells = <3>;
>> +                    #size-cells = <2>;
>> +                    device_type = "pci";
>> +                    ranges;
>> +
>> +                    qcom,nfts = /bits/ 8 <10>;
>> +                };
>> +
>> +                pcie@3,0 {
>> +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
>> +                    #address-cells = <3>;
>> +                    #size-cells = <2>;
>> +                    device_type = "pci";
>> +                    ranges;
>> +
>> +                    qcom,tx-amplitude-millivolt = <10>;
>> +
>> +                         pcie@0,0 {
> 
> Wrong indentation.
> 
>> +                              reg = <0x40000 0x0 0x0 0x0 0x0>;
>> +                              #address-cells = <3>;
>> +                              #size-cells = <2>;
>> +                              device_type = "pci";
>> +                              ranges;
>> +
>> +                              qcom,l1-entry-delay-ns = <10>;
>> +                         };
>> +
>> +                         pcie@0,1 {
>> +                              reg = <0x40100 0x0 0x0 0x0 0x0>;
>> +                              #address-cells = <3>;
>> +                              #size-cells = <2>;
>> +                              device_type = "pci";
>> +                              ranges;
>> +
>> +                              qcom,l0s-entry-delay-ns = <10>;
>> +                         };
>> +                };
>> +            };
>> +        };
>> +    };
>>
>> -- 
>> 2.34.1
>>
> 

