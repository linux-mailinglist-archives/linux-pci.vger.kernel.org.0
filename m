Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F78F33F6E0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCQRcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 13:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhCQRbt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 13:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616002308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VCRl2Ujnoj9GFNl34NOOZgQ2wSo/22DbU8Ct//+Bg64=;
        b=e9pMxI15vJBrzPDj7Adg2IALu1LWbdr1cf4/1s061CVJbMej4DpQEhtvuuF82JlH/YvTUf
        vDZSTlh/8bO/Dpstv76sFVDswE5xdKsKlqNI7Nzop5bQiWCUsSUddGvkcXP4266SJM31lu
        gR2tT4Q5FpN6kkyboV7UfmUBvXA4iKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-of7mWQo-PZKuQB54u5qxvQ-1; Wed, 17 Mar 2021 13:31:44 -0400
X-MC-Unique: of7mWQo-PZKuQB54u5qxvQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD061107B7C4;
        Wed, 17 Mar 2021 17:31:42 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com [10.3.112.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 126D25D9D3;
        Wed, 17 Mar 2021 17:31:42 +0000 (UTC)
Date:   Wed, 17 Mar 2021 11:31:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210317113140.3de56d6c@omen.home.shazbot.org>
In-Reply-To: <YFILEOQBOLgOy3cy@unreal>
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
        <YFILEOQBOLgOy3cy@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Mar 2021 15:58:40 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Wed, Mar 17, 2021 at 06:47:18PM +0530, Amey Narkhede wrote:
> > On 21/03/17 01:47PM, Leon Romanovsky wrote: =20
> > > On Wed, Mar 17, 2021 at 04:53:09PM +0530, Amey Narkhede wrote: =20
> > > > On 21/03/17 01:02PM, Leon Romanovsky wrote: =20
> > > > > On Wed, Mar 17, 2021 at 03:54:47PM +0530, Amey Narkhede wrote: =20
> > > > > > On 21/03/17 06:20AM, Leon Romanovsky wrote: =20
> > > > > > > On Mon, Mar 15, 2021 at 06:32:32PM +0000, Raphael Norwitz wro=
te: =20
> > > > > > > > On Mon, Mar 15, 2021 at 10:29:50AM -0600, Alex Williamson w=
rote: =20
> > > > > > > > > On Mon, 15 Mar 2021 21:03:41 +0530
> > > > > > > > > Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> > > > > > > > > =20
> > > > > > > > > > On 21/03/15 05:07PM, Leon Romanovsky wrote: =20
> > > > > > > > > > > On Mon, Mar 15, 2021 at 08:34:09AM -0600, Alex Willia=
mson wrote: =20
> > > > > > > > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > > > > =20
> > > > > > > > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wr=
ote: =20
> > > > > > > > > > > > > > slot reset (pci_dev_reset_slot_function) and se=
condary bus
> > > > > > > > > > > > > > reset(pci_parent_bus_reset) which I think are h=
ot reset and
> > > > > > > > > > > > > > warm reset respectively. =20
> > > > > > > > > > > > >
> > > > > > > > > > > > > No. PCI secondary bus reset =3D PCIe Hot Reset. S=
lot reset is just another
> > > > > > > > > > > > > type of reset, which is currently implemented onl=
y for PCIe hot plug
> > > > > > > > > > > > > bridges and for PowerPC PowerNV platform and it j=
ust call PCI secondary
> > > > > > > > > > > > > bus reset with some other hook. PCIe Warm Reset d=
oes not have API in
> > > > > > > > > > > > > kernel and therefore drivers do not export this t=
ype of reset via any
> > > > > > > > > > > > > kernel function (yet). =20
> > > > > > > > > > > >
> > > > > > > > > > > > Warm reset is beyond the scope of this series, but =
could be implemented
> > > > > > > > > > > > in a compatible way to fit within the pci_reset_fn_=
methods[] array
> > > > > > > > > > > > defined here.  Note that with this series the reset=
s available through
> > > > > > > > > > > > pci_reset_function() and the per device reset attri=
bute is sysfs remain
> > > > > > > > > > > > exactly the same as they are currently.  The bus an=
d slot reset
> > > > > > > > > > > > methods used here are limited to devices where only=
 a single function is
> > > > > > > > > > > > affected by the reset, therefore it is not like the=
 patch you proposed
> > > > > > > > > > > > which performed a reset irrespective of the downstr=
eam devices.  This
> > > > > > > > > > > > series only enables selection of the existing metho=
ds.  Thanks, =20
> > > > > > > > > > >
> > > > > > > > > > > Alex,
> > > > > > > > > > >
> > > > > > > > > > > I asked the patch author here [1], but didn't get any=
 response, maybe
> > > > > > > > > > > you can answer me. What is the use case scenario for =
this functionality?
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > > >
> > > > > > > > > > > [1] https://lore.kernel.org/lkml/YE389lAqjJSeTolM@unr=
eal/
> > > > > > > > > > > =20
> > > > > > > > > > Sorry for not responding immediately. There were some b=
uggy wifi cards
> > > > > > > > > > which needed FLR explicitly not sure if that behavior i=
s fixed in
> > > > > > > > > > drivers. Also there is use a case at Nutanix but the en=
gineer who
> > > > > > > > > > is involved is on PTO that is why I did not respond imm=
ediately as
> > > > > > > > > > I don't know the details yet. =20
> > > > > > > > >
> > > > > > > > > And more generally, devices continue to have reset issues=
 and we
> > > > > > > > > impose a fixed priority in our ordering.  We can and prob=
ably should
> > > > > > > > > continue to quirk devices when we find broken resets so t=
hat we have
> > > > > > > > > the best default behavior, but it's currently not easy fo=
r an end user
> > > > > > > > > to experiment, ie. this reset works, that one doesn't.  W=
e might also
> > > > > > > > > have platform issues where a given reset works better on =
a certain
> > > > > > > > > platform.  Exposing a way to test these things might lead=
 to better
> > > > > > > > > quirks.  In the case I think Pali was looking for, they w=
anted a
> > > > > > > > > mechanism to force a bus reset, if this was in reference =
to a single
> > > > > > > > > function device, this could be accomplished by setting a =
priority for
> > > > > > > > > that mechanism, which would translate to not only the sys=
fs reset
> > > > > > > > > attribute, but also the reset mechanism used by vfio-pci.=
  Thanks,
> > > > > > > > >
> > > > > > > > > Alex
> > > > > > > > > =20
> > > > > > > >
> > > > > > > > To confirm from our end - we have seen many such instances =
where default
> > > > > > > > reset methods have not worked well on our platform. Debuggi=
ng these
> > > > > > > > issues is painful in practice, and this interface would mak=
e it far
> > > > > > > > easier.
> > > > > > > >
> > > > > > > > Having an interface like this would also help us better com=
municate the
> > > > > > > > issues we find with upstream. Allowing others to more easil=
y test our
> > > > > > > > (or other entities') findings should give better visibility=
 into
> > > > > > > > which issues apply to the device in general and which are p=
latform
> > > > > > > > specific. In disambiguating the former from the latter, we =
should be
> > > > > > > > able to better quirk devices for everyone, and in the latte=
r cases, this
> > > > > > > > interface allows for a safer and more elegant solution than=
 any of the
> > > > > > > > current alternatives. =20
> > > > > > >
> > > > > > > So to summarize, we are talking about test and debug interfac=
e to
> > > > > > > overcome HW bugs, am I right?
> > > > > > >
> > > > > > > My personal experience shows that once the easy workaround ex=
ists
> > > > > > > (and write to generally available sysfs is very simple), the =
vendors
> > > > > > > and users desire for proper fix decreases drastically. IMHO, =
we will
> > > > > > > see increase of copy/paste in SO and blog posts, but reduce i=
n quirks.
> > > > > > >
> > > > > > > My 2-cents.
> > > > > > > =20
> > > > > > I agree with your point but at least it gives the userspace abi=
lity
> > > > > > to use broken device until bug is fixed in upstream. =20
> > > > >
> > > > > As I said, I don't expect many fixes once "userspace" will be abl=
e to
> > > > > use cheap workaround. There is no incentive to fix it.

We can increase the annoyance factor of using a modified set of reset
methods, but ultimately we can only control what goes into our kernel,
other kernels might take v1 of this series and incorporate it
regardless of what happens here.

> > > > > > This is also applicable for obscure devices without upstream
> > > > > > drivers for example custom FPGA based devices. =20
> > > > >
> > > > > This is not relevant to upstream kernel. Those vendors ship every=
thing
> > > > > custom, they don't need upstream, we don't need them :)
> > > > > =20
> > > > By custom I meant hobbyists who could tinker with their custom FPGA=
. =20
> > >
> > > I invite such hobbyists to send patches and include their FPGA in
> > > upstream kernel.

This is potentially another good use case, how receptive are we going
to be to an FPGA design that botches a reset.  Do they have a valid
device ID for us to base a quirk on, are they just squatting on one, or
using the default from a library.  Maybe the next bitstream will
resolve it, maybe without any external indication.  IOW, what would the
quality level be for that quirk versus using this as a workaround,
where the user probably wouldn't mind a kernel nag?

> > > > > > Another main application which I forgot to mention is virtualiz=
ation
> > > > > > where vmm wants to reset the device when the guest is reset,
> > > > > > to emulate machine reboot as closely as possible. =20
> > > > >
> > > > > It can work in very narrow case, because reset will cause to devi=
ce
> > > > > reprobe and most likely the driver will be different from the one=
 that
> > > > > started reset. I can imagine that net devices will lose their sta=
te and
> > > > > config after such reset too.
> > > > > =20
> > > > Not sure if I got that 100% right. The pci_reset_function() function
> > > > saves and restores device state over the reset. =20
> > >
> > > I'm talking about netdev state, but whatever given the existence of
> > > sysfs reset knob.
> > > =20
> > > > =20
> > > > > IMHO, it will be saner for everyone if virtualization don't try s=
uch resets.

That would cause a massive regression in device assignment support.  As
with other sysfs attributes, triggering them alongside a running driver
is probably not going to end well.  However, pci_reset_function() is
extremely useful for stopping devices and returning them to a default
state, when either rebooting a VM or returning the device to the host.
The device is not removed and re-probed when this occurs, vfio-pci is
able to hold onto the device across these actions.  Sure, don't reset a
netdev device when it's in use, that's not what these are used for.

> > > > The exists reset sysfs attribute was added for exactly this case
> > > > though. =20
> > >
> > > I didn't know the rationale behind that file till you said and I
> > > googled libvirt discussion, so ok. Do you propose that libvirt
> > > will manage database of devices and their working reset types?
> > > =20
> > I don't have much idea about internals of libvirt but why would
> > it need to manage database of working reset types? It could just
> > read new reset_methods attribute to get the list of supported reset
> > methods. =20
>=20
> Because the idea of this patch is to read all supported reset types and
> allow to the user to chose the working one. The user will do it with
> help from StackOverflow, but libvirt will need to have some sort of
> database, otherwise it won't be different from simple "echo 1 > reset"
> which will iterate over all supported resets anyway.

AFAIK, libvirt no longer attempts to do resets itself, or is at least
moving in that direction.  vfio-pci will reset as device when they're
opened by a user (when available) or triggered via the API.

> > > I'm not against this patch, just want to raise an attention that the
> > > outcome of this patch will be decrease in fixes of broken devices.
> > >
> > > Thanks
> > > =20
> > That makes sense but that isn't any different from existing reset
> > attribute. This patch inhances it and allows selecting a device support=
ed
> > reset method instead of using first available reset method according to
> > existing hardcoded policy. =20
>=20
> The difference here is that this is a workaround to solve bugs that
> should be fixed in the kernel.

If we want to discourage using this as a primary means to resolve reset
issues on a device then we can create log warnings any time it's used.
Downstreams that really want this functionality are going to take this
patch from the list whether we accept it or not.  As above, it seems
there are valid use cases.  Even with mainstream vfio in QEMU, I go
through some hoops trying to determine if I can do a secondary bus
reset rather than a PM reset because it's not specified anywhere what a
"soft reset" means for any given device.  This sort of interface could
make it easier to apply a system policy that a pci_reset_function()
should always perform a secondary bus reset if the only other option is
a PM reset.  Maybe that policy mostly makes sense for a VM use case, so
we'd want one policy by default and another when the device is used for
this functionality.  How could we accomplish that with a quirk?  Thanks,

Alex

