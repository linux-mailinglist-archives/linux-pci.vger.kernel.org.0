Return-Path: <linux-pci+bounces-39058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7FBFDF62
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 21:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C3F3A4924
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7B52F1FD8;
	Wed, 22 Oct 2025 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSN9tBv0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8D2F069E;
	Wed, 22 Oct 2025 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159844; cv=none; b=mXLWbIYUiDK5VMcuRqRPZGDbEpjCwdb91lg5fbt80X3vGVmTclKKyOBSdXZbdy6B8/Rf9lqGgEiDtPZYdzCGdUytuRZ6clXlHSTrBrKV6eacbG3olKCidN7h7SE0QUOaFoHnE++4pkIv2yAAWulTaWwtI6hZmL3+gfh1OLPBBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159844; c=relaxed/simple;
	bh=HynxvFvL63x3qBAv6jyUnbljlrqHMAy78xfcOCsEeHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qHiffhCKqk0AbSstgt9jL/41OeFoBUC0eKJ5+NFCRMbdS1x8aS21vq/ypDHhSx1SgvPSpJ7kZBt8dfJVlb5oHIWC3Fe4AHZALbY7A31GPaTE/C8Zx3pA/i4I1F2ipMpX+FdmU+wTbCSsanauKTGhRi+dsT8GbaOiECDf+ZwLFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSN9tBv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662DCC4CEE7;
	Wed, 22 Oct 2025 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761159843;
	bh=HynxvFvL63x3qBAv6jyUnbljlrqHMAy78xfcOCsEeHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NSN9tBv0CifB0arwpVmfBmqmRO3mJaAIUdXhdzNTFPa4msh/y2tHxQiwcHbr/DwcA
	 z1N7+0NQju/bE5zoxNg1TGM7GBw420UlQCuaXYRJ3wmy0nexThFKJtMqsf5Dcs2FgX
	 tpN3WAZBAMXoqQnA8R62MNnpjvolmTl5kvnlu7A6FZjEI0hx+/2QdeICA1p0IelyEe
	 jrOpLfyO4ZO0EYFVpc8ci7iRiYZ3/f7dwjUPUa5AdFgVAhS/KoFXUc9FDHwjRgdc7B
	 l1d+gi+PrflsqymNwaVZwrxyYzozhbhysAwFXF6BJrS/PHOxPDQMgWY2+YuQUf1yzx
	 d/d0YZi/M30kg==
Date: Wed, 22 Oct 2025 14:04:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <20251022190402.GA1262472@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022174309.1180931-4-vincent.guittot@linaro.org>

On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> Add initial support of the PCIe controller for S32G Soc family. Only
> host mode is supported.

> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -406,6 +406,16 @@ config PCIE_UNIPHIER_EP
>  	  Say Y here if you want PCIe endpoint controller support on
>  	  UniPhier SoCs. This driver supports Pro5 SoC.
>  
> +config PCIE_NXP_S32G
> +	tristate "NXP S32G PCIe controller (host mode)"
> +	depends on ARCH_S32 || COMPILE_TEST
> +	select PCIE_DW_HOST
> +	help
> +	  Enable support for the PCIe controller in NXP S32G based boards to
> +	  work in Host mode. The controller is based on DesignWare IP and
> +	  can work either as RC or EP. In order to enable host-specific
> +	  features PCIE_S32G must be selected.

Reorder this so the menu item is sorted by vendor name.

> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h

> +/* Link Interrupt Control And Status */
> +#define PCIE_S32G_LINK_INT_CTRL_STS		0x40
> +#define LINK_REQ_RST_NOT_INT_EN			BIT(1)
> +#define LINK_REQ_RST_NOT_CLR			BIT(2)

None of these are used; remove until you need them.

> +/* PCIe controller 0 General Control 1 */
> +#define PCIE_S32G_PE0_GEN_CTRL_1		0x50
> +#define DEVICE_TYPE_MASK			GENMASK(3, 0)
> +#define DEVICE_TYPE(x)				FIELD_PREP(DEVICE_TYPE_MASK, x)

Not sure this adds much over just doing this:

  #define DEVICE_TYPE   GENMASK(3, 0)

  val |= FIELD_PREP(DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT);

> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c

> +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_addr)
> +{
> +	u32 ddr_base_low = lower_32_bits(ddr_base_addr);
> +	u32 ddr_base_high = upper_32_bits(ddr_base_addr);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0x0);
> +
> +	/*
> +	 * Ncore is a cache-coherent interconnect module that enables the
> +	 * integration of heterogeneous coherent and non-coherent agents in
> +	 * the chip. Ncore Transactions to peripheral should be non-coherent
> +	 * or it might drop them.
> +	 * One example where this is needed are PCIe MSIs, which use NoSnoop=0
> +	 * and might end up routed to Ncore.
> +	 * Define the start of DDR as seen by Linux as the boundary between
> +	 * "memory" and "peripherals", with peripherals being below.

Add blank lines between paragraphs.

> +	 */
> +	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_1_OFF,
> +			   (ddr_base_low & CFG_MEMTYPE_BOUNDARY_LOW_ADDR_MASK));
> +	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_2_OFF, ddr_base_high);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
> +static void s32g_init_pcie_controller(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 val;
> +
> +	/* Set RP mode */
> +	val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1);
> +	val &= ~DEVICE_TYPE_MASK;
> +	val |= DEVICE_TYPE(PCI_EXP_TYPE_ROOT_PORT);
> +
> +	/* Use default CRNS */
> +	val &= ~SRIS_MODE;
> +
> +	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1, val);
> +
> +	/* Disable phase 2,3 equalization */
> +	s32g_pcie_disable_equalization(pci);
> +
> +	/*
> +	 * Make sure we use the coherency defaults (just in case the settings
> +	 * have been changed from their reset values)
> +	 */
> +	s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());

This seems sketchy and no other driver uses memblock_start_of_DRAM().
Shouldn't a physical memory address like this come from devicetree
somehow?

> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> +	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> +
> +	/*
> +	 * Set max payload supported, 256 bytes and
> +	 * relaxed ordering.
> +	 */
> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> +	val &= ~(PCI_EXP_DEVCTL_RELAX_EN |
> +		 PCI_EXP_DEVCTL_PAYLOAD |
> +		 PCI_EXP_DEVCTL_READRQ);
> +	val |= PCI_EXP_DEVCTL_RELAX_EN |
> +	       PCI_EXP_DEVCTL_PAYLOAD_256B |
> +	       PCI_EXP_DEVCTL_READRQ_256B;
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);

MPS and relaxed ordering should be configured by the PCI core.  Is
there some s32g-specific restriction about these?

> +	/* Enable errors */
> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> +	val |= PCI_EXP_DEVCTL_CERE |
> +	       PCI_EXP_DEVCTL_NFERE |
> +	       PCI_EXP_DEVCTL_FERE |
> +	       PCI_EXP_DEVCTL_URRE;
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);

Enabling these errors doesn't really seem device-specific, and
pci_enable_pcie_error_reporting() would enable all these.

But that only happens with CONFIG_PCIEAER=y, and since this is
DWC-based, you probably don't have standard interrupts for AER and
CONFIG_PCIEAER isn't useful.  Someday we might have support for
non-standard AER interrupts, but we don't have it yet.

I guess you get platform-specific System Errors when any of these
errors are detected (see PCIe r7.0, sec 6.2.6)?  What is the handler
for these?

> +static int s32g_pcie_host_init(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	int ret;
> +
> +	pp->ops = &s32g_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +
> +	return ret;

  return dw_pcie_host_init(pp);

Not sure this is really worth a wrapper.

> +static int s32g_pcie_get_resources(struct platform_device *pdev,
> +				   struct s32g_pcie *s32g_pp)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +
> +	s32g_pp->phy = devm_phy_get(dev, NULL);
> +	if (IS_ERR(s32g_pp->phy))
> +		return dev_err_probe(dev, PTR_ERR(s32g_pp->phy),
> +				"Failed to get serdes PHY\n");

Add blank line here.

> +	s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> +	if (IS_ERR(s32g_pp->ctrl_base))
> +		return PTR_ERR(s32g_pp->ctrl_base);

This looks like the first DWC driver that uses a "ctrl" resource.  Is
this something unique to s32g, or do other drivers have something
similar but use a different name?

> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);

Isn't this already done by dw_pcie_get_resources()?

> +static int s32g_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +
> +	if (!dw_pcie_link_up(pci))
> +		return 0;

Does something bad happen if you omit the link up check and the link
is not up when we get here?  The check is racy (the link could go down
between dw_pcie_link_up() and dw_pcie_suspend_noirq()), so it's not
completely reliable.

If you have to check, please add a comment about why this driver needs
it when no other driver does.

> +	return dw_pcie_suspend_noirq(pci);
> +}
> +
> +static int s32g_pcie_resume_noirq(struct device *dev)
> +{
> +	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +
> +	s32g_init_pcie_controller(s32g_pp);

Odd that you need this.  Other drivers really don't do anything
similar, probably because this could be done by the
pci->pp.ops->init() call in dw_pcie_resume_noirq().

> +	return dw_pcie_resume_noirq(pci);
> +}

> +static const struct of_device_id s32g_pcie_of_match[] = {
> +	{ .compatible = "nxp,s32g2-pcie"},

Add space before "}"

> +	{ /* sentinel */ },
> +};

