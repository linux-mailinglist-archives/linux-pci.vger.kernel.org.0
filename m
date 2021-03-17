Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1811133F97A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 20:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhCQTks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 15:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233106AbhCQTk2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Mar 2021 15:40:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D058164EEC;
        Wed, 17 Mar 2021 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616010028;
        bh=MpxkVHR2v2jDzIm3O25rle7AIjiLnTT10u+fsNBUBpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYfUPIP4crIukPwcwdJYe6cIFvacWkd9H5Jh8tz23DdqLmIPKTFW6fYyKRgVmIFu4
         428NtxScj2hg43DfxZLUUrlj17qgz8+mf8e2V53kwt7SCl70st4gZSKoa0f0cse3Qs
         O7NMUhkDugWoK/vtQaql66o7iwKYD9SKfLITqbH4qiEBeClysBsGSQxMizM8yTGVtK
         nAWWZqsi4vCXBBxBxh2ok9gNFm+egZODhBUp3fNhex4D/S0VxUJZSRqhftkWad6h0C
         Ea0zVw8cthkar8YYvaSXZYDWI7ANxtzhma0tNw5wyM+dIL1Z5oqF/vT4GnVM/lKnHn
         Qt4dh1+PUbSXA==
Received: by pali.im (Postfix)
        id 75E208A9; Wed, 17 Mar 2021 20:40:24 +0100 (CET)
Date:   Wed, 17 Mar 2021 20:40:24 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>, bhelgaas@google.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210317194024.nkzrbbvi6utoznze@pali>
References: <20210314235545.girtrazsdxtrqo2q@pali>
 <20210315134323.llz2o7yhezwgealp@archlinux>
 <20210315135226.avwmnhkfsgof6ihw@pali>
 <20210315083409.08b1359b@x1.home.shazbot.org>
 <20210315145238.6sg5deblr2z2pupu@pali>
 <20210315090339.54546e91@x1.home.shazbot.org>
 <20210317190206.zrtzwgskxdogl7dz@pali>
 <20210317131536.38f398b0@omen.home.shazbot.org>
 <20210317192424.kpfybcrsen3ivr4f@pali>
 <20210317133245.7d95909c@omen.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210317133245.7d95909c@omen.home.shazbot.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 17 March 2021 13:32:45 Alex Williamson wrote:
> On Wed, 17 Mar 2021 20:24:24 +0100
> Pali Rohár <pali@kernel.org> wrote:
> 
> > On Wednesday 17 March 2021 13:15:36 Alex Williamson wrote:
> > > On Wed, 17 Mar 2021 20:02:06 +0100
> > > Pali Rohár <pali@kernel.org> wrote:
> > >   
> > > > On Monday 15 March 2021 09:03:39 Alex Williamson wrote:  
> > > > > On Mon, 15 Mar 2021 15:52:38 +0100
> > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > >     
> > > > > > On Monday 15 March 2021 08:34:09 Alex Williamson wrote:    
> > > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > >       
> > > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:      
> > > > > > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > > > > > warm reset respectively.        
> > > > > > > > 
> > > > > > > > No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
> > > > > > > > type of reset, which is currently implemented only for PCIe hot plug
> > > > > > > > bridges and for PowerPC PowerNV platform and it just call PCI secondary
> > > > > > > > bus reset with some other hook. PCIe Warm Reset does not have API in
> > > > > > > > kernel and therefore drivers do not export this type of reset via any
> > > > > > > > kernel function (yet).      
> > > > > > > 
> > > > > > > Warm reset is beyond the scope of this series, but could be implemented
> > > > > > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > > > > > defined here.      
> > > > > > 
> > > > > > Ok!
> > > > > >     
> > > > > > > Note that with this series the resets available through
> > > > > > > pci_reset_function() and the per device reset attribute is sysfs remain
> > > > > > > exactly the same as they are currently.  The bus and slot reset
> > > > > > > methods used here are limited to devices where only a single function is
> > > > > > > affected by the reset, therefore it is not like the patch you proposed
> > > > > > > which performed a reset irrespective of the downstream devices.  This
> > > > > > > series only enables selection of the existing methods.  Thanks,
> > > > > > > 
> > > > > > > Alex
> > > > > > >       
> > > > > > 
> > > > > > But with this patch series, there is still an issue with PCI secondary
> > > > > > bus reset mechanism as exported sysfs attribute does not do that
> > > > > > remove-reset-rescan procedure. As discussed in other thread, this reset
> > > > > > let device in unconfigured / broken state.    
> > > > > 
> > > > > No, there's not:
> > > > > 
> > > > > int pci_reset_function(struct pci_dev *dev)
> > > > > {
> > > > >         int rc;
> > > > > 
> > > > >         if (!dev->reset_fn)
> > > > >                 return -ENOTTY;
> > > > > 
> > > > >         pci_dev_lock(dev);    
> > > > > >>>     pci_dev_save_and_disable(dev);    
> > > > > 
> > > > >         rc = __pci_reset_function_locked(dev);
> > > > >     
> > > > > >>>     pci_dev_restore(dev);    
> > > > >         pci_dev_unlock(dev);
> > > > > 
> > > > >         return rc;
> > > > > }
> > > > > 
> > > > > The remove/re-scan was discussed primarily because your patch performed
> > > > > a bus reset regardless of what devices were affected by that reset and
> > > > > it's difficult to manage the scope where multiple devices are affected.
> > > > > Here, the bus and slot reset functions will fail unless the scope is
> > > > > limited to the single device triggering this reset.  Thanks,
> > > > > 
> > > > > Alex
> > > > >     
> > > > 
> > > > I was thinking a bit more about it and I'm really sure how it would
> > > > behave with hotplugging PCIe bridge.
> > > > 
> > > > On aardvark PCIe controller I have already tested that secondary bus
> > > > reset bit is triggering Hot Reset event and then also Link Down event.
> > > > These events are not handled by aardvark driver yet (needs to
> > > > implemented into kernel's emulated root bridge code).
> > > > 
> > > > But I'm not sure how it would behave on real HW PCIe hotplugging bridge.
> > > > Kernel has already code which removes PCIe device if it changes presence
> > > > bit (and inform via interrupt). And Link Down event triggers this
> > > > change.  
> > > 
> > > This is the difference between slot and bus resets, the slot reset is
> > > implemented by the hotplug controller and disables presence detection
> > > around the bus reset.  Thanks,  
> > 
> > Yes, but I'm talking about bus reset, not about slot reset.
> > 
> > I mean: to use bus reset via sysfs on hardware which supports slots and
> > hotplugging.
> > 
> > And if I'm reading code correctly, this combination is allowed, right?
> > Via these new patches it is possible to disable slot reset and enable
> > bus reset.
> 
> That's true, a slot reset is simply a bus reset wrapped around code
> that prevents the device from getting ejected.

Yes, this makes slot reset "safe". But bus reset is "unsafe".

> Maybe it would make
> sense to combine the two as far as this interface is concerned, ie. a
> single "bus" reset method that will always use slot reset when
> available.  Thanks,

That should work when slot reset is available.

Other option is that mentioned remove-reset-rescan procedure.

But quick search in drivers/pci/hotplug/ results that not all hotplug
drivers implement reset_slot method.

So there is a possible issue with hotplug driver which may eject device
during bus reset (because e.g. slot reset is not implemented)?
