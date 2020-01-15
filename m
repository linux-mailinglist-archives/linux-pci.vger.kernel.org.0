Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613FF13CAB4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAOROX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 12:14:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbgAOROX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:14:23 -0500
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 016A9214AF;
        Wed, 15 Jan 2020 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579108463;
        bh=SQJm7DfTXV/H8rTX2xiaCsVfM41XVr6lC9di9L4B7BM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mSLC4peGqPVqdbaszsk6TYlHYhuXP/CDxCZvLtMq3dj+YTcLQuboT6uPvlSdqQ6iJ
         EM16jhMvudLSQxydu7wzdEm/hfaMMgOxN2mHTdi74Yqi0ktn7ARFRIJL2boEA8L9M5
         ZD9PH1JaZ8okseU+VeXC9eVr7lcyLiWq6tOxZotA=
Date:   Wed, 15 Jan 2020 11:14:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 0/2] Adjust AMD GPU ATS quirks
Message-ID: <20200115171421.GA174505@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114234144.GA56595@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 05:41:44PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 14, 2020 at 03:55:21PM -0500, Alex Deucher wrote:
> > We've root caused the issue and clarified the quirk.
> > This also adds a new quirk for a new GPU.
> > 
> > Alex Deucher (2):
> >   pci: Clarify ATS quirk
> >   pci: add ATS quirk for navi14 board (v2)
> > 
> >  drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
> >  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> I propose the following, which I intend to be functionally identical.
> It just doesn't repeat the pci_info() and pdev->ats_cap = 0.

Applied to pci/misc for v5.6, thanks!

> commit 998c4f7975b0 ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Jan 14 17:09:28 2020 -0600
> 
>     PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken
>     
>     To account for parts of the chip that are "harvested" (disabled) due to
>     silicon flaws, caches on some AMD GPUs must be initialized before ATS is
>     enabled.
>     
>     ATS is normally enabled by the IOMMU driver before the GPU driver loads, so
>     this cache initialization would have to be done in a quirk, but that's too
>     complex to be practical.
>     
>     For Navi14 (device ID 0x7340), this initialization is done by the VBIOS,
>     but apparently some boards went to production with an older VBIOS that
>     doesn't do it.  Disable ATS for those boards.
>     
>     https://lore.kernel.org/r/20200114205523.1054271-3-alexander.deucher@amd.com
>     Bug: https://gitlab.freedesktop.org/drm/amd/issues/1015
>     See-also: d28ca864c493 ("PCI: Mark AMD Stoney Radeon R7 GPU ATS as broken")
>     See-also: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4937a088d7d8..fbeb9f73ef28 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5074,18 +5074,25 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>  
>  #ifdef CONFIG_PCI_ATS
>  /*
> - * Some devices have a broken ATS implementation causing IOMMU stalls.
> - * Don't use ATS for those devices.
> + * Some devices require additional driver setup to enable ATS.  Don't use
> + * ATS for those devices as ATS will be enabled before the driver has had a
> + * chance to load and configure the device.
>   */
> -static void quirk_no_ats(struct pci_dev *pdev)
> +static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
>  {
> -	pci_info(pdev, "disabling ATS (broken on this device)\n");
> +	if (pdev->device == 0x7340 && pdev->revision != 0xc5)
> +		return;
> +
> +	pci_info(pdev, "disabling ATS\n");
>  	pdev->ats_cap = 0;
>  }
>  
>  /* AMD Stoney platform GPU */
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
> +/* AMD Iceland dGPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
> +/* AMD Navi14 dGPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
>  #endif /* CONFIG_PCI_ATS */
>  
>  /* Freescale PCIe doesn't support MSI in RC mode */
