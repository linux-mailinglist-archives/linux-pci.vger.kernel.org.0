Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DFB69D3AD
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjBTTCO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 14:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjBTTCM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 14:02:12 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FCDB46C;
        Mon, 20 Feb 2023 11:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FKRoA1ZXCl+mWQiZAqnMEA8vWoiiARgJnm8LfViqPIg=; b=ADsLNMkVDAf+fm+hklhFeJIDWg
        dw0SUdI144x1H8iz3Hxja1BD9zhK2VNGTHy5ajNkPlsnZOZbVQGi4nf2djXrM88ZWJbQvdDq2e48Q
        Y+sUPpE5Zz2blfaw81PJcSq9UtIF5vJgcTYYlTMv8BPa+f/cxGnPgMAhihu957LFSb/33cRrLRz4J
        PVrgQJUkC5NysoUbvyboBHId5ilsFUl/jzMj69cophWVpXk+k9JAOhwYo+q2BnSf5+7HOq7Ow4DMe
        nu9pIzRe+QAtbsK3zB8L+NW+6lrtWk5WAFDiZ2KxTOrC7oiVRZNxYdD/rD6X1f1W9rvJvT83aIdPZ
        +RIiJ5Cg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58574)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pUBOQ-0004tv-Gp; Mon, 20 Feb 2023 19:00:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pUBOM-0001T4-7W; Mon, 20 Feb 2023 19:00:02 +0000
Date:   Mon, 20 Feb 2023 19:00:02 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Marc Zyngier <maz@kernel.org>
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
Message-ID: <Y/PDMlc5gqlEkX0m@shell.armlinux.org.uk>
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
> On Mon, 20 Feb 2023 17:11:23 +0000,
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > 
> > On Fri, Nov 25, 2022 at 12:25:59AM +0100, Thomas Gleixner wrote:
> > > Per device domains provide the real domain size to the core code. This
> > > allows range checking on insertion of MSI descriptors and also paves the
> > > way for dynamic index allocations which are required e.g. for IMS. This
> > > avoids external mechanisms like bitmaps on the device side and just
> > > utilizes the core internal MSI descriptor storxe for it.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Hi Thomas,
> > 
> > This patch appears to cause a regression on Macchiatobin, delaying the
> > boot by about ten seconds due to all the warnings the kernel now
> > produces.
> > 
> > > @@ -136,11 +149,16 @@ static bool msi_desc_match(struct msi_de
> > >  
> > >  static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
> > >  {
> > > +	unsigned int hwsize;
> > > +
> > >  	if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
> > > -			 !dev->msi.data->__domains[ctrl->domid].domain ||
> > > -			 ctrl->first > ctrl->last ||
> > > -			 ctrl->first > MSI_MAX_INDEX ||
> > > -			 ctrl->last > MSI_MAX_INDEX))
> > > +			 !dev->msi.data->__domains[ctrl->domid].domain))
> > > +		return false;
> > > +
> > > +	hwsize = msi_domain_get_hwsize(dev, ctrl->domid);
> > 
> > This calls msi_get_device_domain() without taking dev->msi.data->mutex,
> > resulting in the lockdep_assert_held() firing for what seems to be every
> > MSI created by the Armada 8040 ICU driver, which suggests something isn't
> > taking the lock as you expect. Please can you take a look and propose a
> > patch to fix this regression.
> 
> Since you already worked it out, I only had to translate your words
> into the patch below, which solves it for me.

Thanks for making incorrect assumptions. I hadn't "worked it out",
I merely reported it and stated the bleeding obvious.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
