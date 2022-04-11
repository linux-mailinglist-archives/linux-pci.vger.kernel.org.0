Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAFD4FC1BF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348393AbiDKQCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348371AbiDKQCv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 12:02:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761E627FDC
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 09:00:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ndwSh-00082j-JG; Mon, 11 Apr 2022 18:00:19 +0200
Message-ID: <8e4825444d3972fcce083f03500b8595013391be.camel@pengutronix.de>
Subject: Re: [PATCH v3] PCI: imx6: Fix PERST# start-up sequence
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 11 Apr 2022 18:00:15 +0200
In-Reply-To: <20220404081509.94356-1-francesco.dolcini@toradex.com>
References: <20220404081509.94356-1-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Montag, dem 04.04.2022 um 10:15 +0200 schrieb Francesco Dolcini:
> According to the PCIe standard the PERST# signal (reset-gpio in
> fsl,imx* compatible dts) should be kept asserted for at least 100 usec
> before the PCIe refclock is stable, should be kept asserted for at
> least 100 msec after the power rails are stable and the host should wait
> at least 100 msec after it is de-asserted before accessing the
> configuration space of any attached device.
> 
> From PCIe CEM r2.0, sec 2.6.2
> 
>   T-PVPERL: Power stable to PERST# inactive - 100 msec
>   T-PERST-CLK: REFCLK stable before PERST# inactive - 100 usec.
> 
> From PCIe r5.0, sec 6.6.1
> 
>   With a Downstream Port that does not support Link speeds greater than
>   5.0 GT/s, software must wait a minimum of 100 ms before sending a
>   Configuration Request to the device immediately below that Port.
> 
> Failure to do so could prevent PCIe devices to be working correctly,
> and this was experienced with real devices.
> 
> Move reset assert to imx6_pcie_assert_core_reset(), this way we ensure
> that PERST# is asserted before enabling any clock, move de-assert to the
> end of imx6_pcie_deassert_core_reset() after the clock is enabled and
> deemed stable and add a new delay of 100 msec just afterward.
> 
> Link: https://lore.kernel.org/all/20220211152550.286821-1-francesco.dolcini@toradex.com
> Fixes: bb38919ec56e ("PCI: imx6: Add support for i.MX6 PCIe controller")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> 
> ---
> v3: Add Acked-by: Richard Zhu
> v2: Add complete reference to the PCIe standards, s/PCI-E/PCIe/g
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6619e3caffe2..7a285fb0f619 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -408,6 +408,11 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  			dev_err(dev, "failed to disable vpcie regulator: %d\n",
>  				ret);
>  	}
> +
> +	/* Some boards don't have PCIe reset GPIO. */
> +	if (gpio_is_valid(imx6_pcie->reset_gpio))
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +					imx6_pcie->gpio_active_high);
>  }
>  
>  static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
> @@ -540,15 +545,6 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	/* allow the clocks to stabilize */
>  	usleep_range(200, 500);
>  
> -	/* Some boards don't have PCIe reset GPIO. */
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> -					imx6_pcie->gpio_active_high);
> -		msleep(100);
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> -					!imx6_pcie->gpio_active_high);
> -	}
> -
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
> @@ -595,6 +591,15 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		break;
>  	}
>  
> +	/* Some boards don't have PCIe reset GPIO. */
> +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +		msleep(100);
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +					!imx6_pcie->gpio_active_high);
> +		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> +		msleep(100);
> +	}
> +
>  	return;
>  
>  err_ref_clk:


