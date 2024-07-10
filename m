Return-Path: <linux-pci+bounces-10046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A192CB3C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 08:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4521F240F8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AEF77F1B;
	Wed, 10 Jul 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jmUCGW0E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C3657CBC;
	Wed, 10 Jul 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593460; cv=none; b=X15Ekj+MNodXr4mxF3bCAmU+uIQcfVI4JVYhJk27OMu83Vw8rX7Br1xLCdlya/sNZYQLzDmdnYc82SqcXda8s/ZIYM/byrIcQApazrMUyswb7FmeksssqXnvcCPFDoAMXTUyEg8FnUFP8Fv+6FsS+5mJuhCq5+A8dOP7t9bHYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593460; c=relaxed/simple;
	bh=87AHnkJ8UfsgESziEwaLMdfncxJiLVWYj5UjZeZYoug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PcycaeVa4AWdN/VnSdgrShiq0ETQ3sOdbFE3SrsaTuwiX7n505iQa38oMyGpLONKbDWzwqxR/kTg+Hqy5mIkUeUOCN+vqiegi+UNlM6bIzjq9Y4p7GUHiykZCcB6CwGdTLZyMK1AqxL7x7zkIVqyhGF/MrHzAFBOoNDoe3EfQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jmUCGW0E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469MCRpx012919;
	Wed, 10 Jul 2024 06:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	12CEwnz1VdvoSOCH4gcRkSmXRgXBbr4JlTL5IqebeCI=; b=jmUCGW0Eb/CUsiJO
	bk8MTaSzy2o+6fwCEgAgHs83NFc8Yf5bTmV1amGiGwoLhG7taH7iaO8nF3OykaGB
	qEIccHkzeZEq5MMSG0IfvmD5FNmrvqPWKiSA/IMimxncHbZU3LpO2BIc64xVSvn/
	gZR7k2nw2ds/QHHfkH32DA0SugKkpaLWsEoHMkFeWaAW6a9Ny/l+DgXrBIuTGEWX
	WH/v16ADsf0M+G54En3SfXY2xX0ZQLkTsHjnm9PHDD6mN09uk84yhpkV38BrLMOP
	c6tLVIXqtlPxiM2BCWQO+kOcS+frdV6rLVimj/iTK/Bnm1KB+nHat/dUwRA9G64s
	xpG3vA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x518kyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:37:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A6bShw015355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:37:28 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 23:37:21 -0700
Message-ID: <e429e0d5-ed88-44c7-aa76-62abd593a3d1@quicinc.com>
Date: Wed, 10 Jul 2024 14:37:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: Document compatible for QCS9100
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240709162912.GA176161@bhelgaas>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <20240709162912.GA176161@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6lON1HvE_L5ft_bw0PurpKBVRJU4wYIZ
X-Proofpoint-ORIG-GUID: 6lON1HvE_L5ft_bw0PurpKBVRJU4wYIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100049



On 7/10/2024 12:29 AM, Bjorn Helgaas wrote:
> On Tue, Jul 09, 2024 at 10:59:29PM +0800, Tengfei Fan wrote:
>> Document compatible for QCS9100 platform.
> 
> Add blank line for paragraph breaks.

A blank line will be added in the next verion patch series.

> 
>> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
>> platform use non-SCMI resource. In the future, the SA8775p platform will
>> move to use SCMI resources and it will have new sa8775p-related device
>> tree. Consequently, introduce "qcom,pcie-qcs9100" to describe non-SCMI
>> based PCIe.
> 
> Not connected to the patch below.  Move to where it is relevant.

As mentioned in the cover letter, we will also push the QCS9100 device 
tree patch series to upstream after all the binding and driver patches 
are reviewd. The QCS9100 device tree is directly renamed from the 
SA8775p device tree.

This comment message serves to explain why we need to push this PCIe 
binding patch, thus avoiding any questions from reviews about why we are 
not continuing to use the "qcom,pcie-sa8775p" compatible name.

If you still think that this comment message is not necessay here, I 
will move this comment message from binding and driver patches to the 
cover letter.

> 
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>> index efde49d1bef8..4de33df6963f 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>> @@ -16,7 +16,10 @@ description:
>>   
>>   properties:
>>     compatible:
>> -    const: qcom,pcie-sa8775p
>> +    items:
>> +      - enum:
>> +          - qcom,pcie-qcs9100
>> +          - qcom,pcie-sa8775p
>>   
>>     reg:
>>       minItems: 6
>>
>> -- 
>> 2.25.1
>>

-- 
Thx and BRs,
Tengfei Fan

