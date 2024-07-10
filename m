Return-Path: <linux-pci+bounces-10052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7723692CBD7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 09:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8F5B212BF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 07:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60A83CBA;
	Wed, 10 Jul 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GYqZHxQs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064B83A09;
	Wed, 10 Jul 2024 07:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595935; cv=none; b=GPZ9rUWHUC9g+u6TMW3d+Qy/lj8j0xn07haCS+LpTPlXtLK2RsHH8UbyZ+vHUpoSsQEqFHrr3oMnVKuWmM6bICGjeGrFxrDAUB7K/i3iYsKiATRa7khYajVPrvdmRknyoxeJvyo5yIm1KAMJnhRtXX0Ari4MPTb/Q8gUZfqISlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595935; c=relaxed/simple;
	bh=/U+lMHxjqHQW8J2TYbjkeT6OFd4TTGHcoGKVHsPmD5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rYXfjAsrnB9xeuoFNdPzpor9BWEnyaE4V4HjI08RlLaWhEAAzJT9dFls6Bj3gXnYeZ1KB+KNJAWYQnMTJ0Ke5pN6TuzSvj8GlNeiJL/pe+zTJA8SJAt0cMlBOu9Us/GkjW7QXibonfDz+2t//Al00M0XLLKJ2yy8BN7ymHOX+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GYqZHxQs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469Kxdqu000478;
	Wed, 10 Jul 2024 07:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hhjMHZvhOUEYvnVQe7XP5sYYHiKGScbresm5K6/Asx8=; b=GYqZHxQs0LXIIQtu
	yX6Ik5iRcSzYq+R8BChT4A5+ZNdkJcb415/TOwqOTYJFyGwttpJ9NmDZv1Jx2g2T
	Q2tzJAC4EO7bIc86svYC+V1eBKboleqrKNrzfaWrSgiO+/z9Crt0QhCu127h7rEd
	qHlFRN8QElSGpeq21UVagQq029aGT638zCCh5ZjWGobC/tGdqNOc+OxTbJtSMk83
	hhHOlhEqLoLNoM5Trodl6jFwL6thMvtjPvLg8B54sD1rmxW//d03mFUDao/LmiEZ
	05CYgUXhWBoJMcMrOTOeJmRQJfdn3o9Z0ivRcKZh4L+MIuFPqM985f4rli+o9vfV
	xe5glA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwrhtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 07:18:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A7IilF015641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 07:18:44 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 00:18:38 -0700
Message-ID: <417ff30e-87d9-4816-addc-943f96ec64ac@quicinc.com>
Date: Wed, 10 Jul 2024 15:18:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: qcom-ep: Add HDMA support for QCS9100 SoC
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
References: <20240709162621.GA175973@bhelgaas>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <20240709162621.GA175973@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FMFiu0mJ3ebQ_-I4SHSCVkL4oHTerKB_
X-Proofpoint-ORIG-GUID: FMFiu0mJ3ebQ_-I4SHSCVkL4oHTerKB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_03,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100051



On 7/10/2024 12:26 AM, Bjorn Helgaas wrote:
> On Tue, Jul 09, 2024 at 10:53:44PM +0800, Tengfei Fan wrote:
>> QCS9100 SoC supports the new Hyper DMA (HDMA) DMA Engine inside the DWC IP,
>> so add support for it by passing the mapping format and the number of
>> read/write channels count.
>>
>> The PCIe EP controller used on this SoC is of version 1.34.0, so a separate
>> config struct is introduced for the sake of enabling HDMA conditionally.
> 
> This patch doesn't add a new config struct.

Thank you for pointing out this. I will remove this commit message in 
the next version patch series.

> 
>> It should be noted that for the eDMA support (predecessor of HDMA), there
>> are no mapping format and channels count specified. That is because eDMA
>> supports auto detection of both parameters, whereas HDMA doesn't.
>>
>> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
>> platform use non-SCMI resource. In the future, the SA8775p platform will
>> move to use SCMI resources and it will have new sa8775p-related device
>> tree. Consequently, introduce "qcom,qcs9100-pcie-ep" to the PCIe device
>> match table.
> 
> This series doesn't add the new SCMI stuff you mention.  It sounds
> like this should be deferred and added when you actually move to using
> SCMI resources.

This patch shouldn't be deferred.

This patch is used to support QSC9100. QCS9100 uses non-SCMI resources, 
so there is nothing related to SCMI in this patch.

Only SA8775p will move to use SCMI resources in the future.


> 
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 236229f66c80..e2775f4ca7ee 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -904,6 +904,7 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
>>   };
>>   
>>   static const struct of_device_id qcom_pcie_ep_match[] = {
>> +	{ .compatible = "qcom,qcs9100-pcie-ep", .data = &cfg_1_34_0},
>>   	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
>>   	{ .compatible = "qcom,sdx55-pcie-ep", },
>>   	{ .compatible = "qcom,sm8450-pcie-ep", },
>>
>> -- 
>> 2.25.1
>>

-- 
Thx and BRs,
Tengfei Fan

