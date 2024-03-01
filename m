Return-Path: <linux-pci+bounces-4296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E086DB98
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 07:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E371C22B94
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD967E62;
	Fri,  1 Mar 2024 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gtm8E90r"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED86930A;
	Fri,  1 Mar 2024 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275374; cv=none; b=RbRL6QguzSFbLdjCh5qlLOCkhbaxMffm4A6MCAMzHdDxd96jNDFg4ibXSHArtMKup51JgvhX+JBwMi2KsLAu5m6MmoyFlZgOCoeTj/4ihV9A3ZEaAfuKNrOqakkQC2YUT8y6GlM+QYf03R+CzpA/N03yWuCaznJTd2xLOtvf4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275374; c=relaxed/simple;
	bh=5b6KZnCfjNH/tMtMaKdO6dCoA4SAphbbMPiWnivfA2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMqfBnd5xN4/B2OPjLIfxU9ls1OaPTNpL1Vmzpa2n3xCmQNWJu6wNVYAoKtcuDY+IuCdLGyVLQ0GXdQVTkN+aw4Yknye9bPpnnqdtYrZfcWbsFEUE3UINsExALS59EVkY0kk+L1OISL/4uQaEroEQoUtR/EugEBOF/TdcpJlVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gtm8E90r; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4216gQfL079737;
	Fri, 1 Mar 2024 00:42:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709275346;
	bh=cymxrUKXsjmmgn8eIcQnHhWpzzzveFDfdOGvsAceMAM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gtm8E90rRo5IOpeq1A5f6w52t9saLWSkUnRfMsTBTHAwFk1Sdnu7+8nf/OAlsUyuB
	 H+Er29EMLJp1qwbfLhBx8HBzwAOFfKyIXhLDKjFEULDOIO8oByKnVFN6ZNtGEx4bDO
	 2uBix7mKZArgnG6uvzxyjyQbOzIAVCtQe8ZUkdsw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4216gQDh096743
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Mar 2024 00:42:26 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Mar 2024 00:42:26 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Mar 2024 00:42:26 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4216gPaR010515;
	Fri, 1 Mar 2024 00:42:26 -0600
Date: Fri, 1 Mar 2024 12:12:25 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <linux-pci@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <jianjun.wang@mediatek.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <p.zabel@pengutronix.de>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@collabora.com>, <wenst@chromium.org>,
        <nfraprado@collabora.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Assert MAC reset only if PHY
 reset also present
Message-ID: <a55428b8-27b3-42f7-8154-ccc7dde469df@ti.com>
References: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Feb 29, 2024 at 10:24:49AM +0100, AngeloGioacchino Del Regno wrote:
> Some SoCs have two PCI-Express controllers: in the case of MT8195,
> one of them is using a dedicated PHY, but the other uses a combo PHY
> that is shared with USB and in that case the PHY cannot be reset
> from the PCIe driver, or USB functionality will be unable to resume.
> 
> Resetting the PCIe MAC without also resetting the PHY will result in
> a full system lockup at PCIe resume time and the only option to
> resume operation is to hard reboot the system (with a PMIC cut-off).
> 
> To resolve this issue, check if we've got both a PHY and a MAC reset
> and, if not, never assert resets at PM suspend time: in that case,
> the link is still getting powered down as both the clocks and the
> power domains will go down anyway.
> 
> Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> Changes in v2:
>  - Rebased over next-20240229
> 
>  drivers/pci/controller/pcie-mediatek-gen3.c | 25 ++++++++++++++-------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 975b3024fb08..99b5d7a49be1 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -874,17 +874,26 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
>  	return err;
>  }
>  
> -static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
> +static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie, bool is_suspend)
>  {
> +	bool suspend_reset_supported = pcie->mac_reset && pcie->phy_reset;
> +
>  	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  
>  	pm_runtime_put_sync(pcie->dev);
>  	pm_runtime_disable(pcie->dev);
> -	reset_control_assert(pcie->mac_reset);
> +
> +	/*
> +	 * Assert MAC reset only if we also got a PHY reset, otherwise
> +	 * the system will lockup at PM resume time.
> +	 */
> +	if (is_suspend && suspend_reset_supported)
> +		reset_control_assert(pcie->mac_reset);
>  
>  	phy_power_off(pcie->phy);
>  	phy_exit(pcie->phy);

Wouldn't this power off the shared PHY? Or will the PHY driver make this
NO-OP if the PHY is shared, in which case the above two statements could
be combined with the other statements in the:
if (is_suspend && suspend_reset_supported)
condition to get a single block of code that also combines the
reset_control_assert(pcie->phy_reset)
present below.

> -	reset_control_assert(pcie->phy_reset);
> +	if (is_suspend && suspend_reset_supported)
> +		reset_control_assert(pcie->phy_reset);
>  }
>  
...

Regards,
Siddharth.

