Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59ED32D222
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 13:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbhCDL7p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 4 Mar 2021 06:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbhCDL7p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Mar 2021 06:59:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B6C061756
        for <linux-pci@vger.kernel.org>; Thu,  4 Mar 2021 03:59:04 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHmcz-0002LK-IC; Thu, 04 Mar 2021 12:58:49 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHmct-0005HU-9M; Thu, 04 Mar 2021 12:58:43 +0100
Message-ID: <81c45bf40b397b57343f159baae896528fa32d89.camel@pengutronix.de>
Subject: Re: [RFC PATCH 2/6] clk: sifive: Use reset-simple in prci driver
 for PCIe driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Greentime Hu <greentime.hu@sifive.com>, paul.walmsley@sifive.com,
        hes@sifive.com, erik.danie@sifive.com, zong.li@sifive.com,
        bhelgaas@google.com, robh+dt@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Thu, 04 Mar 2021 12:58:43 +0100
In-Reply-To: <e2bd7db9db3c196b9b0399f0655a56939a0f3d62.1614681831.git.greentime.hu@sifive.com>
References: <cover.1614681831.git.greentime.hu@sifive.com>
         <e2bd7db9db3c196b9b0399f0655a56939a0f3d62.1614681831.git.greentime.hu@sifive.com>
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

On Tue, 2021-03-02 at 18:59 +0800, Greentime Hu wrote:
> We use reset-simple in this patch so that pcie driver can use
> devm_reset_control_get() to get this reset data structure and use
> reset_control_deassert() to deassert pcie_power_up_rst_n.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  drivers/clk/sifive/Kconfig       |  2 ++
>  drivers/clk/sifive/sifive-prci.c | 14 ++++++++++++++
>  drivers/clk/sifive/sifive-prci.h |  4 ++++
>  drivers/reset/Kconfig            |  3 ++-
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
> index 1c14eb20c066..9132c3c4aa86 100644
> --- a/drivers/clk/sifive/Kconfig
> +++ b/drivers/clk/sifive/Kconfig
> @@ -10,6 +10,8 @@ if CLK_SIFIVE
>  
>  config CLK_SIFIVE_PRCI
>  	bool "PRCI driver for SiFive SoCs"
> +	select RESET_CONTROLLER
> +	select RESET_SIMPLE
>  	select CLK_ANALOGBITS_WRPLL_CLN28HPC
>  	help
>  	  Supports the Power Reset Clock interface (PRCI) IP block found in
> diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
> index baf7313dac92..925affc6de55 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -583,7 +583,21 @@ static int sifive_prci_probe(struct platform_device *pdev)
>  	if (IS_ERR(pd->va))
>  		return PTR_ERR(pd->va);
>  
> +	pd->reset.rcdev.owner = THIS_MODULE;
> +	pd->reset.rcdev.nr_resets = PRCI_RST_NR;
> +	pd->reset.rcdev.ops = &reset_simple_ops;
> +	pd->reset.rcdev.of_node = pdev->dev.of_node;
> +	pd->reset.active_low = true;
> +	pd->reset.membase = pd->va + PRCI_DEVICESRESETREG_OFFSET;
> +	spin_lock_init(&pd->reset.lock);
> +
> +	r = devm_reset_controller_register(&pdev->dev, &pd->reset.rcdev);
> +	if (r) {
> +		dev_err(dev, "could not register reset controller: %d\n", r);
> +		return r;
> +	}
>  	r = __prci_register_clocks(dev, pd, desc);
> +

Accidental whitespace?

Otherwise,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
