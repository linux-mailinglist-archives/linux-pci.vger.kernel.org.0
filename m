Return-Path: <linux-pci+bounces-21074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30976A2E851
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 10:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA117188BAD8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04211C5D74;
	Mon, 10 Feb 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FjpazmY9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529B2E628;
	Mon, 10 Feb 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181249; cv=none; b=IDkV83vlciVdwGxCXWftyn1J90YkIjtiVmkz4R+UsWkTZRKGIJ3p7UED6EFoV/syCHrZQFy8Ay0O6xuMkz+Zzym59f73z2SOOW5tZ16Ce5cKcprb6LAdNAtpDTDFLv9tMVMgnffI7OuwnugsAHAZQf/OjSmWm0OMlg0w5nalBb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181249; c=relaxed/simple;
	bh=LjyT66AvL9BxiXu9dZlHYu9SzP2c4pJPNOgKqYubhhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MM50GWupBf8rzeMJ3WH6u0CczR2gxgD4A32HpvNtwJs9n4d37Spw1bvQW2PNhyoSJyGnwgNFm43T3ZhnjT8AUnsvjpWPQYJ0xat5azxqSh0qtYYFbwKkkc4DqcZsHxFTGNh2BwnXQumF2Ez4VDY5BxzxXExBiv4Hn74QoHW1mVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FjpazmY9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A8h58M015700;
	Mon, 10 Feb 2025 09:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	87VQP1tycBCf2OB0NnZE52DB5VySlTqmNsTrcPzd0kw=; b=FjpazmY9Cj5tZqqe
	juALkWSf7uFOwVh4Mm0MlJtOrtb6Ljkqz5BavsYUfPMiBfrq4xo34glmmV46VAA+
	w0ZNEqeyfzvIlTUJi9HvKuCEOoP5wtfb+7Wn6otqdjzX7abqXoSMmSZSd287fKW2
	aS/VxnsMEfv0162Lk83yLUI/tshUXqU/PAI8VT8zVDUKbyPpCZ7itVdNvwfd5Kmq
	cKd8jaspnKo5kn1BVfEFmLAyquij5w3YvNt+1uv/1o3dFQPyvz77SAHqBO0eQYJ/
	DezdDOwvGyfyYSRP4Ev3YCGPSVIRPV/91TZq5hmwoi6mY+XNYXq1ipRvVY+gw0ha
	4GekSQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qe6nr6u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 09:53:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51A9rrQw013692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 09:53:53 GMT
Received: from [10.216.26.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Feb
 2025 01:53:46 -0800
Message-ID: <149f513f-a68f-8966-4c3a-ed8c7aafb1ab@quicinc.com>
Date: Mon, 10 Feb 2025 15:23:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/4] PCI: qcom: Enable ECAM feature
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Krishna
 Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
CC: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_mrana@quicinc.com>, <quic_vpernami@quicinc.com>,
        <mmareddy@quicinc.com>
References: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
 <20250207-ecam_v4-v4-4-94b5d5ec5017@oss.qualcomm.com>
 <20250210092240.5b67fsdervb2tvxp@thinkpad>
 <5fc8c993-4993-d930-2687-96fdf95dc1cf@oss.qualcomm.com>
 <20250210094709.lih7lhnwjhmvrk7r@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20250210094709.lih7lhnwjhmvrk7r@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tRkcXHcox5fEBot9VwwthztMO0CnE7H9
X-Proofpoint-ORIG-GUID: tRkcXHcox5fEBot9VwwthztMO0CnE7H9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_05,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100082



On 2/10/2025 3:17 PM, Manivannan Sadhasivam wrote:
> On Mon, Feb 10, 2025 at 03:04:43PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 2/10/2025 2:52 PM, Manivannan Sadhasivam wrote:
>>> On Fri, Feb 07, 2025 at 04:58:59AM +0530, Krishna Chaitanya Chundru wrote:
>>>> The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
>>>> gives us the offset from which ELBI starts. so use this offset and cfg
>>>> win to map these regions instead of doing the ioremap again.
>>>>
>>>> On root bus, we have only the root port. Any access other than that
>>>> should not go out of the link and should return all F's. Since the iATU
>>>> is configured for the buses which starts after root bus, block the
>>>> transactions starting from function 1 of the root bus to the end of
>>>> the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
>>>> outside the link through ECAM blocker through PARF registers.
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 77 ++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 73 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index e4d3366ead1f..84297b308e7e 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> @@ -52,6 +52,7 @@
>>>>    #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>>>>    #define PARF_Q2A_FLUSH				0x1ac
>>>>    #define PARF_LTSSM				0x1b0
>>>> +#define PARF_SLV_DBI_ELBI			0x1b4
>>>>    #define PARF_INT_ALL_STATUS			0x224
>>>>    #define PARF_INT_ALL_CLEAR			0x228
>>>>    #define PARF_INT_ALL_MASK			0x22c
>>>> @@ -61,6 +62,17 @@
>>>>    #define PARF_DBI_BASE_ADDR_V2_HI		0x354
>>>>    #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
>>>>    #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
>>>> +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
>>>> +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
>>>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
>>>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
>>>> +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
>>>> +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
>>>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
>>>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
>>>> +#define PARF_ECAM_BASE				0x380
>>>> +#define PARF_ECAM_BASE_HI			0x384
>>>> +
>>>>    #define PARF_NO_SNOOP_OVERIDE			0x3d4
>>>>    #define PARF_ATU_BASE_ADDR			0x634
>>>>    #define PARF_ATU_BASE_ADDR_HI			0x638
>>>> @@ -84,6 +96,7 @@
>>>>    /* PARF_SYS_CTRL register fields */
>>>>    #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
>>>> +#define PCIE_ECAM_BLOCKER_EN			BIT(26)
>>>>    #define MST_WAKEUP_EN				BIT(13)
>>>>    #define SLV_WAKEUP_EN				BIT(12)
>>>>    #define MSTR_ACLK_CGC_DIS			BIT(10)
>>>> @@ -294,6 +307,44 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>>>>    	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>>>>    }
>>>> +static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
>>>> +{
>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>>> +	u64 addr, addr_end;
>>>> +	u32 val;
>>>> +
>>>> +	/* Set the ECAM base */
>>>> +	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
>>>> +	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
>>>> +
>>>> +	/*
>>>> +	 * The only device on root bus is the Root Port. Any access other than that
>>>> +	 * should not go out of the link and should return all F's. Since the iATU
>>>> +	 * is configured for the buses which starts after root bus, block the transactions
>>>> +	 * starting from function 1 of the root bus to the end of the root bus (i.e from
>>>> +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
>>>> +	 */
>>>> +	addr = pci->dbi_phys_addr + SZ_4K;
>>>> +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
>>>> +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
>>>> +
>>>> +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
>>>> +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
>>>> +
>>>> +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
>>>> +
>>>> +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
>>>> +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
>>>> +
>>>> +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
>>>> +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
>>>> +
>>>> +	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
>>>> +	val |= PCIE_ECAM_BLOCKER_EN;
>>>> +	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
>>>> +}
>>>> +
>>>>    static int qcom_pcie_start_link(struct dw_pcie *pci)
>>>>    {
>>>>    	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>>> @@ -303,6 +354,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>>>>    		qcom_pcie_common_set_16gt_lane_margining(pci);
>>>>    	}
>>>> +	if (pci->pp.ecam_mode)
>>>> +		qcom_pci_config_ecam(&pci->pp);
>>>> +
>>>>    	/* Enable Link Training state machine */
>>>>    	if (pcie->cfg->ops->ltssm_enable)
>>>>    		pcie->cfg->ops->ltssm_enable(pcie);
>>>> @@ -1233,6 +1287,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>>>    {
>>>>    	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>    	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>>> +	u16 offset;
>>>>    	int ret;
>>>>    	qcom_ep_reset_assert(pcie);
>>>> @@ -1241,6 +1296,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>>>    	if (ret)
>>>>    		return ret;
>>>> +	if (pp->ecam_mode) {
>>>> +		offset = readl(pcie->parf + PARF_SLV_DBI_ELBI);
>>>> +		pcie->elbi = pci->dbi_base + offset;
>>>> +	}
>>>
>>> If you use the existing 'elbi' register offset defined in DT, you can just rely
>>> on the DWC core to call dw_pcie_ecam_supported() as I mentioned in my comment in
>>> patch 3.
>>>   >> +
>>>>    	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
>>>>    	if (ret)
>>>>    		goto err_deinit;
>>>> @@ -1615,6 +1675,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>>>    	pci->ops = &dw_pcie_ops;
>>>>    	pp = &pci->pp;
>>>> +	pp->bridge = devm_pci_alloc_host_bridge(dev, 0);
>>>> +	if (!pp->bridge) {
>>>> +		ret = -ENOMEM;
>>>> +		goto err_pm_runtime_put;
>>>> +	}
>>>> +
>>>
>>> This will also go away.
>>>
>> Hi Mani,
>>
>> I get your point but the problem is in ECAM mode the DBI address to maximum
>> of 256 MB will be ioremap by pci_ecam_create(). If we don't skip
>> this ioremap of elbi ioremap in pci_ecam_create because we already
>> iormaped elbi which falls in dbi address to 256 MB region( as we can't
>> remap same region twice). so we need to skip doing ioremap for elbi
>> region.
>>
> 
> Then obviously, your DT entries are wrong. You cannot define overlapping regions
> on purpose. Can't you leave the ELBI region and start the config region?
> 
> - Mani
ELBI is part of DBI space(present in the first 4kb of the dbi) we can't
relocate ELBI region to different location.
can we keep this elbi region as optional and remove elbi from the
devicetree and binding?

- Krishna Chaitanya.
> 

