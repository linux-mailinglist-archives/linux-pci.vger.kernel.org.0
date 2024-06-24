Return-Path: <linux-pci+bounces-9168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2991441A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 10:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B428D2813CF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D676938DDB;
	Mon, 24 Jun 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oI+18wCF"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494849622;
	Mon, 24 Jun 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216091; cv=none; b=mdiuMbcerPhv3PuXOF/ymDu89GEkOdmyUaazjxop+vAFU7nx6SPreSLy63j0u9C2pLwnAMXrIl3XCf6Rfxn8ABVcPCzp4h1ZyCgpAN7JfRZIezgp/ZN/gqMppvb8DMvyFXZwC7bxaChnLTyqtxxhTYP1ijTAp0I10D0CiAdGW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216091; c=relaxed/simple;
	bh=kHRWpyF7NJn1bOOBzeg2G8XXsr8NWFrJX5UZ5Xuq2b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/v17VXy4QTd1eni3nH2acCbGTRkVjk0TkBd+I5XTSbbrWyZy13+Y0YfHac7DjB1z3cpoiKldPGshN2Gy/gYRh/kWd4qAzdYfbFLnnjzuZrey3mT5SGQVCC44xIKSC6UVG/G/FHnDBLX6FdGYS0gcBdNXUeCrbca49OmHLciN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oI+18wCF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719216088;
	bh=kHRWpyF7NJn1bOOBzeg2G8XXsr8NWFrJX5UZ5Xuq2b0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oI+18wCFOeHvFSOaqzR6LTIEK9rPoCJ2lHoL1XI15Q/qmPdogSOzPqcPDyew9YeOe
	 V3dMyO1DUCmPG70vH7yElqt1Jm248rPtYw8FXM/Z36NsbqtQekR3XWShStgdehv8Is
	 GrvgPV2btNkZOx2yIhi/pB4mvFoUIVuFQl6QOAANfjrUvfkdJd8RKSPvY+goMH2ck6
	 dBF6Mky0QQdxDbbEqMd8bFFXj7oVRfvSgDj3wbAZO51vOTwcKDgk8Ry3KiccegKddm
	 0WrnMPqYezykG1uvKfxMpOzbrIrrEzB9IJUCpEUXBYU4kvFU75iGfJ8hXlbelnNM63
	 1T2xUf7WCZg2g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 69F403781022;
	Mon, 24 Jun 2024 08:01:27 +0000 (UTC)
Message-ID: <ee7ef59d-a698-41ba-a3a6-1e9e32313e2d@collabora.com>
Date: Mon, 24 Jun 2024 10:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PCI: mediatek-gen3: rely on reset_bulk APIs for phy
 reset lines
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, nbd@nbd.name,
 dd@embedd.com, upstream@airoha.com
References: <cover.1718980864.git.lorenzo@kernel.org>
 <e8ab615a56759a4832833211257d83f56bf64303.1718980864.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <e8ab615a56759a4832833211257d83f56bf64303.1718980864.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/06/24 16:48, Lorenzo Bianconi ha scritto:
> Use reset_bulk APIs to manage phy reset lines. This is a preliminary
> patch in order to add Airoha EN7581 pcie support.
> 
> Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 49 ++++++++++++++++-----
>   1 file changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 4859bd875bc4..9842617795a9 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -100,14 +100,21 @@
>   #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
>   #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
>   
> +#define MAX_NUM_PHY_RSTS		1
> +
>   struct mtk_gen3_pcie;
>   
>   /**
>    * struct mtk_pcie_soc - differentiate between host generations
>    * @power_up: pcie power_up callback
> + * @phy_resets: phy reset lines SoC data.
>    */
>   struct mtk_pcie_soc {
>   	int (*power_up)(struct mtk_gen3_pcie *pcie);
> +	struct {
> +		const char *id[MAX_NUM_PHY_RSTS];
> +		int num_rsts;

Well, it's just two chars after all, so "num_resets" looks better imo.

> +	} phy_resets;
>   };
>   
>   /**
> @@ -128,7 +135,7 @@ struct mtk_msi_set {
>    * @base: IO mapped register base
>    * @reg_base: physical register base
>    * @mac_reset: MAC reset control
> - * @phy_reset: PHY reset control
> + * @phy_resets: PHY reset controllers
>    * @phy: PHY controller block
>    * @clks: PCIe clocks
>    * @num_clks: PCIe clocks count for this port
> @@ -148,7 +155,7 @@ struct mtk_gen3_pcie {
>   	void __iomem *base;
>   	phys_addr_t reg_base;
>   	struct reset_control *mac_reset;
> -	struct reset_control *phy_reset;
> +	struct reset_control_bulk_data phy_resets[MAX_NUM_PHY_RSTS];
>   	struct phy *phy;
>   	struct clk_bulk_data *clks;
>   	int num_clks;
> @@ -790,8 +797,8 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
>   {
>   	struct device *dev = pcie->dev;
>   	struct platform_device *pdev = to_platform_device(dev);
> +	int i, ret, num_rsts = pcie->soc->phy_resets.num_rsts; >   	struct resource *regs;
> -	int ret;
>   
>   	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
>   	if (!regs)
> @@ -804,12 +811,13 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
>   
>   	pcie->reg_base = regs->start;
>   
> -	pcie->phy_reset = devm_reset_control_get_optional_exclusive(dev, "phy");
> -	if (IS_ERR(pcie->phy_reset)) {
> -		ret = PTR_ERR(pcie->phy_reset);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get PHY reset\n");
> +	for (i = 0; i < num_rsts; i++)
> +		pcie->phy_resets[i].id = pcie->soc->phy_resets.id[i];
>   
> +	ret = devm_reset_control_bulk_get_optional_shared(dev, num_rsts,
> +							  pcie->phy_resets);

92 columns is ok, you can use one line for that.

> +	if (ret) {
> +		dev_err(dev, "failed to get PHY bulk reset\n");
>   		return ret;
>   	}
>   
> @@ -846,7 +854,12 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
>   	int err;
>   
>   	/* PHY power on and enable pipe clock */
> -	reset_control_deassert(pcie->phy_reset);
> +	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_rsts,
> +					  pcie->phy_resets);
> +	if (err) {
> +		dev_err(dev, "failed to deassert PHYs\n");
> +		return err;
> +	}
>   
>   	err = phy_init(pcie->phy);
>   	if (err) {
> @@ -882,7 +895,8 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
>   err_phy_on:
>   	phy_exit(pcie->phy);
>   err_phy_init:
> -	reset_control_assert(pcie->phy_reset);
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_rsts,
> +				  pcie->phy_resets);

same here

>   
>   	return err;
>   }
> @@ -897,7 +911,8 @@ static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
>   
>   	phy_power_off(pcie->phy);
>   	phy_exit(pcie->phy);
> -	reset_control_assert(pcie->phy_reset);
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_rsts,
> +				  pcie->phy_resets);

ditto

>   }
>   
>   static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
> @@ -912,7 +927,13 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>   	 * The controller may have been left out of reset by the bootloader
>   	 * so make sure that we get a clean start by asserting resets here.
>   	 */
> -	reset_control_assert(pcie->phy_reset);
> +	reset_control_bulk_deassert(pcie->soc->phy_resets.num_rsts,
> +				    pcie->phy_resets);

and again...

> +	usleep_range(5000, 10000);
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_rsts,
> +				  pcie->phy_resets);

.... :-)

Cheers,
Angelo

> +	msleep(100);
> +
>   	reset_control_assert(pcie->mac_reset);
>   	usleep_range(10, 20);
>   
> @@ -1090,6 +1111,10 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
>   
>   static const struct mtk_pcie_soc mtk_pcie_soc_mt8192 = {
>   	.power_up = mtk_pcie_power_up,
> +	.phy_resets = {
> +		.id[0] = "phy",
> +		.num_rsts = 1,
> +	},
>   };
>   
>   static const struct of_device_id mtk_pcie_of_match[] = {


