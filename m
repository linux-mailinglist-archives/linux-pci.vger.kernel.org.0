Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563992A5A0A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 23:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgKCWWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 17:22:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbgKCWWY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 17:22:24 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F22204FD;
        Tue,  3 Nov 2020 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604442144;
        bh=Nn4ugSdXKX2rotSL4FqxCE0SSE5hPVNQ2iOVaGulO0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AUXFXqOvx0HuLclhpfcfttWemE4rj1QtbBl5a5jPiiksBBf9HOWh6tQGr6cUJ/KhF
         RMzpX/Mq1vInvDv9yq8re191PTJQLVXnAfAEBuqSaio6/U2SQsqDNIdrqYtza4K6jV
         TIEPdc3boJhicadaoB+mA1Ow33OejY/1fOLPMwrQ=
Date:   Tue, 3 Nov 2020 16:22:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20201103222223.GA269610@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027060011.25893-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 27, 2020 at 02:00:11PM +0800, Wan Ahmad Zainie wrote:

> +static int keembay_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
> +	u32 val, mask;
> +
> +	val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_SII_PM_STATE);
> +	mask = SMLH_LINK_UP | RDLH_LINK_UP;
> +
> +	return !!((val & mask) == mask);

I think the "!!" is redundant since you're applying it to a value
that's a boolean already.  So you should be able to do:

  return (val & mask) == mask;

But it seems like "mask" just obfuscates a little bit, too.
Personally I think it'd be easier to add something like:

  #define PCIE_REGS_PCIE_SII_LINK_UP  (SMLH_LINK_UP | RDLH_LINK_UP)

and then:

  if ((val & PCIE_REGS_PCIE_SII_LINK_UP) == PCIE_REGS_PCIE_SII_LINK_UP)
    return 1;
  return 0;

or even:

  return (val & PCIE_REGS_PCIE_SII_LINK_UP) == PCIE_REGS_PCIE_SII_LINK_UP;

> +static int keembay_pcie_establish_link(struct dw_pcie *pci)
> +{
> +	return 0;
> +}

Are you sure you need this?  I see other cases where the .start_link
pointer is left NULL, e.g., pci-exynos.c, pci-imx6.c,
dw_ls1021_pcie_ops, etc.

> +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				     enum pci_epc_irq_type type,
> +				     u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		/* Legacy interrupts are not supported in Keem Bay */
> +		dev_err(pci->dev, "Unsupported IRQ type\n");

Might be nice to mention "legacy" here.

> +		return -EINVAL;
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	case PCI_EPC_IRQ_MSIX:
> +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "Unknown IRQ type\n");

And maybe include the %d of "type"?
