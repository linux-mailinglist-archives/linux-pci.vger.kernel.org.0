Return-Path: <linux-pci+bounces-532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D6F80617F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 23:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526A6282343
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD2A6D1D2;
	Tue,  5 Dec 2023 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiOFt1Kg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A3C181
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 14:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701814448; x=1733350448;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1tuUaBHCLAmHNSuSoBrqf/QRUE2qfW7DlZ0RUlKMOzw=;
  b=EiOFt1KgnWoYFS3KJ36FMQqq4bfEYkBoJq8c/Fi0UGPPj/B48C0rb+P1
   vU/6sULou4vKnSBZkSVUDTqp4R0sazsz9NYll/6/KPZs9Eg9bEywKguYb
   Sqcc/kG25Bv0rKvMT74djcvsgxMbiIFkwV7JDBbDcsinFJjDtUbIcKp4Q
   uWfZJANWb6Q8WBivWT77p6excI0fqDKH1ulN3emgjnkJ17PUJLFEMIzq6
   sZ9QsyOxGWZ2LO2ZTeNLmWUD7t+D0CHfg/HcutH01aTcb1G0UH4iLh+KN
   +Du6h5Pk6emLsDFFdV63l+16BcIPsMp48F+HLLBuUKXNvyeF+Q36hgthE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373429250"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="373429250"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 14:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944419633"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="944419633"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 14:14:05 -0800
Message-ID: <2728ad9d38442510c5e0c8174d0f7aae6ff247ac.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on
 VMD rootports
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Date: Tue, 05 Dec 2023 15:20:27 -0700
In-Reply-To: <20231202000704.GA529403@bhelgaas>
References: <20231202000704.GA529403@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2023-12-01 at 18:07 -0600, Bjorn Helgaas wrote:
> On Mon, Nov 27, 2023 at 04:17:29PM -0500, Nirmal Patel wrote:
> > Currently VMD copies root bridge setting to enable Hotplug on its
> > rootports. This mechanism works fine for Host OS and no issue has
> > been observed. However in case of VM, all the HyperVisors don't
> > pass the Hotplug setting to the guest BIOS which results in
> > assigning default values and disabling Hotplug capability in the
> > guest which have been observed by many OEMs.
> 
> Can we make this a little more specific?  I'm lacking a lot of
> virtualization background here, so I'm going to ask a bunch of stupid
> questions here:
> 
> "VMD copies root bridge setting" refers to _OSC and the copying done
> in vmd_copy_host_bridge_flags()?  Obviously this must be in the Host
> OS.
Yes. we are talking about vmd_copy_host_bridge_flags. It gets called in
both Host and Guest. But it assigns different values. In Host, it
assigns correct values, while in guest it assigns power-on default
value 0 which in simple term disable everything including hotplug.
> 
> "This mechanism works fine for Host OS and no issue has been
> observed."  I guess this means that if the platform grants hotplug
> control to the Host OS via _OSC, pciehp in the Host OS works fine to
> manage hotplug on Root Ports below the VMD?
Yes. When platform hotplug setting is enabled, then _OSC assigns
correct value to vmd root ports via vmd_copy_host_bridge_flags.
> 
> If the platform does *not* grant hotplug control to the Host OS, I
> guess it means the Host OS pciehp can *not* manage hotplug below VMD?
> Is that also what you expect?
> 
> "However in case of VM, all the HyperVisors don't pass the Hotplug
> setting to the guest BIOS"  What is the mechanism by which they would
> pass the hotplug setting?  I guess the guest probably doesn't see the
> VMD endpoint itself, right?  The guest sees either virtualized or
> passed-through VMD Root Ports?
In guest, vmd is passthrough including pci topology behind vmd. The way
we verify Hotplug capability is to read Slot Capabilities registers'
hotplug enabled bit set on vmd root ports in Guest.
 
The values copied in vmd_copy_host_bridge_flags are different in Host
than in Guest. I do not know what component is responsible for this in
every HyperVisor. But I tested this in ESXi, HyperV, KVM and they all
had the same behavior where the _OSC flags are set to power-on default
values of 0 by vmd_copy_host_bridge_flags in Guest OS which is
disabling hotplug.
> 
> I assume the guest OS sees a constructed ACPI system (different from
> the ACPI environment the host sees), so it sees a PNP0A03 host bridge
> with _OSC?  And presumably VMD Root Ports below that host bridge?
> 
> So are you saying the _OSC seen by the guest doesn't grant hotplug
> control to the guest OS?  And it doesn't do that because the guest
> BIOS hasn't implemented _OSC?  Or maybe the guest BIOS relies on the
> Slot Capabilities registers of VMD Root Ports to decide whether _OSC
> should grant hotplug control?  And those Slot Capabilities don't
> advertise hotplug support?
Currently Hotplug is controlled by _OSC in both host and Guest. In case
of guest, it seems guest BIOS hasn't implemented _OSC since all the
flags are set to 0 which is not the case in host.

VMD is passthrough in Guest so the slot capabilities registers are
still same as what Host driver would see. That is how we can still
control hotplug on vmd on both Guest and Host.
> 
> "... which results in assigning default values and disabling Hotplug
> capability in the guest."  What default values are these?
0. Everything is disabled in guest. So basically _OSC is writing wrong
values in guest.
>   Is this
> talking about the default host_bridge->native_pcie_hotplug value set
> in acpi_pci_root_create(), where the OS assumes hotplug is owned by
> the platform unless _OSC grants control to the OS?
vmd driver calls pci_create_root_bus which eventually ends up
calling pci_init_host_bridge where native_pcie_hotplug is set to 1.
Now vmd_copy_host_bridge_flags overwrites the native_pcie_hotplug to
_OSC setting of 0 in guest.
> 
> > VMD Hotplug can be enabled or disabled based on the VMD rootports'
> > Hotplug configuration in BIOS. is_hotplug_bridge is set on each
> > VMD rootport based on Hotplug capable bit in SltCap in probe.c.
> > Check is_hotplug_bridge and enable or disable native_pcie_hotplug
> > based on that value.
> > 
> > This patch will make sure that Hotplug is enabled properly in Host
> > as well as in VM while honoring _OSC settings as well as VMD
> > hotplug
> > setting.
> 
> "Hotplug is enabled properly in Host as well as in VM" sounds like
> we're talking about both the host OS and the guest OS.
Yes. VM means guest.
> 
> In the host OS, this overrides whatever was negotiated via _OSC, I
> guess on the principle that _OSC doesn't apply because the host BIOS
> doesn't know about the Root Ports below the VMD.  (I'm not sure it's
> 100% resolved that _OSC doesn't apply to them, so we should mention
> that assumption here.)
_OSC still controls every flag including Hotplug. I have observed that
slot capabilities register has hotplug enabled only when platform has
enabled the hotplug. So technically not overriding it in the host.
It overrides in guest because _OSC is passing wrong/different
information than the _OSC information in Host.
Also like I mentioned, slot capabilities registers are not changed in
Guest because vmd is passthrough.
> 
> In the guest OS, this still overrides whatever was negotiated via
> _OSC, but presumably the guest BIOS *does* know about the Root Ports,
> so I don't think the same principle about overriding _OSC applies
> there.
> 
> I think it's still a problem that we handle
> host_bridge->native_pcie_hotplug differently than all the other
> features negotiated via _OSC.  We should at least explain this
> somehow.
Right now this is the only way to know in Guest OS if platform has
enabled Hotplug or not. We have many customers complaining about
Hotplug being broken in Guest. So just trying to honor _OSC but also
fixing its limitation in Guest.
> 
> I suspect part of the reason for doing it differently is to avoid the
> interrupt storm that we avoid via 04b12ef163d1 ("PCI: vmd: Honor ACPI
> _OSC on PCIe features").  If so, I think 04b12ef163d1 should be
> mentioned here because it's an important piece of the picture.
I can add a note about this patch as well. Let me know if you want me
to add something specific.

Thank you for taking the time. This is a very critical issue for us and
we have many customers complaining about it, I would appreciate to get
it resolved as soon as possible.

Thanks
nirmal
> 
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> > v1->v2: Updating commit message.
> > ---
> >  drivers/pci/controller/vmd.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c
> > index 769eedeb8802..e39eaef5549a 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -720,6 +720,7 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features)
> >  	resource_size_t membar2_offset = 0x2000;
> >  	struct pci_bus *child;
> >  	struct pci_dev *dev;
> > +	struct pci_host_bridge *vmd_bridge;
> >  	int ret;
> >  
> >  	/*
> > @@ -886,8 +887,16 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features)
> >  	 * and will fail pcie_bus_configure_settings() early. It can
> > instead be
> >  	 * run on each of the real root ports.
> >  	 */
> > -	list_for_each_entry(child, &vmd->bus->children, node)
> > +	vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
> > +	list_for_each_entry(child, &vmd->bus->children, node) {
> >  		pcie_bus_configure_settings(child);
> > +		/*
> > +		 * When Hotplug is enabled on vmd root-port, enable it
> > on vmd
> > +		 * bridge.
> > +		 */
> > +		if (child->self->is_hotplug_bridge)
> > +			vmd_bridge->native_pcie_hotplug = 1;
> 
> "is_hotplug_bridge" basically means PCI_EXP_SLTCAP_HPC is set, which
> means "the hardware of this slot is hot-plug *capable*."
> 
> Whether hotplug is *enabled* is a separate policy decision about
> whether the OS is allowed to operate the hotplug functionality, so I
> think saying "When Hotplug is enabled" in the comment is a little bit
> misleading.
I will rewrite the comment.
> 
> Bjorn
> 
> > +	}
> >  
> >  	pci_bus_add_devices(vmd->bus);
> >  
> > -- 
> > 2.31.1
> > 


