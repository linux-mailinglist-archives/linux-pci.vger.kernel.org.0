Return-Path: <linux-pci+bounces-4632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D8875B66
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 01:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A0A1C20D27
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EB5364;
	Fri,  8 Mar 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwaLkYNp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709D363
	for <linux-pci@vger.kernel.org>; Fri,  8 Mar 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856550; cv=none; b=BXYdPAnLYNfKZmrF0BslxVBp8yja5/UBa2bqseAKQ7/ozQ45RaaoIW+p+A2uw2ANvG19nmGXwUaDOWPfZXNRH/fBdXAUcTnf/SGVoCvE7FGLnUpVa8QiitGz1ra6Cy7a63kAIhMSgRHlFnydkcLnh2OztRUv73v0GG/sNghh8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856550; c=relaxed/simple;
	bh=+Y+SbyeqOpFc3t61CFa1k5+chE55VhoQIqbxmBG0N0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8oU+Ybdx430OvFiXwcLdvDW3KD8eGdtsG1pganE4v0Dz6+qEhIZN3qF9MAHW9RucjWljb9Z6QSXIcEj29khaoGXuTVSXNBQr1ZYtQXal3Xrf8IJynKb6kNe/PjwfUtUcIDWNvFKouCmr2sTJ2dfLXePBlMxvhP8g6J+d+JNMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwaLkYNp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709856548; x=1741392548;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Y+SbyeqOpFc3t61CFa1k5+chE55VhoQIqbxmBG0N0A=;
  b=jwaLkYNpP63DlkZeFgz/MGQJdKuVFxxcyRM23lYrQZOMMqq2exsz6Xwz
   UW0kCF2JFqOLP7DA3s0a02YgJWFclzRUKzosere77nEycrrmtaNTjHLf8
   0RW+RHP8bAESe0B0MWyCxytGE0jG4cTVZh1jvF9Di1bI5cBaOAs07rnaX
   QA7+sLHkt9RZXDBLPFYatK0cP2A3L/KqgpuMJHgBBe3kqW0PD5D/hUDVk
   0H6UqIpfcVugofum+BuxSHMfxBqpzQjy7IDGapJdpSq8INROFos6l7MLA
   M3ryJQB2JjfT1yX9eiXssEP4m7CzoA1xbHlfOlk9IRc+p2Ow7c+OBDAZQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="30004478"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="30004478"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 16:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10339401"
Received: from patelni-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.184.40])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 16:09:07 -0800
Date: Thu, 7 Mar 2024 17:09:04 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on
 VMD rootports
Message-ID: <20240307170904.00001cd4@linux.intel.com>
In-Reply-To: <CAAd53p4j3MwigsFXpftuDdSfhn7EH_-cOOjP2DqnqeAuD+Fb=Q@mail.gmail.com>
References: <20240207185549.GA910460@bhelgaas>
	<af071f45513778a9392efb1a9f41f1e18d2670f0.camel@linux.intel.com>
	<46b737db266f08c6dc98c77044bab12491a4d971.camel@linux.intel.com>
	<CAAd53p4j3MwigsFXpftuDdSfhn7EH_-cOOjP2DqnqeAuD+Fb=Q@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Mar 2024 14:44:23 +0800
Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> Hi Nirmal,
>=20
> On Thu, Mar 7, 2024 at 6:20=E2=80=AFAM Nirmal Patel
> <nirmal.patel@linux.intel.com> wrote:
> >
> > On Tue, 2024-02-13 at 10:47 -0700, Nirmal Patel wrote: =20
> > > On Wed, 2024-02-07 at 12:55 -0600, Bjorn Helgaas wrote: =20
> > > > On Tue, Feb 06, 2024 at 05:27:29PM -0700, Nirmal Patel wrote: =20
> > > > > ...
> > > > > Did you have a chance to look at my response on January 16th
> > > > > to your
> > > > > questions? I tried to summarize all of the potential problems
> > > > > and issues with different fixes. Please let me know if it is
> > > > > easier if
> > > > > I
> > > > > resend the explanation. Thanks. =20
> > > >
> > > > I did see your Jan 16 response, thanks.
> > > >
> > > > I had more questions after reading it, but they're more about
> > > > understanding the topology seen by the host and the guest:
> > > >   Jan 16:
> > > > https://lore.kernel.org/r/20240117004933.GA108810@bhelgaas
> > > >   Feb  1:
> > > > https://lore.kernel.org/r/20240201211620.GA650432@bhelgaas
> > > >
> > > > As I mentioned in my second Feb 1 response
> > > > (https://lore.kernel.org/r/20240201222245.GA650725@bhelgaas),
> > > > the usual plan envisioned by the PCI Firmware spec is that an
> > > > OS can use
> > > > a
> > > > PCIe feature if the platform has granted the OS ownership via
> > > > _OSC and
> > > > a device advertises the feature via a Capability in config
> > > > space.
> > > >
> > > > My main concern with the v2 patch
> > > > (
> > > > https://lore.kernel.org/r/20231127211729.42668-1-nirmal.patel@linux=
.intel.com
> > > > )
> > > > is that it overrides _OSC for native_pcie_hotplug, but not for
> > > > any of
> > > > the other features (AER, PME, LTR, DPC, etc.)
> > > >
> > > > I think it's hard to read the specs and conclude that PCIe
> > > > hotplug is
> > > > a special case, and I think we're likely to have similar issues
> > > > with
> > > > other features in the future.
> > > >
> > > > But if you think this is the best solution, I'm OK with merging
> > > > it. =20
> > Hi Bjorn,
> >
> > We tried some other ways to pass the information about all of the
> > flags but I couldn't retrieve it in guest OS and VMD hardware
> > doesn't have empty registers to write this information. So as of
> > now we have this solution which only overwrites Hotplug flag. If
> > you can accept it that would be great. =20
>=20
> My original commit "PCI: vmd: Honor ACPI _OSC on PCIe features" was a
> logically conclusion based on VMD ports are just apertures.
> Apparently there are more nuances than that, and people outside of
> Intel can't possibly know. And yes VMD creates lots of headaches
> during hardware enablement.
>=20
> So is it possible to document the right way to use _OSC, as Bjorn
> suggested?
>=20
> Kai-Heng
Well we are stuck here with two issues which are kind of chicken and egg
problem.
1) VMD respects _OSC; which works excellent in Host but _OSC gives
wrong information in Guest OS which ends up disabling Hotplug, AER,
DPC, etc. We can live with AER, DPC disabled in VM but not the Hotplug.

2) VMD takes ownership of all the flags. For this to work VMD needs to
know these settings from BIOS. VMD hardware doesn't have empty register
where VMD UEFI driver can write this information. So honoring user
settings for AER, Hotplug, etc from BIOS is not possible.

Where do you want me to add documentation? Will more information in
the comment section of the Sltcap code change help?

Architecture wise VMD must own all of these flags but we have a
hardware limitation to successfully pass the necessary information to
the Host OS and the Guest OS.

Thanks
nirmal
>=20
> > > In the host OS, this overrides whatever was negotiated via _OSC, I
> > > guess on the principle that _OSC doesn't apply because the host
> > > BIOS doesn't know about the Root Ports below the VMD.  (I'm not
> > > sure it's 100% resolved that _OSC doesn't apply to them, so we
> > > should mention that assumption here.) =20
> > _OSC still controls every flag including Hotplug. I have observed
> > that slot capabilities register has hotplug enabled only when
> > platform has enabled the hotplug. So technically not overriding it
> > in the host. It overrides in guest because _OSC is passing
> > wrong/different information than the _OSC information in Host.
> > Also like I mentioned, slot capabilities registers are not changed
> > in Guest because vmd is passthrough. =20
> > >
> > > In the guest OS, this still overrides whatever was negotiated via
> > > _OSC, but presumably the guest BIOS *does* know about the Root
> > > Ports, so I don't think the same principle about overriding _OSC
> > > applies there.
> > >
> > > I think it's still a problem that we handle
> > > host_bridge->native_pcie_hotplug differently than all the other
> > > features negotiated via _OSC.  We should at least explain this
> > > somehow. =20
> > Right now this is the only way to know in Guest OS if platform has
> > enabled Hotplug or not. We have many customers complaining about
> > Hotplug being broken in Guest. So just trying to honor _OSC but also
> > fixing its limitation in Guest.
> >
> > Thanks
> > nirmal.
> > =20
> > > I sincerely apologize for late responses. I just found out that my
> > > evolution mail client is automatically sending linux-pci emails to
> > > junk
> > > since January 2024.
> > >
> > > At the moment Hotplug is an exception for us, but I do share your
> > > concern about other flags. We have done lot of testing and so far
> > > patch
> > > v2 is the best solution we have.
> > >
> > > Thanks
> > > nirmal =20
> > > > Bjorn =20
> > =20


