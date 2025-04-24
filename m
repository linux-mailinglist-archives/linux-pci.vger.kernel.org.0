Return-Path: <linux-pci+bounces-26684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29FBA9ADA1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 14:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985AA189E4FA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A1127A126;
	Thu, 24 Apr 2025 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCMQmLAM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8863143C69;
	Thu, 24 Apr 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498265; cv=none; b=YjBMYGC5289TsnGRWz6+4WmTWziBGrVvsuaax4sb5Lldh+5K8jiaNqUOgCkG7H0zshy1ztg90qRz3pSG1FhECR6RJ7fahmYDzmdyPeD4iaL1VM0zt/WJOlRWntJaQ2w/cEmk+ym/iqG5UDzQ5UwsbG1sjJojflw0Xu2otjX8QNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498265; c=relaxed/simple;
	bh=bF3H3hOH42YD0B47rASRpI1vOYUHGGiQQArnmjXuqmI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oOkYu+dHfaVImdMcan2wbDSwcv8OulW430eDwU2k2UEN31s7GTBs4dKYGEjormZvGijrTTpLUv4UeaI7uce/l5Gnsx40Hy7Eg0E8/tYwY0gFeTkgu3OTnuUkfB4Vgu5fF7oSNTzj0Ydkx6IJaxd9Yhdq2g9fGTPsMEvpVqnXgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCMQmLAM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498264; x=1777034264;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=bF3H3hOH42YD0B47rASRpI1vOYUHGGiQQArnmjXuqmI=;
  b=GCMQmLAMJE2zl4rhJrDzu2Hj1fjDH63wxb5dGxE013bMsQMshw5vBrw1
   BBitf1/vVd6oHJpdh3wkth9tlLxIO2B0gRa8zn93+grTqocu0mTV1UoCp
   6uBDfAxKnYVwPK/LmPFYAcfWC8JFKYfhAR8LtTBHpROCvCRRwcUU76NGP
   2A8/yVRYt91BwgtIrMBXcW9DcH03CpxmOPI2H9wh09yFYH2OeIm99ZYiU
   3zAjFIMB/Obw/r8f5EHYYZAJ8GqopjpUt0DSg7VhIuUYS4g+lryTreapx
   Uc9qJ5Ex61cOqsv387XwNBsKu3B64rn2H/3wLXpDU5k7sXp/DNTETHMzd
   Q==;
X-CSE-ConnectionGUID: HJJ5ZZteQM+/S1AB/L6THw==
X-CSE-MsgGUID: CmUIVRf9QVe1yubzizGWAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47222929"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47222929"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:37:43 -0700
X-CSE-ConnectionGUID: mGXoVyZjQX26jryo/cdSMg==
X-CSE-MsgGUID: iYQw3aeCRYyS033If6fEwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="155834211"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:37:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 24 Apr 2025 15:37:38 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2 1/1] PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN
 flag
In-Reply-To: <aAnOOj91-N6rwt2x@wunner.de>
Message-ID: <e639b361-785e-d39b-3c3f-957bcdc54fcd@linux.intel.com>
References: <20250422115548.1483-1-ilpo.jarvinen@linux.intel.com> <aAi734h55l7g6eXH@wunner.de> <87631533-312f-fee9-384e-20a2cc69caf0@linux.intel.com> <aAnOOj91-N6rwt2x@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2068462078-1745492541=:944"
Content-ID: <061b0f46-dd6d-a2a0-2ff6-4d30007ca801@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2068462078-1745492541=:944
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <62369947-c1c3-1f73-2cd4-4aaf0d84bf13@linux.intel.com>

On Thu, 24 Apr 2025, Lukas Wunner wrote:

> On Wed, Apr 23, 2025 at 02:37:11PM +0300, Ilpo J=E4rvinen wrote:
> > On Wed, 23 Apr 2025, Lukas Wunner wrote:
> > > On Tue, Apr 22, 2025 at 02:55:47PM +0300, Ilpo J=E4rvinen wrote:
> > > > +void pcie_reset_lbms(struct pci_dev *port)
> > > >  {
> > > > -=09struct pcie_bwctrl_data *data;
> > > > -
> > > > -=09guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
> > > > -=09data =3D port->link_bwctrl;
> > > > -=09if (data)
> > > > -=09=09atomic_set(&data->lbms_count, 0);
> > > > -=09else
> > > > -=09=09pcie_capability_write_word(port, PCI_EXP_LNKSTA,
> > > > -=09=09=09=09=09   PCI_EXP_LNKSTA_LBMS);
> > > > +=09clear_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
> > > > +=09pcie_capability_write_word(port, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA=
_LBMS);
> > > >  }
> > >=20
> > > Hm, previously the LBMS bit was only cleared in the Link Status regis=
ter
> > > if the bandwith controller hadn't probed yet.  Now it's cleared
> > > unconditionally.  I'm wondering if this changes the logic somehow?
> >=20
> > Hmm, that's a good question and I hadn't thought all the implications.
> > I suppose leaving if (!port->link_bwctrl) there would retain the existi=
ng=20
> > behavior better allowing bwctrl to pick the link speed changes more=20
> > reliably.
>=20
> I think the only potential issue with clearing the LBMS bit in the regist=
er
> is that the bandwidth controller's irq handler won't see the bit and may
> return with IRQ_NONE.
>=20
> However, looking at the callers of pcie_reset_lbms(), that doesn't seem
> to be a real issue.  There are only two of them:
>=20
> - pcie_retrain_link() calls the function after the link was retrained.
>   I guess the LBMS bit in the register may be set as a side-effect of
>   the link retraining?

Retraining does set LBMS, whether the speed was same before doesn't=20
matter. I think it's because LTSSM-wise, retraining transitions through=20
Recovery.
=20
(I don't know why, but in most tests I've done LBMS is actually asserted=20
not only once but twice with only one Link Retraining event).

>   The only concern here is whether the cached
>   link speed is updated.  pcie_bwctrl_change_speed() does call
>   pcie_update_link_speed() after calling pcie_retrain_link(), so that
>   looks fine.  But there's a second caller of pcie_retrain_link():
>   pcie_aspm_configure_common_clock().  It doesn't update the cached
>   link speed after calling pcie_retrain_link().  Not sure if this can
>   lead to a change in link speed and therefore the cached link speed
>   should be updated?  The Target Link Speed isn't changed, but maybe
>   the link fails to retrain to the same speed for electrical reasons?

I've never seen that to happen but it would seem odd if that is forbidden=
=20
(as the alternative is probably that the link remains down).

Perhaps pcie_reset_lbms() should just call pcie_update_link_speed() as the=
=20
last step, then the irq handler returning IRQ_NONE doesn't matter.

> - pciehp's remove_board() calls the function after bringing down the slot
>   to avoid a stale PCI_LINK_LBMS_SEEN flag.  No real harm in clearing the
>   bit in the register at this point I guess.  But I do wonder, is the lin=
k
>   speed updated somewhere when a new board is added?  The replacement
>   device may not support the same speeds as the previous device.

The supported speeds are always recalculated using dev->supported_speeds.=
=20
A new board implies a new pci_dev structure with newly read supported=20
speeds. Also, bringing the link up with the replacement device will also=20
trigger LBMS so the new Link Speed should be picked up by that.

Racing LBMS reset from remove_board() with LBMS due to the replacement=20
board shouldn't result in stale Link Speed because of:

board_added()
  pciehp_check_link_status()
    __pcie_update_link_speed()

> > Given this flag is only for the purposes of the quirk, it seems very mu=
ch=20
> > out of proportions.
>=20
> Yes, let's try to minimize the amount of locking, flags and code to suppo=
rt
> the quirk.  Keep it as simple as possible.  So in that sense, the solutio=
n
> you've chosen is probably fine.
>=20
>=20
> > > >  static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
> > > >  {
> > > > -=09unsigned long count;
> > > > -=09int ret;
> > > > -
> > > > -=09ret =3D pcie_lbms_count(dev, &count);
> > > > -=09if (ret < 0)
> > > > -=09=09return lnksta & PCI_EXP_LNKSTA_LBMS;
> > > > +=09if (test_bit(PCI_LINK_LBMS_SEEN, &dev->priv_flags))
> > > > +=09=09return true;
> > > > =20
> > > > -=09return count > 0;
> > > > +=09return lnksta & PCI_EXP_LNKSTA_LBMS;
> > > >  }
> > >=20
> > > Another small logic change here:  Previously pcie_lbms_count()
> > > returned a negative value if the bandwidth controller hadn't
> > > probed yet or wasn't compiled into the kernel.
> > > Only in those two cases was the LBMS flag in the lnksta variable=20
> > > returned.
> > >=20
> > > Now the LBMS flag is also returned if the bandwidth controller
> > > is compiled into the kernel and has probed, but its irq handler
> > > hasn't recorded a seen LBMS bit yet.
> > >=20
> > > I'm guessing this can happen if the quirk races with the irq
> > > handler and wins the race, so this safety net is needed?
> >=20
> > The main reason why this check is here is for the boot when bwctrl is n=
ot=20
> > yet probed when the quirk runs. But the check just seems harmless, or=
=20
> > even somewhat useful, in the case when bwctrl has already probed. LBMS=
=20
> > being asserted should result in PCI_LINK_LBMS_SEEN even if the irq=20
> > handler has not yet done its job to transfer it into priv_flags.
>=20
> Okay I'm convinced that the logic change in pcie_lbms_seen() is fine.
>=20
> Thanks,
>=20
> Lukas
>=20

--=20
 i.
--8323328-2068462078-1745492541=:944--

