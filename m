Return-Path: <linux-pci+bounces-42073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29861C86AA4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 19:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C4B14E6FB2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1201E3314D2;
	Tue, 25 Nov 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOpAxEHQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F412D73B8;
	Tue, 25 Nov 2025 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095876; cv=none; b=unCa6BT27O103Iwoqt0jkSQHwpoObXCtXl6v1VxXNV1kPQrfbG7K9cnmH7LTuQwEBCw+ZGMo5qLGN++a1sbenALdc3Z1SXw6fr+eFQh8x69T65CiGopQxWchqhjK4hPdoNy3TOKcJpYKAPwjqde5jFJR6MAXI922j3tuNPVPiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095876; c=relaxed/simple;
	bh=ekM/GMp2sa9jEx3lkipZVfwQ5gWiV3PeEUMvSNxE9Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MMtZkvGSZ/kr+bli0IqkMd7VYBmkBEGyvushcKPKPd1jpWvQAaxPCpWlSHZ++ZB+nAPn1FHFok1+P8OCjRW96v9fgmhCKgDwFKnnnnCNqPbzAQXLL7NFIozy1yaOoabVOL++A0qVGjia8As2Dy1vWXbRrCaCOJTyKdyYbd6Lozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOpAxEHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80990C4CEF1;
	Tue, 25 Nov 2025 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764095875;
	bh=ekM/GMp2sa9jEx3lkipZVfwQ5gWiV3PeEUMvSNxE9Yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hOpAxEHQgvVQFN97lM1F/yj6pSYfm6fjQ8OH9b6TPUvvWcemMnqtauseW/XAWbRbk
	 zgZVjA2PboZOpMulFvEBNoQzYAAUbukxQHlyepJ/B7OLa5+9xLj1vUGwbFlBEKhhnq
	 LWhhfmHBMSuFXK3lH4B12rf6x75w+HVFlWOjmq4bov//V6JYIluYhjwdnrfAHkIOJA
	 mXPsMveW7Hj1xG2L3s6u/KMTd3zYweCUxRc7sMp/pEDUxhium3EXVFH9WGWfX5KqMp
	 zg8hDYvG/IB1XxHErStf/4Rl80sw90/AyFAKLHOYDjJIKg8WKhH9Z1b2YAb0H0mZ0y
	 AFhK0BES35ZpQ==
Date: Tue, 25 Nov 2025 12:37:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v8 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
Message-ID: <20251125183754.GA2755815@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119143523.977085-3-claudiu.beznea.uj@bp.renesas.com>

On Wed, Nov 19, 2025 at 04:35:19PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> only as a root complex, with a single-lane (x1) configuration. The
> controller includes Type 1 configuration registers, as well as IP
> specific registers (called AXI registers) required for various adjustments.

> +/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
> +static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
> +				 int where, int size, u32 val)
> +{
> +	struct rzg3s_pcie_host *host = bus->sysdata;
> +	int ret;
> +
> +	/* Enable access control to the CFGU */
> +	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
> +		       host->axi + RZG3S_PCI_PERM);

I suppose this has been asked and answered already, but it's curious
that you need this for config writes but not for reads.  Obviously it
must *work*, but it's unusual and might warrant a comment.  "Access
control" must be a hint, but only means something to experts.

> +	ret = pci_generic_config_write(bus, devfn, where, size, val);
> +
> +	/* Disable access control to the CFGU */
> +	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> +
> +	return ret;
> +}

> +static irqreturn_t rzg3s_pcie_msi_irq(int irq, void *data)
> +{
> +	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
> +	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR);
> +	struct rzg3s_pcie_host *host = data;
> +	struct rzg3s_pcie_msi *msi = &host->msi;
> +	unsigned long bit;
> +	u32 status;
> +
> +	status = readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIS);
> +	if (!(status & RZG3S_PCI_PINTRCVIS_MSI))
> +		return IRQ_NONE;
> +
> +	/* Clear the MSI */
> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
> +			       RZG3S_PCI_PINTRCVIS_MSI,
> +			       RZG3S_PCI_PINTRCVIS_MSI);

Other writes to RZG3S_PCI_PINTRCVIS are guarded by host->hw_lock.  Is this
one safe without it?

> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSGRCVIS,
> +			       RZG3S_PCI_MSGRCVIS_MRI, RZG3S_PCI_MSGRCVIS_MRI);
> +
> +	for (u8 reg_id = 0; reg_id < regs; reg_id++) {
> +		status = readl_relaxed(host->axi + RZG3S_PCI_MSIRS(reg_id));
> +		bitmap_write(bitmap, status, reg_id * RZG3S_PCI_MSI_INT_PER_REG,
> +			     RZG3S_PCI_MSI_INT_PER_REG);
> +	}
> +
> +	for_each_set_bit(bit, bitmap, RZG3S_PCI_MSI_INT_NR) {
> +		int ret;
> +
> +		ret = generic_handle_domain_irq(msi->domain, bit);
> +		if (ret) {
> +			u8 reg_bit = bit % RZG3S_PCI_MSI_INT_PER_REG;
> +			u8 reg_id = bit / RZG3S_PCI_MSI_INT_PER_REG;
> +
> +			/* Unknown MSI, just clear it */
> +			writel_relaxed(BIT(reg_bit),
> +				       host->axi + RZG3S_PCI_MSIRS(reg_id));

Other writes to RZG3S_PCI_MSIRS are guarded by host->hw_lock.  Is this
one safe without it?

> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}

