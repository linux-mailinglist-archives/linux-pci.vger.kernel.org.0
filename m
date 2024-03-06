Return-Path: <linux-pci+bounces-4581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B22873B07
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BCF1F2A44A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D01353F5;
	Wed,  6 Mar 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ff16X58d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2C13175F;
	Wed,  6 Mar 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739860; cv=none; b=i5kIgfFnunEwJNZraVRBvJfc28icMQ2M8PB4JnlEInC0s13AGiLpj2sAxI9PYbr9zMAouhVCNx7mG0WrIV15tBMyS2LcAPE7nOqtg4U5idaaRONdbgA99FSAx99+D/t3P9QFg4BQRKHsKFE8/1z1JmRECBj9T5PHlp3lgFOx91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739860; c=relaxed/simple;
	bh=o5tGBwakNL1GHUnA3SZuy7tj0ORXAvss4hL0Ws3LNmc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V+YIphqOE9e27RCl1wXcUG7t87xNFkotPlOw5bXzF9qouLRA/pPWt2Dg0jHEW546dlfKrImgzlgpJ/k1MHWK9Sx0cwl6AGlYrVqNDd/croox8y99sI10vdxjHVQmC0uxIO5g/M2CizTRnUtoRfaUyLRO1H1jAgy13DVXCv7IZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ff16X58d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709739859; x=1741275859;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=o5tGBwakNL1GHUnA3SZuy7tj0ORXAvss4hL0Ws3LNmc=;
  b=ff16X58drXNNDAhIacr5hp+t5YcUI8A1jRaqX5V5d/fwOngSS4jigDD3
   DDYgDKl95j67oaCHDECBgk9WDKWRk/bV/L00YnZDFqmVMhBnQG0Xv2PU3
   BciqCQCaLrXCoOxICrl8AYhRUWQWp1exbdR0fOx93TxnqtVZmBktIs25J
   x25f23OxjDtR9JiJciAJ44D6O5Vu5pGW8VQkxOPa2riOA2yDhDiDXCk4j
   ymm6yMGqA91s31kiqWCZI+YE8GzVyJAcL+C54/oa2JeRHq3iaCmoy8/Yu
   9w6oBosrbvmrjBU/rOfso0oZv3eQ1TgAyKSz9w7DwrFFTlXM5/0jH7kYg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="21812076"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="21812076"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 07:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14360260"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 07:44:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Mar 2024 17:44:11 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Use the correct bit in Link Training not active
 check
In-Reply-To: <alpine.DEB.2.21.2403060951310.43702@angie.orcam.me.uk>
Message-ID: <01666075-504d-a434-d039-2e25db931f23@linux.intel.com>
References: <20240301150641.4037-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2403011622560.42226@angie.orcam.me.uk> <c740c6e4-ca1a-33ad-8437-4a1219c16eb1@linux.intel.com> <alpine.DEB.2.21.2403060951310.43702@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-376951620-1709737480=:1022"
Content-ID: <0788f6d6-895c-36ff-ac83-a3e053dc0f78@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-376951620-1709737480=:1022
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b7a297db-e162-1f79-03f7-9dff695ed070@linux.intel.com>

On Wed, 6 Mar 2024, Maciej W. Rozycki wrote:
> On Mon, 4 Mar 2024, Ilpo J=E4rvinen wrote:
>=20
> > > > Since waiting for Data Link Layer Link Active bit is only used for =
the
> > > > Target Speed quirk, this only impacts the case when the quirk attem=
pts
> > > > to restore speed to higher than 2.5 GT/s (The link is Up at that po=
int
> > > > so pcie_retrain_link() will fail).
> > >=20
> > >  NAK.  It's used for both clamping and unclamping and it will break t=
he=20
> > > workaround, because the whole point there is to wait until DLLA has b=
een=20
> > > set.  Using LT is not reliable because it will oscillate in the failu=
re=20
> > > case and seeing the bit clear does not mean link has been established=
=2E =20
> >=20
> > In pcie_retrain_link(), there are two calls into=20
> > pcie_wait_for_link_status() and the second one of them is meant to=20
> > implement the link-has-been-established check.
> >=20
> > The first wait call comes from e7e39756363a ("PCI/ASPM: Avoid link=20
> > retraining race") and is just to ensure the link is not ongoing retrain=
ing=20
> > to make sure the latest configuration in captured as required by the=20
> > implementation note. LT being cleared is exactly what is wanted for tha=
t=20
> > check because it means that any earlier retraining has ended (a new one=
=20
> > might be starting but that doesn't matter, we saw it cleared so the new=
=20
> > configuration should be in effect for that instance of link retraining)=
=2E
> >=20
> > So my point is, the first check is not even meant to check that link ha=
s=20
> > been established.
>=20
>  I see what you mean, and I now remember the note in the spec.  I had=20
> concerns about it, but did not do anything about it at that point.
>=20
>  I think we still have no guarantee that LT will be clear at the point we=
=20
> set RL, because LT could get reasserted by hardware between our read and=
=20
> the setting of RL.
>
> IIUC that doesn't matter really, because the new link=20
> parameters will be taken into account regardless of whether retraining wa=
s
> initiated by hardware in an attempt to do link recovery or triggered by=
=20
> software via RL.

I, too, was somewhat worried about having LT never clear for long enough=20
to successfully sample it during the wait but it's like you say, any new=20
link training should take account the new Target Speed which should=20
successfully bring the link up (assuming the quirk works in the first=20
place) and that should clear LT.

> > Of course, I cannot test this with your configuration so I cannot=20
> > confirm how the target speed quirk behaves, I just found it by reading =
the=20
> > code. The current code does not make sense because the first wait is=20
> > supposed to wait for LT bit, not for DLLLA.
>=20
>  I think I now understand the problem correctly, and indeed from master=
=20
> Linux repo's point of view it's been a defect with the merge referred. =
=20
> So I withdraw my objection.  Sorry about the confusion.

Thanks, and the confusion was entirely my fault caused my confusing=20
and partly wrong wording.

>  However I think the last paragraph of your commit description:
>=20
> > Since waiting for Data Link Layer Link Active bit is only used for the
> > Target Speed quirk, this only impacts the case when the quirk attempts
> > to restore speed to higher than 2.5 GT/s (The link is Up at that point
> > so pcie_retrain_link() will fail).
>=20
> is not accurate enough, which contributed to my confusion.  In particular=
=20
> `pcie_retrain_link' succeeds when the link is up, because it calls=20
> `pcie_wait_for_link_status' such as to succeed when either LT is clear or=
=20
> DLLLA is set.

I know, it was simply wrong because I somehow misthought which way those=20
use_lt negations worked (and thus thought I found a different problem=20
than there really was).

I already did major rewriting here to explain out how the code ended up=20
into its current shape but I'll also consider your explanation below=20
which is likely better than what I've currently, thanks.

>  How about:
>=20
> This only impacts the Target Speed quirk, which is the only case where=20
> waiting for Data Link Layer Link Active bit is used.  It currently works=
=20
> in the problematic case by means of link training getting initiated by=20
> hardware repeatedly and respecting the new link parameters set by the=20
> caller, which then make training succeed and bring the link up, setting=
=20
> DLLLA and causing pcie_wait_for_link_status() to return success.  We are=
=20
> not supposed to rely on luck and need to make sure that LT transitioned
> through the inactive state though before we initiate link training by=20
> hand via RL.
>
> then?
>=20
>  Also for `pcie_retrain_link' I think it would be clearer if we rephrased=
=20
> the note as follows:
>=20
> =09 * Ensure the updated LNKCTL parameters are used during link
> =09 * training by checking that there is no ongoing link training
> =09 * that may have started before link parameters were changed, so
> =09 * as to avoid LTSSM race as recommended in Implementation Note
> =09 * at the end of PCIe r6.0.1 sec 7.5.3.7.
>=20
>  NB I am currently away on holiday until the end of next week.  However I=
=20
> do have access to my lab and I'll see if I can verify your change tonight
> or another evening this week, and overall thank you for your patience.

Don't worry. I can easily wait even until you're back from the holiday
so no need to push it or anything. :-)

--=20
 i.
--8323328-376951620-1709737480=:1022--

