Return-Path: <linux-pci+bounces-3800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098C85CC04
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 00:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14221F231E1
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 23:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F20153BF3;
	Tue, 20 Feb 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bk40mBms"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21578688;
	Tue, 20 Feb 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471544; cv=none; b=KrZCHTP1imBp1uXw2Bxdsp65Aj1S4H1ugqD0zwBM6BX2Iq/VDW2l0P1J0ZdkII/uxhayQcsEG3THZR3ICK+NfZYdismQ9dKHpRKWQgzjDUYs90Oxbi98s0JINHtgk1mkskz21JKqUBkd1ZLObzJAaD8rTnuoyVCxGaGOWDY/uBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471544; c=relaxed/simple;
	bh=aZEXdgDXNpiV9ynLc8omSuxhI/t3RarAVerP6oXpfWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ag1MWHhgoHgjMpRzwwZWK17rdmGrpTxEdzdZaORjtKr2GH62w1zzhehz2HPO5K65ABtBO0QqdgblXNvvuc5BWAewkgO7IbT69K9xA6UwVJL8vHiP6dfYnE8ZTKFiSX94VRtXT7mMjrXFOFotdXrHqPpbM3YKKukIKkkRbD1gGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bk40mBms; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708471542; x=1740007542;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=aZEXdgDXNpiV9ynLc8omSuxhI/t3RarAVerP6oXpfWU=;
  b=bk40mBmswitWUmc6gSXTsSAVAc08sl0YWIqYUP5/HXjJV4SGvXMnSHZo
   kKNR7Azkh1sCwVcDVjagzlENo85KkJOkTNesm1ajzL0InuD2c0bgPApW5
   Dmgt0OSAf5H+RrsmnuiyMu3GQVM77+ZFGxdaIHdFnDKJH4zejkqh9KRhn
   nbX2uOyItbWR9kFb/NfAO57u/bue8MscwzOQbTLzG0wWeukmCEuvKFvhn
   i+iRAVG/v5ceK6LTzVZZ4nyf/22UScptHtdJ2CCfCf++s9nF/uF96NMeL
   QKrBxXFQEpuX3yhsBFI1GV3YKBCE+mIoouojE9kXbkGEabXHdChwiuMUF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13164219"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13164219"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:25:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5287373"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:25:42 -0800
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
	by linux.intel.com (Postfix) with ESMTP id 92A65580DBE;
	Tue, 20 Feb 2024 15:25:41 -0800 (PST)
Message-ID: <6d989b7da1e7493a3e2d478cec060a459f375daf.camel@linux.intel.com>
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
Date: Tue, 20 Feb 2024 15:25:41 -0800
In-Reply-To: <CAD8Lp46dPtE12ai8srt9Bz3awnkkb1LZz_7FQuF57M=LaUSaCw@mail.gmail.com>
References: <20240207084452.9597-1-drake@endlessos.org>
	 <20240207200538.GA912749@bhelgaas>
	 <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com>
	 <CAD8Lp44-8WhPyOrd2dCWyG3rRuCqzJ-aZCH6b1r0kyhfcXJ8xg@mail.gmail.com>
	 <9654146ac849bb00faf2fe963d3da94ad65003b8.camel@linux.intel.com>
	 <CAD8Lp44tO_pz_HZmPOKUQ-LEQT=c856eH52xWL9nBtAtJwjL1g@mail.gmail.com>
	 <CAD8Lp46dPtE12ai8srt9Bz3awnkkb1LZz_7FQuF57M=LaUSaCw@mail.gmail.com>
Autocrypt: addr=david.e.box@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBF2w2YABCACw5TpqmFTR6SgsrNqZE8ro1q2lUgVZda26qIi8GeHmVBmu572RfPydisEpCK246rYM5YY9XAps810ZxgFlLyBqpE/rxB4Dqvh04QePD6fQNui/QCSpyZ6j9F8zl0zutOjfNTIQBkcar28hazL9I8CGnnMko21QDl4pkrq1dgLSgl2r2N1a6LJ2l8lLnQ1NJgPAev4BWo4WAwH2rZ94aukzAlkFizjZXmB/6em+lhinTR9hUeXpTwcaAvmCHmrUMxeOyhx+csO1uAPUjxL7olj2J83dv297RrpjMkDyuUOv8EJlPjvVogJF1QOd5MlkWdj+6vnVDRfO8zUwm2pqg25DABEBAAG0KkRhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPokBTgQTAQgAOBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH7Mry1gl3p/NusIAK9z1xnXphedgZMGNzifGUs2UUw/xNl91Q9qRaYGyNYATI6E7zBYmynsUL/4yNFnXK8P/I7WMffiLoMqmUvNp9pG6oYYj8ouvbCexS21jgw54I3m61M+wTokieRIO/GettVlCGhz7YHlHtGGqhzzWB3CGPSJMwsouDPvyFFE+28p5d2v9l6rXSb7T297Kh50VX9Ele8QEKngrG+Z/u2lr/bHEhvx24vI8ka22cuTaZvThYMwLTSC4kq9L9WgRv31JBSa1pcbcHLOCoUl0RaQwe6J8w9hN2uxCssHrrfhSA4YjxKNIIp3YH4IpvzuDR3AadYz1klFTnEOxIM7fvQ2iGu5AQ0EXbDZgAEIAPGbL3wvbYUDGMoBSN89GtiC6ybWo28JSiYIN5N9LhDTwfWROenkRvmTESaE5fAM24sh8S0h+F+eQ7j/E/RF3pM31gSovTKw0Pxk7GorK
	FSa25CWemxSV97zV8fVegGkgfZkBMLUId+AYCD1d2R+tndtgjrHtVq/AeN0N09xv/d3a+Xzc4ib/SQh9mM50ksqiDY70EDe8hgPddYH80jHJtXFVA7Ar1ew24TIBF2rxYZQJGLe+Mt2zAzxOYeQTCW7WumD/ZoyMm7bg46/2rtricKnpaACM7M0r7g+1gUBowFjF4gFqY0tbLVQEB/H5e9We/C2zLG9r5/Lt22dj7I8A6kAEQEAAYkBNgQYAQgAIBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsMAAoJEH7Mry1gl3p/Z/AH/Re8YwzY5I9ByPM56B3Vkrh8qihZjsF7/WB14Ygl0HFzKSkSMTJ+fvZv19bk3lPIQi5lUBuU5rNruDNowCsnvXr+sFxFyTbXw0AQXIsnX+EkMg/JO+/V/UszZiqZPkvHsQipCFVLod/3G/yig9RUO7A/1efRi0E1iJAa6qHrPqE/kJANbz/x+9wcx1VfFwraFXbdT/P2JeOcW/USW89wzMRmOo+AiBSnTI4xvb1s/TxSfoLZvtoj2MR+2PW1zBALWYUKHOzhfFKs3cMufwIIoQUPVqGVeH+u6Asun6ZpNRxdDONop+uEXHe6q6LzI/NnczqoZQLhM8d1XqokYax/IZ4=
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-19 at 12:35 +0100, Daniel Drake wrote:
> On Fri, Feb 9, 2024 at 9:36=E2=80=AFAM Daniel Drake <drake@endlessos.org>=
 wrote:
> > On Thu, Feb 8, 2024 at 5:57=E2=80=AFPM David E. Box <david.e.box@linux.=
intel.com>
> > wrote:
> > > This does look like a firmware bug. We've had reports of D3cold suppo=
rt
> > > missing
> > > when running in non-VMD mode on systems that were designed with VMD f=
or
> > > Windows.
> > > These issues have been caught and addressed by OEMs during enabling o=
f
> > > Linux
> > > systems. Does D3cold work in VMD mode?
> >=20
> > On Windows for the VMD=3Don case, we only tested this on a BIOS with
> > StorageD3Enable=3D0. The NVMe device and parent bridge stayed in D0 ove=
r
> > suspend, but that's exactly what the BIOS asked for, so it doesn't
> > really answer your question.
>=20
> Tested on the original BIOS version with VMD=3Don: Windows leaves the
> NVMe device (and parent bridge) in D0 during suspend (i.e. same result
> as VMD=3Doff).
>=20
> On this setup, there are 2 devices with StorageD3Enable flags:
>=20
> 1. \_SB.PC00.PEG0.PEGP._DSD has StorageD3Enable=3D1. This is set
> regardless of the VMD setting at the BIOS level. This is the flag that
> is causing us the headache in non-VMD mode where Linux then proceeds
> to put devices into D3cold.

Likely never tested.

> This PEGP device in the non-VMD configuration corresponds to the NVMe
> storage device. PEG0 is the PCI root port at 00:06.0 (the one in
> question in this thread), and PEGP is the child with address 0.
> However in VMD mode, 00:06.0 is a dummy device (not a bridge) so this
> PEGP device isn't going to be used by anything.
>=20
> 2. \_SB.PC00.VMD0._DSD has StorageD3Enable=3D0. This VMD0 device is only
> present when VMD is enabled in the BIOS. It is the companion for
> 00:0e.0 which is the device that the vmd driver binds against. This
> could be influencing Windows to leave the NVMe device in D0, but I
> doubt it, because it can't explain why Windows would have the D0
> behaviour when VMD=3Doff, also this is a really strange place to put the
> StorageD3Enable setting because it is not a storage device.

Yes, we don't look for the property here, only under the child device of th=
e
Root Port.

>=20
> > On Linux with VMD=3Don and StorageD3Enable=3D1, the NVMe storage device
> > and the VMD parent bridge are staying in D0 over suspend. I don't know
> > why this is, I would have expected at least D3hot.=C2=A0 However, given
> > that the NVMe device has no firmware_node under the VMD=3Don setup, I
> > believe there is no way it would enter D3cold because there's no
> > linkage to an ACPI device, so no available _PS3 or _PR0 or whatever is
> > the precise definition of D3cold.
>=20
> Checked in more detail. In Linux, the NVMe device will only go into
> D3hot/D3cold if the ACPI companion device has an explicit
> StorageD3Enable=3D1. However, in VMD mode the NVMe storage device has no
> ACPI companion. Code flow is nvme_pci_alloc_dev() -> acpi_storage_d3()
> =C2=A0-> return false because no companion.

That explains it.

>=20
> The VMD PCI bridge at 10000:e0:06.0 that is parent of the SATA & NVME
> devices does have a companion \_SB.PC00.VMD0.PEG0
> However, the SATA and NVME child devices do not have any ACPI
> companion. I examined the logic of vmd_acpi_find_companion() and
> determined that it is looking for devices with _ADR 80b8ffff (SATA)
> and 8100ffff (NVME) and such devices do not exist in the ACPI tables.

Based on its counterpart it should be at \_SB.PC00.VMD0.PEG0.PEGP in VMD mo=
de.
This is where _ADR =3D 8100FFFF should be. This looks like broken ACPI code=
 since
the property does exist in the expected location when VMD is disabled.

>=20
> Speculating a little, I guess this is also why Windows leaves the
> device in D0 in VMD=3Don mode: it would only put the NVMe device in
> D3hot/D3cold if it had a corresponding companion with
> StorageD3Enable=3D1 and there isn't one of those. What's still unknown
> is why it doesn't put the device in D3 in VMD=3Doff mode because there
> is a correctly placed StorageD3Enable=3D1 in that case.

Given the observations (inconsistent firmware and testing showing Windows u=
sing
D0) I'm good with the approach.

David

