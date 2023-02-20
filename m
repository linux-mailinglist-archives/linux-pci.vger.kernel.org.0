Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265B969D401
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 20:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjBTTRm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 14:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjBTTRm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 14:17:42 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020896583;
        Mon, 20 Feb 2023 11:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CQIYaFwjFcInhQesgdM1Q3FOnPe/Uzq5qT3XgjUrVfA=; b=j0qbAdJrPDPAbEMBWpHtFoT0Z5
        YYuJtZBobZNBRsX3p5+rjrDug4KQDa/uOBkp3oTSXLFd+W2XgGnMmIY03JIH5GbTqvEyP7lb6F9vZ
        tRdmnbdmMd8fiulPOgUD+TJnzXdbxpkdAZ7/15va0mAUNzLqgn8qmq6DQJ7Qa1rD34cLE/ZjCO9JM
        Zmu7UbOCEh0D1GJ7cJtBYM0Nj00kx1zg2rVW8VStTzhndFdv/XFqjQTfKAduQ7WqbhcfuPc/L65El
        ZZqzt5UwDY1Ji6HW5RvophDXHRGiASf1P4m29zZTTPS+ip3vmgxNyXyhf3A1/VhMC2vl2giOh4s8w
        01Ls0ieQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57798)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pUBf2-0004vL-Av; Mon, 20 Feb 2023 19:17:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pUBex-0001UW-FZ; Mon, 20 Feb 2023 19:17:11 +0000
Date:   Mon, 20 Feb 2023 19:17:11 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Marc Zyngier <maz@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <Y/PHN+0nETV3o1pQ@shell.armlinux.org.uk>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <Y/Opu6ETe3ZzZ/8E@shell.armlinux.org.uk>
 <86fsb0xkaa.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fsb0xkaa.wl-maz@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 20, 2023 at 06:29:33PM +0000, Marc Zyngier wrote:
> Lockdep also reports[1] a possible circular locking dependency between
> phy_attach_direct() and rtnetlink_rcv_msg(), which looks interesting.
> 
> [1] https://paste.debian.net/1271454/

Adding Andrew, but really this should be in a separate thread, since
this has nothing to do with MSI.

It looks like the open path takes the RTNL lock followed by the phydev
lock, whereas the PHY probe path takes the phydev lock, and then if
there's a SFP attached to the PHY, we end up taking the RTNL lock.
That's going to be utterly horrid to try and solve, and isn't going
to be quick to fix.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
