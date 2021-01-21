Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74662FE4BE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 09:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbhAUIQE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 03:16:04 -0500
Received: from regular1.263xmail.com ([211.150.70.206]:42012 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbhAUIDL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jan 2021 03:03:11 -0500
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 1D0DD1B3F;
        Thu, 21 Jan 2021 15:57:02 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19895T139772989269760S1611215820784170_;
        Thu, 21 Jan 2021 15:57:01 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <49256388058c1d29344f3644cafdfa67>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: shawn.lin@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_2/2=5d_PCI=3a_rockchip=3a_add_DesignWar?=
 =?UTF-8?B?ZSBiYXNlZCBQQ0llIGNvbnRyb2xsZXLjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFy?=
 =?UTF-8?B?b2JoZXJyaW5nMkBnbWFpbC5jb23ku6Plj5HjgJE=?=
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <20210120101658.241134-1-xxm@rock-chips.com>
 <20210120101658.241134-2-xxm@rock-chips.com>
 <20210120145515.GA66756@robh.at.kernel.org>
From:   xxm <xxm@rock-chips.com>
Message-ID: <b3a51d94-f24c-9019-e3a2-329c3147d7a5@rock-chips.com>
Date:   Thu, 21 Jan 2021 15:57:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210120145515.GA66756@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Thanks for your review, some replies inline. All you pointed out will be 
fixed in v3.

在 2021/1/20 22:55, Rob Herring 写道:
> On Wed, Jan 20, 2021 at 06:16:58PM +0800, Simon Xue wrote:
>> pcie-dw-rockchip is based on DWC IP. But pcie-rockchip-host
>> is another IP which is only used for RK3399. So all the following
> s/another/Cadence/
>
> There's been a lot of reworking of the DWC drivers. You need to update
> this based on that. Details inline.

DWC core really cover a lot, I think  I need to refactor some codes. 
It's more

reasonable to start link after all relative registers have set up. So,

dw_pcie_host_ops->host_init just do some set up works, link start should

postpone to dw_pcie_ops->start_link, and place rockchip_pcie_start_link  in

the dw_pcie_ops->start_link call back.

>
>> non-RK3399 SoCs should use this driver.
>>
>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>   drivers/pci/controller/Kconfig                |   4 +-
>>   drivers/pci/controller/dwc/Kconfig            |   9 +
>>   drivers/pci/controller/dwc/Makefile           |   1 +
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 370 ++++++++++++++++++
>>   4 files changed, 382 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>
>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>> index 64e2f5e379aa..48a7d62f97f3 100644
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -219,7 +219,7 @@ config PCIE_ROCKCHIP_HOST
>>   	help
>>   	  Say Y here if you want internal PCI support on Rockchip SoC.
>>   	  There is 1 internal PCIe port available to support GEN2 with
>> -	  4 slots.
>> +	  4 slots. Only for RK3399.
>>   
>>   config PCIE_ROCKCHIP_EP
>>   	bool "Rockchip PCIe endpoint controller"
>> @@ -231,7 +231,7 @@ config PCIE_ROCKCHIP_EP
>>   	help
>>   	  Say Y here if you want to support Rockchip PCIe controller in
>>   	  endpoint mode on Rockchip SoC. There is 1 internal PCIe port
>> -	  available to support GEN2 with 4 slots.
>> +	  available to support GEN2 with 4 slots. Only for RK3399.
> I would make these changes a separate patch. I have a pending patch to
> move this driver to the Cadence directory.
Ok, will remove this.
>>   
>>   config PCIE_MEDIATEK
>>   	tristate "MediaTek PCIe controller"
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 22c5529e9a65..110733d0c241 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -214,6 +214,15 @@ config PCIE_ARTPEC6_EP
>>   	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
>>   	  endpoint mode. This uses the DesignWare core.
>>   
>> +config PCIE_DW_ROCKCHIP_HOST
> PCIE_ROCKCHIP_DW_HOST to be more inline with other DWC config options.
>
>> +	bool "Rockchip DesignWare PCIe controller"
>> +	select PCIE_DW
>> +	select PCIE_DW_HOST
>> +	depends on ARCH_ROCKCHIP
> || COMPILE_TEST
>
>> +	depends on OF
>> +	help
>> +	  Enables support for the DW PCIe controller in the Rockchip SoC.
>> +
>>   config PCIE_INTEL_GW
>>   	bool "Intel Gateway PCIe host controller support"
>>   	depends on OF && (X86 || COMPILE_TEST)
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index a751553fa0db..9c7048d2be17 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -13,6 +13,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
>>   obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>>   obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>>   obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>> +obj-$(CONFIG_PCIE_DW_ROCKCHIP_HOST) += pcie-dw-rockchip.o
>>   obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>>   obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>>   obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> new file mode 100644
>> index 000000000000..e41cd6041c3f
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -0,0 +1,370 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCIe host controller driver for Rockchip SoCs
>> + *
>> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
>> + *		http://www.rock-chips.com
>> + *
>> + * Author: Simon Xue <xxm@rock-chips.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +
>> +#include "pcie-designware.h"
>> +
>> +/*
>> + * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
>> + * mask for the lower 16 bits.  This allows atomic updates
>> + * of the register without locking.
>> + */
>> +#define HIWORD_UPDATE(mask, val) (((mask) << 16) | (val))
>> +#define HIWORD_UPDATE_BIT(val)	HIWORD_UPDATE(val, val)
>> +
>> +#define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
>> +
>> +#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
>> +#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
>> +#define PCIE_SMLH_LINKUP		BIT(16)
>> +#define PCIE_RDLH_LINKUP		BIT(17)
>> +#define PCIE_L0S_ENTRY			0x11
>> +#define PCIE_CLIENT_GENERAL_CONTROL	0x0
>> +#define PCIE_CLIENT_GENERAL_DEBUG	0x104
>> +#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
>> +#define PCIE_CLIENT_LTSSM_STATUS	0x300
>> +#define PCIE_CLIENT_DBG_FIFO_MODE_CON	0x310
>> +#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0 0x320
>> +#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1 0x324
>> +#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0 0x328
>> +#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1 0x32c
>> +#define PCIE_CLIENT_DBG_FIFO_STATUS	0x350
>> +#define PCIE_CLIENT_DBG_TRANSITION_DATA	0xffff0000
>> +#define PCIE_CLIENT_DBF_EN		0xffff0003
>> +#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
>> +
>> +struct rockchip_pcie {
>> +	struct dw_pcie			*pci;
> Make this a struct, not a pointer. Then 1 alloc instead of 2.
>
>> +	void __iomem			*apb_base;
>> +	struct phy			*phy;
>> +	struct clk_bulk_data		*clks;
>> +	unsigned int			clk_cnt;
>> +	struct reset_control		*rst;
>> +	struct gpio_desc		*rst_gpio;
>> +	struct pcie_port		pp;
> Move this up to 2nd element.
No need to define pp,  struct dw_pcie already has one,  will remove this.
>
>> +	struct regulator                *vpcie3v3;
>> +};
>> +
>> +static inline int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
>> +					  u32 reg)
> You can drop inline on all of these. The compiler does that anyways with
> static functions.
>
>> +{
>> +	return readl(rockchip->apb_base + reg);
>> +}
>> +
>> +static inline void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
>> +					    u32 reg, u32 val)
> Use the same order as writel. val then reg.
>
>> +{
>> +	writel(val, rockchip->apb_base + reg);
>> +}
>> +
>> +static inline void rockchip_pcie_set_mode(struct rockchip_pcie *rockchip)
> Set what mode? Just drop this wrapper. The register access tells me more
> than the function name does.
>
>> +{
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_CONTROL,
>> +				 PCIE_CLIENT_RC_MODE);
>> +}
>> +
>> +static inline void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
>> +{
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_CONTROL,
>> +				 PCIE_CLIENT_ENABLE_LTSSM);
>> +}
>> +
>> +static int rockchip_pcie_link_up(struct dw_pcie *pci)
>> +{
>> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> +	u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
>> +
>> +	if ((val & (PCIE_RDLH_LINKUP | PCIE_SMLH_LINKUP)) == 0x30000 &&
>> +	    (val & GENMASK(5, 0)) == PCIE_L0S_ENTRY)
>> +		return 1;
> Just to confirm, the PORT_LOGIC registers for this don't work?
Yes, we need to check the link status from our own SoC's register.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static void rockchip_pcie_establish_link(struct dw_pcie *pci)
> s/establish/start/
>
>> +{
>> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> +
>> +	if (dw_pcie_link_up(pci)) {
> The DWC core does this for you now.
>
>> +		dev_err(pci->dev, "link already up\n");
>> +		return;
>> +	}
>> +
>> +	/* Reset device */
>> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
>> +	msleep(100);
>> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
>> +
>> +	rockchip_pcie_enable_ltssm(rockchip);
>> +}
>> +
>> +static void rockchip_pcie_enable_debug(struct rockchip_pcie *rockchip)
>> +{
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0,
>> +				 PCIE_CLIENT_DBG_TRANSITION_DATA);
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1,
>> +				 PCIE_CLIENT_DBG_TRANSITION_DATA);
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0,
>> +				 PCIE_CLIENT_DBG_TRANSITION_DATA);
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1,
>> +				 PCIE_CLIENT_DBG_TRANSITION_DATA);
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_MODE_CON,
>> +				 PCIE_CLIENT_DBF_EN);
>> +}
>> +
>> +static void rockchip_pcie_debug_dump(struct rockchip_pcie *rockchip)
>> +{
>> +	u32 loop;
>> +	struct dw_pcie *pci = rockchip->pci;
>> +
>> +	dev_dbg(pci->dev, "ltssm = 0x%x\n",
>> +		rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS));
>> +	for (loop = 0; loop < 64; loop++)
>> +		dev_dbg(pci->dev, "fifo_status = 0x%x\n",
>> +			rockchip_pcie_readl_apb(rockchip,
>> +						PCIE_CLIENT_DBG_FIFO_STATUS));
>> +}
> Please document what this debug stuff does. I tend to think it should be
> removed.
Ok, will remove this.
>> +
>> +static int rockchip_pcie_host_init(struct pcie_port *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> +
>> +	dw_pcie_setup_rc(pp);
> The DWC core does this now after host_init.
>
>> +
>> +	rockchip_pcie_enable_debug(rockchip);
>> +
>> +	rockchip_pcie_establish_link(pci);
>> +	dw_pcie_wait_for_link(pci);
> The DWC core does link handling now.
>
>> +
>> +	rockchip_pcie_debug_dump(rockchip);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
>> +	.host_init = rockchip_pcie_host_init,
>> +};
>> +
>> +static int rockchip_add_pcie_port(struct rockchip_pcie *rockchip)
> Remove this wrapper and move to probe.
>
>> +{
>> +	int ret;
>> +	struct dw_pcie *pci = rockchip->pci;
>> +	struct pcie_port *pp = &pci->pp;
>> +
>> +	pp->ops = &rockchip_pcie_host_ops;
>> +
>> +	rockchip_pcie_set_mode(rockchip);
>> +
>> +	ret = dw_pcie_host_init(pp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static void rockchip_pcie_clk_deinit(struct rockchip_pcie *rockchip)
>> +{
> Another pointless wrapper.
>
>> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>> +}
>> +
>> +static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
>> +{
>> +	struct device *dev = rockchip->pci->dev;
>> +	int ret;
>> +
>> +	ret = devm_clk_bulk_get_all(dev, &rockchip->clks);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	rockchip->clk_cnt = ret;
>> +
>> +	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_pcie_resource_get(struct platform_device *pdev,
>> +				      struct rockchip_pcie *rockchip)
>> +{
>> +	struct dw_pcie *pci = rockchip->pci;
>> +
>> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "pcie-dbi");
> The established name is 'dbi' and the DWC core handles it for you.
>
>> +	if (IS_ERR(pci->dbi_base))
>> +		return PTR_ERR(pci->dbi_base);
>> +
>> +	rockchip->apb_base = devm_platform_ioremap_resource_byname(pdev,
>> +								   "pcie-apb");
> Just 'apb' for the name.
>
>> +	if (IS_ERR(rockchip->apb_base))
>> +		return PTR_ERR(rockchip->apb_base);
>> +
>> +	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
>> +						     GPIOD_OUT_HIGH);
>> +	if (IS_ERR(rockchip->rst_gpio))
>> +		return PTR_ERR(rockchip->rst_gpio);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
>> +{
>> +	int ret;
>> +	struct device *dev = rockchip->pci->dev;
>> +
>> +	rockchip->phy = devm_phy_get(dev, "pcie-phy");
>> +	if (IS_ERR(rockchip->phy))
>> +		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
>> +				     "missing phy\n");
>> +
>> +	ret = phy_init(rockchip->phy);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	phy_power_on(rockchip->phy);
>> +
>> +	return 0;
>> +}
>> +
>> +static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
>> +{
>> +	phy_exit(rockchip->phy);
>> +	phy_power_off(rockchip->phy);
>> +}
>> +
>> +static int rockchip_pcie_reset_control_release(struct rockchip_pcie *rockchip)
>> +{
>> +	struct device *dev = rockchip->pci->dev;
>> +	int ret;
>> +
>> +	rockchip->rst = devm_reset_control_array_get_exclusive(dev);
>> +	if (IS_ERR(rockchip->rst))
>> +		return dev_err_probe(dev, PTR_ERR(rockchip->rst),
>> +				     "failed to get reset lines\n");
>> +
>> +	ret = reset_control_deassert(rockchip->rst);
>> +
>> +	return ret;
>> +}
>> +
>> +static void rockchip_pcie_fast_link_setup(struct rockchip_pcie *rockchip)
>> +{
>> +	u32 val;
>> +
>> +	/* LTSSM EN ctrl mode */
>> +	val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL);
>> +	val |= PCIE_LTSSM_ENABLE_ENHANCE | (PCIE_LTSSM_ENABLE_ENHANCE << 16);
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL, val);
>> +}
>> +
>> +static const struct of_device_id rockchip_pcie_of_match[] = {
>> +	{ .compatible = "rockchip,rk3568-pcie", },
>> +	{ /* sentinel */ },
>> +};
> Move this next to MODULE_DEVICE_TABLE.
>
>> +
>> +static const struct dw_pcie_ops dw_pcie_ops = {
>> +	.link_up = rockchip_pcie_link_up,
>> +};
>> +
>> +static int rockchip_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct rockchip_pcie *rockchip;
>> +	struct dw_pcie *pci;
>> +	int ret;
>> +
>> +	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
>> +	if (!rockchip)
>> +		return -ENOMEM;
>> +
>> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
>> +	if (!pci)
>> +		return -ENOMEM;
>> +
>> +	pci->dev = dev;
>> +	pci->ops = &dw_pcie_ops;
>> +
>> +	rockchip->pci = pci;
>> +
>> +	ret = rockchip_pcie_resource_get(pdev, rockchip);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* DON'T MOVE ME: must be enable before phy init */
>> +	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
>> +	if (IS_ERR(rockchip->vpcie3v3)) {
>> +		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
> I think that cannot happen since it is optional.
>
>> +			return PTR_ERR(rockchip->vpcie3v3);
> Use dev_err_probe()
>
>> +		dev_info(dev, "no vpcie3v3 regulator found\n");
> So? It's optional.

Yes, vpcie3v3 is enabled by software or by hardware directly. If get 
NULL, means

enabled by hardware directly.

>> +	}
>> +
>> +	if (!IS_ERR(rockchip->vpcie3v3)) {
> You shouldn't need this check.
>
>> +		ret = regulator_enable(rockchip->vpcie3v3);
>> +		if (ret) {
>> +			dev_err(pci->dev, "fail to enable vpcie3v3 regulator\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = rockchip_pcie_phy_init(rockchip);
>> +	if (ret)
>> +		goto disable_regulator;
>> +
>> +	ret = rockchip_pcie_reset_control_release(rockchip);
>> +	if (ret)
>> +		goto deinit_phy;
>> +
>> +	ret = rockchip_pcie_clk_init(rockchip);
>> +	if (ret)
>> +		goto deinit_phy;
>> +
>> +	rockchip_pcie_fast_link_setup(rockchip);
>> +
>> +	platform_set_drvdata(pdev, rockchip);
> Move this up next to 'rockchip' alloc.
>
>> +
>> +	ret = rockchip_add_pcie_port(rockchip);
>> +	if (ret)
>> +		goto deinit_clk;
>> +
>> +	return 0;
>> +
>> +deinit_clk:
>> +	rockchip_pcie_clk_deinit(rockchip);
>> +deinit_phy:
>> +	rockchip_pcie_phy_deinit(rockchip);
>> +disable_regulator:
>> +	if (!IS_ERR(rockchip->vpcie3v3))
> Shouldn't need this check.
>
>> +		regulator_disable(rockchip->vpcie3v3);
>> +
>> +	return ret;
>> +}
>> +
>> +MODULE_DEVICE_TABLE(of, rockchip_pcie_of_match);
>> +
>> +static struct platform_driver rockchip_pcie_driver = {
>> +	.driver = {
>> +		.name	= "rk-pcie",
>> +		.of_match_table = rockchip_pcie_of_match,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe = rockchip_pcie_probe,
>> +};
>> +
>> +builtin_platform_driver(rockchip_pcie_driver);
>> -- 
>> 2.25.1
>>
>>
>>
>


