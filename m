Return-Path: <linux-pci+bounces-9049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858B591151F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 23:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49B8B22F19
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 21:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B156D1B2;
	Thu, 20 Jun 2024 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m4E9KYjp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7ED2E859;
	Thu, 20 Jun 2024 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718920266; cv=none; b=nwTHf9rLrZb15qvKzR+oTstUnWkWFNcjxxsCm7JusLCFnn4GcIl5OAqZqtBcOCZHibcvGj9xdapnDMe/rGV+alXt0PDT11hyb5GQrxv6cJhcklKXrLo/8LNnFCDlgD+ICveVnTbM8jtIExliOSskuHyRcyInykBbU8Txs27q3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718920266; c=relaxed/simple;
	bh=SeanRr8rDm1OMKg0OwxViXGoxLq9HShOEH1lCUsGsTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ksoKPLhtnX9RGUvfX8G9GFNnblMxO9rhiDpDeGqYHS7K+9j15RRuxClsMNbePrmc45eEEsHafnUQqWGsUQVd6Uv6wzFujRslM13wI/Vv/tZI4ODia8Jvg3HQWCmIdU2aelfn6Lu+aliIOX78D2rf7Coc6f7u78F9AVlq8okJIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m4E9KYjp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHC8Vh008470;
	Thu, 20 Jun 2024 21:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ip7THjRL5AZDLqQZ/bBtnoMvmHBr9835gvEbetvDAZc=; b=m4E9KYjpw2UJhFNv
	WaX/gH6E+QrPvzPFTv4ewcNNtHm4/8a08qFYOYWNFQnL2kmzR74Z3sdStbNtKc/L
	HuazsKwjJx32hze3Pqg/vByCgbmTqDGfJoRnTIlZm0kzKYniv3ZY9tuLauCfiMna
	PMfcocvBes/wTK/mURco9Mesf3nYnzXhxbcpMU7TZP+yXCoQF+iR5cQ4fWs2uh4N
	v8RioyOOkbcfQkuewFS4M0SJaYyu9AALKbWoeco2M7l/HrwL0IcWnaNS2A3qi0kZ
	1DlUfDu6xlK7FEPfft/WIZHGfWwa4XuROaFaMcazWO6yW4zK8SIWLgtnn5g+O/OR
	DBicOw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrm2gq5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 21:50:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KLohdj031295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 21:50:43 GMT
Received: from [10.110.35.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 14:50:43 -0700
Message-ID: <8877e1f7-bbb6-49e9-a30c-0ae8e40bf5dd@quicinc.com>
Date: Thu, 20 Jun 2024 14:50:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: qcom: Avoid DBI and ATU register space mirror to
 BAR/MMIO region
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240620213405.3120611-1-quic_pyarlaga@quicinc.com>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240620213405.3120611-1-quic_pyarlaga@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P1tcC3QnFf4KK72aRldX7NnKsTTyigzx
X-Proofpoint-ORIG-GUID: P1tcC3QnFf4KK72aRldX7NnKsTTyigzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1011 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406200160


On 6/20/2024 2:34 PM, Prudhvi Yarlagadda wrote:
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
> 			|---------------|
> 			|		|
> 			|		|
> 	-------	--------|---------------|
> 	   |	   |	|---------------|
> 	   |	   |	|	DBI	|
> 	   |	   |	|---------------|---->DBI_BASE_ADDR
> 	   |	   |	|		|
> 	   |	   |	|		|
> 	   |	PCIe	|		|---->2*SLV_ADDR_SPACE_SIZE
> 	   |	BAR/MMIO|---------------|
> 	   |	Region	|	ATU	|
> 	   |	   |	|---------------|---->ATU_BASE_ADDR
> 	   |	   |	|		|
> 	PCIe	   |	|---------------|
> 	Memory	   |	|	DBI	|
> 	Region	   |	|---------------|---->DBI_BASE_ADDR
> 	   |	   |	|		|
> 	   |	--------|		|
> 	   |		|		|---->SLV_ADDR_SPACE_SIZE
> 	   |		|---------------|
> 	   |		|	ATU	|
> 	   |		|---------------|---->ATU_BASE_ADDR
> 	   |		|		|
> 	   |		|---------------|
> 	   |		|	DBI	|
> 	   |		|---------------|---->DBI_BASE_ADDR
> 	   |		|		|
> 	   |		|		|
> 	----------------|---------------|
> 			|		|
> 			|		|
> 			|		|
> 			|---------------|
> 
> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
> used for BAR region which is why the above mentioned issue is not
> encountered. This issue is discovered as part of internal testing when we
> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
> we are trying to fix this.
> 
> As PARF hardware block mirrors DBI and ATU register space after every
> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
> U64_MAX to PARF_SLV_ADDR_SPACE_SIZE register to avoid mirroring DBI and
> ATU to BAR/MMIO region. Write the physical base address of DBI and ATU
> register blocks to PARF_DBI_BASE_ADDR (default 0x0) and PARF_ATU_BASE_ADDR
> (default 0x1000) respectively to make sure DBI and ATU blocks are at
> expected memory locations.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 40 ++++++++++++++++++++++----
>   1 file changed, 35 insertions(+), 5 deletions(-)
> 
> Tested:
> - Validated NVME functionality with PCIe6a on x1e80100 platform.
> - Validated WiFi functionality with PCIe4 on x1e80100 platform.
> - Validated NVME functionality with PCIe0 and PCIe1 on SA8775p platform.
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 5f9f0ff19baa..864548657551 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -49,7 +49,12 @@
>   #define PARF_LTSSM				0x1b0
>   #define PARF_SID_OFFSET				0x234
>   #define PARF_BDF_TRANSLATE_CFG			0x24c
> +#define PARF_DBI_BASE_ADDR_V2			0x350
> +#define PARF_DBI_BASE_ADDR_V2_HI		0x354
>   #define PARF_SLV_ADDR_SPACE_SIZE		0x358
> +#define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35C
> +#define PARF_ATU_BASE_ADDR			0x634
> +#define PARF_ATU_BASE_ADDR_HI			0x638
>   #define PARF_NO_SNOOP_OVERIDE			0x3d4
>   #define PARF_DEVICE_TYPE			0x1000
>   #define PARF_BDF_TO_SID_TABLE_N			0x2000
> @@ -319,6 +324,33 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>   	dw_pcie_dbi_ro_wr_dis(pci);
>   }
>   
> +static void qcom_pcie_avoid_dbi_atu_mirroring(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	struct platform_device *pdev;
> +	struct resource *atu_res;
> +	struct resource *dbi_res;
> +
> +	pdev = to_platform_device(pci->dev);
> +	if (!pdev)
> +		return;
> +
> +	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	if (dbi_res) {
> +		writel(lower_32_bits(dbi_res->start), pcie->parf + PARF_DBI_BASE_ADDR_V2);
> +		writel(upper_32_bits(dbi_res->start), pcie->parf + PARF_DBI_BASE_ADDR_V2_HI);
> +	}
> +
> +	atu_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> +	if (atu_res) {
> +		writel(lower_32_bits(atu_res->start), pcie->parf + PARF_ATU_BASE_ADDR);
> +		writel(upper_32_bits(atu_res->start), pcie->parf + PARF_ATU_BASE_ADDR_HI);
> +	}
> +
> +	writel(lower_32_bits(U64_MAX), pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> +	writel(upper_32_bits(U64_MAX), pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_HI);
> +}
> +
>   static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
>   {
>   	u32 val;
> @@ -623,8 +655,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>   	val &= ~PHY_TEST_PWR_DOWN;
>   	writel(val, pcie->parf + PARF_PHY_CTRL);
>   
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> +	qcom_pcie_avoid_dbi_atu_mirroring(pcie);
>   
>   	/* MAC PHY_POWERDOWN MUX DISABLE  */
>   	val = readl(pcie->parf + PARF_SYS_CTRL);
> @@ -900,6 +931,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>   	/* Wait for reset to complete, required on SM8450 */
>   	usleep_range(1000, 1500);
>   
> +	qcom_pcie_avoid_dbi_atu_mirroring(pcie);
> +
>   	/* configure PCIe to RC mode */
>   	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
>   
> @@ -908,9 +941,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>   	val &= ~PHY_TEST_PWR_DOWN;
>   	writel(val, pcie->parf + PARF_PHY_CTRL);
>   
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> -
>   	/* MAC PHY_POWERDOWN MUX DISABLE  */
>   	val = readl(pcie->parf + PARF_SYS_CTRL);
>   	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>

