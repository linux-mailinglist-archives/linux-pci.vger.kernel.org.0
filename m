Return-Path: <linux-pci+bounces-20610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91432A242D6
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 19:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137D0164A5D
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678E61F2368;
	Fri, 31 Jan 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev0A7oX1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AA1F1525;
	Fri, 31 Jan 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348718; cv=none; b=EjLc3H0vbP6WMZughshCZl6Q63QtsIkJFFXjY49P03OfRc6zXK+Jke72UJ4uAEK1JomkV8W5NWwF/2xuKKvi6SRfxMltZxmGkpEYETg0RuiIrYtiFUKi4zesbRSbLVaIXdUtTEy4k7lNN/K8E6j/LqzPTfULT0O2TSbgUGAtp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348718; c=relaxed/simple;
	bh=uRi5jQVv4qDslxglfmTAuNpBXgflIayJuYcLhxVNoBE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jvnxVTKUBMUrZc2g7Iat2/rSMTXcUICcFnyheScnfCHmFafoVD8sVlXXmCZHSXWXLI6TZUMkB+zeocazYW1ZJlNAVTgEiKPe1PW0Oe8ZTG9WoD1DhogD5iNjwtRalToeTWxQRq/0NOipHsApgmTttOOjaEg2CN61p2Axl4a1nu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev0A7oX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C98C4CED1;
	Fri, 31 Jan 2025 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738348717;
	bh=uRi5jQVv4qDslxglfmTAuNpBXgflIayJuYcLhxVNoBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ev0A7oX1xkxerQHhFTMtkRJC1A9pZWZGzOtDH3fCv60Ss9lpg4V0qWlTyPttWdDGZ
	 FbpfEY4MJnpd72sAyA8l9809G46hM2XlT0qLYQ+OiPpCbs5Eu66bFKLEdxVfxK0/8T
	 sSCdLR/gPdt4+XFid367DeUNBB6qa+qbBLDEgY7ULTb0c9DdGMzd+darPZLjMOokw0
	 FbiCuiQfcuGi9z0WV5obtCapFRGfM1NtshIXYgO4J6DSLLyBaD7DblRLeLBZfKMSVs
	 Tnfoms86s8ZkxSuisUeYKeX5Z9FxLSOiZm0RZhYtKs2wPrJjIO/HZDt9FC5ZHnaRgZ
	 jvcLBxmC6MBvA==
Date: Fri, 31 Jan 2025 12:38:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: cdns : Function to read controller architecture
Message-ID: <20250131183835.GA688678@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1C5FA4D55D4271BA4F6F0DA2E82@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

Look at previous subject lines for changes to these files and follow
the pattern.

On Fri, Jan 31, 2025 at 11:58:07AM +0000, Manikandan Karunakaran Pillai wrote:
> Add support for getting the architecture for Cadence PCIe controllers
> Store the architecture type in controller structure.

This needs to be part of a series that uses pcie->is_hpa for
something.  This patch all by itself isn't useful for anything.

Please post the resulting series with a cover letter and the patches
as responses to it:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v6.13#n333

You can look at previous postings to see the style, e.g.,
https://lore.kernel.org/linux-pci/20250115074301.3514927-1-pandoh@google.com/T/#t

> +static void cdns_pcie_ctlr_set_arch(struct cdns_pcie *pcie)
> +{
> +	/* Read register at offset 0xE4 of the config space
> +	 * The value for architecture is in the lower 4 bits
> +	 * Legacy-b'0010 and b'1111 for HPA-high performance architecture
> +	 */

Don't include the hex register offset in the comment.  That's what
CDNS_PCIE_CTRL_ARCH is for.  It doesn't need the bit values either.

Use the conventional comment style:

  /*
   * Text ...
   */

> +	u32 arch, reg;
> +
> +	reg = cdns_pcie_readl(pcie, CDNS_PCIE_CTRL_ARCH);
> +	arch = FIELD_GET(CDNS_PCIE_CTRL_ARCH_MASK, reg);

Thanks for using GENMASK() and FIELD_GET().

> +	if (arch == CDNS_PCIE_CTRL_HPA) {
> +		pcie->is_hpa = true;
> +	} else {
> +		pcie->is_hpa = false;
> +	}
> +}

> +/*
> + * Read completion time out reset value to decode controller architecture
> + */
> +#define CDNS_PCIE_CTRL_ARCH		0xE4

Is this another name for the PCI_EXP_DEVCTL2 in the PCIe Capability?
Or maybe PCI_EXP_DEVCAP2?  If so, use those existing #defines and the
related masks (if it's DEVCAP2, you'd probably have to add a new one
for the Completion Timeout Ranges Supported field).

There's something similar in cdns_pcie_retrain(), where
CDNS_PCIE_RP_CAP_OFFSET is apparently the config space offset of the
PCIe Capability.

> +#define CDNS_PCIE_CTRL_ARCH_MASK	GENMASK(3, 0)
> +#define CDNS_PCIE_CTRL_HPA		0xF

