Return-Path: <linux-pci+bounces-5205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EBB88CF61
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 21:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442DA1F86AEE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 20:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF6A12AAF3;
	Tue, 26 Mar 2024 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYCFtdPg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1105B126F15;
	Tue, 26 Mar 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486125; cv=none; b=Voo88WvNgVNh3e0RG6H1QAxY1jpolXRHAuUihg3c1FixCe0PZl5g6RI9tl6fw2J14NCxX/VFNvbFJK1DHHHw1qaWbTlew1H9Mw/2zxup/49CEgGfw/IkCR5+mZhV2DU0uJHarAIcgy+tqWJY1eIjBwDX78TG5qwANMDAHhgqEK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486125; c=relaxed/simple;
	bh=etagSp8usbIkSs3Qd9csBaKTS3qW9BN61rqxkjf/juU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AISW/xnbXozYcYPf81A1WTIU1yeGeDNb6wzpDfrsDQCFZqWXJpeQEaGIgv5+CzslgnWGXO+96Ygb5QsCxrxqkgqvVphWdgqStlxgY3qps7P2HRwJHPSR/SCOJTMGWv83pbMQSjV6C0paHinxTtoxCkljwFEehdxXJkd/N6BF+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYCFtdPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A24FC433C7;
	Tue, 26 Mar 2024 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711486124;
	bh=etagSp8usbIkSs3Qd9csBaKTS3qW9BN61rqxkjf/juU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PYCFtdPgKe2ritnqym6V42PS7psm4AdruwY+bzvFXIccaCmYWAasovhAAEkJZgdoh
	 K80aYVAyDbuopqXrm7N+W2H7VktmzD21PUyZRuzwdEBSKoYMCv4KRl1NChiOXPJy74
	 hd0RgUe8WxhuWSVJap6g6vvbnY7MFrUVxmb6r6S+ASBBD+tiM6Yl5xld9D7gD4fDYp
	 EKZF3gArxbaJC5kinQmGx0Vx+X8fjhXIIvQAjZNXlkm6+EXdy5JfhhdwmujZ5yQJgk
	 8V+SppbaReAK5tmhaMKARL+gwcWBL5OIO1xwqjzEUFjq7hOSpQE6wrvpoBxuVbOXle
	 3SCIyOe4Coylg==
Date: Tue, 26 Mar 2024 15:48:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] PCI: dwc: rcar-gen4: Add support for other R-Car
 Gen4 PCIe controller
Message-ID: <20240326204842.GA1493890@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326024540.2336155-6-yoshihiro.shimoda.uh@renesas.com>

The subject line should specify which controller(s) this adds support
for.

On Tue, Mar 26, 2024 at 11:45:39AM +0900, Yoshihiro Shimoda wrote:
> The PCIe controllers of R-Car V4H (r8a779g0) and one more SoC require
> different initializing settings than R-Car S4-8 (r8a779f0). So, add
> specific functions for them as "renesas,rcar-gen4-pcie{-ep}" compatible.

I can't tell from this what's being added.  This should say something
like "this driver previously supported r8....  Add support for r8...."
so it's clear what was existing and what is new.

Hmm... the first use of request_firmware() in drivers/pci/.  That
warrants a mention here as it's a pretty significant change.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 188 +++++++++++++++++++-
>  1 file changed, 187 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index a37613dd9ff4..7f3b5e9ca405 100644
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
> @@ -37,33 +40,179 @@
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
> +#define RCAR_GEN4_PCIE_FIRMEARE_NAME		"rcar_gen4_pcie.bin"
> +#define RCAR_GEN4_PCIE_FIRMEARE_BASE_ADDR	0xc000

s/FIRMEARE/FIRMWARE/

>  struct rcar_gen4_pcie {
>  	struct dw_pcie dw;
>  	void __iomem *base;
> +	/*
> +	 * The R-Car Gen4 documents don't describe the PHY registers' name.
> +	 * But, the initialization procedure describes these offsets. So,
> +	 * this driver has "phy_base + magical offset number" for it.

Make up your own #defines for the offsets.  That would be better than
magic hex offsets below.

> +	void __iomem *phy_base;
>  	struct platform_device *pdev;
>  	enum dw_pcie_device_mode mode;
>  
>  	int (*start_link_enable)(struct rcar_gen4_pcie *rcar);
> +	void (*additional_common_init)(struct rcar_gen4_pcie *rcar);
>  };
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>  
>  struct rcar_gen4_pcie_platdata {
>  	enum dw_pcie_device_mode mode;
>  	int (*start_link_enable)(struct rcar_gen4_pcie *rcar);
> +	void (*additional_common_init)(struct rcar_gen4_pcie *rcar);
>  };
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
> +}
> +
> +static int rcar_gen4_pcie_reg_check_bit(struct rcar_gen4_pcie *rcar,
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
> +	struct dw_pcie *dw = &rcar->dw;
> +	const struct firmware *fw;
> +	unsigned int i, timeout;
> +	u32 data;
> +	int ret;
> +
> +	ret = request_firmware(&fw, RCAR_GEN4_PCIE_FIRMEARE_NAME, dw->dev);
> +	if (ret)
> +		return ret;

It looks like a failure here leads to a probe failure, so I think this
needs a diagnostic message so the user has a hint about what went
wrong.

> +	for (i = 0; i < (fw->size / 2); i++) {
> +		data = fw->data[i * 2] | fw->data[(i * 2) + 1] << 8;
> +		timeout = 100;
> +retry_data:
> +		dw_pcie_writel_dbi(dw, PRTLGC89, RCAR_GEN4_PCIE_FIRMEARE_BASE_ADDR + i);
> +		dw_pcie_writel_dbi(dw, PRTLGC90, data);
> +		if (rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC89, BIT(30)) < 0) {
> +			if (!(--timeout)) {
> +				ret = -ETIMEDOUT;
> +				goto exit;
> +			}
> +			usleep_range(100, 200);
> +			goto retry_data;
> +		}
> +	}
> +
> +	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x0f8, BIT(17), BIT(17));
> +
> +	for (i = 0; i < ARRAY_SIZE(check_addr); i++) {
> +		timeout = 100;
> +retry_check:
> +		dw_pcie_writel_dbi(dw, PRTLGC89, check_addr[i]);
> +		ret = rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC89, BIT(30));
> +		ret |= rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC90, BIT(0));
> +		if (ret < 0) {
> +			if (!(--timeout)) {
> +				ret = -ETIMEDOUT;
> +				goto exit;
> +			}
> +			usleep_range(100, 200);
> +			goto retry_check;
> +		}
> +	}
> +
> +	ret = 0;
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
> +	ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)),
> +				 100, 10000);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = rcar_gen4_pcie_update_phy_firmware(rcar);
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
>  static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
>  					bool enable)
>  {
> @@ -201,6 +350,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>  	if (ret)
>  		goto err_unprepare;
>  
> +	if (rcar->additional_common_init)
> +		rcar->additional_common_init(rcar);
>
>  	return 0;
>  
>  err_unprepare:
> @@ -242,6 +394,10 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
>  
>  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>  {
> +	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
> +	if (IS_ERR(rcar->phy_base))
> +		return PTR_ERR(rcar->base);

I don't get it.  This imposes a new requirement (presence of "phy"
resource) on the existing SoCs.  That doesn't sound right.

>  	/* Renesas-specific registers */
>  	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
>  
> @@ -452,6 +608,7 @@ static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
>  
>  	rcar->mode = pd->mode;
>  	rcar->start_link_enable = pd->start_link_enable;
> +	rcar->additional_common_init = pd->additional_common_init;
>  
>  	switch (rcar->mode) {
>  	case DW_PCIE_RC_TYPE:
> @@ -521,6 +678,31 @@ static int r8a779f0_pcie_start_link_enable(struct rcar_gen4_pcie *rcar)
>  	return 0;
>  }
>  
> +static int rcar_gen4_pcie_start_link_enable(struct rcar_gen4_pcie *rcar)
> +{
> +	return rcar_gen4_pcie_enable_phy(rcar);
> +}
> +
> +static void rcar_gen4_pcie_additional_common_init(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +	u32 val;
> +
> +	/*
> +	 * The SoC manual said the register setting is required. Otherwise,
> +	 * linkup failed.
> +	 */
> +	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
> +	val &= ~PORT_LANE_SKEW_INSERT_MASK;
> +	if (dw->num_lanes < 4)
> +		val |= BIT(6);
> +	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
> +
> +	val = readl(rcar->base + PCIEPWRMNGCTRL);
> +	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
> +	writel(val, rcar->base + PCIEPWRMNGCTRL);

I don't get this either.  You do this "additional_common_init" part
only for the existing "renesas,rcar-gen4-pcie" and
"renesas,rcar-gen4-pcie-ep", but PCIE_PORT_LANE_SKEW and
PCIEPWRMNGCTRL do not appear in the driver prior to these patches.  I
must be missing something.  Or this is backwards and you meant to do
this for the *new* SoC?

If you need to limit some functionality to existing SoCs and add new
functionality for new SoCs, do those in separate patches if you can.

> +}
> +
>  static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie = {
>  	.mode = DW_PCIE_RC_TYPE,
>  	.start_link_enable = r8a779f0_pcie_start_link_enable,
> @@ -533,10 +715,14 @@ static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie_ep = {
>  
>  static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie = {
>  	.mode = DW_PCIE_RC_TYPE,
> +	.start_link_enable = rcar_gen4_pcie_start_link_enable,
> +	.additional_common_init = rcar_gen4_pcie_additional_common_init,
>  };
>  
>  static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie_ep = {
>  	.mode = DW_PCIE_EP_TYPE,
> +	.start_link_enable = rcar_gen4_pcie_start_link_enable,
> +	.additional_common_init = rcar_gen4_pcie_additional_common_init,
>  };
>  
>  static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> -- 
> 2.25.1
> 

