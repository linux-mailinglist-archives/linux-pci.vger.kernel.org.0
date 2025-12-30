Return-Path: <linux-pci+bounces-43843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE5CE994C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03B18301C951
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E628A2D839F;
	Tue, 30 Dec 2025 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvD6ECWI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E22264C0;
	Tue, 30 Dec 2025 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095648; cv=none; b=RjGUhbPqWSF/zqUwJbsomk+oqCCvp7dsF81XOXMPCbhPFDn8PO2GZUTF4llJX0aKCgHEY2Qb6Y0qX2kp7Lom7aBk7CJFhZKFhXh9+fhvoSMBT6sG+5TlC6sx1CkZeyAIf1PCnKF/IfFXsKpD0YYHDoUrAJHRakk/OJY1a4YUNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095648; c=relaxed/simple;
	bh=spPr8TBiHbVgQkzYTHJ55ZXoc4bw8ADD5ffVTH2O2wg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lqCajx0QF+xOD+odEFOZrLIAS4EaqTGOqd4b7zHC685Uk0gR5obzIUoyWY8YXcfW00p3qkR6W9K7dARkRdJ0LeyQV8nehVRJ1tB0vazkcdl1wlG6MSWyBYnInrsS/jbV810SVrpsHuNTBTxJnbv5Vp5rdH9x79Lv9d+hTbQCcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvD6ECWI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767095647; x=1798631647;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=spPr8TBiHbVgQkzYTHJ55ZXoc4bw8ADD5ffVTH2O2wg=;
  b=kvD6ECWIFT0vzwaIuEp5RusnxymBxJOKl6E+A9LIdot+vkC0ncc9w4Qi
   6H97eUWTxUEeOalip8z1qMCvz2uVFHFJC6JhNRvRbNrISJzeC2H4t0R2Q
   QUE//kO3VTeW2j0eY74t6k5Q5WXqPCZTSJMM/8IKqvh2sS6rxkCZoDl2j
   hIKDOYhLVmseSe7N/4K+S+IVtfO7XKIvswSvqdyklbOtsmVh5PNSJsJ1a
   BobsyaLkwJEvdxPbBxsflLOTkmVi7qZESYc3GI/gztCb5pmJfyiml9G/i
   dq1ihffPdAPc1rtJYwx8fnUWRNRWkb+27e9H7Ea1sx1SCGE0PczdNAHkt
   w==;
X-CSE-ConnectionGUID: tNJuxyPwSZ6E1AyAfnKJVw==
X-CSE-MsgGUID: x24pF/jpTiq57zRJsZP1GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="80135671"
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="80135671"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 03:54:06 -0800
X-CSE-ConnectionGUID: FMJIFOZzTRGmupU6isp6WA==
X-CSE-MsgGUID: vWIk7zn3QT67vm8gW7fs3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="206260072"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.114])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 03:54:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Dec 2025 13:53:58 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Linux ACPI <linux-acpi@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
    Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Linux PCI <linux-pci@vger.kernel.org>, Alex Hung <alexhung@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v1] ACPI: scan: Use resource_type() for resource type
 checking
In-Reply-To: <12814730.O9o76ZdvQC@rafael.j.wysocki>
Message-ID: <e555049f-1170-9e7e-7564-1fe541c33dd8@linux.intel.com>
References: <12814730.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-565337332-1767095638=:985"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-565337332-1767095638=:985
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 30 Dec 2025, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> To follow a well-established existing pattern, use resource_type() for
> resource type checking in acpi_scan_claim_resources().
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> This is a follow-up to
>=20
> https://lore.kernel.org/linux-acpi/7888874.EvYhyI6sBW@rafael.j.wysocki/
>=20
> which is present in linux-next.
>=20
> ---
>  drivers/acpi/scan.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2624,7 +2624,7 @@ static void acpi_scan_claim_resources(st
>  =09=09if ((res->flags & IORESOURCE_DISABLED) || res->end < res->start)
>  =09=09=09continue;
> =20
> -=09=09if (res->flags & IORESOURCE_IO) {
> +=09=09if (resource_type(res) =3D=3D IORESOURCE_IO) {
>  =09=09=09/*
>  =09=09=09 * Follow the PNP system driver and on x86 skip I/O
>  =09=09=09 * resources that start below 0x100 (the "standard PC
> @@ -2635,7 +2635,7 @@ static void acpi_scan_claim_resources(st
>  =09=09=09=09continue;
>  =09=09=09}
>  =09=09=09r =3D request_region(res->start, resource_size(res), regionid);
> -=09=09} else if (res->flags & IORESOURCE_MEM) {
> +=09=09} else if (resource_type(res) =3D=3D IORESOURCE_MEM) {
>  =09=09=09r =3D request_mem_region(res->start, resource_size(res), region=
id);
>  =09=09} else {
>  =09=09=09continue;
>=20
>=20
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-565337332-1767095638=:985--

