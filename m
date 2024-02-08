Return-Path: <linux-pci+bounces-3241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AC484E5A7
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 17:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85528286A15
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 16:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0744980058;
	Thu,  8 Feb 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMZ5PSoR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A957EEE9;
	Thu,  8 Feb 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411435; cv=none; b=RyxM55HpxRalyz96SC2NbVls3DTBWBPCYO7RZ8IyFsPjTWWnPeSQ1LzDzYRGwu/7SAi8dhoyRxFk6mtOpbVzFJtrdVHOi8DzHJROta8vmQmxZ+ZA9qoKu+uf6jpZAKtT7Y7c6Rl+aRjjw4kRC60FYR81hwtAQyXHd/jcpIiHT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411435; c=relaxed/simple;
	bh=oupV3kTT50Gb/TGEGdVzk1Z4pRuREEf427kVS39VzdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJf3F650l/OBYIg/udlfYPIEKyyR36di7CERG6DyjRVEhbyV3REQHKWSxTO+e06abAbtuJGUZnXM+8rrSwSWP9pubPYJTBInJmKE4uqTCLd6dR659uBnMYTzZJyUamqLiVoYhhETcoImTN6cS8uiBxLKhgoPJdhqyYGlpxfEboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMZ5PSoR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411435; x=1738947435;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oupV3kTT50Gb/TGEGdVzk1Z4pRuREEf427kVS39VzdQ=;
  b=QMZ5PSoRCbKfK8Gme951C45eUBpfyQCmg9JfTPM/s0WNmnDHZMZpqTDl
   1TvCEVlBByIWDR2EAnIHUNic/OwHm+sm7ARxGCUG7/5EaSCaFtGB0Vv/M
   MT6cu4UIPJHaRfVLG/KdMi8IyaaEF90Yhbneci44nex8cTHACKqKLlM5C
   65XAJ1DuPV30FNCtpviiewRzgKz0pjR7Dd2TwWlKzdH+SSgGQoxOsAWzb
   N8invHlQ1ymtmJb+l3+aUk8NwnTOu7TO3Y57OrKBQpt6TKD0Hk+VggqJq
   1n1M7sxUzKTdRgKd/kuZj/7gAQy9gnpq794OARJtZ6ftX5SD3er7I5k+1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1557693"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1557693"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:57:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="2072780"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:57:14 -0800
Received: from ricardo2-mobl.amr.corp.intel.com (ricardo2-mobl.amr.corp.intel.com [10.209.74.190])
	by linux.intel.com (Postfix) with ESMTP id DA4F1580C9A;
	Thu,  8 Feb 2024 08:57:12 -0800 (PST)
Message-ID: <9654146ac849bb00faf2fe963d3da94ad65003b8.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Daniel Drake <drake@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com,  mario.limonciello@amd.com, rafael@kernel.org,
 lenb@kernel.org,  linux-acpi@vger.kernel.org, linux@endlessos.org
Date: Thu, 08 Feb 2024 08:57:12 -0800
In-Reply-To: <CAD8Lp44-8WhPyOrd2dCWyG3rRuCqzJ-aZCH6b1r0kyhfcXJ8xg@mail.gmail.com>
References: <20240207084452.9597-1-drake@endlessos.org>
	 <20240207200538.GA912749@bhelgaas>
	 <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com>
	 <CAD8Lp44-8WhPyOrd2dCWyG3rRuCqzJ-aZCH6b1r0kyhfcXJ8xg@mail.gmail.com>
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

On Thu, 2024-02-08 at 10:52 +0100, Daniel Drake wrote:
> On Thu, Feb 8, 2024 at 9:37=E2=80=AFAM Daniel Drake <drake@endlessos.org>=
 wrote:
> > > What would be the downside of skipping the DMI table and calling
> > > pci_d3cold_disable() always?=C2=A0 If this truly is a Root Port defec=
t, it
> > > should affect all platforms with this device, and what's the benefit
> > > of relying on BIOS to use StorageD3Enable to avoid the defect?
> >=20
> > I had more assumed that it was a platform-specific DSDT bug, in that
> > PEG0.PXP._OFF is doing something that PEG0.PXP._ON is unable to
> > recover from, and that other platforms might handle the suspend/resume
> > of this root port more correctly. Not sure if it is reasonable to
> > assume that all other platforms on the same chipset have the same bug
> > (if that's what this is).

This does look like a firmware bug. We've had reports of D3cold support mis=
sing
when running in non-VMD mode on systems that were designed with VMD for Win=
dows.
These issues have been caught and addressed by OEMs during enabling of Linu=
x
systems. Does D3cold work in VMD mode?

David

>=20
> Just realised my main workstation (Dell XPS) has the same chipset.
>=20
> The Dell ACPI table has the exact same suspect-buggy function, which
> the affected Asus system calls from PEG0.PXP._OFF:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Method (DL23, 0, Serialized)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L23E =
=3D One
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sleep =
(0x10)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Local0=
 =3D Zero
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 While =
(L23E)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 If ((Local0 > 0x04))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Break
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Sleep (0x10)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Local0++
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SCB0 =
=3D One
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> (the "L23E =3D One" line is the one that writes a value to config offset
> 0xe2, if you comment out this line then everything works)
>=20
> However, on the Dell XPS system, nothing calls DL23() i.e. it is dead cod=
e.
>=20
> Comparing side by side:
> Asus root port (PC00.PEG0) has the PXP power resource which gets
> powered down during D3cold transition as it becomes unused. Dell root
> port has no power resources (no _PR0).
> Asus NVM device sitting under that root port (PC00.PEG0.PEGP) has
> no-op _PS3 method, but Dell does not have _PS3. This means that Dell
> doesn't attempt D3cold on NVMe nor the parent root port during suspend
> (both go to D3hot only).
>=20
> Let me know if you have any ideas for other useful comparative experiment=
s.
> Daniel


