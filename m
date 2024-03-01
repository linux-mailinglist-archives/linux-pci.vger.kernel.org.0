Return-Path: <linux-pci+bounces-4303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D30F86DEAD
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 10:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C27E287660
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180606A352;
	Fri,  1 Mar 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xrGghXaB"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82346A8DC;
	Fri,  1 Mar 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286967; cv=none; b=SZ4DUZgQKc7ZiG8sTqQjwgjyJGKaqD3R465B1aaL73/AnxuRVAHDxau2py4UrOlnswDYOFuqZFif+Q7b/ovQ84bScKMV+O3tRRnlrElLqH6hTW27+FRDR2UGH3WqxKKQTDnFcVNVQ9rzaD9PPbuiogNpDozjqyliAxrIru3Qw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286967; c=relaxed/simple;
	bh=68k66iiwRdL8e8XIa//t2nz73CKwh3gM563bwOXQDhE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pml1dbCO4asvj+lCw3GTJ8DRod+RzM2KIh6r2e2bC5YTx4MRItp+tu7laRW9+FIKCFpxXK5AQFb+l2ScR/TRJvzmMazlF+OvuFD3cllgWXx7aj5sC5wg1mps1z64u8g7A6VtbjnB0j8LLdTgQJuo3JocXbJ3NgLC6lgButAyyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xrGghXaB; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4219tPbo107280;
	Fri, 1 Mar 2024 03:55:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709286925;
	bh=vDfr0yp6C7xDyyNdToZD3gwq3T9ELQ+xwGdPREZ00cI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=xrGghXaBtr4kZR8rMV6MgYmVuHmN8laIPpUPrIMjve/sWCx81rBH5N+YejowBj9jm
	 DKbiwOaExltjW7e/GsZb9g7IyAcZTlBGGCRekCYzmnr99kmNibTC0mEMaKbCP5f5to
	 BXd62pdCoIX0i4N8uUR0WAcNwR8cnBRG9KOjIkoM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4219tPHt027170
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Mar 2024 03:55:25 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Mar 2024 03:55:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Mar 2024 03:55:25 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4219tOE6119278;
	Fri, 1 Mar 2024 03:55:25 -0600
Date: Fri, 1 Mar 2024 15:25:24 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <linux-pci@vger.kernel.org>,
        <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <p.zabel@pengutronix.de>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@collabora.com>, <wenst@chromium.org>,
        <nfraprado@collabora.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Assert MAC reset only if PHY
 reset also present
Message-ID: <9920b298-4627-4323-b367-13ee94a83869@ti.com>
References: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
 <a55428b8-27b3-42f7-8154-ccc7dde469df@ti.com>
 <2b2effdd-0b9d-40fd-a88d-ab364f2b0668@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b2effdd-0b9d-40fd-a88d-ab364f2b0668@collabora.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri, Mar 01, 2024 at 10:06:33AM +0100, AngeloGioacchino Del Regno wrote:
> Il 01/03/24 07:42, Siddharth Vadapalli ha scritto:
> > On Thu, Feb 29, 2024 at 10:24:49AM +0100, AngeloGioacchino Del Regno wrote:
> > > Some SoCs have two PCI-Express controllers: in the case of MT8195,
> > > one of them is using a dedicated PHY, but the other uses a combo PHY
> > > that is shared with USB and in that case the PHY cannot be reset
> > > from the PCIe driver, or USB functionality will be unable to resume.
> > > 
> > > Resetting the PCIe MAC without also resetting the PHY will result in
> > > a full system lockup at PCIe resume time and the only option to
> > > resume operation is to hard reboot the system (with a PMIC cut-off).
> > > 
> > > To resolve this issue, check if we've got both a PHY and a MAC reset
> > > and, if not, never assert resets at PM suspend time: in that case,
> > > the link is still getting powered down as both the clocks and the
> > > power domains will go down anyway.
> > > 
> > > Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > > 
> > > Changes in v2:
> > >   - Rebased over next-20240229
> > > 
> > >   drivers/pci/controller/pcie-mediatek-gen3.c | 25 ++++++++++++++-------
> > >   1 file changed, 17 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > index 975b3024fb08..99b5d7a49be1 100644
> > > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > @@ -874,17 +874,26 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
> > >   	return err;
> > >   }
> > > -static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
> > > +static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie, bool is_suspend)
> > >   {
> > > +	bool suspend_reset_supported = pcie->mac_reset && pcie->phy_reset;
> > > +
> > >   	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> > >   	pm_runtime_put_sync(pcie->dev);
> > >   	pm_runtime_disable(pcie->dev);
> > > -	reset_control_assert(pcie->mac_reset);
> > > +
> > > +	/*
> > > +	 * Assert MAC reset only if we also got a PHY reset, otherwise
> > > +	 * the system will lockup at PM resume time.
> > > +	 */
> > > +	if (is_suspend && suspend_reset_supported)
> > > +		reset_control_assert(pcie->mac_reset);
> > >   	phy_power_off(pcie->phy);
> > >   	phy_exit(pcie->phy);
> > 
> > Wouldn't this power off the shared PHY? Or will the PHY driver make this
> > NO-OP if the PHY is shared, in which case the above two statements could
> > be combined with the other statements in the:
> > if (is_suspend && suspend_reset_supported)
> > condition to get a single block of code that also combines the
> > reset_control_assert(pcie->phy_reset)
> > present below.
> > 
> 
> No, that'd be fine:
> 
> static int mtk_phy_power_off(struct phy *phy)
> {
> 	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
> 	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
> 
> 	if (instance->type == PHY_TYPE_USB2)
> 		u2_phy_instance_power_off(tphy, instance);
> 	else if (instance->type == PHY_TYPE_PCIE)
> 		pcie_phy_instance_power_off(tphy, instance);
> 
> 	return 0;
> }
> 
> ...it's two different PHY instances that we're dealing with, here :-)

I didn't realize that it is handled separately. Thank you for clarifying!

Regards,
Siddharth.

