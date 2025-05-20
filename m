Return-Path: <linux-pci+bounces-28082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133EAABD433
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872414A44E9
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBCB26A1AA;
	Tue, 20 May 2025 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/P8ZdAT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FF26A0F6;
	Tue, 20 May 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735661; cv=none; b=qgTmuhb5Z78xtUYLGqa5FGbmlPZAr60FAICacAj52TH3AW19eksZJPprvin6fhu8/xkRnXRih5UyfDRMza5oLOMe7YT3XkZJvn6OQJhcoV2iIBZLWUL3TAZY0tTUB8/maf24L88yO39lX7Fc/6Oz1pYjKDYyIkPXNr7fh0CyQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735661; c=relaxed/simple;
	bh=nBJkZXNbdiTT4TtUhW1xrZ1w9aUSLA3c/ko7B4Kt5Os=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c7njjv7OIt/fksDkLCTWOt7Ih2PNt4gfX5IufEJpl6NI7dUXNdUUCoIKEvGp67SmeI+ECAcY1ZUGV0Xn1AaGmsKvPBsUJ9ZnJ5p8TmjldBEMYSF3ImClcBoYC9/5VkVCeRi/iqXLVTaRs8Fb99BB5/IQ3ff9ZXDlTT33cqlg7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/P8ZdAT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747735659; x=1779271659;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nBJkZXNbdiTT4TtUhW1xrZ1w9aUSLA3c/ko7B4Kt5Os=;
  b=G/P8ZdATz8JmJcoxQg11MSiziugSdX5uJelsKrBIbu9C1IGX1td6IdL0
   NqpXuBvOnmUxD17z/SEHD3sFXZYvVKpFt/SRynoT7XyJk/8yspkatLvB0
   r9UxfgivCIqVOYImHuxkLQEqw9a18nNWTardyjBiGDYFVTWTCkFTvVyPe
   joTlz5gCJTO5evvpXUNAhmO5RiWAsajAgR/xqxQuF43cPIPCdHrwZzOtL
   NNpRKRt1zxZ/uN6TL43XGm2IHLGW/bEU++z6+16Zj+5zFFVpVowuf2Fy3
   LA3k9a+glP0LJt6sdpHcZMsoF19iuFaxHSlAyV4CUh4QksxhhuMuA5aD6
   w==;
X-CSE-ConnectionGUID: qkOrKZjVQCa3V5yU2DL3mQ==
X-CSE-MsgGUID: jGEsh26QTkugH2XmccNwBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="72173352"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72173352"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:07:38 -0700
X-CSE-ConnectionGUID: NYKCjjLCTTO+ND9iovPoSg==
X-CSE-MsgGUID: Uj2IGygfQsSchAx47NQFeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139678174"
Received: from johunt-mobl9.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:07:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 13:07:28 +0300 (EEST)
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: rostedt@goodmis.org, Lukas Wunner <lukas@wunner.de>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    helgaas@kernel.org, bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, 
    mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, 
    naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com, 
    mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
In-Reply-To: <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com>
Message-ID: <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com> <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com> <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-653060713-1747735648=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-653060713-1747735648=:936
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 May 2025, Shuai Xue wrote:

> Hi, Ilpo,
>=20
> =E5=9C=A8 2025/5/20 01:10, Ilpo J=C3=A4rvinen =E5=86=99=E9=81=93:
> > On Mon, 12 May 2025, Shuai Xue wrote:
> >=20
> > > Hotplug events are critical indicators for analyzing hardware health,
> > > particularly in AI supercomputers where surprise link downs can
> > > significantly impact system performance and reliability.
> > >=20
> > > To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
> > > tracepoint for hotplug event to help healthy check, and generate
> > > tracepoints for pcie hotplug event. Add enum pci_hotplug_event in
> > > include/uapi/linux/pci.h so applications like rasdaemon can register
> > > tracepoint event handlers for it.
> > >=20
> > > The output like below:
> > >=20
> > > $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> > > $ cat /sys/kernel/debug/tracing/trace_pipe
> > >      <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02=
=2E0
> > > slot:10, event:Link Down
> > >=20
> > >      <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02=
=2E0
> > > slot:10, event:Card not present
> > >=20
> > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > > changes since v7:
> > > - replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
> > > - pick up Reviewed-by from Lukas Wunner
> > > ---
> > >   drivers/pci/hotplug/Makefile      |  3 ++
> > >   drivers/pci/hotplug/pciehp_ctrl.c | 33 ++++++++++++---
> > >   drivers/pci/hotplug/trace.h       | 68 ++++++++++++++++++++++++++++=
+++
> > >   include/uapi/linux/pci.h          |  7 ++++
> > >   4 files changed, 105 insertions(+), 6 deletions(-)
> > >   create mode 100644 drivers/pci/hotplug/trace.h
> > >=20
> > > diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makef=
ile
> > > index 40aaf31fe338..a1a9d1e98962 100644
> > > --- a/drivers/pci/hotplug/Makefile
> > > +++ b/drivers/pci/hotplug/Makefile
> > > @@ -3,6 +3,9 @@
> > >   # Makefile for the Linux kernel pci hotplug controller drivers.
> > >   #
> > >   +# define_trace.h needs to know how to find our header
> > > +CFLAGS_pciehp_ctrl.o=09=09=09=09:=3D -I$(src)
> > > +
> > >   obj-$(CONFIG_HOTPLUG_PCI)=09=09+=3D pci_hotplug.o
> > >   obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)=09+=3D cpqphp.o
> > >   obj-$(CONFIG_HOTPLUG_PCI_IBM)=09=09+=3D ibmphp.o
> > > diff --git a/drivers/pci/hotplug/pciehp_ctrl.c
> > > b/drivers/pci/hotplug/pciehp_ctrl.c
> > > index d603a7aa7483..f9beb4d3a9b8 100644
> > > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > > @@ -23,6 +23,9 @@
> > >   #include "../pci.h"
> > >   #include "pciehp.h"
> > >   +#define CREATE_TRACE_POINTS
> > > +#include "trace.h"
> > > +
> > >   /* The following routines constitute the bulk of the
> > >      hotplug controller logic
> > >    */
> > > @@ -244,12 +247,20 @@ void pciehp_handle_presence_or_link_change(stru=
ct
> > > controller *ctrl, u32 events)
> > >   =09case ON_STATE:
> > >   =09=09ctrl->state =3D POWEROFF_STATE;
> > >   =09=09mutex_unlock(&ctrl->state_lock);
> > > -=09=09if (events & PCI_EXP_SLTSTA_DLLSC)
> > > +=09=09if (events & PCI_EXP_SLTSTA_DLLSC) {
> > >   =09=09=09ctrl_info(ctrl, "Slot(%s): Link Down\n",
> > >   =09=09=09=09  slot_name(ctrl));
> > > -=09=09if (events & PCI_EXP_SLTSTA_PDC)
> > > +=09=09=09trace_pci_hp_event(pci_name(ctrl->pcie->port),
> > > +=09=09=09=09=09   slot_name(ctrl),
> > > +=09=09=09=09=09   PCI_HOTPLUG_LINK_DOWN);
> > > +=09=09}
> > > +=09=09if (events & PCI_EXP_SLTSTA_PDC) {
> > >   =09=09=09ctrl_info(ctrl, "Slot(%s): Card not present\n",
> > >   =09=09=09=09  slot_name(ctrl));
> > > +=09=09=09trace_pci_hp_event(pci_name(ctrl->pcie->port),
> > > +=09=09=09=09=09   slot_name(ctrl),
> > > +=09=09=09=09=09   PCI_HOTPLUG_CARD_NOT_PRESENT);
> > > +=09=09}
> > >   =09=09pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
> > >   =09=09break;
> > >   =09default:
> > > @@ -269,6 +280,9 @@ void pciehp_handle_presence_or_link_change(struct
> > > controller *ctrl, u32 events)
> > >   =09=09=09=09=09      INDICATOR_NOOP);
> > >   =09=09=09ctrl_info(ctrl, "Slot(%s): Card not present\n",
> > >   =09=09=09=09  slot_name(ctrl));
> > > +=09=09=09trace_pci_hp_event(pci_name(ctrl->pcie->port),
> > > +=09=09=09=09=09   slot_name(ctrl),
> > > +=09=09=09=09=09   PCI_HOTPLUG_CARD_NOT_PRESENT);
> > >   =09=09}
> > >   =09=09mutex_unlock(&ctrl->state_lock);
> > >   =09=09return;
> > > @@ -281,12 +295,19 @@ void pciehp_handle_presence_or_link_change(stru=
ct
> > > controller *ctrl, u32 events)
> > >   =09case OFF_STATE:
> > >   =09=09ctrl->state =3D POWERON_STATE;
> > >   =09=09mutex_unlock(&ctrl->state_lock);
> > > -=09=09if (present)
> > > +=09=09if (present) {
> > >   =09=09=09ctrl_info(ctrl, "Slot(%s): Card present\n",
> > >   =09=09=09=09  slot_name(ctrl));
> > > -=09=09if (link_active)
> > > -=09=09=09ctrl_info(ctrl, "Slot(%s): Link Up\n",
> > > -=09=09=09=09  slot_name(ctrl));
> > > +=09=09=09trace_pci_hp_event(pci_name(ctrl->pcie->port),
> > > +=09=09=09=09=09   slot_name(ctrl),
> > > +=09=09=09=09=09   PCI_HOTPLUG_CARD_PRESENT);
> > > +=09=09}
> > > +=09=09if (link_active) {
> > > +=09=09=09ctrl_info(ctrl, "Slot(%s): Link Up\n",
> > > slot_name(ctrl));
> > > +=09=09=09trace_pci_hp_event(pci_name(ctrl->pcie->port),
> > > +=09=09=09=09=09   slot_name(ctrl),
> > > +=09=09=09=09=09   PCI_HOTPLUG_LINK_UP);
> > > +=09=09}
> > >   =09=09ctrl->request_result =3D pciehp_enable_slot(ctrl);
> > >   =09=09break;
> > >   =09default:
> > > diff --git a/drivers/pci/hotplug/trace.h b/drivers/pci/hotplug/trace.=
h
> > > new file mode 100644
> > > index 000000000000..21329c198019
> > > --- /dev/null
> > > +++ b/drivers/pci/hotplug/trace.h
> > > @@ -0,0 +1,68 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#if !defined(_TRACE_HW_EVENT_PCI_HP_H) ||
> > > defined(TRACE_HEADER_MULTI_READ)
> > > +#define _TRACE_HW_EVENT_PCI_HP_H
> > > +
> > > +#include <linux/tracepoint.h>
> > > +
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM pci
> > > +
> > > +#define PCI_HOTPLUG_EVENT=09=09=09=09=09\
> > > +=09EM(PCI_HOTPLUG_LINK_UP,=09=09=09"Link Up")=09\
> > > +=09EM(PCI_HOTPLUG_LINK_DOWN,=09=09"Link Down")=09\
> > > +=09EM(PCI_HOTPLUG_CARD_PRESENT,=09=09"Card present")=09\
> > > +=09EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,=09"Card not present")
> >=20
> > Hi,
> >=20
> > While I was thinking of adding tracing into PCIe BW controller (bwctrl)=
,
> > I ended up thinking that perhaps it would make more sense to have PCIe
> > Link related tracepoints which would cover both hotplug and bwctrl so t=
hat
> > also Link Speed changes would be reported through the same trace event.
> >=20
> > Downgraded speed may indicate there's something wrong with the card and
> > the Link Speed does have performance impact too for those who are pushi=
ng
> > BW boundaries such as AI systems.
>=20
> Agreed!
>=20
> >=20
> > So my suggestion is:
> >=20
> > - Add "Link Speed changed" to the event types.
> > - Add Link Speed and Width into the event format (and probably also Fli=
t
> >    mode as PCIe gen6 is coming).
>=20
>=20
> How about bellow event format:
>=20
> +=09TP_STRUCT__entry(
> +=09=09__string(=09port_name,=09port_name=09)
> +=09=09__field(=09unsigned char,=09cur_bus_speed=09)
> +=09=09__field(=09unsigned char,=09max_bus_speed=09)

Add also the Link Width.

> +=09=09__field(=09unsigned char,=09flit_mode=09)
> +=09),
>=20
> And add the event to pcie_update_link_speed():
>=20
> @@ -796,6 +799,10 @@ void pcie_update_link_speed(struct pci_bus *bus)
>         pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
>         pcie_capability_read_word(bridge, PCI_EXP_LNKSTA2, &linksta2);
>         __pcie_update_link_speed(bus, linksta, linksta2);
> +
> +       trace_pci_link_event(pci_name(bridge), bus->cur_bus_speed,
> +                                          bus->max_bus_speed,

I don't think outputting the internal values of enum pci_bus_speed is a=20
good idea. Maybe these could be printed as a string (with=20
pci_speed_string()) or encoded with trace interface specific values.

Perhaps it would make sense to check if the speed really changed before=20
sending that event, but there are good sides in both approaches as I=20
know some platforms assert LBMS more than once during a single Link Speed=
=20
change.

> +                                          PCI_HOTPLUG_LINK_SPEED_CHANGED=
);
>=20
> But I don't find link speed changed in hotplug driver

pciehp_check_link_status() calls __pcie_update_link_speed().

> , and the format of "Link Speed changed" is a bit different from=20
> "pci_hp_event".

The difference is only because when the Link is down, there's no Link
Speed (obviously). Whenever a new device is hotplugged and it comes up,=20
there's also Link Speed for it which can be included into the trace event.=
=20

I think the trace event should have some special value for the fields that=
=20
are N/A due to Link being off. While it would be possible to create=20
separate events for speed changes and hotplug, I don't see any pros in=20
that approach over just having the N/A fields marked as such when the Link=
=20
is Down.

Perhaps it would even make sense to add PCIE_SPEED_LINK_DOWN into=20
bus->cur_bus_speed when hotplug finds the card is gone (I'm not entirely=20
sure how bwctrl or pcie_cooling driver would cope with that though, they=20
might need minor tweaking to support it, and there are a few other drivers=
=20
that use that field).

> Do we really need a PCI_HOTPLUG_EVENT? May PCI_LINK_EVENT is more
> appropriate?

Ah, right, I forgot to mention it would make sense to rename it to=20
PCI_LINK_EVENT.

--=20
 i.

--8323328-653060713-1747735648=:936--

