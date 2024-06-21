Return-Path: <linux-pci+bounces-9084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82880912CDD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 20:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8211C23A9B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 18:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675D1607BC;
	Fri, 21 Jun 2024 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq7ZIiTC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA44EB51;
	Fri, 21 Jun 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992973; cv=none; b=ZbrVQIdCgwYeLUmusu80lDqq6UZfxJUpsEB/ZIeOUMlYv0eajpBMwJypbM/JRKzQ2Udmlm3y8h/vWj3U8G7xSix0Ovxd+ZNA/GOr4e0bEoa+2RAnaqv20XYgTS+bHe0cqdhVpHVbLvUNZA2GR6KeotRoR6t6+g2jlrmJq/NTG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992973; c=relaxed/simple;
	bh=0qSdXM3yj/mMwv7tZU9uHYRGL9WyAMjg+G7TZPlR4z8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p7yxXEuLIcNRcRyiB5h81cbizv2dRuJfEVNsuyENHvWADH3/EGvzhbPAjHMNwSSzoTrZ/kZlk/6ABpeCJ6Vxk2zCUeaSJXUG8eEBKy6GuvHNbE2EwRZ7SzxiFn3GhPxnBbkcEJ48u7H2QZJvYKGKDSu7I8zzjtHkrzbTnFLWeag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq7ZIiTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE25C2BBFC;
	Fri, 21 Jun 2024 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718992972;
	bh=0qSdXM3yj/mMwv7tZU9uHYRGL9WyAMjg+G7TZPlR4z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Qq7ZIiTCUXUjx6tAnvbup/wd+ARGZYKZwP/9FG8IhaWWxMX6jsbVx1VUkmckzybp5
	 ROYebHd67CcWXkmzBQw6GiOMeyG/qOuQGV+SIZ7XFFe/VXLX3VC41C/10XduzTJpMZ
	 iZFtHDsDiBVszdza8a1xyhljWd+XdR3ckgpq72UsGu7ZVkmPdLBWOmANXCv0a2UeJS
	 2AzkHpsB45ZoXIqlhsDhE6+6ycKtlz22yi1jik46Qx6k7DGFdDBozh3oXsoXrHjtVA
	 kV2si6OrvneBeEx2JKnIyT9HSsATrWLxMjaavXF8V4NY4irzBGsx/NUOFmE2jwBpF9
	 wZcI3Sf1DlDQQ==
Date: Fri, 21 Jun 2024 13:02:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <20240621180250.GA1396831@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f044eb44654522801d4a93e94918a32c72c4c49f.1718980864.git.lorenzo@kernel.org>

On Fri, Jun 21, 2024 at 04:48:50PM +0200, Lorenzo Bianconi wrote:
> Introduce support for Airoha EN7581 pcie controller to mediatek-gen3
> pcie controller driver.

s/pcie/PCIe/ (twice)

> Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pci/controller/Kconfig              |  2 +-
>  drivers/pci/controller/pcie-mediatek-gen3.c | 84 ++++++++++++++++++++-
>  2 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index e534c02ee34f..3bd6c9430010 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -196,7 +196,7 @@ config PCIE_MEDIATEK
>  
>  config PCIE_MEDIATEK_GEN3
>  	tristate "MediaTek Gen3 PCIe controller"
> -	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
>  	depends on PCI_MSI
>  	help
>  	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 9842617795a9..2dacfed665c6 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/iopoll.h>
>  #include <linux/irq.h>
> @@ -21,6 +22,8 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_device.h>

Existing list of includes is sorted.  Preserve that sorted order.

> +static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	int err;
> +
> +	writel_relaxed(0x23020133, pcie->base + 0x10044);
> +	writel_relaxed(0x50500032, pcie->base + 0x15030);
> +	writel_relaxed(0x50500032, pcie->base + 0x15130);

Magic.  Needs #defines at least for the registers.  These offsets are
HUGE, far bigger than the existing offsets:

  #define PCIE_CFGNUM_REG                 0x140
  #define PCIE_CFG_OFFSET_ADDR            0x1000
  #define PCIE_TRANS_TABLE_BASE_REG       0x800
  #define PCIE_MSI_SET_BASE_REG           0xc00
  #define PCIE_MSI_SET_ADDR_HI_BASE       0xc80
  #define PCIE_MSI_SET_ENABLE_REG         0x190
  #define PCIE_INT_ENABLE_REG             0x180
  #define PCIE_SETTING_REG                0x80
  #define PCIE_PCI_IDS_1                  0x9c
  #define PCIE_MISC_CTRL_REG              0x348
  #define PCIE_RST_CTRL_REG               0x148
  #define PCIE_LINK_STATUS_REG            0x154
  #define PCIE_LTSSM_STATUS_REG           0x150
  #define PCIE_INT_STATUS_REG             0x184

> +	err = phy_init(pcie->phy);
> +	if (err) {
> +		dev_err(dev, "failed to initialize PHY\n");
> +		return err;
> +	}
> +	mdelay(30);

Source?  Cite the spec that requires this delay and add a #define if
possible.

> +	err = phy_power_on(pcie->phy);
> +	if (err) {
> +		dev_err(dev, "failed to power on PHY\n");
> +		goto err_phy_on;
> +	}
> +
> +	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_rsts,
> +					  pcie->phy_resets);
> +	if (err) {
> +		dev_err(dev, "failed to deassert PHYs\n");
> +		goto err_phy_deassert;
> +	}
> +	usleep_range(5000, 10000);

Source?

> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
> +	err = clk_bulk_prepare(pcie->num_clks, pcie->clks);
> +	if (err) {
> +		dev_err(dev, "failed to prepare clock\n");
> +		goto err_clk_prepare;
> +	}
> +
> +	writel_relaxed(0x41474147, pcie->base + PCIE_EQ_PRESET_01_REF);
> +	writel_relaxed(0x1018020f, pcie->base + PCIE_PIPE4_PIE8_REG);
> +	mdelay(10);

Source?

