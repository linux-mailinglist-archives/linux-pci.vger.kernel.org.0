Return-Path: <linux-pci+bounces-10742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026C93B6F4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 20:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6182B1C23B09
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6461016A940;
	Wed, 24 Jul 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/Ji5Tcx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381DA15FA9E;
	Wed, 24 Jul 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846594; cv=none; b=NjR2UrcQdsF+H5JBhGb9GVUKpLu1JcIev7gjf3ZUp9xdqIJRKgZnLCZsbq2OiSd7MPvrMkzE0FQ7fPFthhycOdmbq5vOP3/n+4eGGEIhz85sV/ny9qjITpxyYNfxyo4ovabLyNo0/buFPPigDzPNxKkMVXOIcU3LQIEuGC1gyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846594; c=relaxed/simple;
	bh=L80G3kPVO8gxwuFs2mPT1nO1RmFx/FrBSZjpfwFmHos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W4gcoT5ih/nNYsKFFF3+eTYpOIkYP8x8i/gav7PRZhprF9/zFZymX9Chc+t1vcghiZdYXTkBOMhQ1m3qLjgJk9QuorjmESPVM1E5CxFn96HhFd+cNaVFt6qUF4GCGZ9L8TnMxuzAFE1z2nF5C17VDOFX5Jvyz1ECaPLH5yx/K6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/Ji5Tcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B15C32786;
	Wed, 24 Jul 2024 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721846593;
	bh=L80G3kPVO8gxwuFs2mPT1nO1RmFx/FrBSZjpfwFmHos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C/Ji5Tcxdw6ztbZTRnedFT2zVntttve6JQGa4mgXO1sZyIuIobiM1o70bQIITCxZy
	 LKIcIfUkltmdl7TAKz086FrJyWhy7Z3tg1LWQme1YnUeZ7klUO9jUM9V9Cjqu1G2ty
	 pAIDSteK24dStdt5k/NplnXduMgNs+XtL2nRoRcV+2FdxFjccl5TZNRsqQmnQ329Au
	 VnEauHY1lUFnMDEvy0PisKogV63MGv5g712+ntltz/QAUqxYNygueHv49te4S+CcXT
	 uW31a+Fb5bewgLaBYHQcLGw6FxLXHcYJ++2PaY6m9DGHqol8JDMgwtkRJ9nIQpihWp
	 k/XMpTmWC0XAQ==
Date: Wed, 24 Jul 2024 13:43:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 2/2] PCI: qcom: Avoid DBI and ATU register space
 mirror to BAR/MMIO region
Message-ID: <20240724184311.GA807002@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724022719.2868490-3-quic_pyarlaga@quicinc.com>

On Tue, Jul 23, 2024 at 07:27:19PM -0700, Prudhvi Yarlagadda wrote:
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
>                         |---------------|
>                         |               |
>                         |               |
>         ------- --------|---------------|
>            |       |    |---------------|
>            |       |    |       DBI     |
>            |       |    |---------------|---->DBI_BASE_ADDR
>            |       |    |               |
>            |       |    |               |
>            |    PCIe    |               |---->2*SLV_ADDR_SPACE_SIZE
>            |    BAR/MMIO|---------------|
>            |    Region  |       ATU     |
>            |       |    |---------------|---->ATU_BASE_ADDR
>            |       |    |               |
>         PCIe       |    |---------------|
>         Memory     |    |       DBI     |
>         Region     |    |---------------|---->DBI_BASE_ADDR
>            |       |    |               |
>            |    --------|               |
>            |            |               |---->SLV_ADDR_SPACE_SIZE
>            |            |---------------|
>            |            |       ATU     |
>            |            |---------------|---->ATU_BASE_ADDR
>            |            |               |
>            |            |---------------|
>            |            |       DBI     |
>            |            |---------------|---->DBI_BASE_ADDR
>            |            |               |
>            |            |               |
>         ----------------|---------------|
>                         |               |
>                         |               |
>                         |               |
>                         |---------------|
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
> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 62 +++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..6976efb8e2f0 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -45,6 +45,7 @@
>  #define PARF_PHY_REFCLK				0x4c
>  #define PARF_CONFIG_BITS			0x50
>  #define PARF_DBI_BASE_ADDR			0x168
> +#define PARF_SLV_ADDR_SPACE_SIZE		0x16C
>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>  #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> @@ -52,8 +53,13 @@
>  #define PARF_LTSSM				0x1b0
>  #define PARF_SID_OFFSET				0x234
>  #define PARF_BDF_TRANSLATE_CFG			0x24c
> -#define PARF_SLV_ADDR_SPACE_SIZE		0x358
> +#define PARF_DBI_BASE_ADDR_V2			0x350
> +#define PARF_DBI_BASE_ADDR_V2_HI		0x354
> +#define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
> +#define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35C
>  #define PARF_NO_SNOOP_OVERIDE			0x3d4
> +#define PARF_ATU_BASE_ADDR			0x634
> +#define PARF_ATU_BASE_ADDR_HI			0x638
>  #define PARF_DEVICE_TYPE			0x1000
>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
>  #define PARF_BDF_TO_SID_CFG			0x2c00
> @@ -107,9 +113,6 @@
>  /* PARF_CONFIG_BITS register fields */
>  #define PHY_RX0_EQ(x)				FIELD_PREP(GENMASK(26, 24), x)
>  
> -/* PARF_SLV_ADDR_SPACE_SIZE register value */
> -#define SLV_ADDR_SPACE_SZ			0x10000000
> -
>  /* PARF_MHI_CLOCK_RESET_CTRL register fields */
>  #define AHB_CLK_EN				BIT(0)
>  #define MSTR_AXI_CLK_EN				BIT(1)
> @@ -324,6 +327,39 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
> +static void qcom_pcie_configure_dbi_base(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	if (pci->dbi_phys_addr) {
> +		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
> +							PARF_DBI_BASE_ADDR);
> +		writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> +	}
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
> +
> +		if (pci->atu_phys_addr) {
> +			writel(lower_32_bits(pci->atu_phys_addr), pcie->parf +
> +							PARF_ATU_BASE_ADDR);
> +			writel(upper_32_bits(pci->atu_phys_addr), pcie->parf +
> +							PARF_ATU_BASE_ADDR_HI);
> +		}
> +
> +		writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2);
> +		writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2_HI);
> +	}
> +}

These functions write CPU physical addresses into registers.  I don't
know where these registers live.  If they are on the PCI side of the
world, they most likely should contain PCI bus addresses, not CPU
physical addresses.

In some systems, PCI bus addresses are the same as CPU physical
addresses, but on many systems they are not the same, so it's better
if we don't make implicit assumptions that they are the same.  

Bjorn

