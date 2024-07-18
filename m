Return-Path: <linux-pci+bounces-10534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5045A93704E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 23:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE60B213A4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133AA145B10;
	Thu, 18 Jul 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gV4cyZZC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD10145B00;
	Thu, 18 Jul 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339753; cv=none; b=IQycwDKEmjj7gGZbzHovVTkzk59TBj9dT1DY/bZ+WtFPOZiPSLPiceI/9IPmR8QONUg/8xakskXAUTy8Ugqy2g+Izuu+0N0X1qXo2YzORcostgCQ4Xror5h0fBZaCfwbup9/JBnmyZ64a0jf59lZ/dL4xI7KrHh6v14vDEBJPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339753; c=relaxed/simple;
	bh=aQn20DkKZX8DLc+OVqic662SFlNsLXgj0L6rqFW+IO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uKyDWpGdXhyybHnxeryxnFI5AlpUoIkdriZIwegqeIK0ZeZKWDN2ufU4lDVPCYdg8rY6W/PZJIDmZfHjEU2mWFLXRgko2fZpdYNi1ciyoY1i5gRmngMdrpHBwuchznh+hFJMAleKw0SZKWJBtQ4fYJExCfTsWJaW2bxA+GzRjYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gV4cyZZC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IBD0wj023117;
	Thu, 18 Jul 2024 21:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h0mCvED66flAoqckntQBt2/IbGwfigCgEEWsJja9jeg=; b=gV4cyZZCVK5ZE+pI
	S3W5U1iOrOb7cLrOkkgnTERXEYQ9WER3JUUY3TpcRLLl6EfH+TsBDK0WrIbfIZmq
	/FOwJ76nUrbnZ/OXqRBsTvp6cNPNz8mV94xtIv0cX7VgRs8FqUayVaYLvJsiVRHi
	ZlZLuZ+hIKhcOGYc0emEutJxrVTqosqv7fRzLx1x3oTwWQVeB8L+URBUaekaxzTU
	En6vWvaHT7QmDjdHrb8G91tdTmIowsaOSpnQaqeGet0egbkN8kEmwjoTOHrH6wLR
	OZcqtbVYEhKvjTZDCiQcNwdCxW3Y67Z8Kh5kZpuhBU6wev/I0oP5yobLfSEV82AO
	xciYIg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfnprdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 21:52:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46ILqLFZ027887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 21:52:21 GMT
Received: from [10.110.7.185] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Jul
 2024 14:52:21 -0700
Message-ID: <e04f8a63-3dc8-4a58-a9a4-4c70debd2b93@quicinc.com>
Date: Thu, 18 Jul 2024 14:52:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: qcom: Avoid DBI and ATU register space mirror
 to BAR/MMIO region
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240718051258.1115271-1-quic_pyarlaga@quicinc.com>
 <20240718051258.1115271-3-quic_pyarlaga@quicinc.com>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240718051258.1115271-3-quic_pyarlaga@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: emAt5mAXUMMkMGMADMyQ74DUJyIcGVZH
X-Proofpoint-ORIG-GUID: emAt5mAXUMMkMGMADMyQ74DUJyIcGVZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_15,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407180146

Hi Prudhvi

On 7/17/2024 10:12 PM, Prudhvi Yarlagadda wrote:
> PARF hardware block which is a wrapper on top of DWC PCIe controller
> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
> register to get the size of the memory block to be mirrored and uses
> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
> address of DBI and ATU space inside the memory block that is being
> mirrored.
> 
> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
> boundary is used for BAR region then there could be an overlap of DBI and
> ATU address space that is getting mirrored and the BAR region. This
> results in DBI and ATU address space contents getting updated when a PCIe
> function driver tries updating the BAR/MMIO memory region. Reference
> memory map of the PCIe memory region with DBI and ATU address space
> overlapping BAR region is as below.
> 
>                          |---------------|
>                          |               |
>                          |               |
>          ------- --------|---------------|
>             |       |    |---------------|
>             |       |    |       DBI     |
>             |       |    |---------------|---->DBI_BASE_ADDR
>             |       |    |               |
>             |       |    |               |
>             |    PCIe    |               |---->2*SLV_ADDR_SPACE_SIZE
>             |    BAR/MMIO|---------------|
>             |    Region  |       ATU     |
>             |       |    |---------------|---->ATU_BASE_ADDR
>             |       |    |               |
>          PCIe       |    |---------------|
>          Memory     |    |       DBI     |
>          Region     |    |---------------|---->DBI_BASE_ADDR
>             |       |    |               |
>             |    --------|               |
>             |            |               |---->SLV_ADDR_SPACE_SIZE
>             |            |---------------|
>             |            |       ATU     |
>             |            |---------------|---->ATU_BASE_ADDR
>             |            |               |
>             |            |---------------|
>             |            |       DBI     |
>             |            |---------------|---->DBI_BASE_ADDR
>             |            |               |
>             |            |               |
>          ----------------|---------------|
>                          |               |
>                          |               |
>                          |               |
>                          |---------------|
> 
> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
> used for BAR region which is why the above mentioned issue is not
> encountered. This issue is discovered as part of internal testing when we
> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
> we are trying to fix this.
> 
> As PARF hardware block mirrors DBI and ATU register space after every
> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
> U32_MAX (all 0xFF's) to PARF_SLV_ADDR_SPACE_SIZE register to avoid
> mirroring DBI and ATU to BAR/MMIO region. Write the physical base address
> of DBI and ATU register blocks to PARF_DBI_BASE_ADDR (default 0x0) and
> PARF_ATU_BASE_ADDR (default 0x1000) respectively to make sure DBI and ATU
> blocks are at expected memory locations.
> 
> The register offsets PARF_DBI_BASE_ADDR_V2, PARF_SLV_ADDR_SPACE_SIZE_V2
> and PARF_ATU_BASE_ADDR are applicable for platforms that use PARF
> Qcom IP rev 1.9.0, 2.7.0 and 2.9.0. PARF_DBI_BASE_ADDR_V2 and
> PARF_SLV_ADDR_SPACE_SIZE_V2 are applicable for PARF Qcom IP rev 2.3.3.
> PARF_DBI_BASE_ADDR and PARF_SLV_ADDR_SPACE_SIZE are applicable for PARF
> Qcom IP rev 1.0.0, 2.3.2 and 2.4.0. Updating the init()/post_init()
> functions of the respective PARF versions to program applicable
> PARF_DBI_BASE_ADDR, PARF_SLV_ADDR_SPACE_SIZE and PARF_ATU_BASE_ADDR
> register offsets. And remove the unused SLV_ADDR_SPACE_SZ macro.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 62 +++++++++++++++++++-------
>   1 file changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..845c7641431f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -45,6 +45,7 @@
>   #define PARF_PHY_REFCLK				0x4c
>   #define PARF_CONFIG_BITS			0x50
>   #define PARF_DBI_BASE_ADDR			0x168
> +#define PARF_SLV_ADDR_SPACE_SIZE		0x16C
>   #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>   #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
[...]> +static void qcom_pcie_configure_dbi_base(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	if (pci->dbi_phys_addr)
> +		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
> +							PARF_DBI_BASE_ADDR);
> +
> +	writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
We can't update PARF_SLV_ADDR_SPACE_SIZE without updating 
PARF_DBI_BASE_ADDR.
Please make dbi_phys_addr mandatory to update PARF_SLV_ADDR_SPACE_SIZE.
> +}
> +
> +static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	if (pci->dbi_phys_addr) {
> +		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
> +							PARF_DBI_BASE_ADDR_V2);
> +		writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf +
> +						PARF_DBI_BASE_ADDR_V2_HI);
> +	}
> +
> +	if (pci->atu_phys_addr) {
> +		writel(lower_32_bits(pci->atu_phys_addr), pcie->parf +
> +							PARF_ATU_BASE_ADDR);
> +		writel(upper_32_bits(pci->atu_phys_addr), pcie->parf +
> +							PARF_ATU_BASE_ADDR_HI);
> +	}
> +
> +	writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2);
> +	writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2_HI);
Same as above. atu_phys_addr shall be optional here but not 
dbi_phys_addr to update PARF_SLV_ADDR_SPACE_SIZE.
> +}
> +
>   static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
>   {
>   	u32 val;
> @@ -540,8 +576,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
>   
>   static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
>   {
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> +	qcom_pcie_configure_dbi_base(pcie);
>   
>   	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>   		u32 val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
> @@ -628,8 +663,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>   	val &= ~PHY_TEST_PWR_DOWN;
>   	writel(val, pcie->parf + PARF_PHY_CTRL);
>   
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> +	qcom_pcie_configure_dbi_base(pcie);
>   
>   	/* MAC PHY_POWERDOWN MUX DISABLE  */
>   	val = readl(pcie->parf + PARF_SYS_CTRL);
> @@ -811,13 +845,11 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>   	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>   	u32 val;
>   
> -	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> -
>   	val = readl(pcie->parf + PARF_PHY_CTRL);
>   	val &= ~PHY_TEST_PWR_DOWN;
>   	writel(val, pcie->parf + PARF_PHY_CTRL);
>   
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> +	qcom_pcie_configure_dbi_atu_base(pcie);
>   
>   	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
>   		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
> @@ -913,8 +945,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>   	val &= ~PHY_TEST_PWR_DOWN;
>   	writel(val, pcie->parf + PARF_PHY_CTRL);
>   
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> +	qcom_pcie_configure_dbi_atu_base(pcie);
>   
>   	/* MAC PHY_POWERDOWN MUX DISABLE  */
>   	val = readl(pcie->parf + PARF_SYS_CTRL);
> @@ -1123,14 +1154,11 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>   	u32 val;
>   	int i;
>   
> -	writel(SLV_ADDR_SPACE_SZ,
> -		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> -
>   	val = readl(pcie->parf + PARF_PHY_CTRL);
>   	val &= ~PHY_TEST_PWR_DOWN;
>   	writel(val, pcie->parf + PARF_PHY_CTRL);
>   
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> +	qcom_pcie_configure_dbi_atu_base(pcie);
>   
>   	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
>   	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,

