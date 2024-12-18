Return-Path: <linux-pci+bounces-18699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C2F9F685F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD4918931CD
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363D61C2325;
	Wed, 18 Dec 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chvdzgvx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8023270819;
	Wed, 18 Dec 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531902; cv=none; b=tuoH6c+Yi8SXV2CqoXEAu0MY65B1fGM7mbpv9M53vrP1baqpxvCyELdb05s+BrATkPQO6N9CcrYBJJv6w3QFOyyghVieRcePY+qSG0nNavaaZnfKSHKEyJW1agtRtSWfCHhLSzkDpWLodwOttmK6K7bhr0olVXF9aw9IfVpLRqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531902; c=relaxed/simple;
	bh=jXV7XyJRmu6HSpyyngB1vqa+GMDUyf2VJ19KpM94/gU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QpOpySKcAiQ5doXyuuf0p0FVSi7h2zHy4w32TrZbCKUP4ybsiD2mej/U0yGHl7bpMDcfXhNWNY4sY5+jY7p0P+VOPLN5LamrIPM2JVT+rFszm69DdsNN0Jhwd8ckWSojIQbvUCn/VMn6sUZiVTnugzDH0X0JUNHGFaHs1JfsF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chvdzgvx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734531901; x=1766067901;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=jXV7XyJRmu6HSpyyngB1vqa+GMDUyf2VJ19KpM94/gU=;
  b=chvdzgvx1EcQf8OWC7kFicO2U8l8Jxm1O/zSrHLd6vjyXrOv8i9u6OeK
   aFkjuiYsS5bRScK55LsJpqiKaIzDqIwuEs5MpVgDL7wDzkLi/90rPDcj5
   pCPP5IRvOMulZ/ENQ+WzBgIrQZ2/qZ0oNsDZ4+9SCooeKim+taUSxN9j1
   KmbyvhtyPDt9D/0MfxtDk2vr2X6PiIcC49ZheHGH6IWcmRKFJy3waEQ//
   f5h503gPJrZ3uKA/6BgLIOeh0nYtj+xnK7bVD16o/TUl4YHIIkBFwa2dG
   cJcufanjveSr0hU9GY5UfHrdQnOXzi2g6Qges3/O9BI+xj5YnYRnZf/S/
   w==;
X-CSE-ConnectionGUID: YHPtWxDoQOWb9040rwSWOw==
X-CSE-MsgGUID: rebR7kzMRLWjxUYxtHJiEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="38685438"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="38685438"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:25:00 -0800
X-CSE-ConnectionGUID: RHbH0LbbQEKEF3SQ2pyDSw==
X-CSE-MsgGUID: 9XnzB4UkSN2aOMnrmYKyFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98696671"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.138])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:24:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Dec 2024 16:24:53 +0200 (EET)
To: Yazen Ghannam <yazen.ghannam@amd.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Lukas Wunner <lukas@wunner.de>, Borislav Petkov <bp@alien8.de>, 
    linux-edac@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/3] PCI: Add support for logging Flit Mode TLPs
 (PCIe6)
In-Reply-To: <20241217214929.GA1121691@yaz-khff2.amd.com>
Message-ID: <bbd52a2b-a97f-7825-c271-0f470b75df1b@linux.intel.com>
References: <20240614150921.29724-1-ilpo.jarvinen@linux.intel.com> <20241217214929.GA1121691@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-666698470-1734529599=:939"
Content-ID: <57976c77-cac9-bb7b-8590-a5b03a24285f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-666698470-1734529599=:939
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e7996e2e-a4e3-0dc0-b045-a62823a48f7a@linux.intel.com>

On Tue, 17 Dec 2024, Yazen Ghannam wrote:

> On Fri, Jun 14, 2024 at 06:09:18PM +0300, Ilpo J=E4rvinen wrote:
> > This series adds support for Flit Mode (PCIe6). The series is built on
> > top of the TLP Logging refactoring series:
> >=20
> >   https://lore.kernel.org/linux-pci/20240514113109.6690-1-ilpo.jarvinen=
@linux.intel.com/
> >=20
> > Important note to maintainer: The series carries
> > pcie_update_link_speed() refactoring change that is almost identical
> > with a patch in the PCIe BW controller series. The patch itself is
> > basically the same but the context has minor difference. This will need
> > to be considered if applying both series within the same kernel cycle.
> >=20
> > Ilpo J=E4rvinen (3):
> >   PCI: Refactor pcie_update_link_speed()
> >   PCI: Track Flit Mode Status & print it with link status
> >   PCI: Handle TLP Log in Flit mode
> >=20
> >  drivers/pci/hotplug/pciehp_hpc.c |  5 +--
> >  drivers/pci/pci.c                | 12 ++++---
> >  drivers/pci/pci.h                | 13 ++++++--
> >  drivers/pci/pcie/aer.c           |  4 ++-
> >  drivers/pci/pcie/dpc.c           | 23 ++++++++++---
> >  drivers/pci/pcie/tlp.c           | 57 ++++++++++++++++++++++----------
> >  drivers/pci/probe.c              | 13 +++++---
> >  include/linux/aer.h              | 13 ++++++--
> >  include/linux/pci.h              |  1 +
> >  include/ras/ras_event.h          | 12 +++----
> >  include/uapi/linux/pci_regs.h    |  6 +++-
> >  11 files changed, 112 insertions(+), 47 deletions(-)
>
> Is there any new development on this feature? Or is it on hold while any
> spec oversights are worked out in the PCI-SIG?

As far as I know, the series is not on hold. It just tends to take time=20
from Bjorn to get patches applied (and I don't want to pressure=20
maintainers with frequent pings). But I think it might help if you would=20
kindly review the patches. :-)

And of course this series depends on the TLP cleanup series that has to=20
be applied first (but hopefully that happens soon enough).

When it comes to the spec oversight, we concluded with Lukas Wunner that=20
even if DPC capability would eventually get a flag to indicate in which=20
mode the TLP was logged we cannot assume the flags is always there. Thus,=
=20
this link Flit mode status tracking has to be done anyway. I know it's not=
=20
ideal because at least in theory the state kept by the kernel could be=20
stale but there seems to no way around that given how the spec is.

--=20
 i.
--8323328-666698470-1734529599=:939--

