Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05836463C77
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbhK3RHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhK3RHm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:07:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A582C061574;
        Tue, 30 Nov 2021 09:04:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5E2B0CE1849;
        Tue, 30 Nov 2021 17:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ADDC53FC1;
        Tue, 30 Nov 2021 17:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638291859;
        bh=cSn+Ep2v0SL7KJfHgs3j8RbhQX+lAo4RdrTIDkGPmpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Elt8UquEZNJJ2xkFTrhIXggTrDjb06fXulzTul/7jMrtjYrVoY1BmQpxzElEPWVoN
         D674Vs+yNHUj/afbrEtFhlZae3ZKDIzJeizf6P4yLxh2hengfZTT3kAB9DWW0jVWDo
         X/08374AsvWJBB9H6JjCtA+NpIBaaJ7vBdd4Ie1pRjsphOo9v+EDEjskDIuWN3WK/o
         NBrdwA3e80xuOIx5JlJMTpfkTuY3ML0NXqMCqy7n81cparGcHGdrWwtB73JAu3Uhqk
         TIpoMRvQcNgfdToZDG/PXj8ilkSjy82LD3zgx+gsGXv66QAzwKxtC5zvpms/vdTDxt
         7jR3WGiIJuBWA==
Date:   Tue, 30 Nov 2021 11:04:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     nsaenz@kernel.org, jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a
 plain 'unsigned long'
Message-ID: <20211130170417.GA2744534@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 07, 2021 at 09:32:58AM +0100, Christophe JAILLET wrote:
> The 'used' field of 'struct brcm_msi' is used as a bitmap. So it should
> be declared as so (i.e. unsigned long *).
> 
> This fixes an harmless Coverity warning about array vs singleton usage.
> 
> This bitmap can be BRCM_INT_PCI_MSI_LEGACY_NR or BRCM_INT_PCI_MSI_NR long.
> So, while at it, document it, should it help someone in the future.
> 
> Addresses-Coverity: "Out-of-bounds access (ARRAY_VS_SINGLETON)"
> Suggested-by: Krzysztof Wilczynski <kw@linux.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The BUILD_BUG_ON is surely a bit to much of paranoia :)
> 
> I'm also not really pleased about the layout of the DECLARE_BITMAP. This
> looks odd, but I couldn't find something nicer :(
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 1fc7bd49a7ad..15d394ac7478 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -266,8 +266,9 @@ struct brcm_msi {
>  	struct mutex		lock; /* guards the alloc/free operations */
>  	u64			target_addr;
>  	int			irq;
> -	/* used indicates which MSI interrupts have been alloc'd */
> -	unsigned long		used;
> +	/* Used indicates which MSI interrupts have been alloc'd. 'nr' bellow is
> +	   the real size of the bitmap. It depends on the chip. */

I hate to bike-shed this even more, but IMO we should just drop the
comment above completely.  It's not the usual commenting style, no
other drivers provide similar explanation, and "below" is misspelled,
which will lead to a future fixup patch.

> +	DECLARE_BITMAP		(used, BRCM_INT_PCI_MSI_NR);
>  	bool			legacy;
>  	/* Some chips have MSIs in bits [31..24] of a shared register. */
>  	int			legacy_shift;
> @@ -534,7 +535,7 @@ static int brcm_msi_alloc(struct brcm_msi *msi)
>  	int hwirq;
>  
>  	mutex_lock(&msi->lock);
> -	hwirq = bitmap_find_free_region(&msi->used, msi->nr, 0);
> +	hwirq = bitmap_find_free_region(msi->used, msi->nr, 0);
>  	mutex_unlock(&msi->lock);
>  
>  	return hwirq;
> @@ -543,7 +544,7 @@ static int brcm_msi_alloc(struct brcm_msi *msi)
>  static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq)
>  {
>  	mutex_lock(&msi->lock);
> -	bitmap_release_region(&msi->used, hwirq, 0);
> +	bitmap_release_region(msi->used, hwirq, 0);
>  	mutex_unlock(&msi->lock);
>  }
>  
> @@ -661,6 +662,12 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
>  	msi->irq = irq;
>  	msi->legacy = pcie->hw_rev < BRCM_PCIE_HW_REV_33;
>  
> +	/*
> +	 * Sanity check to make sure that the 'used' bitmap in struct brcm_msi
> +	 * is large enough.
> +	 */
> +	BUILD_BUG_ON(BRCM_INT_PCI_MSI_LEGACY_NR > BRCM_INT_PCI_MSI_NR);
> +
>  	if (msi->legacy) {
>  		msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
>  		msi->nr = BRCM_INT_PCI_MSI_LEGACY_NR;
> -- 
> 2.30.2
> 
