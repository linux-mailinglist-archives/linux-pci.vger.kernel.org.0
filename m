Return-Path: <linux-pci+bounces-14775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15AC9A2371
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EE91F24490
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926011DE2DE;
	Thu, 17 Oct 2024 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRC1bi0f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F21DE3DD;
	Thu, 17 Oct 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171015; cv=none; b=CBYjTEtB+OL4+I1jcKJ25SZfoukhIvG6/vCbOT3nAG8VbsUxdJfQIIjtTf2bFnOJzv077svD3vciqGuw8XeFclpX7YYWAPAEI50GwEO4f5PXzwR1cAhesXCSNwUfeydHZaiSXV9+4bcHhld4UdTmvupnjqPuYvVSwZ2/SQ+9tbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171015; c=relaxed/simple;
	bh=8/VHn17r/Dn2bT1CmRUWZnXjoztZOFZAY1vbgtcprKI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eutp5cg+0vn5tHdEnCtgmKEOJGdROjIQb5QId6nZsCZen7phEJcW+6r31wUiyRc9aEi2tgwsITBqeL8qp3uRQdwSsiLmzoIjiPo4Zvo/rcAOzBg2K4RbjZGXFnYDyYXCSPpopQE6P+jU3RsYnpCRQVxo05+5nC0Izm56g/FALiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRC1bi0f; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729171012; x=1760707012;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=8/VHn17r/Dn2bT1CmRUWZnXjoztZOFZAY1vbgtcprKI=;
  b=FRC1bi0fzV0oQvvs2xIfyLIH8x4TRGi3V9Roid7AYe0YPdrnJFo13Nsx
   bpvTHrhb/7eL0RUu3xzlfXEbToDVp1LkJgfJuUwmwWUn8ZvPRz8eQoKZH
   2t+V8dkoXelIDxSXH6ATjQNbSqyDST6Umocu1sRCCO3BnloUKcDltjLES
   9U4p23PDACD6Ku/1T+CCV3AJTchZUKyHSyyqkmM6QfJDCnWgMBc45yMYA
   51KBmJojrc6oaztd41LO9Vni0avbf9VPbgBFEQckLMifoesegaMRBI1sn
   EuTalWrUqBc0u8fpiW2ZRwKyVv47loGHbk3n1EmGoGLTlomKKOeRlem76
   w==;
X-CSE-ConnectionGUID: KpaDdSdnT0ebnJFj5P+9sQ==
X-CSE-MsgGUID: +9X+f2wFQs+BOD3y7JluKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="39243615"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="39243615"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:16:51 -0700
X-CSE-ConnectionGUID: R6uK7DS/RgyKD2r3Cn1WeA==
X-CSE-MsgGUID: gTkdf9heQySJc+/lhrck1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78582011"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:16:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 17 Oct 2024 16:16:43 +0300 (EEST)
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 6/8] PCI/bwctrl: Add API to set PCIe Link Speed
In-Reply-To: <20241017120211.00005b1e@Huawei.com>
Message-ID: <79ada41b-5d10-e063-1d15-3ed5e78f3720@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com> <20241009095223.7093-7-ilpo.jarvinen@linux.intel.com> <20241017120211.00005b1e@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-761507247-1729163516=:929"
Content-ID: <c0f80b6b-b7f7-c65e-f330-85ac2a2d4041@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-761507247-1729163516=:929
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <ef38b944-4235-46bb-c7d7-058c0c5e58cc@linux.intel.com>

On Thu, 17 Oct 2024, Jonathan Cameron wrote:

> On Wed,  9 Oct 2024 12:52:21 +0300
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > Currently, PCIe Link Speeds are adjusted by custom code rather than in
> > a common function provided in PCI core. PCIe bandwidth controller
> > (bwctrl) introduces an in-kernel API to set PCIe Link Speed.
> >=20
> > Convert Target Speed quirk to use the new API. The Target Speed quirk
> > runs very early when bwctrl is not yet probed for a Port and can also
> > run later when bwctrl is already setup for the Port, which requires the
> > per port mutex (set_speed_mutex) to be only taken if the bwctrl setup
> > is already complete.
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
>=20
> Trivial stuff inline.  The mutex_destroy discussion is a just a consisten=
cy
> thing given that call is rarely bothered with but here it might help with
> debug.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Jonathan
>=20
> > ---
> >  drivers/pci/pci.h         |  20 +++++
> >  drivers/pci/pcie/bwctrl.c | 161 +++++++++++++++++++++++++++++++++++++-
> >  drivers/pci/quirks.c      |  17 +---
> >  include/linux/pci.h       |  10 +++
> >  4 files changed, 193 insertions(+), 15 deletions(-)
>=20
>=20
> > diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> > index 1b11b5da79d4..1d3680ea8e06 100644
> > --- a/drivers/pci/pcie/bwctrl.c
> > +++ b/drivers/pci/pcie/bwctrl.c
> > @@ -7,6 +7,11 @@
>=20
> >  static void pcie_bwnotif_enable(struct pcie_device *srv)
> >  {
> >  =09struct pcie_bwctrl_data *data =3D get_service_data(srv);
> > @@ -135,6 +288,7 @@ static int pcie_bwnotif_probe(struct pcie_device *s=
rv)
> >  =09if (!data)
> >  =09=09return -ENOMEM;
> > =20
> > +=09mutex_init(&data->set_speed_mutex);
> >  =09set_service_data(srv, data);
> > =20
> >  =09ret =3D request_threaded_irq(srv->irq, NULL, pcie_bwnotif_irq_threa=
d,
> > @@ -142,8 +296,10 @@ static int pcie_bwnotif_probe(struct pcie_device *=
srv)
> >  =09if (ret)
> >  =09=09return ret;
> > =20
> > -=09port->link_bwctrl =3D no_free_ptr(data);
> > -=09pcie_bwnotif_enable(srv);
> > +=09scoped_guard(rwsem_write, &pcie_bwctrl_remove_rwsem) {
>=20
> Calling it remove_rwsem and using it to protect against not yet
> present seems odd. Maybe rename, pcie_bwctrl_bound_rswem or something lik=
e that?

Okay but there's one related issue I need to address:

I came across recursive locking splat from pcie_bwctrl_remove_rwsem
(seems I had lockdep off for some odd reason in my config so it didn't
trigger during my testing until now). The splat is because of:

pcie_set_target_speed()
   scoped_guard(rwsem_read, &pcie_bwctrl_remove_rwsem) =20
   -> pcie_bwctrl_change_speed
      -> pcie_retrain_link()
         -> pcie_reset_lbms_count()
            guard(rwsem_read)(&pcie_bwctrl_remove_rwsem);

I wouldn't want to special case pcie_retrain_link() just for BW=20
control's sake, I plan to solve that by splitting pcie_bwctrl_remove_rwsem=
=20
to have one for LBMS API and another for set speed API so split it into:

- pcie_bwctrl_setspeed_rwsem
- pcie_bwctrl_lbms_rwsem

It requires taking both in .probe and .remove which is not as elegant I'd=
=20
want but definitely seems more elegant compared with differentiating=20
pcie_retrain_link().

If you, for some reason would instead prefer I differentiated=20
pcie_retrain_link() for cases when holding pcie_bwctrl_remove_rwsem=20
already (or pcie_bwctrl_bound_rwsem as suggested by you), please let me=20
know.

> > +=09=09port->link_bwctrl =3D no_free_ptr(data);
> > +=09=09pcie_bwnotif_enable(srv);
> > +=09}
> > =20
> >  =09pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
> > =20
> > @@ -159,6 +315,7 @@ static void pcie_bwnotif_remove(struct pcie_device =
*srv)
> >  =09=09srv->port->link_bwctrl =3D NULL;
> > =20
> >  =09free_irq(srv->irq, srv);
> > +=09mutex_destroy(&data->set_speed_mutex);
>
> Probably not worth doing.  Also you don't do error handling for this abov=
e.

I'm not sure what error handling you're referring to?

> Ideal is use devm_ for data and then devm_mutex_init()

I've now converted alloc, irq, and mutex to devm. I had them at one point=
=20
but then Lukas said it's the wrong direction consider what lies in future=
=20
but since the future seeming has now changed I've no problem of making our
lives easier with devm. :-)

I also got rid of the service data use for your convinience.

--=20
 i.
--8323328-761507247-1729163516=:929--

