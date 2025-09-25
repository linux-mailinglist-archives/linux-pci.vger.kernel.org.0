Return-Path: <linux-pci+bounces-36937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9E7B9ED1C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 12:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3363A6F35
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DE678F59;
	Thu, 25 Sep 2025 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxIGk9g+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E02ECD13
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797515; cv=none; b=FRV+/G69TVqIWKe7H9H8rbXZYNDUGJTtsCu9YsOODP4lDPeKJVy6PYNohZpwV3LCt4Cf0ifp0/l5ReBVzoS3uv0928wRAp/Jvt2C2433oZaKslAn9pNIt7piPGj4awbn8ndN2TcbV9UloRr1PkQzwQN4LgnWOvlO09pYMRG2Rnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797515; c=relaxed/simple;
	bh=xvkyFEDKFbRCb03nx/S+JW03S2ydvwJJ7TG4NtNiDgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBzEhhfgFzHjw4YyT6/DuknyiCkPXh0RyH0I8RMB/oK88sZcqoDoeKfY7bX4ljGTVVPlUHIhdDXDheZCXRU/JDN2exAHzLtnZ6qO6ZYKPreQCe6RHyYPhC9+FiwoYVAIzhgAnqsfZC9fDRUsF9/kLFqHSXgX6pJve8Qg/ftI+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxIGk9g+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758797513; x=1790333513;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xvkyFEDKFbRCb03nx/S+JW03S2ydvwJJ7TG4NtNiDgI=;
  b=GxIGk9g+tyZmGyj4z0MPFBpklngVL/2WByfHrcgXgvJPOtkqjuFHa+Bd
   IoncI3vvdv2wS7BxV+nYHtAQz7U4yyQOb7/3BpB085ayEYeBT/Ijjk/tR
   EYnsOrOjf4So55le5WQU5LPRJgx2qXFipB5brR3jwWwUxpUfhNOQF0q5q
   Hc9knvz4Wv/M+avDJ3Ti2WGfM97RHgA1VKSDIg7bqkfZg66oi0+z1WfJh
   Ko/yNK6fpTr6RjuGpBa/qoOifed3RhIpLzWyxh0dCvQ3NHBkf5PUuOqlh
   NzVMlbGg37uCxoQ+ySG/Hz/fQs8QSHS+CXPv1OUmzCCA6w1fB+Kg9ZEY5
   w==;
X-CSE-ConnectionGUID: HDBKvO8QTFWS8U9frr368g==
X-CSE-MsgGUID: Z8a4Ef58RgGrJM73LeF9AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71731284"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="71731284"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 03:51:52 -0700
X-CSE-ConnectionGUID: QcwvSll1Q4+7TnmcvNoK3g==
X-CSE-MsgGUID: lyFnAOAyQhq79DoHxhA87g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181590178"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.244.100]) ([10.245.244.100])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 03:51:50 -0700
Message-ID: <ab09c09638c4482f99047672680c247b98c961c9.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Brost, Matthew" <matthew.brost@intel.com>, Simona Vetter	
 <simona.vetter@ffwll.ch>, "dri-devel@lists.freedesktop.org"	
 <dri-devel@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"	
 <intel-xe@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Date: Thu, 25 Sep 2025 12:51:47 +0200
In-Reply-To: <IA0PR11MB7185239DB2331A899561AA7DF81FA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <045c6892-9b15-4f31-aa6a-1f45528500f1@amd.com>
	 <20250922122018.GU1391379@nvidia.com>
	 <IA0PR11MB718580B723FA2BEDCFAB71E9F81DA@IA0PR11MB7185.namprd11.prod.outlook.com>
	 <aNI9a6o0RtQmDYPp@lstrano-desk.jf.intel.com>
	 <aNJB1r51eC2v2rXh@lstrano-desk.jf.intel.com>
	 <80d2d0d1-db44-4f0a-8481-c81058d47196@amd.com>
	 <20250923121528.GH1391379@nvidia.com>
	 <522d3d83-78b5-4682-bb02-d2ae2468d30a@amd.com>
	 <20250923131247.GK1391379@nvidia.com>
	 <8da25244-be1e-4d88-86bc-5a6f377bdbc1@amd.com>
	 <20250923133839.GL1391379@nvidia.com>
	 <5f9f8cb6-2279-4692-b83d-570cf81886ab@amd.com>
	 <IA0PR11MB71855457D1061D0A2344A5CFF81CA@IA0PR11MB7185.namprd11.prod.outlook.com>
	 <1d9065f3-8784-4497-b92c-001ae0e78b63@amd.com>
	 <IA0PR11MB7185239DB2331A899561AA7DF81FA@IA0PR11MB7185.namprd11.prod.outlook.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-25 at 03:56 +0000, Kasireddy, Vivek wrote:
> Hi Christian,
>=20
> > Subject: Re: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for
> > device
> > functions of Intel GPUs
> >=20
> > > >=20
> > > > On 23.09.25 15:38, Jason Gunthorpe wrote:
> > > > > On Tue, Sep 23, 2025 at 03:28:53PM +0200, Christian K=C3=B6nig
> > > > > wrote:
> > > > > > On 23.09.25 15:12, Jason Gunthorpe wrote:
> > > > > > > > When you want to communicate addresses in a device
> > > > > > > > specific
> > address
> > > > > > > > space you need a device specific type for that and not
> > > > > > > > abuse
> > > > > > > > phys_addr_t.
> > > > > > >=20
> > > > > > > I'm not talking about abusing phys_addr_t, I'm talking
> > > > > > > about putting a
> > > > > > > legitimate CPU address in there.
> > > > > > >=20
> > > > > > > You can argue it is hack in Xe to reverse engineer the
> > > > > > > VRAM offset
> > > > > > > from a CPU physical, and I would be sympathetic, but it
> > > > > > > does allow
> > > > > > > VFIO to be general not specialized to Xe.
> > > > > >=20
> > > > > > No, exactly that doesn't work for all use cases. That's why
> > > > > > I'm
> > > > > > pushing back so hard on using phys_addr_t or CPU addresses.
> > > > > >=20
> > > > > > See the CPU address is only valid temporary because the VF
> > > > > > BAR is
> > > > > > only a window into the device memory.
> > > > >=20
> > > > > I know, generally yes.
> > > > >=20
> > > > > But there should be no way that a VFIO VF driver in the
> > > > > hypervisor
> > > > > knows what is currently mapped to the VF's BAR. The only way
> > > > > I can
> > > > > make sense of what Xe is doing here is if the VF BAR is a
> > > > > static
> > > > > aperture of the VRAM..
> > > > >=20
> > > > > Would be nice to know the details.
> > > >=20
> > > > Yeah, that's why i asked how VFIO gets the information which
> > > > parts of the
> > > > it's BAR should be part of the DMA-buf?
> > > >=20
> > > > That would be really interesting to know.
> > > As Jason guessed, we are relying on the GPU VF being a Large BAR
> > > device here. In other words, as you suggested, this will not work
> > > if the
> > > VF BAR size is not as big as its actual VRAM portion. We can
> > > certainly add
> > > this check but we have not seen either the GPU PF or VF getting
> > > detected
> > > as Small BAR devices in various test environments.
> > >=20
> > > So, given the above, once a VF device is bound to vfio-pci driver
> > > and
> > > assigned to a Guest VM (launched via Qemu), Qemu's vfio layer
> > > maps
> > > all the VF's resources including the BARs. This mapping info
> > > (specifically
> > HVA)
> > > is leveraged (by Qemu) to identity the offset at which the Guest
> > > VM's buffer
> > > is located (in the BAR) and this info is then provided to vfio-
> > > pci kernel driver
> > > which finally creates the dmabuf (with BAR Addresses).
> >=20
> > In that case I strongly suggest to add a private DMA-buf interface
> > for the DMA-
> > bufs exported by vfio-pci which returns which BAR and offset the
> > DMA-buf
> > represents.

@Christian, Is what you're referring to here the "dma_buf private
interconnect" we've been discussing previously, now only between vfio-
pci and any interested importers instead of private to a known exporter
and importer?

If so I have a POC I can post as an RFC on a way to negotiate such an
interconnect.

> Does this private dmabuf interface already exist or does it need to
> be created
> from the ground up?
>=20
> If it already exists, could you please share an example/reference of
> how you
> have used it with amdgpu or other drivers?
>=20
> If it doesn't exist, I was wondering if it should be based on any
> particular best
> practices/ideas (or design patterns) that already exist in other
> drivers?

@Vivek, another question: Also on the guest side we're exporting dma-
mapped adresses that are imported and somehow decoded by the guest
virtio-gpu driver? Is something similar needed there?

Also how would the guest side VF driver know that what is assumed to be
a PF on the same device is actually a PF on the same device and not a
completely different device with another driver? (In which case I
assume it would like to export a system dma-buf)?

Thanks,
Thomas



>=20
> >=20
> > Ideally using the same structure Qemu used to provide the offset to
> > the vfio-
> > pci driver, but not a must have.
> >=20
> > This way the driver for the GPU PF (XE) can leverage this
> > interface, validates
> > that the DMA-buf comes from a VF it feels responsible for and do
> > the math to
> > figure out in which parts of the VRAM needs to be accessed to
> > scanout the
> > picture.
> Sounds good. This is definitely a viable path forward and it looks
> like we are all
> in agreement with this idea.
>=20
> I guess we can start exploring how to implement the private dmabuf
> interface
> mechanism right away.
>=20
> Thanks,
> Vivek
>=20
> >=20
> > This way this private vfio-pci interface can also be used by
> > iommufd for
> > example.
> >=20
> > Regards,
> > Christian.
> >=20
> > >=20
> > > Thanks,
> > > Vivek
> > >=20
> > > >=20
> > > > Regards,
> > > > Christian.
> > > >=20
> > > > >=20
> > > > > > What Simona agreed on is exactly what I proposed as well,
> > > > > > that you
> > > > > > get a private interface for exactly that use case.
> > > > >=20
> > > > > A "private" interface to exchange phys_addr_t between at
> > > > > least
> > > > > VFIO/KVM/iommufd - sure no complaint with that.
> > > > >=20
> > > > > Jason
> > >=20
>=20


