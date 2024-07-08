Return-Path: <linux-pci+bounces-9914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA432929EA2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BF62823F7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9882EAF9;
	Mon,  8 Jul 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqcgCVnp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD58C06;
	Mon,  8 Jul 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429480; cv=none; b=aNQj0VVjJs+/ZE7bCaqNZOC1Z9nCOnQpA9nNJ37ck7/m1O5KxoTuQfdkSPKXjpSNi0OAaqCLi6Ow1WuKa42m6BnWjleT/Tk6zU4bF78lY0BR6oh2ovqyrpQrxKphX4+nbxfm7RlsKZ80UCjslIvJNr5l3BrNqSsE/EQc3qDxqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429480; c=relaxed/simple;
	bh=0aI49ZEwUflNdgkB5KmEXIC466KnmIbQc17d0H6wyiU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=osKWboFTnp69XNse+EQO3hVt2cwHDXi4gvNoAEAbmUNSr13r1d6SGL6DnqhHNXU134pn1pvrSutpzJH/UHWWMJVDlGtUvODF3pjEcDNSQPYvwYhmDPaRUZYSTDjukb/sjPt6NsOr781ZNIqqB/fizZ20ZMFU1qlFTcfI46nF/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqcgCVnp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720429478; x=1751965478;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0aI49ZEwUflNdgkB5KmEXIC466KnmIbQc17d0H6wyiU=;
  b=aqcgCVnpKzoDolEw0GMjEa2sryv8aUSJi4rndyUe3Qpnh0jK1q9AKGXe
   WGGkKJXHLXnvMiy3e6wvM0LQN9141uSFpWuus8SyK8Uk08bkvh+a3i8XW
   ZcjOUVCA9Or+Gi81wWg69RM5Ni+xxjsE8eVhDLcLRJqpz/+gUuEW5g06r
   I3dDOii7+Klm0g1jDCn9C1mkyBZuLPRMrQB8X9bk3TsDpgfTUmmvzN/MH
   7GoEDBKsvkaJjKZ5SAsqVoEKspOWkpHcQHF0DKOws2as3Y8y9/UPhtyKH
   0hU1+F961LjAAaX5KUReSipPjUb1vv3AMNOTA01TQ6ZKkrYJi67T2v6gU
   w==;
X-CSE-ConnectionGUID: n3GQKVskT0GimjxTotXspA==
X-CSE-MsgGUID: DTq9CWWWQMuSC2MfGgmo0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17754111"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17754111"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 02:04:38 -0700
X-CSE-ConnectionGUID: q9lJAyFqTYyN1F2sobzr4w==
X-CSE-MsgGUID: VMNX/6kuSp24CnC+3hRKRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="47323026"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 02:04:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Jul 2024 12:04:31 +0300 (EEST)
To: daire.mcnamara@microchip.com
cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com, 
    robh@kernel.org, bhelgaas@google.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 1/3] PCI: microchip: Fix outbound address translation
 tables
In-Reply-To: <20240628115923.4133286-2-daire.mcnamara@microchip.com>
Message-ID: <6c879527-4578-e3b5-2cc2-cf0638901f24@linux.intel.com>
References: <20240628115923.4133286-1-daire.mcnamara@microchip.com> <20240628115923.4133286-2-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-728995024-1720429471=:1343"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-728995024-1720429471=:1343
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 28 Jun 2024, daire.mcnamara@microchip.com wrote:

> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
> three general-purpose Fabric Interface Controller (FIC) buses that
> encapsulate an AXI-M interface. That FIC is responsible for managing
> the translations of the upper 32-bits of the AXI-M address. On MPFS,
> the Root Port driver needs to take account of that outbound address
> translation done by the parent FIC bus before setting up its own
> outbound address translation tables.  In all cases on MPFS,
> the remaining outbound address translation tables are 32-bit only.
>=20
> Limit the outbound address translation tables to 32-bit only.
>=20
> This necessitates changing a size_t in mc_pcie_setup_window
> to a resource_size_t to avoid a compile error on 32-bit platforms.

Do you really mean "a compile error" here, that is, building 32-bit kernel=
=20
fails during compile stage? If not, it would be good to rephrase this line.

Other than that,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe contro=
ller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/c=
ontroller/pcie-microchip-host.c
> index 137fb8570ba2..47c397ae515a 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -23,6 +23,8 @@
>  /* Number of MSI IRQs */
>  #define MC_MAX_NUM_MSI_IRQS=09=09=0932
> =20
> +#define MC_OUTBOUND_TRANS_TBL_MASK=09=09GENMASK(31, 0)
> +
>  /* PCIe Bridge Phy and Controller Phy offsets */
>  #define MC_PCIE1_BRIDGE_ADDR=09=09=090x00008000u
>  #define MC_PCIE1_CTRL_ADDR=09=09=090x0000a000u
> @@ -933,7 +935,7 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *p=
ort)
> =20
>  static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 ind=
ex,
>  =09=09=09=09 phys_addr_t axi_addr, phys_addr_t pci_addr,
> -=09=09=09=09 size_t size)
> +=09=09=09=09 resource_size_t size)
>  {
>  =09u32 atr_sz =3D ilog2(size) - 1;
>  =09u32 val;
> @@ -983,7 +985,8 @@ static int mc_pcie_setup_windows(struct platform_devi=
ce *pdev,
>  =09=09if (resource_type(entry->res) =3D=3D IORESOURCE_MEM) {
>  =09=09=09pci_addr =3D entry->res->start - entry->offset;
>  =09=09=09mc_pcie_setup_window(bridge_base_addr, index,
> -=09=09=09=09=09     entry->res->start, pci_addr,
> +=09=09=09=09=09     entry->res->start & MC_OUTBOUND_TRANS_TBL_MASK,
> +=09=09=09=09=09     pci_addr,
>  =09=09=09=09=09     resource_size(entry->res));
>  =09=09=09index++;
>  =09=09}
> @@ -1117,9 +1120,8 @@ static int mc_platform_init(struct pci_config_windo=
w *cfg)
>  =09int ret;
> =20
>  =09/* Configure address translation table 0 for PCIe config space */
> -=09mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
> -=09=09=09     cfg->res.start,
> -=09=09=09     resource_size(&cfg->res));
> +=09mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & MC_OUTBOUN=
D_TRANS_TBL_MASK,
> +=09=09=09     0, resource_size(&cfg->res));
> =20
>  =09/* Need some fixups in config space */
>  =09mc_pcie_enable_msi(port, cfg->win);


--8323328-728995024-1720429471=:1343--

