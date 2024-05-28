Return-Path: <linux-pci+bounces-7897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0A18D1C38
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDB71C224BF
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E28916DED0;
	Tue, 28 May 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GU5hEJzp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29DD16415;
	Tue, 28 May 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901859; cv=none; b=QCIjSOlLjLId95WfndmSOzSqbaL+wxdxyeGvfUD+rxlsYqTE90WrUCHwgEuGVF6yRQiMYB8uRVwEB2yz010OHro/i6hk9ZJd4DsH43H3BlxoMyEVuoqk/5t7Prv48k7cqR4pu95bjruV2iYuJgOX9OGSkMv9n6grY060dkehX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901859; c=relaxed/simple;
	bh=y2U0inHLJFQsjFYdDnuZ/Pyh6sqhoML60UpW/fbBVD8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aNpSXQMhEkw82jqzK+iArF/FqnJjFutCyXaRwy5L4N26HeVhT+WRNc1QCRIA9qTdVO2TXU7n/AAuWJvnNv1HH6U02VbvQJ5UqcGsnwUvm8eflQ/NmjFn47R3Ac3QthE1oi+wRlk7INKAabOfjmUkT3nNH/6G50cBOdEgR6w50Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GU5hEJzp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716901857; x=1748437857;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=y2U0inHLJFQsjFYdDnuZ/Pyh6sqhoML60UpW/fbBVD8=;
  b=GU5hEJzpkwC4wTVKhz/CJMluY1haKzxG2DkxcL9TgbDq4t5uzYbYjf+8
   kVc85NecnLZW6b+hJUuw3TlCnSpMSSiFvs0+pHlREO3TNT9MCqg+sXkpz
   iCsyQVcyt0BSpIV86AB1GSEbzfFEe7zC3LtiuZSV4I7K+EBuPAqrSiC9H
   oZfdBc5hEaNQb4Dfte7C9lRRhjI1HA5Ez+WRQukSzPEsaPql9X6oCeIkH
   RvD0jQE6JxI43BmyceBEN1M+SjWFhc6Hj6XI0WBtEATsP/8nUpfQxD0Rt
   mZHm4/U4KoWDiJ28nRYggKmPdBRJT+2OrOU5zdkJkKfzF1n+pmsmF3tG9
   w==;
X-CSE-ConnectionGUID: 1FIEn3J5R92jjN6+nP9jOg==
X-CSE-MsgGUID: VhSrSl4vQZaQ6PiZg7ixSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16193950"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="16193950"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:10:57 -0700
X-CSE-ConnectionGUID: J1JoFGxjRIq98SGInm9S3Q==
X-CSE-MsgGUID: YhbmgSIuRTOqX7FDWsDQnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="72497555"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:10:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 16:10:48 +0300 (EEST)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Igor Mammedov <imammedo@redhat.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] PCI: Solve two bridge window sizing issues
In-Reply-To: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <253622e9-378c-4699-886e-2240216eef59@linux.intel.com>
References: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-471983526-1716901848=:5869"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-471983526-1716901848=:5869
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 May 2024, Ilpo J=C3=A4rvinen wrote:

> Hi all,
>=20
> Here's a series that contains two fixes to PCI bridge window sizing
> algorithm. Together, they should enable remove & rescan cycle to work
> for a PCI bus that has PCI devices with optional resources and/or
> disparity in BAR sizes.
>=20
> For the second fix, I chose to expose find_resource_space() from
> kernel/resource.c because it should increase accuracy of the cannot-fit
> decision (currently that function is called find_resource()). In order
> to do that sensibly, a few improvements seemed in order to make its
> interface and name of the function sane before exposing it. Thus, the
> few extra patches on resource side.
>=20
> v3:

Hi Bjorn,

It's a bit unclear to me what is your view about the status of this=20
series? I see you placed these first into some wip branches and then into=
=20
resource branch but the state of the patches in patchwork is still marked=
=20
as "New" nor have you sent any notice they'd have been "applied".

I'm thinking this from the perspective of whether I should send v4 with=20
those minor comments from Andy addressed or not? I could also send those
minor things as separate patches on top of the series if that's=20
easier/better for you.

--=20
 i.

> - Removed "slot" wording
>         - Renamed find_empty_resource_slot() -> find_resource_space()
> - find_resource_space() returns bool instead of int
> - Added patch to convert literal 20 related to bridge win minimum
>   alignment to __ffs(SZ_1M)
> - Fixed kerneldoc missing "struct"
> - Tweaked prints (one dbg -> info, added new dbg one for success case)
> - Changelog tweaks
>         - Take account largest >> 1 (in alignment calc)
>         - Adjust to minor changes made into calculate_memsize()
>         - Take logs from more recent kernel to get rid of reg 0xXX
>=20
> v2:
> - Add "typedef" to kerneldoc to get correct formatting
> - Use RESOURCE_SIZE_MAX instead of literal
> - Remove unnecessary checks for io{port/mem}_resource
> - Apply a few style tweaks from Andy
>=20
> Ilpo J=C3=A4rvinen (8):
>   PCI: Fix resource double counting on remove & rescan
>   resource: Rename find_resource() to find_resource_space()
>   resource: Document find_resource_space() and resource_constraint
>   resource: Use typedef for alignf callback
>   resource: Handle simple alignment inside __find_resource_space()
>   resource: Export find_resource_space()
>   PCI: Make minimum bridge window alignment reference more obvious
>   PCI: Relax bridge window tail sizing rules
>=20
>  drivers/pci/bus.c       | 10 +----
>  drivers/pci/setup-bus.c | 91 +++++++++++++++++++++++++++++++++++++----
>  include/linux/ioport.h  | 44 ++++++++++++++++++--
>  include/linux/pci.h     |  5 +--
>  kernel/resource.c       | 68 ++++++++++++++----------------
>  5 files changed, 157 insertions(+), 61 deletions(-)
>=20
>=20
--8323328-471983526-1716901848=:5869--

