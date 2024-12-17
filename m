Return-Path: <linux-pci+bounces-18600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1863E9F49FE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 12:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D9D168D92
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C31F2C5A;
	Tue, 17 Dec 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4tZtKqz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDD1F2385
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435228; cv=none; b=newRxSUyytShuMzyG89sjwD/3aBtMwm0happDoM/RhDgmsnIflWUw1egJUkvZpfmuDV3Jv7WNZYJyCBDOXOLpxVCdfbi5bRwWSLci5WmaJ8Ol5kpt5oQ5V8Ysa5IDbU2el4raoGk7Mcp8cFBMOpo+NlYH0FKyyZjhSiAc6tdqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435228; c=relaxed/simple;
	bh=dovFDGfh0oTg3T/Ws6pelYKX4I/ATheP2kHV4hFq6Mg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qDnKU6wRnpNMvnJy7KpijHf6xBngPQktHqEfkDiJu77TUwhtq4Lg0JZ3qy1Chvtxh4e5dcnDyWt0lGa3zHjd5em1F/dK570DxHRaCbEUJnlaj9f9yauBIXw2IwvPHl9kcBUMZkI8DtH8Csskiy06ny+MmGDZkzVeANU8QXKpvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4tZtKqz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734435225; x=1765971225;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dovFDGfh0oTg3T/Ws6pelYKX4I/ATheP2kHV4hFq6Mg=;
  b=R4tZtKqzSd/Z2CzvHPe8ujlsIBpL/1JVPE+/jINj2+uOy5waULXb/hJs
   TmHqXDLsBxghfAN9h7t9askGgHyUeHaMrvOpR2xJOjWdK3jlX7vfBQh21
   wbpKS5ZNJIawP3UFehpnhuUMLSSHIf772dy4hQc1OzUJuearLo7AeW0U/
   KjSrI0ytc05EK3EnMZ1tTYfSesd9Zd1491VB8r5Daxg4DNIjejfFJCXj2
   OOWD2BXm/fTqs7JkEQ0rcj+AMCUCCQghOgJQ2CljxEAvekNRsLT1ZUGyZ
   8zTgOe04zNGMGCR42oWd5SSFzQKTAFnT7LEeKqiJvOV6OWZZ3TZ01V7bJ
   w==;
X-CSE-ConnectionGUID: Us/sJYEUQKuwnvipDdHTYw==
X-CSE-MsgGUID: Wh0J4bANSNuYLGQp4XjxEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34177061"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="34177061"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 03:33:43 -0800
X-CSE-ConnectionGUID: 1BbLwNjXQKe33T0q/wBtuQ==
X-CSE-MsgGUID: nuCvQoyAT/qyDljTjer3wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="97403588"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 03:33:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Dec 2024 13:33:36 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Niklas Schnelle <niks@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v3 1/2] PCI: Honor Max Link Speed when determining
 supported speeds
In-Reply-To: <fe03941e3e1cc42fb9bf4395e302bff53ee2198b.1734428762.git.lukas@wunner.de>
Message-ID: <7bbd48eb-efaf-260f-ad8d-9fe7f2209812@linux.intel.com>
References: <cover.1734428762.git.lukas@wunner.de> <fe03941e3e1cc42fb9bf4395e302bff53ee2198b.1734428762.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-152149658-1734435216=:924"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-152149658-1734435216=:924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Dec 2024, Lukas Wunner wrote:

> The Supported Link Speeds Vector in the Link Capabilities 2 Register
> indicates the *supported* link speeds.  The Max Link Speed field in the
> Link Capabilities Register indicates the *maximum* of those speeds.
>=20
> pcie_get_supported_speeds() neglects to honor the Max Link Speed field an=
d
> will thus incorrectly deem higher speeds as supported.  Fix it.
>=20
> One user-visible issue addressed here is an incorrect value in the sysfs
> attribute "max_link_speed".
>=20
> But the main motivation is a boot hang reported by Niklas:  Intel JHL7540
> "Titan Ridge 2018" Thunderbolt controllers supports 2.5-8 GT/s speeds,
> but indicate 2.5 GT/s as maximum.  Ilpo recalls seeing this on more
> devices.  It can be explained by the controller's Downstream Ports
> supporting 8 GT/s if an Endpoint is attached, but limiting to 2.5 GT/s
> if the port interfaces to a PCIe Adapter, in accordance with USB4 v2
> sec 11.2.1:
>=20
>    "This section defines the functionality of an Internal PCIe Port that
>     interfaces to a PCIe Adapter. [...]
>     The Logical sub-block shall update the PCIe configuration registers
>     with the following characteristics: [...]
>     Max Link Speed field in the Link Capabilities Register set to 0001b
>     (data rate of 2.5 GT/s only).
>     Note: These settings do not represent actual throughput. Throughput
>     is implementation specific and based on the USB4 Fabric performance."
>=20
> The present commit is not sufficient on its own to fix Niklas' boot hang,
> but it is a prerequisite:  A subsequent commit will fix the boot hang by
> enabling bandwidth control only if more than one speed is supported.
>=20
> The GENMASK() macro used herein specifies 0 as lowest bit, even though
> the Supported Link Speeds Vector ends at bit 1.  This is done on purpose
> to avoid a GENMASK(0, 1) macro if Max Link Speed is zero.  That macro
> would be invalid as the lowest bit is greater than the highest bit.
> Ilpo has witnessed a zero Max Link Speed on Root Complex Integrated
> Endpoints in particular, so it does occur in practice.

Thanks for adding this extra information.

I'd also add reference to r6.2 section 7.5.3 which states those registers=
=20
are required for RPs, Switch Ports, Bridges, and Endpoints _that are not=20
RCiEPs_. My reading is that implies they're not required from RCiEPs.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Reported-by: Niklas Schnelle <niks@kernel.org>
> Tested-by: Niklas Schnelle <niks@kernel.org>
> Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d136=
9.camel@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35dc9f2..b730560 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6240,12 +6240,14 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  =09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
>  =09speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS;
> =20
> +=09/* Ignore speeds higher than Max Link Speed */
> +=09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +=09speeds &=3D GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
> +
>  =09/* PCIe r3.0-compliant */
>  =09if (speeds)
>  =09=09return speeds;
> =20
> -=09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> -
>  =09/* Synthesize from the Max Link Speed field */
>  =09if ((lnkcap & PCI_EXP_LNKCAP_SLS) =3D=3D PCI_EXP_LNKCAP_SLS_5_0GB)
>  =09=09speeds =3D PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
>=20
--8323328-152149658-1734435216=:924--

