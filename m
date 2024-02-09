Return-Path: <linux-pci+bounces-3295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C972F84FAE4
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 18:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A12AB274BC
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F8180BEE;
	Fri,  9 Feb 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a66ebNfQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C37F493;
	Fri,  9 Feb 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499163; cv=none; b=qveY3wRcdXwNW3jS702MdfvGpxRgFlj4qHeN536iVmIRSEQEhrIXAZPcLnLuYl3BL4JLFLWofwqnJUYJYWI1jv88nRjl1P3FCM6ZmoDIntCDWdoDdc4qXq5UYi5tZlitP9YHrpWYCTJxfRrKeyhRemGMrkD0zUQZE9ea2Iijfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499163; c=relaxed/simple;
	bh=VRJlINL6pxzWElhznPgpcMFZwr/R2ULvU04lgrJbPs0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plkJAbt+UvgHgs5ENf+cZU//k10bLSWv7W2DPFdrdvFDrGvdWMskatY5D9EFeJmkwZ70ixTJ1K+zuheA9dbzUsJ1nzRngtyMAVF4RkE8caTjUke6kJcETRU8Vwbjk50GoQEGsCd7nxgXvpMcMdUV31l9lQOTnaKyBd4mc0171PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a66ebNfQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707499162; x=1739035162;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VRJlINL6pxzWElhznPgpcMFZwr/R2ULvU04lgrJbPs0=;
  b=a66ebNfQvxSXrWpBTnuyWd0uR9akmuokHSqgPntVDkc0RH37VeVoQawk
   VD+ZAL+K3GCvx3h05X2ldiqJkw6JXDPp+XcH9EcLMxpKQav2yxpRFBZ0p
   EDfG/t5Z3dA/U79rBWOpTgxDVg7NfSiKXKodtFva0QZW9g1gr2Ca8yI9e
   af/ahpV64InNzP2tL0vWVo6lZG6z4eR2M7clRA5tXN3C2kXVqXFuD143C
   GTQ7ZkdovgxzLY9BctroSUaflGLn5aSNVHEwc79tI0sXjrIHafxyzRmM8
   PtHNkaE7EB2KZX92XBWIRr86NziLqeF3PUBMGERU9n5NdVJBK8HrxxF8D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1326078"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1326078"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2195068"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:19:20 -0800
Received: from spboulos-mobl1.amr.corp.intel.com (spboulos-mobl1.amr.corp.intel.com [10.209.44.214])
	by linux.intel.com (Postfix) with ESMTP id C48635804FA;
	Fri,  9 Feb 2024 09:19:19 -0800 (PST)
Message-ID: <ecb40fbc2dc50cc2ebe7cc5393c2b0d6da58e4f3.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Daniel Drake <drake@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de,
 mingo@redhat.com,  bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com,  linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com, 
 mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, 
 linux-acpi@vger.kernel.org, linux@endlessos.org
Date: Fri, 09 Feb 2024 09:19:19 -0800
In-Reply-To: <CAD8Lp44tO_pz_HZmPOKUQ-LEQT=c856eH52xWL9nBtAtJwjL1g@mail.gmail.com>
References: <20240207084452.9597-1-drake@endlessos.org>
	 <20240207200538.GA912749@bhelgaas>
	 <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com>
	 <CAD8Lp44-8WhPyOrd2dCWyG3rRuCqzJ-aZCH6b1r0kyhfcXJ8xg@mail.gmail.com>
	 <9654146ac849bb00faf2fe963d3da94ad65003b8.camel@linux.intel.com>
	 <CAD8Lp44tO_pz_HZmPOKUQ-LEQT=c856eH52xWL9nBtAtJwjL1g@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-09 at 09:36 +0100, Daniel Drake wrote:
> On Thu, Feb 8, 2024 at 5:57=E2=80=AFPM David E. Box <david.e.box@linux.in=
tel.com>
> wrote:
> > This does look like a firmware bug. We've had reports of D3cold support
> > missing
> > when running in non-VMD mode on systems that were designed with VMD for
> > Windows.
> > These issues have been caught and addressed by OEMs during enabling of =
Linux
> > systems. Does D3cold work in VMD mode?
>=20
> On Windows for the VMD=3Don case, we only tested this on a BIOS with
> StorageD3Enable=3D0. The NVMe device and parent bridge stayed in D0 over
> suspend, but that's exactly what the BIOS asked for, so it doesn't
> really answer your question.
>=20
> On Linux with VMD=3Don and StorageD3Enable=3D1, the NVMe storage device
> and the VMD parent bridge are staying in D0 over suspend. I don't know
> why this is, I would have expected at least D3hot.

Yeah something is missing here. When StorageD3Enable is set, the nvme drive=
r
prints the following message during boot:

	"platform quirk: setting simple suspend"

If you don't see this, then the driver never saw StorageD3Enable=3D1. Possi=
ble
reasons are:

	- The property doesn't exist
	- The property isn't set under the ACPI companion device
	- There is no associated ACPI companion device
	- The "nvme=3Dnoacpi" parameter was passed on the kernel cmdline
	- The nvme driver was quirked to not use D3 with
	   NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND.

How was the D-state status confirmed? You can use the following to see the =
D
state of PCI devices during suspend in the kernel log:

echo -n "file pci-driver.c +p" > /sys/kernel/debug/dynamic_debug/control

David

> =C2=A0 However, given
> that the NVMe device has no firmware_node under the VMD=3Don setup, I
> believe there is no way it would enter D3cold because there's no
> linkage to an ACPI device, so no available _PS3 or _PR0 or whatever is
> the precise definition of D3cold.
>=20
> I also realise I may have made a bad assumption in my previous mail
> when looking at the Dell device: I was assuming that a parent PCI
> bridge cannot go into D3cold if its child devices only got as far as
> D3hot, but I now realise I'm not sure if that constraint actually
> exists.
>=20
> Not sure if these questions are relevant for the consideration of this
> patch, but I'll try to find some time to answer them next week.
>=20
> Daniel


