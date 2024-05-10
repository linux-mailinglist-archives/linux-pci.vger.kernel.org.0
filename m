Return-Path: <linux-pci+bounces-7341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437F68C222F
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE41428231C
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9F83A0A;
	Fri, 10 May 2024 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llOSO/aD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F355C3B;
	Fri, 10 May 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337180; cv=none; b=YKUGMbwx4KpwysjyZhVJQ1kW3+DutzPUhU/uuOWdBRT+5gdhXq3/0iG9HqPSAk9vTIr5sGkgMr1UQoBlacJmgNC9M1tvdqvmTaeic//GffeYry1TVllBYmdx51bFgzTiqtAUQmcoabz/4xmyuR1fbkbb8Jqocq+E2M/0CVp5DG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337180; c=relaxed/simple;
	bh=AEKgswUJANlzIvAmpFnfIfEK2+gPL0RIE+Jn9iTpIWw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RxQVc8HThEjIdbbGz2dC/kFSC7FJTsFvNVymJEI9aNfYjhOyrz6PsKIR6bnS208g5bELgPz+1knc8yad1odCv58BwMlkb5fOoTApwdZHwGlFeec/KLQaZI4BIm7JUB6jHzSZ0Z5V6w8Lg4UboekauVKWjGJeHvYSVwfc4JZah0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llOSO/aD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715337179; x=1746873179;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AEKgswUJANlzIvAmpFnfIfEK2+gPL0RIE+Jn9iTpIWw=;
  b=llOSO/aDsDbPuuvtCw44TfKOIGCvSWBfZ0jd6wZiLFdbqC5+6g6Vk5dI
   uKcmkmwKitNChhlb1novHt4iCZBh+TV05VydVSSVrIaaI3KS0IyD12NmE
   URfugDUhb/H291931N0ufwbHXt6tOLliEGuAwLxAUObhPbGtOsviOTTdP
   kDcvHpTeJy8+C4j2zLhCasFxlHUZGcJF8Yw8DQHciTc2P6NqaMFlLZWoG
   pn8MJq5wswaQA82Ho6SVqpCvIXrmY7iGZ5Yew7SZwfQ45OU53KFuOqPSW
   w5RTCFsbcxkyZu1IbWdzhTXIXiq+QBAIFmzNUM3g4GC6IuvsjE2qoR/+c
   g==;
X-CSE-ConnectionGUID: Yu8hAiUkQSyrGlQiuFuRoA==
X-CSE-MsgGUID: bd56JdbhSRu3vH3AYjBPnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11475005"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11475005"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:32:58 -0700
X-CSE-ConnectionGUID: 0YRyAAFDQtKAlMMNsYQofg==
X-CSE-MsgGUID: xCb6XGQ5SMCUaX83IQpJ2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34348159"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:32:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 May 2024 13:32:48 +0300 (EEST)
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 6/8] PCI/bwctrl: Add API to set PCIe Link Speed
In-Reply-To: <20240509125358.00004c55@Huawei.com>
Message-ID: <3555fc97-baec-282f-0a93-4a22f67254e9@linux.intel.com>
References: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com> <20240508134744.52134-7-ilpo.jarvinen@linux.intel.com> <20240509125358.00004c55@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-643942565-1715337168=:1562"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-643942565-1715337168=:1562
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 May 2024, Jonathan Cameron wrote:

> On Wed,  8 May 2024 16:47:42 +0300
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > Currently, PCIe Link Speeds are adjusted by custom code rather than in
> > a common function provided in PCI core. PCIe bandwidth controller
> > (bwctrl) introduces an in-kernel API to set PCIe Link Speed. Convert
> > Target Speed quirk to use the new API.
> >=20
> > The new API is also intended to be used in an upcoming commit that adds
> > a thermal cooling device to throttle PCIe bandwidth when thermal
> > thresholds are reached.
> >=20
> > The PCIe bandwidth control procedure is as follows. The highest speed
> > supported by the Port and the PCIe device which is not higher than the
> > requested speed is selected and written into the Target Link Speed in
> > the Link Control 2 Register. Then bandwidth controller retrains the
> > PCIe Link.
> >=20
> > Bandwidth Notifications enable the cur_bus_speed in the struct pci_bus
> > to keep track PCIe Link Speed changes. While Bandwidth Notifications
> > should also be generated when bandwidth controller alters the PCIe Link
> > Speed, a few platforms do not deliver LMBS interrupt after Link
> > Training as expected. Thus, after changing the Link Speed, bandwidth
> > controller makes additional read for the Link Status Register to ensure
> > cur_bus_speed is consistent with the new PCIe Link Speed.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/pci.h         |  13 ++++
> >  drivers/pci/pcie/Makefile |   2 +-
> >  drivers/pci/pcie/bwctrl.c | 147 ++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/quirks.c      |  12 +---
> >  include/linux/pci.h       |   3 +
> >  5 files changed, 166 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 416540baf27b..324899fbad0a 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -270,6 +270,19 @@ void pci_disable_bridge_window(struct pci_dev *dev=
);
> >  struct pci_bus *pci_bus_get(struct pci_bus *bus);
> >  void pci_bus_put(struct pci_bus *bus);
> > =20
> > +#define PCIE_LNKCAP_SLS2SPEED(lnkcap)=09=09=09=09=09\
> > +({=09=09=09=09=09=09=09=09=09\
> > +=09u32 _lnkcap =3D (lnkcap) & PCI_EXP_LNKCAP_SLS;=09=09=09\
>=20
> Why the inconsistency wrt to PCIE_LNKCAP2_SLS2SPEED which doesn't bother =
with
> this initial mask. It's not needed afterall as the bits checked are all i=
n the
> mask anyway?
>=20
> I don't really mind which form but they should look the same.

I made it the same as PCIE_LNKCAP2_SLS2SPEED() as it's like you say,=20
it checks explicit bits so the other bits don't matter.

--=20
 i.

> > +=09=09=09=09=09=09=09=09=09\
> > +=09(_lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :=09\
> > +=09 _lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :=09\
> > +=09 _lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :=09\
> > +=09 _lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :=09\
> > +=09 _lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :=09\
> > +=09 _lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :=09\
> > +=09 PCI_SPEED_UNKNOWN);=09=09=09=09=09=09\
> > +})
> > +
>=20
>=20
>=20

--8323328-643942565-1715337168=:1562--

