Return-Path: <linux-pci+bounces-1255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDA381AC12
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 02:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8712A286680
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 01:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC9210EB;
	Thu, 21 Dec 2023 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2TunVLu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC4185D;
	Thu, 21 Dec 2023 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703121576; x=1734657576;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Ew4Vzxgx7zUVYzmP1sdM/F/Om3TXE5iEhv2H8noeomE=;
  b=c2TunVLu1oUbr+f5h8d4zkYQGpOeZwUdUNV/L03RaecbKyruZ05TI0Xc
   LkK+JiXxcPg90qvu6CKDDYJK+uPxmJ9cSNTiFDGSfhfOC76pqZEwNVFRO
   9n56fv1KPwIKvYXTP7tZRKHxIzsC1YZOHgyeWAhJKhW0VdgmA2HKZHZG+
   6wSUFO9Zew4bEALLtK+KryBQ3pDqhtbnLxEvx+hC9E3/4LVw6In8rhxTC
   c45FRgxk+wt+LNQfR4ktigRMbbE+NWbTL8RgV+UXb40U81rU5nz9g3BnF
   f1txmsUKozu874rDjtHJN1114u12pMpdzbbDUbG6v8ZXYgstOkp1sXaij
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="482083997"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="482083997"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 17:19:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="24773388"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 17:19:35 -0800
Received: from vheredia-mobl.amr.corp.intel.com (unknown [10.209.87.121])
	by linux.intel.com (Postfix) with ESMTP id 75E5F580DA4;
	Wed, 20 Dec 2023 17:19:34 -0800 (PST)
Message-ID: <5a6d5b9688ff8f0a08da7dd6ecf00fc386ac37f8.camel@linux.intel.com>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Kenneth R. Crudup"
 <kenny@panix.com>, vidyas@nvidia.com, bhelgaas@google.com, 
 kai.heng.feng@canonical.com, andrea.righi@canonical.com, 
 vicamo.yang@canonical.com, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Ricky WU <ricky_wu@realtek.com>, Mario
 Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, Thomas Witt <kernel@witt.link>, Matthew Garrett
 <mjg59@srcf.ucam.org>
Date: Wed, 20 Dec 2023 17:19:34 -0800
In-Reply-To: <57f31eb90e4027f0da8718f76cae9be9eec19974.camel@linux.intel.com>
References: <20231116231812.GA57394@bhelgaas>
	 <57f31eb90e4027f0da8718f76cae9be9eec19974.camel@linux.intel.com>
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

On Fri, 2023-11-17 at 16:21 -0800, David E. Box wrote:
> On Thu, 2023-11-16 at 17:18 -0600, Bjorn Helgaas wrote:
> > [+cc Matthew, author of 41cd766b0659 ("PCI: Don't enable aspm before dr=
ivers
> > have had a chance to veto it")]
> >=20
> > On Thu, Nov 16, 2023 at 12:10:02PM -0800, David E. Box wrote:
> > > On Tue, 2023-11-07 at 13:15 +0200, Mika Westerberg wrote:
> > > > On Mon, Nov 06, 2023 at 12:11:07PM -0600, Bjorn Helgaas wrote:
> > > > > On Sat, Nov 04, 2023 at 10:13:24AM -0700, Kenneth R. Crudup wrote=
:
> > > > > >=20
> > > > > > I have a Dell XPS-9320 with an Alderlake chipset, and the NVMe
> > > > > > behind a VMD device:
> > > > > >=20
> > > > > > ----
> > > > > > [=C2=A0=C2=A0=C2=A0 0.127342] smpboot: CPU0: 12th Gen Intel(R) =
Core(TM) i7-1280P
> > > > > > (family:
> > > > > > 0x6, model: 0x9a, stepping: 0x3)
> > > > > > ----
> > > > > > 0000:00:0e.0 0104: 8086:467f
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: 1028:0af3
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, f=
ast devsel, latency 0, IOMMU group 9
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 603c000000=
 (64-bit, non-prefetchable) [size=3D32M]
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 72000000 (=
32-bit, non-prefetchable) [size=3D32M]
> > > > > > a7152be79b6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at=
 6040100000 (64-bit, non-prefetchable)
> > > > > > [size=3D1M]
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <acces=
s denied>
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use=
: vmd
> > > > > > ----
> > > > > >=20
> > > > > > The only release kernel that was able to get this laptop to
> > > > > > fully get into low-power (unfortunately only s0ix) was the
> > > > > > Ubuntu-6.2.0- ... series from Ubuntu (remote
> > > > > > git://git.launchpad.net/~ubuntu-
> > > > > > kernel/ubuntu/+source/linux/+git/lunar).
> > > > > >=20
> > > > > > I'd bisected it to the following commits (in this order):
> > > > > >=20
> > > > > > 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for
> > > > > > suspend/resume
> > > > > > 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Registe=
r
> > > > > > programming
> > > > > > 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links und=
er
> > > > > > VMD
> > > > > > domain
> > > > > > 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints
> > > > > > behind
> > > > > > VMD
> > > > > > 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver na=
me
> > > > > > instead
> > > > >=20
> > > > > Thanks for these.=C2=A0 You don't happen to have URLs for those U=
buntu
> > > > > commits, do you?=C2=A0 E.g., https://git.kernel.org/linus/4ff116d=
0d5fd
> > > > > (which was reverted by a7152be79b62 ("Revert "PCI/ASPM: Save L1 P=
M
> > > > > Substates Capability for suspend/resume"")).
> > > > >=20
> > > > > > Without the patches I never see Pkg%PC8 or higher(? lower?),
> > > > > > nor i915 states DC5/6, all necssary for SYS%LPI/CPU%LPI. I've
> > > > > > attached a little script I use alongside turbostat for
> > > > > > verifying low-power operation (and also for seeing what
> > > > > > chipset subsystem may be preventing it).
> > > > > >=20
> > > > > > The first two are in Linus' trees, but were reverted
> > > > > > (4ff116d0d5fd in a7152be79b6, 5e85eba6f50d in ff209ecc376a).
> > > > > > The last three come from Ubuntu's Linux trees (see remote spec
> > > > > > above). The first two remain reverted in the Ubuntu trees, but
> > > > > > if I put them back, I get increased power savings during
> > > > > > suspend/resume cycles.
> > > > > >=20
> > > > > > Considering the power draw is really significant without these
> > > > > > patches (10s of %s per hour) and I'd think Dell would have
> > > > > > sold some decent number of these laptops, I'd been patiently
> > > > > > waiting for these patches, or some variant to show up in the
> > > > > > stable trees, but so far I'm up to the 6.6 stable kernel and
> > > > > > still having to manually cherry-pick these, so I thought maybe
> > > > > > I could bring this to the PM maintainers' attention so at
> > > > > > least start a discussion about this issue.
> > > > >=20
> > > > > Thank you very much for raising this again.=C2=A0 We really need =
to make
> > > > > some progress, and Mika recently posted a patch to add the
> > > > > 4ff116d0d5fd functionality again:
> > > > > https://lore.kernel.org/r/20231002070044.2299644-1-mika.westerber=
g@linux.intel.com
> > > > >=20
> > > > > The big problem is that it works on *most* systems, but it still
> > > > > seems to break a few.=C2=A0 So Mika's current patch relies on a
> > > > > denylist of systems where we *don't* restore the substates.
> > > >=20
> > > > According to latest reports it is just that one system where this
> > > > is still an issue. The latest patch works in Asus UX305FA even if
> > > > it is not in the denylist. That would leave that one system only
> > > > to the denylist, at least the ones we are aware about.
> > >=20
> > > I've been working with Thomas, whose system is the last known to
> > > have problems with Mika's patch. It turns out that his config sets
> > > aspm_policy to 'powersave'.=C2=A0 If he sets it to any other policy,
> > > Mika's patch works [1]. It's possible that others may see the same
> > > issue if they use 'powersave' as well.
> > >=20
> > > The theory right now is that enabling L1SS in pci_restore_state() is
> > > too early.=C2=A0=20
> >=20
> > I'd really like to figure out what "too early" means.=C2=A0 We can make=
 it
> > later by enabling L1SS somewhere else, but unless we know exactly what
> > needs to happen first, we're likely to break it again.=C2=A0 And if we =
know
> > what's required, we can probably figure out a cleaner way to restore
> > it.
>=20
> Still trying to understand this particular failure. The current patch to
> Thomas
> more closely mimics how ASPM is enabled during boot when powersave is set=
. If
> it
> works we can at least prove that we can get it to work again by using a
> similar
> flow.


With some free time I was able to find a system in our lab that reproduces =
the
same failure reported on the last problem report from Thomas. That is, with
powersave selected, the nvme fails to come up after resume from S3 with thi=
s
patch without a quirk. It's actually obvious when you can see the flow. We
observed that on S3 resume, BIOS has enabled L1.2 (likely back to preboot
setting). Restoring powersave will therefore disable L1.2. Per spec, L1.2 m=
ust
be disabled on the downstream first. But pci_restore_state() gets called on
upstream devices first. Indeed, on my system, clearing the L1.2 state on th=
e
root port makes the nvme device inaccessible by the time
pci_aspm_restore_state() is called for it. I've modified the patch to defer=
 L1SS
restore until the downstream component so they can be done together. The pa=
tch
clears L1.2 on the child first before the parent, restores both configs and=
 then
reenables them in reverse on the parent then the child. This works on my sy=
stem.
I've posted the patch as a V5 and on the bugzilla and appreciate if anyone =
here
can test.

https://lore.kernel.org/linux-pci/20231221011250.191599-1-david.e.box@linux=
.intel.com/

David

