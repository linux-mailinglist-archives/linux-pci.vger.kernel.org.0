Return-Path: <linux-pci+bounces-16919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC879CF3BA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F441F23585
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9218FC89;
	Fri, 15 Nov 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Am+75XCZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D714A088;
	Fri, 15 Nov 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694555; cv=none; b=Jxl6b57Gsu0rADywMSIVCB9dwT3lQ8llT8ZL6swgzg6BbIyN/uHHb/52UFX6Y27f+HeL+FqAtJ6zkCnYPCmqwBxKymYXexjelhgyLWV0luc8P2K2sbxT4uZetQTtBAFzQJPLaB1FIaOXz5xMPyGuJwQlZDtOFCCMP4JODJzmh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694555; c=relaxed/simple;
	bh=PEzhzsiyg9cRaNGBafo7sY/8/nU93itEWzsmVDPl9GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c7Phhpdm1B8IwyMSgnA/KS3gb1xySgJErgfAhsWY8+MeqG1C6802dZzPb7nywIij8J/3HK1WoJUVRBHQSbkRlNvamA3+e0tnv5OUs7SuZxfM+bnHlP++I/FOHILspxyQ40PeczOob1NtiH9IDvMY39xTgqS665SadBl1SZDxi8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Am+75XCZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBgmZI002826;
	Fri, 15 Nov 2024 18:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M2WyXe2SBxlxUIacTDe+njhEHQuZqWKlJtZCw5cMLrA=; b=Am+75XCZzMbYghJq
	BqG+GFSbkXQm1lDMOIKNMTCsaox/aTREnEeC3x+qqZpS07btKO9CwBXZszPoNZ0x
	sVO5Zk2ieVz9eSnuv3qO2nreh12JWs57d+1Bv5PXGHHNogDrP7/0heOPtCS8VsSw
	WD45kURU3NYPsTAErOs/Yl9jSJrESy3yRKgqZ0vfN7s1NhdR1O7q4NbG3LrgiyRS
	9HN3CuidsxRsFBD2uS+4/6GRJIxwWHDxFpq6LaD9C1uvdLXYzBYJT5B7NOR60BWR
	VKnDf6mexQUrMPGoebqy9CdygrIqLhkxn6X0OZGXIifQG+agAbZ0bqweSUHsmxmY
	XdFo2w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ww6dtgqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:15:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFIFg6x027723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:15:42 GMT
Received: from [10.110.68.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 10:15:40 -0800
Message-ID: <362bbb66-3d8b-4b20-9e02-1cbe234510c6@quicinc.com>
Date: Fri, 15 Nov 2024 10:15:39 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] PCI: dwc: Export dwc MSI controller related APIs
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <jingoohan1@gmail.com>, <will@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzk@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_krichai@quicinc.com>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-2-quic_mrana@quicinc.com>
 <20241115091419.tc4p2jwukjdo56of@thinkpad>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20241115091419.tc4p2jwukjdo56of@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MD9u7n5VoT62-OZrVRUDqXzF1fpVhvgr
X-Proofpoint-GUID: MD9u7n5VoT62-OZrVRUDqXzF1fpVhvgr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150153



On 11/15/2024 1:14 AM, Manivannan Sadhasivam wrote:
> On Wed, Nov 06, 2024 at 02:13:38PM -0800, Mayank Rana wrote:
>> To allow dwc PCIe controller based MSI functionality from ECAM pcie
>> driver, export dw_pcie_msi_host_init(), dw_pcie_msi_init() and
>> dw_pcie_msi_free() APIs. Also move MSI IRQ related initialization code
>> into dw_pcie_msi_init() as this code executes before dw_pcie_msi_init()
>> API to use with ECAM driver.
>>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>   .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++---------
>>   drivers/pci/controller/dwc/pcie-designware.h  | 14 +++++++
>>   2 files changed, 34 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 3e41865c7290..25020a090db8 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -250,7 +250,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>>   	return 0;
>>   }
>>   
>> -static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>> +void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>>   {
>>   	u32 ctrl;
>>   
>> @@ -263,19 +263,34 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>>   	irq_domain_remove(pp->msi_domain);
>>   	irq_domain_remove(pp->irq_domain);
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
>>   
>> -static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
>> +void dw_pcie_msi_init(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	u64 msi_target = (u64)pp->msi_data;
>> +	u32 ctrl, num_ctrls;
>>   
>>   	if (!pci_msi_enabled() || !pp->has_msi_ctrl)
>>   		return;
>>   
>> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>> +
>> +	/* Initialize IRQ Status array */
>> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
>> +		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
>> +				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>> +				    pp->irq_mask[ctrl]);
>> +		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
>> +				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>> +				    ~0);
>> +	}
>> +
>>   	/* Program the msi_data */
>>   	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
>>   	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
>>   
>>   static int dw_pcie_parse_split_msi_irq(struct dw_pcie_rp *pp)
>>   {
>> @@ -317,7 +332,7 @@ static int dw_pcie_parse_split_msi_irq(struct dw_pcie_rp *pp)
>>   	return 0;
>>   }
>>   
>> -static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>> +int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct device *dev = pci->dev;
>> @@ -391,6 +406,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>   
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_msi_host_init);
>>   
>>   static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>>   {
>> @@ -802,7 +818,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>>   int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> -	u32 val, ctrl, num_ctrls;
>> +	u32 val;
>>   	int ret;
>>   
>>   	/*
>> @@ -813,20 +829,6 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>>   
>>   	dw_pcie_setup(pci);
>>   
>> -	if (pp->has_msi_ctrl) {
>> -		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>> -
>> -		/* Initialize IRQ Status array */
>> -		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
>> -			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
>> -					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>> -					    pp->irq_mask[ctrl]);
>> -			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
>> -					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>> -					    ~0);
>> -		}
>> -	}
>> -
>>   	dw_pcie_msi_init(pp);
>>   
>>   	/* Setup RC BARs */
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 347ab74ac35a..ef748d82c663 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -679,6 +679,9 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>>   
>>   #ifdef CONFIG_PCIE_DW_HOST
>>   irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
>> +void dw_pcie_msi_init(struct dw_pcie_rp *pp);
>> +int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
>> +void dw_pcie_free_msi(struct dw_pcie_rp *pp);
>>   int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
>>   int dw_pcie_host_init(struct dw_pcie_rp *pp);
>>   void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
>> @@ -691,6 +694,17 @@ static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
>>   	return IRQ_NONE;
>>   }
>>   
>> +static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
> 
> Missing 'inline' here and below?
ACK
> 
> - Mani
> 
>> +{ }
>> +
>> +static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>> +{ }
>> +
>>   static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>>   {
>>   	return 0;
>> -- 
>> 2.25.1
>>
> 

