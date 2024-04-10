Return-Path: <linux-pci+bounces-6059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433789FF20
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C06B24F40
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0017F38A;
	Wed, 10 Apr 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCZ6y2zE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596717F37D;
	Wed, 10 Apr 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771514; cv=none; b=HhvhzAPLRsr9aKo52j4kjYAyckvuLTCEYzLiSQ9nUBbRR4AxCXkc0ev49iM2zjmQU1Jassq+EDbzD97edQnv/wyVsUtDNbKxVQUd6rIEm6JgiEwZh07Bj1rVMoAWa2IKO/wjkAM3R03vNQh+VMXwNmVWC/P1Jj817gfzY6lx5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771514; c=relaxed/simple;
	bh=uxQ6UK6Pz6XOy7WaOuj5FmgSDDWFLu8reVbu3KQQcIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhHA1gjycGG7dmuzhMicQ2BnOQaD0C75HB1Cbzo/xUAK5MdQmEH3ayNU5dsBwQWP6M/jkiUftVQyvO9FbKAfRyraaY65m2/AjtSCTcFwp1sFTL9ucXoNMpPn+LCxgazJAle6x1aD0pLMceT9BjNWLN6oSXXpqwS42kPHz0XCI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCZ6y2zE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFF5C433F1;
	Wed, 10 Apr 2024 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712771513;
	bh=uxQ6UK6Pz6XOy7WaOuj5FmgSDDWFLu8reVbu3KQQcIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCZ6y2zEt4xskOA5LRNBrdQk3TaFBsh63lvEqyPofgSbbR48GF+cQhpsTZNU7msVW
	 ZPRXazdewuGbHyiRUoqpRAPMu9ghKLV6UkFJ7WfkFVGcRVbnkDRy0G14KHsVYfu7Gb
	 rUSFlbBVxyaEWp1SpUWRIwYwsyNzJCJ5k/ol+e6kUVuX1SSA5nFrE8LcpUU8qyOwCA
	 cxVw8CjkYNcNMWV/A63OnJ9LgEEwM9H0CcM0fjjtXKJ0ZaOO0NYaXh5jF/rXaiyDSG
	 NPEfjJ5VemNdwHD5cJW9YwM/1/5shQca+iVyyVp+kN+esJI1Cdv+EK+vXW79/PuO6T
	 m34NYqxMlyhig==
Date: Wed, 10 Apr 2024 23:21:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 6/7] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <20240410175144.GD16629@thinkpad>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
 <20240410004832.3726922-7-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410004832.3726922-7-yoshihiro.shimoda.uh@renesas.com>

On Wed, Apr 10, 2024 at 09:48:31AM +0900, Yoshihiro Shimoda wrote:
> This driver previously supported r8a779f0 (R-Car S4-8). Add support
> for r8a779g0 (R-Car V4H).
> 
> To support r8a779g0, it requires specific firmware.
> 

Add more information about the new SoC. Like features, why firmware is needed,
how it is downloaded/verified etc...

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 201 +++++++++++++++++++-
>  1 file changed, 200 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 47ec394885f5..a62804674f4e 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -5,8 +5,10 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/firmware.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pci.h>
> @@ -20,9 +22,10 @@
>  /* Renesas-specific */
>  /* PCIe Mode Setting Register 0 */
>  #define PCIEMSR0		0x0000
> -#define BIFUR_MOD_SET_ON	BIT(0)
> +#define APP_SRIS_MODE		BIT(6)
>  #define DEVICE_TYPE_EP		0
>  #define DEVICE_TYPE_RC		BIT(4)
> +#define BIFUR_MOD_SET_ON	BIT(0)
>  
>  /* PCIe Interrupt Status 0 */
>  #define PCIEINTSTS0		0x0084
> @@ -37,19 +40,47 @@
>  #define PCIEDMAINTSTSEN		0x0314
>  #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
>  
> +/* Port Logic Registers 89 */
> +#define PRTLGC89		0x0b70
> +
> +/* Port Logic Registers 90 */
> +#define PRTLGC90		0x0b74
> +
>  /* PCIe Reset Control Register 1 */
>  #define PCIERSTCTRL1		0x0014
>  #define APP_HOLD_PHY_RST	BIT(16)
>  #define APP_LTSSM_ENABLE	BIT(0)
>  
> +/* PCIe Power Management Control */
> +#define PCIEPWRMNGCTRL		0x0070
> +#define APP_CLK_REQ_N		BIT(11)
> +#define APP_CLK_PM_EN		BIT(10)
> +
> +/*
> + * The R-Car Gen4 documents don't describe the PHY registers' name.
> + * But, the initialization procedure describes these offsets. So,
> + * this driver makes up own #defines for the offsets.
> + */

This provides no information at all. So better hardcode them.

> +#define RCAR_GEN4_PCIE_PHY_0f8	0x0f8
> +#define RCAR_GEN4_PCIE_PHY_148	0x148
> +#define RCAR_GEN4_PCIE_PHY_1d4	0x1d4
> +#define RCAR_GEN4_PCIE_PHY_514	0x514
> +#define RCAR_GEN4_PCIE_PHY_700	0x700
> +
>  #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
>  #define RCAR_MAX_LINK_SPEED		4
>  
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
>  
> +#define RCAR_GEN4_PCIE_FIRMWARE_NAME		"rcar_gen4_pcie.bin"
> +#define RCAR_GEN4_PCIE_FIRMWARE_BASE_ADDR	0xc000
> +
> +MODULE_FIRMWARE(RCAR_GEN4_PCIE_FIRMWARE_NAME);
> +
>  struct rcar_gen4_pcie;
>  struct rcar_gen4_pcie_platdata {
> +	void (*additional_common_init)(struct rcar_gen4_pcie *rcar);
>  	int (*ltssm_enable)(struct rcar_gen4_pcie *rcar);
>  	enum dw_pcie_device_mode mode;
>  };
> @@ -57,12 +88,144 @@ struct rcar_gen4_pcie_platdata {
>  struct rcar_gen4_pcie {
>  	struct dw_pcie dw;
>  	void __iomem *base;
> +	void __iomem *phy_base;
>  	struct platform_device *pdev;
>  	const struct rcar_gen4_pcie_platdata *platdata;
>  };
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>  
>  /* Common */
> +static void rcar_gen4_pcie_phy_reg_update_bits(struct rcar_gen4_pcie *rcar,
> +					       u32 offset, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp = readl(rcar->phy_base + offset);
> +	tmp &= ~mask;
> +	tmp |= val;
> +	writel(tmp, rcar->phy_base + offset);

If you use FIELD_* macros, then the values can be passed sensibly ie., just 0
and 1.

> +}
> +
> +static int rcar_gen4_pcie_reg_check_bit(struct rcar_gen4_pcie *rcar,

rcar_gen4_pcie_reg_check()?

> +					u32 offset, u32 mask)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +
> +	if (dw_pcie_readl_dbi(dw, offset) & mask)
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
> +static int rcar_gen4_pcie_update_phy_firmware(struct rcar_gen4_pcie *rcar)
> +{
> +	const u32 check_addr[] = { 0x00101018, 0x00101118, 0x00101021, 0x00101121};

What are these addresses?

> +	struct dw_pcie *dw = &rcar->dw;
> +	const struct firmware *fw;
> +	unsigned int i, timeout;
> +	u32 data;
> +	int ret;
> +
> +	ret = request_firmware(&fw, RCAR_GEN4_PCIE_FIRMWARE_NAME, dw->dev);

Is this the PHY firmware or PCIe?

> +	if (ret) {
> +		dev_err(dw->dev, "%s: Requesting firmware failed\n", __func__);

Please, do not print function names in error log.

> +		return ret;
> +	}
> +
> +	for (i = 0; i < (fw->size / 2); i++) {
> +		data = fw->data[i * 2] | fw->data[(i * 2) + 1] << 8;

Well, the usual concat order is:

		data << 8 | data

> +		timeout = 100;
> +		do {
> +			dw_pcie_writel_dbi(dw, PRTLGC89, RCAR_GEN4_PCIE_FIRMWARE_BASE_ADDR + i);
> +			dw_pcie_writel_dbi(dw, PRTLGC90, data);
> +			if (rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC89, BIT(30)) >= 0)

What is going on here? Please add a comment to make it clear.

> +				break;
> +			if (!(--timeout)) {
> +				ret = -ETIMEDOUT;
> +				goto exit;
> +			}
> +			usleep_range(100, 200);
> +		} while (1);
> +	}
> +
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_0f8, BIT(17), BIT(17));
> +
> +	for (i = 0; i < ARRAY_SIZE(check_addr); i++) {
> +		timeout = 100;
> +		do {
> +			dw_pcie_writel_dbi(dw, PRTLGC89, check_addr[i]);
> +			ret = rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC89, BIT(30));
> +			ret |= rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC90, BIT(0));
> +			if (ret >= 0)
> +				break;
> +			if (!(--timeout)) {
> +				ret = -ETIMEDOUT;
> +				goto exit;
> +			}
> +			usleep_range(100, 200);
> +		} while (1);
> +	}
> +
> +	ret = 0;

return 0

> +exit:
> +	release_firmware(fw);
> +
> +	return ret;
> +}
> +
> +static int rcar_gen4_pcie_enable_phy(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +	u32 val;
> +	int ret;
> +
> +	val = dw_pcie_readl_dbi(dw, PCIE_PORT_FORCE);
> +	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> +	dw_pcie_writel_dbi(dw, PCIE_PORT_FORCE, val);
> +
> +	val = readl(rcar->base + PCIEMSR0);
> +	val |= APP_SRIS_MODE;
> +	writel(val, rcar->base + PCIEMSR0);
> +
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(28), 0);
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(20), 0);
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(12), 0);
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(4), 0);
> +
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> +					   GENMASK(23, 22), BIT(22));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> +					   GENMASK(18, 16), GENMASK(17, 16));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> +					   GENMASK(7, 6), BIT(6));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> +					   GENMASK(2, 0), GENMASK(11, 0));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_1d4,
> +					   GENMASK(16, 15), GENMASK(16, 15));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_514, BIT(26), BIT(26));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_0f8, BIT(16), 0);
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_0f8, BIT(19), BIT(19));
> +
> +	val = readl(rcar->base + PCIERSTCTRL1);
> +	val &= ~APP_HOLD_PHY_RST;
> +	writel(val, rcar->base + PCIERSTCTRL1);
> +
> +	ret = readl_poll_timeout(rcar->phy_base + RCAR_GEN4_PCIE_PHY_0f8, val,
> +				 !(val & BIT(18)), 100, 10000);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = rcar_gen4_pcie_update_phy_firmware(rcar);

Updating or downloading the PHY firmware?

> +	if (ret)
> +		return ret;
> +
> +	val = readl(rcar->base + PCIERSTCTRL1);
> +	val |= APP_LTSSM_ENABLE;
> +	writel(val, rcar->base + PCIERSTCTRL1);
> +
> +	return 0;
> +}
> +
>  static void rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar,
>  					 bool enable)
>  {
> @@ -200,6 +363,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>  	if (ret)
>  		goto err_unprepare;
>  
> +	if (rcar->platdata->additional_common_init)
> +		rcar->platdata->additional_common_init(rcar);
> +
>  	return 0;
>  
>  err_unprepare:
> @@ -241,6 +407,10 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
>  
>  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>  {
> +	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
> +	if (IS_ERR(rcar->phy_base))
> +		return PTR_ERR(rcar->base);

rcar->phy_base?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

