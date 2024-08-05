Return-Path: <linux-pci+bounces-11302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2F947CD8
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 16:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9BC4B22666
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67A78297;
	Mon,  5 Aug 2024 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ybdskc+3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82CB39FE5;
	Mon,  5 Aug 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868265; cv=none; b=Ihxiq5hP8Pqop9uzuSmVTv3kZF9zWqPBza/G5RLnVyTPZxzaNY5pgaxvWovR4SaaTdhsY+VZ3LUm1ujFquKLtvGYlxiJTN7h8JZOBPaW7FybNK04K+Ig7i/EjmLLEwO6ciuA7Vkl4O34/VlEEVsGaCyAw9fF1ms09pPNFtKMAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868265; c=relaxed/simple;
	bh=A+ejUO0ucuD8rkWcqVcgovmJzievlnCHGnch/v9cG6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoXkcB0/kX2kQ9i+4nIE1AN/qXC9bzTlvKKWd/SZ4UyVcXgYj+62ogM/MvCbz95uQ8xHRIRRbmLpedvZIaKRRX8KQEgBzn4h1aRfUd6XX+KWdNoE35mKpxY45i74rOF9kVP5nVp7USo1PTajE/GzNGY6rKaPaAEZleDAmJziFnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ybdskc+3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722868264; x=1754404264;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A+ejUO0ucuD8rkWcqVcgovmJzievlnCHGnch/v9cG6Q=;
  b=Ybdskc+3/m0tKVk3OZwFuzYNUfc9CI4smDJbDfMmlTEzuwpHeCn/O5oE
   HMbL8vi9vV7KPmcWGumgksv2u85C6VBjAH5BMkXrVSAOGB/FEbd6wRT6l
   aY89L0TkAsLbb76NbvwxLlonpoBPA0UL3bYNrVBdm1QngyVZWEiAedlNf
   /GMmItJ8m2qx+H0Ej6Ao4/f56moFhjkV6li0dw9Kx8iVafyO4jmEqVjvl
   iXxwmLQv65KycTTcmAOtLpKVD2eXCB+7WUdAvBpZmcUa9l6WDatFclBxW
   MKsG68Fl+XnADzmI2CV+mRz8EMC8xqm9rjUUzd8Yt4Hdvx25JdrB1UhMz
   Q==;
X-CSE-ConnectionGUID: srJCOYTMS+iUpCXzW1Hn7g==
X-CSE-MsgGUID: jyDrna/qT3+kmD2lb7ultw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="46236818"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="46236818"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:30:51 -0700
X-CSE-ConnectionGUID: 6keIFrHNSxCUdsGhOh0BZw==
X-CSE-MsgGUID: V3hkeNUJSjaoQEVDF9ySdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="60546846"
Received: from unknown (HELO localhost) ([10.2.132.131])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:30:49 -0700
Date: Mon, 5 Aug 2024 07:30:47 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Pali =?UTF-8?Q?Roh=C3=A1r?= <pali@kernel.org>, Uwe
 =?UTF-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Aleksandr
 Mishin <amishin@t-argos.ru>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Anup Patel <apatel@ventanamicro.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Daire McNamara
 <daire.mcnamara@microchip.com>, Damien Le Moal <dlemoal@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Hou Zhiqiang
 <Zhiqiang.Hou@nxp.com>, Jianjun Wang <jianjun.wang@mediatek.com>, Jim
 Quinlan <jim2101024@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Jisheng
 Zhang <Jisheng.Zhang@synaptics.com>, Jon Hunter <jonathanh@nvidia.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>, Joyce Ooi
 <joyce.ooi@intel.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Koichiro Den
 <den@valinux.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Marc Zyngier
 <maz@kernel.org>, Michal Simek <michal.simek@amd.com>, Nicolas Saenz
 Julienne <nsaenz@kernel.org>, Niklas Cassel <cassel@kernel.org>, Nipun
 Gupta <nipun.gupta@amd.com>, Rob Herring <robh@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>, Shivamurthy Shastri
 <shivamurthy.shastri@linutronix.de>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas
 Gleixner <tglx@linutronix.de>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 12/15] PCI: vmd: Silence set affinity failed warning
Message-ID: <20240805073047.0000286a@linux.intel.com>
In-Reply-To: <20240723132958.41320-13-marek.vasut+renesas@mailbox.org>
References: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
	<20240723132958.41320-13-marek.vasut+renesas@mailbox.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 15:27:12 +0200
Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Use newly introduced MSI_FLAG_NO_AFFINITY, which keeps
> .irq_set_affinity unset and allows migrate_one_irq() code in
> cpuhotplug.c to exit right away, without printing "IRQ...: set
> affinity failed(-22)" warning.
>=20
> Remove .irq_set_affinity implementation which only return -EINVAL
> from this controller driver.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczy=C5=84ski" <kw@linux.com>
> Cc: "Pali Roh=C3=A1r" <pali@kernel.org>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Aleksandr Mishin <amishin@t-argos.ru>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Broadcom internal kernel review list
> <bcm-kernel-feedback-list@broadcom.com> Cc: Daire McNamara
> <daire.mcnamara@microchip.com> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Jianjun Wang <jianjun.wang@mediatek.com>
> Cc: Jim Quinlan <jim2101024@gmail.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Joyce Ooi <joyce.ooi@intel.com>
> Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Nipun Gupta <nipun.gupta@amd.com>
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-tegra@vger.kernel.org
> ---
> V4: - New patch
> ---
>  drivers/pci/controller/vmd.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>=20
> diff --git a/drivers/pci/controller/vmd.c
> b/drivers/pci/controller/vmd.c index a726de0af011f..bc849b0d9e8dc
> 100644 --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -204,22 +204,11 @@ static void vmd_irq_disable(struct irq_data
> *data) raw_spin_unlock_irqrestore(&list_lock, flags);
>  }
> =20
> -/*
> - * XXX: Stubbed until we develop acceptable way to not create
> conflicts with
> - * other devices sharing the same vector.
> - */
> -static int vmd_irq_set_affinity(struct irq_data *data,
> -				const struct cpumask *dest, bool
> force) -{
> -	return -EINVAL;
> -}
> -
>  static struct irq_chip vmd_msi_controller =3D {
>  	.name			=3D "VMD-MSI",
>  	.irq_enable		=3D vmd_irq_enable,
>  	.irq_disable		=3D vmd_irq_disable,
>  	.irq_compose_msi_msg	=3D vmd_compose_msi_msg,
> -	.irq_set_affinity	=3D vmd_irq_set_affinity,
>  };
> =20
>  static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
> @@ -326,7 +315,7 @@ static struct msi_domain_ops vmd_msi_domain_ops =3D
> {=20
>  static struct msi_domain_info vmd_msi_domain_info =3D {
>  	.flags		=3D MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS |
> -			  MSI_FLAG_PCI_MSIX,
> +			  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
>  	.ops		=3D &vmd_msi_domain_ops,
>  	.chip		=3D &vmd_msi_controller,
>  };

Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

Thanks.

