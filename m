Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6661A4B2CAB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 19:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiBKSS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 13:18:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiBKSS3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 13:18:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EB013A
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 10:18:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5601561E6F
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 18:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67397C340E9;
        Fri, 11 Feb 2022 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644603506;
        bh=7h6+U0QyJ2iRXwnHJiK2E1wPEmMwdOFIcD6R74xoEQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C2BZXgBPdObkIIflLjyGbFfeVCv3dIfm9cHpaT7khQcCsN6xrlGOXWaQw0lErTB+4
         2+XcnlVV2brFtOy24bqr0kZf6Fs4fCLN1DGvhxPYKU+ZkbNlHWm7EN0I1qZunc7giR
         8JtVBnN0lppNe5y3lfjPOg29LER5dQPZBWgbqrkcRGXPoo/E1M82jKSMLgCQH9d3Yx
         dmB/o8qqrQfViRg4cbGtvbELSutY0OS3ny3HiPPlZmQXt8izyfQ8VaUmnsDZpjDgb7
         JYVuyqneEBOt54dQ+EshjNj9J2OWSkk6chyfAcC53QPPEcSwssuZaxFNQ7tZZ9mJYf
         zO066UhB6iePg==
Date:   Fri, 11 Feb 2022 12:18:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] PCI: imx6: Fix PERST# start-up sequence
Message-ID: <20220211181824.GA718271@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211152550.286821-1-francesco.dolcini@toradex.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 04:25:50PM +0100, Francesco Dolcini wrote:
> According to the PCI-E standard the PERST# signal (reset-gpio in

s/PCI-E/PCIe/ everywhere, to match conventional usage.

> fsl,imx6* compatible dts) should be kept asserted for at least 100 usec
> before the PCI-E refclock is stable, should be kept asserted for at
> least 100ms after the power rails are stable and the host should wait
> at least 100 msec after it is de-asserted before accessing the
> configuration space of any attached device.
> 
> From PCI Express Card Electromechanical Specification

Please include spec revision and section number.  I think this would
probably be "PCIe CEM r5.0, sec 2.9.2".

>   T-PVPERL: Power stable to PERST# inactive - 100 msec
>   T-PERST-CLK: REFCLK stable before PERST# inactive 100 usec.
> 
> From PCI Express Base Specification:

Similarly, "PCIe r6.0, sec xxx".  I don't see the text below in r6.0,
so I think it must have evolved a bit.  Probably something in sec
6.6.1.

>   To allow components to perform internal initialization, system
>   software must wait for at least 100 ms from the end of a Conventional
>   Reset of one or more devices before it is permitted to issue
>   Configuration Requests to those devices
> 
> Failure to do so could prevent PCI-E devices to be working correctly,
> and this was experienced with real devices.
> 
> Move reset assert to imx6_pcie_assert_core_reset(), this way we ensure
> that PERST# is asserted before enabling any clock, move de-assert to the
> end of imx6_pcie_deassert_core_reset() after the clock is enabled and
> deemed stable and add a new delay of 100 msec just afterward.
> 
> Fixes: bb38919ec56e ("PCI: imx6: Add support for i.MX6 PCIe controller")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7b200b66114a..392803544364 100644
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
> @@ -544,15 +549,6 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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
> @@ -599,6 +595,19 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		break;
>  	}
>  
> +	/* Some boards don't have PCIe reset GPIO. */
> +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +		msleep(100);
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +					!imx6_pcie->gpio_active_high);
> +		/*
> +		 * PCI Express Base Specification:

Mention spec rev & section here, too.  Someday we'll consolidate these
with #defines and identifying all the delays related to sec 6.6.1 (or
whatever it is) will be important.

> +		 *   A delay of at least 100ms is required after PERST# is
> +		 *   de-asserted before issuing any Configuration Requests
> +		 */
> +		msleep(100);
> +	}
> +
>  	return;
>  
>  err_ref_clk:
> -- 
> 2.25.1
> 
