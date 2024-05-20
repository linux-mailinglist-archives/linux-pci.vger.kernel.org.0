Return-Path: <linux-pci+bounces-7668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8468C9F27
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6F6280FD7
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1031E878;
	Mon, 20 May 2024 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwR3HoZn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523DA54917
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217197; cv=none; b=YlBT2hEXVghkH+4TKZoBpXsao1ksXUHMvKF8IyBCSSzvJXN6HHMp1xT099aeyIHKEO2av80ZrOGSMsc4utc9wqIGYZ0fynHRRjUepGYcm8cHCFllTIa9gwRuW9rWEFcrffgVS/3AQYKJjNpLXRJzXx1I6oLiqFnKeAf/DPjEnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217197; c=relaxed/simple;
	bh=O/6oxNT37ZxsX1RYEwYHVNSQ2JJoR/rdgXHg/TKuRIw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ervxX5Duny+RZFTKMpP6Us/fmVYg+/JQiS1q305613duztLNkn79SHX8fNvjHfqiwEvMcn/rmg52bENveC36d8avnUF3YsvZQ8gv3axd0b+eRQv6OLmvEkNlJslGYht+8swylP5m3gJjPAypT4wL39MnLyhWwAjwqth9CbJY5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwR3HoZn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716217195; x=1747753195;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O/6oxNT37ZxsX1RYEwYHVNSQ2JJoR/rdgXHg/TKuRIw=;
  b=WwR3HoZnNuIoQnH3BU3qTIz26PZy4OD0nAKW6JXK8oEIvFyMKq2nCVqp
   dIcvlz6kfqOAq5JjcmENYhQx2ssWJsHvcAGO6bNwaoPXZ9sErscrV6k7u
   e1LrETYpNNe8wCmwdfdhZ3LgAn+9o1FV2aJd5ZFhiyurmEsjD72CNrOqY
   PEQwxGa/STu36TBKyjfQfXRpgH2FKahjvpYNSJszea9EKgCwrfG1MmSsI
   opAHoV4wQASYE1npNMh8Q+fdHuLoWHALdGQB5vv26dfLNAiImavuzaOC9
   zpW2Yw696MKroL5TIU2Zi1bhH86r+7TG+Ndi8gm1HdvXe2No4qVreSIgI
   w==;
X-CSE-ConnectionGUID: ucH1JWidTr6t9zqpEci0EA==
X-CSE-MsgGUID: YwMUzvjYRK+IR2LoG2ObKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="29860732"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="29860732"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 07:59:55 -0700
X-CSE-ConnectionGUID: 5bM04gn0SkCIusONYrwacA==
X-CSE-MsgGUID: 4bdkTVUAQ5+6TCyy3yGQkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="63383339"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 07:59:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 May 2024 17:59:48 +0300 (EEST)
To: Alex Williamson <alex.williamson@redhat.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, geoff@hostfission.com
Subject: Re: [PATCH] PCI: Release unused bridge resources during resize
In-Reply-To: <20240516074939.3689ff0d.alex.williamson@redhat.com>
Message-ID: <d00429ff-5c5a-159c-60ce-dd2e48fd08ed@linux.intel.com>
References: <20240507213125.804474-1-alex.williamson@redhat.com> <a16aeae5-9507-3a5d-de04-04eb92aefffc@linux.intel.com> <20240516074939.3689ff0d.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-671048225-1716217188=:11507"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-671048225-1716217188=:11507
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 16 May 2024, Alex Williamson wrote:

> On Mon, 13 May 2024 16:46:09 +0300 (EEST)
> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Tue, 7 May 2024, Alex Williamson wrote:
> >=20
> > > Resizing BARs can be blocked when a device in the bridge hierarchy
> > > itself consumes resources from the resized range.  This scenario is
> > > common with Intel Arc DG2 GPUs where the following is a typical
> > > topology:
> > >=20
> > >  +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Int=
el Corporation DG2 [Arc A380]
> > >                                              \-04.0-[61]----00.0  Int=
el Corporation DG2 Audio Controller
> > >=20
> > > Here the system BIOS has provided a large 64bit, prefetchable window:
> > >=20
> > > pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff win=
dow]
> > >=20
> > > But only a small portion is programmed into the root port aperture:
> > >=20
> > > pci 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bi=
t pref]
> > >=20
> > > The upstream port then provides the following aperture:
> > >=20
> > > pci 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bi=
t pref]
> > >=20
> > > With the missing range found to be consumed by the switch port itself=
:
> > >=20
> > > pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]
> > >=20
> > > The downstream port above the GPU provides the same aperture as upstr=
eam:
> > >=20
> > > pci 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bi=
t pref]
> > >=20
> > > Which is entirely consumed by the GPU:
> > >=20
> > > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> > >=20
> > > In summary, iomem reports the following:
> > >=20
> > > b000000000-bfffffffff : PCI Bus 0000:5d
> > >   bfe0000000-bff07fffff : PCI Bus 0000:5e
> > >     bfe0000000-bfefffffff : PCI Bus 0000:5f
> > >       bfe0000000-bfefffffff : PCI Bus 0000:60
> > >         bfe0000000-bfefffffff : 0000:60:00.0
> > >     bff0000000-bff07fffff : 0000:5e:00.0
> > >=20
> > > The GPU at 0000:60:00.0 supports a Resizable BAR:
> > >=20
> > > =09Capabilities: [420 v1] Physical Resizable BAR
> > > =09=09BAR 2: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB =
8GB
> > >=20
> > > However when attempting a resize we get -ENOSPC:
> > >=20
> > > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: r=
eleasing
> > > pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 6=
4bit pref]: releasing
> > > pcieport 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 6=
4bit pref]: releasing
> > > pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref=
]: can't assign; no space
> > > pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref=
]: failed to assign
> > > pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref=
]: can't assign; no space
> > > pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref=
]: failed to assign
> > > pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: can't assi=
gn; no space
> > > pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: failed to =
assign
> > > pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> > > pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > > pcieport 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff=
 64bit pref]
> > > pcieport 0000:5e:00.0: PCI bridge to [bus 5f-61]
> > > pcieport 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > > pcieport 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff=
 64bit pref]
> > > pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> > > pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> > > pcieport 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff=
 64bit pref]
> > > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: a=
ssigned
> > >=20
> > > In this example we need to resize all the way up to the root port
> > > aperture, but we refuse to change the root port aperture while resour=
ces
> > > are allocated for the upstream port BAR.
> > >=20
> > > The solution proposed here builds on the idea in commit 91fa127794ac
> > > ("PCI: Expose PCIe Resizable BAR support via sysfs") where the BAR ca=
n
> > > be resized while there is no driver attached.  In this case, when the=
re
> > > is no driver bound to the upstream switch port we'll release resource=
s
> > > of the bridge which match the reallocation.  Therefore we can achieve
> > > the below successful resize operation by unbinding 0000:5e:00.0 from =
the
> > > pcieport driver before invoking the resource2_resize interface on the
> > > GPU at 0000:60:00.0.
> > >=20
> > > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: r=
eleasing
> > > pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 6=
4bit pref]: releasing
> > > pci 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit =
pref]: releasing
> > > pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]: r=
eleasing
> > > pcieport 0000:5d:00.0: bridge window [mem 0xbfe0000000-0xbff07fffff 6=
4bit pref]: releasing
> > > pcieport 0000:5d:00.0: bridge window [mem 0xb000000000-0xb2ffffffff 6=
4bit pref]: assigned
> > > pci 0000:5e:00.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit =
pref]: assigned
> > > pci 0000:5e:00.0: BAR 0 [mem 0xb200000000-0xb2007fffff 64bit pref]: a=
ssigned
> > > pcieport 0000:5f:01.0: bridge window [mem 0xb000000000-0xb1ffffffff 6=
4bit pref]: assigned
> > > pci 0000:60:00.0: BAR 2 [mem 0xb000000000-0xb1ffffffff 64bit pref]: a=
ssigned
> > > pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> > > pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > > pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bi=
t pref]
> > > pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> > > pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > > pcieport 0000:5d:00.0:   bridge window [mem 0xb000000000-0xb2ffffffff=
 64bit pref]
> > > pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> > > pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > > pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bi=
t pref]
> > > pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> > > pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> > > pcieport 0000:5f:01.0:   bridge window [mem 0xb000000000-0xb1ffffffff=
 64bit pref]
> > >=20
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com> =20
> >=20
> > Yes. Looks another case where an already assigned resource prevents som=
e=20
> > operation from succeeding.
> >=20
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 909e6a7c3cc3..15fc8e4e84c9 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -2226,6 +2226,26 @@ void pci_assign_unassigned_bridge_resources(st=
ruct pci_dev *bridge)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
> > > =20
> > > +static void pci_release_resource_type(struct pci_dev *pdev, unsigned=
 long type)
> > > +{
> > > +=09int i;
> > > +
> > > +=09if (!device_trylock(&pdev->dev))
> > > +=09=09return;
> > > +
> > > +=09if (pdev->dev.driver) =20
> >=20
> > Isn't portdrv bound to bridges so how does this ends up working?
>=20
> The user will need to unbind the bridge from the driver, just like
> they'd need to unbind the endpoint from a driver to resize a BAR
> through sysfs.  I'm not sure how else to avoid races with drivers
> requesting resources other than to assert that there is no driver for
> the device.  Do you have an alternative suggestion?  Thanks,

Okay, understood. It just wasn't immediately obvious there was=20
this additional requirement related to unbinding the portdrv.

--=20
 i.

--8323328-671048225-1716217188=:11507--

