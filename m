Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2777481C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjHHT0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjHHT0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:26:03 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A85955901
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WOWVhDI4qFWUd04F12Ell7sznfPaqEvPafPQZpb6ekE=; b=jzKx6GTHBxZi8eOmub0CE4yqTB
        HyK91vKlygCDZPAcj7FZJsWhuvbFr5Zr7+4U1QGVRVBBczDjgx8IABqrOVL8a5CcoV4W2gUh+a1aG
        0yuPO6+V72wJ+LsE2Go5m7HNttQ0BYv2wZDfBBcwASDtYFhnb3f/TUvUaNx0MWF7rUb2NTKpJ+pFt
        hpUx9Kj8SjpcAtkIg5sEPLRzg0tnQRZeERDukINzuT+G/dYqLoFgxe1+gcFPxHcZJVBngdu/7sZr8
        cCxrEIJz5St1711rWLwcOVdDwR23ic5ensE+20RUnLr4NpqD8dP0xwspBgZw7Ypq+aAGfxz33+64i
        cs0AWQcA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35616)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qTI8F-0006mn-39;
        Tue, 08 Aug 2023 09:31:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qTI8G-0007vD-3i; Tue, 08 Aug 2023 09:32:00 +0100
Date:   Tue, 8 Aug 2023 09:32:00 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <ZNH9gFAC9bPmIdGg@shell.armlinux.org.uk>
References: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230804170655.GA147757@bhelgaas>
 <20230808073154.bstm3xwtjalyq3qb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808073154.bstm3xwtjalyq3qb@pali>
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

On Tue, Aug 08, 2023 at 09:31:54AM +0200, Pali Rohár wrote:
> On Friday 04 August 2023 12:06:55 Bjorn Helgaas wrote:
> > [+cc Krzysztof]
> > 
> > On Fri, Aug 04, 2023 at 12:35:13PM +0100, Russell King (Oracle) wrote:
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
> > > 
> > > Uwe has a SATA controller for a bunch of disks in an Armada 370 based
> > > NAS platform that is connected to PCIe, and removing PCIe support
> > > effectively makes his platform utterly useless.
> > > 
> > > Please revert this patch.
> > 
> > Sorry for the inconvenience.
> > 
> > I was under the mistaken impression that making the driver depend on
> > CONFIG_BROKEN would keep the driver available but only if the user
> > explicitly requested it, similar to how 
> > CONFIG_COMPILE_TEST works.  But obviously that's not the case, so
> > we'll revert the change.
> > 
> > I queued up the revert below, including a note in the Kconfig help
> > text about the known issues.
> > 
> > commit 814b6bb15367 ("Revert "PCI: mvebu: Mark driver as BROKEN"")
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Fri Aug 4 11:54:43 2023 -0500
> > 
> >     Revert "PCI: mvebu: Mark driver as BROKEN"
> >     
> >     b3574f579ece ("PCI: mvebu: Mark driver as BROKEN") made it impossible to
> >     enable the pci-mvebu driver.  The driver does have known problems, but as
> >     Russell and Uwe reported, it does work in some configurations, so removing
> >     it broke some working setups.
> >     
> >     Revert b3574f579ece so pci-mvebu is available.  Mention the known problems
> >     in the Kconfig help text.
> >     
> >     Reported-by: Russell King (Oracle) <linux@armlinux.org.uk>
> >     Link: https://lore.kernel.org/r/ZMzicVQEyHyZzBOc@shell.armlinux.org.uk
> >     Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >     Link: https://lore.kernel.org/r/20230804134622.pmbymxtzxj2yfhri@pengutronix.de
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> 
> What you are trying to achieve with this patch now? Do you think that it
> is really correct to show that everything is working for everybody
> correctly? Use a common sense here.

Common sense is not to break people's working setups. You seem to lack
that appreciation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
