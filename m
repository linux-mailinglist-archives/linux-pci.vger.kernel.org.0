Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26A327A98B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1Ic5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 28 Sep 2020 04:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI1Ic5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 04:32:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7AFC0613CE
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 01:32:57 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kMoaY-00083X-Mf; Mon, 28 Sep 2020 10:32:50 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kMoaQ-0004M0-Ts; Mon, 28 Sep 2020 10:32:42 +0200
Message-ID: <aaccd827fa6de117d27319884f2d70a2ea91aa5e.camel@pengutronix.de>
Subject: Re: [v3,2/3] PCI: mediatek: Add new generation controller support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        davem@davemloft.net, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com
Date:   Mon, 28 Sep 2020 10:32:42 +0200
In-Reply-To: <20200927074555.4155-3-jianjun.wang@mediatek.com>
References: <20200927074555.4155-1-jianjun.wang@mediatek.com>
         <20200927074555.4155-3-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jianjun,

On Sun, 2020-09-27 at 15:45 +0800, Jianjun Wang wrote:
> MediaTek's PCIe host controller has three generation HWs, the new
> generation HW is an individual bridge, it supoorts Gen3 speed and
> up to 256 MSI interrupt numbers for multi-function devices.
> 
> Add support for new Gen3 controller which can be found on MT8192.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/Kconfig              |   14 +
>  drivers/pci/controller/Makefile             |    1 +
>  drivers/pci/controller/pcie-mediatek-gen3.c | 1024 +++++++++++++++++++
>  3 files changed, 1039 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-mediatek-gen3.c
> 
[...]
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> new file mode 100644
> index 000000000000..ad69c789b24d
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -0,0 +1,1024 @@
[...]
> +static int mtk_pcie_power_up(struct mtk_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	int err;
> +
> +	port->phy_reset = devm_reset_control_get_optional_exclusive(dev,
> +								    "phy-rst");
> +	if (IS_ERR(port->phy_reset))
> +		return PTR_ERR(port->phy_reset);
> +
> +	reset_control_deassert(port->phy_reset);

In general, it is better to request all required resources before
starting to activate the hardware.

> +
> +	/* PHY power on and enable pipe clock */
> +	port->phy = devm_phy_optional_get(dev, "pcie-phy");
> +	if (IS_ERR(port->phy))
> +		return PTR_ERR(port->phy);

For example, if the PHY driver is not loaded yet and this returns
-EPROBE_DEFER, it was not useful to take the PHY out of reset above.
Also, phy-rst is kept deasserted if this fails.

> +
> +	err = phy_init(port->phy);
> +	if (err) {
> +		dev_notice(dev, "failed to initialize pcie phy\n");
> +		return err;

phy-rst is kept deasserted if this fails.

> +	}
> +
> +	err = phy_power_on(port->phy);
> +	if (err) {
> +		dev_notice(dev, "failed to power on pcie phy\n");
> +		goto err_phy_on;
> +	}
> +
> +	port->mac_reset = devm_reset_control_get_optional_exclusive(dev,
> +								    "mac-rst");
> +	if (IS_ERR(port->mac_reset))
> +		return PTR_ERR(port->mac_reset);

The PHY is not powered down if this fails.

> +
> +	reset_control_deassert(port->mac_reset);
> +
> +	/* MAC power on and enable transaction layer clocks */
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
> +	err = mtk_pcie_clk_init(port);
> +	if (err) {
> +		dev_notice(dev, "clock init failed\n");
> +		goto err_clk_init;
> +	}
> +
> +	return 0;
> +
> +err_clk_init:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	reset_control_assert(port->mac_reset);
> +	phy_power_off(port->phy);
> +err_phy_on:
> +	phy_exit(port->phy);
> +	reset_control_assert(port->phy_reset);
> +
> +	return -EBUSY;
> +}
> +
> +static void mtk_pcie_power_down(struct mtk_pcie_port *port)
> +{
> +	phy_power_off(port->phy);
> +	phy_exit(port->phy);
> +
> +	clk_bulk_disable_unprepare(port->num_clks, port->clks);

In the power-up sequence clocks are enabled last, but here they are not
disabled before the PHY is powered off. Is this on purpose?

> +
> +	pm_runtime_put_sync(port->dev);
> +	pm_runtime_disable(port->dev);

In the power-up error path, PHY and controller resets are asserted
again, but here they are kept deasserted. Should they be asserted here
as well?

regards
Philipp
