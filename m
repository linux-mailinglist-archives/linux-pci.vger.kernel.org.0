Return-Path: <linux-pci+bounces-25508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D50CA81230
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19213BF498
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8C822D4C1;
	Tue,  8 Apr 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aB0hhlBk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FE1DD526;
	Tue,  8 Apr 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129116; cv=none; b=rNeXjq3nxyg21G0BoP2AN6ycc+IsWMzXF2B7K/dvLWMx4i/wTdMSatR+h58qRhryJW4KtQAutDUR6Cp5G72B3gBlyp6nxwrUeY3eETuwurbzQJB84y/+3EBv1ME2DNfKtkdxuCBkaynnD381DC7dTV7kLKPkVnJekG53GB9lUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129116; c=relaxed/simple;
	bh=UN+/mu1+4eP9QyP0GltuKkck23d661gKUF//Ihg+3nI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f8VdYX+8mbtkDAJNi+wxPj6JY2Kt43NoYVOoMnXyCOBFYMVQ4EKhN35DKpAY6a3ZTmUdw54oqmwbmsCzDuXo6iZ8GQBSc4tgKJ8xiQYF1UjXBba5n97A7UDSTdHgw3+L6xYM7kQL70wBlrd5fs7PmPjCa3XI1/i1Z8iGNQ3HRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aB0hhlBk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744129115; x=1775665115;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UN+/mu1+4eP9QyP0GltuKkck23d661gKUF//Ihg+3nI=;
  b=aB0hhlBk/qt0yNynrlw3jgw38mlHnXVoX9L6XxlmA6TTkwNDjI9JEtm1
   Hb/43oyjVkK6L5Bnax5SeH2+stgp4aunPqii2oGFQoAedBV9itVjtILjH
   Q0NaPMNajWiDgmkhhPfcOD3LwwBNb7t8RUG1YgK5pLdhR/ZW5VAlKAQAw
   4tqknQsgImpvyeDDQhfy5rN1oFAg18lC5sa6ycTPZtyMDffZU6nFwVSPT
   8Ngo+xjq+XBNDlhpK0vqmrvkWPLcgxuv2QAMiORsgdGbqyLNVxOYocUzl
   xe9wPRAIawCTtTjXN6PtIkJwKxTPVXQM78u+4To1dX4GhGfhHnbgqgMb7
   g==;
X-CSE-ConnectionGUID: ZXQjqVs8R5aPWp6wZ5OyJQ==
X-CSE-MsgGUID: QDtAa3CCRE2UxC3cft1e0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45461877"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="45461877"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 09:18:34 -0700
X-CSE-ConnectionGUID: dWRkYcfeR5KMJ3oWMQ8byA==
X-CSE-MsgGUID: 4NXHVb68QEuk+0MKbnR53g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133461557"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 09:18:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 8 Apr 2025 19:18:28 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com, 
    manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
In-Reply-To: <ef311715-3e61-4bf5-bdae-58fd87a3d5e7@163.com>
Message-ID: <e4db2248-ed8b-d270-d417-9efdca947e8e@linux.intel.com>
References: <20250402042020.48681-1-18255117159@163.com> <20250402042020.48681-3-18255117159@163.com> <8b693bfc-73e0-2956-2ba3-1bfd639660b6@linux.intel.com> <c6706073-86b0-445a-b39f-993ac9b054fa@163.com> <bf6f0acb-9c48-05de-6d6d-efb0236e2d30@linux.intel.com>
 <f77f60a0-72d2-4a9c-864e-bd8c4ea8a514@163.com> <ef0237d9-f5da-44d7-ab45-2be037cf0f25@163.com> <3689b121-1ff2-f0f6-59f4-293cda8ea6a8@linux.intel.com> <ef311715-3e61-4bf5-bdae-58fd87a3d5e7@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-372179522-1744129108=:930"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-372179522-1744129108=:930
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 8 Apr 2025, Hans Zhang wrote:

>=20
>=20
> On 2025/4/8 01:03, Ilpo J=C3=A4rvinen wrote:
> > > Hi Ilpo,
> > >=20
> > > The [v9 3/6]patch I plan to submit is as follows, please review it.
> > >=20
> > >  From 6da415d130e76b57ecf401f14bf0b66f20407839 Mon Sep 17 00:00:00 20=
01
> > > From: Hans Zhang<18255117159@163.com>
> > > Date: Fri, 4 Apr 2025 00:20:29 +0800
> > > Subject: [v9 3/6] PCI: Refactor capability search into common macros
> > >=20
> > > - Capability search is done both in PCI core and some controller driv=
ers.
> > > - PCI core's cap search func requires PCI device and bus structs exis=
t.
> > > - Controller drivers cannot use PCI core's cap search func as they
> > >    need to find capabilities before they instantiated the PCI device =
& bus
> > >    structs.
> > >=20
> > > - Move capability search into a macro so it can be reused where norma=
l
> > >    PCI config space accessors cannot yet be used due to lack of the
> > >    instantiated PCI dev.
> > > - Instead, give the config space reading function as an argument to t=
he
> > >    new macro.
> > > - Convert PCI core to use the new macro.
> > None of these bullets are true lists so please write them as normal
> > English paragraphs. Also please extend some of shortened words lke "cap=
"
> > --> "Capability", "PCI dev" -> PCI Device (for terms, the capitalizatio=
n
> > of the first letter, you should follow what the PCI specs use).
> >=20
>=20
> Dear Ilpo,
>=20
> Thank you very much for your reply. Is it OK to modify it like this?
>=20
> The PCI Capability search functionality is duplicated across the PCI core=
 and
> several controller drivers.  The core's current implementation
> requires fully initialized PCI device and bus structures, which prevents
> controller drivers from using it during early initialization phases befor=
e
> these structures are available.
>=20
> Move the Capability search logic into a header-based macro that accepts a
> config space accessor function as an argument.  This enables controller
> drivers to perform Capability discovery using their early access mechanis=
ms
> prior to full device initialization while maintaining the original search
> behavior.

=2E.. while maintaining ... ->

=2E.. while sharing the Capability search code.

>=20
> Convert the existing PCI core Capability search implementation to use thi=
s new
> macro

I think the rest of this paragraph after this are unnecessary.

> , eliminating code duplication. The refactoring preserves the original
> functionality without behavioral changes, while allowing both the core an=
d
> drivers to share common Capability discovery logic.

Other than that, it seemed good enough for me.

--=20
 i.

> > > The macros now implement, parameterized by the config access method. =
The
> > > PCI core functions are converted to utilize these macros with the sta=
ndard
> > > pci_bus_read_config accessors. Controller drivers can later use the s=
ame
> > > macros with their early access mechanisms while maintaining the exist=
ing
> > > protection against infinite loops through preserved TTL checks.
> > >=20
> > > The ttl parameter was originally an additional safeguard to prevent
> > > infinite loops in corrupted config space.  However, the
> > > PCI_FIND_NEXT_CAP_TTL macro already enforces a TTL limit internally.
> > > Removing redundant ttl handling simplifies the interface while mainta=
ining
> > > the safety guarantee. This aligns with the macro's design intent of
> > > encapsulating TTL management.
> > >=20
> > > Signed-off-by: Hans Zhang<18255117159@163.com>
> > > ---
> > >   drivers/pci/pci.c | 70 +++++---------------------------------
> > >   drivers/pci/pci.h | 86 ++++++++++++++++++++++++++++++++++++++++++++=
+++
> > >   2 files changed, 95 insertions(+), 61 deletions(-)
>=20
--8323328-372179522-1744129108=:930--

