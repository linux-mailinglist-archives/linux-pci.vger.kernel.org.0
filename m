Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ECD476369
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 21:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhLOUge (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 15:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhLOUge (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 15:36:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27220C061574;
        Wed, 15 Dec 2021 12:36:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8055461A94;
        Wed, 15 Dec 2021 20:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBCBC36AE2;
        Wed, 15 Dec 2021 20:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639600592;
        bh=w2ji66cDZOpUYJpMi0FUwoBY9Q0VZyx0B3jj/5yMIbs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BIfeti0DoVI0rsV0OMLLXebcFMjGL3E829uWJ8pSaGnmjDRhMhaDd53aozQ4x+k2j
         /WR5QFnST7gvwRZX11AiAwKcGaNmo0HZEFTpaYVy/8KiynTKghpF8VOY3bYwWZsvE5
         9YRvTj8/dBE+qEOxccw8Bd6Hoe+cbiXeebr8Wg2toJEPgKxXgn6o19WQg5WXdAEuYX
         IpRE4M2A7ibg91c/Kv5F2kIdLdztinALfjiTHMpqx8uDRzrf9wlGKSbQBkQ5h33dPa
         a/EWhLeHV4dMkY+Byas3EZK5nsZ7IBW7HlzNd7h+BR1KUr0KZGR5LrTUJkHr5jsqV0
         auS/I8fZ4JQ9A==
Date:   Wed, 15 Dec 2021 14:36:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sam Bingner <sam@bingner.com>, linux-pci@vger.kernel.org,
        trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] PCI: Add func1 DMA quirk for Marvell 88SE9125
 SATA controller
Message-ID: <20211215203631.GA710012@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YahpKVR+McJVDdkD@work>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 06:35:21AM +0000, Yifeng Li wrote:
> Like other SATA controller chips in the Marvell 88SE91xx series, the
> Marvell 88SE9125 has the same DMA requester ID hardware bug that prevents
> it from working under IOMMU. This patch adds its device ID 0x9125 to the
> Function 1 DMA alias quirk list.
> 
> This patch should not be confused with an earlier patch, commit 059983790a4c
> ("PCI: Add function 1 DMA alias quirk for Marvell 9215 SATA controller"),
> which applies to a different chip with a similar model number, 88SE9215.
> 
> Without this patch, device initialization fails with DMA errors.
> 
>     ata8: softreset failed (1st FIS failed)
>     DMAR: DRHD: handling fault status reg 2
>     DMAR: [DMA Write NO_PASID] Request device [03:00.1] fault addr 0xfffc0000 [fault reason 0x02] Present bit in context entry is clear
>     DMAR: DRHD: handling fault status reg 2
>     DMAR: [DMA Read NO_PASID] Request device [03:00.1] fault addr 0xfffc0000 [fault reason 0x02] Present bit in context entry is clear
> 
> After applying the patch, the controller can be successfully initialized.
> 
>     ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 330)
>     ata8.00: ATAPI: PIONEER BD-RW   BDR-207M, 1.21, max UDMA/100
>     ata8.00: configured for UDMA/100
>     scsi 7:0:0:0: CD-ROM            PIONEER  BD-RW   BDR-207M 1.21 PQ: 0 ANSI: 5
> 
> Cc: stable@vger.kernel.org
> Reported-by: Sam Bingner <sam@bingner.com>
> Tested-by: Sam Bingner <sam@bingner.com>
> Tested-by: Yifeng Li <tomli@tomli.me>
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

I tweaked the subject line to match similar previous commits and
applied to pci/virtualization for v5.17, thanks!

  e44537588288 ("PCI: Add function 1 DMA alias quirk for Marvell 88SE9125 SATA controller")
  059983790a4c ("PCI: Add function 1 DMA alias quirk for Marvell 9215 SATA controller")
  9cde402a5977 ("PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller")
  7695e73f3db4 ("PCI: Add function 1 DMA alias quirk for Marvell 88SS9183")
  1903be8222b7 ("PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L")
  832e4e1f76b8 ("PCI: Add function 1 DMA alias quirk for Marvell 88SE9220")
  aa0082066343 ("PCI: Add function 1 DMA alias quirk for Marvell 9128")
  00456b35a527 ("PCI: Add function 1 DMA alias quirk for Marvell 88SE9182")

> ---
> 
> Notes:
>     v3: Use full names in Reported-by and Tested-by tags.
>     
>     v2: I accidentally sent an earlier version of the commit without
>     CCing stable@vger.kernel.org. The mail itself was also rejected by
>     many servers due to a DKIM issue. Thus [PATCH v2], sorry for the
>     noise.
> 
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 003950c73..20a932690 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4103,6 +4103,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9120,
>  			 quirk_dma_func1_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
>  			 quirk_dma_func1_alias);
> +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c136 */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9125,
> +			 quirk_dma_func1_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
>  			 quirk_dma_func1_alias);
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
> -- 
> 2.31.1
