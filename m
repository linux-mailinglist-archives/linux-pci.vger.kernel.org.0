Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91ED7706AD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjHDRHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 13:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjHDRHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 13:07:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BB349E0
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 10:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36031620BC
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 17:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56641C433C8;
        Fri,  4 Aug 2023 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691168817;
        bh=PI/gZagiBqGZl2jmhjT/oBtTcKVB/5mgtIar2yRF/Bw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=itEyvAJ33H94w+vafn84Tk9Hhjm03Ya2U6P2jOKViOcGkFVQL6DgsQ72NKVafGQdi
         VqOWJnVHRjWMqIRyWqMO8ih+TtICcRPd4Eh22VP3dyaNFjUYBwuxvERiRf3yeiSaoY
         u/WVcW9oP0fUP/BeAYXWHFVkAQmS24QdsJzUEw+21LRQJYtk3wDfftqfNIr9rKaYZM
         idw2RVde+A7wXRFl4kw+2tgQ0Z++Il1SIgP1spoasuq6BAtVuVeUVRHuoUtklRlprQ
         HveNqyIxcHOk3mNz+Zw+SSarTZagYvYeBZi6onTw7UQNVtggQNEIBFv6Jeuz//W+14
         jRuFOh5iRdB4A==
Date:   Fri, 4 Aug 2023 12:06:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230804170655.GA147757@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Fri, Aug 04, 2023 at 12:35:13PM +0100, Russell King (Oracle) wrote:
> So it seems this patch got applied, but it wasn't Cc'd to
> linux-arm-kernel or anyone else, so those of us with platforms never
> had a chance to comment on it.
> 
> *** This change causes a regression to working setups. ***
> 
> It appears that the *only* reason this patch was proposed is to stop a
> kernel developer receiving problem reports from a set of users, but
> completely ignores that there is another group of users where this works
> fine - and thus the addition of this patch causes working setups to
> regress.
> 
> Because one is being bothered with problem reports is not a reason to
> mark a driver broken - and especially not doing so in a way that those
> who may be affected don't get an opportunity to comment on the patch!
> Also, there is _zero_ information provided on what the reported problems
> actually are, so no one else can guess what these issues are.
> 
> However, given that there are working setups and this change causes
> those to regress, it needs to be reverted.
> 
> For example, I have an Atheros PCIe WiFi card in an Armada 388 Clearfog
> platform, and this works fine.
> 
> Uwe has a SATA controller for a bunch of disks in an Armada 370 based
> NAS platform that is connected to PCIe, and removing PCIe support
> effectively makes his platform utterly useless.
> 
> Please revert this patch.

Sorry for the inconvenience.

I was under the mistaken impression that making the driver depend on
CONFIG_BROKEN would keep the driver available but only if the user
explicitly requested it, similar to how 
CONFIG_COMPILE_TEST works.  But obviously that's not the case, so
we'll revert the change.

I queued up the revert below, including a note in the Kconfig help
text about the known issues.

commit 814b6bb15367 ("Revert "PCI: mvebu: Mark driver as BROKEN"")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Aug 4 11:54:43 2023 -0500

    Revert "PCI: mvebu: Mark driver as BROKEN"
    
    b3574f579ece ("PCI: mvebu: Mark driver as BROKEN") made it impossible to
    enable the pci-mvebu driver.  The driver does have known problems, but as
    Russell and Uwe reported, it does work in some configurations, so removing
    it broke some working setups.
    
    Revert b3574f579ece so pci-mvebu is available.  Mention the known problems
    in the Kconfig help text.
    
    Reported-by: Russell King (Oracle) <linux@armlinux.org.uk>
    Link: https://lore.kernel.org/r/ZMzicVQEyHyZzBOc@shell.armlinux.org.uk
    Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Link: https://lore.kernel.org/r/20230804134622.pmbymxtzxj2yfhri@pengutronix.de
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8d49bad7f847..478f158b2dfb 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -179,13 +179,15 @@ config PCI_MVEBU
 	depends on MVEBU_MBUS
 	depends on ARM
 	depends on OF
-	depends on BROKEN
 	select PCI_BRIDGE_EMUL
 	help
 	 Add support for Marvell EBU PCIe controller. This PCIe controller
 	 is used on 32-bit Marvell ARM SoCs: Dove, Kirkwood, Armada 370,
 	 Armada XP, Armada 375, Armada 38x and Armada 39x.
 
+	 This driver has known problems that may cause crashes during boot
+	 and failure to detect PCIe devices in some cases.
+
 config PCIE_MEDIATEK
 	tristate "MediaTek PCIe controller"
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
