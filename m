Return-Path: <linux-pci+bounces-23735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8769A60FB8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 12:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404FE3BD2BC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31971E5213;
	Fri, 14 Mar 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ysc+sbD1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B91FDE01;
	Fri, 14 Mar 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951096; cv=none; b=HWkhyE112N3jl5GparDOmfffOfjIJLb/iSOpJoNFQTrBTVH4FRLg2CJutIISY8P8hCy80ZVs0tI7RP9d/qzTUAVnXeE7YZ0/sEeWI1MhGzYqD4RN3/8ywKH8M7r82DGbET7oVC8a1u53CtQQGqR8Pudf4z4Y1Lx6jOwWVZhaWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951096; c=relaxed/simple;
	bh=RXdbAWa7Ikw5X3/Ts0WK5E/8AFDYnH9rJFvIdp3Pwik=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dJPHd0DnG0fR3Ar1R5kp1mxIwiM9Ugj6VwTcsx8mw3jXN2eRbFHgxoqSlM6JzwpThJ+8QQR9y2X4EAoE38yuqT4Sppq2s1aOU+1neMOcjln3y2Kodp/yCEf6kmDKxhNByabAuUHaI5lW0icwpCvzXwZ5A4cCLX4i6AVsohqrh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ysc+sbD1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741951094; x=1773487094;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RXdbAWa7Ikw5X3/Ts0WK5E/8AFDYnH9rJFvIdp3Pwik=;
  b=Ysc+sbD1IgSULw7jcEw5XmovyQj6yMCnqUfHrwzAzX3V7xaj0yfamtvG
   6fgWb0eUkQNCMu4FHE9Xpm1hAQh5BPdpgBvj62XJlBJDgyllBwR7fSB7K
   PzIZhIA/rOsVR9abQ71syzyV9HS7erayybNImH3gLnL4jm7SKdaBYsrP6
   llpsLIpWpzKt4urDJp5pD0iQM3cPMJVy6ywv6PPT1/8PO0nN7OVTXbYa0
   MhU+/+rN9OHCNPQFREtlm/PVNNc8xR1iKSFz9A5abnrwdixG89z4+1kdw
   JduZhiMUw++/DYB1/eNo5iEN6w71KPVUrnN+0B9tEoEXPRnae0TaowfcF
   A==;
X-CSE-ConnectionGUID: bs4waCvaT9+oZrAshyp6wQ==
X-CSE-MsgGUID: tvP50e44SlGUQsmRnFIUvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46746601"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="46746601"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:18:14 -0700
X-CSE-ConnectionGUID: DmtXz1vXQqyESkL02C15IQ==
X-CSE-MsgGUID: a4zRJQCkRbKBJAD9Y9halQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121242420"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:18:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Mar 2025 13:18:07 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Guenter Roeck <groeck@juniper.net>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    Rajat Jain <rajatxjain@gmail.com>, 
    Joel Mathew Thomas <proxy0@tutamail.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/4] PCI/hotplug: reset_lock is not required synchronizing
 with irq thread
In-Reply-To: <Z9Ppr63yDUhOF1Xo@wunner.de>
Message-ID: <c4023681-3899-ad3b-82d8-53cc42312970@linux.intel.com>
References: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com> <20250313142333.5792-4-ilpo.jarvinen@linux.intel.com> <Z9Ppr63yDUhOF1Xo@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1216766000-1741951087=:934"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1216766000-1741951087=:934
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 14 Mar 2025, Lukas Wunner wrote:

> On Thu, Mar 13, 2025 at 04:23:32PM +0200, Ilpo J=E4rvinen wrote:
> > Disabling HPIE (Hot-Plug Interrupt Enable) and synchronizing with irq
> > handling in pciehp_reset_slot() is enough to ensure no pending events
> > are processed during the slot reset. Thus, there is no need to take
> > reset_lock in the IRQ thread.
> [...]
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -748,12 +748,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_=
id)
> >  =09 * Disable requests have higher priority than Presence Detect Chang=
ed
> >  =09 * or Data Link Layer State Changed events.
> >  =09 */
> > -=09down_read_nested(&ctrl->reset_lock, ctrl->depth);
> >  =09if (events & DISABLE_SLOT)
> >  =09=09pciehp_handle_disable_request(ctrl);
> >  =09else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
> >  =09=09pciehp_handle_presence_or_link_change(ctrl, events);
> > -=09up_read(&ctrl->reset_lock);
> > =20
> >  =09ret =3D IRQ_HANDLED;
> >  out:
>=20
> The release and re-acquisition of reset_lock in
> pciehp_configure_device() and pciehp_unconfigure_device()
> needs to be removed as well if the above hunk is applied.

Ah, right. I also now removed reset_lock from=20
pciehp_ignore_dpc_link_change() that is directly called from pciehp_ist().

This leaves reset_lock only into pciehp_free_irq(), pciehp_reset_slot(),=20
and pciehp_check_presence(). It seems to me pciehp_check_presence()=20
requires keeping reset_lock as is. The former two could have synchronized=
=20
with a mutex and shorter critical sections in pciehp_reset_slot() but it=20
doesn't look worth the effort (IMO) to divide reset_lock into two to=20
realize that.

> But please wait a little while before respinning so that I can
> think through the whole series.

Sure, take your time. :-)

--=20
 i.

--8323328-1216766000-1741951087=:934--

