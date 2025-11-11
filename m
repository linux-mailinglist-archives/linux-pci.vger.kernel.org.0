Return-Path: <linux-pci+bounces-40906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CA6C4E00B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 14:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2662189467B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7183AA193;
	Tue, 11 Nov 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSWWGVqK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE83AA18E;
	Tue, 11 Nov 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865781; cv=none; b=CABNKxKS53yZAkNP1MCBAHKqpylzY6OECotN820+dvRyTZ/vDx1f5c8RKB2X/t5hi2AwvfQw6o3kclP41RUIARI3svNZStsTqwHKQY26llFjJkF9s/ZcagFxBpXMiqtn7/FnuWsmaMh3ghiiLiw7DCgWDTsZn2MgHT1cfzOR4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865781; c=relaxed/simple;
	bh=tYmwcEpqhSpJ8/13glHHz0gQnoOkzoz9NCAxE9NNs+0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HDsbgNol+NEdwiJErQ3pupIuNLtzRfBNzu+VYvBY29HNjkgNJwqF5DxPuO39JxDeZE/9NIeakJF4rG8oBCJkatnH6h15Z0+TOZ8YsfypGxhTCTiFFAqGDC0HXeZQAZ2fnoixpI6EBKL2mZhPz1W0E4ymmK70GieNdvcL6U7beWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSWWGVqK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762865780; x=1794401780;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tYmwcEpqhSpJ8/13glHHz0gQnoOkzoz9NCAxE9NNs+0=;
  b=eSWWGVqKG81OSmoPNEBgLAHUUzEUrBy9NfgERfE2ENmI9vHJj94dOf3y
   pdxVvCYslQGKA2JlMMfmhk5UX4ZjpNVM2zxVrISxOMnKVkwBvUT0MPnIO
   wLzdeqGkqTfBqvoz+jH7KjThlZZTqBWp5mV2a5AA4iMI44ra6AEYOEbB6
   W19H9UT/EmpfDLMMP8oZZpb1zp/kdi18LrDApSRY44kSR81VfNxDpSRBb
   2AVly6asHlMzZg0dnCs4qa5Tait2ccmCiUfsE4xoOR4DsoKa1TJBFkYo5
   rGK+vOPflfqD5f0C3Fznszn9MPH+ynTGWgedK80iCQ2d1Q1BuIT2BBsRZ
   A==;
X-CSE-ConnectionGUID: nzkOCL/ZQxCI5OeGHIMBpg==
X-CSE-MsgGUID: sWK4RIJFRO6oGIqU2ll/Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="67528496"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="67528496"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 04:56:19 -0800
X-CSE-ConnectionGUID: jISM+GLBR+yOLfpapJDzAw==
X-CSE-MsgGUID: 2UVgfDcCQJG9DLpbWnS1AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193067751"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.132])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 04:56:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 11 Nov 2025 14:56:08 +0200 (EET)
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
    Simon Richter <Simon.Richter@hogyros.de>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
    Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@gmail.com>, 
    dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
    intel-xe@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
    linux-pci@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] drm/amdgpu: Remove driver side BAR release before
 resize
In-Reply-To: <fd7fdf61-cb08-4dfc-ba7a-a8a5b7eb9fda@amd.com>
Message-ID: <10b095b5-f433-3bfc-c1c9-5da7db560696@linux.intel.com>
References: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com> <20251028173551.22578-9-ilpo.jarvinen@linux.intel.com> <c90f155f-44fe-4144-af68-309531392d22@amd.com> <aaaf27cf-5de0-c4ef-0758-59849878a99f@linux.intel.com>
 <fd7fdf61-cb08-4dfc-ba7a-a8a5b7eb9fda@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2137640066-1762865768=:1002"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2137640066-1762865768=:1002
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 11 Nov 2025, Christian K=C3=B6nig wrote:

> On 11/11/25 12:08, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 11 Nov 2025, Christian K=C3=B6nig wrote:
> >=20
> >> Sorry for the late reply I'm really busy at the moment.
> >>
> >> On 10/28/25 18:35, Ilpo J=C3=A4rvinen wrote:
> >>> PCI core handles releasing device's resources and their rollback in
> >>> case of failure of a BAR resizing operation. Releasing resource prior
> >>> to calling pci_resize_resource() prevents PCI core from restoring the
> >>> BARs as they were.
> >>
> >> I've intentionally didn't do it this way because at least on AMD HW we=
=20
> >> could only release the VRAM and doorbell BAR (both 64bit), but not the=
=20
> >> register BAR (32bit only).
> >>
> >> This patch set looks like the right thing in general, but which BARs a=
re=20
> >> now released by pci_resize_resource()?
> >>
> >> If we avoid releasing the 32bit BAR as well then that should work,=20
> >> otherwise we will probably cause problems.
> >=20
> > After these changes, pci_resize_resource() releases BARs that share the=
=20
> > bridge window with the BAR to be resized. So the answer depends on the=
=20
> > upstream bridge.
> >=20
> > However, amdgpu_device_resize_fb_bar() also checks that root bus has a
> > resource with a 64-bit address. That won't tell what the nearest bridge=
=20
> > has though. Maybe that check should be converted to check the resources=
 of=20
> > the nearest bus instead? It would make it impossible to have the=20
> > 32-bit resource share the bridge window with the 64-bit resources so th=
e=20
> > resize would be safe.
>=20
> Mhm, I don't think that will work.
>=20
>=20
> I've added the check for the root bus to avoid a couple of issues during=
=20
> resize, but checking the nearest bridge would block a whole bunch of use=
=20
> cases and isn't even 100% save.
>=20
> See one use case of this is that all the BARs of the device start in the=
=20
> same 32bit bridge window (or a mixture of 64bit and 32bit window).

"32bit bridge window" is ambiguous. There are non-prefetchable and=20
prefetchable bridge windows, out of which the latter can be 64-bit as=20
well. Which one you're talking about?

If a 64-bit prefetchable window exists, pbus_size_mem() nor=20
__pci_assign_resource() would not have produced such a configuration where=
=20
they're put into the same bridge window, even before the commit=20
ae88d0b9c57f ("PCI: Use pbus_select_window_for_type() during mem window=20
sizing") (I think). Now pbus_size_mem() certainly doesn't.

> What we have is that BAR 0 and 2 are 64bit BARs which can (after some=20
> preparation) move around freely. But IIRC BAR 4 are the legacy I/O ports=
=20
> and BAR 5 is the 32bit MMIO registers (don't nail me on that, could be=20
> just the other way around).
>
> Especially that 32bit MMIO BAR *can't* move! Not only because it is=20
> 32bit, but also because the amdgpu driver as well as the HW itself=20
> through the VGA emulation, as well as the EFI/VESA/VBIOS code might=20
> reference its absolute address.

So if the 64-bit check is replaced with this:

+       /* Check if the parent bridge has a 64-bit (pref) memory resource *=
/
+       res =3D pci_resource_n(adev->pdev, 0)->parent;
+       /* Trying to resize is pointless without a window above 4GB */
+       if (!(res->flags & IORESOURCE_MEM_64))
=09=09return 0;

=2E..I don't think it's possible for 32-bit resource to share that window=
=20
under _any_ circumstance.

If you say that ->parent somehow points to a non-IORESOURCE_MEM_64 window=
=20
at this point, you're implying allocation for the 64-bit prefetchable=20
window was tried and failed, and __pci_assign_resource() then used one of=
=20
its fallbacks.

Are you saying that "some preparation" includes making room for that=20
64-bit prefetchable window that failed to assign earlier as I cannot see=20
how else it would ever get assigned so that the 64-bit BARs could be moved=
=20
there?

> Could we give pci_resize_resource() a mask of BARs which are save to=20
> release?

It is possible.

> Or maybe a flag to indicate that it can only free up 64bit BARs?
>=20
> Regards,
> Christian.
>=20
> >=20
> > Thanks a lot for checking this out!
> >=20
>=20

--=20
 i.

--8323328-2137640066-1762865768=:1002--

