Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A824D33F8AE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 20:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhCQTCd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 15:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232468AbhCQTCJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Mar 2021 15:02:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F9CD64F59;
        Wed, 17 Mar 2021 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616007729;
        bh=MGC69ZbhZJ/w9e0RsC5PQWGGNkGLL4hG+MDWe0tES/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mY9gq+X3G+Dfr2sl1aAUrYLEdZibbKmRUnYPxQxYMLWG2AJAT8v7CgWhPmSwzw2Zv
         Z7RQ+n4N0b/z/l76JnGjTYhPXTAGny43VLg+IsnuSFJTXZ4kJHHmKeZuDcHBREoe3F
         qCDKRrRdrm50P8Sxej0em953arWH42kuKd1nUSE32Go1eXA7/VB0js+nYEBebKXWDN
         4gMRyS8CurSWc00AxQSO5pc02As5xHNvhZ9rBjsufxA30lTZoPjaWqbr+SNoEHOHu1
         LC9BzLsNknBpj8fR6tYdBfQ7BG/Ak6ay4p3qsYAWxEr/Y5TZ/IdMcXvubXvni36Es6
         cU0x8VJY7mm0g==
Received: by pali.im (Postfix)
        id 776358A9; Wed, 17 Mar 2021 20:02:06 +0100 (CET)
Date:   Wed, 17 Mar 2021 20:02:06 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>, bhelgaas@google.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210317190206.zrtzwgskxdogl7dz@pali>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-5-ameynarkhede03@gmail.com>
 <20210314235545.girtrazsdxtrqo2q@pali>
 <20210315134323.llz2o7yhezwgealp@archlinux>
 <20210315135226.avwmnhkfsgof6ihw@pali>
 <20210315083409.08b1359b@x1.home.shazbot.org>
 <20210315145238.6sg5deblr2z2pupu@pali>
 <20210315090339.54546e91@x1.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210315090339.54546e91@x1.home.shazbot.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 15 March 2021 09:03:39 Alex Williamson wrote:
> On Mon, 15 Mar 2021 15:52:38 +0100
> Pali Rohár <pali@kernel.org> wrote:
> 
> > On Monday 15 March 2021 08:34:09 Alex Williamson wrote:
> > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > Pali Rohár <pali@kernel.org> wrote:
> > >   
> > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:  
> > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > warm reset respectively.    
> > > > 
> > > > No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
> > > > type of reset, which is currently implemented only for PCIe hot plug
> > > > bridges and for PowerPC PowerNV platform and it just call PCI secondary
> > > > bus reset with some other hook. PCIe Warm Reset does not have API in
> > > > kernel and therefore drivers do not export this type of reset via any
> > > > kernel function (yet).  
> > > 
> > > Warm reset is beyond the scope of this series, but could be implemented
> > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > defined here.  
> > 
> > Ok!
> > 
> > > Note that with this series the resets available through
> > > pci_reset_function() and the per device reset attribute is sysfs remain
> > > exactly the same as they are currently.  The bus and slot reset
> > > methods used here are limited to devices where only a single function is
> > > affected by the reset, therefore it is not like the patch you proposed
> > > which performed a reset irrespective of the downstream devices.  This
> > > series only enables selection of the existing methods.  Thanks,
> > > 
> > > Alex
> > >   
> > 
> > But with this patch series, there is still an issue with PCI secondary
> > bus reset mechanism as exported sysfs attribute does not do that
> > remove-reset-rescan procedure. As discussed in other thread, this reset
> > let device in unconfigured / broken state.
> 
> No, there's not:
> 
> int pci_reset_function(struct pci_dev *dev)
> {
>         int rc;
> 
>         if (!dev->reset_fn)
>                 return -ENOTTY;
> 
>         pci_dev_lock(dev);
> >>>     pci_dev_save_and_disable(dev);
> 
>         rc = __pci_reset_function_locked(dev);
> 
> >>>     pci_dev_restore(dev);
>         pci_dev_unlock(dev);
> 
>         return rc;
> }
> 
> The remove/re-scan was discussed primarily because your patch performed
> a bus reset regardless of what devices were affected by that reset and
> it's difficult to manage the scope where multiple devices are affected.
> Here, the bus and slot reset functions will fail unless the scope is
> limited to the single device triggering this reset.  Thanks,
> 
> Alex
> 

I was thinking a bit more about it and I'm really sure how it would
behave with hotplugging PCIe bridge.

On aardvark PCIe controller I have already tested that secondary bus
reset bit is triggering Hot Reset event and then also Link Down event.
These events are not handled by aardvark driver yet (needs to
implemented into kernel's emulated root bridge code).

But I'm not sure how it would behave on real HW PCIe hotplugging bridge.
Kernel has already code which removes PCIe device if it changes presence
bit (and inform via interrupt). And Link Down event triggers this
change.

Can somebody test these changes on some PCIe hotplug controller what
secondary bus reset via sysfs would do? Because currently it is not
exported as reset method and there can be different race conditions and
maybe error (?) if hotplug code is going to remove device on which user
triggered bus reset via sysfs.

And in my opinion this can happen also in case when only one device is
on the bus, so it perfectly matches all conditions when sysfs can use
bus reset for one device.

I can try to implement hotplug code into aardvark driver and root bridge
emulator to test how this patch would happen. But it would take some
time...
