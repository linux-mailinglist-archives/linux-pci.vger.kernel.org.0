Return-Path: <linux-pci+bounces-12510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEAD96618E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 14:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB561F281C3
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172419ABAE;
	Fri, 30 Aug 2024 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJex0kCn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97D19ABAC;
	Fri, 30 Aug 2024 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020617; cv=none; b=gW0g9vm9AAPeskCC6JeMgglXZtMX6jOpz6MUf/pVRLRXwe6hayLHlI9sGD1VXXAYmManAKT552dCSDvrnMQsuqYcprF7floT6zJq+EzpDgA5FILGcjfjbS+sQ2PJMMNz7f1s705vVHnlfa336EJIeySFoaXYzGlEGa0Urba3zqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020617; c=relaxed/simple;
	bh=cxrQeFVCyW/V+8awK9/tTd4oB2KNPfWEV4kRyotwVsU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gJVNlcP95QkAVwD9cd7WO0HWEEGNmYe9rBvRorl2tYgK6leU/SmG96zMfGJBXmV8oUT8Gh/FQ7QI19ann4Anf2qN93XNZi2wjV/qb4N5Y5xrNThCpyTIVSeGMswOxtK0Gf/uYKII8yYyfqpY7FjJTll8abbEIYbbIZfN0N2bYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJex0kCn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725020617; x=1756556617;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cxrQeFVCyW/V+8awK9/tTd4oB2KNPfWEV4kRyotwVsU=;
  b=ZJex0kCnJz6gqfJKCbZjt5UBDlOWImjjgAi3wXtAYiJ8liiLB12AP6fD
   1wv4EaSHQSmobMPV/jQCGe9ePHmq5RCMbPA1zMqvTIMSDHLe6FqxkTL9v
   7+vxTw+oTyMm2d0r68RCfyOwSm3BtzMs24LFLk6Du49AZY9oV8ZyxAHxf
   nCYtavW2OUKBE5suK/izd1xbPYNdNtzHIQcXDd/zjjM9Fdz9rk1hXet2F
   ny2BODgScsas9WJ42cRawpnoYf0vbu9CqSpfBvfhMW0ESTBmQh/tsTQzw
   D19/PjjmiF0yUydnsEi47/Ld50CRZAQnWujDHVgoBXlJQ3cAqAYB8AFtk
   Q==;
X-CSE-ConnectionGUID: mUmqHuP5SFSmKhS00cvecg==
X-CSE-MsgGUID: 3YCGlbEXQje3LrHVVqmcZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27422922"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="27422922"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 05:23:36 -0700
X-CSE-ConnectionGUID: d/hHSfZ2SOKCjMdhZ5I6EQ==
X-CSE-MsgGUID: NGJStJN1Sn6X9IfbN8Sc8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="68033775"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 05:23:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Aug 2024 15:23:28 +0300 (EEST)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>, 
    linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] PCI: Consolidate TLP Log reading and printing
In-Reply-To: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <076a7814-1ab9-a6a1-6b08-3f414595c6ba@linux.intel.com>
References: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1575701497-1725020608=:1027"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1575701497-1725020608=:1027
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 May 2024, Ilpo J=C3=A4rvinen wrote:

> This series has the remaining patches of the AER & DPC TLP Log handling
> consolidation and now includes a few minor improvements to the earlier
> accepted TLP Logging code.
>=20
> v5:
> - Fix build with AER=3Dy and DPC=3Dn
> - Match kerneldoc and function parameter name

Hi Bjorn,

A gentle reminder, could you take a look at this series (and perhaps also=
=20
the one which introduces the Flit mode support on top of this series).

--=20
 i.

> v4:
> - Added patches:
> =09- Remove EXPORT of pcie_read_tlp_log()
> =09- Moved code to pcie/tlp.c and build only with AER enabled
> =09- Match variables in prototype and function
> =09- int -> unsigned int conversion
> =09- eetlp_prefix_max into own patch
> - struct pcie_tlp_log param consistently called "log" within tlp.c
> - Moved function prototypes into drivers/pci/pci.h
> - Describe AER/DPC differences more clearly in one commit message
>=20
> v3:
> - Small rewording in a commit message
>=20
> v2:
> - Don't add EXPORT()s
> - Don't include igxbe changes
> - Don't use pr_cont() as it's incompatible with pci_err() and according
>   to Andy Shevchenko should not be used in the first place
>=20
> Ilpo J=C3=A4rvinen (7):
>   PCI: Don't expose pcie_read_tlp_log() outside of PCI subsystem
>   PCI: Move TLP Log handling to own file
>   PCI: Make pcie_read_tlp_log() signature same
>   PCI: Use unsigned int i in pcie_read_tlp_log()
>   PCI: Store # of supported End-End TLP Prefixes
>   PCI: Add TLP Prefix reading into pcie_read_tlp_log()
>   PCI: Create helper to print TLP Header and Prefix Log
>=20
>  drivers/pci/ats.c             |   2 +-
>  drivers/pci/pci.c             |  28 ---------
>  drivers/pci/pci.h             |   9 +++
>  drivers/pci/pcie/Makefile     |   2 +-
>  drivers/pci/pcie/aer.c        |  14 ++---
>  drivers/pci/pcie/dpc.c        |  14 ++---
>  drivers/pci/pcie/tlp.c        | 109 ++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c           |  14 +++--
>  include/linux/aer.h           |   3 +-
>  include/linux/pci.h           |   2 +-
>  include/uapi/linux/pci_regs.h |   2 +
>  11 files changed, 143 insertions(+), 56 deletions(-)
>  create mode 100644 drivers/pci/pcie/tlp.c
>=20
>=20
--8323328-1575701497-1725020608=:1027--

