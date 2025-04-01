Return-Path: <linux-pci+bounces-25090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6B0A78198
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 19:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D9C3A6C94
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E82B205AC5;
	Tue,  1 Apr 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XO22uJ4z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE899461;
	Tue,  1 Apr 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743529138; cv=none; b=uP1C3oEd3+rD9DcXByI0+iWKRv0SBcuacACPGlMWSYXCKuCvitL+oKBSCHowLl9ZUrKgraMoGkw4sHwqvMKjPTXVGm0yqSMvh93IywFBktZeQAk2dlc5SRSV64xvosQenpZomX1+saPzsU9GCo5Fzem3wEW4tadU18VSTJyLUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743529138; c=relaxed/simple;
	bh=P8rA5nUmcF8wRHeKhO2SH6TJ/9u6Hvan7BoOpsyOTY8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jFEjGygv4vnfaZaeR/XtkZW4NICIK33Iz9hqaWQ7EBv+Ji56UJr2dDu2OeoWCCsyCO4pPv+8NYVhpS3bLr9EopyCGZfAzisBpSplN/BdpI406xPnt+CwonA4+ece+JQuARUwVxeohJvP33hkjSG4y3XSxbl7c3Q2x7MXAlo6TQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XO22uJ4z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743529136; x=1775065136;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=P8rA5nUmcF8wRHeKhO2SH6TJ/9u6Hvan7BoOpsyOTY8=;
  b=XO22uJ4z5DLGO1JOnGYDZa2lWgIp4GI8Gl2F0Nyxs52ZZX68efdbB0x8
   WBRyK5EH9gwnrGY0tstzfZHFIC2uecIEHvUTWsclLjG16KtFtvEegAzhz
   vg1ESi9I0EN/kWQkxSZ+aNDj7LTK5KpiQ/+u0hrBZZs8PZkiSSEKmfg2U
   d82IgKtw0tazTjXELP28q97oc7iI0D0tN2/MmqlqZXYgPNRerM/aEwfVZ
   Vnst6JH9MjsF4y2y2wFFmBZct3+lGiT2+iOpSEzm4K4Sp8Z6dH8EVR3EC
   MPYmewFjaE2NDTOI8b2bH6MdKLDeX3cOIB4sK9oa9YCKj5GxH+6gegrio
   w==;
X-CSE-ConnectionGUID: xuJhKNacQy6qRNMBRxp4Hg==
X-CSE-MsgGUID: /cFjX/p7SuWFCjbdvw31/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="44750294"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="44750294"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 10:38:56 -0700
X-CSE-ConnectionGUID: Lyxsr7YOScGsYymeXLVY7g==
X-CSE-MsgGUID: QXii4zu9Sl+NiHaoBY3zFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126975934"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 10:38:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 1 Apr 2025 20:38:48 +0300 (EEST)
To: Guenter Roeck <linux@roeck-us.net>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <5eb8fd42-b288-4ecb-ae0e-177904cc0a14@roeck-us.net>
Message-ID: <c34c6dc2-5ab2-1a81-3ba4-b3bc2c016945@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net> <75f74b48-edd8-7d1c-d303-1222d12e3812@linux.intel.com> <6612c4d2-2533-98ef-7c89-f61d80c3e3e2@linux.intel.com>
 <5eb8fd42-b288-4ecb-ae0e-177904cc0a14@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1374073976-1743517432=:932"
Content-ID: <cacbfb25-7e16-a6b9-ba59-76e65adf2bb8@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1374073976-1743517432=:932
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <38a43576-6722-4be8-63eb-04da6a621334@linux.intel.com>

On Tue, 1 Apr 2025, Guenter Roeck wrote:
> On 4/1/25 05:07, Ilpo J=E4rvinen wrote:
> > On Tue, 1 Apr 2025, Ilpo J=E4rvinen wrote:
> >=20
> > > On Mon, 31 Mar 2025, Guenter Roeck wrote:
> > > > On Mon, Dec 16, 2024 at 07:56:31PM +0200, Ilpo J=E4rvinen wrote:
> > > > > Resetting resource is problematic as it prevent attempting to all=
ocate
> > > > > the resource later, unless something in between restores the reso=
urce.
> > > > > Similarly, if fail_head does not contain all resources that were
> > > > > reset,
> > > > > those resource cannot be restored later.
> > > > >=20
> > > > > The entire reset/restore cycle adds complexity and leaving resour=
ces
> > > > > into reseted state causes issues to other code such as for checks=
 done
> > > > > in pci_enable_resources(). Take a small step towards not resettin=
g
> > > > > resources by delaying reset until the end of resource assignment =
and
> > > > > build failure list (fail_head) in sync with the reset to avoid le=
aving
> > > > > behind resources that cannot be restored (for the case where the
> > > > > caller
> > > > > provides fail_head in the first place to allow restore somewhere =
in
> > > > > the
> > > > > callchain, as is not all callers pass non-NULL fail_head).
> > > > >=20
> > > > > The Expansion ROM check is temporarily left in place while buildi=
ng
> > > > > the
> > > > > failure list until the upcoming change which reworks optional res=
ource
> > > > > handling.
> > > > >=20
> > > > > Ideally, whole resource reset could be removed but doing that in =
a big
> > > > > step would make the impact non-tractable due to complexity of all
> > > > > related code.
> > > > >=20
> > > > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > > >=20
> > > > With this patch in the mainline kernel, all mips:boston qemu emulat=
ions
> > > > fail when running a 64-bit little endian configuration
> > > > (64r6el_defconfig).
> > > >=20
> > > > The problem is that the PCI based IDE/ATA controller is not initial=
ized.
> > > > There are a number of pci error messages.
> > > >=20
> > > > pci_bus 0002:01: extended config space not accessible
> > > > pci 0002:01:00.0: [8086:2922] type 00 class 0x010601 conventional P=
CI
> > > > endpoint
> > > > pci 0002:01:00.0: BAR 4 [io  0x0000-0x001f]
> > > > pci 0002:01:00.0: BAR 5 [mem 0x00000000-0x00000fff]
> > > > pci 0002:00:00.0: PCI bridge to [bus 01-ff]
> > > > pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
> > > > pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff]: assign=
ed
> > > > pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: c=
an't
> > > > assign; no space
> > > > pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: f=
ailed
> > > > to assign
> > > > pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no
> > > > space
> > > > pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
> > > > pci 0002:00:00.0: bridge window [mem size 0x00100000]: can't assign=
;
> > > > bogus alignment
> > > > pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff 64bit pr=
ef]:
> > > > assigned
> > > > pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no
> > > > space
> > > > pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
> > > > pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: can't assign; no spa=
ce
> > > > pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: failed to assign
> > > > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
> > > > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
> > > > pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: can't assign; no spa=
ce
> > > > pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: failed to assign
> > > > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
> > > > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
> > > > pci 0002:00:00.0: PCI bridge to [bus 01]
> > > > pci 0002:00:00.0:   bridge window [mem 0x16000000-0x160fffff 64bit =
pref]
> > > > pci_bus 0002:00: Some PCI device resources are unassigned, try boot=
ing
> > > > with pci=3Drealloc
> > > > pci_bus 0002:00: resource 4 [mem 0x16000000-0x160fffff]
> > > > pci_bus 0002:01: resource 2 [mem 0x16000000-0x160fffff 64bit pref]
> > > > ...
> > > > pci 0002:00:00.0: enabling device (0000 -> 0002)
> > > > ahci 0002:01:00.0: probe with driver ahci failed with error -12
> > > >=20
> > > > Bisect points to this patch. Reverting it together with "PCI: Rewor=
k
> > > > optional resource handling" fixes the problem. For comparison, afte=
r
> > > > reverting the offending patches, the log messages are as follows.
> > > >=20
> > > > pci_bus 0002:00: root bus resource [bus 00-ff]
> > > > pci_bus 0002:00: root bus resource [mem 0x16000000-0x160fffff]
> > > > pci 0002:00:00.0: [10ee:7021] type 01 class 0x060400 PCIe Root Comp=
lex
> > > > Integrated Endpoint
> > > > pci 0002:00:00.0: PCI bridge to [bus 00]
> > > > pci 0002:00:00.0:   bridge window [io  0x0000-0x0fff]
> > > > pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> > > > pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit =
pref]
> > > > pci 0002:00:00.0: enabling Extended Tags
> > > > pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]),
> > > > reconfiguring
> > > > pci_bus 0002:01: extended config space not accessible
> > > > pci 0002:01:00.0: [8086:2922] type 00 class 0x010601 conventional P=
CI
> > > > endpoint
> > > > pci 0002:01:00.0: BAR 4 [io  0x0000-0x001f]
> > > > pci 0002:01:00.0: BAR 5 [mem 0x00000000-0x00000fff]
> > > > pci 0002:00:00.0: PCI bridge to [bus 01-ff]
> > > > pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
> > > > pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff]: assign=
ed
> > > > pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: c=
an't
> > > > assign; no space
> > > > pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: f=
ailed
> > > > to assign
> > > > pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no
> > > > space
> > > > pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
> > > > pci 0002:01:00.0: BAR 5 [mem 0x16000000-0x16000fff]: assigned
> > > > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
> > > > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
> > > > pci 0002:00:00.0: PCI bridge to [bus 01]
> > > > pci 0002:00:00.0:   bridge window [mem 0x16000000-0x160fffff]
> > > > pci_bus 0002:00: Some PCI device resources are unassigned, try boot=
ing
> > > > with pci=3Drealloc
> > > > pci_bus 0002:00: resource 4 [mem 0x16000000-0x160fffff]
> > > > pci_bus 0002:01: resource 1 [mem 0x16000000-0x160fffff]
> > > > ...
> > > > pci 0002:00:00.0: enabling device (0000 -> 0002)
> > > > ahci 0002:01:00.0: enabling device (0000 -> 0002)
> > > > ahci 0002:01:00.0: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps,=
 SATA
> > > > mode
> > > > ahci 0002:01:00.0: 6/6 ports implemented (port mask 0x3f)
> > > > ahci 0002:01:00.0: flags: 64bit ncq only
> > >=20
> > > Hi,
> > >=20
> > > Thanks for reporting. Please add this to the command line to get the
> > > resource releasing between the steps to show:
> > >=20
> > > dyndbg=3D"file drivers/pci/setup-bus.c +p"
> > >=20
> > > Also, the log snippet just shows it fails but it is impossible to kno=
w
> > > from it why the resource assigments do not fit so could you please pr=
ovide
> > > a complete dmesg logs. Also providing the contents of /proc/iomem fro=
m the
> > > working case would save me quite a bit of decoding the iomem layout f=
rom
> > > the dmesgs.
> >=20
> > Hi again,
> >=20
> > If you could kindly include this patch into the test with pci_dbg()
> > enabled so the resource reset/restore is better tracked.
> >=20
>=20
> Same link as before (http://server.roeck-us.net/qemu/mipsel64/).
> The log with the patch applied is in bad-extra.log.

That log wasn't taken from a bad case but it doesn't matter anymore as I=20
could test this with qemu myself, thanks for providing enough to make it=20
easy to reproduce & test it locally :-).

The problem is caused by assign+release cycle being destructive on start=20
aligned resources because successful assigment overwrites the start field.=
=20
I'll send a patch to fix the problem once I've given it a bit more thought
as this resource fitting code is somewhat complex.

--=20
 i.
--8323328-1374073976-1743517432=:932--

