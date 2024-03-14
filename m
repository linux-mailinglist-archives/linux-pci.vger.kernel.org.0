Return-Path: <linux-pci+bounces-4819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504287BC0A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 12:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C9C2869AE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B76E616;
	Thu, 14 Mar 2024 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUtuI5mx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB56CDB5;
	Thu, 14 Mar 2024 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416374; cv=none; b=gasD04ZUuIY/KEwpqF9JOfhPnpL99q714LxDimxuPSTyiMi0mW8rLlMacnHKHr+BGZGpIHvVQMRmNMPasOGu1urZT4hAPInPCJE+J4qPSkUaXITi4+xi73MIeWzr0RiISoUh6jKNd6eZlnITq+gZPaO/Q5PapPk91IZXawx/DMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416374; c=relaxed/simple;
	bh=gFRSJcnPaE/PeJWZbowy+BixegV6p7D1UJq7221K7gE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nnTUAiKCxokwHySY/AxSXBLFs0CZRrP3fmZHt2bpHEzPz6eQJKDBJlEn6/icgjBjgrrLyxGihHqVRxcMKhLSXg+Db02F6vA2f3l0OxTyu+96RzNqqEGNc02f1SQDG2mm8UbgCad9FCRW6yfUWl4bU930yt5dMdCNJXViHcKj7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUtuI5mx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710416373; x=1741952373;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gFRSJcnPaE/PeJWZbowy+BixegV6p7D1UJq7221K7gE=;
  b=NUtuI5mxCpUPosQw59dobzfHE4BcQz0SrbQ3aHg0PFMQmZkKacNZVnQS
   UloH4oAsMdzl/idAECu/598Ie4DoM7IylpTK8WqFxMzZBGym2ea4k/ZAG
   fb8JBR34Y4wMuaxfyF6MwNZy2xonR9vaCRvgmfNWipOMCHqnerDyKF4OZ
   VFgzKF2mjcBxfaml2yb7lxNsOesP4ixLhZyc08e9LcHieug5bl6/NaVql
   g/zTAosl7ConWlliucxmaUneH90kuoheCsoU/ZSoV3CDOAW6l6PJ8Qp1Q
   m1PYzWUOs6B+mIX9TKIgNQzTzkIucp9vZdL4Wr21Oe3IsrNS2keN1UsmJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5352302"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5352302"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="12842860"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.8])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:39:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 14 Mar 2024 13:39:24 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Use the correct bit in Link Training not active
 check
In-Reply-To: <01666075-504d-a434-d039-2e25db931f23@linux.intel.com>
Message-ID: <c4fe9080-245f-7089-84c1-bb47dcf2cd83@linux.intel.com>
References: <20240301150641.4037-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2403011622560.42226@angie.orcam.me.uk> <c740c6e4-ca1a-33ad-8437-4a1219c16eb1@linux.intel.com> <alpine.DEB.2.21.2403060951310.43702@angie.orcam.me.uk>
 <01666075-504d-a434-d039-2e25db931f23@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-462866126-1710416364=:1017"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-462866126-1710416364=:1017
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 6 Mar 2024, Ilpo J=E4rvinen wrote:

> On Wed, 6 Mar 2024, Maciej W. Rozycki wrote:
> > On Mon, 4 Mar 2024, Ilpo J=E4rvinen wrote:
> >=20
> > > > > Since waiting for Data Link Layer Link Active bit is only used fo=
r the
> > > > > Target Speed quirk, this only impacts the case when the quirk att=
empts
> > > > > to restore speed to higher than 2.5 GT/s (The link is Up at that =
point
> > > > > so pcie_retrain_link() will fail).
> > > >=20
> > > >  NAK.  It's used for both clamping and unclamping and it will break=
 the=20
> > > > workaround, because the whole point there is to wait until DLLA has=
 been=20
> > > > set.  Using LT is not reliable because it will oscillate in the fai=
lure=20
> > > > case and seeing the bit clear does not mean link has been establish=
ed. =20
> > >=20
> > > In pcie_retrain_link(), there are two calls into=20
> > > pcie_wait_for_link_status() and the second one of them is meant to=20
> > > implement the link-has-been-established check.
> > >=20
> > > The first wait call comes from e7e39756363a ("PCI/ASPM: Avoid link=20
> > > retraining race") and is just to ensure the link is not ongoing retra=
ining=20
> > > to make sure the latest configuration in captured as required by the=
=20
> > > implementation note. LT being cleared is exactly what is wanted for t=
hat=20
> > > check because it means that any earlier retraining has ended (a new o=
ne=20
> > > might be starting but that doesn't matter, we saw it cleared so the n=
ew=20
> > > configuration should be in effect for that instance of link retrainin=
g).
> > >=20
> > > So my point is, the first check is not even meant to check that link =
has=20
> > > been established.
> >=20
> >  I see what you mean, and I now remember the note in the spec.  I had=
=20
> > concerns about it, but did not do anything about it at that point.
> >=20
> >  I think we still have no guarantee that LT will be clear at the point =
we=20
> > set RL, because LT could get reasserted by hardware between our read an=
d=20
> > the setting of RL.
> >
> > IIUC that doesn't matter really, because the new link=20
> > parameters will be taken into account regardless of whether retraining =
was
> > initiated by hardware in an attempt to do link recovery or triggered by=
=20
> > software via RL.
>=20
> I, too, was somewhat worried about having LT never clear for long enough=
=20
> to successfully sample it during the wait but it's like you say, any new=
=20
> link training should take account the new Target Speed which should=20
> successfully bring the link up (assuming the quirk works in the first=20
> place) and that should clear LT.

Hi,

One more point to add here, I started to wonder today why that use_lt=20
parameter is needed at all for pcie_retrain_link()?

Once the Target Speed has been changed to 2.5GT/s which is what the quirk=
=20
does before calling retraining, LT too should work "normally" after that.

--=20
 i.

--8323328-462866126-1710416364=:1017--

