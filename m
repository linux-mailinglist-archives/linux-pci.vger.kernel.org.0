Return-Path: <linux-pci+bounces-4413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FE7870052
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 12:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6241F23BBF
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EEE3839F;
	Mon,  4 Mar 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bibQeV22"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5239FC4;
	Mon,  4 Mar 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551286; cv=none; b=eMZoMk0h/5gz4PgTOp1nbBbPKgT8LY9j5jRSsrpyNdmSWH1iLlC8iJ+bO8tRfe/SmxljRATZricR6OfVagBkj3pKEICEBO2eLKtRMbiHPbwZWtD1Y8D3ZpYys1s2Klz4elwcNhU0HYBYYY8U5lOr/AUBrrbHncT+YGB9ldJURXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551286; c=relaxed/simple;
	bh=Sbb1gBYdpa5zkmb+nr8xjSn5zLmEKlOUK4LklNEgemU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZEyaVRg7f9M1Oh7pDRgqXn+4ShicGCVIdbX4MrICmOryBQSd+5iZOGPOKtoM2sxWmSbWoNZBuqqhYeZgNl+Kv4+1OHoPjeb+RA4MQgzHzm3ZW9tX7qzTAPo5MOTlQOPpyT0yYECVMdYZFnOJ9quoZsPTljEG6W/yP45dlkcFOrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bibQeV22; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709551285; x=1741087285;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Sbb1gBYdpa5zkmb+nr8xjSn5zLmEKlOUK4LklNEgemU=;
  b=bibQeV22K9LR46nskOcr9An9XSCILRB5+wCAoxnWk4oKU+eTIuylVV5x
   7DCmh0lDM6yujLRZ6JXPN0k3D2TqXEIxk48SFKgQ2W5u0Ts86u634t7nk
   rQJJQFsNTkZ5FhbLAJjdB1beoHq9DJV4cpqcqgShuhKP0/PfOqtpKUiZq
   QhA6JoGjaQNZv0S+ecdiQR/nzy8KNmD97SwgRyC/D0Zr0QbqAhAb2qILp
   fGNlCjkuFSMfq3XQ6F49APj4FQTnLdAUES+sWBrmolEtNOiqby/Zq0lWq
   N9rHSJMIs1ZAyM7ZUA1RMURX9glwmw4PM9grINFXSbBSEhM6+zjvaFE0H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3963219"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3963219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:21:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8877670"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:21:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 4 Mar 2024 13:21:18 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Use the correct bit in Link Training not active
 check
In-Reply-To: <alpine.DEB.2.21.2403011622560.42226@angie.orcam.me.uk>
Message-ID: <c740c6e4-ca1a-33ad-8437-4a1219c16eb1@linux.intel.com>
References: <20240301150641.4037-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2403011622560.42226@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1332954053-1709550611=:986"
Content-ID: <2e8518c1-13d2-0ab3-9a4a-797e1493b1c1@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1332954053-1709550611=:986
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <17e80b29-02cc-97b3-0856-783bbbf11ce9@linux.intel.com>

On Fri, 1 Mar 2024, Maciej W. Rozycki wrote:

> On Fri, 1 Mar 2024, Ilpo J=E4rvinen wrote:
>=20
> > Besides Link Training bit, pcie_retrain_link() can also be asked to
> > wait for Data Link Layer Link Active bit (PCIe r6.1 sec 7.5.3.8) using
> > 'use_lt' parameter since the merge commit 1abb47390350 ("Merge branch
> > 'pci/enumeration'").
>=20
>  Nope, it was added with commit 680e9c47a229 ("PCI: Add support for=20
> polling DLLLA to pcie_retrain_link()"), before said merge.

Ah sorry, my wording was not good here, I meant on the line I was=20
changing in the patch and that line didn't exist in 680e9c47a229 at all.=20

So yes, DLLLA and use_lt waiting was added in 680e9c47a229 but the merge=20
commit brought the implementation note related code into=20
pcie_retrain_link() which I think was mismerged when it comes to use_lt.

> > pcie_retrain_link() first tries to ensure Link Training is not
> > currently active (see Implementation Note in PCIe r6.1 sec 7.5.3.7)
> > which must always check Link Training bit regardless of 'use_lt'.
> > Correct the pcie_wait_for_link_status() parameters to only wait for
> > the correct bit to ensure there is no ongoing Link Training.
>=20
>  You're talking the PCIe spec here and code is talking a bad device case.
>
> > Since waiting for Data Link Layer Link Active bit is only used for the
> > Target Speed quirk, this only impacts the case when the quirk attempts
> > to restore speed to higher than 2.5 GT/s (The link is Up at that point
> > so pcie_retrain_link() will fail).
>=20
>  NAK.  It's used for both clamping and unclamping and it will break the=
=20
> workaround, because the whole point there is to wait until DLLA has been=
=20
> set.  Using LT is not reliable because it will oscillate in the failure=
=20
> case and seeing the bit clear does not mean link has been established. =
=20

In pcie_retrain_link(), there are two calls into=20
pcie_wait_for_link_status() and the second one of them is meant to=20
implement the link-has-been-established check.

The first wait call comes from e7e39756363a ("PCI/ASPM: Avoid link=20
retraining race") and is just to ensure the link is not ongoing retraining=
=20
to make sure the latest configuration in captured as required by the=20
implementation note. LT being cleared is exactly what is wanted for that=20
check because it means that any earlier retraining has ended (a new one=20
might be starting but that doesn't matter, we saw it cleared so the new=20
configuration should be in effect for that instance of link retraining).

So my point is, the first check is not even meant to check that link has=20
been established.

>  What are you trying to achieve here and what problem is it to fix?

Actually, I misthought what it breaks so the problem is not well described=
=20
above but I still think it is broken:

In the case of quirk, before 2.5GT/s is attempted DLLLA is not set,=20
right? Then quirk sets 2.5GT/s target speed and calls into=20
pcie_retrain_link().

The first call into pcie_wait_for_link_status() is made with (..., false,=
=20
true) which waits until DLLLA is set but this occurs before OS even=20
triggered Link Retraining. Since there's no retraining commanded by the=20
OS, DLLLA will not get set, the wait will fail and error is returned, and=
=20
the quirk too returns failure.

It could of course occur that because of the HW retraining loop=20
(independent of OS control), the link retrains itselfs to 2.5GT/s without=
=20
OS asking for it just by OS setting the target speed alone, which is well=
=20
possible given the HW behavior in your target speed quirk case is not=20
fully understood. Even if that's the case, it seems not good to rely on=20
the HW originating retraining loop triggering the link retraining that
is necessary here.

Maybe this is far fetched thought but perhaps it could explain why you=20
didn't get the link up with your setup when you tried to test it earlier.

Alternative approach to fix this problem would be to not make the first=20
call into pcie_wait_for_link_status() at all when use_lt =3D false.

Of course, I cannot test this with your configuration so I cannot=20
confirm how the target speed quirk behaves, I just found it by reading the=
=20
code. The current code does not make sense because the first wait is=20
supposed to wait for LT bit, not for DLLLA.

--=20
 i.
--8323328-1332954053-1709550611=:986--

