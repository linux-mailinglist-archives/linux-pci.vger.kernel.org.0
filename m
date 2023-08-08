Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8837F773E40
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjHHQ1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjHHQ0R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F2D136
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 08:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CCAB60202
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 07:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA52C433C7;
        Tue,  8 Aug 2023 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691479917;
        bh=ATs2f06VXRPuOGQ04L+DaPWovVdeFCFuKK9xzmYIC14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0ruxBMeU2doqFZn7yfljKGPTEdRD1aFxvsrZirlwWztN0RumGl1w8cunoA5kHL/y
         lmCGn/IJSjONQMUWptmZXnE9TCxpfjLRGYwaMn7hg77wr/Dbbj/HNUALFAWGn6KUR3
         GgVb5hKH7B9mhY0SrfjKXSgmivKBTaJvVDsA4bVV4cdQ+jcTAWH/SXJmOkpVUB/njD
         1YQvm3COA9B6dguuHgl2Xc54fjYoGoBEthEnBUH5v+HZ1vEzZF5BnKHmv8KRc6cIbm
         Ls4kLkW5qHgUTENS9hKRnqS3DPcSynSXaRr2yeZ2GPhH7ZRicquvlqaTOFtrNp0JXd
         nkOZ33jUFdjQw==
Received: by pali.im (Postfix)
        id 8F91F687; Tue,  8 Aug 2023 09:31:54 +0200 (CEST)
Date:   Tue, 8 Aug 2023 09:31:54 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808073154.bstm3xwtjalyq3qb@pali>
References: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230804170655.GA147757@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230804170655.GA147757@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 04 August 2023 12:06:55 Bjorn Helgaas wrote:
> [+cc Krzysztof]
> 
> On Fri, Aug 04, 2023 at 12:35:13PM +0100, Russell King (Oracle) wrote:
> > So it seems this patch got applied, but it wasn't Cc'd to
> > linux-arm-kernel or anyone else, so those of us with platforms never
> > had a chance to comment on it.
> > 
> > *** This change causes a regression to working setups. ***
> > 
> > It appears that the *only* reason this patch was proposed is to stop a
> > kernel developer receiving problem reports from a set of users, but
> > completely ignores that there is another group of users where this works
> > fine - and thus the addition of this patch causes working setups to
> > regress.
> > 
> > Because one is being bothered with problem reports is not a reason to
> > mark a driver broken - and especially not doing so in a way that those
> > who may be affected don't get an opportunity to comment on the patch!
> > Also, there is _zero_ information provided on what the reported problems
> > actually are, so no one else can guess what these issues are.
> > 
> > However, given that there are working setups and this change causes
> > those to regress, it needs to be reverted.
> > 
> > For example, I have an Atheros PCIe WiFi card in an Armada 388 Clearfog
> > platform, and this works fine.
> > 
> > Uwe has a SATA controller for a bunch of disks in an Armada 370 based
> > NAS platform that is connected to PCIe, and removing PCIe support
> > effectively makes his platform utterly useless.
> > 
> > Please revert this patch.
> 
> Sorry for the inconvenience.
> 
> I was under the mistaken impression that making the driver depend on
> CONFIG_BROKEN would keep the driver available but only if the user
> explicitly requested it, similar to how 
> CONFIG_COMPILE_TEST works.  But obviously that's not the case, so
> we'll revert the change.
> 
> I queued up the revert below, including a note in the Kconfig help
> text about the known issues.
> 
> commit 814b6bb15367 ("Revert "PCI: mvebu: Mark driver as BROKEN"")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Aug 4 11:54:43 2023 -0500
> 
>     Revert "PCI: mvebu: Mark driver as BROKEN"
>     
>     b3574f579ece ("PCI: mvebu: Mark driver as BROKEN") made it impossible to
>     enable the pci-mvebu driver.  The driver does have known problems, but as
>     Russell and Uwe reported, it does work in some configurations, so removing
>     it broke some working setups.
>     
>     Revert b3574f579ece so pci-mvebu is available.  Mention the known problems
>     in the Kconfig help text.
>     
>     Reported-by: Russell King (Oracle) <linux@armlinux.org.uk>
>     Link: https://lore.kernel.org/r/ZMzicVQEyHyZzBOc@shell.armlinux.org.uk
>     Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>     Link: https://lore.kernel.org/r/20230804134622.pmbymxtzxj2yfhri@pengutronix.de
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 

What you are trying to achieve with this patch now? Do you think that it
is really correct to show that everything is working for everybody
correctly? Use a common sense here.

Or this is a way how kernel people are fixing bugs?

Now I'm starting understand why majority of HW industry say to not use
"unsupported mainline kernel" and instead use our prepared patched
kernels...

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 8d49bad7f847..478f158b2dfb 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -179,13 +179,15 @@ config PCI_MVEBU
>  	depends on MVEBU_MBUS
>  	depends on ARM
>  	depends on OF
> -	depends on BROKEN
>  	select PCI_BRIDGE_EMUL
>  	help
>  	 Add support for Marvell EBU PCIe controller. This PCIe controller
>  	 is used on 32-bit Marvell ARM SoCs: Dove, Kirkwood, Armada 370,
>  	 Armada XP, Armada 375, Armada 38x and Armada 39x.
>  
> +	 This driver has known problems that may cause crashes during boot
> +	 and failure to detect PCIe devices in some cases.
> +
>  config PCIE_MEDIATEK
>  	tristate "MediaTek PCIe controller"
>  	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
