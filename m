Return-Path: <linux-pci+bounces-9132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022DA913AC6
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1323E1C20BB0
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C21E4BE;
	Sun, 23 Jun 2024 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9PvKxVA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8E8F6A;
	Sun, 23 Jun 2024 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719148583; cv=none; b=WDaA89CPNhQFNwa8uRdkE0g2IAsAOCgelIUcasMnkF6PvROjjL5Dg1vPUidnZoLsuHBz7uAihzWV3r9pckYsOOfncg/+6zyIoRqFSeMb5gSTgzxKe4HGE6GxVs8yYLh5K0pYzsuj3NQRaZSQDAdLrIl6sQqWmYdi5iiYAChS6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719148583; c=relaxed/simple;
	bh=wuh+iLMJWlnLSU0UTI+cNjQb5LTFC2aME8kjtjmCa4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHc+qpRC1Yjw3vMe81Y2EyFl6EeZocf87B4u+llUPkhZcLvupgM79RBHRJ02cNlGm4A7v37HeGZZS00ulucr9vQSHtMUPSGpS7Vpkg8Be+HhG8gmWWQfyQCiUcERNXi/GGLqk9d7NJQoeuTaoGxBoI1W8AMiu8DWtuhosM/xaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9PvKxVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47111C2BD10;
	Sun, 23 Jun 2024 13:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719148583;
	bh=wuh+iLMJWlnLSU0UTI+cNjQb5LTFC2aME8kjtjmCa4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9PvKxVAEoLC76a0N41BWgKi2pW9G/o6uuYVvHOHdW623E8zI3CL4VwkrS7Sc48EY
	 8Mx7pzNTWIUWi9pMna9U2enxVNucVXsobzxOUSEQv+6HXT8+0kolDuPYf2265T6EGm
	 Mu4j/wEANfUp8wo1yhuo1+1pnbBQt4BTxsWGclrSCPd1YDTtn+ErH/vFSDb2rxFdic
	 DBvBlVuP6yiiAxwMJcJHMgWRhNXmU7B/bvdEUm6FyhDysd/EcJk9F+4ZM83baLROU9
	 hmh3QsmW8SGb8uOax+meLtuOyaWpiAZKlnh0duJVZphxn8awE6VbjDUXw5UYSwgbcU
	 PfT0gpT61c1Fg==
Date: Sun, 23 Jun 2024 18:46:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <20240623131616.GA58184@thinkpad>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>

On Tue, Jun 11, 2024 at 09:50:56PM +0900, Yoshihiro Shimoda wrote:
> Add support for r8a779g0 (R-Car V4H).
> 
> This driver previously supported r8a779f0 (R-Car S4-8). PCIe features
> of both r8a779f0 and r8a779g0 are almost all the same. For example:
>  - PCI Express Base Specification Revision 4.0
>  - Root complex mode and endpoint mode are supported
> However, r8a779g0 requires specific firmware downloading, to
> initialize the PHY. Otherwise, the PCIe controller cannot work.
> 
> The attached firmware file "104_PCIe_fw_addr_data_ver1.05.txt" in
> the datasheet is a text file. But, Renesas is not able to distribute
> the firmware freely. So, we require converting the text file
> to a binary before the driver runs by using the following script:
> 
>  $ awk '/^\s*0x[0-9A-Fa-f]{4}\s+0x[0-9A-Fa-f]{4}/ \
>    { print substr($2,5,2) substr($2,3,2) }' \
>    104_PCIe_fw_addr_data_ver1.05.txt | xxd -p -r > \
>    rcar_gen4_pcie.bin
>  $ sha1sum rcar_gen4_pcie.bin
>    1d0bd4b189b4eb009f5d564b1f93a79112994945  rcar_gen4_pcie.bin
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 207 +++++++++++++++++++-
>  1 file changed, 206 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index dac78388975d..c67097e718d3 100644
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
> @@ -37,19 +40,48 @@
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
>  #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
>  #define RCAR_MAX_LINK_SPEED		4
>  
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
>  
> +/*
> + * The attached firmware file "104_PCIe_fw_addr_data_ver1.05.txt" in
> + * the datasheet is a text file. But, Renesas is not able to distribute
> + * the firmware freely. So, we require converting the text file
> + * to a binary before the driver runs by using the following script:
> + *
> + * $ awk '/^\s*0x[0-9A-Fa-f]{4}\s+0x[0-9A-Fa-f]{4}/ \
> + *      { print substr($2,5,2) substr($2,3,2) }' \
> + *      104_PCIe_fw_addr_data_ver1.05.txt | xxd -p -r > \
> + *      rcar_gen4_pcie.bin
> + *    $ sha1sum rcar_gen4_pcie.bin
> + *      1d0bd4b189b4eb009f5d564b1f93a79112994945  rcar_gen4_pcie.bin
> + */
> +#define RCAR_GEN4_PCIE_FIRMWARE_NAME		"rcar_gen4_pcie.bin"
> +#define RCAR_GEN4_PCIE_FIRMWARE_BASE_ADDR	0xc000
> +MODULE_FIRMWARE(RCAR_GEN4_PCIE_FIRMWARE_NAME);
> +
>  struct rcar_gen4_pcie;
>  struct rcar_gen4_pcie_drvdata {
> +	void (*additional_common_init)(struct rcar_gen4_pcie *rcar);
>  	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
>  	enum dw_pcie_device_mode mode;
>  };
> @@ -57,6 +89,7 @@ struct rcar_gen4_pcie_drvdata {
>  struct rcar_gen4_pcie {
>  	struct dw_pcie dw;
>  	void __iomem *base;
> +	void __iomem *phy_base;
>  	struct platform_device *pdev;
>  	const struct rcar_gen4_pcie_drvdata *drvdata;
>  };
> @@ -180,6 +213,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>  	if (ret)
>  		goto err_unprepare;
>  
> +	if (rcar->drvdata->additional_common_init)
> +		rcar->drvdata->additional_common_init(rcar);
> +
>  	return 0;
>  
>  err_unprepare:
> @@ -221,6 +257,10 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
>  
>  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>  {
> +	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
> +	if (IS_ERR(rcar->phy_base))
> +		return PTR_ERR(rcar->phy_base);
> +
>  	/* Renesas-specific registers */
>  	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
>  
> @@ -528,6 +568,167 @@ static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
>  	return 0;
>  }
>  
> +static void rcar_gen4_pcie_additional_common_init(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
> +	val &= ~PORT_LANE_SKEW_INSERT_MASK;
> +	if (dw->num_lanes < 4)
> +		val |= BIT(6);
> +	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
> +
> +	val = readl(rcar->base + PCIEPWRMNGCTRL);
> +	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
> +	writel(val, rcar->base + PCIEPWRMNGCTRL);
> +}
> +
> +static void rcar_gen4_pcie_phy_reg_update_bits(struct rcar_gen4_pcie *rcar,
> +					       u32 offset, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp = readl(rcar->phy_base + offset);
> +	tmp &= ~mask;
> +	tmp |= val;
> +	writel(tmp, rcar->phy_base + offset);
> +}
> +
> +/*
> + * SoC datasheet suggests checking port logic register bits during firmware
> + * write. If read returns non-zero value, then this function returns -EAGAIN
> + * indicating that the write needs to be done again. If read returns zero,
> + * then return 0 to indicate success.
> + */
> +static int rcar_gen4_pcie_reg_test_bit(struct rcar_gen4_pcie *rcar,
> +				       u32 offset, u32 mask)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +
> +	if (dw_pcie_readl_dbi(dw, offset) & mask)
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
> +static int rcar_gen4_pcie_download_phy_firmware(struct rcar_gen4_pcie *rcar)
> +{
> +	/* The check_addr values are magical numbers in the datasheet */
> +	const u32 check_addr[] = { 0x00101018, 0x00101118, 0x00101021, 0x00101121};
> +	struct dw_pcie *dw = &rcar->dw;
> +	const struct firmware *fw;
> +	unsigned int i, timeout;
> +	u32 data;
> +	int ret;
> +
> +	ret = request_firmware(&fw, RCAR_GEN4_PCIE_FIRMWARE_NAME, dw->dev);
> +	if (ret) {
> +		dev_err(dw->dev, "Failed to load firmware (%s): %d\n",
> +			RCAR_GEN4_PCIE_FIRMWARE_NAME, ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < (fw->size / 2); i++) {
> +		data = fw->data[(i * 2) + 1] << 8 | fw->data[i * 2];
> +		timeout = 100;
> +		do {
> +			dw_pcie_writel_dbi(dw, PRTLGC89, RCAR_GEN4_PCIE_FIRMWARE_BASE_ADDR + i);
> +			dw_pcie_writel_dbi(dw, PRTLGC90, data);
> +			if (!rcar_gen4_pcie_reg_test_bit(rcar, PRTLGC89, BIT(30)))
> +				break;
> +			if (!(--timeout)) {
> +				ret = -ETIMEDOUT;
> +				goto exit;
> +			}
> +			usleep_range(100, 200);
> +		} while (1);
> +	}
> +
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x0f8, BIT(17), BIT(17));
> +
> +	for (i = 0; i < ARRAY_SIZE(check_addr); i++) {
> +		timeout = 100;
> +		do {
> +			dw_pcie_writel_dbi(dw, PRTLGC89, check_addr[i]);
> +			ret = rcar_gen4_pcie_reg_test_bit(rcar, PRTLGC89, BIT(30));
> +			ret |= rcar_gen4_pcie_reg_test_bit(rcar, PRTLGC90, BIT(0));
> +			if (!ret)
> +				break;
> +			if (!(--timeout)) {
> +				ret = -ETIMEDOUT;
> +				goto exit;
> +			}
> +			usleep_range(100, 200);
> +		} while (1);
> +	}
> +
> +exit:
> +	release_firmware(fw);
> +
> +	return ret;
> +}
> +
> +static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +	u32 val;
> +	int ret;
> +
> +	if (!enable) {
> +		val = readl(rcar->base + PCIERSTCTRL1);
> +		val &= ~APP_LTSSM_ENABLE;
> +		writel(val, rcar->base + PCIERSTCTRL1);
> +
> +		return 0;
> +	}
> +
> +	val = dw_pcie_readl_dbi(dw, PCIE_PORT_FORCE);
> +	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> +	dw_pcie_writel_dbi(dw, PCIE_PORT_FORCE, val);
> +
> +	val = readl(rcar->base + PCIEMSR0);
> +	val |= APP_SRIS_MODE;
> +	writel(val, rcar->base + PCIEMSR0);
> +
> +	/*
> +	 * The R-Car Gen4 datasheet doesn't describe the PHY registers' name.
> +	 * But, the initialization procedure describes these offsets. So,
> +	 * this driver has magical offset numbers.
> +	 */
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x700, BIT(28), 0);
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x700, BIT(20), 0);
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x700, BIT(12), 0);
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x700, BIT(4), 0);
> +
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(23, 22), BIT(22));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(18, 16), GENMASK(17, 16));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(7, 6), BIT(6));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(2, 0), GENMASK(11, 0));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x1d4, GENMASK(16, 15), GENMASK(16, 15));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x514, BIT(26), BIT(26));
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x0f8, BIT(16), 0);
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x0f8, BIT(19), BIT(19));
> +
> +	val = readl(rcar->base + PCIERSTCTRL1);
> +	val &= ~APP_HOLD_PHY_RST;
> +	writel(val, rcar->base + PCIERSTCTRL1);
> +
> +	ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)), 100, 10000);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = rcar_gen4_pcie_download_phy_firmware(rcar);
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
>  static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
>  	.ltssm_control = r8a779f0_pcie_ltssm_control,
>  	.mode = DW_PCIE_RC_TYPE,
> @@ -539,10 +740,14 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
>  };
>  
>  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
> +	.additional_common_init = rcar_gen4_pcie_additional_common_init,
> +	.ltssm_control = rcar_gen4_pcie_ltssm_control,
>  	.mode = DW_PCIE_RC_TYPE,
>  };
>  
>  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
> +	.additional_common_init = rcar_gen4_pcie_additional_common_init,
> +	.ltssm_control = rcar_gen4_pcie_ltssm_control,
>  	.mode = DW_PCIE_EP_TYPE,
>  };
>  
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

