Return-Path: <linux-pci+bounces-17044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED59D1057
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 13:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C451628349D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 12:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F8190470;
	Mon, 18 Nov 2024 12:08:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DB3188A0D
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931684; cv=none; b=UVB7vwmKEItN7x//cnPWEqCVQ42tLtVE328ThOA6B9p6yXn5xgihIfp1bf92Dmy6Qsy/h1nTwHHaxf6eeh7E10/N3XB1mfHnCghbbwIMlMDvCgKU8t9PNKRA4ButCkXQWmwFb1O1e3UlacCjfx+M+kmp3YDdxCWPnyUR430x8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931684; c=relaxed/simple;
	bh=9317DECpVOPSVH/eS7BM0cm9sa6APpK76JtHQx2ovX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aj1dfy/cU93iY5dFPQu6YPA+63NrpNXZ1JhnWskNXXScXnVy7Xf2VVfQ7k8dspaF7h45RsMUNRBMgXeLZFf/d7Lu9KMMWu2VwgfVty7twPo1oZBC+OfCwCL7JEypFcKK3W8Yh8BpwzDTJSMWORaaJTSYQmXpR9lGtSNMOgcCQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tD0Xf-00009K-9Z; Mon, 18 Nov 2024 13:07:43 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tD0Xb-001OQe-2s;
	Mon, 18 Nov 2024 13:07:39 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tD0Xb-0007J9-2a;
	Mon, 18 Nov 2024 13:07:39 +0100
Message-ID: <12ee035ae0ac88976a6521ee765c35c626494440.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/6] PCI: mediatek-gen3: Move reset/assert callbacks
 in .power_up()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>,  Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org
Date: Mon, 18 Nov 2024 13:07:39 +0100
In-Reply-To: <ZzspgzXCyds04gTY@lore-desk>
References: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
	 <20241118-pcie-en7581-fixes-v4-3-24bb61703ad7@kernel.org>
	 <2d7e1e5e09babb468199ac44520683fcb87d697c.camel@pengutronix.de>
	 <ZzsC_hW-w6WSMYSO@lore-desk>
	 <1fb3166c1f520a57c19bd3103b4585eee1e57fec.camel@pengutronix.de>
	 <ZzspgzXCyds04gTY@lore-desk>
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

On Mo, 2024-11-18 at 12:48 +0100, Lorenzo Bianconi wrote:
> > On Mo, 2024-11-18 at 10:03 +0100, Lorenzo Bianconi wrote:
> > > On Nov 18, Philipp Zabel wrote:
> > > > On Mo, 2024-11-18 at 09:04 +0100, Lorenzo Bianconi wrote:
> > > > > In order to make the code more readable, the
> > > > > reset_control_bulk_assert()
> > > > > for PHY reset lines is moved to make it pair with
> > > > > reset_control_bulk_deassert() in mtk_pcie_power_up() and
> > > > > mtk_pcie_en7581_power_up(). The same change is done for
> > > > > reset_control_assert() used to assert MAC reset line.
> > > > >=20
> > > > > Introduce PCIE_MTK_RESET_TIME_US macro for the time needed to
> > > > > complete PCIe reset on MediaTek controller.
> > > > >=20
> > > > > Reviewed-by: AngeloGioacchino Del Regno
> > > > > <angelogioacchino.delregno@collabora.com>
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > ---
> > > > > =C2=A0drivers/pci/controller/pcie-mediatek-gen3.c | 27
> > > > > +++++++++++++++++++--------
> > > > > =C2=A01 file changed, 19 insertions(+), 8 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > > b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > > index
> > > > > 3cfcb45d31508142d28d338ff213f70de9b4e608..2b80edd4462ad4e9f2a
> > > > > 5d192db7f99307113eb8a 100644
> > > > > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > > @@ -125,6 +125,8 @@
> > > > > =C2=A0
> > > > > =C2=A0#define MAX_NUM_PHY_RESETS		3
> > > > > =C2=A0
> > > > > +#define PCIE_MTK_RESET_TIME_US		10
> > > > > +
> > > > > =C2=A0/* Time in ms needed to complete PCIe reset on EN7581 SoC *=
/
> > > > > =C2=A0#define PCIE_EN7581_RESET_TIME_MS	100
> > > > > =C2=A0
> > > > > @@ -912,6 +914,14 @@ static int
> > > > > mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> > > > > =C2=A0	int err;
> > > > > =C2=A0	u32 val;
> > > > > =C2=A0
> > > > > +	/*
> > > > > +	 * The controller may have been left out of reset by
> > > > > the bootloader
> > > > > +	 * so make sure that we get a clean start by
> > > > > asserting resets here.
> > > > > +	 */
> > > > > +	reset_control_bulk_assert(pcie->soc-
> > > > > >phy_resets.num_resets,
> > > > > +				  pcie->phy_resets);
> > > > > +	reset_control_assert(pcie->mac_reset);
> > > > > +
> > > > > =C2=A0	/*
> > > > > =C2=A0	 * Wait for the time needed to complete the bulk
> > > > > assert in
> > > > > =C2=A0	 * mtk_pcie_setup for EN7581 SoC.
> > > >=20
> > > > This comment is not correct anymore.
> > >=20
> > > I agree naming is hard, but I guess we can assume with 'bulk' we
> > > refer to both
> > > phy and mac reset (similar to what we have in
> > > mtk_pcie_power_up()),
> > > what do you think?
> >=20
> > My point is that the referenced (bulk) assert isn't in
> > mtk_pcie_setup()
> > anymore - it was just moved right above this comment.
>=20
> ok, thx. I got what you mean now, I will fix it.
>=20
> >=20
> > I wonder why that delay is required at all, though. Does the reset
> > controller driver return from reset_control_ops::assert before the
> > reset line to the PCI controller is asserted?
>=20
> We discussed it in a previous revision and Bjorn requested to have
> the required delaies=20
> in the PCIe driver.
>=20
> https://patchwork.kernel.org/project/linux-pci/patch/aca00bd672ee576ad96d=
279414fc0835ff31f637.1720022580.git.lorenzo@kernel.org/#26110282

Ok, thank you.

regards
Philipp

