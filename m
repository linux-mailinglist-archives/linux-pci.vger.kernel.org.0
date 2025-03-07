Return-Path: <linux-pci+bounces-23082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8646A55CE6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 02:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2723A97A3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 01:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F72741C71;
	Fri,  7 Mar 2025 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hdHVhchq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C231547C0
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310108; cv=none; b=bG6eIjTnvsN7j8bvpKBAdwU8SeeeGpzEofb/y3eDfq5nSg89QQbfNQWGvAIm42ARBo1I+ts0lPYPvweX8pAsUrD2qDQJvEkf97pY1ncivVAg8FoOJD1EIRdpN92hE8l1TPusvctxG9GLqpScT/59bCPF6EPXwYzOG/GRjDOea40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310108; c=relaxed/simple;
	bh=vvJ7Ic1cdp10j+QYggPUF8udL5L6/nFXaIODmUEuCK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ux0i8w7/j0j+WopFtAALndAby9pL9OfBxhBQSl1yak9IzGGAr13VBcnfNP6kbMJvfWBQXV81g73FERewTmsxKGH+BpNXn9MoHJ8moChi9J1KgyQXWV41IGYLIZ2ZP4yxPZqPUuXMjX00E1aGZUlxggGL71zwzG+eD2kjwBLawYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hdHVhchq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526KZFc0013362
	for <linux-pci@vger.kernel.org>; Fri, 7 Mar 2025 01:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iI2N8CwrDtDkSWx9F00jEAdnM8BhWOIKc87gFJ9bfeo=; b=hdHVhchqrgQR0YxD
	ynTJJvw1JNayc5WVTjacvlmxl3AbKInDYMOHlrqXmcoFiOmXBV7EYy/2xSVdt9ad
	Gs5NbgTjJYw2ashycyzv90IyllpzsUaOzPHJYu7j9WbnQnMWBTY5oDijchKuP+7n
	pu2bhu/4vwe+6KIycjW3Xo6eIeK/mZK+k9jsPKAHitNpOTIFCvETyIEbFHrJduXT
	OYhR0ItdA0BXtJxC6/4oiQyFEs8Sy7JQvXijx/lJvsCm3OxIvVJKNCE5D16rEmhX
	rGIWl9IVZTv2tuogkEKPR0nDf4nGrBbGh5uo7Yt5uXR/hNf46T394P8mbksA+FVk
	8b5dUw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 457jvdrk0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 07 Mar 2025 01:15:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22367f4e9b9so23278245ad.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Mar 2025 17:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741310104; x=1741914904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI2N8CwrDtDkSWx9F00jEAdnM8BhWOIKc87gFJ9bfeo=;
        b=oBb9jHRmHJBlyxBWU99Z4mz+toG4lf4zoXgJSD5yvy9s0smFf/ut0N5atn/QsfAJ1u
         IfHLS7iJWn7p64A3oEw14sITOF+M9QNlgssaM9W19OcdDU2/3K2de/YaLWrXxjhZyIfI
         TLcGnxnGt+HAr4w/klCsQ7eIaDnYnx8CC1v2E86Kk/yXg1IMLYHH+d+ozmDTaWFr66E8
         /kBPbHaQS+7tmuHfM0beS+SYxnXUzXOVoWoMMwp6MyU7r3E7lMXmEa1CGBR9hEaftimx
         /ezlr5l4w9hjjmYdxhDx2F9G8wqQ5ri3TMSd3auyyhCDNNGAUntcrqRuKGXH1JF1K028
         xX1g==
X-Forwarded-Encrypted: i=1; AJvYcCXN0KwhWD+kfpOE/H6BRwJMDEi5HS1VHG8LyEjYKtFB3DhZ/+wXZE6RpF99RgAa5Nd8RLguIODoygY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bv5kUeryWbL2KTrvbFUdhTRTDKBfPUb5SNd86jyUV4CPXF2G
	5OWVz53nA0lHs9RP3ee8WOQ5Swo/5keSoVhkXn0+I+3uM3CdIlAdmcJ2q1Q6RHvniI1UG73rOr9
	/wfzDR3hoCJ613rfXR6aBzNzi0Xfh+6DXtQ6aubS45ObeCrD0fsnJAP/dEBc=
X-Gm-Gg: ASbGncv9Ns6Dk31jdDqOE0LbDUd0MSuUvIuBD5bltjuhtQORWztgwb+8jHM8hbjKqd/
	kT+5ANVkYISJXfhFUYoquPaHtkDr8uIvTWI4qDEtOClyU+m5iz9+mviYR3YIwdaI2QTdSZuzFxe
	LR2mqfboldOiHEZtJjsWTCOXB+cPogfB9srxH7CD6J7F0Bc49NwOxs1xgF7exiGKXBs+Y7y4AkK
	k9A3CAgGS0Y/yqbqnQp+TWkvh/nfwZbP3wIx/tGpeqmiRDU8ntz2q5H25YnHkJ9OYwd6OoccevV
	Yj+QJaHEJW7dUVD+zEmj835Y6U2XHvjp72zJsxF7G6+vnA==
X-Received: by 2002:a17:903:19c4:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22428bf6d24mr24269405ad.48.1741310103697;
        Thu, 06 Mar 2025 17:15:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB9an4W1W2oxG+l8wDfnqtca4twJs2o6LXBR9IbBTKftNlqe6OnXmtOiEMbN1shcv/sX4Edg==
X-Received: by 2002:a17:903:19c4:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22428bf6d24mr24268945ad.48.1741310103202;
        Thu, 06 Mar 2025 17:15:03 -0800 (PST)
Received: from [192.168.29.92] ([49.43.228.40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28126e09dsm1882719a12.53.2025.03.06.17.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 17:15:02 -0800 (PST)
Message-ID: <263aa955-943d-5bdf-8eb9-74e90d289fb5@oss.qualcomm.com>
Date: Fri, 7 Mar 2025 06:44:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/4] PCI: qcom: Enable ECAM feature
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
 <20250207-ecam_v4-v4-4-94b5d5ec5017@oss.qualcomm.com>
 <20250210092240.5b67fsdervb2tvxp@thinkpad>
 <5fc8c993-4993-d930-2687-96fdf95dc1cf@oss.qualcomm.com>
 <20250210094709.lih7lhnwjhmvrk7r@thinkpad>
 <149f513f-a68f-8966-4c3a-ed8c7aafb1ab@quicinc.com>
 <20250305182639.ov6yiqplyaymdbpa@thinkpad>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250305182639.ov6yiqplyaymdbpa@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W8XCVQWk c=1 sm=1 tr=0 ts=67ca4899 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=gzHQz5DndFXDghOZWxpFUA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=mg4TMdeMBWTuOWjfejAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: t_5OpSJC_IRPY0wGtr-FAcEGSSGOPCgZ
X-Proofpoint-ORIG-GUID: t_5OpSJC_IRPY0wGtr-FAcEGSSGOPCgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070006



On 3/5/2025 11:56 PM, Manivannan Sadhasivam wrote:
> On Mon, Feb 10, 2025 at 03:23:43PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 2/10/2025 3:17 PM, Manivannan Sadhasivam wrote:
>>> On Mon, Feb 10, 2025 at 03:04:43PM +0530, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 2/10/2025 2:52 PM, Manivannan Sadhasivam wrote:
>>>>> On Fri, Feb 07, 2025 at 04:58:59AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
>>>>>> gives us the offset from which ELBI starts. so use this offset and cfg
>>>>>> win to map these regions instead of doing the ioremap again.
>>>>>>
>>>>>> On root bus, we have only the root port. Any access other than that
>>>>>> should not go out of the link and should return all F's. Since the iATU
>>>>>> is configured for the buses which starts after root bus, block the
>>>>>> transactions starting from function 1 of the root bus to the end of
>>>>>> the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
>>>>>> outside the link through ECAM blocker through PARF registers.
>>>>>>
>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>>>> ---
>>>>>>     drivers/pci/controller/dwc/pcie-qcom.c | 77 ++++++++++++++++++++++++++++++++--
>>>>>>     1 file changed, 73 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>>>> index e4d3366ead1f..84297b308e7e 100644
>>>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>>>> @@ -52,6 +52,7 @@
>>>>>>     #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>>>>>>     #define PARF_Q2A_FLUSH				0x1ac
>>>>>>     #define PARF_LTSSM				0x1b0
>>>>>> +#define PARF_SLV_DBI_ELBI			0x1b4
>>>>>>     #define PARF_INT_ALL_STATUS			0x224
>>>>>>     #define PARF_INT_ALL_CLEAR			0x228
>>>>>>     #define PARF_INT_ALL_MASK			0x22c
>>>>>> @@ -61,6 +62,17 @@
>>>>>>     #define PARF_DBI_BASE_ADDR_V2_HI		0x354
>>>>>>     #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
>>>>>>     #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
>>>>>> +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
>>>>>> +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
>>>>>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
>>>>>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
>>>>>> +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
>>>>>> +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
>>>>>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
>>>>>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
>>>>>> +#define PARF_ECAM_BASE				0x380
>>>>>> +#define PARF_ECAM_BASE_HI			0x384
>>>>>> +
>>>>>>     #define PARF_NO_SNOOP_OVERIDE			0x3d4
>>>>>>     #define PARF_ATU_BASE_ADDR			0x634
>>>>>>     #define PARF_ATU_BASE_ADDR_HI			0x638
>>>>>> @@ -84,6 +96,7 @@
>>>>>>     /* PARF_SYS_CTRL register fields */
>>>>>>     #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
>>>>>> +#define PCIE_ECAM_BLOCKER_EN			BIT(26)
>>>>>>     #define MST_WAKEUP_EN				BIT(13)
>>>>>>     #define SLV_WAKEUP_EN				BIT(12)
>>>>>>     #define MSTR_ACLK_CGC_DIS			BIT(10)
>>>>>> @@ -294,6 +307,44 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>>>>>>     	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>>>>>>     }
>>>>>> +static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
>>>>>> +{
>>>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>>>>> +	u64 addr, addr_end;
>>>>>> +	u32 val;
>>>>>> +
>>>>>> +	/* Set the ECAM base */
>>>>>> +	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
>>>>>> +	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * The only device on root bus is the Root Port. Any access other than that
>>>>>> +	 * should not go out of the link and should return all F's. Since the iATU
>>>>>> +	 * is configured for the buses which starts after root bus, block the transactions
>>>>>> +	 * starting from function 1 of the root bus to the end of the root bus (i.e from
>>>>>> +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
>>>>>> +	 */
>>>>>> +	addr = pci->dbi_phys_addr + SZ_4K;
>>>>>> +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
>>>>>> +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
>>>>>> +
>>>>>> +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
>>>>>> +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
>>>>>> +
>>>>>> +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
>>>>>> +
>>>>>> +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
>>>>>> +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
>>>>>> +
>>>>>> +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
>>>>>> +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
>>>>>> +
>>>>>> +	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
>>>>>> +	val |= PCIE_ECAM_BLOCKER_EN;
>>>>>> +	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
>>>>>> +}
>>>>>> +
>>>>>>     static int qcom_pcie_start_link(struct dw_pcie *pci)
>>>>>>     {
>>>>>>     	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>>>>> @@ -303,6 +354,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>>>>>>     		qcom_pcie_common_set_16gt_lane_margining(pci);
>>>>>>     	}
>>>>>> +	if (pci->pp.ecam_mode)
>>>>>> +		qcom_pci_config_ecam(&pci->pp);
>>>>>> +
>>>>>>     	/* Enable Link Training state machine */
>>>>>>     	if (pcie->cfg->ops->ltssm_enable)
>>>>>>     		pcie->cfg->ops->ltssm_enable(pcie);
>>>>>> @@ -1233,6 +1287,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>>>>>     {
>>>>>>     	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>>>     	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>>>>> +	u16 offset;
>>>>>>     	int ret;
>>>>>>     	qcom_ep_reset_assert(pcie);
>>>>>> @@ -1241,6 +1296,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>>>>>     	if (ret)
>>>>>>     		return ret;
>>>>>> +	if (pp->ecam_mode) {
>>>>>> +		offset = readl(pcie->parf + PARF_SLV_DBI_ELBI);
>>>>>> +		pcie->elbi = pci->dbi_base + offset;
>>>>>> +	}
>>>>>
>>>>> If you use the existing 'elbi' register offset defined in DT, you can just rely
>>>>> on the DWC core to call dw_pcie_ecam_supported() as I mentioned in my comment in
>>>>> patch 3.
>>>>>    >> +
>>>>>>     	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
>>>>>>     	if (ret)
>>>>>>     		goto err_deinit;
>>>>>> @@ -1615,6 +1675,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>>>>>     	pci->ops = &dw_pcie_ops;
>>>>>>     	pp = &pci->pp;
>>>>>> +	pp->bridge = devm_pci_alloc_host_bridge(dev, 0);
>>>>>> +	if (!pp->bridge) {
>>>>>> +		ret = -ENOMEM;
>>>>>> +		goto err_pm_runtime_put;
>>>>>> +	}
>>>>>> +
>>>>>
>>>>> This will also go away.
>>>>>
>>>> Hi Mani,
>>>>
>>>> I get your point but the problem is in ECAM mode the DBI address to maximum
>>>> of 256 MB will be ioremap by pci_ecam_create(). If we don't skip
>>>> this ioremap of elbi ioremap in pci_ecam_create because we already
>>>> iormaped elbi which falls in dbi address to 256 MB region( as we can't
>>>> remap same region twice). so we need to skip doing ioremap for elbi
>>>> region.
>>>>
>>>
>>> Then obviously, your DT entries are wrong. You cannot define overlapping regions
>>> on purpose. Can't you leave the ELBI region and start the config region?
>>>
>>> - Mani
>> ELBI is part of DBI space(present in the first 4kb of the dbi) we can't
>> relocate ELBI region to different location.
>> can we keep this elbi region as optional and remove elbi from the
>> devicetree and binding?
>>
> 
> Since ELBI is a DWC generic region, you should move the resource get call to
> dw_pcie_get_resources(). Also, it is an optional region, so you should open code
> devm_platform_ioremap_resource_byname() to skip devm_ioremap_resource() if
> platform_get_resource_byname() returns NULL. DT binding should make sure that
> the DTS has the region specified if required.
>
Hi Mani,
even though elbi is a dwc region the registers in the elbi are specific
to the vendors. The ELBI register contents in the qcom might not match
with the other vendors. So we can skip this adding this in 
dw_pcie_get_resources()

we will try to make it optional only in qcom driver, and remove from the
dt as suggested.

- Krishna Chaitanya.

> And this should allow you to move the dw_pcie_ecam_supported() call inside DWC
> core.
> 

> - Mani
> 

