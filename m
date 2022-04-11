Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31FC4FC2B7
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbiDKQxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 12:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiDKQxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 12:53:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E487C33E96
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 09:50:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 596481424;
        Mon, 11 Apr 2022 09:50:51 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.6.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 121613F73B;
        Mon, 11 Apr 2022 09:50:47 -0700 (PDT)
Date:   Mon, 11 Apr 2022 17:50:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Fix PERST# start-up sequence
Message-ID: <20220411165031.GA28780@lpieralisi>
References: <20220404081509.94356-1-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404081509.94356-1-francesco.dolcini@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[CC'ed Pali, who is working on PERST consolidation]

On Mon, Apr 04, 2022 at 10:15:09AM +0200, Francesco Dolcini wrote:
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
> -- 
> 2.25.1
> 
