Return-Path: <linux-pci+bounces-13336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF497DC46
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2024 11:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C491C20E72
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2024 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC34140E3C;
	Sat, 21 Sep 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrLYY33t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA75F9DF
	for <linux-pci@vger.kernel.org>; Sat, 21 Sep 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726909702; cv=none; b=H3mbuSSXiu9/AsnE52QLzQqj0qiDMb/yfssLaPy4tR8e40UvUSremexTyWT0GU0Qu5WIqPDiSLdz0VUnqBDIzbK76mShFaicOCxmgiZUEP4J+LDpXRFvoj60pAkC2fYZ/1B75NiyZjRVP+312tQutgT2p546W45lbVlz4ORNRoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726909702; c=relaxed/simple;
	bh=mtXdgL13DnWCdOgleEm3z5nu7kK6RrLpxbPmrYudg/s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RQ3EnvIWw3xB1F7P7fDTI49I+X1gDsUY67LxzKqFVFyJ+OZHwpfAzb5onAJndW28Q8aX7q85+rR/8sfTMkbilWtqUkuuuDFbCC84PycLwGBu7J13z52MCjSg0oQs3CgoFRSBbm0PH37UAjNPtkBhm8hBeWqGnt+OH6vIF2k1EGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrLYY33t; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726909701; x=1758445701;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=mtXdgL13DnWCdOgleEm3z5nu7kK6RrLpxbPmrYudg/s=;
  b=TrLYY33tIs66s++zRR1xfoKJcH2Uf4XzJSuIaM5W/V8JpFvIc5Vpv1l/
   fIIuaBNtGAjKQX24B2b367rcXwyCw9npeN3xe2XDf0791EqolwPk6qf81
   6ZksbYHK4PqvCjDOVvBVzCpYJl5i4ObVNc27cqGsRexdWAVsUsMorBrV2
   f1fgv9fzAH8pYZBHu42Yxb7cYdkqpOLd7qMew34MByPfIgN4R4+l/bRXK
   cCZmj0HxIrKDwXu4tOEz//jwbYkhWCbQ1MsDsNj3heO4IJyKoyFOjZhHP
   QofBDqmwrozXSt/dUcFEedU1CEH3/meot9OjaoBkN/oN6ePSbK+S59ojU
   w==;
X-CSE-ConnectionGUID: ukRi8UkvTIC30ld9gRIZxQ==
X-CSE-MsgGUID: OxP3RzgoQAapOcZUIVnxxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="28812679"
X-IronPort-AV: E=Sophos;i="6.10,246,1719903600"; 
   d="scan'208";a="28812679"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 02:08:16 -0700
X-CSE-ConnectionGUID: Jl6y8YFKTqe34RQc4cK5hw==
X-CSE-MsgGUID: nRNCRxCUTYumWS8OvtrytA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,246,1719903600"; 
   d="scan'208";a="75327947"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.110])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 02:08:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sat, 21 Sep 2024 12:08:02 +0300 (EEST)
To: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "kbusch@kernel.org" <kbusch@kernel.org>, 
    "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, 
    "mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Lukas Wunner <lukas@wunner.de>
Subject: Re: UAF during boot on MTL based devices with attached dock
In-Reply-To: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
Message-ID: <c01f8f96-7a42-dd70-3a59-915f9f185929@linux.intel.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1056021313-1726841421=:956"
Content-ID: <07eeeed1-b7a5-e0ae-7144-8a64ee0a9c6c@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1056021313-1726841421=:956
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c4950097-bfe5-daac-7a2e-7318bbdd2ac2@linux.intel.com>

On Thu, 19 Sep 2024, Wassenberg, Dennis wrote:

> Hi together,
>=20
> we are facing into issues which seems to be PCI related and asking for yo=
ur estimations.
>=20
> Background:
> We want to boot up an Intel MeteorLake based system (e.g. Lenovo ThinkPad=
 X13 Gen5) with the Lenovo Thunderbolt 4
> universal dock attached during boot. On some devices it is nearly 100% re=
producible that the boot will fail. Other
> systems will never show this issue (e.g. older devices based on RaptorLak=
e or AlderLake platform).
>=20
> We did some debugging on this and came to the conclusion that there is a =
use-after-free in pci_slot_release.
> The Thunderbolt 4 Dock will expose a PCI hierarchy at first and shortly a=
fter that, due to the device is inaccessible,
> it will release the additional buses/ports. This seems to end up in a rac=
e where pci_slot_release accesses &slot->bus
> which as already freed:
>=20
> 0000:00 [root bus]
>       -> 0000:00:07.0 [bridge to 20-49]
>                      -> 0000:20:00.0 [bridge to 21-49]
>                                     -> 0000:21:00.0 [bridge to 22]
>                                        0000:21:01.0 [bridge to 23-2e]
>                                        0000:21:02.0 [bridge to 2f-3a]
>                                        0000:21:03.0 [bridge to 3b-48]
>                                        0000:21:04.0 [bridge to 49]
>          0000:00:07.2 [bridge to 50-79]
>=20
>=20
> We are currently running on kernel 6.8.12. Because this kernel is out of =
support I tried it on 6.11. This kernel shows
> exactly the same issue. I attached two log files:
> dmesg-ramoops-0: Based on kernel 6.11 with added kernel command line opti=
on "slab_debug" in order to force a kernel Oops
> while accessing freed memory.
> dmesg-ramoops-0-pci_dbg: This it like dmesg-ramoops-0 with additional ker=
nel command line option '"dyndbg=3Dfile
> drivers/pci/* +p" ignore_loglevel' in order to give you more insight what=
s happening on the pci bus.
>=20
> I would appreciate any kind of help on this.

Hi,

Thanks for the report.

Unfortunately I don't really know how this is supposed to work (what in=20
which order) but the patch below might help to the immediate issue you=20
hit. I'm a bit skeptical it's the _correct_ solution and I expect there's=
=20
going to be just another spot that blows next.


[PATCH 1/1] PCI: Don't access freed bus in pci_slot_release()

Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/remove.c |  2 ++
 drivers/pci/slot.c   | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 910387e5bdbf..532604dd722c 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -97,6 +97,8 @@ static void pci_remove_bus_device(struct pci_dev *dev)
=20
 =09=09pci_remove_bus(bus);
 =09=09dev->subordinate =3D NULL;
+=09=09if (dev->slot && PCI_SLOT(dev->devfn) =3D=3D dev->slot->number)
+=09=09=09dev->slot->bus =3D NULL;
 =09}
=20
 =09pci_destroy_dev(dev);
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 0f87cade10f7..4bcc16d484dd 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -69,14 +69,16 @@ static void pci_slot_release(struct kobject *kobj)
 =09struct pci_dev *dev;
 =09struct pci_slot *slot =3D to_pci_slot(kobj);
=20
-=09dev_dbg(&slot->bus->dev, "dev %02x, released physical slot %s\n",
-=09=09slot->number, pci_slot_name(slot));
-
-=09down_read(&pci_bus_sem);
-=09list_for_each_entry(dev, &slot->bus->devices, bus_list)
-=09=09if (PCI_SLOT(dev->devfn) =3D=3D slot->number)
-=09=09=09dev->slot =3D NULL;
-=09up_read(&pci_bus_sem);
+=09if (slot->bus) {
+=09=09dev_dbg(&slot->bus->dev, "dev %02x, released physical slot %s\n",
+=09=09=09slot->number, pci_slot_name(slot));
+
+=09=09down_read(&pci_bus_sem);
+=09=09list_for_each_entry(dev, &slot->bus->devices, bus_list)
+=09=09=09if (PCI_SLOT(dev->devfn) =3D=3D slot->number)
+=09=09=09=09dev->slot =3D NULL;
+=09=09up_read(&pci_bus_sem);
+=09}
=20
 =09list_del(&slot->list);
=20
--=20
2.39.2
--8323328-1056021313-1726841421=:956--

