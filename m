Return-Path: <linux-pci+bounces-17038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F849D0B32
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 09:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892911F22054
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 08:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115E815445D;
	Mon, 18 Nov 2024 08:49:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082F155333
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919773; cv=none; b=raTqPq52DT+yHfRK50QMuUHvz8jVfgx5jiknmQfbk5eXfXcqrHOeFjX5zgfLN5NCL0ubfDio7OzPKHQFj02aFh+6zuV/JeTXgsmKDpBg3YoHJNW2H43j3z3Y22db5G1+HAM8czI1Qdi4mOhL+VSoxuKleqd+CGwOgaslYvG3FO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919773; c=relaxed/simple;
	bh=TN6YzMywhtFni8t0CRIuqkUt5uz4fvw4DfILRs0HFFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gI1itngGCMLmHKQ6Cj6mmwn1MXPiqL+eNOfUwilf2ZbLAu4vQQNLFBD4lc4fFUHDbT4a3BRzRjTzC+8DciPy3rIY+7flzoUWBmIap5jsaQuT9wsf5c1YHVE6UlA1HSCIOQtZPJH8shPKbby1phXmNebCLUQpRL4SxaeRSX6yLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tCxRQ-00005E-Ef; Mon, 18 Nov 2024 09:49:04 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tCxRN-001MXm-0Q;
	Mon, 18 Nov 2024 09:49:01 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tCxRN-0002o6-0G;
	Mon, 18 Nov 2024 09:49:01 +0100
Message-ID: <2d7e1e5e09babb468199ac44520683fcb87d697c.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/6] PCI: mediatek-gen3: Move reset/assert callbacks
 in .power_up()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>,  Jianjun Wang <jianjun.wang@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,  Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date: Mon, 18 Nov 2024 09:49:01 +0100
In-Reply-To: <20241118-pcie-en7581-fixes-v4-3-24bb61703ad7@kernel.org>
References: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
	 <20241118-pcie-en7581-fixes-v4-3-24bb61703ad7@kernel.org>
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

On Mo, 2024-11-18 at 09:04 +0100, Lorenzo Bianconi wrote:
> In order to make the code more readable, the reset_control_bulk_assert()
> for PHY reset lines is moved to make it pair with
> reset_control_bulk_deassert() in mtk_pcie_power_up() and
> mtk_pcie_en7581_power_up(). The same change is done for
> reset_control_assert() used to assert MAC reset line.
>=20
> Introduce PCIE_MTK_RESET_TIME_US macro for the time needed to
> complete PCIe reset on MediaTek controller.
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 27 +++++++++++++++++++----=
----
>  1 file changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index 3cfcb45d31508142d28d338ff213f70de9b4e608..2b80edd4462ad4e9f2a5d192d=
b7f99307113eb8a 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -125,6 +125,8 @@
> =20
>  #define MAX_NUM_PHY_RESETS		3
> =20
> +#define PCIE_MTK_RESET_TIME_US		10
> +
>  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
>  #define PCIE_EN7581_RESET_TIME_MS	100
> =20
> @@ -912,6 +914,14 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_=
pcie *pcie)
>  	int err;
>  	u32 val;
> =20
> +	/*
> +	 * The controller may have been left out of reset by the bootloader
> +	 * so make sure that we get a clean start by asserting resets here.
> +	 */
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> +				  pcie->phy_resets);
> +	reset_control_assert(pcie->mac_reset);
> +
>  	/*
>  	 * Wait for the time needed to complete the bulk assert in
>  	 * mtk_pcie_setup for EN7581 SoC.

This comment is not correct anymore.


regards
Philipp

