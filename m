Return-Path: <linux-pci+bounces-17239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF79D6C6F
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 02:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA4B2144C
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 01:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86F715E8B;
	Sun, 24 Nov 2024 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WQ5MJta/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC63C39;
	Sun, 24 Nov 2024 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732412527; cv=none; b=rNMvdPf5Ek5U9tGpJRiN+wMzHd8+fg3yZmQf19sh5kLei0oRFukIfIh7O3BhSDHNMUl7MKSmwBuGKXAJ/DoEm0BZLmAWYYdgLjR72sJCIkbiNONda9SWD6qOJIsEy7jmDg3DdHtLwBWnKZhiXlpcawhtnpeYnmjFRc6EKcWd4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732412527; c=relaxed/simple;
	bh=mf9hl1nOts/rBjwL3POmmzWKXTv11+3yyOuSfHrWImc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ta5at80WFRu2DrElZASUXVyolnoapFgabWx2co/WPqpVPhIWXwk2iHVtlfogYcab+COVP4kh+XphXFUPd4ErHdD+YuK7JJ1LxIX77MsEZN+tyVsGLP/vmRTkjW4D4gF5UkHuq5//DNjg/VoqD/YJGz8npOFrsabiG4U71eNT1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WQ5MJta/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ANNgZIF018598;
	Sun, 24 Nov 2024 01:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OISCvQkf8hrKZaSID4y7EnxkKyp+98/H1nIaA6Aptcg=; b=WQ5MJta/9v/dSNWd
	9mLPq0pkMJY5URJHzG+IH8xk0npIIrIMFP6SkrNoLwvmNth6fMvDHcvSCSPPlfZz
	U3Z9WYMYAbXPq2FxAZBne5BwHq6msEwmgwa1GFSSy5CJV9oy0KYuFHt3Q41cFscg
	yvEzPSbJrIYRIeZ1AunOfmySPFvHK39cnjPySsrHQELEYs1VkiA2GYkjFZHJei/F
	4s5k3Ym1Dn1Kq7EhI56HS4RFxOhr342ax4x2CEn9HAgn7CqhLxX4PCEPPtc/nQRu
	8V/P3WkMBMCkSDB7VRVEM19sMJMNwe+U651xP2C2Y/mz+kC6NcfOkaZ1KWlT+ztp
	GcXu0Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4334rd1qhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 01:41:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AO1ftI6025794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 01:41:55 GMT
Received: from [10.216.29.212] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 23 Nov
 2024 17:41:49 -0800
Message-ID: <42425b92-6e0d-a77b-8733-e50614bcb3a8@quicinc.com>
Date: Sun, 24 Nov 2024 07:11:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <poruhxgxnkhvqij5q7z4toxzcsk2gvkyj6ewicsfxj6xl3i3un@msgyeeyb6hsf>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <poruhxgxnkhvqij5q7z4toxzcsk2gvkyj6ewicsfxj6xl3i3un@msgyeeyb6hsf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E5SJ_1vJdxGLco9s_xvmQn41OXAexLgj
X-Proofpoint-GUID: E5SJ_1vJdxGLco9s_xvmQn41OXAexLgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411240013



On 11/20/2024 1:34 PM, Krzysztof Kozlowski wrote:
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
> 
> Isn't "qcom,qps615" a SoC name? This is supposed to be matching
> compatible, in your case probably qcom,qps615-whatever-this-is?
>
qcom,qcs615 is a soc name, qcom,qps615 is the pcie switch.

ack I will change it to qcom,qps615-pcie

> ...
> 
>> +  qps615,axi-clk-freq-hz:
> 
> That's a downstream code you send us.
> 
> Anyway, why assigned clock rates do not work for you? You are
> re-implementing legacy property now under different name :/
> 
> The assigned clock rates comes in to the picture when we are using clock
framework to control the clocks. For this switch there are no clocks 
needs to be control, the moment we power on the switch clocks are
enabled by default. This switch provides a mechanism to control the
frequency using i2c. And switch supports only two frequencies i.e
125MHz and 250MHZ by default it runs on 250MHz, we can do one i2c
write with which switch runs in 125MHz.
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
>> +    description: child nodes describing the internal downstream ports
>> +      the qps615 switch.
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
>> +
>> +      qcom,tx-amplitude-millivolt:
> 
> -microvolt does not work for you?
> 
let me check this if it is applicable we will change it to microvolt.
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
> Use some of these properties in the example. I saw only one.
> 
In the next patch I will try to use all the properties as suggested.
>> +
>> +    allOf:
>> +      - $ref: /schemas/pci/pci-bus.yaml#
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
> 
> Drop blank line
> 
ack.

- Krishna Chaitanya.
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    pcie {
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +
>> +        pcie@0 {
>> +            device_type = "pci";
>> +            reg = <0x0 0x0 0x0 0x0 0x0>;
> 
> Best regards,
> Krzysztof
> 

