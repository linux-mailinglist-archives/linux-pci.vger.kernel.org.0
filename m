Return-Path: <linux-pci+bounces-2527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF37483AD94
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA6C1C25C5F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2597765D;
	Wed, 24 Jan 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMRd8K2r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019777C087;
	Wed, 24 Jan 2024 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110945; cv=none; b=ephc6MCXW7uRuZb2Du852efukWw1XgM5OaucGQR+PPG5N9CKkf16xgnxMdxVEejpPB2AIpvUu0UmbqanLzumKUOSZ1SAOHNnz3iakQ2hlCxsfWZZR+ctpBFoSE/4RFifmk4p4Vog5aDTf2OllXjHOrKwteicv0FkOWzqXM+FDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110945; c=relaxed/simple;
	bh=SBoWD63q8kLgyAD+GKynKP95gGumgebOok1RHetlrEc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SZ1cz2CaJsLNPzepycRGh8kQBPHVG9p2AZQfvtkTIcXxch8uX/FltLzBvEUrr7RmeFuPVc2p8dLyQnlhlrifaGgZUN+phmDK6F68iHIwdyPYYNysyxVEJN1xX0dOTM+9xppXrJb72SnwBiEICpY9QvFcy/fC70Mwmd/HZTKkBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMRd8K2r; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706110944; x=1737646944;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SBoWD63q8kLgyAD+GKynKP95gGumgebOok1RHetlrEc=;
  b=IMRd8K2r5vRPrGEedaOOiiOsYQ8B3mOcoEbjKN160vHvaaOOFgnxs33z
   w4DUigu0CVOXZVwvLW44hDP/m0owE6NR5pApps6stgQ/kUzlEbu/B2mng
   tfdv2Na7tTZveXCkmNlW6tBkqNyaB3m2BWecPeZISpWHV91yx2eWqLHU1
   XLNIdluPa4r9dLL53FiVce0/Fdrt2OqYF1WxkJChl/5uLdL55GlfZW/xZ
   qT5HF5hP9hy3C1tr5xVNdMNO0q7l1GfcyX1FzN2sjZIjpAVT3mfb2Cnm+
   aeItDzyNJlUYH+99ZCz/bqKugmeihELV7HsurXIvszLEF7XZY11oow0/H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401538485"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401538485"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 07:42:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20754382"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 07:42:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Jan 2024 17:42:14 +0200 (EET)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Jingoo Han <jingoohan1@gmail.com>, 
    Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI: dwc: Cleanup in dw_pcie_ep_raise_msi_irq()
In-Reply-To: <64ef42f0-5618-40fd-b715-0d412121045c@moroto.mountain>
Message-ID: <d38e9f8f-ade9-8e77-2d19-756f76ecec76@linux.intel.com>
References: <64ef42f0-5618-40fd-b715-0d412121045c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-442463817-1706110934=:1372"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-442463817-1706110934=:1372
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 24 Jan 2024, Dan Carpenter wrote:

> I recently changed the alignment code in dw_pcie_ep_raise_msix_irq().
> The code in dw_pcie_ep_raise_msi_irq() is similar so update it to match
> as well, just for consistency.  (No effect on runtime, just a cleanup).
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v4: style improvements
> v3: use ALIGN_DOWN()
> v2: new patch
>=20
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 51679c6702cf..d2de41f02a77 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -482,9 +482,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, =
u8 func_no,
>  =09=09reg =3D ep_func->msi_cap + PCI_MSI_DATA_32;
>  =09=09msg_data =3D dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  =09}
> -=09aligned_offset =3D msg_addr_lower & (epc->mem->window.page_size - 1);
> -=09msg_addr =3D ((u64)msg_addr_upper) << 32 |
> -=09=09=09(msg_addr_lower & ~aligned_offset);
> +=09msg_addr =3D ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> +
> +=09aligned_offset =3D msg_addr & (epc->mem->window.page_size - 1);
> +=09msg_addr =3D ALIGN_DOWN(msg_addr, epc->mem->window.page_size);

After you've added the #include in 1/2, for both patches:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-442463817-1706110934=:1372--

