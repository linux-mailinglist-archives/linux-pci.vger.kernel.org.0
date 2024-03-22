Return-Path: <linux-pci+bounces-5020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B50887445
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 21:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23104B22382
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 20:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947AC7EF09;
	Fri, 22 Mar 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i47ntwK9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1156B78
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711141038; cv=none; b=sh2NY5oH8dCslcCpf9rIlRYP9yvE0y5jIb4ECwIvd4U59rau0UPQcrDs/3fswrhlkA9YSZr0z89N72K5sZXrEtpLdk52iSdkTSpyY0nhmw3uBs3BUP4O9u4E3ewKjXkFYs8C7A6HwKBNMPSueQbgLAPZfD7vD0CcurfTki3rDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711141038; c=relaxed/simple;
	bh=b9me/5pNEsIcPvSooCivLNExRcqldFAgdvOppCWKZNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJsAQ5fZrEqTnWGpm6NvI6HGcRERMlbe5pnxFxaWDqQ9daHdXh1rITw7liKaiDZCJS+4gBqz6o7ab97SG0PLUzIY/JinauNKJp6ZE8DOy0qh1aEloiAgixP1c/rM5C/vHO9cEadrjBN4UwoLmDilz3taIPi8jtNoFIInPtLsZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i47ntwK9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711141037; x=1742677037;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b9me/5pNEsIcPvSooCivLNExRcqldFAgdvOppCWKZNA=;
  b=i47ntwK9YGHxg8423wJZXup/qJ3g5mr49TB6e/P/W+UerwWfoSsQ/rab
   LjwOt9vOaam+xqyYxh4TCO/sjr8WdrxWVKBShB2CUld4wtliBe1x63KmB
   t1g7iowYFCBvxIvGMQgH9OjYjEtvfMLUQ9h+rTNgGgUo+2ES2+fYyQ0Ao
   nlaEKixpGmWT+KLRQ62SrIJFp7qs7IpV/tVlAMBpMC0fH9rb2pozvYHjh
   lwtRIqPLW1BjYRGLmF4TQ3cafUYg+UjJkVIkFGSijs6Lb2pSKljCBiabF
   ZJQMzNqAbjhxlhk9YB/0ku1dLvSLEzuHcpmKsXJuTvLpLJnl2iSjiOTPw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6413935"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6413935"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 13:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="19724222"
Received: from patelni-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.165.191])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 13:57:03 -0700
Date: Fri, 22 Mar 2024 13:57:00 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on
 VMD rootports
Message-ID: <20240322135700.0000192a@linux.intel.com>
In-Reply-To: <CAAd53p79uvaY7QOQCBP=ztnyzsXaiKAiR8-A5sCDXmqnr-3LrA@mail.gmail.com>
References: <20240207185549.GA910460@bhelgaas>
	<af071f45513778a9392efb1a9f41f1e18d2670f0.camel@linux.intel.com>
	<46b737db266f08c6dc98c77044bab12491a4d971.camel@linux.intel.com>
	<CAAd53p4j3MwigsFXpftuDdSfhn7EH_-cOOjP2DqnqeAuD+Fb=Q@mail.gmail.com>
	<20240307170904.00001cd4@linux.intel.com>
	<CAAd53p79uvaY7QOQCBP=ztnyzsXaiKAiR8-A5sCDXmqnr-3LrA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Mar 2024 09:29:32 +0800
Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> On Fri, Mar 8, 2024 at 8:09=E2=80=AFAM Nirmal Patel
> <nirmal.patel@linux.intel.com> wrote:
> >
> > On Thu, 7 Mar 2024 14:44:23 +0800
> > Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > =20
> > > Hi Nirmal,
> > >
> > > On Thu, Mar 7, 2024 at 6:20=E2=80=AFAM Nirmal Patel
> > > <nirmal.patel@linux.intel.com> wrote: =20
> > > >
> > > > On Tue, 2024-02-13 at 10:47 -0700, Nirmal Patel wrote: =20
> > > > > On Wed, 2024-02-07 at 12:55 -0600, Bjorn Helgaas wrote: =20
> > > > > > On Tue, Feb 06, 2024 at 05:27:29PM -0700, Nirmal Patel
> > > > > > wrote: =20
> > > > > > > ...
> > > > > > > Did you have a chance to look at my response on January
> > > > > > > 16th to your
> > > > > > > questions? I tried to summarize all of the potential
> > > > > > > problems and issues with different fixes. Please let me
> > > > > > > know if it is easier if
> > > > > > > I
> > > > > > > resend the explanation. Thanks. =20
> > > > > >
> > > > > > I did see your Jan 16 response, thanks.
> > > > > >
> > > > > > I had more questions after reading it, but they're more
> > > > > > about understanding the topology seen by the host and the
> > > > > > guest: Jan 16:
> > > > > > https://lore.kernel.org/r/20240117004933.GA108810@bhelgaas
> > > > > >   Feb  1:
> > > > > > https://lore.kernel.org/r/20240201211620.GA650432@bhelgaas
> > > > > >
> > > > > > As I mentioned in my second Feb 1 response
> > > > > > (https://lore.kernel.org/r/20240201222245.GA650725@bhelgaas),
> > > > > > the usual plan envisioned by the PCI Firmware spec is that
> > > > > > an OS can use
> > > > > > a
> > > > > > PCIe feature if the platform has granted the OS ownership
> > > > > > via _OSC and
> > > > > > a device advertises the feature via a Capability in config
> > > > > > space.
> > > > > >
> > > > > > My main concern with the v2 patch
> > > > > > (
> > > > > > https://lore.kernel.org/r/20231127211729.42668-1-nirmal.patel@l=
inux.intel.com
> > > > > > )
> > > > > > is that it overrides _OSC for native_pcie_hotplug, but not
> > > > > > for any of
> > > > > > the other features (AER, PME, LTR, DPC, etc.)
> > > > > >
> > > > > > I think it's hard to read the specs and conclude that PCIe
> > > > > > hotplug is
> > > > > > a special case, and I think we're likely to have similar
> > > > > > issues with
> > > > > > other features in the future.
> > > > > >
> > > > > > But if you think this is the best solution, I'm OK with
> > > > > > merging it. =20
> > > > Hi Bjorn,
> > > >
> > > > We tried some other ways to pass the information about all of
> > > > the flags but I couldn't retrieve it in guest OS and VMD
> > > > hardware doesn't have empty registers to write this
> > > > information. So as of now we have this solution which only
> > > > overwrites Hotplug flag. If you can accept it that would be
> > > > great. =20
> > >
> > > My original commit "PCI: vmd: Honor ACPI _OSC on PCIe features"
> > > was a logically conclusion based on VMD ports are just apertures.
> > > Apparently there are more nuances than that, and people outside of
> > > Intel can't possibly know. And yes VMD creates lots of headaches
> > > during hardware enablement.
> > >
> > > So is it possible to document the right way to use _OSC, as Bjorn
> > > suggested?
> > >
> > > Kai-Heng =20
> > Well we are stuck here with two issues which are kind of chicken
> > and egg problem.
> > 1) VMD respects _OSC; which works excellent in Host but _OSC gives
> > wrong information in Guest OS which ends up disabling Hotplug, AER,
> > DPC, etc. We can live with AER, DPC disabled in VM but not the
> > Hotplug.
> >
> > 2) VMD takes ownership of all the flags. For this to work VMD needs
> > to know these settings from BIOS. VMD hardware doesn't have empty
> > register where VMD UEFI driver can write this information. So
> > honoring user settings for AER, Hotplug, etc from BIOS is not
> > possible.
> >
> > Where do you want me to add documentation? Will more information in
> > the comment section of the Sltcap code change help?
> >
> > Architecture wise VMD must own all of these flags but we have a
> > hardware limitation to successfully pass the necessary information
> > to the Host OS and the Guest OS. =20
>=20
> If there's an official document on intel.com, it can make many things
> clearer and easier.
> States what VMD does and what VMD expect OS to do can be really
> helpful. Basically put what you wrote in an official document.
>=20
> Kai-Heng

Hi Kai-Heng/ Bjorn,
Thanks for the suggestion. I can certainly find official VMD
architecture document and add that required information to
Documentation/PCI/controller/vmd.rst. Will that be okay?

I also need your some help/suggestion on following alternate solution.
We have been looking at VMD HW registers to find some empty registers.
Cache Line Size register offset OCh is not being used by VMD. This is
the explanation in PCI spec 5.0 section 7.5.1.1.7:
"This read-write register is implemented for legacy compatibility
purposes but has no effect on any PCI Express device behavior."
Can these registers be used for passing _OSC settings from BIOS to VMD
OS driver?

These 8 bits are more than enough for UEFI VMD driver to store all _OSC
flags and VMD OS driver can read it during OS boot up. This will solve
all of our issues.

Thanks
nirmal

>=20
> >
> > Thanks
> > nirmal =20
> > > =20
> > > > > In the host OS, this overrides whatever was negotiated via
> > > > > _OSC, I guess on the principle that _OSC doesn't apply
> > > > > because the host BIOS doesn't know about the Root Ports below
> > > > > the VMD.  (I'm not sure it's 100% resolved that _OSC doesn't
> > > > > apply to them, so we should mention that assumption here.) =20
> > > > _OSC still controls every flag including Hotplug. I have
> > > > observed that slot capabilities register has hotplug enabled
> > > > only when platform has enabled the hotplug. So technically not
> > > > overriding it in the host. It overrides in guest because _OSC
> > > > is passing wrong/different information than the _OSC
> > > > information in Host. Also like I mentioned, slot capabilities
> > > > registers are not changed in Guest because vmd is passthrough. =20
> > > > >
> > > > > In the guest OS, this still overrides whatever was negotiated
> > > > > via _OSC, but presumably the guest BIOS *does* know about the
> > > > > Root Ports, so I don't think the same principle about
> > > > > overriding _OSC applies there.
> > > > >
> > > > > I think it's still a problem that we handle
> > > > > host_bridge->native_pcie_hotplug differently than all the
> > > > > other features negotiated via _OSC.  We should at least
> > > > > explain this somehow. =20
> > > > Right now this is the only way to know in Guest OS if platform
> > > > has enabled Hotplug or not. We have many customers complaining
> > > > about Hotplug being broken in Guest. So just trying to honor
> > > > _OSC but also fixing its limitation in Guest.
> > > >
> > > > Thanks
> > > > nirmal.
> > > > =20
> > > > > I sincerely apologize for late responses. I just found out
> > > > > that my evolution mail client is automatically sending
> > > > > linux-pci emails to junk
> > > > > since January 2024.
> > > > >
> > > > > At the moment Hotplug is an exception for us, but I do share
> > > > > your concern about other flags. We have done lot of testing
> > > > > and so far patch
> > > > > v2 is the best solution we have.
> > > > >
> > > > > Thanks
> > > > > nirmal =20
> > > > > > Bjorn =20
> > > > =20
> > =20


