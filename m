Return-Path: <linux-pci+bounces-16755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9559C8A09
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 13:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E455628525D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3E1FA24F;
	Thu, 14 Nov 2024 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGeURtVd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D11F9A8D;
	Thu, 14 Nov 2024 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587591; cv=none; b=Pnlu7Y+Bf3YKNl1BzlU+rIsby4EY9NQ76gureV/xARo9VFIMFnO9f0T4xYW+XV0n8m8XULKpLaj0tQ3W4y/z4S1atK08sfr/Cv2ojW49KWF+L03SQfhOqtayji9rNHL0gy7dbBEaJy+B1ZCUJowHeKpT3KuZooqyJ81nxaqymIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587591; c=relaxed/simple;
	bh=3kQXH45Idd5+JbJ5Ak0RLE0/ggWU/RBEVLi1j3lyd1Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ldD8ff4CdP2YFP/KAKs3PpW2+ihxV4/dwWtIrH6dQw7NarfTCPD7o6XWA04zQQYuspJ+UT+Fi5aFHXdRhgC9CGvyC7XOOFbtV6IAG0c/+tNeK/2zQFNuMv73k52hDmzC/Lq2bwkMg3QR9lX85VBNnJ61gHgXYrxIZwIP2kVfies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGeURtVd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731587590; x=1763123590;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=3kQXH45Idd5+JbJ5Ak0RLE0/ggWU/RBEVLi1j3lyd1Y=;
  b=NGeURtVdfcDQWCMh6ffMTeqv/BZIUJDfkAvOh+aKurh+kKcvvfo5faBE
   SXQR+DG2s+218RCHKKig3vO+v9rh0HzSI7do6FDRpkEDQ38fRgnpKCJtx
   mudFdPiTDx0qa+iYjP+XlYf3zqDOE+8/g7tFwfa9dsdvcVImKQxi2Z/HJ
   4IjlEliCq0yYGW296vQcFyW3Ob/6DME8aUzaEVsi3U7yMg8HXrt6pIMIz
   oBG2TOkuIN2tidS//wqSIuKJtBUtS6hpteRLC7E3NoPpcqs8nG33IvWdj
   BQMJ9doJZWVUqFXPfon1c+AIEdmErfaUrHeT/+eQ7Cqev6BuH+/Rb/d7m
   A==;
X-CSE-ConnectionGUID: sv4qmrZ0Siu7lvU4apokRQ==
X-CSE-MsgGUID: h/KeglIvQIK+kMxbNh+UCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42149100"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="42149100"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 04:33:07 -0800
X-CSE-ConnectionGUID: u6Su2D4VTTSwaRflvzFO/Q==
X-CSE-MsgGUID: RxPJOsDQS0yrxIdVh89iTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="92999718"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 04:32:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 14 Nov 2024 14:32:56 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
    Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
    Amit Pundir <amit.pundir@linaro.org>, 
    Neil Armstrong <neil.armstrong@linaro.org>, 
    Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v9 0/9] PCI: Add PCIe bandwidth controller
In-Reply-To: <20241113214850.GA1912974@bhelgaas>
Message-ID: <a5d7afb0-be64-78fd-24fa-b374647c1d8c@linux.intel.com>
References: <20241113214850.GA1912974@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-533261549-1731581789=:939"
Content-ID: <ddf631d2-2345-0064-55e1-b6856dcd4a0a@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-533261549-1731581789=:939
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <24c044f9-6a09-1f98-9c0b-5ebe7e7d745b@linux.intel.com>

On Wed, 13 Nov 2024, Bjorn Helgaas wrote:

> [+cc Bart, Amit, Neil, Caleb]
>=20
> On Wed, Oct 23, 2024 at 05:19:04PM -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 18, 2024 at 05:47:46PM +0300, Ilpo J=E4rvinen wrote:
> > > This series adds PCIe bandwidth controller (bwctrl) and associated PC=
Ie
> > > cooling driver to the thermal core side for limiting PCIe Link Speed
> > > due to thermal reasons. PCIe bandwidth controller is a PCI express bu=
s
> > > port service driver. A cooling device is created for each port the
> > > service driver finds to support changing speeds.
>=20
> > >  drivers/pci/pcie/bwctrl.c                     | 366 ++++++++++++++++=
++
> > >  include/linux/pci-bwctrl.h                    |  28 ++
> > >  tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
> > >  .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 ++++++
> > >  .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 ++++
>=20
> > Applied to pci/bwctrl for v6.13, thanks Ilpo (and Alexandru, for the
> > bandwidth notification interrupt support)!
>=20
> How attached are we to "bwctrl" and "pwrctl" as the names?
>
> I just noticed that we have "ctrl" for bandwidth control but "ctl" for
> power control, which is slightly annoying to keep straight.
>=20
> "ctrl" is more common in the tree:
>=20
>   $ find -name \*ctrl\*[ch] | wc -l
>   691
>   $ find -name \*ctl\*[ch] | wc -l
>   291
>=20
> so I would prefer that, although "pwrctl" is already in the tree (as
> of v6.11), so it would be more disruptive to change it than to rename
> "bwctrl".

I personally don't mind what the name is.

However, what I've noted is that visually those two are so similar that my=
=20
brains will mix them on a glance anyway. Maybe the length difference would=
=20
help on that confusion too, remains to be seen.

--=20
 i.
--8323328-533261549-1731581789=:939--

