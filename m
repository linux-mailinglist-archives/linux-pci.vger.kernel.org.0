Return-Path: <linux-pci+bounces-3345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06086851345
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 13:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70014B219DC
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D639FFD;
	Mon, 12 Feb 2024 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdMESjWk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9213A1A0;
	Mon, 12 Feb 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739902; cv=none; b=OGKRcSwLCQnBtq+/Mg6/TiebGYqx5ApPCcieq213985GH7YWYuSkAQRvVNL0Uf7aJG5f9l0DFQfcdiIIaR8CFEp2xSZqjpmK8aXbZ7Gf1JnLFqTLVG/A9mSHW/7XYAWnekVfgjiKIYP2/Ss4IVbAbfc+JnCp8EDuslM6AjwnzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739902; c=relaxed/simple;
	bh=PfZZMPWmdWb5VMkivTxDsN/s28aAecflD0CMc9I8gc4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ofRZxtWp6pvcqlMYRg0Ag377x8I6ouGdahifBxiqwMolIdvySnIoQ3TMbKH7MzzoGiqnYZEtYLuSnX3mSMUROFOLQ1wTB4ic4GCOuPhEgjdlwiTRPHJZdLeYRe6B0vPe+0VtMxkZp48OTN9hmUImlRCSQwa2zUmiOrnYMnnCX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdMESjWk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739900; x=1739275900;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PfZZMPWmdWb5VMkivTxDsN/s28aAecflD0CMc9I8gc4=;
  b=EdMESjWkv4nHDMuUpvLoMo7H0Eap7v7vOU+MNnkdaKpWX8cOpXBIfPJv
   1KvqCb9hMCnllR4WhVw3CSdcsHkvrIIm0T+dZuHIChi76axR1H4DEddU/
   /YtXMT4mxVVBFSnRBCqac+AtkgEu8cHoZ9zt/afH/rJGsaG6QQrSQ8np0
   Q1imd1xdS4dzkmgURK53cbPWFXlpPVyvp/4WS3NpHqygexbQZSsDyERfn
   Xw6se+f3Q8QJZ02SGZXRwLyq2jn9xvLkkU76Ws1PhcCZ6Y/nCZE3SJvJ8
   T2atqbLa6oZZ6QkYzOFniFZ/s05dRIP8iPZIg3q1tKOxj0grCtu2EtzDw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="2057607"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2057607"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:11:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2541515"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.160])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:11:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Feb 2024 14:11:32 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Use an error code with PCIe failed link
 retraining
In-Reply-To: <alpine.DEB.2.21.2402100048440.2376@angie.orcam.me.uk>
Message-ID: <855a5a56-75f2-2ce5-7f35-b761b62784e7@linux.intel.com>
References: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk> <alpine.DEB.2.21.2402100048440.2376@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1549470714-1707739892=:1013"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1549470714-1707739892=:1013
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 10 Feb 2024, Maciej W. Rozycki wrote:

> Given how the call place in `pcie_wait_for_link_delay' got structured=20
> now, and that `pcie_retrain_link' returns a potentially useful error=20
> code, convert `pcie_failed_link_retrain' to return an error code rather=
=20
> than a boolean status, fixing handling at the call site mentioned. =20
> Update the other call site accordingly.
>=20
> Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
> Reported-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linu=
x.intel.com/
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # v6.5+
> ---
>  drivers/pci/pci.c    |    2 +-
>  drivers/pci/pci.h    |    6 +++---
>  drivers/pci/quirks.c |   14 +++++++-------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>=20
> linux-pcie-failed-link-retrain-status-int.diff
> Index: linux-macro/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-macro.orig/drivers/pci/pci.c
> +++ linux-macro/drivers/pci/pci.c
> @@ -1263,7 +1263,7 @@ static int pci_dev_wait(struct pci_dev *
>  =09=09if (delay > PCI_RESET_WAIT) {
>  =09=09=09if (retrain) {
>  =09=09=09=09retrain =3D false;
> -=09=09=09=09if (pcie_failed_link_retrain(bridge)) {
> +=09=09=09=09if (pcie_failed_link_retrain(bridge) =3D=3D 0) {
>  =09=09=09=09=09delay =3D 1;
>  =09=09=09=09=09continue;
>  =09=09=09=09}
> Index: linux-macro/drivers/pci/pci.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-macro.orig/drivers/pci/pci.h
> +++ linux-macro/drivers/pci/pci.h
> @@ -540,7 +540,7 @@ void pci_acs_init(struct pci_dev *dev);
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
>  int pci_dev_specific_enable_acs(struct pci_dev *dev);
>  int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
> -bool pcie_failed_link_retrain(struct pci_dev *dev);
> +int pcie_failed_link_retrain(struct pci_dev *dev);
>  #else
>  static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
>  =09=09=09=09=09       u16 acs_flags)
> @@ -555,9 +555,9 @@ static inline int pci_dev_specific_disab
>  {
>  =09return -ENOTTY;
>  }
> -static inline bool pcie_failed_link_retrain(struct pci_dev *dev)
> +static inline int pcie_failed_link_retrain(struct pci_dev *dev)
>  {
> -=09return false;
> +=09return -ENOTTY;
>  }
>  #endif
> =20
> Index: linux-macro/drivers/pci/quirks.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-macro.orig/drivers/pci/quirks.c
> +++ linux-macro/drivers/pci/quirks.c
> @@ -74,17 +74,17 @@
>   * firmware may have already arranged and lift it with ports that alread=
y
>   * report their data link being up.
>   *
> - * Return TRUE if the link has been successfully retrained, otherwise FA=
LSE,
> + * Return 0 if the link has been successfully retrained, otherwise an er=
ror,
>   * also when retraining was not needed in the first place.
>   */
> -bool pcie_failed_link_retrain(struct pci_dev *dev)
> +int pcie_failed_link_retrain(struct pci_dev *dev)
>  {
>  =09static const struct pci_device_id ids[] =3D {
>  =09=09{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
>  =09=09{}
>  =09};
>  =09u16 lnksta, lnkctl2;
> -=09bool ret =3D false;
> +=09int ret =3D -ENOTTY;
> =20
>  =09if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
>  =09    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
> @@ -100,8 +100,8 @@ bool pcie_failed_link_retrain(struct pci
>  =09=09lnkctl2 |=3D PCI_EXP_LNKCTL2_TLS_2_5GT;
>  =09=09pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> =20
> -=09=09ret =3D pcie_retrain_link(dev, false) =3D=3D 0;
> -=09=09if (!ret) {
> +=09=09ret =3D pcie_retrain_link(dev, false);
> +=09=09if (ret) {
>  =09=09=09pci_info(dev, "retraining failed\n");
>  =09=09=09return ret;
>  =09=09}
> @@ -120,8 +120,8 @@ bool pcie_failed_link_retrain(struct pci
>  =09=09lnkctl2 |=3D lnkcap & PCI_EXP_LNKCAP_SLS;
>  =09=09pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> =20
> -=09=09ret =3D pcie_retrain_link(dev, false) =3D=3D 0;
> -=09=09if (!ret) {
> +=09=09ret =3D pcie_retrain_link(dev, false);
> +=09=09if (ret) {
>  =09=09=09pci_info(dev, "retraining failed\n");
>  =09=09=09return ret;
>  =09=09}

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

I closed my patch from patchwork that is not need after this change.

--=20
 i.

--8323328-1549470714-1707739892=:1013--

