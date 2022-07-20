Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1249B57BC89
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 19:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiGTRXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGTRXb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 13:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720DA62489;
        Wed, 20 Jul 2022 10:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F4C360A6D;
        Wed, 20 Jul 2022 17:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F827C3411E;
        Wed, 20 Jul 2022 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658337809;
        bh=l64eNEL01LL7AhwbuDc6ZfskIyioKtZYaB4s9mZGuxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YF+iVRp3FgEJiLnhxHApOdIjZhUT0lJw0k4AwBXwcAUpmrIzHmOFApJ+HFTbpl0Wi
         /CSrc/Y1G/R/xwEdaJJqnb/xZEqxQQAj+1wfmu/v/CIGZIxVBq9g90CJTpLeDNfTh9
         9lVTbSv3USzWlVmT/Lz9j4/4puaVt4stzD25yc1AELlqbKZ+xnpc6lKcsQbfuftBq6
         5nBqUBncE9Vp+VmVm68yyyiYINzKlYUHr/GP2aghFxpWC8IHlci6MlS0aTAj1KkyHJ
         ezg65EeNKmtC8+P8hyWVJPHLNxQEso0ENSMuq36P+YaiNJGf1s/xeNmzuNtqZ8PoIi
         JJhFr4s/XLHAA==
Date:   Wed, 20 Jul 2022 12:23:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] PCI: eliminate abnormal characters when reads help
 information of "PCI_P2PDMA" under menuconfig
Message-ID: <20220720172328.GA1647083@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1658301723-111283-1-git-send-email-liusong@linux.alibaba.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Andy, Joe, possible checkpatch question]

On Wed, Jul 20, 2022 at 03:22:03PM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> Read the help information of PCI_P2PDMA through make menuconfig,
> "Enables" is partially displayed as garbled characters, so fix it.
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> ---
>  drivers/pci/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 133c732..8102b78 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -166,7 +166,7 @@ config PCI_P2PDMA
>  	depends on ZONE_DEVICE
>  	select GENERIC_ALLOCATOR
>  	help
> -	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> +	  Enables drivers to do PCI peer-to-peer transactions to and from

I see this problem ("Enables" renders as "Enable ~U" because the "s"
is actually UTF-8 D195, CYRILLIC SMALL LETTER DZE).

"file" found the following other Kconfig files that also contain
UTF-8:

  drivers/pci/Kconfig
    D195 CYRILLIC SMALL LETTER DZE, which looks like "s"
    "Enables" renders as "Enable ~U"
  net/netfilter/ipvs/Kconfig
    C2A0 NO-BREAK SPACE
    renders fine
  drivers/mtd/nand/raw/Kconfig
    MTD_NAND_CAFE  C389 LATIN CAPITAL LETTER E WITH ACUTE
    "CAFÉ" renders as "CAF ~I"
  drivers/mtd/spi-nor/Kconfig
    MTD_SPI_NOR_USE_4K_SECTORS
    "16 × 4 KiB" renders as "16  ~W 4 KiB"
  drivers/net/can/usb/Kconfig
  drivers/net/can/peak_canfd/Kconfig
  drivers/gpu/drm/panel/Kconfig
  drivers/platform/mellanox/Kconfig
  kernel/time/Kconfig
  crypto/Kconfig
  arch/Kconfig

Some of these are clearly wrong (Cyrillic letter), some are
unnecessary (non-breakable space), some are arguable ("CAFÉ" and "16 ×
4 KiB" -- these take advantage of UTF-8 in useful ways).

Not being a charset guru, I dunno if the rendering problem means
my terminal is set incorrectly or if they all need to be changed.

But I think we should address all of them at the same time.  If we do
need to avoid UTF-8 in Kconfig help, maybe checkpatch should look for
it.

>  	  BARs that are exposed in other devices that are the part of
>  	  the hierarchy where peer-to-peer DMA is guaranteed by the PCI
>  	  specification to work (ie. anything below a single PCI bridge).
> -- 
> 1.8.3.1
> 
