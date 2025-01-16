Return-Path: <linux-pci+bounces-19963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A09E5A13B41
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AB93A64C5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95022ACCF;
	Thu, 16 Jan 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KT9SeX88"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1FD22A7E9;
	Thu, 16 Jan 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035556; cv=none; b=gIqkwSdSu8+LOOcVY34JVouBSe2JNw1yPbqSHE3VOLw9zGkqljUGGoZbfVhOeRxLVLnSTtR0jHmJnfoUZnPjXqISSfquYQ9IhwG+FNvFxsG/VBgwGwQdqpXYMppvIxvUMBhD4WNXW7GRETYeFCaNa3WNPVUF9wTl6I2+3+zikmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035556; c=relaxed/simple;
	bh=GmMZGm+EJvJa00cjNmjRzRyY+cidd/NriOcOvG5pad4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GITOEe26uu0vK/e4c7BR/RRagN0C5Eus+fj4/ZXEiPNCBK/FvV6q62tWwCoKtt3FJKmjxS759Hi70j4LI/R483Ach0Aj3mS9mxuonBNit5l/IdncWNdQhjyU6PKqj/EG5hczpEyKlcPrnA49iF9vCL0Dh5IoaXiLjJ2DBWMLth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KT9SeX88; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737035556; x=1768571556;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GmMZGm+EJvJa00cjNmjRzRyY+cidd/NriOcOvG5pad4=;
  b=KT9SeX88/vE/hANZl+9RWOXPm6gcZEBuS/bP/CAhWUsDN4mX5wv1GbjR
   BQhP1IfacsllnDhvCdIjKhCa1SudNkm9ci59rqxM1rzbtNP6ilr3xFVI3
   iaySxq0ZTY27DPbdxrmAXsir4C1IH2JfUWMPJrwFNzVz30g5X0OFNh65w
   nYVeJpSU74FsNhUQDx5YtpOeyUyeLzCHMrSYgg68DkG3t7pQFZh8q0G9B
   wsTjMeLCtHwV1fKwlICa8MWM6CGPTzwGNBkerQ/TaJg+Fbx4pf7WSHU9Z
   wdTSARNeemOVm6sqRwPXBozVmFYFf1k8NWdABRGLrVFYrL2m1riFYIKL6
   Q==;
X-CSE-ConnectionGUID: kkhnuDxqT/WrM36hw5WJ7Q==
X-CSE-MsgGUID: hrOfqje7SCKLxaENbClqHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="41185259"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="41185259"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:52:34 -0800
X-CSE-ConnectionGUID: qZRWdrVkSRKQ+usnV9prBA==
X-CSE-MsgGUID: 8QHx7i2USlGehLFVBYDJkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="110518556"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.116])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:52:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 16 Jan 2025 15:52:26 +0200 (EET)
To: Jiwei Sun <sjiwei@163.com>
cc: macro@orcam.me.uk, bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, helgaas@kernel.org, 
    Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    jiwei.sun.bj@qq.com, sunjw10@outlook.com
Subject: Re: [PATCH v2 1/2] PCI: Fix the wrong reading of register fields
In-Reply-To: <20250115134154.9220-2-sjiwei@163.com>
Message-ID: <8441fdc4-de28-a3ba-27d6-8a5351d4ea19@linux.intel.com>
References: <20250115134154.9220-1-sjiwei@163.com> <20250115134154.9220-2-sjiwei@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2131764559-1737035546=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2131764559-1737035546=:933
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 15 Jan 2025, Jiwei Sun wrote:

> From: Jiwei Sun <sunjw10@lenovo.com>
>=20
> The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just uses
> the link speed field of the registers. However, there are many other
> different function fields in the Link Control 2 Register or the Link
> Capabilities Register. If the register value is directly used by the two
> macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN=
).
>=20
> In order to avoid the above-mentioned potential issue, only keep link
> speed field of the two registers before using.
>
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>

Missing Fixes tag.

> ---
>  drivers/pci/pci.h | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..b7e5af859517 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -337,12 +337,13 @@ void pci_bus_put(struct pci_bus *bus);
> =20
>  #define PCIE_LNKCAP_SLS2SPEED(lnkcap)=09=09=09=09=09\
>  ({=09=09=09=09=09=09=09=09=09\
> -=09((lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :=09\
> -=09 (lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :=09\
> -=09 (lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :=09\
> -=09 (lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :=09\
> -=09 (lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :=09\
> -=09 (lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :=09\
> +=09u32 __lnkcap =3D (lnkcap) & PCI_EXP_LNKCAP_SLS;=09=09\
> +=09(__lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :=09\

It would be nice to have an empty line here and below as is in "normal=20
functions" (obviously the \ continuation at the end of the line is=20
required).

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

This is quite important fix IMO.

> +=09 __lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :=09\
> +=09 __lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :=09\
> +=09 __lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :=09\
> +=09 __lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :=09\
> +=09 __lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :=09\
>  =09 PCI_SPEED_UNKNOWN);=09=09=09=09=09=09\
>  })
> =20
> @@ -357,13 +358,16 @@ void pci_bus_put(struct pci_bus *bus);
>  =09 PCI_SPEED_UNKNOWN)
> =20
>  #define PCIE_LNKCTL2_TLS2SPEED(lnkctl2) \
> -=09((lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
> -=09 (lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
> -=09 (lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
> -=09 (lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
> -=09 (lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
> -=09 (lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
> -=09 PCI_SPEED_UNKNOWN)
> +({=09=09=09=09=09=09=09=09=09\
> +=09u16 __lnkctl2 =3D (lnkctl2) & PCI_EXP_LNKCTL2_TLS;=09\
> +=09(__lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
> +=09 __lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
> +=09 __lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
> +=09 __lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
> +=09 __lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
> +=09 __lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
> +=09 PCI_SPEED_UNKNOWN);=09=09=09=09=09=09\
> +})
> =20
>  /* PCIe speed to Mb/s reduced by encoding overhead */
>  #define PCIE_SPEED2MBS_ENC(speed) \
>=20


--=20
 i.

--8323328-2131764559-1737035546=:933--

