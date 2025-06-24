Return-Path: <linux-pci+bounces-30502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D7FAE64DD
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 14:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF41817088A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83088222599;
	Tue, 24 Jun 2025 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muDdnY9t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2A280CC8
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768100; cv=none; b=FnJPO4DAGRodaYbD3KMhjS7jvhd0bFTI5MCAsdxQqXWVyZVagLcCLZyOYVeIkhQTgITKsrjUHRsEvZcwJ8vq9sVRT5oyKvxSFO0WQFy5P1KtYfk5SQIcmkkgZErSLPp316wnnp/rM2wXr9XnVT6onhKmVlBiX1qQh7sx8SpuUUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768100; c=relaxed/simple;
	bh=Weguv2Q++I4YxHY3wXMyCrYDP+6bf5TnmlNds+RJ+do=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SJk1ifQ9x6ysSh7yuNHyKJTb6aNvIzNCoPpQ++DAUpenMr9SdRTnnuOPduxi/v9g6t+C9/qZ0KcIEnVev+Tpb7e5yF7UxqV6mF0IEXrYnR05qmx0SXeEyDDmdu5toxGSrXF2CNo+rQPNi1pmg/XK08hDIPVqW8e++4KStad7vTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muDdnY9t; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750768099; x=1782304099;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Weguv2Q++I4YxHY3wXMyCrYDP+6bf5TnmlNds+RJ+do=;
  b=muDdnY9trCkXU8RtvABIKPMHnqG5iIudkeYZFI40RJoqY3OMocFI5YqG
   H6YDLXct8TI+kMIV3DV8s2sTIRd4yf92/pzcn2Px2o424WfuTGcbaN2qh
   TdbzqgECQe6wHchrlwwYBk+YoP4RljZZyAYW5FAaPBMAU/tF46Yhf2jAG
   r5jLYd/rhB/TjQml4a3Oouw/EfxUhV876DGNQqL7vtXl/n8Wiqc9gNCpM
   WV8DKt4S6okoQvSZZBlpJtfE7P6HG0xXLdUALh85T2V7p89VAJgyQX9bv
   sndYRKvE65U8JjXB2kQmdimhjvEHFicu+EdQ3VSqgCWZPO3SseWuUjCwR
   Q==;
X-CSE-ConnectionGUID: ChxZgRjZS56D+cqaNsyeYw==
X-CSE-MsgGUID: j9PMcDWCT3Wcvbi1AhJclA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="40619185"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="40619185"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 05:28:14 -0700
X-CSE-ConnectionGUID: Q075/ueFQlSpjMle/7RloQ==
X-CSE-MsgGUID: ZV9+hf8CTtqZDF+TAw40Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="182934890"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 05:28:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Jun 2025 15:28:07 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
cc: Andrew <andreasx0@protonmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix link speed calculation on retrain failure
In-Reply-To: <aFqXz8llC2gYl5XJ@wunner.de>
Message-ID: <8bc398ab-bf76-cf46-f67d-684229ee6de1@linux.intel.com>
References: <1c92ef6bcb314ee6977839b46b393282e4f52e74.1750684771.git.lukas@wunner.de> <78b87a33-3e46-aabd-3f88-db5c1130c20c@linux.intel.com> <aFqXz8llC2gYl5XJ@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2093005495-1750767798=:943"
Content-ID: <1df8ba67-f547-6580-0afd-2bc973fb0f69@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2093005495-1750767798=:943
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7878aca2-6619-83d9-0f3a-ac7e68bb2885@linux.intel.com>

On Tue, 24 Jun 2025, Lukas Wunner wrote:

> On Tue, Jun 24, 2025 at 02:23:33PM +0300, Ilpo J=E4rvinen wrote:
> > On Mon, 23 Jun 2025, Lukas Wunner wrote:
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -108,7 +108,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
> > >  =09pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> > >  =09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> > >  =09if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnkst=
a)) {
> > > -=09=09u16 oldlnkctl2 =3D lnkctl2;
> > > +=09=09u16 oldlnkctl2 =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
> > > =20
> > >  =09=09pci_info(dev, "broken device, retraining non-functional downst=
ream link at 2.5GT/s\n");
> >=20
> > IIRC, there was a patch from somebody else which fixed this a bit=20
> > differently but never got applied (many months ago by now).
>=20
> Must be this one, still marked "New" in patchwork:
>=20
> https://patchwork.kernel.org/project/linux-pci/patch/20250123055155.22648=
-2-sjiwei@163.com/
>=20
> I don't care which one gets applied, as long as the issue is fixed.

Yes, that's the one.

It seemed pointless to me to require callers to apply the mask to=20
the register value when the conversion helper could do that itself,=20
especially when the macro takes in a parameter called "lnkctl2".

--=20
 i.
--8323328-2093005495-1750767798=:943--

