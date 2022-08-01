Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2E5873A2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 23:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiHAV41 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 17:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiHAV40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 17:56:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2DE1A83C;
        Mon,  1 Aug 2022 14:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7D1B60C0B;
        Mon,  1 Aug 2022 21:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C686FC433C1;
        Mon,  1 Aug 2022 21:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659390985;
        bh=B8TBmWZcZntHxEEgKroTXVo9xYKk6rkYy+2Rcuto/vY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DgbnX0X3sB8Oe/KHOKQSVWGc9ZLpjpqf/9EL9dqBj4k4D8pMVp8jBXJ9jiJEfxihr
         IQKjkhHXOrJE/ke3bLWMKBKczCWM/npxoyouZM4LLOElt0KUiX8jXjmY/8bPxXGh+W
         jb11Wfc+G6E6dWf8GONhMRIa9Xt8VuPlvIfCY5GT3kMSbewulnCqh+FqZwBhu1TGy2
         okpcxz4F1onsRMzOGkwC/3FXb2jVJG08t6LSiuBLd0A1ATNWMjBNqnA9KG20htlP7Y
         +soGHnTXMql+7Gm3VHHk1SP1GKxFcmhzMVe64ZLJpjy0GZyqQr/vdIAULoznTVjL98
         6AwN++KEv0YEw==
Date:   Mon, 1 Aug 2022 16:56:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] PCI: eliminate abnormal characters when reads help
 information of "PCI_P2PDMA" under menuconfig
Message-ID: <20220801215623.GA676484@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220720172328.GA1647083@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 12:23:29PM -0500, Bjorn Helgaas wrote:
> [+cc Andy, Joe, possible checkpatch question]
> 
> On Wed, Jul 20, 2022 at 03:22:03PM +0800, Liu Song wrote:
> > From: Liu Song <liusong@linux.alibaba.com>
> > 
> > Read the help information of PCI_P2PDMA through make menuconfig,
> > "Enables" is partially displayed as garbled characters, so fix it.
> > 
> > Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> > ---
> >  drivers/pci/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 133c732..8102b78 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -166,7 +166,7 @@ config PCI_P2PDMA
> >  	depends on ZONE_DEVICE
> >  	select GENERIC_ALLOCATOR
> >  	help
> > -	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> > +	  Enables drivers to do PCI peer-to-peer transactions to and from
> 
> I see this problem ("Enables" renders as "Enable ~U" because the "s"
> is actually UTF-8 D195, CYRILLIC SMALL LETTER DZE).
> 
> "file" found the following other Kconfig files that also contain
> UTF-8:
> 
>   drivers/pci/Kconfig
>     D195 CYRILLIC SMALL LETTER DZE, which looks like "s"
>     "Enables" renders as "Enable ~U"
>   net/netfilter/ipvs/Kconfig
>     C2A0 NO-BREAK SPACE
>     renders fine
>   drivers/mtd/nand/raw/Kconfig
>     MTD_NAND_CAFE  C389 LATIN CAPITAL LETTER E WITH ACUTE
>     "CAFÉ" renders as "CAF ~I"
>   drivers/mtd/spi-nor/Kconfig
>     MTD_SPI_NOR_USE_4K_SECTORS
>     "16 × 4 KiB" renders as "16  ~W 4 KiB"
>   drivers/net/can/usb/Kconfig
>   drivers/net/can/peak_canfd/Kconfig
>   drivers/gpu/drm/panel/Kconfig
>   drivers/platform/mellanox/Kconfig
>   kernel/time/Kconfig
>   crypto/Kconfig
>   arch/Kconfig
> 
> Some of these are clearly wrong (Cyrillic letter), some are
> unnecessary (non-breakable space), some are arguable ("CAFÉ" and "16 ×
> 4 KiB" -- these take advantage of UTF-8 in useful ways).
> 
> Not being a charset guru, I dunno if the rendering problem means
> my terminal is set incorrectly or if they all need to be changed.
> 
> But I think we should address all of them at the same time.  If we do
> need to avoid UTF-8 in Kconfig help, maybe checkpatch should look for
> it.

Any progress on this problem?  I certainly agree that it should be
fixed; I would just like to fix all the problems, not just the PCI
one.

Bjorn
