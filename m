Return-Path: <linux-pci+bounces-42380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0CDC985B3
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 17:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9E314E3383
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E1334C09;
	Mon,  1 Dec 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+4J1Te6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F201335067;
	Mon,  1 Dec 2025 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607741; cv=none; b=qvz2mipwaGpqpe/MHb0oLNhg2aMfLhHoX3XSbo80y+8NiogSGSHeCEy3WO1HWi/kwSZChoeORzwFbT7bbImZy+uhEgO3+UB5jppWuOZNoHIw4g727FXjHLYkC/oItkwT9v+KT59YVuOn2xbJF2UyCXAGqLRyjZFGEIR2byCrywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607741; c=relaxed/simple;
	bh=2SsmyRdZRbvqmzgnL34IM76Q7MWDNgo5DZV34g2Htzc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kZ4zJHrwSrxWZi+ZhRxN9yHs9eUCQLlMpB01oRACol9aQVUYjxELv9OrWinYNtszMoUyTm512723xbGpA+HVzkXqrCM26MMbCoAGY78KMyswNxdDkiuBOjuxZIN1/M85yY/CSgoFCkASFQLOtV9lMzVNp4RV/kf456putOqd9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+4J1Te6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764607737; x=1796143737;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=2SsmyRdZRbvqmzgnL34IM76Q7MWDNgo5DZV34g2Htzc=;
  b=N+4J1Te6Oio5GXecm3pI6nBMx4OzHw4zdGByrhNuNzup1X52aQwMIoMR
   us0fbmNTNxOE4zzIY65gsFE4RiXgBnoFVjNMi7pHCfsuzej1C9O1DjqPS
   /1zfh75aCbRl9USodveXzOL5ulduxJHrbFDwEMRGUPGHXtD34fZ+36ggT
   3GKqyi9rPuMHl1264PXSUbJm1iAfzxBL577i8WWYVKq3pCt4yrhLEa/mg
   iIlCBfwHTyP3aGuD2ni4zCx4PZT9N+arULo9CofdQDQhKdtxGil1M05tD
   f6M1VCrpiDlJN/ugdyFs040z/m9w+d4XCTZgFshw+3/5XCAdK7B5SmGKJ
   A==;
X-CSE-ConnectionGUID: 3exaKiXOSdSXneBYcgdl0w==
X-CSE-MsgGUID: u5t5gm63QhWRYMmTj8ypDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66441544"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="66441544"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 08:48:53 -0800
X-CSE-ConnectionGUID: qBIkZHOpT7KoiGPXneeRuw==
X-CSE-MsgGUID: /NydiJjPThOIjgrDWW5lrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="194548600"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.202])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 08:48:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 1 Dec 2025 18:48:45 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    ALOK TIWARI <alok.a.tiwari@oracle.com>, ashishk@purestorage.com, 
    msaggi@purestorage.com, sconnor@purestorage.com, 
    Lukas Wunner <lukas@wunner.de>, Jiwei <jiwei.sun.bj@qq.com>, 
    guojinhui.liam@bytedance.com, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining
In-Reply-To: <alpine.DEB.2.21.2512011319590.49654@angie.orcam.me.uk>
Message-ID: <4bf967a6-0918-d074-58bb-f0aebf6ceeb6@linux.intel.com>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk> <440e7c29-bee1-29f3-afa8-7b5905fd6cf2@linux.intel.com> <alpine.DEB.2.21.2512011319590.49654@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-805540840-1764607541=:974"
Content-ID: <a067360e-2ba6-ce76-9f35-1ca94dec1da5@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-805540840-1764607541=:974
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a80e5367-7a42-1e71-be06-024c753c8315@linux.intel.com>

On Mon, 1 Dec 2025, Maciej W. Rozycki wrote:

> On Mon, 1 Dec 2025, Ilpo J=E4rvinen wrote:
>=20
> > > +=09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > > +=09if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) =3D=3D PCI_EXP_LNKCTL2_TLS_2_=
5GT &&
> > > +=09    (lnkcap & PCI_EXP_LNKCAP_SLS) !=3D PCI_EXP_LNKCAP_SLS_2_5GB) =
{
> >=20
> > I'm trying to recall, if there was some particular reason why=20
> > ->supported_speeds couldn't be used in this function. It would avoid th=
e=20
> > need to read LinkCap at all.
>=20
>  Thanks for the hint.  There's probably none and it's just me missing som=
e=20
> of the zillion bits and pieces.  I'll wait a couple of days for any other=
=20
> people to chime in and respin with this update included if everyone is=20
> otherwise happy to proceed with this update.
>=20
> > > +=09=09if (ret)
> > > +=09=09=09goto err;
> > >  =09}
> > > =20
> > >  =09return ret;
> >=20
> > return 0;
>=20
>  It can still return -ENOTTY if neither of the two latter conditionals=20
> matched, meaning the quirk was not applicable after all.  ISTR you had=20
> issues with the structure of this code before; I am not sure if it can=20
> be made any better in a reasonable way.  It is not a failure per se, so=
=20
> the newly-added common error path does not apply.  This is the case for:=
=20
> "Return an error if retraining was not needed[...]" from the introductory=
=20
> comment.
>=20
>  Shall I add a comment above the return statement referring to this?

I think it's fine as is, I just didn't review with enough context to=20
notice what it was initialized to (the usual thing when adding a=20
rollback path is to forget to change the normal path to return 0, thus=20
"auto commenting" it without checking enough, I'm sorry about that).

--=20
 i.
--8323328-805540840-1764607541=:974--

