Return-Path: <linux-pci+bounces-6787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E18B5BF3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8BC1F23D55
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6A7FBC8;
	Mon, 29 Apr 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXZJWuff"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D07EF1C;
	Mon, 29 Apr 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402283; cv=none; b=EfVyEU4+QK5KXAs1KD2gCDnDxf4d7+FT0uFtGhynN4iprorT4kO+VsMtVwa/I3SbFHzzBulNgZor4flclfn/QBVBIqklu76U1wsvsNdSSqtvwjQnfV7/YoBTJIJoMT6mJ9VJalILlBJXTfwa7liinyTu9diIjK9r7PJ3Zjz2P4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402283; c=relaxed/simple;
	bh=pJPuvAxvq6t2LfZ0lSaha8rRl2Cjbgd6sgUyJR0F57I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j3yIbq8Ssae6eWL+vbarjTpMZNkGUQC5M/jd9IVIk5ZO8hvTC3dXHZUhBZat154vBCsEi2Wp2gwgHKofDv3hOvX0AOqb1FyKoDlen99IBZEzDG5R3QI04XNaAR2Ayaz7NLZ9dpRqx1Acu/wYj9eWrIYipcqQSzmc3zIPt36ObL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXZJWuff; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714402281; x=1745938281;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pJPuvAxvq6t2LfZ0lSaha8rRl2Cjbgd6sgUyJR0F57I=;
  b=dXZJWuffFXSjevRJPKzvQ+9V5+h2BTtgWEAm1zAv+9fMNNRI7ATAy95E
   Kw3UWCREhBdVUxN8Xe82yU66B5fHZ9tY1hqYCrcagDyGae9+yDjR5t0i9
   yzhXtwpzdkdj0UhB6JLD9PHvpmh3mwHVH4TbyhXTeA1yV75ZsnzynHl7O
   rhM5hDV6oWkeIPEFu0CSGxid3WKaCRaalpFbD/nCq7tpFD/3yybrboSRT
   TVusVPFKsrfhTLZXOFHW74jW7jjgs0QyjtrHs9LNglRSo6BII37nvXVuY
   V6S26uVEI/eyARXi4pM2xEv9sWJjyfs9aTyCawIRRPy6J2V6DcCjTAkxS
   A==;
X-CSE-ConnectionGUID: UvQvqRK3Qu+UZ6yA19brQw==
X-CSE-MsgGUID: tKiX0aebTZGS492ewqZ1LA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="9941737"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9941737"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 07:51:20 -0700
X-CSE-ConnectionGUID: j+I079RvTY6USK5/eXE1Ng==
X-CSE-MsgGUID: 7hlZdKHIRRihV1XXSG8fkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26123028"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 07:51:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Apr 2024 17:51:13 +0300 (EEST)
To: Andrew Lunn <andrew@lunn.ch>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
    Gregory Clement <gregory.clement@bootlin.com>, 
    Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] ARM: orion5x: Rename PCI_CONF_{REG,FUNC}() out of
 the way
In-Reply-To: <1d3606e7-0cb5-4180-92ff-5b9cec7a64ad@lunn.ch>
Message-ID: <eceb5fb8-dbc6-3f2c-4a50-629518198b89@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429104633.11060-2-ilpo.jarvinen@linux.intel.com> <1d3606e7-0cb5-4180-92ff-5b9cec7a64ad@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-486568427-1714402273=:1286"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-486568427-1714402273=:1286
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 29 Apr 2024, Andrew Lunn wrote:

> On Mon, Apr 29, 2024 at 01:46:24PM +0300, Ilpo J=E4rvinen wrote:
> > orion5x defines PCI_CONF_REG() and PCI_CONF_FUNC() that are problematic
> > because PCI core is going to introduce defines with the same names.
> >=20
> > Add ORION5X prefix to those defines to avoid name conflicts.
> >=20
> > Note: as this is part of series that replaces the code in question
> > anyway, only bare minimum renaming is done and other similarly named
> > macros are not touched.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Hi Ilpo
>=20
> What branch do these apply to? I wanted to test them, but i get hunks
> rejected:
>=20
> git am < 20240429104633.11060-1-ilpo.jarvinen@linux.intel.com.mbx
> Applying: ARM: orion5x: Rename PCI_CONF_{REG,FUNC}() out of the way
> Applying: ARM: orion5x: Use generic PCI Conf Type 1 helper
> error: patch failed: arch/arm/mach-orion5x/pci.c:276
> error: arch/arm/mach-orion5x/pci.c: patch does not apply
> Patch failed at 0002 ARM: orion5x: Use generic PCI Conf Type 1 helper
>=20
> I tried linux-next, v6.9-rc6, pci:next

Hi,

On top of pci:main (so v6.9-rc1).

"ARM: orion5x: Use generic PCI Conf Type 1 helper" should be only 4th=20
patch but your command seems to apply it as 2nd patch (is the mbx file=20
having them out-of-order?).

--=20
 i.

--8323328-486568427-1714402273=:1286--

