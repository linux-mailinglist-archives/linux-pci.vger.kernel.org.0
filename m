Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2B773C69
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjHHQFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjHHQEP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:04:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397DD2103
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 08:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0CB962411
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 07:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BCAC433C8;
        Tue,  8 Aug 2023 07:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691479569;
        bh=M0SPxHUd5hAr/xJLALVcRATPCsI99nCm47kRUi6N1b0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcI1Ya3s/9abghpUHxcz95GabocIMsmNtTmC9eNZAAlVSYSWVqMFTTBmmuKpjiWGh
         yXlNiAkTryFhNetuzot8s9WgZaFRbMfxqgFVYhg+/QBqP1JV9Kpw8S/uBzj3hhNewg
         5qm0KXrZUztRBsMr6e2y28vuwCBFs1YfMrkAUXa+6GRvA7jsJwNr49GKzc0KTbC/0z
         QdOFw+BIn6HQtJRjjhdZW4tVfvaduCVKo97qfE754ybxp7Urv2oHy5aio7h7PcP640
         tMJsuSR2GW8S+y9ThWN+TrDpkYDh/B4eKlPcVXk/KWx+2FgkRcGT6LdTgCezFVMdNX
         XrLQ00Bs6Yw5A==
Received: by pali.im (Postfix)
        id A5BE1687; Tue,  8 Aug 2023 09:26:05 +0200 (CEST)
Date:   Tue, 8 Aug 2023 09:26:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808072605.n3rjfsxuogza7qth@pali>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
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

On Friday 04 August 2023 12:35:13 Russell King (Oracle) wrote:
> Hi,
> 
> So it seems this patch got applied, but it wasn't Cc'd to
> linux-arm-kernel or anyone else, so those of us with platforms never
> had a chance to comment on it.

You have received more changes and fixes for last 2 years for these
issues and you have done **nothing**. You even not said anything.
So you are the last one who can complain here.

And I'm stopped communicating with people who do not want to communicate
with me. This is pretty normal situation and you should have think about
it. No?

> *** This change causes a regression to working setups. ***
> 
> It appears that the *only* reason this patch was proposed is to stop a
> kernel developer receiving problem reports from a set of users, but
> completely ignores that there is another group of users where this works
> fine - and thus the addition of this patch causes working setups to
> regress.

You should have come up and start solving issues. And not complaining
now.

> Because one is being bothered with problem reports is not a reason to
> mark a driver broken - and especially not doing so in a way that those
> who may be affected don't get an opportunity to comment on the patch!

You had oportunity for last two years, so stop saying untruth
information here.

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

Please do not revert it, instead start fixing problems.

I'm really fed up with people who ignores all previous emails, did
absolutely nothing in related area and start complaining that something
does not work for them.

> Thanks.
> 
> On Sat, Jan 14, 2023 at 05:41:25PM +0100, Pali Rohár wrote:
> > People are reporting that pci-mvebu.c driver does not work with recent
> > mainline kernel. There are more bugs which prevents its for daily usage.
> > So lets mark it as broken for now, until somebody would be able to fix it
> > in mainline kernel.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > ---
> > Bjorn: I would really appreciate if you take this change and send it in
> > pull request for v6.2 release. There is no reason to wait more longer.
> > 
> > 
> > I'm periodically receiving emails that driver does not work correctly
> > anymore, PCIe cards are not detected or that they crashes during boot.
> > 
> > Some of the issues are handled in patches which are waiting on the list for
> > a long time and nobody cares for them. Some others needs investigation.
> > 
> > I'm really tired in replying to those user emails as I cannot do more in
> > this area. I have asked more people for help but either there were only
> > promises without any action for more than year or simple no direction how
> > to move forward or what to do with it.
> > 
> > So mark this driver as broken. Users would see the real current state
> > and hopefully will stop reporting me old or new bugs.
> > ---
> >  drivers/pci/controller/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index 1569d9a3ada0..b4a4d84a358b 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -9,6 +9,7 @@ config PCI_MVEBU
> >  	depends on MVEBU_MBUS
> >  	depends on ARM
> >  	depends on OF
> > +	depends on BROKEN
> >  	select PCI_BRIDGE_EMUL
> >  	help
> >  	 Add support for Marvell EBU PCIe controller. This PCIe controller
> > -- 
> > 2.20.1
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
