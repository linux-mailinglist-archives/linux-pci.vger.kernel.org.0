Return-Path: <linux-pci+bounces-27110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE768AA7B5F
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 23:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD421BA7239
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E22AF0E;
	Fri,  2 May 2025 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ey2b+D5J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E5F9CB
	for <linux-pci@vger.kernel.org>; Fri,  2 May 2025 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221437; cv=none; b=pzHurJTZjNTeMkDO3+sAgwK2YHSUsVnR5aXOPhfNEq5PsPpCJRoBNwH3ucB8h59jPXsLqpr7uBvUWl+Ig3bLk8w5d3+dTskBDh9Jg/fwyvr53QaUPMfyTGSLoBXcg63qsH3CwC4vOJpMN7MWEDnyp1+5rAeE97a8ccWvtPB1Vfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221437; c=relaxed/simple;
	bh=SysMf8NTny2Lgtpz179s1zPQsjM9OmPQqOwI9AuZ1Oo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OTjkBnUVxbmfPjoJxL+7mUidm2jVsPFyws+Lqlt+52UFDlCnpPERQCZrIWBlT16QbSsVHKfCj1oG77WNFi10Feld5FCSzuJnllNl3/jYj/NfbCPJrrFHQDA903wjrAvJ/fr/pnNDesOuFeS2kSEYK2kBQc81InRz0sFNtRYMP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ey2b+D5J; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746221434; x=1777757434;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SysMf8NTny2Lgtpz179s1zPQsjM9OmPQqOwI9AuZ1Oo=;
  b=Ey2b+D5J5IH6AhUUUIZDfUBrw/a6DsZyKS5QcfQRIHgjRKMbSQqjkx8Y
   bVDhimqiG3swiX4cF/RWadgxwPkdUFWUwPIM2joY5ofDteRGY0uWf8nxL
   hBVWsuqDXY6aSZ9I8Id3CTBuZFCGoo/NoAzg8XbmEpaa3UTxHJ3f5H+Az
   4+FSmcUuvBTdlNZ280BnI2ZKVhTsWRYXLCDKDGV5J9535cS5d7kPCbsL9
   vPsZSMUsM1+te1lRRtWtRBnY7dKLjM0SDA6Vf6WTFAVGlR4IeHxw3iEon
   TCeb+pHZfHiHlF3sF8lqnQFvn6Q69EcBsMyC3Tm9I6/CNbz38Xqrnf67F
   A==;
X-CSE-ConnectionGUID: vrZokzsXSyCj2veuIENW0g==
X-CSE-MsgGUID: 9NxWh/wKQvGeNfRcRGC5gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="51570673"
X-IronPort-AV: E=Sophos;i="6.15,257,1739865600"; 
   d="scan'208";a="51570673"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 14:30:34 -0700
X-CSE-ConnectionGUID: M9bb9Ww0ROet4yE4a1uj0A==
X-CSE-MsgGUID: bTo68OfVRceHRTz2IazldA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,257,1739865600"; 
   d="scan'208";a="134484696"
Received: from aschofie-mobl2.amr.corp.intel.com ([10.125.110.175])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 14:30:34 -0700
Message-ID: <2f33f07841d5a20a1eb14c73b2c3000dd45a031b.camel@linux.intel.com>
Subject: Re: [Bug 219984] New: [BISECTED] High power usage since 'PCI/ASPM:
 Correct LTR_L1.2_THRESHOLD computation'
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>, Sergey Dolgov
	 <sergey.v.dolgov@gmail.com>
Cc: linux-pci@vger.kernel.org, Kuppuswamy Sathyanarayanan
	 <sathyanarayanan.kuppuswamy@linux.intel.com>, "Artem S. Tashkinov"
	 <aros@gmx.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Fri, 02 May 2025 14:30:33 -0700
In-Reply-To: <20250410220915.GA326095@bhelgaas>
References: <20250410220915.GA326095@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

On Thu, 2025-04-10 at 17:09 -0500, Bjorn Helgaas wrote:
> On Thu, Apr 10, 2025 at 02:59:41PM +0100, Sergey Dolgov wrote:
> > Dear Bjorn,
> >=20
> > one (probably the main) power user is the CPU at shallow C states post
> > 7afeb84d14ea. Even at some load (like web browsing) the CPU spends
> > most time in C7 after reverting 7afeb84d14ea, in contrast to C3 even
> > at idle in the original 6.14.0. So the main question is what can make
> > the CPU busy with larger LTR_L1.2_THRESHOLDs?
>=20
> That's a good question and I have no idea what the answer is.
> Obviously a larger LTR_L1.2_THRESHOLD means less time in L1.2, but I
> don't know how that translates to CPU C states.
>=20
> These bugs:
>=20
> =C2=A0 https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> =C2=A0 https://bugzilla.kernel.org/show_bug.cgi?id=3D215832
>=20
> mention C states and ASPM.=C2=A0 I added some of those folks to cc.
>=20
> > I do have Win10 too, but neither Win binaries of pciutils nor Device
> > Manager show LTR_L1.2_THRESHOLD. lspci -vv run as Administrator does
> > report some "latencies" though. Some of them are significantly
> > smaller, e.g. "Exit Latency L0s <1us, L1 <16us" for the bridge
> > 00:1d.6, others are significantly larger, e.g. "Exit Latency L1
> > unlimited" for the NVMe 6e:00.0, than the LTR_L1.2_THRESHOLDs
> > calculated by Linux. The full log is attached.
>=20
> I think I'm missing your point here.=C2=A0 The L0s/L1 Acceptable Latencie=
s
> and the L0s/L1 Exit Latencies I see in your Win10 lspci are the same
> as in Windows, which is what I would expect because these are
> read-only Device and Link Capability registers and the OS can't
> influence them:
>=20
> =C2=A0 00:1d.6 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express =
Root Port
> #15
> =C2=A0=C2=A0=C2=A0 LnkCap: Port #15, Speed 8GT/s, Width x1, ASPM L0s L1, =
Exit Latency L0s
> <1us, L1 <16us
>=20
> =C2=A0 6e:00.0 Non-Volatile memory controller: Intel Corporation Optane N=
VME SSD
> H10
> =C2=A0=C2=A0=C2=A0 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s=
 unlimited, L1
> unlimited
> =C2=A0=C2=A0=C2=A0 LnkCap: Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit =
Latency L1 unlimited
>=20
> The DevCap L0s and L1 Acceptable Latencies are "the acceptable total
> latency that an Endpoint can withstand due to transition from L0s or
> L1 to L0.=C2=A0 It is essentially an indirect measure of the Endpoint's
> internal buffering."
>=20
> The LnkCap L0s and L1 Exit Latencies are the "time the Port requires
> to complete transitions from L0s or L1 to L0."
>=20
> I don't know how to relate LTR_L1.2_THRESHOLD to L1.=C2=A0 I do know that
> L0s and L1 were part of PCIe r2.1, but it wasn't until r3.1 that the
> L1.1 and L1.2 substates were added and L1 was renamed to L1.0.=C2=A0 So I
> expect the L1 latencies to be used to enable L1.0 by itself, and I
> assume LTR and LTR_L1.2_THRESHOLD are used separately to further
> enable L1.2.
>=20
> > But do we need to care about precise values? At least we know now that
> > 7afeb84d14ea has only increased the thresholds, slightly. What happens
> > if they are underestimated? Can this lead to severe problems, e.g.
> > data corruption on NVMes?
>=20
> IIUC, LTR messages are essentially a way for the device to say "I have
> enough local buffer space to hold X ns worth of traffic while I'm
> waiting for the link to return to L0."
>=20
> Then we should only put the link in L1.2 if we can get to L1.2 and
> back to L0 in X ns or less, and LTR_L1.2_THRESHOLD is basically the
> minimum L0 -> L1.2 -> L0 time.
>=20
> If we set LTR_L1.2_THRESHOLD lower than it should be, it seems like
> we're at risk of overrunning the device's local buffer.=C2=A0 Maybe that'=
s
> OK and the device needs to be able to tolerate that, but it does feel
> risky to me.
>=20
> There's also the LTR Capability that "specifies the maximum latency a
> device is permitted to request.=C2=A0 Software should set this to the
> platform's maximum supported latency or less."=C2=A0 Evidently drivers ca=
n
> set this (only amdgpu does, AFAICS), but I have no idea how to use it.
>=20
> I suppose setting it to something less than LTR_L1.2_THRESHOLD might
> cause L1.2 to be used more?=C2=A0 This would be writable via setpci, and =
it
> looks like it can be updated any time.=C2=A0 If you want to play with it,
> the value and scale are encoded the same way as
> encode_l12_threshold(), and PCI_EXT_CAP_ID_LTR and related #defines
> show the register layouts.
>=20
> > If not (and I've never seen one using 5.15 kernels for 4 years), can
> > we reprogram LTR_L1.2_THRESHOLDs at runtime?=C2=A0 Like for the CPU,
> > introduce 'performance' and 'powersave' governors for the PCI, which
> > set the thresholds to, say, 2x and 0.5x (2 + 4 + t_common_mode +
> > t_power_on), respectively.
>=20
> I don't think I would support a sysfs or similar interface to tweak
> this.=C2=A0 Right now computing LTR_L1.2_THRESHOLD already feels like a b=
it
> of black magic, and tweaking it would be farther down the road of
> "well, it seems to help this situation, but we don't really know why."
>=20
> > On Wed, Apr 9, 2025 at 12:18=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > >=20
> > > On Tue, Apr 08, 2025 at 09:02:46PM +0100, Sergey Dolgov wrote:
> > > > Dear Bjorn,
> > > >=20
> > > > here are both dmesg from the kernels with your info patch.
> > >=20
> > > Thanks again!=C2=A0 Here's the difference:
> > >=20
> > > =C2=A0 - pre=C2=A0 7afeb84d14ea
> > > =C2=A0 + post 7afeb84d14ea
> > >=20
> > > =C2=A0=C2=A0 pci 0000:02:00.0: parent CMRT 0x28 child CMRT 0x00
> > > =C2=A0=C2=A0 pci 0000:02:00.0: parent T_POWER_ON 0x2c usec (val 0x16 =
scale 0)
> > > =C2=A0=C2=A0 pci 0000:02:00.0: child=C2=A0 T_POWER_ON 0x0a usec (val =
0x5 scale 0)
> > > =C2=A0=C2=A0 pci 0000:02:00.0: t_common_mode 0x28 t_power_on 0x2c l1_=
2_threshold
> > > 0x5a
> > > =C2=A0 -pci 0000:02:00.0: encoded LTR_L1.2_THRESHOLD value 0x02 scale=
 3
> > > =C2=A0 +pci 0000:02:00.0: encoded LTR_L1.2_THRESHOLD value 0x58 scale=
 2
> > >=20
> > > We computed LTR_L1.2_THRESHOLD =3D=3D 0x5a =3D=3D 90 usec =3D=3D 9000=
0 nsec.
> > >=20
> > > Prior to 7afeb84d14ea, we computed *scale =3D 3, *value =3D (90000 >>=
 15)
> > > =3D=3D 0x2.=C2=A0 But per PCIe r6.0, sec 6.18, this is a latency valu=
e of only
> > > 0x2 * 32768 =3D=3D 65536 ns, which is less than the 90000 ns we reque=
sted.
> > >=20
> > > After 7afeb84d14ea, we computed *scale =3D 2, *value =3D
> > > roundup(threshold_ns, 1024) / 1024 =3D=3D 0x58, which is a latency va=
lue
> > > of 90112 ns, which is almost exactly what we requested.
> > >=20
> > > In essence, before 7afeb84d14ea we tell the Root Port that it can
> > > enter L1.2 and get back to L0 in 65536 ns or less, and after
> > > 7afeb84d14ea, we tell it that it may take up to 90112 ns.
> > >=20
> > > It's possible that the calculation of LTR_L1.2_THRESHOLD itself in
> > > aspm_calc_l12_info() is too conservative, and we don't actually need
> > > 90 usec, but I think the encoding done by 7afeb84d14ea itself is more
> > > correct.=C2=A0 I don't have any information about how to improve 90 u=
sec
> > > estimate.=C2=A0 (If you happen to have Windows on that box, it would =
be
> > > really interesting to see how it sets LTR_L1.2_THRESHOLD.)
> > >=20
> > > If the device has sent LTR messages indicating a latency requirement
> > > between 65536 ns and 90112 ns, the pre-7afeb84d14ea kernel would allo=
w
> > > L1.2 while post 7afeb84d14ea would not.=C2=A0 I don't think we can ac=
tually
> > > see the LTR messages sent by the device, but my guess is they must be
> > > in that range.=C2=A0 I don't know if that's enough to account for the=
 major
> > > difference in power consumption you're seeing.

If the Root Port is attached to a controller in the South Complex =E2=80=94=
 which would
be the case on a Cannon Lake=E2=80=93based platform =E2=80=94 you can obser=
ve the resulting LTR
value sent from the Port using the pmc_core driver:

    cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT

Needs CONFIG_INTEL_PMC_CORE which the major distros set.

The SOUTHPORTs correspond to Root Ports. Unfortunately, we don=E2=80=99t cu=
rrently have
a mapping between the internal PMC SOUTHPORT_X designation and the PCI Bus
enumeration. However, since this behavior clearly affects C-state entry, yo=
u
should be able to narrow it down by monitoring this file =E2=80=94 ideally =
capturing
several snapshots, as the values can change depending on device activity.

Note that the value shown may not exactly match what was sent in the LTR
message, but it won=E2=80=99t be smaller. My current assumption (pending co=
nfirmation)
is that simply entering L1.2 increases the effective LTR value observed by =
the
CPU, since it=E2=80=99s unlikely that the LTR message value itself changes =
solely as a
result of modifying the threshold.

Incidentally, you can also ignore the LTR from the Port by writing the bit =
value
(first column) to the ltr_ignore file in the same folder. This is for testi=
ng
only as it ignores device activity. But you should see deeper C state resid=
ency
after ignoring the problem Port, which would be a way to narrow down the
SOUTHPORT as well. The LTR consideration can be restored by writing the sam=
e bit
value to the ltr_restore file.

David

> > >=20
> > > The AX200 at 6f:00.0 is in exactly the same situation as the
> > > Thunderbolt bridge at 02:00.0 (LTR_L1.2_THRESHOLD 90 usec, RP set to
> > > 65536 ns before 7afeb84d14ea and 90112 ns after).
> > >=20
> > > For the NVMe devices at 6d:00.0 and 6e:00.0, LTR_L1.2_THRESHOLD is
> > > 3206 usec (!), and we set the RP to 3145728 ns (slightly too small)
> > > before, 3211264 ns after.
> > >=20
> > > For the RTS525A at 70:00.0, LTR_L1.2_THRESHOLD is 126 usec, and we se=
t
> > > the RP to 98304 ns before, 126976 ns after.
> > >=20
> > > Sorry, no real answers here yet, still puzzled.
> > >=20
> > > Bjorn
>=20
>=20


