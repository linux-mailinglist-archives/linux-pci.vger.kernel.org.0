Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B5E773C83
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjHHQH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjHHQFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:05:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC2F6EB5
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 08:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCEB7623E1
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 07:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D6AC433C7;
        Tue,  8 Aug 2023 07:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691479624;
        bh=EopuX5FxOKTjRTVmex9E/nn6vq8p2q0flJ/9Afje0Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5VcLB25pnQopj2fU7//BTjsc8vdqkC1hya9BwFQcm/BusSGSij+Le8yCQSUxgAJb
         Tm7CPlYMACAGjNCmEDBMu8mhk3CcsIq5rFZ11b8ZVUIEJ+O0J1wd/rZeaxWf/spvvV
         sNvPKzjP77A+63Lbxo9SEiRimJeMNsHH4ySXdbRA3HgNg3Dz5tsmeI6/g5QRvHG9PB
         R/nQumrQK4PhKg2Wy03J8yP73ObtMSloz0qKV9Yo3pJEY0VX2tno3SA2VLWDrTA70i
         uIKS10//hwcHDmpnfVurgB/RTkCV5X12biAachNswg6QJEKt0HijcZCyn61ZYk2Xrb
         A8S8vL8yCFXBA==
Received: by pali.im (Postfix)
        id 6B1C7687; Tue,  8 Aug 2023 09:27:01 +0200 (CEST)
Date:   Tue, 8 Aug 2023 09:27:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808072701.gx6apjnnrppv7sit@pali>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230804134622.pmbymxtzxj2yfhri@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230804134622.pmbymxtzxj2yfhri@pengutronix.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 04 August 2023 15:46:22 Uwe Kleine-König wrote:
> [Cc += linux-arm-kernel list]
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
> 
> While this is true there is really a problem on my platform with
> accessing the hard disks via that pci controller and a 88SE9215 SATA
> controller. While it seems to work in principle, it's incredible slow.

Exactly those are things which randomly does not work.

> I intend to bisect that, 6.1.x is still fine. Don't know when I find the
> time though, as there are a few things that are more important
> currently.
> 
> +1 on some information about what is already known about the breakage.
> 
> > Please revert this patch.
> > 
> > Thanks.
> > 
> > On Sat, Jan 14, 2023 at 05:41:25PM +0100, Pali Rohár wrote:
> > > People are reporting that pci-mvebu.c driver does not work with recent
> > > mainline kernel. There are more bugs which prevents its for daily usage.
> > > So lets mark it as broken for now, until somebody would be able to fix it
> > > in mainline kernel.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > ---
> > > Bjorn: I would really appreciate if you take this change and send it in
> > > pull request for v6.2 release. There is no reason to wait more longer.
> > > 
> > > 
> > > I'm periodically receiving emails that driver does not work correctly
> > > anymore, PCIe cards are not detected or that they crashes during boot.
> > > 
> > > Some of the issues are handled in patches which are waiting on the list for
> > > a long time and nobody cares for them. Some others needs investigation.
> > > 
> > > I'm really tired in replying to those user emails as I cannot do more in
> > > this area. I have asked more people for help but either there were only
> > > promises without any action for more than year or simple no direction how
> > > to move forward or what to do with it.
> > > 
> > > So mark this driver as broken. Users would see the real current state
> > > and hopefully will stop reporting me old or new bugs.
> > > ---
> > >  drivers/pci/controller/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > index 1569d9a3ada0..b4a4d84a358b 100644
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -9,6 +9,7 @@ config PCI_MVEBU
> > >  	depends on MVEBU_MBUS
> > >  	depends on ARM
> > >  	depends on OF
> > > +	depends on BROKEN
> > >  	select PCI_BRIDGE_EMUL
> > >  	help
> > >  	 Add support for Marvell EBU PCIe controller. This PCIe controller
> > > -- 
> > > 2.20.1
> > > 
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> > 
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


