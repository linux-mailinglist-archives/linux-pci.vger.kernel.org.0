Return-Path: <linux-pci+bounces-31930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC0B01E26
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 15:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4F61CA6145
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A61FBEA6;
	Fri, 11 Jul 2025 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYtUWUjC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55672D3EC8
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241576; cv=none; b=WWjXWVyfeZBfwldPP12qTK16A6zGehWNIb0G9s51MzJFBSxUfqjq83zUPgHBJyHu48bYBxO4xa7Oa80YFy6h9iRU0HXFG0a/iQq+hpI07C1xDsa6Lg9whPl8EAeP9yrdfy7E7buQQQtxOs/c9fp5/KIPimu6xpJwmL58+J9SWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241576; c=relaxed/simple;
	bh=fGG4qtyOaP2TQYqoaUZipLhPfi9nMTbP0t851LEAIco=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QYSD5bbrj0oRuUJrBDW2FptWgFUewstOvhtAMHfispyIIpBe/scdxEPbQ6OwQghU6qoXycNLGaq0cA+Z9VEUAtk3rRPMyBghJQHCRnolxSMgAXtQPFE1+NHBB4cUkdMR85NOysEn/ihPFRZD1fAXVMs1ORLObaa67RImkn7n+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYtUWUjC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752241575; x=1783777575;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=fGG4qtyOaP2TQYqoaUZipLhPfi9nMTbP0t851LEAIco=;
  b=fYtUWUjCx14V4HuDuEKhQFTrBLmnasHqlCUV4GD+Hip+orlp7/erX7Dq
   +srXzfNZsCp4CYRMfbv49TMe19th3V0lJ5taBCYxiZDihe7SXmBMAS8Lr
   C6URIMqjg22ib2xmVN3ZxaEAqfzg3JY8FczvU44tkOVEYHagTbgW7Zv0B
   kZFGXgnWyMte3ptL96VQmEqL4N+O+8aA+3Px0czML/a5em+RNqx9CKLgs
   f0RuE1N1IP1WKkw+s++L5SQVYze7HrEf+KFxwaRaWRv8MIxiarei6IS6K
   BghSmfOjxZbFMwASUiD9tqVPa9Pqs3aet3Ejgen16jgApg/lY71WaFncf
   g==;
X-CSE-ConnectionGUID: Mzdn4HegSDiOehIWsf9ESw==
X-CSE-MsgGUID: hsrWh/sMQziM06Q19fh2jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54394927"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="54394927"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 06:46:15 -0700
X-CSE-ConnectionGUID: aLJlQyJ6SP6l6Oj3AXClQA==
X-CSE-MsgGUID: 51AVVeCrThaL86c99naJsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="160394117"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 06:46:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Jul 2025 16:46:08 +0300 (EEST)
To: Matthew W Carlis <mattc@purestorage.com>
cc: ashishk@purestorage.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
    macro@orcam.me.uk, msaggi@purestorage.com, sconnor@purestorage.com
Subject: Re: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is
 not ASM2824
In-Reply-To: <20250709185309.29900-1-mattc@purestorage.com>
Message-ID: <7c289bba-3133-0989-6333-41fc41fe3504@linux.intel.com>
References: <2b72378d-a8c1-56b1-3dbb-142eb4c7f302@linux.intel.com> <20250709185309.29900-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1596385370-1752228768=:933"
Content-ID: <156722b0-2254-e32b-dd47-5e1e439f1d78@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1596385370-1752228768=:933
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a4531dfe-24b8-0d7c-813e-399a7724948c@linux.intel.com>

On Wed, 9 Jul 2025, Matthew W Carlis wrote:

> On Wed, 9 Jul 2025, Ilpo J=E4rvinen wrote:
> > Are you saying there's still a problem in hpc? Since the introduction o=
f=20
> > bwctrl, remove_board() in pciehp has had pcie_reset_lbms() (or it's=20
> > equivalent).
>
> I think my concern with hpc or the current mechanism in general is that t=
he
> condition is basically binary. Across a large fleet I expect to see momen=
tary
> issues. For example a device might start to link up, have an issue & then
> try to link up again and from there be working correctly. However if that
> were to trigger an LBMS it might result in the quirk forcing the link to =
Gen1.
>=20
> For example if the quirk first guided the link to Gen1 & then if the devi=
ce
> linked up at Gen1 it tried to guide it to Gen2 & then if it linked up at =
Gen2
> it continued towards the maximum speed falling back down when it found th=
e
> device not able to achieve a certain higher speed that would be more idea=
l.
> Or perhaps starting at the second highest speed & working its way down.
> Its quite a large fall in performance for a device to go from Gen4/5 to G=
en1
> whereas the ASMedia/Pericom combination was only capable of Gen2 as a pai=
r.
> If the SI is marginal for Gen4/5 I would tend to think the device has a f=
airly
> high chance of being able to run at the next lower speed for example.

This is possible but it also come at a non-trivial latency cost, Link=20
Retraining is not very cheap.

In here, you seem to suggesting the TLS quirk might be useful for other=20
devices too besides the one on the ID list. Is that the case? (I'm asking=
=20
this because it contradicts with the patch you're submitting.)

I don't know if other speeds are generally useful, intuition tells they=20
might be. However, I've no way to gather numbers as I don't have to luxury=
=20
of large fleet of machines with PCIe devices to observe/measure. Perhaps=20
you have some insight to this beyond just hypothetizing?

> Actually I also wonder in the case of the ASMedia & Pericom combination
> would we just see a LBMS interrupt every time the device loop between
> speeds? Maybe the quirk should have been invoked by bwctrl.c when a certa=
in
> rate of LBMS assertions is detected instead? Is it better to give a devic=
e
> a few chances or to catch it right away on the first issue? (some value
> judgements here)

I investigated this as it came up while bwctrl was under review and found=
=20
various issues and challenges related to the quirk. The main problem=20
is that bwctrl being a portdrv service means it probes quite late so it's=
=20
not available very early and quirk runs mainly during that time.

It might be possible to delay bringing up of a failty device to=20
workaround that, however, it's not the end of challenges.

One would need to build a state machine to make such decisions as we don't=
=20
want to keep repeating it if the link is just broken. I lacked a way to=20
test this in a meaningful way so I just gave up and left it as future work.

But yes, it might be workable solution nobody has just written yet. If you=
=20
want to implement this, I'm certainly not against it. (I might even=20
consider writing one myself but that certainly isn't going to be a high=20
priority item for me and the current level details are not concrete enough=
=20
to be realized on the code level.)

> > As I already mentioned, for DPC I agree, it likely should reset LBMS=20
> > somewhere.
> ...
> > If you'd try this on different generations of Intel RP, you'd likely se=
e=20
> > variations there too, that's my experience when testing bwctrl.
>=20
> Yes agree about DPC especially given that there is likely vendor/device s=
pecific
> variations in assertions of the bit. There is another patch that came int=
o the
> DPC driver which suppresses surprise down error reporting which I would l=
ike to
> challenge/remove. My feeling is that the DPC driver should clear LBMS in =
all cases
> before clearing DPC status.

I suggest you make a patch to that effect.

> >> Should it not matter how long ago LBMS
> >> was asserted before we invoke a TLS modification?
> >
> > To some extent, yes, which is why we call pcie_reset_lbms() in a few=20
> > places.
>=20
> Maybe there should even be a config or sysfs file to disable the quirk be=
cause
> it kind of takes control away from users in some ways. i.e - doesn't obvi=
ously
> interact well with callers of setpci etc.

There's PCI_QUIRKS but that's probably not fine-grained enough to be=20
useful in practice at it takes away all quirks.

> >> I wonder if it shouldn't have to see some kind of actual link activity=
=20
> >> as a prereq to entering the quirk.
> >
> > How would you observe that "link activity"? Doesn't LBMS itself imply=
=20
> > "link activity" occurred?
>=20
> I was thinking literally not entering the quirk function unless the kerne=
l
> had witnessed LNKSTA_DLLLA or LNKSTA_LT in the last second.

How can we track that condition? There's nothing that tracks DLLLA nor LT,=
=20
and we can't get interrupt out of them either (AFAIK). So while it is=20
perhaps nice on conceptual level, it would require polling those bits=20
which doesn't look reasonable from implementation point-of-view.

Also, I'm not convinced it would help your cases where you have=20
short-term, intermitted failures during bring up.

> Does this preclude us from declaring a device as "broken" as done by the =
quirk
> without having seen DLLA within 1s after DLLSC Event?
> * PCI Express Base Revision - 6.7.3.3 Data Link Layer State Changed Event=
s
> "Software must allow 1 second after the Data Link Layer Link Active bit r=
eads 1b
> before it is permitted to determine that a hot plugged device which fails=
 to return
> a Successful Completion for a Valid Configuration Request is a broken dev=
ice."

If you think there is problem related to spec compliance here (there=20
well might be), patches are definitely welcome. I'm not sure from where=20
the quirk is called in this scenario and where/how the quirk logic=20
invocation can be delayed (unfortunately won't have time to look at it any=
=20
time soon either).
=20
> > > One thing that honestly doesn't make any sense to me is the ID list i=
n the
> > > quirk. If the link comes up after forcing to Gen1 then it would only =
restore
> > > TLS if the device is the ASMedia switch, but also ignoring what devic=
e is
> > > detected downstream. If we allow ASMedia to restore the speed for any=
 downstream
> > > device when we only saw the initial issue with the Pericom switch the=
n why
> > > do we exclude Intel Root Ports or AMD Root Ports or any other bridge =
from the
> > > list which did not have any issues reported.
> >=20
> > I think it's because the restore has been tested on that device=20
> > (whitelist).
> >=20
> > Your reasoning is based on assumption that TLS quirk setting Link Speed=
=20
> > to 2.5GT/s is part of "normal" operation. My view is that those=20
> > triggerings are caused by not clearing stale LBMS in the right places. =
If=20
> > LBMS is not wrongly kept, the quirk is no-op on all but that ID listed=
=20
> > device.
>=20
> I'm making a slightly different assumption which is "something is working
> until proven otherwise". We only know that the restore works on the ASMed=
ia
> when the downstream device is the Pericom switch. In fact we only know
> it works for very specific layout & configuration of these two devices.
> It seems wrong in my mind to be more restrictive on devices that don't ha=
ve
> a reported issue from, but then be less restrictive on the devices that h=
ad an
> out of spec interaction in the first place. Until reported we don't know
> how many devices might see LBMS get set during the course of linking up, =
but
> then still arrive at the maximum speed.

I wonder, if you could give my bwctrl tracing patch (below) a spin in some=
=20
case where such a problem shows up as it could show what DLLLA/LT are=20
while LNKSTA register is read from bwctrl's irq handler. I'm planning to=20
submit it eventually but placement of the tracing code has not been=20
agreed yet with the other person submitting hotplug tracing.

--
From=20e5d7bc850028a82823c2cbb822c3ba5edaa623c1 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Mon, 9 Jun 2025 20:29:29 +0300
Subject: [PATCH 1/1] PCI/bwctrl: Add trace event to BW notifications
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Frequent changes in the Link Speed or Width may indicate a PCIe
link-layer problem. PCIe BW controller listen BW notifications, i.e.,
whenever LBMS (Link Bandwidth Management Status) and/or LABS (Link
Autonomous Bandwidth Status) is asserted to indicate the Link Speed
and/or Width was changed (PCIe spec. r6.2, sec. 7.5.3.7 & 7.5.3.8).

To help troubleshooting link related problems, add trace event for LBMS
and LABS assertions.

I was (privately) asked to expose LBMS count for this purpose while
bwctrl was under review. Lukas Wunner suggested, however, to use
traceevent instead to expose finer-grained details of the LBMS
assertions (namely, the timing of the assertions and link status
details).

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/Makefile       |  3 ++-
 drivers/pci/pci-trace.c    |  9 +++++++
 drivers/pci/pci.h          |  1 -
 drivers/pci/pcie/bwctrl.c  | 13 ++++++++++
 include/linux/pci.h        |  1 +
 include/trace/events/pci.h | 49 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/pci-trace.c
 create mode 100644 include/trace/events/pci.h

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..49bd51b995cd 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -5,7 +5,8 @@
 obj-$(CONFIG_PCI)=09=09+=3D access.o bus.o probe.o host-bridge.o \
 =09=09=09=09   remove.o pci.o pci-driver.o search.o \
 =09=09=09=09   rom.o setup-res.o irq.o vpd.o \
-=09=09=09=09   setup-bus.o vc.o mmap.o devres.o
+=09=09=09=09   setup-bus.o vc.o mmap.o devres.o \
+=09=09=09=09   pci-trace.o
=20
 obj-$(CONFIG_PCI)=09=09+=3D msi/
 obj-$(CONFIG_PCI)=09=09+=3D pcie/
diff --git a/drivers/pci/pci-trace.c b/drivers/pci/pci-trace.c
new file mode 100644
index 000000000000..99af6466447f
--- /dev/null
+++ b/drivers/pci/pci-trace.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI trace functions
+ *
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/pci.h>
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..8f1fffcda364 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -452,7 +452,6 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_spee=
d speed)
 }
=20
 u8 pcie_get_supported_speeds(struct pci_dev *dev);
-const char *pci_speed_string(enum pci_bus_speed speed);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
=20
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34..7fb4e00f1e7a 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -20,6 +20,7 @@
 #define dev_fmt(fmt) "bwctrl: " fmt
=20
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
@@ -32,6 +33,8 @@
 #include <linux/slab.h>
 #include <linux/types.h>
=20
+#include <trace/events/pci.h>
+
 #include "../pci.h"
 #include "portdrv.h"
=20
@@ -208,6 +211,11 @@ static void pcie_bwnotif_disable(struct pci_dev *port)
 =09=09=09=09   PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
 }
=20
+#define PCI_EXP_LNKSTA_LINK_STATUS_MASK (PCI_EXP_LNKSTA_LBMS | \
+=09=09=09=09=09 PCI_EXP_LNKSTA_LABS | \
+=09=09=09=09=09 PCI_EXP_LNKSTA_LT | \
+=09=09=09=09=09 PCI_EXP_LNKSTA_DLLLA)
+
 static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
 {
 =09struct pcie_device *srv =3D context;
@@ -236,6 +244,11 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *con=
text)
 =09 */
 =09pcie_update_link_speed(port->subordinate);
=20
+=09trace_pci_link_event(port,
+=09=09=09     link_status & PCI_EXP_LNKSTA_LINK_STATUS_MASK,
+=09=09=09     pcie_link_speed[link_status & PCI_EXP_LNKSTA_CLS],
+=09=09=09     FIELD_GET(PCI_EXP_LNKSTA_NLW, link_status));
+
 =09return IRQ_HANDLED;
 }
=20
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..8346121c035d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -305,6 +305,7 @@ enum pci_bus_speed {
 =09PCI_SPEED_UNKNOWN=09=09=3D 0xff,
 };
=20
+const char *pci_speed_string(enum pci_bus_speed speed);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
=20
diff --git a/include/trace/events/pci.h b/include/trace/events/pci.h
new file mode 100644
index 000000000000..c7187022cba5
--- /dev/null
+++ b/include/trace/events/pci.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pci
+
+#if !defined(_TRACE_PCI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PCI_H
+
+#include <linux/pci.h>
+#include <linux/tracepoint.h>
+
+#define LNKSTA_FLAGS=09=09=09=09=09\
+=09{ PCI_EXP_LNKSTA_LT,=09"LT"},=09=09=09\
+=09{ PCI_EXP_LNKSTA_DLLLA,=09"DLLLA"},=09=09\
+=09{ PCI_EXP_LNKSTA_LBMS,=09"LBMS"},=09=09\
+=09{ PCI_EXP_LNKSTA_LABS,=09"LABS"}
+
+TRACE_EVENT(pci_link_event,
+=09TP_PROTO(struct pci_dev *dev, u16 link_status,
+=09=09 enum pci_bus_speed link_speed, u8 link_width),
+=09TP_ARGS(dev, link_status, link_speed, link_width),
+
+=09TP_STRUCT__entry(
+=09=09__string(=09name,=09=09=09pci_name(dev))
+=09=09__field(=09u16,=09=09=09link_status)
+=09=09__field(=09enum pci_bus_speed,=09link_speed)
+=09=09__field(=09u8,=09=09=09link_width)
+=09),
+
+=09TP_fast_assign(
+=09=09__assign_str(name);
+=09=09__entry->link_status=09=3D link_status;
+=09=09__entry->link_speed=09=3D link_speed;
+=09=09__entry->link_width=09=3D link_width;
+=09),
+
+=09TP_printk("%s %s x%u st=3D%s",
+=09=09  __get_str(name), pci_speed_string(__entry->link_speed),
+=09=09  __entry->link_width,
+=09=09  __print_flags((unsigned long)__entry->link_status, "|",
+=09=09=09=09LNKSTA_FLAGS))
+);
+
+#endif /* _TRACE_PCI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
--=20
2.39.5

--8323328-1596385370-1752228768=:933--

