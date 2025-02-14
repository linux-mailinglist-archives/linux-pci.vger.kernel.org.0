Return-Path: <linux-pci+bounces-21450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B58A35D29
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 12:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A26B188917E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695A263F36;
	Fri, 14 Feb 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jmqh6xRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30281263C70;
	Fri, 14 Feb 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534012; cv=none; b=J4+n7yDGpgYMQftQMRTcmm9U9eTmwp7XhIBWBV/m2B3p7GhnjPv+R0Bb+AxXQCaF7zf7uNemVW0EFn0vaj+nxKNCBvqb8clbkNts/J6u1XwRYh/7zhCfKF56fiwbbbJC81s2QnggieaVlVRHe1rbkrx/EhHF0Z5roY1RpEkQLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534012; c=relaxed/simple;
	bh=hN7mZgtRYM62uyhk4JMKAzreBpJR0Dk7bnADcpzizR0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fjYszt6TY2+B9UI2k58+fCx52ecreD7SZFOImN9zfOSgUNz9FnPPBmxKiPRr7rREzhgQEIz1guJd7gjHAlZXqRSBN3vUsCYxx/ALbkObLlvOOptMuxSgEhmXCZ9S69ASzkCpy1RIbFcMJdq1QBjU2vRoL4SXT8Mg1qAHfoIFghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jmqh6xRt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739534011; x=1771070011;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=hN7mZgtRYM62uyhk4JMKAzreBpJR0Dk7bnADcpzizR0=;
  b=Jmqh6xRtM1cJwEP+YvTn7aKxxI31CDsJu7INqYZIgovBQ5HESmdDuLNA
   FrNjNzKj1MK39fxB+LW/grNFu5xa6DfuwrheUzhmubUJTPqbjMajzeJiT
   t+AU9DNflVDkhcoTwEgACQV9ezjHGTy5/GaDxK0CVAqAsMCV+vp2jbuZx
   SWOIDwtHL7mtnOwnHM7N/1BaKeLLPIL3x0QK0K8qIB1fqJEpBFVfsDU04
   OVBUCVAgQJs/ivZVWsD8G9kV2dzU40GJZIOWpp3hO6FBhofE736M1uz2R
   CG50T0OI0qSFNwLknMnN5TwgsHaGXcmRq56lu3XpfGAUIQlGLbp20ryec
   w==;
X-CSE-ConnectionGUID: mh9yYuMCRq2P5b7wsewgYg==
X-CSE-MsgGUID: Cceq7gVvQBS2ZBM4VocUng==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="51679753"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="51679753"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 03:53:30 -0800
X-CSE-ConnectionGUID: Gh/agrcXSm2sfpwTTwEm+w==
X-CSE-MsgGUID: MVsxA/2oT4yJy0AuhPpGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="113629564"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.228])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 03:53:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Feb 2025 13:53:24 +0200 (EET)
To: "=?ISO-2022-JP?Q?Xiaochun_XC17_Li_|_=1B$BM{=3E=2E=3DU=1B=28J_Xav?=
 =?ISO-2022-JP?Q?ier?=" <lixc17@lenovo.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH 00/25] PCI: Resource fitting/assignment fixes and
 cleanups
In-Reply-To: <SEYPR03MB68778FC6609C967F1C05F556BCFE2@SEYPR03MB6877.apcprd03.prod.outlook.com>
Message-ID: <dc575157-ab4b-c287-2ba5-b277aeb8c5ef@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <SEYPR03MB68778FC6609C967F1C05F556BCFE2@SEYPR03MB6877.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-213667712-1739533528=:944"
Content-ID: <391af4c5-15d1-1c66-28c7-b1eb4fdd9001@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-213667712-1739533528=:944
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <543eb919-2d99-5aae-daf8-5483861fb8bf@linux.intel.com>

Hi Bjorn,

Can you please add to the last patch of the series:

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219547

=2E..And also Xiaochun's tested by tag from below to the series.

On Fri, 14 Feb 2025, Xiaochun XC17 Li | =E6=9D=8E=E5=B0=8F=E6=98=A5 Xavier =
wrote:
> On Mon, Dec 16, 2024 at 7:56:45PM +0200 Ilpo J=C3=A4rvinen <ilpo.jarvinen=
@linux.intel.com> wrote:
> > From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
> > Hi all,
> >=20
> > This series focuses on PCI resource fitting and assignment algorithms.
> > I've further changes in works to enable handling resizable BARs better =
during
> > resource fitting built on top of these, but that's still WIP and this s=
eries seems
> > way too large as is to have more stuff included.
> >=20
> > First there are small tweaks and fixes to the relaxed tail alignment co=
de and
> > applying the lessons learned to other similar cases. They are sort of
> > independent of the rest. Then a large set of pure cleanups and refactor=
ing that
> > are not intended to make any functional changes.
> > Finally, starting from "PCI: Extend enable to check for any optional re=
source" are
> > again patches that aim to make behavioral changes to fix bridge window =
sizing
> > to consider expansion ROM as an optional resource (to fix a remove/resc=
an
> > cycle issue) and improve resource fitting algorithm in general.
> >=20
> > The series includes one of the change from Micha=C5=82 Winiarski
> > <michal.winiarski@intel.com> as these changes also touch the same IOV c=
hecks.
> >=20
> > Please let me know if you'd prefer me to order the changes differently =
or split it
> > into smaller chunks.
> >=20
> >=20
> > I've extensively tested this series over the hosts in our lab which hav=
e quite
> > heterogeneous PCI setup each. There were no losses of any important res=
ource.
> > Without pci=3Drealloc, there's some churn in which of the disabled expa=
nsion
> > ROMs gets a scarce memory space assigned (with pci=3Drealloc, they are =
all
> > assigned large enough bridge window).
> >=20
> >=20
> > Ilpo J=C3=A4rvinen (24):
> >   PCI: Remove add_align overwrite unrelated to size0
> >   PCI: size0 is unrelated to add_align
> >   PCI: Simplify size1 assignment logic
> >   PCI: Optional bridge window size too may need relaxing
> >   PCI: Fix old_size lower bound in calculate_iosize() too
> >   PCI: Use SZ_* instead of literals in setup-bus.c
> >   PCI: resource_set_range/size() conversions
> >   PCI: Check resource_size() separately
> >   PCI: Add pci_resource_num() helper
> >   PCI: Add dev & res local variables to resource assignment funcs
> >   PCI: Converge return paths in __assign_resources_sorted()
> >   PCI: Refactor pdev_sort_resources() & __dev_sort_resources()
> >   PCI: Use while loop and break instead of gotos
> >   PCI: Rename retval to ret
> >   PCI: Consolidate assignment loop next round preparation
> >   PCI: Remove wrong comment from pci_reassign_resource()
> >   PCI: Add restore_dev_resource()
> >   PCI: Extend enable to check for any optional resource
> >   PCI: Always have realloc_head in __assign_resources_sorted()
> >   PCI: Indicate optional resource assignment failures
> >   PCI: Add debug print when releasing resources before retry
> >   PCI: Use res->parent to check is resource is assigned

I also noticed there's a typo here, should be "if resource is assigned"

My apologies for the extra work.

> >   PCI: Perform reset_resource() and build fail list in sync
> >   PCI: Rework optional resource handling
> >=20
> > Micha=C5=82 Winiarski (1):
> >   PCI: Add a helper to identify IOV resources
> >=20
> >  drivers/pci/pci.h       |  44 +++-
> >  drivers/pci/setup-bus.c | 566 +++++++++++++++++++++++-----------------
> >  drivers/pci/setup-res.c |   8 +-
> >  3 files changed, 364 insertions(+), 254 deletions(-)
> >=20
> Hi, all
> This series has undergone testing on the following configurations:
> - Lenovo ThinkSystem SR630 V4 equipped with Intel Granite Rapids CPUs.
> - The latest upstream kernel v6.14-rc2 and the stable kernel 6.13.2.
> - With "pci=3Drealloc" appended to the kernel command line.
> - Red Hat Enterprise Linux 10.0 Beta.
>=20
> Test results:
> - All patches were applied cleanly and the build process was successful.
> - The assignment for the ROM BAR of downstream devices was successful.
> - The bridge window has been adjusted to fit the downstream resources.
>=20
> Tested-by: Xiaochun Lee <lixc17@lenovo.com>


--=20
 i.
--8323328-213667712-1739533528=:944--

