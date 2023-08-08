Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266DB77481D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHHT0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjHHT0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:26:03 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25A680A4
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MK5zDI7GKxBGQF2O82h2PZoOlsy0J6Y7t9dGNZiaLJc=; b=t5vExVbHYOc54lF3Fwyd6O+wG4
        Bh4u5szVlZFpyRzYZiDIwxMdwlVr4gV2F98TResqhGKp2Qo7qK/4ucNy/ZN3f0qUApnplEFvC1RxB
        qYTznAAFXxoWEtyqNBYDTQozAbYeCxpewupYLYPVh2voPLFfBf4YAjY77McqKpMv2g+5A4MgNtbdI
        XB9RSftsKS/ZIWddQEjvksyfRMa9arqhD1uTmaN3AJZ/C2WRRL0xVdDmZJaHrdVM9ZulEVh3sukVx
        aFLPfwIKaysZ+5Q2hPeVHtGIt6URCUp+kjncCx2EX8kzxR740qPlX70LSOrKZREyyKd8qzothNL/E
        71zgEQew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34180)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qTI7R-0006mF-2d;
        Tue, 08 Aug 2023 09:31:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qTI7S-0007v6-0s; Tue, 08 Aug 2023 09:31:10 +0100
Date:   Tue, 8 Aug 2023 09:31:09 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <ZNH9TbVpUYVGQwqz@shell.armlinux.org.uk>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <ZM0RIheSZKiImCsz@shell.armlinux.org.uk>
 <20230808072740.bn6ketsfatxw55ge@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808072740.bn6ketsfatxw55ge@pali>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 09:27:40AM +0200, Pali Rohár wrote:
> On Friday 04 August 2023 15:54:26 Russell King (Oracle) wrote:
> > On Fri, Aug 04, 2023 at 12:35:13PM +0100, Russell King (Oracle) wrote:
> > > Hi,
> > > 
> > > So it seems this patch got applied, but it wasn't Cc'd to
> > > linux-arm-kernel or anyone else, so those of us with platforms never
> > > had a chance to comment on it.
> > > 
> > > *** This change causes a regression to working setups. ***
> > > 
> > > It appears that the *only* reason this patch was proposed is to stop a
> > > kernel developer receiving problem reports from a set of users, but
> > > completely ignores that there is another group of users where this works
> > > fine - and thus the addition of this patch causes working setups to
> > > regress.
> > > 
> > > Because one is being bothered with problem reports is not a reason to
> > > mark a driver broken - and especially not doing so in a way that those
> > > who may be affected don't get an opportunity to comment on the patch!
> > > Also, there is _zero_ information provided on what the reported problems
> > > actually are, so no one else can guess what these issues are.
> > > 
> > > However, given that there are working setups and this change causes
> > > those to regress, it needs to be reverted.
> > > 
> > > For example, I have an Atheros PCIe WiFi card in an Armada 388 Clearfog
> > > platform, and this works fine.
> > 
> > Further testing - same platform with a mini-PCIe SATA card:
> > 
> > 01:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 01)
> > 
> > with a WD10JPVX-60JC3T0 2.5" drive with hdparm -t:
> > 
> >  Timing buffered disk reads: 344 MB in  3.01 seconds = 114.16 MB/sec
> > 
> > which is about what is expected for spinny-rust 2.5" drives.
> > 
> > This was tested with ASPM and AER disabled. AER isn't supported anyway
> > as pcie_init_service_irqs() fails with -ENODEV.
> 
> So another thing which is broken. Perfect!

No, not broken. There has never been AER because (a) historically the
PCI config reg emulation didn't allow access, and (b) there are _no_
interrupts for this stuff. The reason pcie_init_service_irqs() fails
is because of that.

This is not something that needs fixing. As far as I can see, we do
*not* have the information to support AER.

That does not mean we need to fix it. If we don't have the information,
the feature is not supported. And it's fine that the kernel fails to
initialise the feature.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
