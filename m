Return-Path: <linux-pci+bounces-10941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2029693F23A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 12:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B21284749
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19EB14290E;
	Mon, 29 Jul 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h4QeQG9l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353291411D7;
	Mon, 29 Jul 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247698; cv=none; b=S1suh1jh49LwZxk6bNdHPDgI/2EpUmsfT7EEn6n+FUK4Xeon/AoXvRJMePrlKk+mbf6pBEApwHjKV1VQ0MxjQWGNepqyLYm/enoddlmnMmr7cvP63tlBj04ePfVTTtpPlzbW+d2f8NZetlwS/5qA1ScM4xOBfgzC7BbyngwCSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247698; c=relaxed/simple;
	bh=vedgY74m+6OciRl2ovOnzNkoNP4D75usfhnPKKJQ1zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZZ3s/xnawYSlwb119Lss6ycUH3nvC1aWfgHjI9eVagRpkCPQxWz2elnoB+STqZ4T5isjyvUahTWw8iXUOuCJzDZTqQh/cdVhxzfayazc+flBxw4jkhMfET75aATKmEjc1ryek4GSOUZ0SCtFJB+Zaje7aUYsoJXKCHxIfnNjTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h4QeQG9l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SMnwve021411;
	Mon, 29 Jul 2024 10:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M4BXX6n92h4v9WVTgwUfXCEHdKiSNz73F/d554qrYmk=; b=h4QeQG9l6lIr99c3
	D+GfauLi8tuvRy6JS0SyYa8L6Y1fZNzBBvG75DwpOmqZ2orgLsDBzHyVjPPaZxR2
	0UM0amX96kBanGYlbo0Z1BVrSHPbAuvWlDlE279q+ae4TVfFd7jpKBh48fchAFVi
	d6eIZt0hHsHc/QNz3/C3hl7YJbLSOgypXXObQb8CIwhdBuUzpHJrcY3tEDps2JYC
	JOwBEZgmVorPzyhMeFUn2PLV7G35wDZt7JIXNpBwlVfUEo1N3ExgKBP0ML1saEJ+
	hd7/Cl7Yi2a/19dDPKpymaRFNLy8RiCXnU6pY2cC+CH1ahWYADqwwyGOlxCdfpcC
	M2IRjA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mp8mv0mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:08:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TA88hs024316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:08:08 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 03:08:02 -0700
Message-ID: <c6b4821e-f2e0-4009-9179-2820f13841d3@quicinc.com>
Date: Mon, 29 Jul 2024 18:08:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: qcom-ep: Add HDMA support for QCS9100 SoC
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
        Bjorn Helgaas
	<helgaas@kernel.org>
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
 <6ddf2c14-c8f6-4440-a8ac-93bdbdd6d08c@quicinc.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <6ddf2c14-c8f6-4440-a8ac-93bdbdd6d08c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dCeRgDJR7MVC4dhpIdTasRf9_QIaTg_R
X-Proofpoint-ORIG-GUID: dCeRgDJR7MVC4dhpIdTasRf9_QIaTg_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290068



On 7/10/2024 6:40 PM, Aiqun Yu (Maria) wrote:
> 
> 
> On 7/10/2024 12:26 AM, Bjorn Helgaas wrote:
>> On Tue, Jul 09, 2024 at 10:53:44PM +0800, Tengfei Fan wrote:
>>> QCS9100 SoC supports the new Hyper DMA (HDMA) DMA Engine inside the DWC IP,
>>> so add support for it by passing the mapping format and the number of
>>> read/write channels count.
>>>
>>> The PCIe EP controller used on this SoC is of version 1.34.0, so a separate
>>> config struct is introduced for the sake of enabling HDMA conditionally.
>>
>> This patch doesn't add a new config struct.
>>
>>> It should be noted that for the eDMA support (predecessor of HDMA), there
>>> are no mapping format and channels count specified. That is because eDMA
>>> supports auto detection of both parameters, whereas HDMA doesn't.
>>>
>>> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
>>> platform use non-SCMI resource. In the future, the SA8775p platform will
>>> move to use SCMI resources and it will have new sa8775p-related device
>>> tree. Consequently, introduce "qcom,qcs9100-pcie-ep" to the PCIe device
>>> match table.
>>
>> This series doesn't add the new SCMI stuff you mention.  It sounds
>> like this should be deferred and added when you actually move to using
>> SCMI resources.
> 
> We can rename "sa8775p" to "qcs9100" compatible name in next patchset
> for this driver. Let's know if this is reasonable from your point of view?
> 
> SCMI resource solution will come in a later point, and at that time it
> can have scmi related resource operations in this driver and add
> "sa8775p" compatible with correct resources ops at that time.
> 
> More background:
> We want to make QCS9100 non-SCMI resources not blocking by current SCMI
> resources changes, since SCMI changes are also pending to merge in order
> to not blocking non-scmi resource platforms like current QCS9100
> project. So the splitting base device trees are pending here. Don't want
> to have a circular dependency loop. :)

After considering the feedback provided on the subject, We have decided
to keep current SA8775p compatible and ABI compatibility in drivers.
Let's close this session and ignore all the current patches here.
Thank you for your input.

>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>> index 236229f66c80..e2775f4ca7ee 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>> @@ -904,6 +904,7 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
>>>   };
>>>   
>>>   static const struct of_device_id qcom_pcie_ep_match[] = {
>>> +	{ .compatible = "qcom,qcs9100-pcie-ep", .data = &cfg_1_34_0},
>>>   	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
>>>   	{ .compatible = "qcom,sdx55-pcie-ep", },
>>>   	{ .compatible = "qcom,sm8450-pcie-ep", },
>>>
>>> -- 
>>> 2.25.1
>>>
> 

-- 
Thx and BRs,
Tengfei Fan

