Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363C869D444
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 20:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjBTToA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 14:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjBTTn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 14:43:59 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B322CA10;
        Mon, 20 Feb 2023 11:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=9HbrxqQTQpnPyk90Ibmi+L1eYlZ8P8y6XH2D3rbiNws=; b=UfFwuH6iH/M1sgUS3t+DNVm34J
        hyEwZY+mOKUDtI34qcK4zuS9bReY+5FrBE4PLLAmm814GqdqowfY41TFnRqrrbVUc5RrDT85KHAcM
        VM+FSvlsXppxYfq8qVwOLeTlxKqSOoKd6Fm20bWRMREnfV8VdMOsU4EVCfy35cme8usA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pUC4e-005XE4-Td; Mon, 20 Feb 2023 20:43:44 +0100
Date:   Mon, 20 Feb 2023 20:43:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [REGRESSION] Re: [patch V3 09/33] genirq/msi: Add range checking
 to msi_insert_desc()
Message-ID: <Y/PNcLACXSN2X/F/@lunn.ch>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <Y/Opu6ETe3ZzZ/8E@shell.armlinux.org.uk>
 <86fsb0xkaa.wl-maz@kernel.org>
 <Y/PHN+0nETV3o1pQ@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/PHN+0nETV3o1pQ@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 20, 2023 at 07:17:11PM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 20, 2023 at 06:29:33PM +0000, Marc Zyngier wrote:
> > Lockdep also reports[1] a possible circular locking dependency between
> > phy_attach_direct() and rtnetlink_rcv_msg(), which looks interesting.
> > 
> > [1] https://paste.debian.net/1271454/
> 
> Adding Andrew, but really this should be in a separate thread, since
> this has nothing to do with MSI.
> 
> It looks like the open path takes the RTNL lock followed by the phydev
> lock, whereas the PHY probe path takes the phydev lock, and then if
> there's a SFP attached to the PHY, we end up taking the RTNL lock.
> That's going to be utterly horrid to try and solve, and isn't going
> to be quick to fix.

What are we actually trying to protect in phy_probe() when we take the
lock and call phydev->drv->probe(phydev) ?

The main purpose of the lock is to protect members of phydev, such as
link, speed, duplex, which can be inconsistent when the lock is not
held. But the PHY is not attached to a MAC yet, so a MAC cannot be
using it, and those members of phydev are not valid yet anyway.

The lock also prevents parallel operation on the device by phylib, but
i cannot think of how that could happen at this early stage in the
life of the PHY.

So maybe we can move the mutex_lock() after the call to
phydev->drv->probe()?

	Andrew
