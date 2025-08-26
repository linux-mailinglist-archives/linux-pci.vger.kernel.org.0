Return-Path: <linux-pci+bounces-34756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7AB3604F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 14:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE071BA5DFB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB5920F067;
	Tue, 26 Aug 2025 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBxPNHbZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF01EB9F2;
	Tue, 26 Aug 2025 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212955; cv=none; b=CPTfdkLLiYAwonuc5EfEA6emA0VJs324nP84E6TuuLTX57CZPog1Pj2YIeLmD/7sCK0kNEydX588paaparx3n3tRWHYl+HdQiXWah62un98YG6cLejkRa7swyLS56Di7pdVagM6p0UwSat7Iq9wsG31iaI2q5kEE+N0o+TyKxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212955; c=relaxed/simple;
	bh=R4iU1jfyixe8o3Lo4PGR4XGLQyegIIrVAMccWj8FMcM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qHe0JwpRQSdaC1WmgYLEiQfa8WanAilnvZTRl2phrjwizOLHLQdd5QDoBabESbza0kdTKtW85b+70O4MDeR5xNAijabeF/hNJv3t7XUSIlaujD/aKcY2hGoRBOrtNzjhh5lBNtLq3tpWewKtcjB83c5rxbldgkrplvnWJARSp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBxPNHbZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756212954; x=1787748954;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=R4iU1jfyixe8o3Lo4PGR4XGLQyegIIrVAMccWj8FMcM=;
  b=lBxPNHbZi6luuGmdMBVp+xWKYwCA17hjKPbfm6mLYbIywgk2+d/aemzx
   X2z9F2k+svnMkoWEQ9a0d8wNPCn8ehUh8WjuKNd+Glai8GY89BWS4s7kx
   ItHg56FZ5eU0KX6FJRC9VGvOOfaZ5lU3Zd7Q9WuvTZeO/8+nU7vJK3pYy
   hAlXSdPWm7HPgVc+LcuQGS2P6u3xI1IXypRJqdMeCOWhnz59mdmlU92Lk
   PnAebwJWM/T9pywa4CA5RX5jCAEEYpV0XQsbL9+s9g2Eq4F57j/LQAjVN
   Ac8JPCzyWBPfmLoseb+hKaKZlAsRp30z2cwTUfi4L+R3ByzW6JJZEiAj6
   g==;
X-CSE-ConnectionGUID: Xy+l5tuITeeChhUapWtAng==
X-CSE-MsgGUID: C+/6LF5xTm+A4cu4N22uBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69814749"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69814749"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 05:55:53 -0700
X-CSE-ConnectionGUID: auHUum6tRHS2IljYMCxSQg==
X-CSE-MsgGUID: o1h+Y04mS+OxNUWKpynnLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="206733326"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.4])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 05:55:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 26 Aug 2025 15:55:42 +0300 (EEST)
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
    David Box <david.e.box@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
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
In-Reply-To: <20250825-ath-aspm-fix-v2-2-61b2f2db7d89@oss.qualcomm.com>
Message-ID: <f644fc83-31cc-1f0e-58cf-7c007e6173e4@linux.intel.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com> <20250825-ath-aspm-fix-v2-2-61b2f2db7d89@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-846575285-1756206986=:934"
Content-ID: <ed51a60b-2da2-8824-e685-a71851c626aa@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-846575285-1756206986=:934
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <96a2aa14-031e-f827-2cad-088a1b047808@linux.intel.com>

+David

On Mon, 25 Aug 2025, Manivannan Sadhasivam via B4 Relay wrote:

> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>=20
> pci_enable_link_state() and pci_enable_link_state_locked() APIs are
> supposed to be symmectric with pci_disable_link_state() and
> pci_disable_link_state_locked() APIs.
>=20
> But unfortunately, they are not symmetric. This behavior was mentioned in
> the kernel-doc of these APIs:
>=20
> " Clear and set the default device link state..."
>=20
> and
>=20
> "Also note that this does not enable states disabled by
> pci_disable_link_state()"
>=20
> These APIs won't enable all the states specified by the 'state' parameter=
,
> but only enable the ones not previously disabled by the
> pci_disable_link_state*() APIs. But this behavior doesn't align with the
> naming of these APIs, as they give the impression that these APIs will
> enable all the specified states.
>=20
> To resolve this ambiguity, allow these APIs to enable the specified state=
s,
> regardeless of whether they were previously disabled or not. This is
> accomplished by clearing the previously disabled states from the
> 'link::aspm_disable' parameter in __pci_enable_link_state() helper. Also,
> reword the kernel-doc to reflect this behavior.
>=20
> The current callers of pci_enable_link_state_locked() APIs (vmd and
> pcie-qcom) did not disable the ASPM states before calling this API. So it
> is evident that they do not depend on the previous behavior of this API a=
nd
> intend to enable all the specified states.

While it might be "safe" in the sense that ->aspm_disable is not set by=20
anything, I'm still not sure if overloading this function for two=20
different use cases is a good idea.

I'd like to hear David's opinion on this as he grasps the ->aspm_default=20
vs ->aspm_disable thing much better than I do.

> And the other API, pci_enable_link_state() doesn't have a caller for now,
> but will be used by the 'atheros' WLAN drivers in the subsequent commits.
>=20
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

This tag sound like I'm endorsing this approach which is not the case. I'd=
=20
prefer separate functions for each use case, setting aspm_default and=20
another for the enable state.

--=20
 i.

> Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.=
com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/pci/pcie/aspm.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index be9bd272057c3472f3e31dc9568340b19d52012a..fac46113a90c7fac6c97125e6=
a7e385045780005 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1459,6 +1459,7 @@ static int __pci_enable_link_state(struct pci_dev *=
pdev, int state, bool locked)
>  =09=09down_read(&pci_bus_sem);
>  =09mutex_lock(&aspm_lock);
>  =09link->aspm_default =3D pci_calc_aspm_enable_mask(state);
> +=09link->aspm_disable &=3D ~state;
>  =09pcie_config_aspm_link(link, policy_to_aspm_state(link));
> =20
>  =09link->clkpm_default =3D (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> @@ -1471,17 +1472,18 @@ static int __pci_enable_link_state(struct pci_dev=
 *pdev, int state, bool locked)
>  }
> =20
>  /**
> - * pci_enable_link_state - Clear and set the default device link state s=
o that
> - * the link may be allowed to enter the specified states. Note that if t=
he
> - * BIOS didn't grant ASPM control to the OS, this does nothing because w=
e can't
> - * touch the LNKCTL register. Also note that this does not enable states
> - * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> + * pci_enable_link_state - Enable device's link state
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + *
> + * Enable device's link state, so the link will enter the specified stat=
es.
> + * Note that if the BIOS didn't grant ASPM control to the OS, this does
> + * nothing because we can't touch the LNKCTL register.
>   *
>   * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates=
, per
>   * PCIe r6.0, sec 5.5.4.
>   *
> - * @pdev: PCI device
> - * @state: Mask of ASPM link states to enable
> + * Return: 0 on success, a negative errno otherwise.
>   */
>  int pci_enable_link_state(struct pci_dev *pdev, int state)
>  {
> @@ -1490,19 +1492,20 @@ int pci_enable_link_state(struct pci_dev *pdev, i=
nt state)
>  EXPORT_SYMBOL(pci_enable_link_state);
> =20
>  /**
> - * pci_enable_link_state_locked - Clear and set the default device link =
state
> - * so that the link may be allowed to enter the specified states. Note t=
hat if
> - * the BIOS didn't grant ASPM control to the OS, this does nothing becau=
se we
> - * can't touch the LNKCTL register. Also note that this does not enable =
states
> - * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> + * pci_enable_link_state_locked - Enable device's link state
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + *
> + * Enable device's link state, so the link will enter the specified stat=
es.
> + * Note that if the BIOS didn't grant ASPM control to the OS, this does
> + * nothing because we can't touch the LNKCTL register.
>   *
>   * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates=
, per
>   * PCIe r6.0, sec 5.5.4.
>   *
> - * @pdev: PCI device
> - * @state: Mask of ASPM link states to enable
> - *
>   * Context: Caller holds pci_bus_sem read lock.
> + *
> + * Return: 0 on success, a negative errno otherwise.
>   */
>  int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
>  {
>=20
>=20
--8323328-846575285-1756206986=:934--

