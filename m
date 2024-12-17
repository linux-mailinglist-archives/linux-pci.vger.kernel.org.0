Return-Path: <linux-pci+bounces-18601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695D9F4A02
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9407B1883A08
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7A1EBFE3;
	Tue, 17 Dec 2024 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3/rmqQM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16851DDA35
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435323; cv=none; b=ix0hbkuGRLQ4yUgaWglwVYyzdsSm2K+9x/nJ+QxBhEe3A9Q7VzjTv9tJ+GUmT2/G00lL8vq6u8pmWQwsKy8bfmSEta0YI3WRxyQvfaLC92a463qn5D8vlmB8uNmzB9bBoo5fGRO6kEoxsULK7NMQHggMrcEOPpPgLHkrjvbhsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435323; c=relaxed/simple;
	bh=KFHWe4yw4h/Z1XC4XDHfokrrpBQKfZVcMgaNhS+ege4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H/BKmjhmMaEETQx7bNx+MjKN+JlsP72fLEuggdfucOZ4E1fGPH4lOF7lJAogMAF70rWLy9p+zwAMI8MG8n+gTxm0TrbJ6JsxD+hpifSt4SXL2tz0ItsAIIFnoQ5RUlxstEGBR6DI5FHLor5OXsIdYggKhpVbpKdg567uWSGVXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3/rmqQM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734435322; x=1765971322;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KFHWe4yw4h/Z1XC4XDHfokrrpBQKfZVcMgaNhS+ege4=;
  b=M3/rmqQM3X4MNP1iIy/8Oye2MYFKjUT0+4b+oUZJ6t/V0HP6jQle8317
   0moq+78CcE/3dSVn8RIS+LMh9qQRPfuRzmvNmTG0Cvb4wo5js2PRiXPH0
   8OUoGg0zJT0jEU5mXdXkCgKR8cYlzZ+AtSemcIa0xD6QdcjGT0WMF1mxA
   E+OiStQPqolgQr85dN8aN75Yg7d88H/OxjoN7t2ed++enPLlfuLPQM7OA
   QwjG092le6e9ZjiDA6+66GEIV+6+4Ae2bbGyrqA+wlwnS4jPMWGglr5tT
   2tAe8Y3ncCJts7DW2dwWxTmpjgt8tXtg2B3PJx6/+v0yoM3MgDZPNrwMG
   Q==;
X-CSE-ConnectionGUID: kscvOvxkRTG8Qm4+wodEww==
X-CSE-MsgGUID: eaVaUAa6Q+6/KJ9Rl5Tp2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57335808"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="57335808"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 03:35:21 -0800
X-CSE-ConnectionGUID: T9XBm6uHTZyrIN8TDWEX4g==
X-CSE-MsgGUID: OjntznneQ+K5miOxU51UQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="98081350"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 03:35:18 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Dec 2024 13:35:15 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Niklas Schnelle <niks@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v3 2/2] PCI/bwctrl: Enable only if more than
 one speed is supported
In-Reply-To: <3564908a9c99fc0d2a292473af7a94ebfc8f5820.1734428762.git.lukas@wunner.de>
Message-ID: <4c66d934-58fa-cc6a-77bd-04be5f81f76e@linux.intel.com>
References: <cover.1734428762.git.lukas@wunner.de> <3564908a9c99fc0d2a292473af7a94ebfc8f5820.1734428762.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-339689917-1734435315=:924"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-339689917-1734435315=:924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Dec 2024, Lukas Wunner wrote:

> If a PCIe port only supports a single speed, enabling bandwidth control
> is pointless:  There's no need to monitor autonomous speed changes, nor
> can the speed be changed.
>=20
> Not enabling it saves a small amount of memory and compute resources,
> but also fixes a boot hang reported by Niklas:  It occurs when enabling
> bandwidth control on Downstream Ports of Intel JHL7540 "Titan Ridge 2018"
> Thunderbolt controllers.  The ports only support 2.5 GT/s in accordance
> with USB4 v2 sec 11.2.1, so the present commit works around the issue.
>=20
> PCIe r6.2 sec 8.2.1 prescribes that:
>=20
>    "A device must support 2.5 GT/s and is not permitted to skip support
>     for any data rates between 2.5 GT/s and the highest supported rate."
>=20
> Consequently, bandwidth control is currently only disabled if a port
> doesn't support higher speeds than 2.5 GT/s.  However the Implementation
> Note in PCIe r6.2 sec 7.5.3.18 cautions:
>=20
>    "It is strongly encouraged that software primarily utilize the
>     Supported Link Speeds Vector instead of the Max Link Speed field,
>     so that software can determine the exact set of supported speeds on
>     current and future hardware.  This can avoid software being confused
>     if a future specification defines Links that do not require support
>     for all slower speeds."
>=20
> In other words, future revisions of the PCIe Base Spec may allow gaps
> in the Supported Link Speeds Vector.  To be future-proof, don't just
> check whether speeds above 2.5 GT/s are supported, but rather check
> whether *more than one* speed is supported.
>=20
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe =
BW controller")
> Reported-by: Niklas Schnelle <niks@kernel.org>
> Tested-by: Niklas Schnelle <niks@kernel.org>
> Closes: https://lore.kernel.org/r/db8e457fcd155436449b035e8791a8241b0df40=
0.camel@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Jonathan Cameron <Jonthan.Cameron@huawei.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
>  drivers/pci/pcie/portdrv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 5e10306..02e7309 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -265,12 +265,14 @@ static int get_port_device_capability(struct pci_de=
v *dev)
>  =09    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>  =09=09services |=3D PCIE_PORT_SERVICE_DPC;
> =20
> +=09/* Enable bandwidth control if more than one speed is supported. */
>  =09if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
>  =09    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) {
>  =09=09u32 linkcap;
> =20
>  =09=09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
> -=09=09if (linkcap & PCI_EXP_LNKCAP_LBNC)
> +=09=09if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> +=09=09    hweight8(dev->supported_speeds) > 1)
>  =09=09=09services |=3D PCIE_PORT_SERVICE_BWCTRL;
>  =09}
> =20
>=20
--8323328-339689917-1734435315=:924--

