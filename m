Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D1317E2E3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 15:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgCIO4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 10:56:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33824 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726488AbgCIO4n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2020 10:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583765802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODfRe6uEVeZq3vqEM4WfZ+r6PXYR5n68FRLYtTpLTVU=;
        b=cP49DCFnSjEOonKJREbpVz+zeglYAVHOpIgr1J72qUeI9yekI1cIRo3zgpjY83E3B8156o
        WX6LV8zBX+e5BgD1ZqkC49wj8YnGGGM1sIL8ccKBiHdmWiPzeuOg08w0XfyZKDRvdlZ9iw
        xpgYdGILMdc4XRKL+cacjoVNEyO1pOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-IbxpYgV8PpCV01KNoee4PA-1; Mon, 09 Mar 2020 10:56:37 -0400
X-MC-Unique: IbxpYgV8PpCV01KNoee4PA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A8AA1005509;
        Mon,  9 Mar 2020 14:56:36 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B21675D9CA;
        Mon,  9 Mar 2020 14:56:32 +0000 (UTC)
Date:   Mon, 9 Mar 2020 08:56:32 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dev@dpdk.org" <dev@dpdk.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "thomas@monjalon.net" <thomas@monjalon.net>,
        "bluca@debian.org" <bluca@debian.org>,
        "jerinjacobk@gmail.com" <jerinjacobk@gmail.com>,
        "Richardson, Bruce" <bruce.richardson@intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>
Subject: Re: [PATCH v2 5/7] vfio/pci: Add sriov_configure support
Message-ID: <20200309085632.32a1e07d@w520.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7C36CC@SHSMSX104.ccr.corp.intel.com>
References: <158213716959.17090.8399427017403507114.stgit@gimli.home>
        <158213846731.17090.37693075723046377.stgit@gimli.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D79A943@SHSMSX104.ccr.corp.intel.com>
        <20200305112230.0dd77712@w520.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7C07A0@SHSMSX104.ccr.corp.intel.com>
        <20200306151734.741d1d58@x1.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7C208E@SHSMSX104.ccr.corp.intel.com>
        <20200308184610.647b70f4@x1.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7C36CC@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 9 Mar 2020 01:48:11 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson
> > Sent: Monday, March 9, 2020 8:46 AM
> >=20
> > On Sat, 7 Mar 2020 01:35:23 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >  =20
> > > > From: Alex Williamson
> > > > Sent: Saturday, March 7, 2020 6:18 AM
> > > >
> > > > On Fri, 6 Mar 2020 07:57:19 +0000
> > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > =20
> > > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > > Sent: Friday, March 6, 2020 2:23 AM
> > > > > >
> > > > > > On Tue, 25 Feb 2020 03:08:00 +0000
> > > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > > > =20
> > > > > > > > From: Alex Williamson
> > > > > > > > Sent: Thursday, February 20, 2020 2:54 AM
> > > > > > > >
> > > > > > > > With the VF Token interface we can now expect that a vfio =
=20
> > userspace =20
> > > > > > > > driver must be in collaboration with the PF driver, an unwi=
tting
> > > > > > > > userspace driver will not be able to get past the GET_DEVIC=
E_FD =20
> > step =20
> > > > > > > > in accessing the device.  We can now move on to actually al=
lowing
> > > > > > > > SR-IOV to be enabled by vfio-pci on the PF.  Support for th=
is is not
> > > > > > > > enabled by default in this commit, but it does provide a mo=
dule =20
> > > > option =20
> > > > > > > > for this to be enabled (enable_sriov=3D1).  Enabling VFs is=
 rather
> > > > > > > > straightforward, except we don't want to risk that a VF mig=
ht get
> > > > > > > > autoprobed and bound to other drivers, so a bus notifier is=
 used =20
> > to =20
> > > > > > > > "capture" VFs to vfio-pci using the driver_override support=
.  We
> > > > > > > > assume any later action to bind the device to other drivers=
 is
> > > > > > > > condoned by the system admin and allow it with a log warnin=
g.
> > > > > > > >
> > > > > > > > vfio-pci will disable SR-IOV on a PF before releasing the d=
evice,
> > > > > > > > allowing a VF driver to be assured other drivers cannot tak=
e over =20
> > the =20
> > > > > > > > PF and that any other userspace driver must know the shared=
 VF =20
> > > > token. =20
> > > > > > > > This support also does not provide a mechanism for the PF =
=20
> > userspace =20
> > > > > > > > driver itself to manipulate SR-IOV through the vfio API.  W=
ith this
> > > > > > > > patch SR-IOV can only be enabled via the host sysfs interfa=
ce and =20
> > the =20
> > > > > > > > PF driver user cannot create or remove VFs. =20
> > > > > > >
> > > > > > > I'm not sure how many devices can be properly configured simp=
ly
> > > > > > > with pci_enable_sriov. It is not unusual to require PF driver=
 prepare
> > > > > > > something before turning PCI SR-IOV capability. If you look k=
ernel
> > > > > > > PF drivers, there are only two using generic pci_sriov_config=
ure_
> > > > > > > simple (simple wrapper like pci_enable_sriov), while most oth=
ers
> > > > > > > implementing their own callback. However vfio itself has no i=
dea
> > > > > > > thus I'm not sure how an user knows whether using this option=
 can
> > > > > > > actually meet his purpose. I may miss something here, possibly
> > > > > > > using DPDK as an example will make it clearer. =20
> > > > > >
> > > > > > There is still the entire vfio userspace driver interface.  Ima=
gine for
> > > > > > example that QEMU emulates the SR-IOV capability and makes a ca=
ll =20
> > out =20
> > > > > > to libvirt (or maybe runs with privs for the PF SR-IOV sysfs at=
tribs)
> > > > > > when the guest enables SR-IOV.  Can't we assume that any PF spe=
cific
> > > > > > support can still be performed in the userspace/guest driver, l=
eaving
> > > > > > us with a very simple and generic sriov_configure callback in v=
fio-pci? =20
> > > > >
> > > > > Makes sense. One concern, though, is how an user could be warned
> > > > > if he inadvertently uses sysfs to enable SR-IOV on a vfio device =
whose
> > > > > userspace driver is incapable of handling it. Note any VFIO devic=
e,
> > > > > if SR-IOV capable, will allow user to do so once the module optio=
n is
> > > > > turned on and the callback is registered. I felt such uncertainty=
 can be
> > > > > contained by toggling SR-IOV through a vfio api, but from your =20
> > description =20
> > > > > obviously it is what you want to avoid. Is it due to the sequence=
 reason,
> > > > > e.g. that SR-IOV must be enabled before userspace PF driver sets =
the
> > > > > token? =20
> > > >
> > > > As in my other reply, enabling SR-IOV via a vfio API suggests that
> > > > we're not only granting the user owning the PF device access to the
> > > > device itself, but also the ability to create and remove subordinate
> > > > devices on the host.  That implies an extended degree of trust in t=
he
> > > > user beyond the PF device itself and raises questions about whether=
 a
> > > > user who is allowed to create VF devices should automatically be
> > > > granted access to those VF devices, what the mechanism would be for
> > > > that, and how we might re-assign those devices to other users,
> > > > potentially including host kernel usage.  What I'm proposing here
> > > > doesn't preclude some future extension in that direction, but inste=
ad
> > > > tries to simplify a first step towards enabling SR-IOV by leaving t=
he
> > > > SR-IOV enablement and VF assignment in the realm of a privileged sy=
stem
> > > > entity. =20
> > >
> > > the intention is clear to me now.
> > > =20
> > > >
> > > > So, what I think you're suggesting here is that we should restrict
> > > > vfio_pci_sriov_configure() to reject enabling SR-IOV until a user
> > > > driver has configured a VF token.  That requires both that the
> > > > userspace driver has initialized to this point before SR-IOV can be
> > > > enabled and that we would be forced to define a termination point f=
or
> > > > the user set VF token.  Logically, this would need to be when the
> > > > userspace driver exits or closes the PF device, which implies that =
we
> > > > need to disable SR-IOV on the PF at this point, or we're left in an
> > > > inconsistent state where VFs are enabled but cannot be disabled bec=
ause
> > > > we don't have a valid VF token.  Now we're back to nearly a state w=
here
> > > > the user has control of not creating devices on the host, but remov=
ing
> > > > them by closing the device, which will necessarily require that any=
 VF
> > > > driver release the device, whether userspace or kernel.
> > > >
> > > > I'm not sure what we're gaining by doing this though.  I agree that
> > > > there will be users that enable SR-IOV on a PF and then try to, for
> > > > example, assign the PF and all the VFs to a VM.  The VFs will fail =
due
> > > > to lacking VF token support, unless they've patch QEMU with my test
> > > > code, but depending on the PF driver in the guest, it may, or more
> > > > likely won't work.  But don't you think the VFs and probably PF not
> > > > working is a sufficient clue that the configuration is invalid?  OT=
OH,
> > > > from what I've heard of the device in the ID table of the pci-pf-st=
ub
> > > > driver, they might very well be able to work with both PF and VFs in
> > > > QEMU using only my test code to set the VF token.
> > > >
> > > > Therefore, I'm afraid what you're asking for here is to impose a us=
age
> > > > restriction as a sanity test, when we don't really know what might =
be
> > > > sane for this particular piece of hardware or use case.  There are
> > > > infinite ways that a vfio based userspace driver can fail to config=
ure
> > > > their hardware and make it work correctly, many of them are device
> > > > specific.  Isn't this just one of those cases?  Thanks,
> > > > =20
> > >
> > > what you said all makes sense. so I withdraw the idea of manipulating
> > > SR-IOV through vfio ioctl. However I still feel that simply registeri=
ng
> > > sriov_configuration callback by vfio-pci somehow violates the typical
> > > expectation of the sysfs interface. Before this patch, the success re=
turn
> > > of writing non-zero value to numvfs implies VFs are in sane state and
> > > functionally ready for immediate use. However now the behavior of
> > > success return becomes undefined for vfio devices, since even vfio-pci
> > > itself doesn't know whether VFs are functional for a random device
> > > (may know some if carrying the same device IDs from pci-pf-stub). It
> > > simply relies on the privileged entity who knows exactly the implicat=
ion
> > > of such write, while there is no way to warn inadvertent users which
> > > to me is not a good design from kernel API p.o.v. Of course we may
> > > document such restriction and the driver_override may also be an
> > > indirect way to warn such user if he wants to use VFs for other purpo=
se.
> > > But it is still less elegant than reporting it in the first place. Ma=
ybe
> > > what we really require is a new sysfs attribute purely for enabling
> > > PCI SR-IOV capability, which doesn't imply making VFs actually
> > > functional as did through the existing numvfs? =20
> >=20
> > I don't read the same guarantee into the sysfs SR-IOV interface.  If
> > such a guarantee exists, it's already broken by pci-pf-stub, which like
> > vfio-pci allows dynamic IDs and driver_override to bind to any PF device
> > allowing the ability to create (potentially) non-functional VFs.  I =20
>=20
> I don't know whether others raised the similar concern and how=20
> it was addressed for pci-pf-stub before. Many places describe=20
> numvfs as the preferred interface to enable/disable VFs while=20
> 'enable' just reads functional to me.

=46rom a PCI perspective, they are functional.  We've enabled them in the
sense that they appear on the bus.  Whether they are functional or not
depends on device specific configuration.  If I take your definition to
an extreme, it seems that we might for example not allow SR-IOV to be
enabled unless an 82576 PF has the network link up because the VF
wouldn't be able to route packets until that point.  Do we require that
the igb PF driver generates a warning that VFs might not be functional
if the link is down when SR-IOV is enabled?  I'm absolutely not
recommending we do this, I'm just pointing out that I think a different
standard is being suggested here than actually exists.  Thanks,

Alex

