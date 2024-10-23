Return-Path: <linux-pci+bounces-15102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FFC9AC18F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 10:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26FC1F24454
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDE0158DA3;
	Wed, 23 Oct 2024 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xxu8n6oc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FEF158853;
	Wed, 23 Oct 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672044; cv=none; b=p846ijfeLP2nHb+tGp55viME3M+G/Pgn9TLwsPKJS54qvhN9mmfOhbY7oc3h3LuQEqK5LODODUU4mhMuneyPAPd3FUk5ud5HDBVDHCW8TocM7oNxQBh5U9JmJ5EEA6r8p2Sm6lSy1jWQTjeEvy0WpYGNGZVqSbCrK7PJOyzHC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672044; c=relaxed/simple;
	bh=Efmdsy7784WWboxNzcyHMI/+dAUXMhQMYCQtnPAq+7s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yh69/sJvSzS1jWRQiiF0GGFIOGZPgySp/kBWc+Okl/emYug1e8B188Ze3ir38vvZARNX+aikEP/RkKECiYikgrxD0F6/9FKjaWVbN2bVSQlak/f9im2bMUjNZpSF9ApWws42RgcnLbi52s8b63pONZdI3uIrNDfB43WYNSlBVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xxu8n6oc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729672043; x=1761208043;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Efmdsy7784WWboxNzcyHMI/+dAUXMhQMYCQtnPAq+7s=;
  b=Xxu8n6oc18kXuCEC+xivc69D+rMrTkG/8quYKm9p0UtSwS0zyvgpG8s3
   6au+mD9IaoDX8jXVDqilFhefN79A+F7MTkCFieegWHFFG7pxwKohgGtKk
   p1RJxRsyraUUxX4CCTsVJlEzt881AsRiI8itA6T58WBccYbF+XBIDneKZ
   KZjfAr322PHnNQlLDaM0y7lqff7rScghi8OBptMbmwoNi1PYhEQA1ZOms
   440VLGE4eOBrCsZlv42PksJ1Xd6gUA65iULGx95OSKpeDsA5fJRysgyri
   CgxS1xwabKrJgjwp5+AUe4JqLRkeH4sNfrzlDCymq3e1ulFQ4GOs1A4pb
   Q==;
X-CSE-ConnectionGUID: 7bWuE50fTpqjcEVGAh072A==
X-CSE-MsgGUID: lDFY6ZH+RCu4ShNwKf/EMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="33168553"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="33168553"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:27:22 -0700
X-CSE-ConnectionGUID: IvumlnRqTX60gu5OpdbeWg==
X-CSE-MsgGUID: hseAE24qSLqbyZF66jw03w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84939400"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:27:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 23 Oct 2024 11:27:15 +0300 (EEST)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 0/8] PCI: Consolidate TLP Log reading and printing
In-Reply-To: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <cb44bafe-a7ec-889b-5c1c-ee8ca6c540a0@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1808313237-1729671934=:1168"
Content-ID: <cc279ec2-2c48-0171-1345-2b12ec189a87@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1808313237-1729671934=:1168
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <74b67500-5d3a-40fd-f220-927c23ad6df0@linux.intel.com>

On Fri, 13 Sep 2024, Ilpo J=E4rvinen wrote:

> This series has the remaining patches of the AER & DPC TLP Log handling
> consolidation and now includes a few minor improvements to the earlier
> accepted TLP Logging code.
>=20
> v6:
> - Preserve "AER:"/"DPC:" prefix on the printed TLP line
> - New patch to add "AER:" also  on other lines of the AER error dump

Hi Bjorn,

A small reminder this series exists.

--=20
 i.

> v5:
> - Fix build with AER=3Dy and DPC=3Dn
> - Match kerneldoc and function parameter name
>=20
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
> Ilpo J=E4rvinen (8):
>   PCI: Don't expose pcie_read_tlp_log() outside of PCI subsystem
>   PCI: Move TLP Log handling to own file
>   PCI: Make pcie_read_tlp_log() signature same
>   PCI: Use unsigned int i in pcie_read_tlp_log()
>   PCI: Store # of supported End-End TLP Prefixes
>   PCI: Add TLP Prefix reading into pcie_read_tlp_log()
>   PCI: Create helper to print TLP Header and Prefix Log
>   PCI/AER: Add prefixes to printouts
>=20
>  drivers/pci/ats.c             |   2 +-
>  drivers/pci/pci.c             |  28 ---------
>  drivers/pci/pci.h             |   9 +++
>  drivers/pci/pcie/Makefile     |   2 +-
>  drivers/pci/pcie/aer.c        |  26 ++++----
>  drivers/pci/pcie/dpc.c        |  14 ++---
>  drivers/pci/pcie/tlp.c        | 109 ++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c           |  14 +++--
>  include/linux/aer.h           |   3 +-
>  include/linux/pci.h           |   2 +-
>  include/uapi/linux/pci_regs.h |   2 +
>  11 files changed, 149 insertions(+), 62 deletions(-)
>  create mode 100644 drivers/pci/pcie/tlp.c
>=20
>=20
--8323328-1808313237-1729671934=:1168--

