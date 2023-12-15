Return-Path: <linux-pci+bounces-1043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22AA814193
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 06:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788F01F23145
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 05:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE18CA66;
	Fri, 15 Dec 2023 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bTWau8W4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA28DDAD;
	Fri, 15 Dec 2023 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF4piv2020912;
	Fri, 15 Dec 2023 05:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Rme/5OhVSjCBq2kmTCYlSIW8T0zVGGECmOSIYy5c8Ys=; b=bT
	Wau8W4ngt+G9V5ROW9aIdbb3R3WPqMMVe2zZHRzd0/PpmwP676FCZGFqhdDX+MBp
	p7ejv66eGLuwvJrL8smkUQfiZ96rHeblIGgGV66HkS8sGt2aLV1I3VFC6KZs1jmF
	n7C4vqTpYd5FAFqG4Fzg2TpXcW/C1dN5xa3KR1T8zo56wgbKnT2fn67Rfepu5u15
	oQ5HrpzpiKHcKUHUsujGyX5dqLEpUtJy5uqeHQ+Ld4PLfOXFnbEv2JdM7Z+4cVpc
	3u0YX4Io3iv3hN+wK6bF2hUlkWYqwlOJdQAMlpQuAq4qvxGfaqNogNSMNBMX5I2W
	gRK7Wq30YdPfamemZF0Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynjace5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:52:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF5qflH006608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:52:41 GMT
Received: from [10.201.3.91] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 21:52:34 -0800
Message-ID: <356c7a26-00eb-4189-b463-8946ac5e8201@quicinc.com>
Date: Fri, 15 Dec 2023 11:22:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] dt-bindings: PCI: qcom: Add IPQ5332 SoC
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <quic_nsekar@quicinc.com>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
 <20231214062847.2215542-8-quic_ipkumar@quicinc.com>
 <CAA8EJppyd5-TQmvzRB3rBhRQtMLdu=6u5aQd5rWHitRuaJXzpA@mail.gmail.com>
From: Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <CAA8EJppyd5-TQmvzRB3rBhRQtMLdu=6u5aQd5rWHitRuaJXzpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y_9pkFcntguGdLcF8mnAq_eQCS_KVja0
X-Proofpoint-ORIG-GUID: y_9pkFcntguGdLcF8mnAq_eQCS_KVja0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150034



On 12/14/2023 12:45 PM, Dmitry Baryshkov wrote:
> On Thu, 14 Dec 2023 at 08:30, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>> Add support for the PCIe controller on the Qualcomm
>> IPQ5332 SoC to the bindings.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 36 +++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index eadba38171e1..af5e67d2a984 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -21,6 +21,7 @@ properties:
>>             - qcom,pcie-apq8064
>>             - qcom,pcie-apq8084
>>             - qcom,pcie-ipq4019
>> +          - qcom,pcie-ipq5332
>>             - qcom,pcie-ipq6018
>>             - qcom,pcie-ipq8064
>>             - qcom,pcie-ipq8064-v2
>> @@ -170,6 +171,7 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> +              - qcom,pcie-ipq5332
>>                 - qcom,pcie-ipq6018
>>                 - qcom,pcie-ipq8074-gen3
>>       then:
>> @@ -332,6 +334,39 @@ allOf:
>>               - const: ahb # AHB reset
>>               - const: phy_ahb # PHY AHB reset
>>
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,pcie-ipq5332
> As you seem to be depending on the ipq9574, could you please reuse the
> DT entry too?
Sure, will reuse ipq9574 entry.
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 6
>> +          maxItems: 6
>> +        clock-names:
>> +          items:
>> +            - const: ahb # AHB clock
>> +            - const: aux # Auxiliary clock
>> +            - const: axi_m # AXI Master clock
>> +            - const: axi_s # AXI Slave clock
>> +            - const: axi_bridge # AXI bridge clock
>> +            - const: rchng
>> +        resets:
>> +          minItems: 8
>> +          maxItems: 8
>> +        reset-names:
>> +          items:
>> +            - const: pipe # PIPE reset
>> +            - const: sticky # Core sticky reset
>> +            - const: axi_m_sticky # AXI master sticky reset
>> +            - const: axi_m # AXI master reset
>> +            - const: axi_s_sticky # AXI slave sticky reset
>> +            - const: axi_s # AXI slave reset
>> +            - const: ahb # AHB reset
>> +            - const: aux # AUX reset
>> +
>>     - if:
>>         properties:
>>           compatible:
>> @@ -790,6 +825,7 @@ allOf:
>>                 enum:
>>                   - qcom,pcie-apq8064
>>                   - qcom,pcie-ipq4019
>> +                - qcom,pcie-ipq5332
>>                   - qcom,pcie-ipq8064
>>                   - qcom,pcie-ipq8064v2
>>                   - qcom,pcie-ipq8074
>> --
>> 2.34.1
>>
>>
>
--
Thanks,
Praveenkumar

