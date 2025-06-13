Return-Path: <linux-pci+bounces-29747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C325AD913F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016EB1E4E9F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72431E1DEB;
	Fri, 13 Jun 2025 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OneHVLcc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1959444;
	Fri, 13 Jun 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828424; cv=none; b=AKMlvRDSz08PuxFiMcJrnFjI8FKR4I48ePlNs2jxR3b0Kl2P+Ul9727tORlp5I/Ijhtnh2HQtnmPkf6gLoDA+fg2SybTCd16xFAxAC84dg0G49Ralt3rFYZGVwIHNehDj5Eh/5Uk458Q/D2lkQQkysv1g4N+r8Z+bxEHZ/qyBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828424; c=relaxed/simple;
	bh=QDmODICNWiBtCvM/b89KqBEr7GNxx9lEwD2x/dRQD5k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SHgdytjlQqhPQWzn3Em4f90r5Kpphosd2quF3JciwwVehVfjoiZNMwVo/6JePEqp1/C7Fju8qsim1rWeLfDurPn1zM5RQDE218SaNwAoY1JihulRvsebP6rA8eLLt5atGA5AsUyxFOhqI5CNqn/mxo3/QXM1gCp+AIxwb0nNIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OneHVLcc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749828423; x=1781364423;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QDmODICNWiBtCvM/b89KqBEr7GNxx9lEwD2x/dRQD5k=;
  b=OneHVLccc231CZDVurFZmORvRteIa6ghXW5hwIgLlngPbPEhwO2fkvTk
   I5yH6TaaVtITWNVo5W9UWA4Gs4LLGs2YsshQ7EitYU4ngjJIGlcU+HQ1t
   qKaHJwkzO28xBiq4dKExwR+cEoBaHetJC7IZYw7n9PNunFJqlsYtkPhAR
   GAqovOx+dSeKvI2j0ExUv0Auz049dM8j9z3/zbZLAwKahYa+B2VVljLPH
   fU+a8+kmsOYf/cAOohnr/5iLBOgaZbXv7pl8FxEC/f7Xb9TpE4Auv1B0n
   RnE6efj427K0zzcGKsEsh5JtF+TM6AlCxsjJ4X/+Go7qz9nD0GRah7uzn
   w==;
X-CSE-ConnectionGUID: r7g6SKVYRBKmY5PA6J7gKQ==
X-CSE-MsgGUID: J2MZgEhUTY+52wk9oKidBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="69626440"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="69626440"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:27:02 -0700
X-CSE-ConnectionGUID: eiLse6EbSKa+9117fseorQ==
X-CSE-MsgGUID: wA+9VSQeRj6fWsmzEAVkKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="152743439"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:25:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 13 Jun 2025 18:25:50 +0300 (EEST)
To: Geraldo Nascimento <geraldogabriel@gmail.com>
cc: linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
    Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
    linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 2/5] PCI: rockchip: Drop unused custom registers
 and bitfields
In-Reply-To: <aExBeNdkOtFtW87z@geday>
Message-ID: <b4dc6d96-b268-7da4-e41f-cc922ae6941c@linux.intel.com>
References: <cover.1749826250.git.geraldogabriel@gmail.com> <ed25d30f2761e963164efffcfbe35502feb3adc2.1749826250.git.geraldogabriel@gmail.com> <97114c68-5eb7-18b0-adbd-227e1d7957c6@linux.intel.com> <aExBeNdkOtFtW87z@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-642005326-1749828350=:948"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-642005326-1749828350=:948
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 13 Jun 2025, Geraldo Nascimento wrote:

> On Fri, Jun 13, 2025 at 06:03:14PM +0300, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 13 Jun 2025, Geraldo Nascimento wrote:
> >=20
> > > Since we are now using standard PCIe defines, drop
> > > unused custom-defined ones, which are now referenced
> > > from offset at added Capabilities Register.
> >=20
> > These are quite short lines, please reflow the changelog paragraphs to =
the=20
> > usual length.
>=20
> Hi Ilpo,
>=20
> I'll reflow for v5.
>=20
> >=20
> > > Suggested-By: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-rockchip.h | 11 +----------
> > >  1 file changed, 1 insertion(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/con=
troller/pcie-rockchip.h
> > > index 5864a20323f2..f611599988d7 100644
> > > --- a/drivers/pci/controller/pcie-rockchip.h
> > > +++ b/drivers/pci/controller/pcie-rockchip.h
> > > @@ -155,16 +155,7 @@
> > >  #define PCIE_EP_CONFIG_DID_VID=09=09(PCIE_EP_CONFIG_BASE + 0x00)
> > >  #define PCIE_EP_CONFIG_LCS=09=09(PCIE_EP_CONFIG_BASE + 0xd0)
> > >  #define PCIE_RC_CONFIG_RID_CCR=09=09(PCIE_RC_CONFIG_BASE + 0x08)
> > > -#define PCIE_RC_CONFIG_DCR=09=09(PCIE_RC_CONFIG_BASE + 0xc4)
> > > -#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT=09=0918
> > > -#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT=09=090xff
> > > -#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT=09=0926
> > > -#define PCIE_RC_CONFIG_DCSR=09=09(PCIE_RC_CONFIG_BASE + 0xc8)
> > > -#define   PCIE_RC_CONFIG_DCSR_MPS_MASK=09=09GENMASK(7, 5)
> > > -#define   PCIE_RC_CONFIG_DCSR_MPS_256=09=09(0x1 << 5)
> > > -#define PCIE_RC_CONFIG_LINK_CAP=09=09(PCIE_RC_CONFIG_BASE + 0xcc)
> > > -#define   PCIE_RC_CONFIG_LINK_CAP_L0S=09=09BIT(10)
> > > -#define PCIE_RC_CONFIG_LCS=09=09(PCIE_RC_CONFIG_BASE + 0xd0)
> > > +#define PCIE_RC_CONFIG_CR=09=09(PCIE_RC_CONFIG_BASE + 0xc0)
> >=20
> > This will cause a build failure because PCIE_RC_CONFIG_CR is used in 1/=
5=20
> > but only introduced here so you'll need to do this in the same patch as=
=20
> > any step within a series must build too. IMO it would anyway make sense=
 to=20
> > combine patches 1 & 2.
>=20
> Ah, interesting angle. I'll fix it.
>=20
> >=20
> > >  #define PCIE_EP_CONFIG_LCS=09=09(PCIE_EP_CONFIG_BASE + 0xd0)
> >=20
> > Aren't you going to convert this as well?
>=20
> I can, but I can't test it however! But I'll Cc: someone who hopefully
> can.

TBH, the risk getting it wrong / changing the resulting object is pretty=20
low. :-)

It might be that scripts/objdiff tool could prove there were no changes in=
=20
the binary code output as it looks just a pre-preprocessor change.

--=20
 i.

--8323328-642005326-1749828350=:948--

