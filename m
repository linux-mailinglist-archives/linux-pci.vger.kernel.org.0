Return-Path: <linux-pci+bounces-10051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9425292CBA7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 09:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDC8B21597
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF67F487;
	Wed, 10 Jul 2024 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HZ3rLnYs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9047E799;
	Wed, 10 Jul 2024 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595397; cv=none; b=t9Awlm1FperR2uhmk/6wUyAilHR1KZp03pMLMSTqmMQk+uBBYNUXpu/G42i+8F3ONnxgcjUhZ/BK/joZZU9awjOEjLaLbyz+kTDakPGvRK+euvUI/7COdvXqpM9ZSOhmtK89t5bI1gSBr1/e04R6mhtRFDVqRAGF4BZZlUKizno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595397; c=relaxed/simple;
	bh=Rm2ycqUWWSxIwfulIViKtoC9gfOIgWmOYofu0pKwzMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VyxGNhYxK0yYwKNH2mhZ5ZnkBzlO7CkUsgNdHHeW4VKDbdTvpE1275yfF3kNRK0F0UJxeLoWk99XtIc0BU0ei3Ftw2L3Ku4uqACvY3FRaTOfKsOcRRm7wI9tBDUdA5ijAu2aCQ8PbkkS75MNkFAWz1ZnluEBwklqoDe7xEAflII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HZ3rLnYs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A1nhAO017547;
	Wed, 10 Jul 2024 07:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ujGT8DB3n2+Z6Ln7pA3KHvJvEOKVnyVLmrk1V8AsAkg=; b=HZ3rLnYs5+/Fyc5i
	5rSzsly4g6Lgk/L3ZjwFOadrxtH3IcHg/qqE/AbeTps4VPA8+TsdvMtb+HDdzKRo
	Bn5hqxJkh0rSM0TJSCtrP1Zn07o12g9qOAMJ1j6NpPHhixnWWb4+eG3Ul8STriKh
	mcsRjzF7+IlEkV5tufC7TIzG6SUBnowZu6tTtTqUbM7MODtfL9mPo733EMhOZmOT
	+Nvvs9wCnzQxcI/ZAV4xDpiCwCseaVbK2lGQtnSJeQ08Cn2l7W9RVdoy89Bj+9xT
	Hw3nj6QXz/UHh8A9qFZf8n5E3ufaOgEMLceqteAEZgyPRU0UB574ay2hKauDCpN6
	TbBl5g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wg40ruu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 07:09:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A79gRQ004893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 07:09:42 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 00:09:36 -0700
Message-ID: <cab35cb7-f9a8-45ce-9714-84c0382fcfd0@quicinc.com>
Date: Wed, 10 Jul 2024 15:09:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom-ep: Add support for QCS9100
 SoC
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <kernel@quicinc.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240709162831.GA176079@bhelgaas>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <20240709162831.GA176079@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: odx495PcHuh2bgJk15YZtTzRiidUWaoI
X-Proofpoint-GUID: odx495PcHuh2bgJk15YZtTzRiidUWaoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_03,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100051



On 7/10/2024 12:28 AM, Bjorn Helgaas wrote:
> On Tue, Jul 09, 2024 at 10:53:43PM +0800, Tengfei Fan wrote:
>> Add devicetree bindings support for QCS9100 SoC. It has DMA register
>> space and dma interrupt to support HDMA.
> 
> s/dma/DMA/ above for consistency.
This update will be included in the next verion of the patch series.

> 
> Add blank line here if this is a paragraph break.

A blank line will be added in the next verion of the patch series.

> 
>> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
>> platform use non-SCMI resource. In the future, the SA8775p platform will
>> move to use SCMI resources and it will have new sa8775p-related device
>> tree. Consequently, introduce "qcom,qcs9100-pcie-ep" to describe non-SCMI
>> based PCIe.
> 
> s/drived/derived/

This update will be included in the next verion of the patch series

> 
> This patch doesn't add anything related to SCMI, so this paragraph
> seems like a distraction.

This patch is used to support QSC9100. QCS9100 uses non-SCMI resources, 
so there is nothing related to SCMI in this patch.

Only SA8775p will move to use SCMI resources in the future.

> 
> The first paragraph seems a bit of a distraction too, since the patch
> doesn't say anything about DMA register space or interrupt.
I will update this commit message as follows in the next version of the 
patch series.

"Add devicetree bindings support for QCS9100 PCIe EP compatible."


> 
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>> index 46802f7d9482..8012663e7efc 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>> @@ -13,6 +13,7 @@ properties:
>>     compatible:
>>       oneOf:
>>         - enum:
>> +          - qcom,qcs9100-pcie-ep
>>             - qcom,sa8775p-pcie-ep
>>             - qcom,sdx55-pcie-ep
>>             - qcom,sm8450-pcie-ep
>> @@ -203,6 +204,7 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> +              - qcom,qcs9100-pcie-ep
>>                 - qcom,sa8775p-pcie-ep
>>       then:
>>         properties:
>>
>> -- 
>> 2.25.1
>>

-- 
Thx and BRs,
Tengfei Fan

