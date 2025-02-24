Return-Path: <linux-pci+bounces-22217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B30A4260B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08093A4811
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED9A13D52B;
	Mon, 24 Feb 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRepr2/9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6902155744;
	Mon, 24 Feb 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410003; cv=none; b=M6UvEvvhCuQoX2vn1OgmTyhArxnAdl2vko2UXmUGTqBs3ozLAfZNLSNU0dlpSxjO2THwjPIy8kKq8Bw3Rl38hPKCtGyK3MXv1Lo5L1CGoqlAf3O1VWisZ2z9m4BapcAatO2bPDQor8bTAadfTdmGtzymxCDQALl+dnZDHbZ0o74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410003; c=relaxed/simple;
	bh=2lrEW7fKEmytUQvaxt5sAnJstfJfZLbLMW6ThOmSUk8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f+xQvaYn6uQqFlxHlbN0Jis3E8x+4VegziZfSuR/HXYL6QWx0LJHNi0Hih4fKqHjblqwe96IQQ0ab1CIAJOIB3gEJeD5rEV4XmwMgd2CIS3e4M+Hze/g8fUsexYa69tyPaXU0wGQJzMXO6B93uaQRJ9H/sm7frYasOaTOjI4gP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRepr2/9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740410002; x=1771946002;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=2lrEW7fKEmytUQvaxt5sAnJstfJfZLbLMW6ThOmSUk8=;
  b=fRepr2/9RTsLHbngs2Zv375gehrrxhbuGpbihSOxyW3mHFXrODf4Rgao
   aZwkAIWGtGY2aIw3/Jn31bjnjwdLyCNTRd3DByn8UAITzh7k+pGM6A9MY
   by4BWen3Asn4MlkjKurexbEF90BGf1RP6q4pnNVl+DCbfGbdbXUN3oK3D
   b99JX0Xwbf08Oec1utsATtMdnsh0+p9Hc8XjtUrzKs9UxpUvsKuT/64gc
   GjbODRQgJr3sAwKoCmfiTJ95+P+3ORCjoxegD4aVl8zler49xVfNz1g8o
   HIvCZilKWQq0gNRMlMBjuAl40Jr2QFYSG/PfATzwHrAIQ6Nyrm39CV8T8
   g==;
X-CSE-ConnectionGUID: p4B+WI95TVCy2pC0XbMmOg==
X-CSE-MsgGUID: E/6sfLOtSK20VJTuCd9QBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40355702"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40355702"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:13:21 -0800
X-CSE-ConnectionGUID: cFU1qciwRDWRkjmaulCmqw==
X-CSE-MsgGUID: BfGO7GmVScO9JONOLc49pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116591599"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.233])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:13:18 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Feb 2025 17:13:15 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Joel Mathew Thomas <proxy0@tutamail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Disable PCIe BW controller during
 reset
In-Reply-To: <Z7RL7ZXZ_vDUbncw@wunner.de>
Message-ID: <14797a5a-6ded-bf8f-aa0c-128668ba608f@linux.intel.com>
References: <20250217165258.3811-1-ilpo.jarvinen@linux.intel.com> <Z7RL7ZXZ_vDUbncw@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1975770050-1740389518=:933"
Content-ID: <7ae1b7e7-ce77-7678-8389-feec435e7b8d@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1975770050-1740389518=:933
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <433e8960-e79b-20de-9bc1-33e4c29a413c@linux.intel.com>

On Tue, 18 Feb 2025, Lukas Wunner wrote:

> On Mon, Feb 17, 2025 at 06:52:58PM +0200, Ilpo J=E4rvinen wrote:
> > PCIe BW controller enables BW notifications for Downstream Ports by
> > setting Link Bandwidth Management Interrupt Enable (LBMIE) and Link
> > Autonomous Bandwidth Interrupt Enable (LABIE) (PCIe Spec. r6.2 sec.
> > 7.5.3.7).
> >=20
> > It was discovered that performing a reset can lead to the device
> > underneath the Downstream Port becoming unavailable if BW notifications
> > are left enabled throughout the reset sequence (at least LBMIE was
> > found to cause an issue).
>=20
> What kind of reset?  FLR?  SBR?  This needs to be specified in the
> commit message so that the reader isn't forced to sift through a
> bugzilla with dozens of comments and attachments.

Heh, I never really tried to figure out it because the reset disable=20
patch was just a stab into the dark style patch. To my surprise, it ended=
=20
up working (after the initial confusion was resolved) and I just started=20
to prepare this patch from that knowledge.

Logs do mention this:

[   21.560206] pcieport 0000:00:01.1: unlocked secondary bus reset via: pci=
ehp_reset_slot+0x98/0x140

=2E..so it seems to be SBR.

> The commit message should also mention the type of affected device
> (Nvidia GPU AD107M [GeForce RTX 4050 Max-Q / Mobile]).  The Root Port
> above is an AMD one, that may be relevant as well.

Okay.

> > While the PCIe Specifications do not indicate BW notifications could no=
t
> > be kept enabled during resets, the PCIe Link state during an
> > intentional reset is not of large interest. Thus, disable BW controller
> > for the bridge while reset is performed and re-enable it after the
> > reset has completed to workaround the problems some devices encounter
> > if BW notifications are left on throughout the reset sequence.
>=20
> This approach won't work if the reset is performed without software
> intervention.  E.g. if a DPC event occurs, the device likewise undergoes
> a reset but there is no prior system software involvement.  Software only
> becomes involved *after* the reset has occurred.
>=20
> I think it needs to be tested if that same issue occurs with DPC.
> It's easy to simulate DPC by setting the Software Trigger bit:
>=20
> setpci -s 00:01.1 ECAP_DPC+6.w=3D40:40
>=20
> If the issue does occur with DPC then this fix isn't sufficient.

Looking into lspci logs, I don't see DPC capability being there for=20
00:01.1?!

> > Keep a counter for the disable/enable because MFD will execute
> > pci_dev_save_and_disable() and pci_dev_restore() back to back for
> > sibling devices:
> >=20
> > [   50.139010] vfio-pci 0000:01:00.0: resetting
> > [   50.139053] vfio-pci 0000:01:00.1: resetting
> > [   50.141126] pcieport 0000:00:01.1: PME: Spurious native interrupt!
> > [   50.141133] pcieport 0000:00:01.1: PME: Spurious native interrupt!
> > [   50.441466] vfio-pci 0000:01:00.0: reset done
> > [   50.501534] vfio-pci 0000:01:00.1: reset done
>=20
> So why are you citing the PME messages here?  Are they relevant?
> Do they not occur when the bandwidth controller is disabled?
> If they do not, they may provide a clue what's going on.
> But that's not clear from the commit message.

They do occur also when BW controller is disabled for the duration of=20
reset. What I don't currently have at hand is a comparable log from era=20
prior to any BW controller commits (from 6.12). The one currently in=20
bugzilla has the out-of-tree module loaded.

PME and BW notifications do share the interrupt so I'd not entirely=20
discount their relevance though, and one of my theories (never mentioned=20
anywhere until now) was that the extra interrupts that come due to BW=20
notifications somehow manage to confuse PME driver. But I never found=20
anything to that effect.

I can remove the PME lines though.

> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5166,6 +5167,9 @@ static void pci_dev_save_and_disable(struct pci_d=
ev *dev)
> >  =09 */
> >  =09pci_set_power_state(dev, PCI_D0);
> > =20
> > +=09if (bridge)
> > +=09=09pcie_bwnotif_disable(bridge);
> > +
> >  =09pci_save_state(dev);
>=20
> Instead of putting this in the PCI core, amend pcie_portdrv_err_handler
> with ->reset_prepare and ->reset_done callbacks which call down to all
> the port service drivers, then amend bwctrl.c to disable/enable
> interrupts in these callbacks.

Will it work? I mean if the port itself is not reset (0000:00:01.1 in this=
=20
case), do these callbacks get called for it?

> > +=09port->link_bwctrl->disable_count--;
> > +=09if (!port->link_bwctrl->disable_count) {
> > +=09=09__pcie_bwnotif_enable(port);
> > +=09=09pci_dbg(port, "BW notifications enabled\n");
> > +=09}
> > +=09WARN_ON_ONCE(port->link_bwctrl->disable_count < 0);
>=20
> So why do you need to count this?  IIUC you get two consecutive
> disable and two consecutive enable events.
>=20
> If the interrupts are already disabled, just do nothing.
> Same for enablement.  Any reason this simpler approach
> doesn't work?

If enabling on restore of the first dev, BW notifications would get=20
enabled before the last of the devices has been restored. While it might=20
work, the test patch, after all, did work without this complexity, IMO it=
=20
seems unwise to create such a racy pattern.

For disable side, I think it would be possible to always disable=20
unconditionally.

--=20
 i.
--8323328-1975770050-1740389518=:933--

