Return-Path: <linux-pci+bounces-25060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB5BA778B3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 12:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B6F3AAA4B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E11EB1A8;
	Tue,  1 Apr 2025 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvHDD4GP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1931F0987;
	Tue,  1 Apr 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502707; cv=none; b=mng+bvq0ogTJK3T59RIBUztwQdjJ3VJ4ePG0TmWRjlbXKuX56vPMEoEUo6CzNh8MG8+ZL7LmMb6SSR4KSNagSTE+8Y4fWLnOA4bgdGxMlXzlDAqab2mRARRlX8xqxpjLlZAZfjdz2sPoTZvBCzdBZti+8wD2DUus+6+2rfJ3PJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502707; c=relaxed/simple;
	bh=/EHz54318NdoMp45HsLtrxjCORjhcPcP0lWu4il58HI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iK/Yxk2lDbnX/ZMi7VaLBIf8TpuWYReoPNMBnzRlY9F7riO/7N4elUWWr14qJ1nw58CsDVjF57xagzaeoHxVnDtyey9F1XAGPu8Pw5jlinaNg7TdLDmuFVwJP6Wj835SywUwvz9dzYObLn0ASm0gkxGIO69Cn9Gvz6WM/AmNni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvHDD4GP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743502705; x=1775038705;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/EHz54318NdoMp45HsLtrxjCORjhcPcP0lWu4il58HI=;
  b=jvHDD4GP9Ifq3fQ7RU6zTye/yZEjSJV/zb8uMvz1tA3nMeYHXRyfyXBF
   vjei40I0iN5nI3cpU9t+zUyMeDdnm6ux+gfBAuur/Pol6hjVQTpco9G0M
   R7iSeozyFW8QxFKBsE2ISyJO49VMmbACjyZMmlLZCxv+EOszzWKvJoC5h
   N0tyEhCuPxvzPXzMuiZnG3C1l+caFwiob0VH7RKxHhR35D+Y1wFJS6Mpt
   OY3HwzU3ChEnmsIeWX+yuCB9StOQBzPUYg1GJFXGBcKN35DkpeDwUb2xo
   Tun63lIYxHqKZNvJGhHWAeQI+T3ItKNeWpe/BkUzTTCwL/8tlfI+fz1Xd
   Q==;
X-CSE-ConnectionGUID: K6MY/3QPSYmxh+1Zv/2U5g==
X-CSE-MsgGUID: k07KUhraS5K0bfFWIE9Amg==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44531764"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="44531764"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 03:18:24 -0700
X-CSE-ConnectionGUID: slC0r/iuTUq6wGP/SJvnFw==
X-CSE-MsgGUID: QrB00bnMTgGIxQDKdFYIAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="131068381"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 03:18:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 1 Apr 2025 13:18:17 +0300 (EEST)
To: Guenter Roeck <linux@roeck-us.net>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net>
Message-ID: <75f74b48-edd8-7d1c-d303-1222d12e3812@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2117202481-1743502697=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2117202481-1743502697=:932
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 31 Mar 2025, Guenter Roeck wrote:
> On Mon, Dec 16, 2024 at 07:56:31PM +0200, Ilpo J=E4rvinen wrote:
> > Resetting resource is problematic as it prevent attempting to allocate
> > the resource later, unless something in between restores the resource.
> > Similarly, if fail_head does not contain all resources that were reset,
> > those resource cannot be restored later.
> >=20
> > The entire reset/restore cycle adds complexity and leaving resources
> > into reseted state causes issues to other code such as for checks done
> > in pci_enable_resources(). Take a small step towards not resetting
> > resources by delaying reset until the end of resource assignment and
> > build failure list (fail_head) in sync with the reset to avoid leaving
> > behind resources that cannot be restored (for the case where the caller
> > provides fail_head in the first place to allow restore somewhere in the
> > callchain, as is not all callers pass non-NULL fail_head).
> >=20
> > The Expansion ROM check is temporarily left in place while building the
> > failure list until the upcoming change which reworks optional resource
> > handling.
> >=20
> > Ideally, whole resource reset could be removed but doing that in a big
> > step would make the impact non-tractable due to complexity of all
> > related code.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> With this patch in the mainline kernel, all mips:boston qemu emulations
> fail when running a 64-bit little endian configuration (64r6el_defconfig)=
=2E
>=20
> The problem is that the PCI based IDE/ATA controller is not initialized.
> There are a number of pci error messages.
>=20
> pci_bus 0002:01: extended config space not accessible
> pci 0002:01:00.0: [8086:2922] type 00 class 0x010601 conventional PCI end=
point
> pci 0002:01:00.0: BAR 4 [io  0x0000-0x001f]
> pci 0002:01:00.0: BAR 5 [mem 0x00000000-0x00000fff]
> pci 0002:00:00.0: PCI bridge to [bus 01-ff]
> pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
> pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff]: assigned
> pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: can't a=
ssign; no space
> pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: failed =
to assign
> pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no space
> pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
> pci 0002:00:00.0: bridge window [mem size 0x00100000]: can't assign; bogu=
s alignment
> pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff 64bit pref]: a=
ssigned
> pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no space
> pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
> pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: can't assign; no space
> pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: failed to assign
> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
> pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: can't assign; no space
> pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: failed to assign
> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
> pci 0002:00:00.0: PCI bridge to [bus 01]
> pci 0002:00:00.0:   bridge window [mem 0x16000000-0x160fffff 64bit pref]
> pci_bus 0002:00: Some PCI device resources are unassigned, try booting wi=
th pci=3Drealloc
> pci_bus 0002:00: resource 4 [mem 0x16000000-0x160fffff]
> pci_bus 0002:01: resource 2 [mem 0x16000000-0x160fffff 64bit pref]
> ...
> pci 0002:00:00.0: enabling device (0000 -> 0002)
> ahci 0002:01:00.0: probe with driver ahci failed with error -12
>=20
> Bisect points to this patch. Reverting it together with "PCI: Rework
> optional resource handling" fixes the problem. For comparison, after
> reverting the offending patches, the log messages are as follows.
>=20
> pci_bus 0002:00: root bus resource [bus 00-ff]
> pci_bus 0002:00: root bus resource [mem 0x16000000-0x160fffff]
> pci 0002:00:00.0: [10ee:7021] type 01 class 0x060400 PCIe Root Complex In=
tegrated Endpoint
> pci 0002:00:00.0: PCI bridge to [bus 00]
> pci 0002:00:00.0:   bridge window [io  0x0000-0x0fff]
> pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> pci 0002:00:00.0: enabling Extended Tags
> pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
> pci_bus 0002:01: extended config space not accessible
> pci 0002:01:00.0: [8086:2922] type 00 class 0x010601 conventional PCI end=
point
> pci 0002:01:00.0: BAR 4 [io  0x0000-0x001f]
> pci 0002:01:00.0: BAR 5 [mem 0x00000000-0x00000fff]
> pci 0002:00:00.0: PCI bridge to [bus 01-ff]
> pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
> pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff]: assigned
> pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: can't a=
ssign; no space
> pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: failed =
to assign
> pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no space
> pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
> pci 0002:01:00.0: BAR 5 [mem 0x16000000-0x16000fff]: assigned
> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
> pci 0002:00:00.0: PCI bridge to [bus 01]
> pci 0002:00:00.0:   bridge window [mem 0x16000000-0x160fffff]
> pci_bus 0002:00: Some PCI device resources are unassigned, try booting wi=
th pci=3Drealloc
> pci_bus 0002:00: resource 4 [mem 0x16000000-0x160fffff]
> pci_bus 0002:01: resource 1 [mem 0x16000000-0x160fffff]
> ...
> pci 0002:00:00.0: enabling device (0000 -> 0002)
> ahci 0002:01:00.0: enabling device (0000 -> 0002)
> ahci 0002:01:00.0: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA =
mode
> ahci 0002:01:00.0: 6/6 ports implemented (port mask 0x3f)
> ahci 0002:01:00.0: flags: 64bit ncq only

Hi,

Thanks for reporting. Please add this to the command line to get the=20
resource releasing between the steps to show:

dyndbg=3D"file drivers/pci/setup-bus.c +p"

Also, the log snippet just shows it fails but it is impossible to know=20
from it why the resource assigments do not fit so could you please provide=
=20
a complete dmesg logs. Also providing the contents of /proc/iomem from the=
=20
working case would save me quite a bit of decoding the iomem layout from=20
the dmesgs.

> Bisect log is attached for reference.
>=20
> Guenter
> ---
> # bad: [609706855d90bcab6080ba2cd030b9af322a1f0c] Merge tag 'trace-latenc=
y-v6.15-3' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-tra=
ce
> # good: [acb4f33713b9f6cadb6143f211714c343465411c] Merge tag 'm68knommu-f=
or-v6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
> git bisect start 'HEAD' 'acb4f33713b9'
> # good: [cf05922d63e2ae6a9b1b52ff5236a44c3b29f78c] Merge tag 'drm-intel-g=
t-next-2025-03-12' of https://gitlab.freedesktop.org/drm/i915/kernel into d=
rm-next
> git bisect good cf05922d63e2ae6a9b1b52ff5236a44c3b29f78c
> # bad: [93d52288679e29aaa44a6f12d5a02e8a90e742c5] Merge tag 'backlight-ne=
xt-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
> git bisect bad 93d52288679e29aaa44a6f12d5a02e8a90e742c5
> # bad: [e5e0e6bebef3a21081fd1057c40468d4cff1a60d] Merge tag 'v6.15-p1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect bad e5e0e6bebef3a21081fd1057c40468d4cff1a60d
> # bad: [dea140198b846f7432d78566b7b0b83979c72c2b] Merge branch 'pci/misc'
> git bisect bad dea140198b846f7432d78566b7b0b83979c72c2b
> # bad: [a113afb84ae63ec4c893bc3204945ef6f3bb89f7] Merge branch 'pci/endpo=
int'
> git bisect bad a113afb84ae63ec4c893bc3204945ef6f3bb89f7
> # good: [a7a8e7996c1c114b50df5599229b1e7be38be3db] Merge branch 'pci/rese=
t'
> git bisect good a7a8e7996c1c114b50df5599229b1e7be38be3db
> # bad: [7d4bcc0f2631e4ee10b5bcfff24a423d1c3c02a3] PCI: Move resource reas=
signment func declarations into pci/pci.h
> git bisect bad 7d4bcc0f2631e4ee10b5bcfff24a423d1c3c02a3
> # good: [acba174d2e754346c07578ad2220258706a203e2] PCI: Use while loop an=
d break instead of gotos
> git bisect good acba174d2e754346c07578ad2220258706a203e2
> # good: [8884b5637b794ae541e8d6fb72102b1d8dba2b8d] PCI: Add debug print w=
hen releasing resources before retry
> git bisect good 8884b5637b794ae541e8d6fb72102b1d8dba2b8d
> # bad: [5af473941b56189423a7d16c05efabaf77299847] PCI: Increase Resizable=
 BAR support from 512 GB to 128 TB
> git bisect bad 5af473941b56189423a7d16c05efabaf77299847
> # bad: [96336ec702643aec2addb3b1cdb81d687fe362f0] PCI: Perform reset_reso=
urce() and build fail list in sync
> git bisect bad 96336ec702643aec2addb3b1cdb81d687fe362f0
> # good: [e89df6d2beae847e931d84a190b192dfac41eba7] PCI: Use res->parent t=
o check if resource is assigned
> git bisect good e89df6d2beae847e931d84a190b192dfac41eba7
> # first bad commit: [96336ec702643aec2addb3b1cdb81d687fe362f0] PCI: Perfo=
rm reset_resource() and build fail list in sync
>=20

--=20
 i.

--8323328-2117202481-1743502697=:932--

