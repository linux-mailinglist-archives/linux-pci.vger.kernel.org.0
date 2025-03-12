Return-Path: <linux-pci+bounces-23515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBDFA5E198
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 17:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEB018961C9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535521CAA6E;
	Wed, 12 Mar 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltpF4bv2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228DF78F29;
	Wed, 12 Mar 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796162; cv=none; b=FtPomc7+o2C8VuqqBqSP3kFSj2K+UL97qu78MCp/Ml5TaoVmmCnR+F5gYBSupCEeiCvHxmeiX+NlfMqx1cTeZ8QXX9D5z38yXXypvZpVWWWljaaKvkx9EuO/ymarA2uLloHJdDI1U+CZjDI2E30emb7gT31kCz/maSQu43XjLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796162; c=relaxed/simple;
	bh=VsNryCp6Jdy8Cj9W96kO7ltsyTKRP2vUyvO8MTRIRCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K66pd0pgK5CrW+mor17LcAT4pXNe1HkKLqUDt5kApzHLxsbXY1aPJasRlx1wcPxX2xQ5s/ueiIrC4FC1hROdL4oDqjWl8MP7Lri1NzFm2Qta/1ZkkzRN0y+7wiz5yS28wgN6vsvGMnf9DBVs6+38fJ6bRfrr2IKaby5CZPInMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltpF4bv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DDDC4CEEA;
	Wed, 12 Mar 2025 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741796161;
	bh=VsNryCp6Jdy8Cj9W96kO7ltsyTKRP2vUyvO8MTRIRCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ltpF4bv2tpgig/rLF/SWUcRuVcjvjoqZTAwgDD/ab0SRZVZNFMNz/pO2uKoKFdUZ3
	 Efa7P5+PybmQOFHqmjcy+GO9MJyiAtGOYfr+mrGhlQpC7/AuJ9lGqOhXLihiXLnT/6
	 Tr/U34cIicPdZye4F1wPbcYYZNmQi9jSuLORnyM8fsy/2kkE/iVqElEgCVK/Ffm8F7
	 01PQdXAtnn/gCdy0zkV60RsSHtz2V4JgT6B5WM00VL29bZHnuFvCp8zH4ma+HBw7h6
	 J8Vcp02yuuuib4zPHSES5zqgX+d2N3xlacNeY4YPx6wiOVy8l/3OSk4Xj1JX7VN1mf
	 D+5gS6kD2oJ2Q==
Date: Wed, 12 Mar 2025 11:16:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Matt Ranostay <mranostay@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, rogerq@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250312161600.GA680640@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305132018.2260771-1-s-vadapalli@ti.com>

[+to Matt, author of e49ad667815d]

On Wed, Mar 05, 2025 at 06:50:18PM +0530, Siddharth Vadapalli wrote:
> Commit under Fixes assigned the value of 'linkdown_irq_regfield' for the
> J784S4 SoC as 'LINK_DOWN' which corresponds to BIT(1). However, according
> to the Technical Reference Manual and Register Documentation for the J784S4
> SoC [0], BIT(1) corresponds to "ENABLE_SYS_EN_PCIE_DPA_1" which is __NOT__
> the field for the link-state interrupt. Instead, it is BIT(10) of the
> "PCIE_INTD_ENABLE_REG_SYS_2" register that corresponds to the link-state
> field named as "ENABLE_SYS_EN_PCIE_LINK_STATE".

I guess the reason we want this is that on J784S4, we ignore actual
link-down interrupts (and we don't write STATUS_CLR_REG_SYS_2 to clear
the interrupt indication, so maybe there's an interrupt storm), and we
think some other interrupt (DPA_1, whatever that is) is actually a
link-down interrupt?

> Hence, set 'linkdown_irq_regfield' to the macro 'J7200_LINK_DOWN' which
> expands to BIT(10) and was first defined for the J7200 SoC. Other SoCs
> already reuse this macro since it accurately represents the link-state
> field in their respective "PCIE_INTD_ENABLE_REG_SYS_2" register.
> 
> [0]: https://www.ti.com/lit/zip/spruj52

Thanks for the spec URL.  Can you include a relevant section number?
I searched for some of this stuff but couldn't find it.

Since I have low confidence that the URL will be valid after a few
years, I wish the spec also had a human-readable name and revision
number.  But maybe the alphabet soup or "SPRUJ52D", "revised July
2024" is all we can hope for.

> Fixes: e49ad667815d ("PCI: j721e: Add TI J784S4 PCIe configuration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 48a5eed9ad58 Merge tag 'devicetree-fixes-for-6.14-2' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> of the master branch of Linux.
> 
> Patch has been tested on J784S4-EVM, validating that disconnecting an
> Endpoint Device connected to J784S4-EVM results in the following message
> on the J784S4-EVM:
> 	j721e-pcie 2900000.pcie: LINK DOWN!
> which wasn't seen earlier.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/cadence/pci-j721e.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 0341d51d6aed..1da9d9918d0d 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -376,13 +376,13 @@ static const struct j721e_pcie_data j784s4_pcie_rc_data = {
>  	.mode = PCI_MODE_RC,
>  	.quirk_retrain_flag = true,
>  	.byte_access_allowed = false,
> -	.linkdown_irq_regfield = LINK_DOWN,
> +	.linkdown_irq_regfield = J7200_LINK_DOWN,
>  	.max_lanes = 4,
>  };
>  
>  static const struct j721e_pcie_data j784s4_pcie_ep_data = {
>  	.mode = PCI_MODE_EP,
> -	.linkdown_irq_regfield = LINK_DOWN,
> +	.linkdown_irq_regfield = J7200_LINK_DOWN,
>  	.max_lanes = 4,
>  };
>  
> -- 
> 2.34.1
> 

