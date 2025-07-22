Return-Path: <linux-pci+bounces-32729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B029B0DA2D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 14:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2131854300D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9B2DEA88;
	Tue, 22 Jul 2025 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8DZTfVj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6971C32;
	Tue, 22 Jul 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188986; cv=none; b=oeYZVr5GHCzOLcL2JELdhB6mK1r/QUQYoWRmy/UKf2XnlTKseq0F1A6+hwIOoDgqc93WcZZZbU7LemLHXMrHtg1wPvcfKmpIv8fxH2y1NhIIJ8bj63mIApx3Yg/dM99Ausrj6I7RvNAaWuyUeWFRh+cK2XsWKBKRRc9MWzqormg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188986; c=relaxed/simple;
	bh=c2L6rHjmtCJeciELiYPIjGCjIfrsQARmY4/qEmALyGE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Iq0X+ByNodj8/X99rin2orJ7HCt+OIejmsa0A/CxS3c2dksIHfqi7ipGtvtEnG5LUELaVhYuTEgdQSjJ4c7O3cOGIKk4SGTSMgeaDQzPcnfFYDPv3Mf1vXk17LyrbaaYf1N1vnzjQWmiYWP88VQuaJ58bLCbSD90myR9kwC/pew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8DZTfVj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753188984; x=1784724984;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c2L6rHjmtCJeciELiYPIjGCjIfrsQARmY4/qEmALyGE=;
  b=U8DZTfVjyQ1jga4qv4cwR+dEKrZxu//pbG3aKDlyaei7weazKuTyOjiR
   uwx1OGmDSOcNhVyaK0zvHE4xacU9eNdBcKXDJMaMELep9/ndVKTOJ7ync
   cDAxSrzWPjuKDREikBJMUKqDDzFNctPSw++BupOyvwJnxCQgPtRyL4Evf
   gRz0ud/Os+ucex5zg9E8pOh+eiPCWHQQo1rPhj26LzuIE2IVHwOKIsguy
   ROIhg08PKu2Y38W46jD90Vc2oIdatM9wdhiWMqYNtSCtRsmDCw/5opnkB
   zRuGASZOJP8XnfJHApfCegsWzUoOT/4uCTHHEAINt7sDpop5DEfISb0mt
   Q==;
X-CSE-ConnectionGUID: wUMpMEzPTr+XO6Q3JDeytQ==
X-CSE-MsgGUID: BoMDM1ZYSAyWHRDyPKUupA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="66121521"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="66121521"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 05:56:23 -0700
X-CSE-ConnectionGUID: scgFeFDvR7O3N7BwwGx8Bw==
X-CSE-MsgGUID: Du0Jm0HnRzOfSC4GwKBEkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="164604090"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 05:56:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 22 Jul 2025 15:56:16 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Icenowy Zheng <uwu@icenowy.me>, Bjorn Helgaas <bhelgaas@google.com>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-pci@vger.kernel.org, 
    intel-xe@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
    Han Gao <rabenda.cn@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH] PCI: hide mysterious 8MB 64-bit pref BAR on Intel Arc
 PCIe Switch
In-Reply-To: <20250721202401.GA2751369@bhelgaas>
Message-ID: <380aa860-89a4-08dc-7d39-b7b212546415@linux.intel.com>
References: <20250721202401.GA2751369@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Jul 2025, Bjorn Helgaas wrote:

> [+cc Ilpo]
> 
> On Tue, Jul 22, 2025 at 01:30:57AM +0800, Icenowy Zheng wrote:
> > The upstream port device of Intel Arc series dGPUs' internal PCIe switch
> > contains a mysterious 8MB 64-bit prefetchable BAR. All reads to memory
> > mapped to that BAR returns 0xFFFFFFFF and writes have no effect.
> > 
> > When the PCI bus isn't configured by any firmware (e.g. a PCIe
> > controller solely initialized by Linux kernel), the PCI space allocation
> > algorithm of Linux will allocate the main VRAM BAR of Arc dGPU device at
> > base+0, and then the 8MB BAR at base+256M, which prevents the main VRAM
> > BAR gets resized.

__resource_resize_store() tries to release all resoures with the same 
flags as the resource to be resized. But it seems the release doesn't work 
across devices.

I don't like that flags check anyway, I'd want to replace all such black 
magic with a function that consistently determines the bridge window a 
resouce is assigned to. I've a series to that effect but it doesn't cover 
resize cases yet and it requires more testing anyway to confirm it doesn't 
change any parent windows resources get assigned to.

So IMO, the correct logic on resize would be to:

1) Get the relevant upstream bridge window
2) Release all child resource of that bridge window. But that will 
require further checks whether all those resources (from foreign PCI devs) 
can be released which might run a foul with dev lock ordering.

...So it might turn out hard to implement in practice.

> > As the functionality and performance of Arc dGPU will
> > get severely restricted with small BAR, this makes a problem.
> > 
> > Hide the mysterious 8MB BAR to Linux PCI subsystem, to allow resizing
> > the VRAM BAR to VRAM size with the Linux PCI space allocation algorithm.
> 
> There's no reason a switch upstream port should not have a BAR.  I
> suspect this BAR probably does have a legitimate purpose, and it's
> only "mysterious" because we don't know how to use it.
> 
> This sounds like it may be a deficiency in the Linux BAR assignment
> code.  Any other device could have a similar problem.  

I'm still working also with the resource fitting logic to make it consider 
resizable BARs when sizing the resource which would address this problem 
another way.

> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> >  drivers/pci/quirks.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index d7f4ee634263..df304bfec6e9 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3650,6 +3650,22 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d0, quirk_broken_intx_masking);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d1, quirk_broken_intx_masking);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d2, quirk_broken_intx_masking);
> >  
> > +/*
> > + * Intel Arc dGPUs' internal switch upstream port contains a mysterious 8MB
> > + * 64-bit prefetchable BAR that blocks resize of main dGPU VRAM BAR with
> > + * Linux's PCI space allocation algorithm.
> > + */
> > +static void quirk_intel_xe_upstream(struct pci_dev *pdev)
> > +{
> > +	memset(&pdev->resource[0], 0, sizeof(pdev->resource[0]));
> 
> This doesn't touch the BAR itself, so we may be leaving the BAR
> decoding accesses, which could lead to an address conflict.  It also
> prevents a driver for the upstream port from using the BAR.
> 
> > +}
> > +/* Intel Arc A380 PCI Express Switch Upstream Port */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4fa1, quirk_intel_xe_upstream);
> > +/* Intel Arc A770 PCI Express Switch Upstream Port */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4fa0, quirk_intel_xe_upstream);
> > +/* Intel Arc B580 PCI Express Switch Upstream Port */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xe2ff, quirk_intel_xe_upstream);
> > +
> >  static u16 mellanox_broken_intx_devs[] = {
> >  	PCI_DEVICE_ID_MELLANOX_HERMON_SDR,
> >  	PCI_DEVICE_ID_MELLANOX_HERMON_DDR,
> > -- 
> > 2.50.1
> > 
> 

-- 
 i.


