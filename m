Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB517D7F0
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 02:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCIBsR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 8 Mar 2020 21:48:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:40716 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCIBsQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 8 Mar 2020 21:48:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2020 18:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,530,1574150400"; 
   d="scan'208";a="235519784"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 08 Mar 2020 18:48:15 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 8 Mar 2020 18:48:14 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 8 Mar 2020 18:48:14 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.86]) with mapi id 14.03.0439.000;
 Mon, 9 Mar 2020 09:48:12 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dev@dpdk.org" <dev@dpdk.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "thomas@monjalon.net" <thomas@monjalon.net>,
        "bluca@debian.org" <bluca@debian.org>,
        "jerinjacobk@gmail.com" <jerinjacobk@gmail.com>,
        "Richardson, Bruce" <bruce.richardson@intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>
Subject: RE: [PATCH v2 5/7] vfio/pci: Add sriov_configure support
Thread-Topic: [PATCH v2 5/7] vfio/pci: Add sriov_configure support
Thread-Index: AQHV51YaoTnickP570etlLGInd5eAKgrQJIwgA6gtQCAAWITYIAAce8AgAC1CGCAApkmAIAAk+rQ
Date:   Mon, 9 Mar 2020 01:48:11 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7C36CC@SHSMSX104.ccr.corp.intel.com>
References: <158213716959.17090.8399427017403507114.stgit@gimli.home>
        <158213846731.17090.37693075723046377.stgit@gimli.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D79A943@SHSMSX104.ccr.corp.intel.com>
        <20200305112230.0dd77712@w520.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7C07A0@SHSMSX104.ccr.corp.intel.com>
        <20200306151734.741d1d58@x1.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7C208E@SHSMSX104.ccr.corp.intel.com>
 <20200308184610.647b70f4@x1.home>
In-Reply-To: <20200308184610.647b70f4@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGYxODZjNmYtZTFhMS00ZjA5LThlYzAtYTY0YTJhODQyMDhmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNE9Ga2VCUUh3NWt4NjllSVZpb1FYczg0VVBBZ3Nnc291SngwWVVXV2Rad0F2Z3ZXU0pZTzVRTDA3WGdSbmk4SCJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Alex Williamson
> Sent: Monday, March 9, 2020 8:46 AM
> 
> On Sat, 7 Mar 2020 01:35:23 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Alex Williamson
> > > Sent: Saturday, March 7, 2020 6:18 AM
> > >
> > > On Fri, 6 Mar 2020 07:57:19 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >
> > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > Sent: Friday, March 6, 2020 2:23 AM
> > > > >
> > > > > On Tue, 25 Feb 2020 03:08:00 +0000
> > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > >
> > > > > > > From: Alex Williamson
> > > > > > > Sent: Thursday, February 20, 2020 2:54 AM
> > > > > > >
> > > > > > > With the VF Token interface we can now expect that a vfio
> userspace
> > > > > > > driver must be in collaboration with the PF driver, an unwitting
> > > > > > > userspace driver will not be able to get past the GET_DEVICE_FD
> step
> > > > > > > in accessing the device.  We can now move on to actually allowing
> > > > > > > SR-IOV to be enabled by vfio-pci on the PF.  Support for this is not
> > > > > > > enabled by default in this commit, but it does provide a module
> > > option
> > > > > > > for this to be enabled (enable_sriov=1).  Enabling VFs is rather
> > > > > > > straightforward, except we don't want to risk that a VF might get
> > > > > > > autoprobed and bound to other drivers, so a bus notifier is used
> to
> > > > > > > "capture" VFs to vfio-pci using the driver_override support.  We
> > > > > > > assume any later action to bind the device to other drivers is
> > > > > > > condoned by the system admin and allow it with a log warning.
> > > > > > >
> > > > > > > vfio-pci will disable SR-IOV on a PF before releasing the device,
> > > > > > > allowing a VF driver to be assured other drivers cannot take over
> the
> > > > > > > PF and that any other userspace driver must know the shared VF
> > > token.
> > > > > > > This support also does not provide a mechanism for the PF
> userspace
> > > > > > > driver itself to manipulate SR-IOV through the vfio API.  With this
> > > > > > > patch SR-IOV can only be enabled via the host sysfs interface and
> the
> > > > > > > PF driver user cannot create or remove VFs.
> > > > > >
> > > > > > I'm not sure how many devices can be properly configured simply
> > > > > > with pci_enable_sriov. It is not unusual to require PF driver prepare
> > > > > > something before turning PCI SR-IOV capability. If you look kernel
> > > > > > PF drivers, there are only two using generic pci_sriov_configure_
> > > > > > simple (simple wrapper like pci_enable_sriov), while most others
> > > > > > implementing their own callback. However vfio itself has no idea
> > > > > > thus I'm not sure how an user knows whether using this option can
> > > > > > actually meet his purpose. I may miss something here, possibly
> > > > > > using DPDK as an example will make it clearer.
> > > > >
> > > > > There is still the entire vfio userspace driver interface.  Imagine for
> > > > > example that QEMU emulates the SR-IOV capability and makes a call
> out
> > > > > to libvirt (or maybe runs with privs for the PF SR-IOV sysfs attribs)
> > > > > when the guest enables SR-IOV.  Can't we assume that any PF specific
> > > > > support can still be performed in the userspace/guest driver, leaving
> > > > > us with a very simple and generic sriov_configure callback in vfio-pci?
> > > >
> > > > Makes sense. One concern, though, is how an user could be warned
> > > > if he inadvertently uses sysfs to enable SR-IOV on a vfio device whose
> > > > userspace driver is incapable of handling it. Note any VFIO device,
> > > > if SR-IOV capable, will allow user to do so once the module option is
> > > > turned on and the callback is registered. I felt such uncertainty can be
> > > > contained by toggling SR-IOV through a vfio api, but from your
> description
> > > > obviously it is what you want to avoid. Is it due to the sequence reason,
> > > > e.g. that SR-IOV must be enabled before userspace PF driver sets the
> > > > token?
> > >
> > > As in my other reply, enabling SR-IOV via a vfio API suggests that
> > > we're not only granting the user owning the PF device access to the
> > > device itself, but also the ability to create and remove subordinate
> > > devices on the host.  That implies an extended degree of trust in the
> > > user beyond the PF device itself and raises questions about whether a
> > > user who is allowed to create VF devices should automatically be
> > > granted access to those VF devices, what the mechanism would be for
> > > that, and how we might re-assign those devices to other users,
> > > potentially including host kernel usage.  What I'm proposing here
> > > doesn't preclude some future extension in that direction, but instead
> > > tries to simplify a first step towards enabling SR-IOV by leaving the
> > > SR-IOV enablement and VF assignment in the realm of a privileged system
> > > entity.
> >
> > the intention is clear to me now.
> >
> > >
> > > So, what I think you're suggesting here is that we should restrict
> > > vfio_pci_sriov_configure() to reject enabling SR-IOV until a user
> > > driver has configured a VF token.  That requires both that the
> > > userspace driver has initialized to this point before SR-IOV can be
> > > enabled and that we would be forced to define a termination point for
> > > the user set VF token.  Logically, this would need to be when the
> > > userspace driver exits or closes the PF device, which implies that we
> > > need to disable SR-IOV on the PF at this point, or we're left in an
> > > inconsistent state where VFs are enabled but cannot be disabled because
> > > we don't have a valid VF token.  Now we're back to nearly a state where
> > > the user has control of not creating devices on the host, but removing
> > > them by closing the device, which will necessarily require that any VF
> > > driver release the device, whether userspace or kernel.
> > >
> > > I'm not sure what we're gaining by doing this though.  I agree that
> > > there will be users that enable SR-IOV on a PF and then try to, for
> > > example, assign the PF and all the VFs to a VM.  The VFs will fail due
> > > to lacking VF token support, unless they've patch QEMU with my test
> > > code, but depending on the PF driver in the guest, it may, or more
> > > likely won't work.  But don't you think the VFs and probably PF not
> > > working is a sufficient clue that the configuration is invalid?  OTOH,
> > > from what I've heard of the device in the ID table of the pci-pf-stub
> > > driver, they might very well be able to work with both PF and VFs in
> > > QEMU using only my test code to set the VF token.
> > >
> > > Therefore, I'm afraid what you're asking for here is to impose a usage
> > > restriction as a sanity test, when we don't really know what might be
> > > sane for this particular piece of hardware or use case.  There are
> > > infinite ways that a vfio based userspace driver can fail to configure
> > > their hardware and make it work correctly, many of them are device
> > > specific.  Isn't this just one of those cases?  Thanks,
> > >
> >
> > what you said all makes sense. so I withdraw the idea of manipulating
> > SR-IOV through vfio ioctl. However I still feel that simply registering
> > sriov_configuration callback by vfio-pci somehow violates the typical
> > expectation of the sysfs interface. Before this patch, the success return
> > of writing non-zero value to numvfs implies VFs are in sane state and
> > functionally ready for immediate use. However now the behavior of
> > success return becomes undefined for vfio devices, since even vfio-pci
> > itself doesn't know whether VFs are functional for a random device
> > (may know some if carrying the same device IDs from pci-pf-stub). It
> > simply relies on the privileged entity who knows exactly the implication
> > of such write, while there is no way to warn inadvertent users which
> > to me is not a good design from kernel API p.o.v. Of course we may
> > document such restriction and the driver_override may also be an
> > indirect way to warn such user if he wants to use VFs for other purpose.
> > But it is still less elegant than reporting it in the first place. Maybe
> > what we really require is a new sysfs attribute purely for enabling
> > PCI SR-IOV capability, which doesn't imply making VFs actually
> > functional as did through the existing numvfs?
> 
> I don't read the same guarantee into the sysfs SR-IOV interface.  If
> such a guarantee exists, it's already broken by pci-pf-stub, which like
> vfio-pci allows dynamic IDs and driver_override to bind to any PF device
> allowing the ability to create (potentially) non-functional VFs.  I

I don't know whether others raised the similar concern and how 
it was addressed for pci-pf-stub before. Many places describe 
numvfs as the preferred interface to enable/disable VFs while 
'enable' just reads functional to me.

> think it would be a really bad decision to fork a new sysfs interface
> for this.  I've already made SR-IOV support in vfio-pci an opt-in via a
> module option, would it ease your concerns if I elaborate in the text
> for the option that enabling SR-IOV may depend on support provided by a
> vfio-pci userspace driver?

Sure.

> 
> I think that without absolutely knowing that an operation is incorrect,
> we're just generating noise and confusion by triggering warnings or
> developing alternate interfaces.  Unfortunately, we have no generic
> means of knowing that an operation is incorrect, so I assume the best.
> Thanks,
> 
> Alex

