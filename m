Return-Path: <linux-pci+bounces-11551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D940894D408
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 17:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC761F21E66
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F8198A2F;
	Fri,  9 Aug 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgcvN8n5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E7168B8;
	Fri,  9 Aug 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218963; cv=none; b=qT0uX0b4ZyCpLJIMPNezadvcy0nI7baGIx9AdT0u9nJWT9AlLSBdZ07Epy/BS2SlfUILxEtzceHwuguYV7rmTEXGPzZYsj8HgvJuE07Gor0OOG/AwWtEZKXmC/bMlmzdKQAqb0ykq1F4ous7dyfMT29pa4/chMcmVutxObN1Jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218963; c=relaxed/simple;
	bh=OnZ/XKvESL+KOqBHUml6q9GBQ4whpdRFBOLSr7/OVvY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NlwRdSCvLJr47akMX515cFA4R8wceAd7zE/k+7J8Nb2UEdUciq/KchiaBR//8swlHhoqa3JwuMYeWg8scbgrKrkuUAuAW/pBcBA0DN2c8HC1V1fCVnhgQwLiHF0QOl8TK84Eugu1Qh72njcPAcOttYnyxC/xHKmZ1YM2zSJtCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgcvN8n5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723218962; x=1754754962;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OnZ/XKvESL+KOqBHUml6q9GBQ4whpdRFBOLSr7/OVvY=;
  b=WgcvN8n5niV8vkwTvdmxy5TGzFULXv0dH/OWueSXbu633YHC7pmBcxQq
   tcG/YD+qE7X1+zlWH/qbWfdEHfTXMKsrTxcOK4yCuLv03vay78f0O0z9r
   Bn1ch925bTvx56ULYmtcJ2QNY/ZR9L192KG7kXiSlLpT46wQAvGD8+F5B
   yx4al8+wE6sy2o2jKaRSCsIokV4qReTQTM/sHqlcoubnJ7SY9oWoxwLWr
   wEpXGftAFltlObZbZ6mbPV27YyAV95kC/KGiOQVIcNdUfypg8Z1LEIKiR
   Cuf2wMLzcI9YMSdhy1D3mLiXJKRgiiCK/pkMCItbDuD9yUrUzWOsm1Ees
   w==;
X-CSE-ConnectionGUID: vnAbsRHZTQeHW9izcxw4EA==
X-CSE-MsgGUID: ubDrxqUXTDeHqj7vsOB3RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21056342"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21056342"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:56:01 -0700
X-CSE-ConnectionGUID: ztPBdIXkTmKV62b/0Z5qhg==
X-CSE-MsgGUID: qpvnwexlT4qMwbZTiOK9YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="62243814"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.119])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:55:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Aug 2024 18:55:56 +0300 (EEST)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <alpine.DEB.2.21.2408091327390.61955@angie.orcam.me.uk>
Message-ID: <42afa3ee-4429-90e4-9e98-18a0d30c0a3c@linux.intel.com>
References: <20240129184354.GA470131@bhelgaas> <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com> <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk> <a7ff7695-77c5-cf5a-812a-e24b716c3842@linux.intel.com> <d5f14b8f-f935-5d5e-e098-f2e78a2766c6@linux.intel.com>
 <alpine.DEB.2.21.2402011800320.15781@angie.orcam.me.uk> <d9f6efe3-3e99-0e4b-0d1c-5dc3442c2419@linux.intel.com> <a0b070b7-14ce-7cc5-4e6c-6e15f3fcab75@linux.intel.com> <alpine.DEB.2.21.2408091327390.61955@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-969202318-1723218956=:1401"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-969202318-1723218956=:1401
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 9 Aug 2024, Maciej W. Rozycki wrote:

> On Wed, 7 Feb 2024, Ilpo J=C3=A4rvinen wrote:
>=20
> > > > > Because if it is constantly picking another speed, it would mean =
you get=20
> > > > > LBMS set over and over again, no? If that happens 34-35 times per=
 second,=20
> > > > > it should be set already again when we get into that quirk becaus=
e there=20
> > > > > was some wait before it gets called.
> > > >=20
> > > >  I'll see if I can experiment with the hardware over the next coupl=
e of=20
> > > > days and come back with my findings.
> > >=20
> > > Okay thanks.
> >=20
> > One point I'd be very interested to know if the link actually comes up=
=20
> > successfully (even if briefly) because this has large implications whet=
her=20
> > the quirk can actually be invoked from the bandwidth controller code.
>=20
>  That was more than a couple of days, sorry about it.  I have now been=20
> able to verify that LBMS keeps getting reasserted over and over again as=
=20
> the device goes through the infinite link training dance.  I haven't ever=
=20
> observed the link to become active in the course.  Here's a short log of=
=20
> commands repeatedly entered at the command prompt:
>=20
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5011
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5812
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5811
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5812
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5011
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5811
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5811
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5812
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5812
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5811
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5811
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5812
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5812
> # setpci -s 02:03.0 CAP_EXP+0x12.W
> 5811
>=20
> As you can see the Link Training bit oscillates as I previously reported=
=20
> and noted in the introduction to `pcie_failed_link_retrain', and also the=
=20
> Current Link Speed field flips between 2.5GT/s and 5GT/s.

Okay, thanks for testing. I suppose that test wasn't done in a busy loop=20
(it might not be easy capture very short link up state if there was any=20
such period when testing it by manually launching that command a few=20
times)?


--=20
 i.

--8323328-969202318-1723218956=:1401--

