Return-Path: <linux-pci+bounces-35887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B0DB52C6D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 11:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD283AD456
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC6F2E7185;
	Thu, 11 Sep 2025 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CN731Js3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4721D8DFB;
	Thu, 11 Sep 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581210; cv=none; b=LoTF8iWZ7fy5Pj2cdeZhsyQ9PY0QUvQ5B0M0gy8rUsWUbHqAce8caTbWVkoXrNqWo0TI+zTxeMVTjjzXqgo1xZEbuNfzY34VEWSG5chmiQuRHMG/ZVAffHq7s8pPGbglV0VYMmutxpVMmOar8MSgvJUKbrPNOfAT0vaM0Wf+Z90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581210; c=relaxed/simple;
	bh=apxpL+JA5234BjF+vbBSUV5l8bBfl2JCXGsBGUN2Sww=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zyc6wszwCSkuSPqmdKy++GKILcQu/YHv9UZDX3kEsckG3eeCCikgPsUXBei4DLMVrhRz9jxYq2Wnb8f6C5gvZAKDelxx1aJDLS/kcWs5XCmXL357Lhg622aCMk1IOUZ8wViCwflN++kl2ZfkXp3RJDsfegmP7vd6wTtA21wKJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CN731Js3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757581209; x=1789117209;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=apxpL+JA5234BjF+vbBSUV5l8bBfl2JCXGsBGUN2Sww=;
  b=CN731Js3kiHGhOxf+CyNtov06/vfZ5YPLbKQGqE/m3J1C15vEJu33W3a
   CNLhez96zaQokVhxVvYWu33EPqdIjLTbCfhxL1zKFBeD86I5295TWbmuJ
   FEN8EHckskKlCcm5ecXwBE3MOaueS8NiCTn8We/vF7AwWeM35K1RphhOS
   PdVnJQDBQKxFq79X0g3Pa+6TwWjKnSBb0u2Na75OEhCB03KrpInp+GUfg
   wH2Ddx/YclPrQ6olhBNf33aDEoOal60qAuM1gqoq5I6VeEgw3TcSwa1l8
   cNdPH0TmW2pii/I9yTFmFIseb+7KLkgOgVWoqi7uCZfUJZuq5rQ4UfAEO
   g==;
X-CSE-ConnectionGUID: y6YRnXHfREGMOA60rEi+VQ==
X-CSE-MsgGUID: M7ff5+1HST66WCvZHBNMRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59980857"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="59980857"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 02:00:08 -0700
X-CSE-ConnectionGUID: DK3xpkOuRkutGbdOlc8uZg==
X-CSE-MsgGUID: S0y7rLfnSaGwSUn6CKkovA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="173539949"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.187])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 02:00:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Sep 2025 11:59:58 +0300 (EEST)
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
    David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
    intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    Jani Nikula <jani.nikula@linux.intel.com>, 
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
    Tvrtko Ursulin <tursulin@ursulin.net>, 
    ?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 04/11] PCI: Improve Resizable BAR functions kernel doc
In-Reply-To: <97f8d4a7-6897-4fe5-878c-c04a887cce62@amd.com>
Message-ID: <20c3a5f5-fa15-3889-3f56-20726aa3925b@linux.intel.com>
References: <20250911075605.5277-1-ilpo.jarvinen@linux.intel.com> <20250911075605.5277-5-ilpo.jarvinen@linux.intel.com> <97f8d4a7-6897-4fe5-878c-c04a887cce62@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-183604244-1757581198=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-183604244-1757581198=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Sep 2025, Christian K=C3=B6nig wrote:

> On 11.09.25 09:55, Ilpo J=C3=A4rvinen wrote:
> > Fix the copy-pasted errors in the Resizable BAR handling functions
> > kernel doc and generally improve wording choices.
> >=20
> > Fix the formatting errors of the Return: line.
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/rebar.c | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
> > index 020ed7a1b3aa..64315dd8b6bb 100644
> > --- a/drivers/pci/rebar.c
> > +++ b/drivers/pci/rebar.c
> > @@ -58,8 +58,9 @@ void pci_rebar_init(struct pci_dev *pdev)
> >   * @bar: BAR to find
> >   *
> >   * Helper to find the position of the ctrl register for a BAR.
> > - * Returns -ENOTSUPP if resizable BARs are not supported at all.
> > - * Returns -ENOENT if no ctrl register for the BAR could be found.
> > + *
> > + * Return: %-ENOTSUPP if resizable BARs are not supported at all,
> > + *=09   %-ENOENT if no ctrl register for the BAR could be found.
> >   */
> >  static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
> >  {
> > @@ -92,12 +93,15 @@ static int pci_rebar_find_pos(struct pci_dev *pdev,=
 int bar)
> >  }
> > =20
> >  /**
> > - * pci_rebar_get_possible_sizes - get possible sizes for BAR
> > + * pci_rebar_get_possible_sizes - get possible sizes for Resizable BAR
> >   * @pdev: PCI device
> >   * @bar: BAR to query
> >   *
> >   * Get the possible sizes of a resizable BAR as bitmask defined in the=
 spec
> > - * (bit 0=3D1MB, bit 31=3D128TB). Returns 0 if BAR isn't resizable.
> > + * (bit 0=3D1MB, bit 31=3D128TB).
> > + *
> > + * Return: A bitmask of possible sizes (0=3D1MB, 31=3D128TB), or %0 if=
 BAR isn't
> > + *=09   resizable.
> >   */
> >  u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
> >  {
> > @@ -121,12 +125,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *=
pdev, int bar)
> >  EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
> > =20
> >  /**
> > - * pci_rebar_get_current_size - get the current size of a BAR
> > + * pci_rebar_get_current_size - get the current size of a Resizable BA=
R
> >   * @pdev: PCI device
> > - * @bar: BAR to set size to
> > + * @bar: BAR to get the size from
> >   *
> > - * Read the size of a BAR from the resizable BAR config.
> > - * Returns size if found or negative error code.
> > + * Reads the current size of a BAR from the Resizable BAR config.
> > + *
> > + * Return: BAR Size if @bar is resizable (bit 0=3D1MB, bit 31=3D128TB)=
, or
>=20
> This is a bit misleading since there is no mask returned but rather the=
=20
> order or in other words which bit of the mask was used.=20

Thanks for noticing this. I'll removed "bit" x2 from it, does that fully=20
address your concern?

--=20
 i.

> > + *=09   negative on error.
> >   */
> >  int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
> >  {
> > @@ -142,13 +148,14 @@ int pci_rebar_get_current_size(struct pci_dev *pd=
ev, int bar)
> >  }
> > =20
> >  /**
> > - * pci_rebar_set_size - set a new size for a BAR
> > + * pci_rebar_set_size - set a new size for a Resizable BAR
> >   * @pdev: PCI device
> >   * @bar: BAR to set size to
> > - * @size: new size as defined in the spec (0=3D1MB, 31=3D128TB)
> > + * @size: new size as defined in the PCIe spec (0=3D1MB, 31=3D128TB)
> >   *
> >   * Set the new size of a BAR as defined in the spec.
> > - * Returns zero if resizing was successful, error code otherwise.
> > + *
> > + * Return: %0 if resizing was successful, or negative on error.
> >   */
> >  int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
> >  {
>=20
--8323328-183604244-1757581198=:944--

