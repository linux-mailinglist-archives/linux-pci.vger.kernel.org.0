Return-Path: <linux-pci+bounces-2820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCC7842B0E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 18:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB61C20B01
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3714E2C2;
	Tue, 30 Jan 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmAuULQF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA914D42D;
	Tue, 30 Jan 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636029; cv=none; b=If50Fs12w2Xgs0GQN/xhfVQ68/P2qhy081Z5fvtjsjLIfN7Rf3L1aKlLNURcXVHoudNFPfv8vQiBSly9/cy92TQw0KP2vJ05C5R6kZGltQtZi8WHhlOkhE2Gpr5o8Nbvg77RXxRXpFULuCmh0hqBJA3RiTHnXwcVBh9wKSVqhZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636029; c=relaxed/simple;
	bh=8y+JtA3p8jEEm3d08iS6Ys4QTmjqBCUJKENj1h5OFiI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VDjOXMAO6kt8iGkvwkwUZL2p44tBatwlVur0XTq7fVOo7OiKm4uKcynHWtCsevLvDACvwBa3AWlDGuYP8tueFHiISISg89uJOdmkmmvlawOAuvC0xP8Gc6g1K8YJcY3tlOOhRCLLYcTayIbjNCPIjrouz5LISq/iFSvegDpYq2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmAuULQF; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706636027; x=1738172027;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8y+JtA3p8jEEm3d08iS6Ys4QTmjqBCUJKENj1h5OFiI=;
  b=JmAuULQFeuQJ2ner7n2uJQGBZrJJYEynZx03xXjWdgVzDECkvQyggSff
   4gEkrYG4/MCcGIcclAhiC/0lXu13Cf+yApi9KYDqYhyzvOgNVqBebUovN
   3nA6VHRh/TAL/kjk1BUzbiWZKanurqVs/LofYioSFUWzTKmgHuEJ/nM8i
   MYUlFePqa3b0zZJn7B4xaqmnRhfwlp6n1CnEPfdrQCo6B2egHCfbuSdmc
   w3Wdx3U2qR+qWe4sKBeDVlSmW54pW97mul1D4TBkehwwv0q+LLZDICsqf
   XGEZCocjZwQYYDbX257L2WxLTyKsfzE0PPPW6QPIA4mwwaRcvsUhD/wP9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="400498088"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="400498088"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:33:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="36564490"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.252])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:33:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Jan 2024 19:33:39 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk>
Message-ID: <a7ff7695-77c5-cf5a-812a-e24b716c3842@linux.intel.com>
References: <20240129184354.GA470131@bhelgaas> <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com> <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1129339086-1706636019=:1000"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1129339086-1706636019=:1000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 30 Jan 2024, Maciej W. Rozycki wrote:

> On Tue, 30 Jan 2024, Ilpo J=C3=A4rvinen wrote:
>=20
> > First of all, this is not true for pcie_failed_link_retrain():
> >  * Return TRUE if the link has been successfully retrained, otherwise F=
ALSE.
> > If LBMS is not set, the Target Speed quirk is not applied but the funct=
ion=20
> > still returns true. I think that should be changed to early return fals=
e
> > when no LBMS is present.
>=20
>  I think there is a corner case here indeed.  If Link Active reporting is=
=20
> supported and neither DLLLA nor LBMS are set at entry, then the function=
=20
> indeed returns success even though the link is down and no attempt to=20
> retrain will have been made.  So this does indeed look a case for a retur=
n=20
> with the FALSE result.
>=20
>  I think most easily this can be sorted by delegating the return result t=
o=20
> a temporary variable, preset to FALSE and then only updated from results=
=20
> of the calls to `pcie_retrain_link'.  I can offer a patch as the author o=
f=20
> the code and one who has means to verify it right away if that helped.

I already wrote a patch which addresses this together with the caller=20
site changes.

>  Overall I guess it's all legacy of how this code evolved before it's bee=
n=20
> finally merged.

Indeed, it looks the step by step changed didn't yield good result here.

> > > >   3. pci_bridge_wait_for_secondary_bus() then calls pci_dev_wait() =
which
> > > >      cannot succeed (but waits ~1 minute, delaying the resume).
> > > >=20
> > > > The Target Speed trick (in step 2) is only used if LBMS bit (PCIe r=
6.1
> > > > sec 7.5.3.8) is set. For links that have been operational before
> > > > suspend, it is well possible that LBMS has been set at the bridge a=
nd
> > > > remains on. Thus, after resume, LBMS does not indicate the link nee=
ds
> > > > the Target Speed quirk. Clear LBMS on resume for bridges to avoid t=
he
> > > > issue.
>=20
>  This can be problematic AFAICT however.  While I am not able to verify=
=20
> suspend/resume operation with my devices, I expect the behaviour to be=20
> exactly the same after resume as after a bus reset: the link will fail to=
=20
> negotiate and the LBMS and DLLLA bits will be respectively set and clear.=
 =20
> Consequently if you clear LBMS at resume, then the workaround won't=20
> trigger and the link will remain inoperational in its limbo state.

How do you get the LBMS set in the first place? Isn't that because the=20
link tries to come up so shouldn't it reassert that bit again before the=20
code ends up into the target speed quirk? That is, I assumed you actually=
=20
wanted to detect LBMS getting set during pcie_wait_for_link_status() call=
=20
preceeding pcie_failed_link_retrain() call?

There's always an option to store it into pci_dev for later use when the=20
quirk is found to be working for the first time if other solutions don't=20
work.

In any case and unrelated to this patch, the way this quirk monopolizes=20
LBMS bit is going to have to be changed because it won't be reliable with=
=20
the PCIe BW controller that sets up and irq for LBMS (and clears the bit).
In bwctrl v5 (yet to be posted) I'll add LBMS counter into bwctrl to allow=
=20
this quirk to keep working (which will need to be confirmed).

>  What kind of scenario does the LBMS bit get set in that you have a=20
> trouble with?  You write that in your case the downstream device has been=
=20
> disconnected while the bug hierarchy was suspended and it is not present=
=20
> anymore at resume, is that correct?
>
>  But in that case no link negotiation could have been possible and=20
> consequently the LBMS bit mustn't have been set by hardware (according to=
=20
> my understanding of PCIe), because (for compliant, non-broken devices=20
> anyway) it is only specified to be set for ports that can communicate wit=
h=20
> the other link end (the spec explicitly says there mustn't have been a=20
> transition through the DL_Down status for the port).
>
>  Am I missing something?

Yes, when resuming the device is already gone but the bridge still has=20
LBMS set. My understanding is that it was set because it was there
from pre-suspend time but I've not really taken a deep look into it=20
because the problem and fix seemed obvious.

I read that "without the Port transitioning through DL_Down status"=20
differently than you, I only interpret that it relates to the two=20
bullets following it. ...So if retrain bit is set, and link then goes=20
down, the bullet no longer applies and LBMS should not be set because=20
there was transition through DL_Down. But I could well be wrong...

--=20
 i.

--8323328-1129339086-1706636019=:1000--

