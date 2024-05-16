Return-Path: <linux-pci+bounces-7573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44CA8C76E9
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 14:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899CB28221B
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5C9146005;
	Thu, 16 May 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fafO1B9c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1E28680;
	Thu, 16 May 2024 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863896; cv=none; b=LnGPZsKx7CnpKpFjv6EvhuLKl+pPze+tk3QbVgFzGivvCAm8IyqgD53ii1ZWj6SvGsFJ8n3bKoZ9ZFxxXGKX+KtN6GSzPTqvXBYtTpBe/WLgsq+ZzZw6hjd9gJHiZh1oX6xGmctnnvuk/VXRmgaQFbV6Fl9t+lzW4JhiveOudig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863896; c=relaxed/simple;
	bh=gIP397vOaMszVFwOZPjH+lMPcE1/OwOTTyKbzqbf08o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ58w4ikJ9IE+aoVNKEhnnAHHB2F6VJ9IlPij8HcTND3o8tPqvEfIyeCjKmQV4cBXrwFxwM9n1Nmux5B+D7vsBaPLpz8wBoD3eEaZujF+bxY46RXJ5Dwurl894Hk1qP5RHb4NRQV4Yj7402uunXWw0Zf0p836IKrgFMITFNK67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fafO1B9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FA5C2BD11;
	Thu, 16 May 2024 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715863895;
	bh=gIP397vOaMszVFwOZPjH+lMPcE1/OwOTTyKbzqbf08o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fafO1B9cA1pOqRnw4BP1JQpah+6FiMvYbhzZeE3qIqCjifVrAlSOGOu2kJwDHH8pI
	 b5Bor0cPDq5md71nBqaGGb83WHhN058uEOaXdeyMHk7MIvRyDi/sAFHVoK0SgsTdjB
	 5zCebWWLLnw+Ugkm3+DG9ewBW41KONdj9/mWa9MtZzMfmViMauyvxSPUXiRYbFNwb9
	 PF9NnPFGdGCI5J30zx3mzvH1APnvdoDJJSZ49qr5jEHeLosyWmwEKLyCoSSAGowmzw
	 oFlJrpCmy9KlTQ4Akp+zEqIalTnpZoekRMM+9IYk4mu2o/gLYKX8W2z7lpuLIBzsk4
	 KD5mKuA3z6RRA==
Date: Thu, 16 May 2024 14:51:30 +0200
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
Message-ID: <20240516125130.GB11261@thinkpad>
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

So how does the conversion need to happen? Does it require any tool or just copy
the content to a file and pass it as a firmware?

Whatever the method is, it should be documented in the commit message (also in
the driver).

> > You cannot ask users to manually copy the text and convert it to a binary file.
> > But if the firmware or sequence is not going to change, why can't you hardcode
> > it in the driver itself?
> 
> This is because that Renesas is not able to distribute the firmware freely.
> 
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

Why do you need a callback for this? There is just a single function that is
used as of now, so please move the contents to rcar_gen4_pcie_common_init().

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

Well, I was asking under what circumstances the write may result in non-zero
value?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

