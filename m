Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB217B987
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 10:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgCFJpx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 6 Mar 2020 04:45:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:26681 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgCFJpx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 04:45:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 01:45:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,521,1574150400"; 
   d="scan'208";a="234748382"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 06 Mar 2020 01:45:52 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 6 Mar 2020 01:45:43 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 6 Mar 2020 01:45:43 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.201]) with mapi id 14.03.0439.000;
 Fri, 6 Mar 2020 17:45:40 +0800
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
Thread-Index: AQHV51YaoTnickP570etlLGInd5eAKgrQJIwgA6gtQCAAWITYIAAIt7A
Date:   Fri, 6 Mar 2020 09:45:40 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7C0A43@SHSMSX104.ccr.corp.intel.com>
References: <158213716959.17090.8399427017403507114.stgit@gimli.home>
        <158213846731.17090.37693075723046377.stgit@gimli.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D79A943@SHSMSX104.ccr.corp.intel.com>
 <20200305112230.0dd77712@w520.home> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjY4MTQ2OWItZDU1Ny00ZGViLTk5ODEtODAzYjcxMDY3OWNhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWEFkM0paSjhCUXhKS0JQdHFpWUw0NGhCOElseFk2c1daa3dnYjdwdUVJMzJJSHlIc3Y4MGxveFhmVDFVR0VVZCJ9
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

> From: Tian, Kevin
> Sent: Friday, March 6, 2020 3:57 PM
> 
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, March 6, 2020 2:23 AM
> >
> > On Tue, 25 Feb 2020 03:08:00 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >
> > > > From: Alex Williamson
> > > > Sent: Thursday, February 20, 2020 2:54 AM
> > > >
> > > > With the VF Token interface we can now expect that a vfio userspace
> > > > driver must be in collaboration with the PF driver, an unwitting
> > > > userspace driver will not be able to get past the GET_DEVICE_FD step
> > > > in accessing the device.  We can now move on to actually allowing
> > > > SR-IOV to be enabled by vfio-pci on the PF.  Support for this is not
> > > > enabled by default in this commit, but it does provide a module option
> > > > for this to be enabled (enable_sriov=1).  Enabling VFs is rather
> > > > straightforward, except we don't want to risk that a VF might get
> > > > autoprobed and bound to other drivers, so a bus notifier is used to
> > > > "capture" VFs to vfio-pci using the driver_override support.  We
> > > > assume any later action to bind the device to other drivers is
> > > > condoned by the system admin and allow it with a log warning.
> > > >
> > > > vfio-pci will disable SR-IOV on a PF before releasing the device,
> > > > allowing a VF driver to be assured other drivers cannot take over the
> > > > PF and that any other userspace driver must know the shared VF token.
> > > > This support also does not provide a mechanism for the PF userspace
> > > > driver itself to manipulate SR-IOV through the vfio API.  With this
> > > > patch SR-IOV can only be enabled via the host sysfs interface and the
> > > > PF driver user cannot create or remove VFs.
> > >
> > > I'm not sure how many devices can be properly configured simply
> > > with pci_enable_sriov. It is not unusual to require PF driver prepare
> > > something before turning PCI SR-IOV capability. If you look kernel
> > > PF drivers, there are only two using generic pci_sriov_configure_
> > > simple (simple wrapper like pci_enable_sriov), while most others
> > > implementing their own callback. However vfio itself has no idea
> > > thus I'm not sure how an user knows whether using this option can
> > > actually meet his purpose. I may miss something here, possibly
> > > using DPDK as an example will make it clearer.
> >
> > There is still the entire vfio userspace driver interface.  Imagine for
> > example that QEMU emulates the SR-IOV capability and makes a call out
> > to libvirt (or maybe runs with privs for the PF SR-IOV sysfs attribs)
> > when the guest enables SR-IOV.  Can't we assume that any PF specific
> > support can still be performed in the userspace/guest driver, leaving
> > us with a very simple and generic sriov_configure callback in vfio-pci?
> 
> Makes sense. One concern, though, is how an user could be warned
> if he inadvertently uses sysfs to enable SR-IOV on a vfio device whose
> userspace driver is incapable of handling it. Note any VFIO device,
> if SR-IOV capable, will allow user to do so once the module option is
> turned on and the callback is registered. I felt such uncertainty can be
> contained by toggling SR-IOV through a vfio api, but from your description
> obviously it is what you want to avoid. Is it due to the sequence reason,
> e.g. that SR-IOV must be enabled before userspace PF driver sets the
> token?
> 

reading again I found that you specifically mentioned "the PF driver user 
cannot create or remove VFs.". However I failed to get the rationale 
behind. If the VF drivers have built the trust with the PF driver through
the token, what is the problem of allowing the PF driver to further manage 
SR-IOV itself? suppose any VF removal will be done in a cooperate way
to avoid surprise impact to related VF drivers. then possibly a new vfio
ioctl for setting the VF numbers plus a token from the userspace driver
could also serve the purpose of this patch series (GET_DEVICE_FD + sysfs)?

Thanks
Kevin
