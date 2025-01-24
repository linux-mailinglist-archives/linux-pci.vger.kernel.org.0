Return-Path: <linux-pci+bounces-20318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C629CA1B18E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 09:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138AB167E94
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9A0218AD2;
	Fri, 24 Jan 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b7Y3lrfz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094A14A0A3;
	Fri, 24 Jan 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737706899; cv=none; b=bgHWI8VU8DX2dzAKVG249pgMira00DUed4xE9BJq0LC68H+ZKGxQmjLm1oNWiljs0OL5Y0Bmk9//jGnxJepYlD0JjMps5y0iU/HqEN8WtxnB4ts0gt9rLeSalAHi+3ajGW8nv1j79sfzJiCOVmKu2xG99fY8gSATLLR8Ed2LIz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737706899; c=relaxed/simple;
	bh=+HCkRR5n7TY/u1JLWkXaFoEAq7bYssPlCmhJ4948i3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JGZjT9hEdgfrhL7GnYsd9o7MKiIBrmSiS5quFQcaPLD61CbYdWH4Xs4+fhQ1U2hrapTRULeQk2/lQJgV9u8GxPIoRY3Fr1OJSyC7Dt1PRZ/9erTxtK0H3sGimdvq6XZSkDP2JHhy07FD5WFimNeEDMPeIFSi/ktHBzmGE4I/XZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b7Y3lrfz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O5T8vD026341;
	Fri, 24 Jan 2025 08:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bzRIcF9wPnpBpr70GVdDLjlJjS5ccbvsI7madkBgUFc=; b=b7Y3lrfzmk9YJG5D
	wOSbyxVMl0uMhu7ecSPxCpyDk7NL5WbTXV3WngBZocce+RqTKoDaXIG70IKXD092
	gksuhFGhRvXgAaYHvATPqyxwD9ORx/3J9HP6JCvdNG5DhbAeNeYl7QfMz3nMSNpp
	d2HMmAjsQrJhsnbE/E8ihvYMJjuaIFTdZocMgVHkRst2mTGMIGkRRmR1iOLEMLK1
	BrIldaZZjR5IEpI/U7vun+ZHbPkw7Az19GhPHxF+oiAA5xF2Zm9OzKIxh0CQ94cz
	PhBqXdWSYeG+cROAdxCdYpWEY1iraz2c/QvsWZBfQ3mu6/u4G28y9Buw3T0D4Gfq
	Nx1WoA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c4rngcu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 08:21:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O8LRoH006595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 08:21:27 GMT
Received: from [10.216.14.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 Jan
 2025 00:21:20 -0800
Message-ID: <919569c3-269b-6331-cc85-b1da086c773c@quicinc.com>
Date: Fri, 24 Jan 2025 13:51:13 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 4/4] PCI: qcom: Enable ECAM feature
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>
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
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_vpernami@quicinc.com>,
        <quic_mrana@quicinc.com>, <mmareddy@quicinc.com>
References: <20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com>
 <20250121-enable_ecam-v3-4-cd84d3b2a7ba@oss.qualcomm.com>
 <20250124065843.te5p55qgjyina53z@thinkpad>
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20250124065843.te5p55qgjyina53z@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E1luK8GNpwEu-rcw6RSY7j5QQQeMGkPT
X-Proofpoint-ORIG-GUID: E1luK8GNpwEu-rcw6RSY7j5QQQeMGkPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240059



On 1/24/2025 12:28 PM, Manivannan Sadhasivam wrote:
> On Tue, Jan 21, 2025 at 02:32:22PM +0530, Krishna Chaitanya Chundru wrote:
>> The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
>> gives us the offset from which ELBI starts. so use this offset and cfg
>> win to map these regions instead of doing the ioremap again.
>>
>> On root bus, we have only the root port. Any access other than that
>> should not go out of the link and should return all F's. Since the iATU
>> is configured for the buses which starts after root bus, block the
>> transactions starting from function 1 of the root bus to the end of
>> the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
>> outside the link through ECAM blocker through PARF registers.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++++++--
>>   1 file changed, 77 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index dc102d8bd58c..cf94718d3059 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -52,6 +52,7 @@
>>   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>>   #define PARF_Q2A_FLUSH				0x1ac
>>   #define PARF_LTSSM				0x1b0
>> +#define PARF_SLV_DBI_ELBI			0x1b4
>>   #define PARF_INT_ALL_STATUS			0x224
>>   #define PARF_INT_ALL_CLEAR			0x228
>>   #define PARF_INT_ALL_MASK			0x22c
>> @@ -61,6 +62,17 @@
>>   #define PARF_DBI_BASE_ADDR_V2_HI		0x354
>>   #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
>>   #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
>> +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
>> +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
>> +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
>> +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
>> +#define PARF_ECAM_BASE				0x380
>> +#define PARF_ECAM_BASE_HI			0x384
>> +
>>   #define PARF_NO_SNOOP_OVERIDE			0x3d4
>>   #define PARF_ATU_BASE_ADDR			0x634
>>   #define PARF_ATU_BASE_ADDR_HI			0x638
>> @@ -84,6 +96,7 @@
>>   
>>   /* PARF_SYS_CTRL register fields */
>>   #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
>> +#define PCIE_ECAM_BLOCKER_EN			BIT(26)
>>   #define MST_WAKEUP_EN				BIT(13)
>>   #define SLV_WAKEUP_EN				BIT(12)
>>   #define MSTR_ACLK_CGC_DIS			BIT(10)
>> @@ -294,15 +307,60 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>>   	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>>   }
>>   
>> +static int qcom_pci_config_ecam(struct dw_pcie_rp *pp)
>> +{
> 
> void qcom_pci_config_ecam()?
> 
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +	u64 addr, addr_end;
>> +	u32 val;
>> +
>> +	/* Set the ECAM base */
>> +	writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
> 
> You can use _relaxed variants in this function.
> 
>> +	writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
>> +
>> +	/*
>> +	 * The only device on root bus is the Root Port. Any access other than that
>> +	 * should not go out of the link and should return all F's. Since the iATU
>> +	 * is configured for the buses which starts after root bus, block the transactions
>> +	 * starting from function 1 of the root bus to the end of the root bus (i.e from
>> +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
> 
> Why can't you impose this limitation with the iATU mapping itself? I mean, why
> can't the mapping be limited to 4K to cover only device 00.0? I believe the min
> iATU window size is 4K on all platforms.
> 
There is no iATU mapping for pcie0 the first 4k i,e 00.0.0 is local 
memory( i.e dbi memory). we configure iATU when we want to specific the 
transctions to go with this type, message etc. The entire 1 MB for bus 0
in not configured through iATU. Any read/write to the PCIe memory region
will goto outside the PCIe link, if there is iATU mapped for that memory
the the transction goes out with iATU injected type or message etc.

we can't use iATU for this case where we do want the transctions going 
out side the link.
>> +	 */
>> +	addr = pci->dbi_phys_addr + SZ_4K;
>> +	writel(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
>> +	writel(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
>> +
>> +	writel(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
>> +	writel(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
>> +
>> +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
>> +
>> +	writel(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
>> +	writel(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
>> +
>> +	writel(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
>> +	writel(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
>> +
>> +	val = readl(pcie->parf + PARF_SYS_CTRL);
>> +	val |= PCIE_ECAM_BLOCKER_EN;
>> +	writel(val, pcie->parf + PARF_SYS_CTRL);
> 
> nit; newline
> 
>> +	return 0;
>> +}
>> +
>>   static int qcom_pcie_start_link(struct dw_pcie *pci)
>>   {
>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +	int ret;
>>   
>>   	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
>>   		qcom_pcie_common_set_16gt_equalization(pci);
>>   		qcom_pcie_common_set_16gt_lane_margining(pci);
>>   	}
>>   
>> +	if (pci->pp.ecam_mode) {
>> +		ret = qcom_pci_config_ecam(&pci->pp);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   	/* Enable Link Training state machine */
>>   	if (pcie->cfg->ops->ltssm_enable)
>>   		pcie->cfg->ops->ltssm_enable(pcie);
>> @@ -1233,6 +1291,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +	u16 offset;
>>   	int ret;
>>   
>>   	qcom_ep_reset_assert(pcie);
>> @@ -1241,6 +1300,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   	if (ret)
>>   		return ret;
>>   
>> +	if (pp->ecam_mode) {
>> +		offset = readl(pcie->parf + PARF_SLV_DBI_ELBI);
>> +		pcie->elbi = pci->dbi_base + offset;
> 
> Can't you derive this offset for non-ECAM mode also?
> 
we can derive it for ecam mode we are not doing any devm_ioremap as it 
will part of dbi space only. For non ecam mode we need to do ioremap to
the dbi physical address + offset to elbi size. As the elbi size can
vary it is best to use this way only.
>> +	}
>> +
>>   	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
>>   	if (ret)
>>   		goto err_deinit;
>> @@ -1613,6 +1677,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   	pci->ops = &dw_pcie_ops;
>>   	pp = &pci->pp;
>>   
>> +	pp->bridge = devm_pci_alloc_host_bridge(dev, 0);
>> +	if (!pp->bridge) {
>> +		ret = -ENOMEM;
>> +		goto err_pm_runtime_put;
>> +	}
>> +
>> +	pci->pp.ecam_mode = dw_pcie_ecam_supported(pp);
> 
> you should be able to set this in designware-host.c
> 
we need this to skip elbi ioremap or not in below before we can
dw_pcie_host_init().
>>   	pcie->pci = pci;
>>   
>>   	pcie->cfg = pcie_cfg;
>> @@ -1629,10 +1700,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   		goto err_pm_runtime_put;
>>   	}
>>   
>> -	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
>> -	if (IS_ERR(pcie->elbi)) {
>> -		ret = PTR_ERR(pcie->elbi);
>> -		goto err_pm_runtime_put;
>> +	if (!pp->ecam_mode) {
>> +		pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
>> +		if (IS_ERR(pcie->elbi)) {
>> +			ret = PTR_ERR(pcie->elbi);
>> +			goto err_pm_runtime_put;
> 
> You can drop this if the ELBI offset can be derived from PARF register on all
> platforms.
> 
As mentioned above, we can derive the offset but in non drv mode we need
to have ioremap. Better stay this way.

- Krishna Chaitanya.
> - Mani
> 

