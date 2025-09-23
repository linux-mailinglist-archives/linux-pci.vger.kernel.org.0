Return-Path: <linux-pci+bounces-36738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF32B949AD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 08:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B1A446D75
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 06:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF12830FC0C;
	Tue, 23 Sep 2025 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbZTJz3R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1D2737E1;
	Tue, 23 Sep 2025 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609987; cv=none; b=L9qp+U25cCMd5JV6d6GTw96EMTgrGPyGWT0cq6fzHtpVA6T0EEoy3WlIWQyeJWDffxrSznn4dDdFK0DHx5cuqR6AfBjiHNm/FrfESFstEeYBwLrRLE3KyBQfksmcw++Pq46iFNmEFwEHvgDHkcDQnc3iYNK3bbsuoNeLalZmJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609987; c=relaxed/simple;
	bh=GCivlAy7lnrNCtJC//h3SqDfb5QdSrixCRyVp8er9jc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z+Z2xjQWRptjx+ql4Rvt2YPQgKknm2+VEjqqG1PmQNwp5km0jqR2wf/vS0W4OtWBrdPtZbHdu+EwkdFLMAxm5Z8AA76Mvlwd+q2CYSBMyfmKuyQxx7EPka3lVXCZJDx5zk3zyMCBqZjpiftCM7gvejDSw+DkjA16qOtXFsdIdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbZTJz3R; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758609985; x=1790145985;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GCivlAy7lnrNCtJC//h3SqDfb5QdSrixCRyVp8er9jc=;
  b=nbZTJz3RgKhc0I6CWmnjXVmJPxkJ37xFo48QbOCtOxAQu/I0t39WMPiZ
   DrvAhV2Kxoe70ZWMPOBgPjAqY9qYj8iDmL6hX8ChCy9ohegjb1TNtaqec
   BertR8A2hlMCsX8wj4GqtO8awPecRtCdmEsojQ0eqWQmHEwTUOB0ldXy/
   WqJRl3cTlpOXIJN5uNfPzs2isfWTivFN4sdgAMyB/ca1re5ejAU2eyjE9
   EwZy/SyG61pumQfT6RgFickyZYTqoTvccMkNrfSepgAWvb1PoqjCZEEIa
   Hi17pDnogv1Ii1EjvEGQyAyZ5wYVIFKziUJ6huCAqx2tOmnlz+qHTSznT
   A==;
X-CSE-ConnectionGUID: imHIr5R+T5Gf8LWyE7doyA==
X-CSE-MsgGUID: 54GgKwt0RWK2UzNhR+hGrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60937824"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="60937824"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 23:46:24 -0700
X-CSE-ConnectionGUID: HEHvwpL6QY6plyx69U4fVQ==
X-CSE-MsgGUID: 553CWKKJRqygRePCxseEtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="176615263"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 23:46:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 23 Sep 2025 09:46:13 +0300 (EEST)
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
In-Reply-To: <12c84bff-6863-4730-b08a-631df904aa12@linux.alibaba.com>
Message-ID: <fe2abb10-3847-af1c-12c2-193c32befe0c@linux.intel.com>
References: <20250920060117.866-1-xueshuai@linux.alibaba.com> <20250920060117.866-2-xueshuai@linux.alibaba.com> <6bab311a-d5ba-133c-fddd-52899959445c@linux.intel.com> <12c84bff-6863-4730-b08a-631df904aa12@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-460974142-1758609973=:961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-460974142-1758609973=:961
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 23 Sep 2025, Shuai Xue wrote:

>=20
>=20
> =E5=9C=A8 2025/9/22 21:10, Ilpo J=C3=A4rvinen =E5=86=99=E9=81=93:
> > On Sat, 20 Sep 2025, Shuai Xue wrote:
> >=20
> > > Hotplug events are critical indicators for analyzing hardware health,
> > > and surprise link downs can significantly impact system performance a=
nd
> > > reliability.
> > >=20
> > > Define a new TRACING_SYSTEM named "pci", add a generic RAS tracepoint
> > > for hotplug event to help health checks. Add enum pci_hotplug_event i=
n
> > > include/uapi/linux/pci.h so applications like rasdaemon can register
> > > tracepoint event handlers for it.
> > >=20
> > > The following output is generated when a device is hotplugged:
> > >=20
> > > $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> > > $ cat /sys/kernel/debug/tracing/trace_pipe
> > >     irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event:
> > > 0000:00:02.0 slot:10, event:CARD_PRESENT
> > >=20
> > >     irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event:
> > > 0000:00:02.0 slot:10, event:LINK_UP
> > >=20
> > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >   drivers/pci/Makefile              |  2 +
> > >   drivers/pci/hotplug/Makefile      |  3 +-
> > >   drivers/pci/hotplug/pciehp_ctrl.c | 31 ++++++++++++---
> > >   drivers/pci/trace.c               | 11 ++++++
> > >   include/trace/events/pci.h        | 63 ++++++++++++++++++++++++++++=
+++
> > >   include/uapi/linux/pci.h          |  7 ++++
> > >   6 files changed, 110 insertions(+), 7 deletions(-)
> > >   create mode 100644 drivers/pci/trace.c
> > >   create mode 100644 include/trace/events/pci.h
> > >=20
> > > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > > index 67647f1880fb..bf389bc4dd3c 100644
> > > --- a/drivers/pci/Makefile
> > > +++ b/drivers/pci/Makefile
> > > @@ -45,3 +45,5 @@ obj-y=09=09=09=09+=3D controller/
> > >   obj-y=09=09=09=09+=3D switch/
> > >     subdir-ccflags-$(CONFIG_PCI_DEBUG) :=3D -DDEBUG
> > > +
> > > +CFLAGS_trace.o :=3D -I$(src)
> > > diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makef=
ile
> > > index 40aaf31fe338..d41f7050b072 100644
> > > --- a/drivers/pci/hotplug/Makefile
> > > +++ b/drivers/pci/hotplug/Makefile
> > > @@ -65,7 +65,8 @@ rpadlpar_io-objs=09:=3D=09rpadlpar_core.o \
> > >   pciehp-objs=09=09:=3D=09pciehp_core.o=09\
> > >   =09=09=09=09pciehp_ctrl.o=09\
> > >   =09=09=09=09pciehp_pci.o=09\
> > > -=09=09=09=09pciehp_hpc.o
> > > +=09=09=09=09pciehp_hpc.o=09\
> > > +=09=09=09=09../trace.o
> >=20
> > To make it useful for any PCI tracing, not juse hotplug, this object fi=
le
> > should be added in drivers/pci/Makefile, not here.
>=20
> Make sence. How about adding to the main CONFIG_PCI object:
>=20
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index bf389bc4dd3c..d7f83d06351d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -5,7 +5,7 @@
>  obj-$(CONFIG_PCI)              +=3D access.o bus.o probe.o host-bridge.o=
 \
>                                    remove.o pci.o pci-driver.o search.o \
>                                    rom.o setup-res.o irq.o vpd.o \
> -                                  setup-bus.o vc.o mmap.o devres.o
> +                                  setup-bus.o vc.o mmap.o devres.o trace=
=2Eo
>=20
>  obj-$(CONFIG_PCI)              +=3D msi/
>  obj-$(CONFIG_PCI)              +=3D pcie/

Yes, that's the right place to add it.


--=20
 i.

--8323328-460974142-1758609973=:961--

