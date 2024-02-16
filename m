Return-Path: <linux-pci+bounces-3600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C217857F35
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 15:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780181C20A24
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E66677F35;
	Fri, 16 Feb 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O85oI3Sk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AA768F2;
	Fri, 16 Feb 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093419; cv=none; b=Wh2sdrxfwQlI82oQ5GxMwmTUdKMEdDXBVKqe3pdDmWU0Nk/MOhcxoA0/451Eulb6AAHvI1ycveCtk+AbN+TIPedyadm9jRClm7QqL25vnzFxjZ0GQuIj6zcOq+8xFczJlqCBx8K9CB0DmK/FYIWDT7LnmhzDI3309i5N80JfGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093419; c=relaxed/simple;
	bh=fXJzP/DCg9y+hQ+fAPAi7qPOlKRWg2YPHVwRkJqW1iI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YBQK2IG/bDh766FdUUGJ7Bh8zSNeUMiB7Mav84ch4L7/P4FretOcN2y63bBlIkxYacMggv1tajGTa4Otamm2Z7jLsAJhyX+X6+EQLTIpsijY40coGrwLOER6EmLgsOuq8F7qee/vkjLvwWvrtvsomrpi2kAFns4Lu57LjTvFDkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O85oI3Sk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708093417; x=1739629417;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fXJzP/DCg9y+hQ+fAPAi7qPOlKRWg2YPHVwRkJqW1iI=;
  b=O85oI3Sk3RRGMwhGgdAXZaSuZe3oyZrWefvfBZ+9WJJLGzOecOvNXJcm
   eWbz6vssw5vMg/0mz/LxQoqGc7fZD3y6sjbtJgQPlCIBEM75DohbO2DmC
   9ObqyYyU1fX4Qlg2I5BBeIBGYzdIGUdOHFKjVK8aKrfZjk57aR67dExa3
   dmvPmqaaVPQcbY2lpl30IdewYdy1V0yQsest8alqqaCvyoZk9dmtz1ccu
   JXuxQEe9eERFGb7vga2/BV1ZQ0A00qG8R/XIVtBOZHVcAF+YDxN+4lBXd
   mMDcMPyWs818EACvuB3XhqF50pUgE0f2I97HZiCIh5BoBqy3JJpAS7t2i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2371952"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2371952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 06:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="8521879"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 06:23:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 16:23:29 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Cleanup link activation wait logic
In-Reply-To: <alpine.DEB.2.21.2402161349350.3971@angie.orcam.me.uk>
Message-ID: <853a63bd-74cb-e19b-24b7-426a0fdd9003@linux.intel.com>
References: <20240202134108.4096-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2402021359450.15781@angie.orcam.me.uk> <ce73f41a-b529-726f-ee4e-9d0e0cee3320@linux.intel.com> <alpine.DEB.2.21.2402161349350.3971@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-291145476-1708093409=:1097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-291145476-1708093409=:1097
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Feb 2024, Maciej W. Rozycki wrote:
> On Fri, 16 Feb 2024, Ilpo J=C3=A4rvinen wrote:
>=20
> > >  You change the logic here in that the second conditional isn't run i=
f the=20
> > > first has not.  This is wrong, unclamping is not supposed to rely on =
LBMS.=20
> > > It is supposed to be always run and any failure has to be reported to=
o, as=20
> > > a retraining error.
> >=20
> > Now that (I think) I fully understand the intent of the second=20
> > condition/block one additional question occurred to me.
> >=20
> > How is the 2nd condition even supposed to work in the current place whe=
n=20
> > firmware has pre-arranged the 2.5GT/s resctriction? Wouldn't the link c=
ome=20
> > up fine in that case and the quirk code is not called at all since the=
=20
> > link came up successfully?
>=20
>  The quirk is called unconditionally from `pci_device_add', so an attempt=
=20
> to unclamp will always happen with a working link for qualifying devices.

Ah, thanks. I'd stared the other two calls enough of times I'd forgotten=20
the 3rd one even existed.

> > Yet another thing in this quirk code I don't like is how it can leaves =
the=20
> > target speed to 2.5GT/s when the quirk fails to get the link working=20
> > (which actually does happen in the disconnection cases because DLLLA wo=
n't=20
> > be set so the target speed will not be restored).
>=20
>  I chose to leave the target speed at the most recent setting, because th=
e=20
> link doesn't work in that case anyway, so I concluded it doesn't matter,=
=20
> but reduces messing with the device; technically you should retrain again=
=20
> afterwards.  I'm not opposed to changing this if you have a use case.

It remains suboptimally set in a case where something is plugged again=20
into that port, for Thunderbolt it doesn't matter as the PCIe speed picked=
=20
is quite bogus anyway, but disconnect then plug something again is not=20
limited to Thunderbolt.

I've no immediate plans on changing it now but it may come relevant when=20
attempting to make the bandwidth controller to trigger the quirk. To me=20
there are two quirks, not just one so I might have to split them to make=20
it better suited for triggering them from bwctrl.

--=20
 i.

--8323328-291145476-1708093409=:1097--

