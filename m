Return-Path: <linux-pci+bounces-18329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AD19EFB75
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4DD16D60D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8FF18C002;
	Thu, 12 Dec 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/mQNjZO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54935188938;
	Thu, 12 Dec 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029329; cv=none; b=TP5BIGCaa33lr5rVTQuSUbxwZ9PReU3ovotFY5bZDluRY27i+2/m1wTADjcm4wPrEV0q+KlvQdA+hHvEDlmnwgxi8CrEgv54UbQ4ta7uVcx6fkU603/uuz0IOdLG17eCMOFCDUP0Fa68NZUvhqSmJmr/vgwvGHQSogQnQqEDqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029329; c=relaxed/simple;
	bh=2wHg5ech62f6kNP58dWuNm42eu3h+FcT06MHSXTV5lM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XyLkWp0FpxfdM67wCeha459cl0dRC8f8uec8DcdlMkud8c5y63tBr+1KBrWwhO9Ez1j3r4SGBypxwb8GZSZuzImD4FEFWaXrJrPp4NmVz4j0/5QY4KtVfvWHbSsACLowphzJtl1LTFw2WUjVqGyhR44yDfOnrs8siiYxe19LD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/mQNjZO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734029328; x=1765565328;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2wHg5ech62f6kNP58dWuNm42eu3h+FcT06MHSXTV5lM=;
  b=a/mQNjZOYJ9jdT92L9536/mxPidqXHeWVKyjHHrlouvBCwCaS9UCzerz
   YPobKd/savImAwKyJrdBgYRNaFIPrPmGJ4TIpGpNyf0kc0Bp2emDrHyf2
   TURALc8HOJDrcaA9UofcXuC3Zwqh+t6klA9wjRBCqZavONDSLxQEHyFQA
   rHhSgPSxmVFmywpOxPifcnNN0rYRFjg7CtRm4ufu6mA4U08pszJXXECv6
   ifCmvXzDpZenUk5c8eUw7jkEQCa7k7ca8P4qfYg80xMNzyD5INVGtcx7B
   pW+5wWBp4k48meIcAP+rpadbkeB35g6qK/SlkaKYRV0FI/FCKa7KlXFmA
   g==;
X-CSE-ConnectionGUID: FIyNuhhuS6CteEJqvJQPTQ==
X-CSE-MsgGUID: R/RckaJsR6aGtJxy2XpvHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45474145"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45474145"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 10:48:47 -0800
X-CSE-ConnectionGUID: pVSicdywTUa2jTMaz/PNGQ==
X-CSE-MsgGUID: cfYrER84RBK5Aqf03CS7jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127318593"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 10:48:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Dec 2024 20:48:38 +0200 (EET)
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 6/8] PCI: Add TLP Prefix reading into
 pcie_read_tlp_log()
In-Reply-To: <e4f907ad-ab87-ac42-7428-93e16f070f74@linux.intel.com>
Message-ID: <827acda7-26d8-f4f5-2251-befb932ebb8b@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com> <20240913143632.5277-7-ilpo.jarvinen@linux.intel.com> <20241211164904.00007a02@huawei.com> <e4f907ad-ab87-ac42-7428-93e16f070f74@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1583029406-1734029318=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1583029406-1734029318=:936
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Dec 2024, Ilpo J=E4rvinen wrote:

> On Wed, 11 Dec 2024, Jonathan Cameron wrote:
>=20
> > On Fri, 13 Sep 2024 17:36:30 +0300
> > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >=20
> > > pcie_read_tlp_log() handles only 4 Header Log DWORDs but TLP Prefix L=
og
> > > (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.
> > >=20
> > > Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
> > > TLP Prefix Log. The relevant registers are formatted identically in A=
ER
> > > and DPC Capability, but has these variations:
> > >=20
> > > a) The offsets of TLP Prefix Log registers vary.
> > > b) DPC RP PIO TLP Prefix Log register can be < 4 DWORDs.
> > >=20
> > > Therefore callers must pass the offset of the TLP Prefix Log register
> > > and the entire length to pcie_read_tlp_log() to be able to read the
> > > correct number of TLP Prefix DWORDs from the correct offset.
> > >=20
> > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
> > Trivial comments below
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Would have been nice if they'd just made the formats have the
> > same sized holes etc!
>=20
> That's not even the worst problem.
>=20
> They managed to copy-paste most of the stuff into DPC (copy-paste is=20
> really obvious because the text still refers to AER in a DPC section :-))=
=20
> but forgot to add a few capability fields into the DPC capability, most=
=20
> importantly, the bit that indicates whether TLP was logged in Flit mode
> or not And now we get to keep the pieces how to interpret the Log=20
> Registers (relates to the follow up series). :-(
>=20
> > > diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> > > index 65ac7b5d8a87..def9dd7b73e8 100644
> > > --- a/drivers/pci/pcie/tlp.c
> > > +++ b/drivers/pci/pcie/tlp.c
> > > @@ -11,26 +11,65 @@
> >=20
> > >  /**
> > >   * pcie_read_tlp_log - read TLP Header Log
> > Maybe update this to read TLP Header and Prefix Logs
> > >   * @dev: PCIe device
> > >   * @where: PCI Config offset of TLP Header Log
> > > + * @where2: PCI Config offset of TLP Prefix Log
> >=20
> > Is it worth giving it a more specific name than where2?
> > Possibly renaming where as well!
>=20
> Sure, why not.

Hi again,

After doing this rename, I rebased the Flit mode series on top of it and
realized there's one small problem with naming where2. It will be=20
overloaded between TLP Prefix Log (Non-Flit mode) and extended TLP Header=
=20
Log (DW5+) (Flit mode) so I'm not sure if there's really going to be a=20
good name for it.

--=20
 i.

--8323328-1583029406-1734029318=:936--

