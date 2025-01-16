Return-Path: <linux-pci+bounces-19947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070D8A1365F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 10:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E07F167BEB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA221D90A5;
	Thu, 16 Jan 2025 09:14:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725381D9A50
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737018840; cv=none; b=PqVpQkAdORXkWd/qJp3GidQ/cZN4DQSrPb+OG0e0nyUpA6h4XTR1Sn2lOLPpzPwTupoe98clR6Vj/FVhi+QujjY8BS70q+cnCoa44SQPhNiXDLXWPvxM27rVMCJYTEo4sY4Gc0GTPq3s9MAkF0XqHtm3V/qjLGJYr5XusWGANSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737018840; c=relaxed/simple;
	bh=h+427gIoDnHRh0KJqlXWKYSCbMZ9f8dduQRDEmp3hws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AM4HxH3x5C3USR+zoEbHGaqV6ALH/3auQoCJIA7ss58OUT5IOPdKE2YkhDXb6IVC10XqISCF/9gev7KRJl7g2ZR5Ycy8QZDoeSczEPuXuVLPrK9X5tHF+h6wEd8belxaXLje9EGZjefl4Vi0mf8qHQd7HLXLdCfbFgAdcMVzjIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tYLwa-00058V-Lt; Thu, 16 Jan 2025 10:13:40 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tYLwZ-000ECZ-0Y;
	Thu, 16 Jan 2025 10:13:39 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tYLwZ-00031z-0H;
	Thu, 16 Jan 2025 10:13:39 +0100
Message-ID: <1f143d85c24d4691299072d582142f36c018c878.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: mediatek-gen3: Remove leftover mac_reset assert
 for Airoha EN7581 SoC.
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>,  Jianjun Wang <jianjun.wang@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,  Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Date: Thu, 16 Jan 2025 10:13:39 +0100
In-Reply-To: <20250115-pcie-en7581-remove-mac_reset-v1-1-61c2652e189f@kernel.org>
References: 
	<20250115-pcie-en7581-remove-mac_reset-v1-1-61c2652e189f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

On Mi, 2025-01-15 at 18:58 +0100, Lorenzo Bianconi wrote:
> Remove a leftover assert for mac_reset line in mtk_pcie_en7581_power_up()=
.
> This is not armful since EN7581 does not requires mac_reset and
              ^ harmful

> mac_reset is not defined in EN7581 device tree.
>

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..0f64e76e2111468e6a453889e=
ad7fbc75804faf7 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -940,7 +940,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_p=
cie *pcie)
>  	 */
>  	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
>  				  pcie->phy_resets);
> -	reset_control_assert(pcie->mac_reset);

Is it ok to keep the mac_reset assert in mtk_pcie_power_down() ?

>  	/* Wait for the time needed to complete the reset lines assert. */
>  	msleep(PCIE_EN7581_RESET_TIME_MS);
>=20
> ---
> base-commit: d02e16e4e05d5d2530a4836ca92318c6a6b21b01

I can't find this commit, which tree is it on?

regards
Philipp

