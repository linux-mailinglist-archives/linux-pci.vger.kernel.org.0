Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D40340841
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 15:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCRO6C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 10:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCRO5w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Mar 2021 10:57:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE0AE64F10;
        Thu, 18 Mar 2021 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616079472;
        bh=hDXuJzQ+kVB52D3s9sqXbwP9pH6r+u0F41rt+74LLe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BP73jHY6Ic2RlSZl74zl+C422UdwYasWVBQk6QrqUoQrrGWKSnHhQ9RM9cISwfbE+
         13NR8KCb/6/YXdjx8jGlQ3f/J5MxqoAk0VW2IMFpIOT0Z0SszjPqd/bwdy7em1lcit
         BMxb/5rwtf07bOksN40mSBEbdxcELHjnDaf137zuUl7st4Zg78nAUTlB+CUEpRvdPl
         wT6dcqT/bQRdz59DwbdfygvutmbShZMGYAAIt99+HDFUmcykFaXCumPVJVpzht15jL
         YiUQW1k2oJyxU/8z8Bb1OPg24qT9kUYkKw5cC8x5/8PQGYuD3dA048PRl8GPhGyhU5
         Vu/D2nS3V9FYw==
Date:   Thu, 18 Mar 2021 16:57:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, alay.shah@nutanix.com,
        suresh.gumpula@nutanix.com, shyam.rajendran@nutanix.com,
        felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFNqbJZo3wqhMc1S@unreal>
References: <YFGDgqdTLBhQL8mN@unreal>
 <20210317102447.73no7mhox75xetlf@archlinux>
 <YFHh3bopQo/CRepV@unreal>
 <20210317112309.nborigwfd26px2mj@archlinux>
 <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318142252.fqi3das3mtct4yje@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210318142252.fqi3das3mtct4yje@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 07:52:52PM +0530, Amey Narkhede wrote:
> On 21/03/18 11:09AM, Leon Romanovsky wrote:
> > On Wed, Mar 17, 2021 at 11:31:40AM -0600, Alex Williamson wrote:
> > > On Wed, 17 Mar 2021 15:58:40 +0200
> > > Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > > On Wed, Mar 17, 2021 at 06:47:18PM +0530, Amey Narkhede wrote:
> > > > > On 21/03/17 01:47PM, Leon Romanovsky wrote:
> > > > > > On Wed, Mar 17, 2021 at 04:53:09PM +0530, Amey Narkhede wrote:
> > > > > > > On 21/03/17 01:02PM, Leon Romanovsky wrote:
> > > > > > > > On Wed, Mar 17, 2021 at 03:54:47PM +0530, Amey Narkhede wrote:
> > > > > > > > > On 21/03/17 06:20AM, Leon Romanovsky wrote:
> > > > > > > > > > On Mon, Mar 15, 2021 at 06:32:32PM +0000, Raphael Norwitz wrote:
> > > > > > > > > > > On Mon, Mar 15, 2021 at 10:29:50AM -0600, Alex Williamson wrote:
> > > > > > > > > > > > On Mon, 15 Mar 2021 21:03:41 +0530
> > > > > > > > > > > > Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > On 21/03/15 05:07PM, Leon Romanovsky wrote:
> > > > > > > > > > > > > > On Mon, Mar 15, 2021 at 08:34:09AM -0600, Alex Williamson wrote:
> > > > > > > > > > > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > > > > > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:
> > > > > > > > > > > > > > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > > > > > > > > > > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > > > > > > > > > > > > > warm reset respectively.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
> > > > > > > > > > > > > > > > type of reset, which is currently implemented only for PCIe hot plug
> > > > > > > > > > > > > > > > bridges and for PowerPC PowerNV platform and it just call PCI secondary
> > > > > > > > > > > > > > > > bus reset with some other hook. PCIe Warm Reset does not have API in
> > > > > > > > > > > > > > > > kernel and therefore drivers do not export this type of reset via any
> > > > > > > > > > > > > > > > kernel function (yet).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Warm reset is beyond the scope of this series, but could be implemented
> > > > > > > > > > > > > > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > > > > > > > > > > > > > defined here.  Note that with this series the resets available through
> > > > > > > > > > > > > > > pci_reset_function() and the per device reset attribute is sysfs remain
> > > > > > > > > > > > > > > exactly the same as they are currently.  The bus and slot reset
> > > > > > > > > > > > > > > methods used here are limited to devices where only a single function is
> > > > > > > > > > > > > > > affected by the reset, therefore it is not like the patch you proposed
> > > > > > > > > > > > > > > which performed a reset irrespective of the downstream devices.  This
> > > > > > > > > > > > > > > series only enables selection of the existing methods.  Thanks,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Alex,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I asked the patch author here [1], but didn't get any response, maybe
> > > > > > > > > > > > > > you can answer me. What is the use case scenario for this functionality?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Thanks
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > [1] https://lore.kernel.org/lkml/YE389lAqjJSeTolM@unreal/
> > > > > > > > > > > > > >
> > > > > > > > > > > > > Sorry for not responding immediately. There were some buggy wifi cards
> > > > > > > > > > > > > which needed FLR explicitly not sure if that behavior is fixed in
> > > > > > > > > > > > > drivers. Also there is use a case at Nutanix but the engineer who
> > > > > > > > > > > > > is involved is on PTO that is why I did not respond immediately as
> > > > > > > > > > > > > I don't know the details yet.
> > > > > > > > > > > >
> > > > > > > > > > > > And more generally, devices continue to have reset issues and we
> > > > > > > > > > > > impose a fixed priority in our ordering.  We can and probably should
> > > > > > > > > > > > continue to quirk devices when we find broken resets so that we have
> > > > > > > > > > > > the best default behavior, but it's currently not easy for an end user
> > > > > > > > > > > > to experiment, ie. this reset works, that one doesn't.  We might also
> > > > > > > > > > > > have platform issues where a given reset works better on a certain
> > > > > > > > > > > > platform.  Exposing a way to test these things might lead to better
> > > > > > > > > > > > quirks.  In the case I think Pali was looking for, they wanted a
> > > > > > > > > > > > mechanism to force a bus reset, if this was in reference to a single
> > > > > > > > > > > > function device, this could be accomplished by setting a priority for
> > > > > > > > > > > > that mechanism, which would translate to not only the sysfs reset
> > > > > > > > > > > > attribute, but also the reset mechanism used by vfio-pci.  Thanks,
> > > > > > > > > > > >
> > > > > > > > > > > > Alex
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > To confirm from our end - we have seen many such instances where default
> > > > > > > > > > > reset methods have not worked well on our platform. Debugging these
> > > > > > > > > > > issues is painful in practice, and this interface would make it far
> > > > > > > > > > > easier.
> > > > > > > > > > >
> > > > > > > > > > > Having an interface like this would also help us better communicate the
> > > > > > > > > > > issues we find with upstream. Allowing others to more easily test our
> > > > > > > > > > > (or other entities') findings should give better visibility into
> > > > > > > > > > > which issues apply to the device in general and which are platform
> > > > > > > > > > > specific. In disambiguating the former from the latter, we should be
> > > > > > > > > > > able to better quirk devices for everyone, and in the latter cases, this
> > > > > > > > > > > interface allows for a safer and more elegant solution than any of the
> > > > > > > > > > > current alternatives.
> > > > > > > > > >
> > > > > > > > > > So to summarize, we are talking about test and debug interface to
> > > > > > > > > > overcome HW bugs, am I right?
> > > > > > > > > >
> > > > > > > > > > My personal experience shows that once the easy workaround exists
> > > > > > > > > > (and write to generally available sysfs is very simple), the vendors
> > > > > > > > > > and users desire for proper fix decreases drastically. IMHO, we will
> > > > > > > > > > see increase of copy/paste in SO and blog posts, but reduce in quirks.
> > > > > > > > > >
> > > > > > > > > > My 2-cents.
> > > > > > > > > >
> > > > > > > > > I agree with your point but at least it gives the userspace ability
> > > > > > > > > to use broken device until bug is fixed in upstream.
> > > > > > > >
> > > > > > > > As I said, I don't expect many fixes once "userspace" will be able to
> > > > > > > > use cheap workaround. There is no incentive to fix it.
> > >
> > > We can increase the annoyance factor of using a modified set of reset
> > > methods, but ultimately we can only control what goes into our kernel,
> > > other kernels might take v1 of this series and incorporate it
> > > regardless of what happens here.
> > >
> > > > > > > > > This is also applicable for obscure devices without upstream
> > > > > > > > > drivers for example custom FPGA based devices.
> > > > > > > >
> > > > > > > > This is not relevant to upstream kernel. Those vendors ship everything
> > > > > > > > custom, they don't need upstream, we don't need them :)
> > > > > > > >
> > > > > > > By custom I meant hobbyists who could tinker with their custom FPGA.
> > > > > >
> > > > > > I invite such hobbyists to send patches and include their FPGA in
> > > > > > upstream kernel.
> > >
> > > This is potentially another good use case, how receptive are we going
> > > to be to an FPGA design that botches a reset.  Do they have a valid
> > > device ID for us to base a quirk on, are they just squatting on one, or
> > > using the default from a library.  Maybe the next bitstream will
> > > resolve it, maybe without any external indication.  IOW, what would the
> > > quality level be for that quirk versus using this as a workaround,
> > > where the user probably wouldn't mind a kernel nag?
> >
> > It is worth to solve it when the need arises.
> >
> > >
> > > > > > > > > Another main application which I forgot to mention is virtualization
> > > > > > > > > where vmm wants to reset the device when the guest is reset,
> > > > > > > > > to emulate machine reboot as closely as possible.
> > > > > > > >
> > > > > > > > It can work in very narrow case, because reset will cause to device
> > > > > > > > reprobe and most likely the driver will be different from the one that
> > > > > > > > started reset. I can imagine that net devices will lose their state and
> > > > > > > > config after such reset too.
> > > > > > > >
> > > > > > > Not sure if I got that 100% right. The pci_reset_function() function
> > > > > > > saves and restores device state over the reset.
> > > > > >
> > > > > > I'm talking about netdev state, but whatever given the existence of
> > > > > > sysfs reset knob.
> > > > > >
> > > > > > >
> > > > > > > > IMHO, it will be saner for everyone if virtualization don't try such resets.
> > >
> > > That would cause a massive regression in device assignment support.  As
> > > with other sysfs attributes, triggering them alongside a running driver
> > > is probably not going to end well.  However, pci_reset_function() is
> > > extremely useful for stopping devices and returning them to a default
> > > state, when either rebooting a VM or returning the device to the host.
> > > The device is not removed and re-probed when this occurs, vfio-pci is
> > > able to hold onto the device across these actions.  Sure, don't reset a
> > > netdev device when it's in use, that's not what these are used for.
> > >
> > > > > > > The exists reset sysfs attribute was added for exactly this case
> > > > > > > though.
> > > > > >
> > > > > > I didn't know the rationale behind that file till you said and I
> > > > > > googled libvirt discussion, so ok. Do you propose that libvirt
> > > > > > will manage database of devices and their working reset types?
> > > > > >
> > > > > I don't have much idea about internals of libvirt but why would
> > > > > it need to manage database of working reset types? It could just
> > > > > read new reset_methods attribute to get the list of supported reset
> > > > > methods.
> > > >
> > > > Because the idea of this patch is to read all supported reset types and
> > > > allow to the user to chose the working one. The user will do it with
> > > > help from StackOverflow, but libvirt will need to have some sort of
> > > > database, otherwise it won't be different from simple "echo 1 > reset"
> > > > which will iterate over all supported resets anyway.
> > >
> > > AFAIK, libvirt no longer attempts to do resets itself, or is at least
> > > moving in that direction.  vfio-pci will reset as device when they're
> > > opened by a user (when available) or triggered via the API.
> >
> > <...>
> >
> > > > The difference here is that this is a workaround to solve bugs that
> > > > should be fixed in the kernel.
> > >
> > > If we want to discourage using this as a primary means to resolve reset
> > > issues on a device then we can create log warnings any time it's used.
> > > Downstreams that really want this functionality are going to take this
> > > patch from the list whether we accept it or not.  As above, it seems
> > > there are valid use cases.  Even with mainstream vfio in QEMU, I go
> > > through some hoops trying to determine if I can do a secondary bus
> > > reset rather than a PM reset because it's not specified anywhere what a
> > > "soft reset" means for any given device.  This sort of interface could
> > > make it easier to apply a system policy that a pci_reset_function()
> > > should always perform a secondary bus reset if the only other option is
> > > a PM reset.  Maybe that policy mostly makes sense for a VM use case, so
> > > we'd want one policy by default and another when the device is used for
> > > this functionality.  How could we accomplish that with a quirk?  Thanks,
> >
> > I'm lost here, does vfio-pci use sysfs interface or internal to the kernel API?
> >
> > If it is latter then we don't really need sysfs, if not, we still need
> > some sort of DB to create second policy, because "supported != working".
> > What am I missing?
> >
> > Thanks
> >
> Can you explain bit more about why supported != working?

It is written in the commit message of this patch.
https://lore.kernel.org/lkml/20210312173452.3855-1-ameynarkhede03@gmail.com/
"This feature aims to allow greater control of a device for use cases
as device assignment, where specific device or platform issues may
interact poorly with a given reset method, and for which device specific
quirks have not been developed."

You wrote it and also repeated it a couple of times during the discussion.

If device can understand that specific reset doesn't work, it won't
perform it in first place.

Thanks
