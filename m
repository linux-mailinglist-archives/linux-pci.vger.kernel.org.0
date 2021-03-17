Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D39933F202
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 14:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhCQN7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 09:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231232AbhCQN6p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Mar 2021 09:58:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 696D864E05;
        Wed, 17 Mar 2021 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615989525;
        bh=Z3w5ueLgqd8fSP7YmnGNHG+CsakrpsACqE5pMMTj0zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrT8ZvqA8s9tshxwvBF8Af5cjwDpNN+0AWfyYxF52zkF3dpHm7wCbHR+hPbe0QmC0
         v1wP5ilao2dwQSq8sFbGUF4SAQ3/yQ9WHc2prbMQ0/Ru9g40cvS1sMi1M9xhWqcoRw
         e8eqlVda46PgIU16oSQxQWuuJdbpVSEZTPWd+rwzBDUXofSohJ9J+/Fo1iAkgaUisj
         UHQ0mnq2SNUamFgCPmxIlBxpP3o0Kd6uFVOq1nzGSjZl5RFYflEewtO6bTGNd+OpL9
         /XzILlgCG194R4BvfhWeCJnzKcShYw4q5ancd2n3K5y1N4eldGrBPMnpniH0RDGW5o
         VAZrAWuK1p9wQ==
Date:   Wed, 17 Mar 2021 15:58:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, alay.shah@nutanix.com,
        suresh.gumpula@nutanix.com, shyam.rajendran@nutanix.com,
        felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFILEOQBOLgOy3cy@unreal>
References: <YE94InPHLWmOaH/b@unreal>
 <20210315153341.miip637z35mwv7fv@archlinux>
 <20210315102950.230de1d6@x1.home.shazbot.org>
 <20210315183226.GA14801@raphael-debian-dev>
 <YFGDgqdTLBhQL8mN@unreal>
 <20210317102447.73no7mhox75xetlf@archlinux>
 <YFHh3bopQo/CRepV@unreal>
 <20210317112309.nborigwfd26px2mj@archlinux>
 <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210317131718.3uz7zxnvoofpunng@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 17, 2021 at 06:47:18PM +0530, Amey Narkhede wrote:
> On 21/03/17 01:47PM, Leon Romanovsky wrote:
> > On Wed, Mar 17, 2021 at 04:53:09PM +0530, Amey Narkhede wrote:
> > > On 21/03/17 01:02PM, Leon Romanovsky wrote:
> > > > On Wed, Mar 17, 2021 at 03:54:47PM +0530, Amey Narkhede wrote:
> > > > > On 21/03/17 06:20AM, Leon Romanovsky wrote:
> > > > > > On Mon, Mar 15, 2021 at 06:32:32PM +0000, Raphael Norwitz wrote:
> > > > > > > On Mon, Mar 15, 2021 at 10:29:50AM -0600, Alex Williamson wrote:
> > > > > > > > On Mon, 15 Mar 2021 21:03:41 +0530
> > > > > > > > Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> > > > > > > >
> > > > > > > > > On 21/03/15 05:07PM, Leon Romanovsky wrote:
> > > > > > > > > > On Mon, Mar 15, 2021 at 08:34:09AM -0600, Alex Williamson wrote:
> > > > > > > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:
> > > > > > > > > > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > > > > > > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > > > > > > > > > warm reset respectively.
> > > > > > > > > > > >
> > > > > > > > > > > > No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
> > > > > > > > > > > > type of reset, which is currently implemented only for PCIe hot plug
> > > > > > > > > > > > bridges and for PowerPC PowerNV platform and it just call PCI secondary
> > > > > > > > > > > > bus reset with some other hook. PCIe Warm Reset does not have API in
> > > > > > > > > > > > kernel and therefore drivers do not export this type of reset via any
> > > > > > > > > > > > kernel function (yet).
> > > > > > > > > > >
> > > > > > > > > > > Warm reset is beyond the scope of this series, but could be implemented
> > > > > > > > > > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > > > > > > > > > defined here.  Note that with this series the resets available through
> > > > > > > > > > > pci_reset_function() and the per device reset attribute is sysfs remain
> > > > > > > > > > > exactly the same as they are currently.  The bus and slot reset
> > > > > > > > > > > methods used here are limited to devices where only a single function is
> > > > > > > > > > > affected by the reset, therefore it is not like the patch you proposed
> > > > > > > > > > > which performed a reset irrespective of the downstream devices.  This
> > > > > > > > > > > series only enables selection of the existing methods.  Thanks,
> > > > > > > > > >
> > > > > > > > > > Alex,
> > > > > > > > > >
> > > > > > > > > > I asked the patch author here [1], but didn't get any response, maybe
> > > > > > > > > > you can answer me. What is the use case scenario for this functionality?
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > [1] https://lore.kernel.org/lkml/YE389lAqjJSeTolM@unreal/
> > > > > > > > > >
> > > > > > > > > Sorry for not responding immediately. There were some buggy wifi cards
> > > > > > > > > which needed FLR explicitly not sure if that behavior is fixed in
> > > > > > > > > drivers. Also there is use a case at Nutanix but the engineer who
> > > > > > > > > is involved is on PTO that is why I did not respond immediately as
> > > > > > > > > I don't know the details yet.
> > > > > > > >
> > > > > > > > And more generally, devices continue to have reset issues and we
> > > > > > > > impose a fixed priority in our ordering.  We can and probably should
> > > > > > > > continue to quirk devices when we find broken resets so that we have
> > > > > > > > the best default behavior, but it's currently not easy for an end user
> > > > > > > > to experiment, ie. this reset works, that one doesn't.  We might also
> > > > > > > > have platform issues where a given reset works better on a certain
> > > > > > > > platform.  Exposing a way to test these things might lead to better
> > > > > > > > quirks.  In the case I think Pali was looking for, they wanted a
> > > > > > > > mechanism to force a bus reset, if this was in reference to a single
> > > > > > > > function device, this could be accomplished by setting a priority for
> > > > > > > > that mechanism, which would translate to not only the sysfs reset
> > > > > > > > attribute, but also the reset mechanism used by vfio-pci.  Thanks,
> > > > > > > >
> > > > > > > > Alex
> > > > > > > >
> > > > > > >
> > > > > > > To confirm from our end - we have seen many such instances where default
> > > > > > > reset methods have not worked well on our platform. Debugging these
> > > > > > > issues is painful in practice, and this interface would make it far
> > > > > > > easier.
> > > > > > >
> > > > > > > Having an interface like this would also help us better communicate the
> > > > > > > issues we find with upstream. Allowing others to more easily test our
> > > > > > > (or other entities') findings should give better visibility into
> > > > > > > which issues apply to the device in general and which are platform
> > > > > > > specific. In disambiguating the former from the latter, we should be
> > > > > > > able to better quirk devices for everyone, and in the latter cases, this
> > > > > > > interface allows for a safer and more elegant solution than any of the
> > > > > > > current alternatives.
> > > > > >
> > > > > > So to summarize, we are talking about test and debug interface to
> > > > > > overcome HW bugs, am I right?
> > > > > >
> > > > > > My personal experience shows that once the easy workaround exists
> > > > > > (and write to generally available sysfs is very simple), the vendors
> > > > > > and users desire for proper fix decreases drastically. IMHO, we will
> > > > > > see increase of copy/paste in SO and blog posts, but reduce in quirks.
> > > > > >
> > > > > > My 2-cents.
> > > > > >
> > > > > I agree with your point but at least it gives the userspace ability
> > > > > to use broken device until bug is fixed in upstream.
> > > >
> > > > As I said, I don't expect many fixes once "userspace" will be able to
> > > > use cheap workaround. There is no incentive to fix it.
> > > >
> > > > > This is also applicable for obscure devices without upstream
> > > > > drivers for example custom FPGA based devices.
> > > >
> > > > This is not relevant to upstream kernel. Those vendors ship everything
> > > > custom, they don't need upstream, we don't need them :)
> > > >
> > > By custom I meant hobbyists who could tinker with their custom FPGA.
> >
> > I invite such hobbyists to send patches and include their FPGA in
> > upstream kernel.
> >
> > >
> > > > > Another main application which I forgot to mention is virtualization
> > > > > where vmm wants to reset the device when the guest is reset,
> > > > > to emulate machine reboot as closely as possible.
> > > >
> > > > It can work in very narrow case, because reset will cause to device
> > > > reprobe and most likely the driver will be different from the one that
> > > > started reset. I can imagine that net devices will lose their state and
> > > > config after such reset too.
> > > >
> > > Not sure if I got that 100% right. The pci_reset_function() function
> > > saves and restores device state over the reset.
> >
> > I'm talking about netdev state, but whatever given the existence of
> > sysfs reset knob.
> >
> > >
> > > > IMHO, it will be saner for everyone if virtualization don't try such resets.
> > > >
> > > > Thanks
> > > >
> > > The exists reset sysfs attribute was added for exactly this case
> > > though.
> >
> > I didn't know the rationale behind that file till you said and I
> > googled libvirt discussion, so ok. Do you propose that libvirt
> > will manage database of devices and their working reset types?
> >
> I don't have much idea about internals of libvirt but why would
> it need to manage database of working reset types? It could just
> read new reset_methods attribute to get the list of supported reset
> methods.

Because the idea of this patch is to read all supported reset types and
allow to the user to chose the working one. The user will do it with
help from StackOverflow, but libvirt will need to have some sort of
database, otherwise it won't be different from simple "echo 1 > reset"
which will iterate over all supported resets anyway.

> > I'm not against this patch, just want to raise an attention that the
> > outcome of this patch will be decrease in fixes of broken devices.
> >
> > Thanks
> >
> That makes sense but that isn't any different from existing reset
> attribute. This patch inhances it and allows selecting a device supported
> reset method instead of using first available reset method according to
> existing hardcoded policy.

The difference here is that this is a workaround to solve bugs that
should be fixed in the kernel.

Thanks

>
> Thanks,
> Amey
