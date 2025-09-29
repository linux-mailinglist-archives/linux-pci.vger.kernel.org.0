Return-Path: <linux-pci+bounces-37201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A8BA9713
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 15:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD073189E61C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C36830507B;
	Mon, 29 Sep 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hY2be1ap"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C01A9FBD;
	Mon, 29 Sep 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154174; cv=none; b=IrhZ6NSW9+eKfhnJJ6gmiSKA2cIJDiQUCV72mHgkxaRkOrzdXkvcunUYL7HoT/d/U4MfLdXO3pRbG2ERGhGkIJ7SX7CxH00Qd3xnmmZQerj240E7ZAJzXD1ZUk5nOVH6Glk2b5S/TD8haCqWJzMP5JFGH1KgPU/A5JKPD3bqhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154174; c=relaxed/simple;
	bh=InW/YTaTkD8Una1CgxcS+Sd39MuweMYKZK1qU0gW9hU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MttSkkUg2xgJKkIZ8JPZTncHMDHVYQbS9zNCH/ZNno8aNx+PTqDYgFHwAWujcvDY7DgTTT2aVdnweS+Q7WIZHiQQGTulob8qjlURNJYUmL1eCQQU+IZzxHskbOZkDxDgOd8whPqPnLq9ihlQ6nAXjwOQ2aBc3V848Y0torErUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hY2be1ap; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759154172; x=1790690172;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=InW/YTaTkD8Una1CgxcS+Sd39MuweMYKZK1qU0gW9hU=;
  b=hY2be1apm2in9h4tc46OFoBsMRt/s6pjPp3enLQHuimKPJbZaLZ1Jb31
   4J0cY0fcyslHVbz95EKnyYrAgXy+z13tjx1FOGO+wp35QZYN6nUqUBDVD
   aYSscPcHbMvZZ5JUxPc+BcWh49saIqGSSmskTBmiPMy1SL4o8UvZitDSF
   7f2jVYjxC1AJxT3PqiM/oTZ2HkbCtaXdKjc1Ai36w1pxKhm7N5GtFQ6G4
   oWW9qToIukRHkW7Ax7wQZ/CNVttjIrEXky8NQIjOvqHK6xju+E4klFec8
   pjvjyMqiryUPm3DzHj+9rqHxHjc0md6K9JQiGsheeL0WECxYjWifqwP1X
   g==;
X-CSE-ConnectionGUID: E8iFxJQZR7qua2YwOalQXQ==
X-CSE-MsgGUID: 7YVE4DvESeGQfoe5aUSh9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61560597"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="61560597"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:56:12 -0700
X-CSE-ConnectionGUID: p5/xDExsSWqsaFWuk/LpIA==
X-CSE-MsgGUID: 8VheNZ6BRFOYiVFSCPX/2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="178989233"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:56:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Sep 2025 16:56:03 +0300 (EEST)
To: Lucas De Marchi <lucas.demarchi@intel.com>
cc: intel-xe@lists.freedesktop.org, linux-pci@vger.kernel.org, 
    dri-devel@lists.freedesktop.org, Icenowy Zheng <uwu@icenowy.me>, 
    Vivian Wang <wangruikang@iscas.ac.cn>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    Simon Richter <Simon.Richter@hogyros.de>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/xe: Move rebar to be done earlier
In-Reply-To: <5osrqzgrh47n6rpjulvsixwbhbh5vwxrrn6p6hpodnwisjfung@lmivgjb66oed>
Message-ID: <dfdd45b2-5a8c-cfea-ecd3-495e947022d1@linux.intel.com>
References: <20250918-xe-pci-rebar-2-v1-0-6c094702a074@intel.com> <20250918-xe-pci-rebar-2-v1-2-6c094702a074@intel.com> <5osrqzgrh47n6rpjulvsixwbhbh5vwxrrn6p6hpodnwisjfung@lmivgjb66oed>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1975384521-1759154048=:943"
Content-ID: <f64c7704-7852-3757-2f7c-098909d873f5@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1975384521-1759154048=:943
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <abbc543f-2c76-119f-fada-3f12d93deccf@linux.intel.com>

On Mon, 29 Sep 2025, Lucas De Marchi wrote:

> Hi,
>=20
> On Thu, Sep 18, 2025 at 01:58:57PM -0700, Lucas De Marchi wrote:
> > There may be cases in which the BAR0 also needs to move to accommodate
> > the bigger BAR2. However if it's not released, the BAR2 resize fails.
> > During the vram probe it can't be released as it's already in use by
> > xe_mmio for early register access.
> >=20
> > Add a new function in xe_vram and let xe_pci call it directly before
> > even early device probe. This allows the BAR2 to resize in cases BAR0
> > also needs to move:
> >=20
> > =09[] xe 0000:03:00.0: vgaarb: deactivate vga console
> > =09[] xe 0000:03:00.0: [drm] Attempting to resize bar from 8192MiB ->
> > 16384MiB
> > =09[] xe 0000:03:00.0: BAR 0 [mem 0x83000000-0x83ffffff 64bit]: releasi=
ng
> > =09[] xe 0000:03:00.0: BAR 2 [mem 0x4000000000-0x41ffffffff 64bit pref]=
:
> > releasing
> > =09[] pcieport 0000:02:01.0: bridge window [mem 0x4000000000-0x41ffffff=
ff
> > 64bit pref]: releasing
> > =09[] pcieport 0000:01:00.0: bridge window [mem 0x4000000000-0x41ffffff=
ff
> > 64bit pref]: releasing
> > =09[] pcieport 0000:01:00.0: bridge window [mem 0x4000000000-0x43ffffff=
ff
> > 64bit pref]: assigned
> > =09[] pcieport 0000:02:01.0: bridge window [mem 0x4000000000-0x43ffffff=
ff
> > 64bit pref]: assigned
> > =09[] xe 0000:03:00.0: BAR 2 [mem 0x4000000000-0x43ffffffff 64bit pref]=
:
> > assigned
> > =09[] xe 0000:03:00.0: BAR 0 [mem 0x83000000-0x83ffffff 64bit]: assigne=
d
> > =09[] pcieport 0000:00:01.0: PCI bridge to [bus 01-04]
> > =09[] pcieport 0000:00:01.0:   bridge window [mem 0x83000000-0x840fffff=
]
> > =09[] pcieport 0000:00:01.0:   bridge window [mem
> > 0x4000000000-0x44007fffff 64bit pref]
> > =09[] pcieport 0000:01:00.0: PCI bridge to [bus 02-04]
> > =09[] pcieport 0000:01:00.0:   bridge window [mem 0x83000000-0x840fffff=
]
> > =09[] pcieport 0000:01:00.0:   bridge window [mem
> > 0x4000000000-0x43ffffffff 64bit pref]
> > =09[] pcieport 0000:02:01.0: PCI bridge to [bus 03]
> > =09[] pcieport 0000:02:01.0:   bridge window [mem 0x83000000-0x83ffffff=
]
> > =09[] pcieport 0000:02:01.0:   bridge window [mem
> > 0x4000000000-0x43ffffffff 64bit pref]
> > =09[] xe 0000:03:00.0: [drm] BAR2 resized to 16384M
> > =09[] xe 0000:03:00.0: [drm:xe_pci_probe [xe]] BATTLEMAGE  e221:0000
> > dgfx:1 gfx:Xe2_HPG (20.02) ...
> >=20
> > As shown above, it happens even before we try to read any register for
> > platform identification.
> >=20
> > All the rebar logic is more pci-specific than xe-specific and can be
> > done very early in the probe sequence. In future it would be good to
> > move it out of xe_vram.c, but this refactor is left for later.
>=20
> Ilpo, can you take a look on this patch? It fixed the issue that I had
> with BMG. It needs the first patch for the full fix, but the fixes are
> more or less orthogonal.

FWIW, it looks okay to me from PCI perspective,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-1975384521-1759154048=:943--

