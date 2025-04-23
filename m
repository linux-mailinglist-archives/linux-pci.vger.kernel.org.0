Return-Path: <linux-pci+bounces-26529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB7FA988AA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 13:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A703BE7EE
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE981269D06;
	Wed, 23 Apr 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KefzT5YJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD95FC08;
	Wed, 23 Apr 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408238; cv=none; b=A9plolTa6fCJiKJ5ckqnoWlvCvRHDfPGhUww+YH+ycxC2XAlxDTM3JBa6TbOnQNszgwh7u/I4LO2UHvDdT6H/6JBNdjE4yZmcSj/BXby7HzhGtav9IQcL5MCcp+gDHQbGNn4BbMJAMJp0E25UfeL3P34cVClDTohqL0hHZQTcwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408238; c=relaxed/simple;
	bh=3pJoG+d0HhWoOv/Vb4FGPIm7v1quxhGiCBygqX42Q1k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f/azfOTjpIx0zkd1Ym3h6AmbH6O6JQuOTvW8woPumXEuVvi+y5Zj/dUPPuYjfzd3B656o6+lr0YFOq67E2mygGJNxmIz/dfres2kjrB1ob9O5HLMBHeqRJ/KmU2WoEAqnHEHUuBVNTGEvhdUpAuEZI3Dk2/rZ2o500OVJSf5Zw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KefzT5YJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745408237; x=1776944237;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3pJoG+d0HhWoOv/Vb4FGPIm7v1quxhGiCBygqX42Q1k=;
  b=KefzT5YJy8F4rWfLKDanbcVPj4h1IneKlwGRLy04NptCHUDzR+F+0+Fw
   L91MALsuB4b/ghwEZdMRBxJnJ+RI42DJKmz86pLLGq2h9z7WbadWT419b
   +0fX+m0bqwZXq9PYIik7dHNRxLQ8qm1KB1k7O+D8paPrQzRAmNKomRBjv
   hKRCwAg1w/ipoB9JDyk8nDwvfPz2IwohTgdyxJAbpr5ig+HVFlzPSa2fu
   qAaDW0J3kp2p39SIorNSKEOiRYYWz4c9LkKwWEx1MWleuXquKM8Wweato
   xN9tyIaVq0+LX9d5CddpctPnDEkzSVw72qdvlnzZdmMY++ZG6dwG2UMex
   w==;
X-CSE-ConnectionGUID: HqROGo77T8CnmpAZBP5QGA==
X-CSE-MsgGUID: ukiphQd7SC+pJ4ckwfHAQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="58368794"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="58368794"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 04:37:16 -0700
X-CSE-ConnectionGUID: noNNdf+cRe+BGXl5d2u+xA==
X-CSE-MsgGUID: Pb5RVM01SwqE7BmDKL6/+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132828354"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.36])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 04:37:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 23 Apr 2025 14:37:11 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2 1/1] PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN
 flag
In-Reply-To: <aAi734h55l7g6eXH@wunner.de>
Message-ID: <87631533-312f-fee9-384e-20a2cc69caf0@linux.intel.com>
References: <20250422115548.1483-1-ilpo.jarvinen@linux.intel.com> <aAi734h55l7g6eXH@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1399898896-1745408231=:1158"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1399898896-1745408231=:1158
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 Apr 2025, Lukas Wunner wrote:

> [cc +=3D Maciej, start of thread is here:
> https://lore.kernel.org/r/20250422115548.1483-1-ilpo.jarvinen@linux.intel=
=2Ecom/
> ]
>=20
> On Tue, Apr 22, 2025 at 02:55:47PM +0300, Ilpo J=E4rvinen wrote:
> > +void pcie_reset_lbms(struct pci_dev *port)
> >  {
> > -=09struct pcie_bwctrl_data *data;
> > -
> > -=09guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
> > -=09data =3D port->link_bwctrl;
> > -=09if (data)
> > -=09=09atomic_set(&data->lbms_count, 0);
> > -=09else
> > -=09=09pcie_capability_write_word(port, PCI_EXP_LNKSTA,
> > -=09=09=09=09=09   PCI_EXP_LNKSTA_LBMS);
> > +=09clear_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
> > +=09pcie_capability_write_word(port, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBM=
S);
> >  }
>=20
> Hm, previously the LBMS bit was only cleared in the Link Status register
> if the bandwith controller hadn't probed yet.  Now it's cleared
> unconditionally.  I'm wondering if this changes the logic somehow?

Hmm, that's a good question and I hadn't thought all the implications.
I suppose leaving if (!port->link_bwctrl) there would retain the existing=
=20
behavior better allowing bwctrl to pick the link speed changes more=20
reliably.

However, I'm not entirely sure if the old code was a good idea either as=20
it assumed the irq handler had read LBMS by the time lbms_count is reset.
Solving that would seemingly require locking to not race with remove,=20
which just got removed (LOL) :-(.

Given this flag is only for the purposes of the quirk, it seems very much=
=20
out of proportions. The quirk seeing extra LBMS doesn't seem to have a big=
=20
practical impact. At worst case, the link speed becomes gen1 if the quirk=
=20
fails to restore the original link speed for some reason (which, IIRC, it=
=20
didn't yet attempt do when the original LBMS reset code was added).

So I'd prefer going with the if (!port->link_bwctrl) solution.

> >  static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
> >  {
> > -=09unsigned long count;
> > -=09int ret;
> > -
> > -=09ret =3D pcie_lbms_count(dev, &count);
> > -=09if (ret < 0)
> > -=09=09return lnksta & PCI_EXP_LNKSTA_LBMS;
> > +=09if (test_bit(PCI_LINK_LBMS_SEEN, &dev->priv_flags))
> > +=09=09return true;
> > =20
> > -=09return count > 0;
> > +=09return lnksta & PCI_EXP_LNKSTA_LBMS;
> >  }
>=20
> Another small logic change here:  Previously pcie_lbms_count()
> returned a negative value if the bandwidth controller hadn't
> probed yet or wasn't compiled into the kernel.

One cannot disable bwctrl, it always comes on with PCIe.

> Only in those two cases was the LBMS flag in the lnksta variable=20
> returned.
>=20
> Now the LBMS flag is also returned if the bandwidth controller
> is compiled into the kernel and has probed, but its irq handler
> hasn't recorded a seen LBMS bit yet.
>=20
> I'm guessing this can happen if the quirk races with the irq
> handler and wins the race, so this safety net is needed?

The main reason why this check is here is for the boot when bwctrl is not=
=20
yet probed when the quirk runs. But the check just seems harmless, or=20
even somewhat useful, in the case when bwctrl has already probed. LBMS=20
being asserted should result in PCI_LINK_LBMS_SEEN even if the irq=20
handler has not yet done its job to transfer it into priv_flags.

> This is quite subtle so I thought I'd ask.

It's good that you asked! :-)

> The patch otherwise
> LGTM, so assuming the two subtle logic changes above are intentional
> and can be explained, this is
>=20
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>=20
> Thanks,
>=20
> Lukas
>=20

--=20
 i.

--8323328-1399898896-1745408231=:1158--

