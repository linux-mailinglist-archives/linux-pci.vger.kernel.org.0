Return-Path: <linux-pci+bounces-10656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F093A1E0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 15:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4311F23539
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D01369B0;
	Tue, 23 Jul 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1huXtjm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAE8F70;
	Tue, 23 Jul 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742364; cv=none; b=bDcZwr0tiIzqOyeCT5EtTHPQMBTRHxSu3GFabhpdTRAGGd4pGWGkwn57sRN3emz0VD6OnH0rPc5XRrO0omyYJCfzWfXNIRteiobFA/mspKCEwbBrmZ9SIt7GHoWh7vJqeZ4Mlf4CmWdXvIpRar0wBhNUwCgAm3b8AQDsCGKgYdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742364; c=relaxed/simple;
	bh=GJawiRDWacobpNsLTELbipOx4l8u61/Poa79VGwoK4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEgXa/6PlNRoB0EEygfktyFIuJGExTnwwHuck17jo8rQvFIw6s4c4TGVxHX3U9MlOAk/TcFkZy3PBKbBNuS8iidk9vc95ja49R4/exJ4UXIi/dlsb+Mx3xPQnbhVUFRj2XLsPXD+BCMLqalgnTAfYkVzP9ynz9NPBNolpKH2XyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1huXtjm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721742361; x=1753278361;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GJawiRDWacobpNsLTELbipOx4l8u61/Poa79VGwoK4g=;
  b=Z1huXtjmLdxBaZx+NPC/bbwrw5kxdzqZjPOsuMk7MgjeWZXIsK2rVt2H
   3gMQF3yCobT3tbFaI9RiCYj4Z4K8pdCBsNlxNOHBgCtmk0D6rmDpqBhHe
   NJ+ImapRVJTl84rKAEhtH3F/e/eNayUXqE+8wrprdRvwO8xNwEi87EhBY
   6MTcgnm//ZQCafGZxeYEr8lUCLfDQI6BKL74B6cJexoWU5SnEY+C2MZx3
   AKpKYWu0rh1/v8qctHsysh/K6r2njc3VijpfvFGu+wN5arQT16ZecgqXV
   OZbs9mfOudUNiuGFt9iU71zxt2WG0GQ1swCenu0mRKN4LrVP6DRAA9skv
   Q==;
X-CSE-ConnectionGUID: LssSXVvzT4aYGGayR6QPNA==
X-CSE-MsgGUID: nncLJP2gSga02ogZ3rYuRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="36810246"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="36810246"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 06:46:00 -0700
X-CSE-ConnectionGUID: YOBOcrmKRVaTsgZ21wdhpw==
X-CSE-MsgGUID: u8/jMZjETKGQ2/IzyrueZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="57083836"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.100])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 06:45:58 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/2] Make ELOG log and trace consistently with GHES
Date: Tue, 23 Jul 2024 15:43:45 +0200
Message-ID: <2737053.vuYhMxLoTh@fdefranc-mobl3>
In-Reply-To: <20240527144356.246220-1-fabio.m.de.francesco@linux.intel.com>
References: <20240527144356.246220-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, May 27, 2024 4:43:39=E2=80=AFPM GMT+2 Fabio M. De Francesco wrot=
e:
> When Firmware First is enabled, BIOS handles errors first and then it
> makes them available to the kernel via the Common Platform Error Record
> (CPER) sections (UEFI 2.10 Appendix N). Linux parses the CPER sections
> via one of two similar paths, either ELOG or GHES.
>=20
> Currently, ELOG and GHES show some inconsistencies in how they print to
> the kernel log as well as in how they report to userspace via trace
> events.
>=20
> Make the two mentioned paths act similarly for what relates to logging
> and tracing.

Gentle ping.
Thanks,

=46abio

> --- Changes for v1 ---
>=20
> 	- Drop the RFC prefix and restart from PATCH v1
> 	- Drop patch 3/3 because a discussion on it has not yet been
> 	  settled
> 	- Drop namespacing in export of pci_print_aer while() (Dan)
> 	- Don't use '#ifdef' in *.c files (Dan)
> 	- Drop a reference on pdev after operation is complete (Dan)
> 	- Don't log an error message if pdev is NULL (Dan)
>=20
> --- Changes for RFC v2 ---
> =09
> 	- 0/3: rework the subject line and the letter.
>         - 1/3: no changes.
>         - 2/3: trace CPER PCIe Section only if CONFIG_ACPI_APEI_PCIEAER
>           is defined; the kernel test robot reported the use of two
>           undefined symbols because the test for the config option was
>           missing; rewrite the subject line and part of commit message.
>         - 3/3: no changes.
>=20
> Fabio M. De Francesco (2):
>   ACPI: extlog: Trace CPER Non-standard Section Body
>   ACPI: extlog: Trace CPER PCI Express Error Section
>=20
>  drivers/acpi/acpi_extlog.c | 35 +++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/aer.c     |  2 +-
>  include/linux/aer.h        |  9 ++++++---
>  3 files changed, 42 insertions(+), 4 deletions(-)
>=20
>=20





