Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3534D7703A0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjHDOyj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHDOyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 10:54:38 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B38CAC
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dF1m+xi9hK5dAK5/Njs60e2rNOE7VFj7wfZlwI2Oe2o=; b=vxQQNBEwn9UUKvBd6Mgb35Mo7a
        7wZv5OziPh+A8OeUl85Pc++8G4e2E8EN9qCZDo7+8oo2yjjoaxxC4ZGO9xY8hcyS/u4HpNifCzASK
        H91WcQAonCwXNeGtkiLiZH41DbvxmnJpE5mQcsF3bGiojx+IxVji7z6EwZLx9goklYsu2u1iK8IqV
        nVbi2yDYLuxmlgirlt6DyEM/uPMekVZy3iXyezxUv24nRadtvYpEFrupp9jst+kGepsCUKTCOUfW4
        s64729ISzG7HHx6Zuif/EFpsaE4qtxKoS/6fubsN1goGIlK+vjI23E/flDn/H7YybqVex3J3XPfuI
        QX3vAbdQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40900)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qRwCA-0000LG-0d;
        Fri, 04 Aug 2023 15:54:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qRwCA-00044Q-7e; Fri, 04 Aug 2023 15:54:26 +0100
Date:   Fri, 4 Aug 2023 15:54:26 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <ZM0RIheSZKiImCsz@shell.armlinux.org.uk>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
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

On Fri, Aug 04, 2023 at 12:35:13PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
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

Further testing - same platform with a mini-PCIe SATA card:

01:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 01)

with a WD10JPVX-60JC3T0 2.5" drive with hdparm -t:

 Timing buffered disk reads: 344 MB in  3.01 seconds = 114.16 MB/sec

which is about what is expected for spinny-rust 2.5" drives.

This was tested with ASPM and AER disabled. AER isn't supported anyway
as pcie_init_service_irqs() fails with -ENODEV.

For further info, the Atheros WiFi card was:

02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
