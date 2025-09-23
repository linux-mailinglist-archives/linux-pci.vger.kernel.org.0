Return-Path: <linux-pci+bounces-36741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF47B94BC7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A722A1A4C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02F3112C1;
	Tue, 23 Sep 2025 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibKUIfmy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276B2E92BC;
	Tue, 23 Sep 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612045; cv=none; b=skqXt5zK4jzmTGXqr8R7OEASnRGBNimXwEMwd+uP4v14wWTHBPvrnbB1NKbEx08DsYYzn4Cnl4pHH18Bb4DEOTiiDa8SXBwK6RYYx0mCysdtARt2aSbxOPwbR1xNNHOvWDr29qhDQj4un1IZWLflMJ8+p5KVM3o0N8j6VoDsHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612045; c=relaxed/simple;
	bh=NM+WVMMbwfyE2avIQz4XHEsgxzTEwWfCVzaJ5Wiw12s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nsP1H0whIDPTcZayPmkPZPS3dbmqUUZZe+QOpo351Z6hFiltDzQkwSI9zP6td3cIGGSKHwRPaPXxu3E0MnfQ13JigxFeoDhdxvTC/MTUctKGcYYGqMtZ7dC/qzvEn1GBuy6+NWKedscwR7qZA2CdNQw2o9DvOQzQEsgphjQ1Tmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibKUIfmy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758612043; x=1790148043;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NM+WVMMbwfyE2avIQz4XHEsgxzTEwWfCVzaJ5Wiw12s=;
  b=ibKUIfmyaU4eQM8puEblWBGM3iNObR7qyk3EhUJr/wetLbKdg0CosuuC
   x9fgY59tFWp5S2PBV2BdQmX1g90o7KQBvTMeE9oCIZaRMH47Qsyq4ae0G
   iDG4qO6odgANOME6MOvnv1+5Vw2MFWj9FdTI2v4+7tjS6v/IEApuXQa0J
   1OLvvZW/gR6ne/s4JYLgdKI349m/smtECHWzNhGdXV4G2K0TRKSfyd4hr
   HHatfeOQxyG7s6hyt7hpgT0ZWiEfGXUkqf8oBV70uUE/5WrMmlwUcLPIV
   nGIBHzp2yB+bsg5UqKGp02iAOZeB6knjhnYmqjouEaO/wAaVb39CypCEz
   w==;
X-CSE-ConnectionGUID: PX6oJ4FbS0ewc+Q47R8ADg==
X-CSE-MsgGUID: f88pb8RAT4+PlrLOfDyo5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64688360"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64688360"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 00:20:43 -0700
X-CSE-ConnectionGUID: YiTgV3tkSBexGCD1hWtrzA==
X-CSE-MsgGUID: Dwz4Et+mQea9x4xlzLxoRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="175829638"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 00:20:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 23 Sep 2025 10:20:31 +0300 (EEST)
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: rostedt@goodmis.org, Lukas Wunner <lukas@wunner.de>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    helgaas@kernel.org, mattc@purestorage.com, Jonathan.Cameron@huawei.com, 
    bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, 
    mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, 
    naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com, 
    mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v10 1/3] PCI: trace: Add a generic RAS tracepoint for
 hotplug event
In-Reply-To: <fb87ff46-ebcf-450d-bfd5-b1ef52cda4be@linux.alibaba.com>
Message-ID: <acfde737-23b3-7b0a-65c6-01082a71e5e8@linux.intel.com>
References: <20250920060117.866-1-xueshuai@linux.alibaba.com> <20250920060117.866-2-xueshuai@linux.alibaba.com> <6bab311a-d5ba-133c-fddd-52899959445c@linux.intel.com> <12c84bff-6863-4730-b08a-631df904aa12@linux.alibaba.com> <fe2abb10-3847-af1c-12c2-193c32befe0c@linux.intel.com>
 <fb87ff46-ebcf-450d-bfd5-b1ef52cda4be@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1081156175-1758612031=:961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1081156175-1758612031=:961
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 23 Sep 2025, Shuai Xue wrote:

>=20
>=20
> =E5=9C=A8 2025/9/23 14:46, Ilpo J=C3=A4rvinen =E5=86=99=E9=81=93:
> > On Tue, 23 Sep 2025, Shuai Xue wrote:
> >=20
> > >=20
> > >=20
> > > =E5=9C=A8 2025/9/22 21:10, Ilpo J=C3=A4rvinen =E5=86=99=E9=81=93:
> > > > On Sat, 20 Sep 2025, Shuai Xue wrote:
> > > >=20
> > > > > Hotplug events are critical indicators for analyzing hardware hea=
lth,
> > > > > and surprise link downs can significantly impact system performan=
ce
> > > > > and
> > > > > reliability.
> > > > >=20
> > > > > Define a new TRACING_SYSTEM named "pci", add a generic RAS tracep=
oint
> > > > > for hotplug event to help health checks. Add enum pci_hotplug_eve=
nt in
> > > > > include/uapi/linux/pci.h so applications like rasdaemon can regis=
ter
> > > > > tracepoint event handlers for it.
> > > > >=20
> > > > > The following output is generated when a device is hotplugged:
> > > > >=20
> > > > > $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enab=
le
> > > > > $ cat /sys/kernel/debug/tracing/trace_pipe
> > > > >      irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event=
:
> > > > > 0000:00:02.0 slot:10, event:CARD_PRESENT
> > > > >=20
> > > > >      irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event=
:
> > > > > 0000:00:02.0 slot:10, event:LINK_UP
> > > > >=20
> > > > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > > > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > > > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > ---
> > > > >    drivers/pci/Makefile              |  2 +
> > > > >    drivers/pci/hotplug/Makefile      |  3 +-
> > > > >    drivers/pci/hotplug/pciehp_ctrl.c | 31 ++++++++++++---
> > > > >    drivers/pci/trace.c               | 11 ++++++
> > > > >    include/trace/events/pci.h        | 63
> > > > > +++++++++++++++++++++++++++++++
> > > > >    include/uapi/linux/pci.h          |  7 ++++
> > > > >    6 files changed, 110 insertions(+), 7 deletions(-)
> > > > >    create mode 100644 drivers/pci/trace.c
> > > > >    create mode 100644 include/trace/events/pci.h
> > > > >=20
> > > > > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > > > > index 67647f1880fb..bf389bc4dd3c 100644
> > > > > --- a/drivers/pci/Makefile
> > > > > +++ b/drivers/pci/Makefile
> > > > > @@ -45,3 +45,5 @@ obj-y=09=09=09=09+=3D controller/
> > > > >    obj-y=09=09=09=09+=3D switch/
> > > > >      subdir-ccflags-$(CONFIG_PCI_DEBUG) :=3D -DDEBUG
> > > > > +
> > > > > +CFLAGS_trace.o :=3D -I$(src)
> > > > > diff --git a/drivers/pci/hotplug/Makefile
> > > > > b/drivers/pci/hotplug/Makefile
> > > > > index 40aaf31fe338..d41f7050b072 100644
> > > > > --- a/drivers/pci/hotplug/Makefile
> > > > > +++ b/drivers/pci/hotplug/Makefile
> > > > > @@ -65,7 +65,8 @@ rpadlpar_io-objs=09:=3D=09rpadlpar_core.o \
> > > > >    pciehp-objs=09=09:=3D=09pciehp_core.o=09\
> > > > >    =09=09=09=09pciehp_ctrl.o=09\
> > > > >    =09=09=09=09pciehp_pci.o=09\
> > > > > -=09=09=09=09pciehp_hpc.o
> > > > > +=09=09=09=09pciehp_hpc.o=09\
> > > > > +=09=09=09=09../trace.o
> > > >=20
> > > > To make it useful for any PCI tracing, not juse hotplug, this objec=
t
> > > > file
> > > > should be added in drivers/pci/Makefile, not here.
> > >=20
> > > Make sence. How about adding to the main CONFIG_PCI object:
> > >=20
> > > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > > index bf389bc4dd3c..d7f83d06351d 100644
> > > --- a/drivers/pci/Makefile
> > > +++ b/drivers/pci/Makefile
> > > @@ -5,7 +5,7 @@
> > >   obj-$(CONFIG_PCI)              +=3D access.o bus.o probe.o host-bri=
dge.o \
> > >                                     remove.o pci.o pci-driver.o searc=
h.o \
> > >                                     rom.o setup-res.o irq.o vpd.o \
> > > -                                  setup-bus.o vc.o mmap.o devres.o
> > > +                                  setup-bus.o vc.o mmap.o devres.o
> > > trace.o
> > >=20
> > >   obj-$(CONFIG_PCI)              +=3D msi/
> > >   obj-$(CONFIG_PCI)              +=3D pcie/
> >=20
> > Yes, that's the right place to add it.
> >=20
>=20
> Thanks for confirm.
> Will send a new version to fix it.

I actually now started to wonder if it should be made depend on some=20
tracing related config (sending this out quickly if you were just=20
waiting for my confirmation to send quickly... I'm still investigating
what other subsystems do).

--=20
 i.

--8323328-1081156175-1758612031=:961--

