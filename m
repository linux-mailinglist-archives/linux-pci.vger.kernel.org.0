Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED376FF87
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHDLfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 07:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHDLfY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 07:35:24 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F7E7
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 04:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cGxz3tqadrygn1tAbDFPTTYMv5xeBvHEYxcjBVByLtU=; b=iUpTH4w/NCB3oORBZyscR+sGcV
        Ln215mCf0ny2+moIZXfUJRzT6UbBSNsEfet+w/7LOdqcgRzlNgU/UOiyEITAQA/tuCtZq8pPrMRYh
        LWRxaVCGpDGjvx744/wOFCe5Z5zTolIA2lCEYv75Ij+BOymo8GpTOaxNgJephelaNtEJWQXl3rV/X
        20mupFnDpIjJOk2Ui8giejQyXfP4l1kMg91uAyQUPwBvPf1P4Iqgc3IHW3YWzfXXbWg7m+m+UG83l
        sJCsyQ+Spj46lRVTBUx1wBZiVJncFqiivClLoWMfCxXwgbWNPfVdLVuTpnhGM042J/FPHSfMlMYZy
        +b6nqmqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36828)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qRt5N-00007p-15;
        Fri, 04 Aug 2023 12:35:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qRt5N-0003wE-CE; Fri, 04 Aug 2023 12:35:13 +0100
Date:   Fri, 4 Aug 2023 12:35:13 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
References: <20230114164125.1298-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230114164125.1298-1-pali@kernel.org>
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

Hi,

So it seems this patch got applied, but it wasn't Cc'd to
linux-arm-kernel or anyone else, so those of us with platforms never
had a chance to comment on it.

*** This change causes a regression to working setups. ***

It appears that the *only* reason this patch was proposed is to stop a
kernel developer receiving problem reports from a set of users, but
completely ignores that there is another group of users where this works
fine - and thus the addition of this patch causes working setups to
regress.

Because one is being bothered with problem reports is not a reason to
mark a driver broken - and especially not doing so in a way that those
who may be affected don't get an opportunity to comment on the patch!
Also, there is _zero_ information provided on what the reported problems
actually are, so no one else can guess what these issues are.

However, given that there are working setups and this change causes
those to regress, it needs to be reverted.

For example, I have an Atheros PCIe WiFi card in an Armada 388 Clearfog
platform, and this works fine.

Uwe has a SATA controller for a bunch of disks in an Armada 370 based
NAS platform that is connected to PCIe, and removing PCIe support
effectively makes his platform utterly useless.

Please revert this patch.

Thanks.

On Sat, Jan 14, 2023 at 05:41:25PM +0100, Pali Rohár wrote:
> People are reporting that pci-mvebu.c driver does not work with recent
> mainline kernel. There are more bugs which prevents its for daily usage.
> So lets mark it as broken for now, until somebody would be able to fix it
> in mainline kernel.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Bjorn: I would really appreciate if you take this change and send it in
> pull request for v6.2 release. There is no reason to wait more longer.
> 
> 
> I'm periodically receiving emails that driver does not work correctly
> anymore, PCIe cards are not detected or that they crashes during boot.
> 
> Some of the issues are handled in patches which are waiting on the list for
> a long time and nobody cares for them. Some others needs investigation.
> 
> I'm really tired in replying to those user emails as I cannot do more in
> this area. I have asked more people for help but either there were only
> promises without any action for more than year or simple no direction how
> to move forward or what to do with it.
> 
> So mark this driver as broken. Users would see the real current state
> and hopefully will stop reporting me old or new bugs.
> ---
>  drivers/pci/controller/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 1569d9a3ada0..b4a4d84a358b 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -9,6 +9,7 @@ config PCI_MVEBU
>  	depends on MVEBU_MBUS
>  	depends on ARM
>  	depends on OF
> +	depends on BROKEN
>  	select PCI_BRIDGE_EMUL
>  	help
>  	 Add support for Marvell EBU PCIe controller. This PCIe controller
> -- 
> 2.20.1
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
