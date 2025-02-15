Return-Path: <linux-pci+bounces-21540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1D9A36C71
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 08:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0A91887C3D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3D9193436;
	Sat, 15 Feb 2025 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDfN4wbA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C01922DE;
	Sat, 15 Feb 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739604888; cv=none; b=NU7FtkhG9OkEV7B3QiouT14ko9D8HU1d3+5YlDq1T5fNUpzUzZcI/VzQwYAsSwcQfqZ49rsuHzvh79SxKtd4vfSLQcZGFc7DJfe7qAbOz659FkXgqDjgKWvoFGzrNK3dCo7+0GYhZuKR6tJiEdITY3FnFf76GjPsMj8zozqckDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739604888; c=relaxed/simple;
	bh=Nie6374pQr7FVzBWNLJ7RHDrHqIfGLRoboxl4wgtWys=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ac/MZntZuceiBxv7VDgrx/nqxDE1wpo0K8Ke7lVkh3CJqq8Xu/FqX3cfPgo2AyQ5P/x+zaiu6Jalc7/TdQwYd9NfhoT1+jN/FSmshMtwkUz2qV0lMPkJpI8VN0AXhvA14Kvu+qf8bfxm+r8/P8/YE7dC1T+OsS5/DkcVib+AtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDfN4wbA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739604887; x=1771140887;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nie6374pQr7FVzBWNLJ7RHDrHqIfGLRoboxl4wgtWys=;
  b=RDfN4wbAV1O3a0rgvsmckZkZxwDT2dAjzoYloEeL95u+3JSuhhkrsKtq
   PlVB5D1xM6zYCSEwF1MzTNtsJsGyHGsu38/6IXcb3FkIqvfb2rb4cajtX
   7VXGxHkghqqbU60Q5+BF2jPCi5B4z37jhKuFbhcZJLwz5YA0T+c+meV8t
   4Eg47UV/4hfIM31jF/KHJbWgE98kIg1y5pB4ddfaXgmzHkpFU2ClIugGS
   QvQ3fLWkVoq1MNtU5S2fdhiT2JKXkq3J6Ngg8hVTU6KyKO5lj3Ksxys0D
   QZS3bkpUCJMpZoKHEEN+GW0Q4SCBt1T3gO4jwiXgsjF8At79tuQXNsY6N
   w==;
X-CSE-ConnectionGUID: aAJEJXloQhifpive/CJ5iw==
X-CSE-MsgGUID: ifgyA/slTPCo09/N6Dbdug==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="62825470"
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="62825470"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 23:34:46 -0800
X-CSE-ConnectionGUID: LX5TTBU2Qd6cQVilcQ3ung==
X-CSE-MsgGUID: QweCwAf+RlC6RKFhvdQR7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118572929"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 23:34:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sat, 15 Feb 2025 09:34:39 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] PCI: Avoid pointless capability searches
In-Reply-To: <20250215000301.175097-2-helgaas@kernel.org>
Message-ID: <b6dc9011-8a12-9ab9-14e9-eec7a85f5f7b@linux.intel.com>
References: <20250215000301.175097-1-helgaas@kernel.org> <20250215000301.175097-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1335142543-1739604879=:3981"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1335142543-1739604879=:3981
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 14 Feb 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Many of the save/restore functions in the pci_save_state() and
> pci_restore_state() paths depend on both a PCI capability of the device a=
nd
> a pci_cap_saved_state structure to hold the configuration data, and they
> skip the operation if either is missing.
>=20
> Look for the pci_cap_saved_state first so if we don't have one, we can sk=
ip
> searching for the device capability, which requires several slow config
> space accesses.
>=20
> Remove some error messages if the pci_cap_saved_state is not found so we
> don't complain about having no saved state for a capability the device
> doesn't have.  We have already warned in pci_allocate_cap_save_buffers() =
if
> the capability is present but we were unable to allocate a buffer.
>=20
> Other than the message change, no functional change intended.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c       | 27 ++++++++++++++-------------
>  drivers/pci/pcie/aspm.c | 15 ++++++++-------
>  2 files changed, 22 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..503376bf7e75 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1686,10 +1686,8 @@ static int pci_save_pcie_state(struct pci_dev *dev=
)
>  =09=09return 0;
> =20
>  =09save_state =3D pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> -=09if (!save_state) {
> -=09=09pci_err(dev, "buffer not found in %s\n", __func__);
> +=09if (!save_state)
>  =09=09return -ENOMEM;
> -=09}
> =20
>  =09cap =3D (u16 *)&save_state->cap.data[0];
>  =09pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &cap[i++]);
> @@ -1742,19 +1740,17 @@ static void pci_restore_pcie_state(struct pci_dev=
 *dev)
> =20
>  static int pci_save_pcix_state(struct pci_dev *dev)
>  {
> -=09int pos;
>  =09struct pci_cap_saved_state *save_state;
> +=09u8 pos;
> +
> +=09save_state =3D pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> +=09if (!save_state)
> +=09=09return -ENOMEM;
> =20
>  =09pos =3D pci_find_capability(dev, PCI_CAP_ID_PCIX);
>  =09if (!pos)
>  =09=09return 0;
> =20
> -=09save_state =3D pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> -=09if (!save_state) {
> -=09=09pci_err(dev, "buffer not found in %s\n", __func__);
> -=09=09return -ENOMEM;
> -=09}
> -
>  =09pci_read_config_word(dev, pos + PCI_X_CMD,
>  =09=09=09     (u16 *)save_state->cap.data);
> =20
> @@ -1763,14 +1759,19 @@ static int pci_save_pcix_state(struct pci_dev *de=
v)
> =20
>  static void pci_restore_pcix_state(struct pci_dev *dev)
>  {
> -=09int i =3D 0, pos;
>  =09struct pci_cap_saved_state *save_state;
> +=09u8 pos;
> +=09int i =3D 0;
>  =09u16 *cap;
> =20
>  =09save_state =3D pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> -=09pos =3D pci_find_capability(dev, PCI_CAP_ID_PCIX);
> -=09if (!save_state || !pos)
> +=09if (!save_state)
>  =09=09return;
> +
> +=09pos =3D pci_find_capability(dev, PCI_CAP_ID_PCIX);
> +=09if (!pos)
> +=09=09return;
> +
>  =09cap =3D (u16 *)&save_state->cap.data[0];
> =20
>  =09pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index e0bc90597dca..007e4a082e6f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -35,16 +35,14 @@ void pci_save_ltr_state(struct pci_dev *dev)
>  =09if (!pci_is_pcie(dev))
>  =09=09return;
> =20
> +=09save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +=09if (!save_state)
> +=09=09return;
> +
>  =09ltr =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
>  =09if (!ltr)
>  =09=09return;
> =20
> -=09save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> -=09if (!save_state) {
> -=09=09pci_err(dev, "no suspend buffer for LTR; ASPM issues possible afte=
r resume\n");
> -=09=09return;
> -=09}
> -
>  =09/* Some broken devices only support dword access to LTR */
>  =09cap =3D &save_state->cap.data[0];
>  =09pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
> @@ -57,8 +55,11 @@ void pci_restore_ltr_state(struct pci_dev *dev)
>  =09u32 *cap;
> =20
>  =09save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +=09if (!save_state)
> +=09=09return;
> +
>  =09ltr =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
> -=09if (!save_state || !ltr)
> +=09if (!ltr)
>  =09=09return;
> =20
>  =09/* Some broken devices only support dword access to LTR */
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1335142543-1739604879=:3981--

