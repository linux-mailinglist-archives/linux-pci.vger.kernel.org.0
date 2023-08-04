Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D121770932
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 21:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHDTp3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 15:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHDTpJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 15:45:09 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77624E4C
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=puyNdtSXLHFYf0O0Kws+tLjbZBlKkYYzNtYKM1xJxHQ=; b=hYexmqyjJY09lspCAqBIpmBHTc
        PCFsUCtiCuKTzkNIjvh4j6m+xWskkRjCbiWhcsdNzDU3DTzeOzc7Aks6VdmVbrpUh+C/x0j8esl+I
        whM80uICzrVyKf5HAjPyppUwi06Gt3N2G03Yf+abfyJQ5iVbCkMz/BBnXrBm+ZTz5/EGqC5NT+qJg
        RLQU/UT4NRw1gnr3u9kPrKkMrv3dpzXAdFakn4Qv1BNwer25rkpCgyGDFFEHbrwiRFSerLBxPW9tt
        UvIt0KCdY6stA5oXBGwU8M0TbJIh6pbcFzaXlY7pO4Ilig8+zwsb0vsUU2Sg9d+q3yF0XZdujqCV+
        o6PLdM8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48714)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qS0jG-0000ea-1b;
        Fri, 04 Aug 2023 20:44:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qS0jG-0004Gl-31; Fri, 04 Aug 2023 20:44:54 +0100
Date:   Fri, 4 Aug 2023 20:44:54 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <ZM1VNv6QMCD+Clqr@shell.armlinux.org.uk>
References: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230804170655.GA147757@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804170655.GA147757@bhelgaas>
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

On Fri, Aug 04, 2023 at 12:06:55PM -0500, Bjorn Helgaas wrote:
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

CONFIG_BROKEN isn't something that can be enabled without editing
init/Kconfig, since the option does not have a prompt:

config BROKEN
        bool

Marking something as "depends on BROKEN" prevents it appearing in
Kconfig, and thus makes it unselectable. It's effectively one step
away from deleting the code.

As we don't know what the problems were, I would not suggest updating
the Kconfig text - we don't know whether they were boot time crashes,
boot hangs, or failures for the link to come up with the device making
some PCIe devices undetectable.

Given that it does work fine for Uwe and myself, it suggests it's the
latter - and that could be down to the PCIe devices themselves, or it
could be a platform hardware issue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
