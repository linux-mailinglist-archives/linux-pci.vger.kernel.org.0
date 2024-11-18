Return-Path: <linux-pci+bounces-17041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87EF9D0F61
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 12:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E02B29C6B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D0D152166;
	Mon, 18 Nov 2024 11:02:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433201946A8
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927734; cv=none; b=MbosHyohZJK76N9RrMUw6cRXK4yN0pc0oJYdoZxdn0ID6KidNc4pB6jsYJ/VfyVTxiZAUwgmtcBSyOj/6SnAedNVF3Kx5XF+nEZLPGUUsXHXQzkxoUyB9RtbOYL1DSZzocSQik0wQqZAu5n7aXSzvccUQftLznfxIJrEtyXFbz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927734; c=relaxed/simple;
	bh=EBnfuGjstPHCNflD27CS6SOmwgyFXJ+hnjsucPtk58Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2xYdzGxET0ihBZ5/HNVEFRLYMnzbkIC7gnVZLmOvW8eCPxLOmtEt4JhgyzY8q9N0Xid48OPdHuRG7ApDWGSVXiruxjpD8yDrJowSP6VZieZi4htwu078NfdS//MdRqi1I0d3D0NyEqhkofty7IUUa1ZiaPqeVzgKrpZouKke/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tCzVd-00036U-Hw; Mon, 18 Nov 2024 12:01:33 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tCzVb-001Ndl-2z;
	Mon, 18 Nov 2024 12:01:31 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tCzVb-0005lO-2k;
	Mon, 18 Nov 2024 12:01:31 +0100
Message-ID: <1fb3166c1f520a57c19bd3103b4585eee1e57fec.camel@pengutronix.de>
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
Date: Mon, 18 Nov 2024 12:01:31 +0100
In-Reply-To: <ZzsC_hW-w6WSMYSO@lore-desk>
References: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
	 <20241118-pcie-en7581-fixes-v4-3-24bb61703ad7@kernel.org>
	 <2d7e1e5e09babb468199ac44520683fcb87d697c.camel@pengutronix.de>
	 <ZzsC_hW-w6WSMYSO@lore-desk>
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

On Mo, 2024-11-18 at 10:03 +0100, Lorenzo Bianconi wrote:
> On Nov 18, Philipp Zabel wrote:
> > On Mo, 2024-11-18 at 09:04 +0100, Lorenzo Bianconi wrote:
> > > In order to make the code more readable, the reset_control_bulk_asser=
t()
> > > for PHY reset lines is moved to make it pair with
> > > reset_control_bulk_deassert() in mtk_pcie_power_up() and
> > > mtk_pcie_en7581_power_up(). The same change is done for
> > > reset_control_assert() used to assert MAC reset line.
> > >=20
> > > Introduce PCIE_MTK_RESET_TIME_US macro for the time needed to
> > > complete PCIe reset on MediaTek controller.
> > >=20
> > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek-gen3.c | 27 +++++++++++++++++++=
--------
> > >  1 file changed, 19 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pc=
i/controller/pcie-mediatek-gen3.c
> > > index 3cfcb45d31508142d28d338ff213f70de9b4e608..2b80edd4462ad4e9f2a5d=
192db7f99307113eb8a 100644
> > > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > @@ -125,6 +125,8 @@
> > > =20
> > >  #define MAX_NUM_PHY_RESETS		3
> > > =20
> > > +#define PCIE_MTK_RESET_TIME_US		10
> > > +
> > >  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
> > >  #define PCIE_EN7581_RESET_TIME_MS	100
> > > =20
> > > @@ -912,6 +914,14 @@ static int mtk_pcie_en7581_power_up(struct mtk_g=
en3_pcie *pcie)
> > >  	int err;
> > >  	u32 val;
> > > =20
> > > +	/*
> > > +	 * The controller may have been left out of reset by the bootloader
> > > +	 * so make sure that we get a clean start by asserting resets here.
> > > +	 */
> > > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> > > +				  pcie->phy_resets);
> > > +	reset_control_assert(pcie->mac_reset);
> > > +
> > >  	/*
> > >  	 * Wait for the time needed to complete the bulk assert in
> > >  	 * mtk_pcie_setup for EN7581 SoC.
> >=20
> > This comment is not correct anymore.
>=20
> I agree naming is hard, but I guess we can assume with 'bulk' we refer to=
 both
> phy and mac reset (similar to what we have in mtk_pcie_power_up()),
> what do you think?

My point is that the referenced (bulk) assert isn't in mtk_pcie_setup()
anymore - it was just moved right above this comment.

I wonder why that delay is required at all, though. Does the reset
controller driver return from reset_control_ops::assert before the
reset line to the PCI controller is asserted?

regards
Philipp

