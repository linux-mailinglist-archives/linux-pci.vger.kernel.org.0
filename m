Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3859B3375BC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 15:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhCKOau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 09:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233905AbhCKOaa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 09:30:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E433D64FE2;
        Thu, 11 Mar 2021 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615473030;
        bh=m2XUVNPGUTgDKeGFE7OBmHC8+8gXlteTLyWvGrLc4Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFSrSouV867Dp29ScUKZyCvSd9AROjGXtxnlN7oGKWIQSo1QKBFQMP2WTJ2Vyha7l
         8UPz8O0UmbI7WB+TSl+e1VIhihv1pvHpJ7CuUJquNf1KSDPz4BJJVo8eU33Ey3rTYk
         ejC6o3lweUqXJ/XGf0VL+3kMUNNH5F/s8AwvYkwwcrKiSTNFuCVQdE+Q816NKNo/m0
         9vcZrsKdUD92toBHE3VJ430v2ri5hMkhPQWzsW6QYtN+69bHqnpzvmq5WR07pN6WSI
         W2pSZ2CiCQ93cdd95qJdGVNEXKO1flRtIcfGbSsZw0v805MRB2tDRWYIEaMW9BeyRV
         M6ifTDBMwHtqA==
Received: by pali.im (Postfix)
        id 7EEC88A7; Thu, 11 Mar 2021 15:30:27 +0100 (CET)
Date:   Thu, 11 Mar 2021 15:30:27 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede02@gmail.com>
Subject: Re: RFC: sysfs node for Secondary PCI bus reset (PCIe Hot Reset)
Message-ID: <20210311143027.mwzdgme3omkj3ld5@pali>
References: <20210301171221.3d42a55i7h5ubqsb@pali>
 <20210301202817.GA201451@bjorn-Precision-5520>
 <20210302125829.216784cd@omen.home.shazbot.org>
 <20210303175635.nv7kxiulevpy5ax5@pali>
 <85786a3a-c7d4-95cc-170f-26f89c2b337e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85786a3a-c7d4-95cc-170f-26f89c2b337e@nvidia.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 11 March 2021 19:53:26 Vidya Sagar wrote:
> On 3/3/2021 11:26 PM, Pali Rohár wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tuesday 02 March 2021 12:58:29 Alex Williamson wrote:
> > > On Mon, 1 Mar 2021 14:28:17 -0600
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > 
> > > > [+cc Alex, reset expert]
> > > > 
> > > > On Mon, Mar 01, 2021 at 06:12:21PM +0100, Pali Rohár wrote:
> > > > > Hello!
> > > > > 
> > > > > PCIe card can be reset via in-band Hot Reset signal which can be
> > > > > triggered by PCIe bridge via Secondary Bus Reset bit in PCI config
> > > > > space.
> > > > > 
> > > > > Kernel already exports sysfs node "reset" for triggering Functional
> > > > > Reset of particular function of PCI device. But in some cases Functional
> > > > > Reset is not enough and Hot Reset is required.
> > > > > 
> > > > > Following RFC patch exports sysfs node "reset_bus" for PCI bridges which
> > > > > triggers Secondary Bus Reset and therefore for PCIe bridges it resets
> > > > > connected PCIe card.
> > > > > 
> > > > > What do you think about it?
> > > > > 
> > > > > Currently there is userspace script which can trigger PCIe Hot Reset by
> > > > > modifying PCI config space from userspace:
> > > > > 
> > > > > https://alexforencich.com/wiki/en/pcie/hot-reset-linux
> > > > > 
> > > > > But because kernel already provides way how to trigger Functional Reset
> > > > > it could provide also way how to trigger PCIe Hot Reset.
> > > 
> > > What that script does and what this does, or what the existing reset
> > > attribute does, are very different.  The script finds the upstream
> > > bridge for a given device, removes the device (ignoring that more than
> > > one device might be affected by the bus reset), uses setpci to trigger
> > > a secondary bus reset, then rescans devices.  The below only triggers
> > > the secondary bus reset, neither saving and restoring affected device
> > > state like the existing function level reset attribute, nor removing
> > > and rescanning as the script does.  It simply leaves an entire
> > > hierarchy of PCI devices entirely un-programmed yet still has struct
> > > pci_devs attached to them for untold future misery.
> > > 
> > > In fact, for the case of a single device affected by the bus reset, as
> > > intended by the script, the existing reset attribute will already do
> > > that if the device supports no other reset mechanism.  There's actually
> > > a running LFX mentorship project that aims to allow the user to control
> > > the type of reset performed by the existing reset attribute such that a
> > > user could force the bus reset behavior over other reset methods.
> > 
> > Hello Alex? Do you have a link for this "reset" project? I'm interesting
> > in it as I'm dealing with Compex wifi cards which are causing problems.
> > 
> > For correct initialization I need to issue PCIe Warm Reset for these
> > cards (Warm Reset is done via PERST# pin which most linux controller
> > drivers controls via GPIO subsystem). And for now there is no way to
> > trigger PCIe Warm Reset for particular PCIe device from userspace. As
> > there is no userspace <--> kernel API for it.
> > 
> > > There might be some justification for an attribute that actually
> > > implements the referenced script correctly, perhaps in kernel we could
> > > avoid races with bus rescans, but simply triggering an SBR to quietly
> > > de-program all downstream devices with no state restore or device
> > > rescan is not it.  Any affected device would be unusable.  Was this
> > > tested?  Thanks,
> > 
> > I have tested my change. First I called 'remove' attribute for PCIe
> > card, then I called this 'bus_reset' on parent PCIe bridge and later I
> > called 'rescan' attribute on bridge. It correctly rested tested ath9k
> > card. So I did something similar as in above script. But I agree that
> > there are race conditions and basically lot of other calls needs to be
> > done to restore state.
> > 
> > So I see that to make it 'usable' we need to do it automatically in
> > kernel and also rescan/restore state of PCIe devices behind bridge after
> > reset...
> But, is save-restore alone going to be enough? I mean what is the state of
> the device-driver going to be when the device is going through the reset
> process? Isn't remove-rescan the correct thing to do here rather than
> save/restore?

I think that remove-reset-rescan (if done atomically with correct
timeouts between them and applying kernel quirks) should be correct
here.

> - Vidya Sagar
> > 
> > > Alex
> > > 
> > > > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > > > index 50fcb62d59b5..f5e11c589498 100644
> > > > > --- a/drivers/pci/pci-sysfs.c
> > > > > +++ b/drivers/pci/pci-sysfs.c
> > > > > @@ -1321,6 +1321,30 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
> > > > > 
> > > > >   static DEVICE_ATTR(reset, 0200, NULL, reset_store);
> > > > > 
> > > > > +static ssize_t reset_bus_store(struct device *dev, struct device_attribute *attr,
> > > > > +                        const char *buf, size_t count)
> > > > > +{
> > > > > + struct pci_dev *pdev = to_pci_dev(dev);
> > > > > + unsigned long val;
> > > > > + ssize_t result = kstrtoul(buf, 0, &val);
> > > > > +
> > > > > + if (result < 0)
> > > > > +         return result;
> > > > > +
> > > > > + if (val != 1)
> > > > > +         return -EINVAL;
> > > > > +
> > > > > + pm_runtime_get_sync(dev);
> > > > > + result = pci_bridge_secondary_bus_reset(pdev);
> > > > > + pm_runtime_put(dev);
> > > > > + if (result < 0)
> > > > > +         return result;
> > > > > +
> > > > > + return count;
> > > > > +}
> > > > > +
> > > > > +static DEVICE_ATTR(reset_bus, 0200, NULL, reset_bus_store);
> > > > > +
> > > > >   static int pci_create_capabilities_sysfs(struct pci_dev *dev)
> > > > >   {
> > > > >    int retval;
> > > > > @@ -1332,8 +1356,15 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
> > > > >            if (retval)
> > > > >                    goto error;
> > > > >    }
> > > > > + if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > > > > +         retval = device_create_file(&dev->dev, &dev_attr_reset_bus);
> > > > > +         if (retval)
> > > > > +                 goto error_reset_bus;
> > > > > + }
> > > > >    return 0;
> > > > > 
> > > > > +error_reset_bus:
> > > > > + device_remove_file(&dev->dev, &dev_attr_reset);
> > > > >   error:
> > > > >    pcie_vpd_remove_sysfs_dev_files(dev);
> > > > >    return retval;
> > > > > @@ -1414,6 +1445,8 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
> > > > >            device_remove_file(&dev->dev, &dev_attr_reset);
> > > > >            dev->reset_fn = 0;
> > > > >    }
> > > > > + if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> > > > > +         device_remove_file(&dev->dev, &dev_attr_reset_bus);
> > > > >   }
> > > > > 
> > > > >   /**
> > > > 
> > > 
