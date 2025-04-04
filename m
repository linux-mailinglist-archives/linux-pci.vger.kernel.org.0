Return-Path: <linux-pci+bounces-25292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061AAA7BD35
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 15:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752E43BAA07
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E671EB9F4;
	Fri,  4 Apr 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/8+Y6m9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880611EB5C6
	for <linux-pci@vger.kernel.org>; Fri,  4 Apr 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743771998; cv=none; b=Bmwg7LouV5IR3c3tdCKivQ3ifObCkxB0wBG9EXE73M1Ra/LFW9q9puWAoa2x2QLa/ebx4XpSn/1eFgzcM5iA9sQFpNH3CIXeetLzXXOT7jTq5vvaV/UzJ6Ns3WO9YGgGpVZdNa87bD7gENlM1IZI23bI4WTpg5d+5qmyWYyzWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743771998; c=relaxed/simple;
	bh=6kLW8TU07eSWPRTQakiapFKxWkQpRJJL6ViFQsUeaDw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZxFS2sZC3+Nk0KcMTsl6gWybhAgIFmedZJx8T1yJa7vkeFRqOlTBbRHNR+O7iw+Kg2e2I8qSqzLDMJOFkvQ7eU3WVs0dL4JuLJDrqTosxbSw/M5sEySrKtYUoiJx3kt4zrVKSj2FnOPpmbxSvk9CR0KDz3pkvWg3MAsqvW+b/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/8+Y6m9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743771997; x=1775307997;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=6kLW8TU07eSWPRTQakiapFKxWkQpRJJL6ViFQsUeaDw=;
  b=f/8+Y6m9Smd71fls5W8psDwuNVXrHHChb9lDt4LjR/jeTmQzqOA36Nwa
   hrQVkPGtDZ3fxnlEZ6nri5eSKGAQajL5ebhRZ4ja/xgeGFx0zTZrkH+66
   5R6Xfy7KF9SrgROGZtJoIEx6u0xLSjRoyevuWHPXe+TbSfyPv6B9lwWkG
   m8SrFzZpE7XXVcJPWLJlfMTWGGO1fxW2cKcOLR+g1kAaCPoLZTJgkQf+9
   OIuSrCK9x3SSlpaFryV/ymTspNEhq2kO4STaJLc3UZ6I15JiyrVWDyYku
   HiYxlnEdqvEuCpDjKZi6Rlx+okZU5/BTn4a8ADonEwAxd/Qhw+8Z/vCd/
   A==;
X-CSE-ConnectionGUID: EF+8/prgRXa1CBDelGNSuw==
X-CSE-MsgGUID: 8xqtKgZgSIuaO+R2E88m4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="55400859"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="55400859"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 06:06:36 -0700
X-CSE-ConnectionGUID: vsLiDqsoQtCw9lOiGvmRIw==
X-CSE-MsgGUID: U5RlDQKsQeeUxX8iKB7Z4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="128156040"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.54])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 06:06:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 4 Apr 2025 16:06:30 +0300 (EEST)
To: Wouter Bijlsma <wouter@wouterbijlsma.nl>
cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, 
    linux-pci@vger.kernel.org, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI/bwctrl: Fix NULL pointer deref on bus number
 exhaustion
In-Reply-To: <20250323125652.GJ1902347@rocinante>
Message-ID: <9155d44f-f750-d678-ead7-3b27e389bb4a@linux.intel.com>
References: <3b6c8d973aedc48860640a9d75d20528336f1f3c.1742669372.git.lukas@wunner.de> <20250323112456.GA1902347@rocinante> <2e16d6af-7d7d-47a7-9c69-26f0765a83d6@app.fastmail.com> <20250323125652.GJ1902347@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-938112304-1742825758=:1100"
Content-ID: <52d4aed4-dd88-f439-1949-0e68415e3eb9@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-938112304-1742825758=:1100
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <4815f46f-f97e-2b43-f61d-73bfc8f1f71b@linux.intel.com>

On Sun, 23 Mar 2025, Krzysztof Wilczy=F1ski wrote:

> Hello,
>=20
> > The patch is working, no kernel crashes and shutting down after hotplug=
ging the Thunderbolt 4 dock does not hang anymore, thanks!
>=20
> Thank you for testing!  Appreciated!
>=20
> > I still see messages in the kernel log that 'devices behind bridge are=
=20
> > unusable' because 'no bus can be assigned to them', 'Hotplug bridge=20
> > without secondary bus, ignoring', etc. These all refer to the=20
> > Thunderbolt 4 bridge. Adding "pci=3Dhpbussize=3D0x33" to the kernel=20
> > doesn't make a difference. Adding=20
> > "pci=3Drealloc,asssign-busses,hpbussize=3D0x33" actually does 'fix' the=
=20

Hi,

Hmm, it seems this reply got stuck into postponed messages so sending it=20
only now.

There's a typo (3 x s) in the value, perhaps just for the email as it=20
worked.

> > bus allocation failures (or at least I don't see any messages in the=20
> > log anymore), but then amdgpu fails to initialize the IGP.=20

That is very likely independent issue. I can try to look at it if it's=20
some resource assignment related problem that occurs with pci=3Drealloc.=20
Please could you take a dmesg with this added into the kernel command=20
line:

dyndbg=3D"file drivers/pci/*.c +p"

I might also benefit from contents /proc/iomem if it turns out to be a=20
resource assignment problem but we'll see.

--=20
 i.

> We can fix any outstanding issues or drop this patch.  I leave it to hot
> plug experts like Ilpo, Bjorn and Lukas to make the call here.

>
> > Anyway, all devices connected to the Thunderbolt 4 dock appear to work =
(USB, screens, ethernet) even despite these bus allocation failures, so I w=
ill just ignore them.=20
> >=20
> > Thanks again!
>=20
> Would you be happy to provide your "Tested-by:" tag?
>=20
> =09Krzysztof
>=20
--8323328-938112304-1742825758=:1100--

