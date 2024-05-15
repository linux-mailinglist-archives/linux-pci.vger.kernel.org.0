Return-Path: <linux-pci+bounces-7483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BBF8C625F
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 10:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D2D1F22775
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 08:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FA83D966;
	Wed, 15 May 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeJr4pxL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30094EB20;
	Wed, 15 May 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760000; cv=none; b=Lj2OPz3RH9HNGTH680DcNEvC+HfBNedaadbt9ME/N3qy5B4JBAbfv5p2fMGY8KeGtns273FDf5q9S9+VQwH0zgif7cUqiQfRquY3dnPsSHbEGUD7feJyNxAGxRr7i3UUew004ieDs3+nbsG+70y+odRTC/6w02ndb9hBUkpvBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760000; c=relaxed/simple;
	bh=r+0+Vq6qbg/imR9e3YB2vyU97C4EsrWijbTNlk08K5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnDXxukCGU8I5ZzteFaeNry00QXFHiilmnyTWAhCaN4so50f8ai/VM1yl399/ifE6kGFIRoeLQEvZ5PMPbhQ1bAyOq3f9NNApksGTNvD073nKejs+EX1B/dmPb3IWCX1m1xGyNqbceypO9TfnzBy9L9Ze9D/HzyvMxGFcLIiBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeJr4pxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B846C116B1;
	Wed, 15 May 2024 07:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715760000;
	bh=r+0+Vq6qbg/imR9e3YB2vyU97C4EsrWijbTNlk08K5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeJr4pxLAzdNk1vg2yM0wBa3yk2/2n3VBc5BTxc9xW+gNzcghL7nWBqZWxreT5DXf
	 MI51aeQqYw/TuWBJnqyJuxOKFu1pDEtO0/lA1mXuwgvj7XnBEHpV9dz3RpWdIlPQtF
	 mKRXq2hIk7wj/kBfuvxIvVyMVhCCpomLMcQqIGVqFACCSnH8VcdYGr/D6pMSDJ0GfD
	 TVc3la18A/on2DV4cmTGts6Fs3nm0vA77N2+X1vWL0g1B6/CBtxE5m7p9X1HvX4LG2
	 JXxky4lij2Ax823WQlsRbguOqz+DbcPT9IfltD7VYmkNYaw5DHYnIznrElelEk4MYX
	 bEbq1am7WF0kA==
Date: Wed, 15 May 2024 09:59:54 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <20240515075954.GB4488@thinkpad>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-7-yoshihiro.shimoda.uh@renesas.com>
 <20240511080257.GF6672@thinkpad>
 <TYCPR01MB110409C8FC92A7C466627E0A2D8E32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB110409C8FC92A7C466627E0A2D8E32@TYCPR01MB11040.jpnprd01.prod.outlook.com>

On Tue, May 14, 2024 at 11:27:30AM +0000, Yoshihiro Shimoda wrote:
> Hi Manivannan,
> 
> > From: Manivannan Sadhasivam, Sent: Saturday, May 11, 2024 5:03 PM
> > 
> > On Mon, Apr 15, 2024 at 05:11:34PM +0900, Yoshihiro Shimoda wrote:
> > > This driver previously supported r8a779f0 (R-Car S4-8). Add support
> > > for r8a779g0 (R-Car V4H). PCIe features of both r8a779f0 and r8a779g0
> > > are almost all the same. For example:
> > >  - PCI Express Base Specification Revision 4.0
> > >  - Root complex mode and endpoint mode are supported
> > >
> > > However, r8a779g0 requires specific firmware downloading, to
> > > initialize the PHY. Otherwise, the PCIe controller cannot work.
> > > The firmware is attached in the manual of the r8a779g0 as text.
> > > So, convert it to a binary file by using a script.
> > 
> > The firmware is expected to be present in userspace. So where is it btw? Is it
> > upstreamed to linux-firmware?
> 
> I may misunderstand your question, but the firmware is in the SoC's datasheet as
> a text file. So, we need to convert it to a binary file and store it into the rootfs.
> (Also, for debug purpose, we can use built-in firmware from "CONFIG_EXTRA_FIRMWARE".)
> 
> > You cannot ask users to manually copy the text and convert it to a binary file.
> > But if the firmware or sequence is not going to change, why can't you hardcode
> > it in the driver itself?
> 
> This is because that Renesas is not able to distribute the firmware freely.
> 

Seriously? Are you saying that the user has to sign NDA to get this firmware?

- Mani

> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 201 +++++++++++++++++++-
> > >  1 file changed, 200 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > index 980a916933d6..4e934e9156f2 100644
> > > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > @@ -5,8 +5,10 @@
> > >   */
> > >
> > >  #include <linux/delay.h>
> > > +#include <linux/firmware.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/pci.h>
> > > @@ -20,9 +22,10 @@
> > >  /* Renesas-specific */
> > >  /* PCIe Mode Setting Register 0 */
> > >  #define PCIEMSR0		0x0000
> > > -#define BIFUR_MOD_SET_ON	BIT(0)
> > > +#define APP_SRIS_MODE		BIT(6)
> > >  #define DEVICE_TYPE_EP		0
> > >  #define DEVICE_TYPE_RC		BIT(4)
> > > +#define BIFUR_MOD_SET_ON	BIT(0)
> > >
> > >  /* PCIe Interrupt Status 0 */
> > >  #define PCIEINTSTS0		0x0084
> > > @@ -37,19 +40,47 @@
> > >  #define PCIEDMAINTSTSEN		0x0314
> > >  #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> > >
> > > +/* Port Logic Registers 89 */
> > > +#define PRTLGC89		0x0b70
> > > +
> > > +/* Port Logic Registers 90 */
> > > +#define PRTLGC90		0x0b74
> > > +
> > >  /* PCIe Reset Control Register 1 */
> > >  #define PCIERSTCTRL1		0x0014
> > >  #define APP_HOLD_PHY_RST	BIT(16)
> > >  #define APP_LTSSM_ENABLE	BIT(0)
> > >
> > > +/* PCIe Power Management Control */
> > > +#define PCIEPWRMNGCTRL		0x0070
> > > +#define APP_CLK_REQ_N		BIT(11)
> > > +#define APP_CLK_PM_EN		BIT(10)
> > > +
> > > +/*
> > > + * The R-Car Gen4 documents don't describe the PHY registers' name.
> > > + * But, the initialization procedure describes these offsets. So,
> > > + * this driver makes up own #defines for the offsets.
> > > + */
> > > +#define RCAR_GEN4_PCIE_PHY_0f8	0x0f8
> > > +#define RCAR_GEN4_PCIE_PHY_148	0x148
> > > +#define RCAR_GEN4_PCIE_PHY_1d4	0x1d4
> > > +#define RCAR_GEN4_PCIE_PHY_514	0x514
> > > +#define RCAR_GEN4_PCIE_PHY_700	0x700
> > > +
> > 
> > As I said before, these defines provide no information about the registers at
> > all. So please use the offset directly and add a comment.
> 
> I got it.
> 
> > >  #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
> > >  #define RCAR_MAX_LINK_SPEED		4
> > >
> > >  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
> > >  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
> > >
> > > +#define RCAR_GEN4_PCIE_FIRMWARE_NAME		"rcar_gen4_pcie.bin"
> > > +#define RCAR_GEN4_PCIE_FIRMWARE_BASE_ADDR	0xc000
> > > +
> > > +MODULE_FIRMWARE(RCAR_GEN4_PCIE_FIRMWARE_NAME);
> > > +
> > >  struct rcar_gen4_pcie;
> > >  struct rcar_gen4_pcie_drvdata {
> > > +	void (*additional_common_init)(struct rcar_gen4_pcie *rcar);
> > 
> > What is this init for? Controller? PHY?
> 
> This init is for controller.
> 
> > >  	int (*ltssm_enable)(struct rcar_gen4_pcie *rcar);
> > >  	enum dw_pcie_device_mode mode;
> > >  };
> > > @@ -57,12 +88,144 @@ struct rcar_gen4_pcie_drvdata {
> > >  struct rcar_gen4_pcie {
> > >  	struct dw_pcie dw;
> > >  	void __iomem *base;
> > > +	void __iomem *phy_base;
> > >  	struct platform_device *pdev;
> > >  	const struct rcar_gen4_pcie_drvdata *drvdata;
> > >  };
> > >  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
> > >
> > >  /* Common */
> > > +static void rcar_gen4_pcie_phy_reg_update_bits(struct rcar_gen4_pcie *rcar,
> > > +					       u32 offset, u32 mask, u32 val)
> > > +{
> > > +	u32 tmp;
> > > +
> > > +	tmp = readl(rcar->phy_base + offset);
> > > +	tmp &= ~mask;
> > > +	tmp |= val;
> > > +	writel(tmp, rcar->phy_base + offset);
> > > +}
> > > +
> > > +static int rcar_gen4_pcie_reg_check(struct rcar_gen4_pcie *rcar,
> > > +				    u32 offset, u32 mask)
> > > +{
> > > +	struct dw_pcie *dw = &rcar->dw;
> > > +
> > > +	if (dw_pcie_readl_dbi(dw, offset) & mask)
> > > +		return -EAGAIN;
> > 
> > What is this function checking actually? It is just a DBI read. Do you expect
> > these register accesses to fail?
> 
> This function is checking whether the register's value with mask is zero or not.
> - If non-zero, return -EAGAIN.
> - If zero, return 0. (this is expected value.)
> 
> Perhaps, should I change the function name? For example, rcar_gen4_pcie_reg_test_bit()?
> According to the datasheet, software needs to write registers again if the register
> value(s) is(are) not expected value(s).
> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int rcar_gen4_pcie_download_phy_firmware(struct rcar_gen4_pcie *rcar)
> > > +{
> > > +	const u32 check_addr[] = { 0x00101018, 0x00101118, 0x00101021, 0x00101121};
> > 
> > What does this check_addr corresponds to?
> 
> I don't know. The datasheet just said that like other magic numbers.
> I'll add such a comment here.
> 
> > > +	struct dw_pcie *dw = &rcar->dw;
> > > +	const struct firmware *fw;
> > > +	unsigned int i, timeout;
> > > +	u32 data;
> > > +	int ret;
> > > +
> > > +	ret = request_firmware(&fw, RCAR_GEN4_PCIE_FIRMWARE_NAME, dw->dev);
> > > +	if (ret) {
> > > +		dev_err(dw->dev, "%s: Requesting firmware failed\n", __func__);
> > 
> > Print the firmware name in the case of error.
> 
> I got it.
> 
> > But as I said above, please try to hardcode the fw if it is not going to change.
> > We do this in other drivers as well.
> 
> As I mentioned above, I would like to keep calling this function.
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > - Mani
> > 
> > > +		return ret;
> > > +	}
> > > +
> > > +	for (i = 0; i < (fw->size / 2); i++) {
> > > +		data = fw->data[(i * 2) + 1] << 8 | fw->data[i * 2];
> > > +		timeout = 100;
> > > +		do {
> > > +			dw_pcie_writel_dbi(dw, PRTLGC89, RCAR_GEN4_PCIE_FIRMWARE_BASE_ADDR + i);
> > > +			dw_pcie_writel_dbi(dw, PRTLGC90, data);
> > > +			if (rcar_gen4_pcie_reg_check(rcar, PRTLGC89, BIT(30)) >= 0)
> > > +				break;
> > > +			if (!(--timeout)) {
> > > +				ret = -ETIMEDOUT;
> > > +				goto exit;
> > > +			}
> > > +			usleep_range(100, 200);
> > > +		} while (1);
> > > +	}
> > > +
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_0f8, BIT(17), BIT(17));
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(check_addr); i++) {
> > > +		timeout = 100;
> > > +		do {
> > > +			dw_pcie_writel_dbi(dw, PRTLGC89, check_addr[i]);
> > > +			ret = rcar_gen4_pcie_reg_check(rcar, PRTLGC89, BIT(30));
> > > +			ret |= rcar_gen4_pcie_reg_check(rcar, PRTLGC90, BIT(0));
> > > +			if (ret >= 0)
> > > +				break;
> > > +			if (!(--timeout)) {
> > > +				ret = -ETIMEDOUT;
> > > +				goto exit;
> > > +			}
> > > +			usleep_range(100, 200);
> > > +		} while (1);
> > > +	}
> > > +
> > > +	ret = 0;
> > > +exit:
> > > +	release_firmware(fw);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int rcar_gen4_pcie_enable_phy(struct rcar_gen4_pcie *rcar)
> > > +{
> > > +	struct dw_pcie *dw = &rcar->dw;
> > > +	u32 val;
> > > +	int ret;
> > > +
> > > +	val = dw_pcie_readl_dbi(dw, PCIE_PORT_FORCE);
> > > +	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > > +	dw_pcie_writel_dbi(dw, PCIE_PORT_FORCE, val);
> > > +
> > > +	val = readl(rcar->base + PCIEMSR0);
> > > +	val |= APP_SRIS_MODE;
> > > +	writel(val, rcar->base + PCIEMSR0);
> > > +
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(28), 0);
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(20), 0);
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(12), 0);
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(4), 0);
> > > +
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> > > +					   GENMASK(23, 22), BIT(22));
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> > > +					   GENMASK(18, 16), GENMASK(17, 16));
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> > > +					   GENMASK(7, 6), BIT(6));
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> > > +					   GENMASK(2, 0), GENMASK(11, 0));
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_1d4,
> > > +					   GENMASK(16, 15), GENMASK(16, 15));
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_514, BIT(26), BIT(26));
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_0f8, BIT(16), 0);
> > > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_0f8, BIT(19), BIT(19));
> > > +
> > > +	val = readl(rcar->base + PCIERSTCTRL1);
> > > +	val &= ~APP_HOLD_PHY_RST;
> > > +	writel(val, rcar->base + PCIERSTCTRL1);
> > > +
> > > +	ret = readl_poll_timeout(rcar->phy_base + RCAR_GEN4_PCIE_PHY_0f8, val,
> > > +				 !(val & BIT(18)), 100, 10000);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret = rcar_gen4_pcie_download_phy_firmware(rcar);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	val = readl(rcar->base + PCIERSTCTRL1);
> > > +	val |= APP_LTSSM_ENABLE;
> > > +	writel(val, rcar->base + PCIERSTCTRL1);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static void rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar,
> > >  					 bool enable)
> > >  {
> > > @@ -200,6 +363,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
> > >  	if (ret)
> > >  		goto err_unprepare;
> > >
> > > +	if (rcar->drvdata->additional_common_init)
> > > +		rcar->drvdata->additional_common_init(rcar);
> > > +
> > >  	return 0;
> > >
> > >  err_unprepare:
> > > @@ -241,6 +407,10 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> > >
> > >  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
> > >  {
> > > +	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
> > > +	if (IS_ERR(rcar->phy_base))
> > > +		return PTR_ERR(rcar->phy_base);
> > > +
> > >  	/* Renesas-specific registers */
> > >  	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
> > >
> > > @@ -517,6 +687,31 @@ static int r8a779f0_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar)
> > >  	return 0;
> > >  }
> > >
> > > +static void rcar_gen4_pcie_additional_common_init(struct rcar_gen4_pcie *rcar)
> > > +{
> > > +	struct dw_pcie *dw = &rcar->dw;
> > > +	u32 val;
> > > +
> > > +	/*
> > > +	 * The SoC manual said the register setting is required. Otherwise,
> > > +	 * linkup failed.
> > > +	 */
> > > +	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
> > > +	val &= ~PORT_LANE_SKEW_INSERT_MASK;
> > > +	if (dw->num_lanes < 4)
> > > +		val |= BIT(6);
> > > +	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
> > > +
> > > +	val = readl(rcar->base + PCIEPWRMNGCTRL);
> > > +	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
> > > +	writel(val, rcar->base + PCIEPWRMNGCTRL);
> > > +}
> > > +
> > > +static int rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar)
> > > +{
> > > +	return rcar_gen4_pcie_enable_phy(rcar);
> > > +}
> > > +
> > >  static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
> > >  	.ltssm_enable = r8a779f0_pcie_ltssm_enable,
> > >  	.mode = DW_PCIE_RC_TYPE,
> > > @@ -528,10 +723,14 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
> > >  };
> > >
> > >  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
> > > +	.additional_common_init = rcar_gen4_pcie_additional_common_init,
> > > +	.ltssm_enable = rcar_gen4_pcie_ltssm_enable,
> > >  	.mode = DW_PCIE_RC_TYPE,
> > >  };
> > >
> > >  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
> > > +	.additional_common_init = rcar_gen4_pcie_additional_common_init,
> > > +	.ltssm_enable = rcar_gen4_pcie_ltssm_enable,
> > >  	.mode = DW_PCIE_EP_TYPE,
> > >  };
> > >
> > > --
> > > 2.25.1
> > >
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

