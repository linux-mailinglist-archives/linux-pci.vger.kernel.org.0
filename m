Return-Path: <linux-pci+bounces-7773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFE28CCF6B
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 11:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE741C215AC
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 09:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220BB13D28B;
	Thu, 23 May 2024 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xGt2xCZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57C13D51B;
	Thu, 23 May 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457051; cv=none; b=FPUbLkAzCaArRPTogRlfdyGZ6t9s4Iq7X/1NKP7Ds8zJKuHrsAwMJmuS7Mp3OnEOvzMx9qZ589L0yW9NFZ57m6ciW+xADUlJv8blTQwTS7EC/+3pl2jXV9OpIeECig8l6pVRaRWZw9VorxnB4hF4YY/I5xRkB4eBMb+Jl4xvGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457051; c=relaxed/simple;
	bh=JY2WbpEI+mWUW18lUIt92d13APRa1KMU3S+PnCTrQYY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKgKXv+WpN9snucgxaFgD4ZkDlZR0dvc30IPbo/3ivqQCJTBijYLecTxV27I7Qh6oq0GKqKtq3YCxZ5Bu4XvB/ILp4jWTbKcwoFCBGnAjEHQoKPvH4p04TvKcc8xRte/o6x7of+oQKSRatkj8WzP9AlSCsMgV/rNtIa/O9iVkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xGt2xCZZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716457049; x=1747993049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JY2WbpEI+mWUW18lUIt92d13APRa1KMU3S+PnCTrQYY=;
  b=xGt2xCZZw8T14V00c3PF6kJnYSvlkzn/WNWe1PJrV2kALZ7oIi++9PKv
   rxO/hemZTtp+ke78TYKGfISDagGHhGOViVANbWFE9xyRhu/OuyJSzBe/n
   mT3OA/eg0+FMNRqQiRJcxC8XFDuZqUoYXZ8bi9DvXKopB4Ntkc6W6udSJ
   04IxdUv2o7ZGjG4Q3UPgoAL5cBvyXoEmuh4Xm4ND0Tq+upZUIOPHhO3M5
   N8OUI3OpTM6Ry9jw0ItfCfCut0N1zIHhT0htKBdzPXlLdO8LlRqb7+aJC
   LaV0qwbkKrrHOCL+mRNtTImBI36H4VDyw+1wVgRR6y2JjPyUv561FV86d
   A==;
X-CSE-ConnectionGUID: HkvOnEM3TYyKWZsRs1HTVA==
X-CSE-MsgGUID: A7IIXf1OSrWGf5ZNODCYxQ==
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="asc'?scan'208";a="26488561"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2024 02:37:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 02:36:51 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 02:36:47 -0700
Date: Thu, 23 May 2024 10:36:29 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Minda Chen <minda.chen@starfivetech.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Conor Dooley <conor@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"Philipp Zabel" <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v16 08/22] PCI: microchip: Change the argument of
 plda_pcie_setup_iomems()
Message-ID: <20240523-scroll-sloping-a297ef0ab464@wendy>
References: <SHXPR01MB086345C911E227889E3A4211E6F42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <20240523023549.GA105928@bhelgaas>
 <SHXPR01MB08637281B32AEE455F030081E6F42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jqWlq/BhKECf1ah8"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB08637281B32AEE455F030081E6F42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>

--jqWlq/BhKECf1ah8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2024 at 09:22:01AM +0000, Minda Chen wrote:
> Hi Conor
>    Thanks for help us for this patch set !
>    I see mars dts have been merged to mainline, this version dts patch can not be merged
>    I will resend the dts patch on v6.10-rc1.

No worries, the dts patches in this series are long gone out of
patchwork anyway so I wouldn't have even tried to apply them ;)

Cheers,
Conor.

--jqWlq/BhKECf1ah8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk8OHAAKCRB4tDGHoIJi
0hGZAP9XeCytwAGiMDsRE76sT98+KIjp7JPfuV4CVnQSht2O6gD9EaIZJ/+EM0dy
O+M3hpVKvaItendrAIFPy+CvMDC6yw4=
=YxeV
-----END PGP SIGNATURE-----

--jqWlq/BhKECf1ah8--

