Return-Path: <linux-pci+bounces-16892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4409CF176
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED072934B2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2A1BCA19;
	Fri, 15 Nov 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cf10LL0X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF5126C10;
	Fri, 15 Nov 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688062; cv=none; b=bDL/DoDqlmfujaD7pUjR425Uuch5ER8q+JgmLd0hJMW8Y7KMzUyXtbz9mIiNghWvwkkMQCbF48ly0VTxiCpD162SlU/4/ac79ppMZMJu1s+fEJDmidzZ1HRqZ3T2IXY3xV3DeKHms0xG5KWwAh/zANBeZMsGADu0GjosSLOg/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688062; c=relaxed/simple;
	bh=oK/ecY8SVQjsxicQV/tUD92mrzRYTPcQsFmw2JJDW/g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rixBU9WD/6vCU+jfTnEwvG/rV1QF9DmQF4xKmP3jfnShrW2emny6iSQY7CqoTGqsB+2K4elMpmchwPSsN7g7HKy9/UqZxYlf3QzPdvgn5qBPxPbsHTHVoAC5/ufzdMk4ZC9nB7W/PVPIgaUdNxCVeSJhDAiAIepIgZRlv/w6w98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cf10LL0X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731688060; x=1763224060;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oK/ecY8SVQjsxicQV/tUD92mrzRYTPcQsFmw2JJDW/g=;
  b=cf10LL0XK2t2PBGZug6VNrNrtMZ2t4Ddg634UObpVj+SzQMwTH5fwDMj
   iH/U2kdwvRl7GknQEgkvx3qX7VovkRZKAs4N20Q6M3+o98+k6Sr+durt7
   E0HY+UdCJJqrbfuul7WcLIyfBmkPcyfOuNYtDTiz+g2WUITtLf+EvnJ3s
   IuomxpNfDRmSBFl7NCcZBXDolVXwjx7TA3bS47gta92KYQnM5fncfcUFi
   OfsUaIhUyIo19MDrHYAdmiUzPtOqQkIieJfAMNx/OGSmxuQMjSe+nY7tU
   p2ybh9Qr9PUST6wAqskVrP+o/Bl8LGtQ9Vc35WyFHQi83hynZcOFBR1Mu
   A==;
X-CSE-ConnectionGUID: +yi6HbtlRgqw8evKt9zwoQ==
X-CSE-MsgGUID: q6fC0XTISfi+NZ8HhNzXGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="34572018"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="34572018"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 08:27:39 -0800
X-CSE-ConnectionGUID: H0U1k8MRTRSwIU8xkOKmwA==
X-CSE-MsgGUID: GK+31EqdRk2Tz36M3cEF8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="93545937"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 08:27:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 15 Nov 2024 18:27:34 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Stefan Wahren <wahrenst@gmx.net>, 
    Florian Fainelli <florian.fainelli@broadcom.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/PME+pciehp: Request IRQF_ONESHOT because bwctrl
 shares IRQ
In-Reply-To: <ZzdF1zrgQNNRlkgP@wunner.de>
Message-ID: <ca3008f1-d4ba-a68e-5a3c-a9e2e075eaa0@linux.intel.com>
References: <20241114142034.4388-1-ilpo.jarvinen@linux.intel.com> <ZzdF1zrgQNNRlkgP@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-269478299-1731688054=:940"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-269478299-1731688054=:940
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 15 Nov 2024, Lukas Wunner wrote:

> On Thu, Nov 14, 2024 at 04:20:34PM +0200, Ilpo J=E4rvinen wrote:
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -68,7 +68,8 @@ static inline int pciehp_request_irq(struct controlle=
r *ctrl)
> > =20
> >  =09/* Installs the interrupt handler */
> >  =09retval =3D request_threaded_irq(irq, pciehp_isr, pciehp_ist,
> > -=09=09=09=09      IRQF_SHARED, "pciehp", ctrl);
> > +=09=09=09=09      IRQF_SHARED | IRQF_ONESHOT,
> > +=09=09=09=09      "pciehp", ctrl);
> >  =09if (retval)
> >  =09=09ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
> >  =09=09=09 irq);
>=20
> I don't think this will work.  The IRQ thread pciehp_ist() may write
> to the Slot Control register and await a Command Completed event,
> e.g. when turning Slot Power on/off, changing LEDs, etc.
>=20
> What happens then is, the hardware sets the Command Completed bit in
> the Slot Status register and signals an interrupt.  The hardirq handler
> pciehp_isr() reads the Slot Status register, acknowledges the
> Command Completed event, sets "ctrl->cmd_busy =3D 0" and wakes up the
> waiting IRQ thread.
>=20
> In other words, pciehp does need the interrupt to stay enabled while
> the IRQ thread is running so that the hardirq handler can receive
> Command Completed interrupts.
>=20
> Note that DPC also does not use IRQF_ONESHOT, so you'd have to change
> that as well in this patch.  The Raspberry Pi happens to not support
> DPC, so Stefan didn't see an error related to it.
>=20
> I'm afraid you need to amend bwctrl to work without IRQF_ONESHOT rather
> than changing all the others.

That isn't complicated. The current irq thread handler is simple enough=20
that it will just work as hardirq handler without any changes.

--=20
 i.

--8323328-269478299-1731688054=:940--

