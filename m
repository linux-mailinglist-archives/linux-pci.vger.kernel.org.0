Return-Path: <linux-pci+bounces-14765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91D9A2006
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DA71C2173C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F61D0944;
	Thu, 17 Oct 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HviEcUWR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC241DACA1;
	Thu, 17 Oct 2024 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161013; cv=none; b=n6zasb3tQITC3esnsBbIESh4Juj9BlfniENdC6lMkW+WVafgvjBuDCv0xoJ6N125HhOXdU/0l61ACqJHgmyLJJSJnABEsz6L6UtK5dIQucRPq61nrig+QMuBloWSkfBbaGu0Y70G7n+MSzwxEoYeOEII/DYlcnPD4bQwb+RtTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161013; c=relaxed/simple;
	bh=kLwSQH57PEe5zVOlFBEwDTX0uJqJce5cR9UB+XSr2Zk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PBI6+EXlfPVyFFXp2b30bPYHS7LGIi0wgIi4NNn+W7949AY890i1Z5b6qmc98Ir3gaZWz7YR08K/6dlVFNYY63AutGa++UtPGgOiFpfBzK8j9Su5cmWAyFIO4yiERiAJP+9lwfm1I8L2AhDv5QlAUgOEfLNQ+Xa8zfIYsiD55zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HviEcUWR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729161010; x=1760697010;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kLwSQH57PEe5zVOlFBEwDTX0uJqJce5cR9UB+XSr2Zk=;
  b=HviEcUWRsGOW6xrRrmGlaZcXXE6okRgYXrTm/5ryk+n/QlI2TXODds5c
   oN/Yex8ND1Q9Gol+GlezAnJcHB0+Ka9qTjueJVD3sYtQtXtf9jyz4IOLD
   NhmqR+pxReW2Qo+trkAaIEnA6JMoJAre/NnJInNXnGzlR2zOibz9dNOqV
   JBGygco0KS/qOn5q4iQt08PIggtuTuENcPYMgql9jjuCjskHS+RiZ/ltn
   nBw+d4sc4wm5nnr8Ud1IslrJDrpyMEizqyV2Z6ZIHx895WZGkAt7dX3CD
   oN+i1aGFa9QUrm9Z8POuJpTn+aUALQGIjH00kkc7qlTOUDGZ03KXkP0gg
   g==;
X-CSE-ConnectionGUID: iLjTbjanTdiWxDI89aueIA==
X-CSE-MsgGUID: sHiS3dG5Tn2UpZV0f7VfNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28771519"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28771519"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 03:30:09 -0700
X-CSE-ConnectionGUID: fq/YAsdiTF2LsYUjOCgWwQ==
X-CSE-MsgGUID: eDB9BRDOTKe9wcIiYvYmZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78164890"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 03:30:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 17 Oct 2024 13:30:00 +0300 (EEST)
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 1/8] PCI: Protect Link Control 2 Register with RMW
 locking
In-Reply-To: <20241017111213.00005d4f@Huawei.com>
Message-ID: <8b022694-ed39-5216-67ed-f532ecb576df@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com> <20241009095223.7093-2-ilpo.jarvinen@linux.intel.com> <20241017111213.00005d4f@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1216660895-1729161000=:929"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1216660895-1729161000=:929
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Oct 2024, Jonathan Cameron wrote:

> On Wed,  9 Oct 2024 12:52:16 +0300
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > PCIe Bandwidth Controller performs RMW accesses the Link Control 2
> > Register which can occur concurrently to other sources of Link Control
> > 2 Register writes. Therefore, add Link Control 2 Register among the PCI
> > Express Capability Registers that need RMW locking.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Totally trivial comment inline.
>=20
> LGTM
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> > ---
> >  Documentation/PCI/pciebus-howto.rst | 14 +++++++++-----
> >  include/linux/pci.h                 |  1 +
> >  2 files changed, 10 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pc=
iebus-howto.rst
> > index f344452651e1..375d9ce171f6 100644
> > --- a/Documentation/PCI/pciebus-howto.rst
> > +++ b/Documentation/PCI/pciebus-howto.rst
> > @@ -217,8 +217,12 @@ capability structure except the PCI Express capabi=
lity structure,
> >  that is shared between many drivers including the service drivers.
> >  RMW Capability accessors (pcie_capability_clear_and_set_word(),
> >  pcie_capability_set_word(), and pcie_capability_clear_word()) protect
> > -a selected set of PCI Express Capability Registers (Link Control
> > -Register and Root Control Register). Any change to those registers
> > -should be performed using RMW accessors to avoid problems due to
> > -concurrent updates. For the up-to-date list of protected registers,
> > -see pcie_capability_clear_and_set_word().
> > +a selected set of PCI Express Capability Registers:
> > +
> > +* Link Control Register
> > +* Root Control Register
> > +* Link Control 2 Register
> > +
> > +Any change to those registers should be performed using RMW accessors =
to
> > +avoid problems due to concurrent updates. For the up-to-date list of
> > +protected registers, see pcie_capability_clear_and_set_word().
>=20
> If I were super fussy I'd ask for a precursor patch doing the reformat.
>=20
> Meh - up to Bjorn, but for me this is small enough to not be worth
> the effort.

Hi Jonathan,

Thanks. Since you brought it up, I've no problem in splitting the=20
reformatting into own patch, it won't take more than a minute
anyway to do that change.

--=20
 i.

> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 573b4c4c2be6..be5ed534c39c 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1274,6 +1274,7 @@ static inline int pcie_capability_clear_and_set_w=
ord(struct pci_dev *dev,
> >  {
> >  =09switch (pos) {
> >  =09case PCI_EXP_LNKCTL:
> > +=09case PCI_EXP_LNKCTL2:
> >  =09case PCI_EXP_RTCTL:
> >  =09=09return pcie_capability_clear_and_set_word_locked(dev, pos,
> >  =09=09=09=09=09=09=09=09 clear, set);
>=20
>=20

--8323328-1216660895-1729161000=:929--

