Return-Path: <linux-pci+bounces-32638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D3B0C120
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 12:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53373B7D24
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986928DB4A;
	Mon, 21 Jul 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsEiCfeS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1904228C2D7;
	Mon, 21 Jul 2025 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093123; cv=none; b=O3sk1SOJ7t6QwpiKJvXlxOoVyKq3Yo8Ol1rvdIFhMOKoZyJsmAlc6eTYBCj/UNH2u6QP3bXO5i97cnT1lrHOXoKQcizFsmkVKwSemIl9AFy+8Toof97AXJzwTL2o7HW+VP5em/jQVKXZnoxmzmxyrOWoAO+f75mI3Y70gSwyCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093123; c=relaxed/simple;
	bh=ciYWhHQQLN6I4PF+Dk1IcyISwuZNzYfEcdeXkbEPPuY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aWQmwSPDXtID5F523XYbb6E+nunmGIYMCRIBHn/djx9ZDyrBDjt1frndmQfGnJ+lzv2lk02dWuQ6z/+9aDRufBVHuf3GrHbAWEpftQYZLBP+GvtbLrfX6+Vr59ClqXjY9EivvGTQoiRRvjZnXDtQr1lY/JQ/GPql7oI6ooFvt6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsEiCfeS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753093123; x=1784629123;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ciYWhHQQLN6I4PF+Dk1IcyISwuZNzYfEcdeXkbEPPuY=;
  b=UsEiCfeSchAriD8yqHxaVVoLlp/JDuSOEJYMMbnRj8EdryylMrkOgFoX
   t15F3Og3fVVj7hXRF5zm8mqC18T28y8HA3TXNIao1invLYhwyzuh+qA5I
   0CfnuzOiICHjq6ddBSek66jKbG+vTYIGIsSDmIojGIKh3d9PwCqJ9UmHh
   KmQbkSLSopO9sk8TBaHCwzpCg3Kk+veUlVo1d/8OJrFoM2IfuRtiFv3KX
   1l+34fespywboidw0SjPeZmNAkBnu9GXE+0hAxhCxlWrcsblCBv7lMjI3
   1b9JeUcXrl+fnD1cXjGvlT/d0h3MoGuWmRG7VTm/+STkGGVWXll83PVrJ
   g==;
X-CSE-ConnectionGUID: sMkZWdDPSKyQ4Es1JgNkKw==
X-CSE-MsgGUID: xc1bF4zrRdeKpMFsvFJkZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="66743638"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="66743638"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 03:18:42 -0700
X-CSE-ConnectionGUID: t54MNEhvQoWpJxIe/wpvCw==
X-CSE-MsgGUID: XVmkOGjnQIegha1m1KPu9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158459692"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 03:18:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Jul 2025 13:18:32 +0300 (EEST)
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: Matthew W Carlis <mattc@purestorage.com>, helgaas@kernel.org, 
    Lukas Wunner <lukas@wunner.de>, anil.s.keshavamurthy@intel.com, 
    bhelgaas@google.com, bp@alien8.de, davem@davemloft.net, 
    linux-edac@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    mark.rutland@arm.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
    naveen@kernel.org, oleg@redhat.com, peterz@infradead.org, 
    rostedt@goodmis.org, tianruidong@linux.alibaba.com, tony.luck@intel.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
In-Reply-To: <e92f8d1f-457c-4248-8397-81b0e20ff4af@linux.alibaba.com>
Message-ID: <11119800-3b6a-a683-3500-115a057c2826@linux.intel.com>
References: <20250717235055.GA2664149@bhelgaas> <20250718034616.26250-1-mattc@purestorage.com> <e92f8d1f-457c-4248-8397-81b0e20ff4af@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-483332610-1753093112=:945"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-483332610-1753093112=:945
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 18 Jul 2025, Shuai Xue wrote:
> =E5=9C=A8 2025/7/18 11:46, Matthew W Carlis =E5=86=99=E9=81=93:
> > On Thu, Jul 17, 2025 Bjorn Helgaas wrote
> > > So I think your idea of adding current link speed/width to the "Link
> > > Up" event is still on the table, and that does sound useful to me.
> >=20
> > We're already reading the link status register here to check DLLA so
> > it would be nice. I guess if everything is healthy we're probably alrea=
dy
> > at the maximum speed by this point.
> >=20
> > > In the future we might add another tracepoint when we enumerate the
> > > device and know the Vendor/Device ID.
> >=20
> > I think we might have someone who would be interested in doing it.
>=20
>=20
> Hi, all,
>=20
> IIUC, the current hotplug event (or presence event) is enough for Matthew=
=2E
> and we would like a new tracepoing for link speed change which reports
> speeds.
>=20
> For hotplug event, I plan to send a new version to
>=20
> 1. address Bjorn' concerns about event strings by removing its spaces.
>=20
> #define PCI_HOTPLUG_EVENT
> \
> =09EM(PCI_HOTPLUG_LINK_UP,=09=09=09"PCI_HOTPLUG_LINK_UP")
> \
> =09EM(PCI_HOTPLUG_LINK_DOWN,=09=09"PCI_HOTPLUG_LINK_DOWN")
> \
> =09EM(PCI_HOTPLUG_CARD_PRESENT,=09=09"PCI_HOTPLUG_CARD_PRESENT")
> \
> =09EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,
> "PCI_HOTPLUG_CARD_NOT_PRESENT")
>=20
> 2. address Ilpo comments by moving pci_hp_event to a common place
> (include/trace/events/pci.h) so that the new comming can also use it.

Ah, I only now noticed you've decided to re-place them. Please disregard=20
my other comment about this being still open/undecided item.

> For link speed change event (perhaps named as pci_link_event),
> I plan to send a seperate patch, which provides:
>=20
> =09TP_STRUCT__entry(
> =09=09__string(=09port_name,=09port_name=09)
> =09=09__field(=09unsigned char,=09cur_bus_speed=09)
> =09=09__field(=09unsigned char,=09max_bus_speed=09)
>  =09=09__field(=09unsigned char,=09width=09=09)
>  =09=09__field(=09unsigned int,=09flit_mode=09)
> =09=09__field(=09unsigned char,=09reason=09=09)
> =09=09),
>=20
> The reason field is from Lukas ideas which indicates why the link speed
> changed, e.g. "hotplug", "autonomous", "thermal", "retrain", etc.
>=20
> Are you happy with above changes?

Since you're probably quite far with the pcie link event patch too given=20
above, could you take a look at the LNKSTA flags representation in my=20
patch and incorporate those as well as there seems to always lot of=20
uncertainty about those flags when investigating the LBMS/bwctrl related=20
issues so it seems prudent to explicitly include them into the traceevent=
=20
output:

https://lore.kernel.org/linux-pci/7c289bba-3133-0989-6333-41fc41fe3504@linu=
x.intel.com/


--=20
 i.

--8323328-483332610-1753093112=:945--

