Return-Path: <linux-pci+bounces-16968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1609CFF47
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36CF1F2445F
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6242B9C6;
	Sat, 16 Nov 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiFfL00p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05812940D;
	Sat, 16 Nov 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768059; cv=none; b=Wfh57OB+aAAqx+r0Lv0zTPCbs0CxkSzXuLn8aVzuI9qRoPhatIwG3cqVlniTJ/Ot6O6knoYE5w/d/U9LDPbJyTVh8ulIWU6schxpjX9j/a1ih2mydyMhOZNZx89eDLCpBX9dx9XiQqIlzdkZFUtHgyOgjmBM+YNtqZnvSSSyrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768059; c=relaxed/simple;
	bh=O9hmtxuZAwYgYSd+bW6jcmwA71WFHHSz0MRm6IsL8KM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AGftS0+wUpooW6STMtl3b+pboOCnSZIt6ZdRqN6UrvqxS7CLZ5UbPe8YCYetsvOJS0/8c8hVUKfCWm4O/GL7sDtAAappJB1CJ/EhvFPjrCVVb5hF102XhuHPzKIMiU5E7ESqY7MAkR2V3XgcOhMU6/tMRHlmFBFSTylVXI8WxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiFfL00p; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731768058; x=1763304058;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O9hmtxuZAwYgYSd+bW6jcmwA71WFHHSz0MRm6IsL8KM=;
  b=DiFfL00p2LV0FPkc/9Jqnl/ts1JTgrcekmTcGCFa9a2W0wi72Mkli0a0
   xiV+7rFbiQvXWAEfW3+MN4jDV42fpnJZwV3Na/OWY0/bwjFwAs6tK13Lj
   o42YocrfxGxHGnCdLNuXFNgEAknjWcxQTebYpIsKyYGWvf0uI+Gsyr6DE
   dAPYT7TcRQmqI2RcQ8KUz+EgtPciHgO9xeZGa2etDzwbRbK0fJf2J2A6M
   L3Wz3I/vCx8wjdB4sEbOyWPnA+IyHP6W0sT1hibNHP+GSEX3zFp9jFLUN
   WCNwzmthvZKg+oP3Uzis/ARz3DWhe/g4INS9vQgtS8D/xqRcbnzxzN9FO
   Q==;
X-CSE-ConnectionGUID: 0swqIwO0SBuBdrX313cOgQ==
X-CSE-MsgGUID: k0X77+eSRfqwZo61ejcw5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31520832"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="31520832"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 06:40:57 -0800
X-CSE-ConnectionGUID: P3Dsm0r/QQ6IIFO+0QYJLA==
X-CSE-MsgGUID: hV5n2tGpTUmHGLHVpMYTiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="88926974"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.42])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 06:40:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sat, 16 Nov 2024 16:40:51 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Stefan Wahren <wahrenst@gmx.net>, 
    Florian Fainelli <florian.fainelli@broadcom.com>, 
    Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove IRQF_ONESHOT and handle hardirqs
 instead
In-Reply-To: <20241115210217.GA2057245@bhelgaas>
Message-ID: <ec7f9169-26dc-cc0e-e321-b66ca9d3f40e@linux.intel.com>
References: <20241115210217.GA2057245@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1380601243-1731768051=:935"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1380601243-1731768051=:935
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 15 Nov 2024, Bjorn Helgaas wrote:

> On Fri, Nov 15, 2024 at 06:57:17PM +0200, Ilpo J=C3=A4rvinen wrote:
> > bwctrl cannot use IRQF_ONESHOT because it shares interrupt with other
> > service drivers that are not using IRQF_ONESHOT nor compatible with it.
> >=20
> > Remove IRQF_ONESHOT from bwctrl and convert the irq thread to hardirq
> > handler. Rename the handler to pcie_bwnotif_irq() to indicate its new
> > purpose.
> >=20
> > The IRQ handler is simple enough to not require not require other
> > changes.
> >=20
> > Fixes: 058a4cb11620 ("PCI/bwctrl: Re-add BW notification portdrv as PCI=
e BW controller")
> > Reported-by: Stefan Wahren <wahrenst@gmx.net>
> > Link: https://lore.kernel.org/linux-pci/dcd660fd-a265-4f47-8696-776a85e=
097a0@gmx.net/
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Squashed into 058a4cb11620, thanks!
>=20
> Also added your tested-by, Stefan, thanks very much for doing that!

Hi Bjorn,

You might want to also remove "3) ..." part from the commit message as it=
=20
still refers to threaded IRQ and IRQF_ONESHOT so it won't confuse anybody=
=20
when looking at this years from now :-).

--=20
 i.

> > ---
> >  drivers/pci/pcie/bwctrl.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> > index ff5d12e01f9c..a6c65bbe3735 100644
> > --- a/drivers/pci/pcie/bwctrl.c
> > +++ b/drivers/pci/pcie/bwctrl.c
> > @@ -230,7 +230,7 @@ static void pcie_bwnotif_disable(struct pci_dev *po=
rt)
> >  =09=09=09=09   PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> >  }
> > =20
> > -static irqreturn_t pcie_bwnotif_irq_thread(int irq, void *context)
> > +static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
> >  {
> >  =09struct pcie_device *srv =3D context;
> >  =09struct pcie_bwctrl_data *data =3D srv->port->link_bwctrl;
> > @@ -302,10 +302,8 @@ static int pcie_bwnotif_probe(struct pcie_device *=
srv)
> >  =09if (ret)
> >  =09=09return ret;
> > =20
> > -=09ret =3D devm_request_threaded_irq(&srv->device, srv->irq, NULL,
> > -=09=09=09=09=09pcie_bwnotif_irq_thread,
> > -=09=09=09=09=09IRQF_SHARED | IRQF_ONESHOT,
> > -=09=09=09=09=09"PCIe bwctrl", srv);
> > +=09ret =3D devm_request_irq(&srv->device, srv->irq, pcie_bwnotif_irq,
> > +=09=09=09       IRQF_SHARED, "PCIe bwctrl", srv);
> >  =09if (ret)
> >  =09=09return ret;
> > =20
> > --=20
> > 2.39.5
> >=20
>=20
--8323328-1380601243-1731768051=:935--

