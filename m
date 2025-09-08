Return-Path: <linux-pci+bounces-35655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E5B48A1C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 12:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348F21B25864
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 10:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAFD2F3617;
	Mon,  8 Sep 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHz1ADtk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C7136358;
	Mon,  8 Sep 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327088; cv=none; b=g6nk/L7da9ONahI+RUYqhh4zyjk0bTIW+3JzO13ak8xw3KsBq2GDaxCyzlgitkdAl0Q/YvOlFkG3TjXWNztRHZ9P5YHotbRHN31A+TR5TTm//mH+5qPh1El/BnIHooaFL7MffM6gptckg8o1JSBfc4+V0VPRXjZyb8oLpM65C7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327088; c=relaxed/simple;
	bh=3c4d46dbwYhFkAIji9CnButKaWApe47Fg8Mn2cBmfHg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UMvkLUy3Eg9sbJLEMp/shZyhOO2ejNs3crBbDNQ1z0mInqbEYhiJMI1a7qG8d3GqnfeqjI27ek/1aNzJJq4FSkHpIbUta9QXxi9Z5M21YblMEdrZGrEHUHGgy0FDcZ6RT/MjKO0coprbir9LKo4TzU2eVxl7drL0VZH4vv3Ovns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHz1ADtk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757327087; x=1788863087;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3c4d46dbwYhFkAIji9CnButKaWApe47Fg8Mn2cBmfHg=;
  b=LHz1ADtkFSQu+lucmUA3HCQo1eo6Ic71+5h7B4LJwTB2CF8yM/KqL2kB
   KS70hCtzBb4TFGRqC67flVKbnU9+ewrXkzNW5KhNvK7ArivurHSrQWPZ1
   B3rpoLASCvC1SMoCjCg9+3lGsH1enCwx1/lkVIS8GySzEYg0+UE7fFRoP
   QfPdb4vha8r5FlVGE9ZijOUvNII8InTI/k+/1+05Nq/EQVwzkcsEOjiRY
   lRY9Wp0qHGeimhUXbY4cccuOIY/EZShAtmAlpStN8KaG0qSq3fKS5USQ9
   yagOmWc1lSb0snymmZgL2gcbfZPRuVmoBvbtw4joiRpQ9far7qfWyTi5x
   Q==;
X-CSE-ConnectionGUID: LFYvIZzwRoaJ0WV6dyV7aw==
X-CSE-MsgGUID: qJ6cFAkTQ/G7bCex7kiDHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="69832941"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="69832941"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 03:24:46 -0700
X-CSE-ConnectionGUID: whEKi/v8TFudb7tIU+AjHA==
X-CSE-MsgGUID: U/YpIi0KRGSt2P0AfeFMvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="172875576"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.11])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 03:24:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Sep 2025 13:24:35 +0300 (EEST)
To: Manivannan Sadhasivam <mani@kernel.org>
cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
    David Box <david.e.box@linux.intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, 
    Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, 
    linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
    ath11k@lists.infradead.org, ath10k@lists.infradead.org, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/8] PCI/ASPM: Fix the behavior of pci_enable_link_state*()
 APIs
In-Reply-To: <67274gnjp4qy4h3bcawey2edmjiuufdbm262q2qxgcc76dwlic@hdjxqczr54nt>
Message-ID: <df354ae2-03bd-d17c-4e3a-9e62b248cc2a@linux.intel.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com> <20250825-ath-aspm-fix-v2-2-61b2f2db7d89@oss.qualcomm.com> <f644fc83-31cc-1f0e-58cf-7c007e6173e4@linux.intel.com> <67274gnjp4qy4h3bcawey2edmjiuufdbm262q2qxgcc76dwlic@hdjxqczr54nt>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1505528149-1757327075=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1505528149-1757327075=:938
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 6 Sep 2025, Manivannan Sadhasivam wrote:

> On Tue, Aug 26, 2025 at 03:55:42PM GMT, Ilpo J=C3=A4rvinen wrote:
> > +David
> >=20
> > On Mon, 25 Aug 2025, Manivannan Sadhasivam via B4 Relay wrote:
> >=20
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > >=20
> > > pci_enable_link_state() and pci_enable_link_state_locked() APIs are
> > > supposed to be symmectric with pci_disable_link_state() and
> > > pci_disable_link_state_locked() APIs.
> > >=20
> > > But unfortunately, they are not symmetric. This behavior was mentione=
d in
> > > the kernel-doc of these APIs:
> > >=20
> > > " Clear and set the default device link state..."
> > >=20
> > > and
> > >=20
> > > "Also note that this does not enable states disabled by
> > > pci_disable_link_state()"
> > >=20
> > > These APIs won't enable all the states specified by the 'state' param=
eter,
> > > but only enable the ones not previously disabled by the
> > > pci_disable_link_state*() APIs. But this behavior doesn't align with =
the
> > > naming of these APIs, as they give the impression that these APIs wil=
l
> > > enable all the specified states.
> > >=20
> > > To resolve this ambiguity, allow these APIs to enable the specified s=
tates,
> > > regardeless of whether they were previously disabled or not. This is
> > > accomplished by clearing the previously disabled states from the
> > > 'link::aspm_disable' parameter in __pci_enable_link_state() helper. A=
lso,
> > > reword the kernel-doc to reflect this behavior.
> > >=20
> > > The current callers of pci_enable_link_state_locked() APIs (vmd and
> > > pcie-qcom) did not disable the ASPM states before calling this API. S=
o it
> > > is evident that they do not depend on the previous behavior of this A=
PI and
> > > intend to enable all the specified states.
> >=20
> > While it might be "safe" in the sense that ->aspm_disable is not set by=
=20
> > anything, I'm still not sure if overloading this function for two=20
> > different use cases is a good idea.
> >=20
>=20
> Why? I thought your concern was with the callers of this API. Since that =
is
> taken care, do you have any other concerns?

I don't think it really matters anymore as it looks the vmd one is going=20
to be removed by the David's patch and the qcom one is removed by your patc=
h
so no users remain.

> > I'd like to hear David's opinion on this as he grasps the ->aspm_defaul=
t=20
> > vs ->aspm_disable thing much better than I do.
> >=20
> > > And the other API, pci_enable_link_state() doesn't have a caller for =
now,
> > > but will be used by the 'atheros' WLAN drivers in the subsequent comm=
its.
> > >=20
> > > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
> > This tag sound like I'm endorsing this approach which is not the case. =
I'd=20
> > prefer separate functions for each use case, setting aspm_default and=
=20
> > another for the enable state.
> >=20
>=20
> Sorry, I misunderstood then. I'll drop this tag.
>=20
> - Mani
>=20
>=20

--=20
 i.

--8323328-1505528149-1757327075=:938--

