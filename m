Return-Path: <linux-pci+bounces-20815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E04DA2AE7A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 18:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2853AB3A9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B324239592;
	Thu,  6 Feb 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzeo/m7t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A623957F;
	Thu,  6 Feb 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861460; cv=none; b=nNlooYgxpOLX2NKQCMXne/IoF1sLYNyNz/ZTsE6n0OPIVg9nykomR3dZSRYcbJbUO1Ct321Tj0BHAmMGHGPpQ8j7prPmgsPrInVAMBN+VGten5hGnBxW4j7iGzsByBmI2yXUe1t5z82upJ+2pLoiYm7hv5AOENNT9vdylxOVh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861460; c=relaxed/simple;
	bh=L2rPvTq6V62r+Q0cSWKfYC74gOjcnbe+1Nz7F+6fQ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ynvb1VFviNdYCkBoH7vMZ9/tz8ahMiI0iZqgtq/U1iugEsD9xU/YQn0Rew1ZGSEW+pCY0EZYbjiKMih/3nHErBOyL3vF0PWSheDWETZQ5tQaWT61haQYfcduR3j55exakkuAPJ6feMdMRA2DbMCh6kzUXm7q0gXQCg2fYsJ4Kgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzeo/m7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F06DC4CEDD;
	Thu,  6 Feb 2025 17:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738861459;
	bh=L2rPvTq6V62r+Q0cSWKfYC74gOjcnbe+1Nz7F+6fQ8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uzeo/m7tfOupfY44sRumsHLskiD0iklYeSbmhmduTUqWpmW6kw9sueCiYyd4dsRjn
	 Xo6adFg4wOloZSBPMxO9IAaUu9eHVq+xrLqFV//6fFgvLFx+GvS6uCYdLnqzStqZwp
	 3bxYpjyWxGUY4jHjEqJsvKt8vBYMleZ1UvoPVThd61f7XYZL/IfTtkQ1RAUpxqWHOX
	 hg7Dp8zdVE+TkA3sxWAR2TBoCwgRenwtPZLoi74brutVQsI6R8Z8tktapJcTA8/VZc
	 LGoq5YyJGq1LviWgq/OgGGBnc22glvNoSOIdEplc5AAIpjoAsHHNMQ4ENGW1SXiWRj
	 imRQnjf0FK7ZQ==
Date: Thu, 6 Feb 2025 11:04:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/6] PCI: brcmstb: Refactor max speed limit
 functionality
Message-ID: <20250206170417.GA989059@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205191213.29202-2-james.quinlan@broadcom.com>

On Wed, Feb 05, 2025 at 02:12:01PM -0500, Jim Quinlan wrote:
> Make changes to the code that limits the PCIe max speed.
> 
> (1) Do the changes before link-up, not after.  We do not want
>     to temporarily rise to a higher speed than desired.

This is a functional change that should be split into its own patch.
That will also make it obvious that this is not simple refactoring as
the subject line advertises.

> (2) Use constants from pci_reg.h when possible
> (3) Use uXX_replace_bits(...) for setting a register field.

> (4) Use the internal link capabilities register for writing
>     the max speed, not the official config space register
>     where the speed field is RO.  Updating this field is
>     not necessary to limit the speed so this mistake was
>     harmless.

Also a bug fix (though harmless in this case) that deserves to be
split out so the distinction between the internal and the architected
paths to the register is highlighted and may help prevent the same
mistake in the future.

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 546056f7f0d3..f8fc3d620ee2 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -47,6 +47,7 @@
>  
>  #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
>  #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
> +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_SPEED_MASK	0xf

If the format of this internal register is different, of course we
need a new #define for this.  But if this is just a different path to
LNKCAP, and both paths read the same bits in the same format, I don't
see the point of a new #define.

>  #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
>  #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
> @@ -413,12 +414,12 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
>  static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
>  {
>  	u16 lnkctl2 = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
> -	u32 lnkcap = readl(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
> +	u32 lnkcap = readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>  
> -	lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
> -	writel(lnkcap, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
> +	u32p_replace_bits(&lnkcap, gen, PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_SPEED_MASK);
> +	writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>  
> -	lnkctl2 = (lnkctl2 & ~0xf) | gen;
> +	u16p_replace_bits(&lnkctl2, gen, PCI_EXP_LNKCTL2_TLS);


OK.  I am not really a fan of the uXX_replace_bits() thing because
it's not widely used (I found 341 instances tree-wide, compared to
14000+ for FIELD_PREP()), grep can't find the definition easily, and
stylistically it doesn't fit with GENMASK(), FIELD_PREP(), etc.

But it's already used throughout brcmstb.c, so we should be
consistent.

