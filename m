Return-Path: <linux-pci+bounces-36271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5FB59CF1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 18:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D23167158
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 16:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7059E283FE7;
	Tue, 16 Sep 2025 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7IqmjlC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545128312D;
	Tue, 16 Sep 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038552; cv=none; b=ItYF3Iv7ViaowvFawW69PpKx/vyxGUT/M7CMSCHJZ9vcNDjdIzr4lAOkN7MFAP8r8ck4U6aPQ222RFMb9ClzYnsj4nfY19o80QWYANIXNeJs4dR63W/uaLWdbbAhJFmuO6UCq7uqxyEH6A5wiYyexWNV3aevEcYk4XyyQu0Yjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038552; c=relaxed/simple;
	bh=Hb5au3Uvp4FpaBemuX/VN5BQxHiXxDyZSfCuoXwXubE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VOLzIgbMEbL6Dz+qyBOJDuVelUhqDbKGpB0iMaor52+/eHgvsBrcqZGUcVAFcSSsQ4VIVACJXxXBCisi4vSwzdJHX0mT5Jw/TYkDGmqRnAv/3DwenpvrYcP/eu7UhnfTqr9/uLVzt1wuS9kZNppDr21iNW9bB5982UHS7XD63Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7IqmjlC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038551; x=1789574551;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Hb5au3Uvp4FpaBemuX/VN5BQxHiXxDyZSfCuoXwXubE=;
  b=i7IqmjlCvDAcReqTnnZYyMgCb/aS85hwya7fmGiEd9CsaV/EjCe7cO4b
   PBUfQFCqNWkmS0SVZCCPv5v0d4wxkHEUlz2sxrA1rJins1JYCx7yPOroD
   tr9FnrFINwimYLxVmdOYsNx8b52qd7cilpH/KWsbC8o+4mx+QyQBahXSs
   JVQ6OjMvfjUjGdJS2bMekxr2GvrBPUmPy2lFtuC2QsSkuNdu9vtMoDjqu
   4vmcgx1rAbXPawoKzkVM0/DJ7iqJgnegcr423VSKalhCgqlbe27JUVCdI
   js08IncrBIEaAcPf7iqAlu+pcqUyjwX2qxAtTdsW13avOKoxP4Z8D2SE+
   w==;
X-CSE-ConnectionGUID: oCZLtxtYT8Kag8dz9I44cQ==
X-CSE-MsgGUID: kK9op9HTQV+MWAp0fqGkhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60394586"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60394586"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:02:29 -0700
X-CSE-ConnectionGUID: EOkCs+SITou17l4soUtPiQ==
X-CSE-MsgGUID: eUSEsKZCSa6pXfmGD5BMmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="205940945"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:02:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Sep 2025 19:02:19 +0300 (EEST)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/24] PCI: Bridge window selection improvements
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <9a21aa6b-ab8b-7ae5-5dbf-f2b895798e8c@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1097006165-1758038539=:10969"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1097006165-1758038539=:10969
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 29 Aug 2025, Ilpo J=C3=A4rvinen wrote:

> This series is based on top of the three resource fitting and assignment
> algorithm fixes already in the pci/resource branch. I've tried to compare
> these patch with the commits in the pci/resource branch to retain the min=
or
> spelling/grammar corrections Bjorn made while applying v1.
>=20
> v2 is just to fix two small issues within the series intermediate patches=
=2E
> These corrections attempt to ensure this series is bisectable if
> troubleshooting requires that in the future.
>=20
> In addition, a few corrections to changelog texts were made.
>=20
> I'm left to wonder though if the added double spaces after some stops
> within the commit messages in the pci/resource branch were intentional or
> not (I did remove them for v2).
>=20
> As the changes are very minimal, I'm only sending this to lists and Bjorn
> to spare people's inboxes. If somebody provides a Tested-by tag for v1, i=
t
> should be counted in for this v2 (v1 vs v2 difference does not matter if
> testing the entire series).
>=20
> v2:
> - In pci_bridge_release_resources():
>     - Keep type assignment in until removing the type hack.
>     - Introduce res_name in the patch it is used avoid compiler warning
>       about unused variable. Place it into the block that needs it.
> - Minor corrections to changelog texts

Hi Bjorn,

Just a reminder that v2 improves bisectability of this series which might=
=20
turn out very useful in case people hit any issues due to one of these=20
changes so I'd prefer pci/resource content to be upgrade from v1 to v2.

--
 i.

> Ilpo J=C3=A4rvinen (24):
>   m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
>   sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
>   MIPS: PCI: Use pci_enable_resources()
>   PCI: Move find_bus_resource_of_type() earlier
>   PCI: Refactor find_bus_resource_of_type() logic checks
>   PCI: Always claim bridge window before its setup
>   PCI: Disable non-claimed bridge window
>   PCI: Use pci_release_resource() instead of release_resource()
>   PCI: Enable bridge even if bridge window fails to assign
>   PCI: Preserve bridge window resource type flags
>   PCI: Add defines for bridge window indexing
>   PCI: Add bridge window selection functions
>   PCI: Fix finding bridge window in pci_reassign_bridge_resources()
>   PCI: Warn if bridge window cannot be released when resizing BAR
>   PCI: Use pbus_select_window() during BAR resize
>   PCI: Use pbus_select_window_for_type() during IO window sizing
>   PCI: Rename resource variable from r to res
>   PCI: Use pbus_select_window() in space available checker
>   PCI: Use pbus_select_window_for_type() during mem window sizing
>   PCI: Refactor distributing available memory to use loops
>   PCI: Refactor remove_dev_resources() to use pbus_select_window()
>   PCI: Add pci_setup_one_bridge_window()
>   PCI: Pass bridge window to pci_bus_release_bridge_resources()
>   PCI: Alter misleading recursion to pci_bus_release_bridge_resources()
>=20
>  arch/m68k/kernel/pcibios.c   |  39 +-
>  arch/mips/pci/pci-legacy.c   |  38 +-
>  arch/sparc/kernel/leon_pci.c |  27 --
>  arch/sparc/kernel/pci.c      |  27 --
>  arch/sparc/kernel/pcic.c     |  27 --
>  drivers/pci/bus.c            |   3 +
>  drivers/pci/pci-sysfs.c      |  27 +-
>  drivers/pci/pci.h            |   8 +-
>  drivers/pci/probe.c          |  35 +-
>  drivers/pci/setup-bus.c      | 798 ++++++++++++++++++-----------------
>  drivers/pci/setup-res.c      |  46 +-
>  include/linux/pci.h          |   5 +-
>  12 files changed, 504 insertions(+), 576 deletions(-)
>=20
>=20
> base-commit: 295524c65d8b4850efbb809f12176eb1262a5aba
>=20
--8323328-1097006165-1758038539=:10969--

