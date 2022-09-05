Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F75ACCBC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 09:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbiIEHW4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 03:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiIEHW2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 03:22:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084B247B84;
        Mon,  5 Sep 2022 00:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85BE561133;
        Mon,  5 Sep 2022 07:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A82C433C1;
        Mon,  5 Sep 2022 07:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662362344;
        bh=19nxD2OgHF2QVoth2PFq3CxZH5zVFIqpZyEzuI/YHbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A5IVl+JOjFxfodqmnjA5/iplAcU9jdP05wWuvEqZCUxiPZuyoNor7xgxpbYXB6NVK
         7DcajL5+Q4Jwv4XR1AvPOAXkUgrwSH/Ov7HM3KXUEl/b4BKQG5MdZ5GTO8igdjjVEV
         HR2BrWQ7cSeUZcnhf0SNpLKhbJC0AEjYvFObLKGjaI4ohnPRXMXtOd+2eSUbXERAnn
         Wt+aJ6+72CZQwxjMiKfr0QzSL2qh96wXclEVsX5h4ma+908Zyb6OVtZsD0AEGTokvq
         Z4gsx2A9lpZW+2kJWomwEZtX41BXuoB9ZUs+w+vRDjrWEAYqK9IYV1wftZ4A4k/PEn
         RnEC8ylDHE6IA==
Received: by pali.im (Postfix)
        id 32DB27D7; Mon,  5 Sep 2022 09:19:02 +0200 (CEST)
Date:   Mon, 5 Sep 2022 09:19:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 01/11] PCI: tegra: switch to using
 devm_fwnode_gpiod_get
Message-ID: <20220905071902.fv4uozrsttk3mosu@pali>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-1-b29adfb27a6c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-1-b29adfb27a6c@gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 04 September 2022 23:30:53 Dmitry Torokhov wrote:
> I would like to limit (or maybe even remove) use of
> [devm_]gpiod_get_from_of_node in drivers so that gpiolib can be cleaned
> a bit, so let's switch to the generic device property API. It may even
> help with handling secondary fwnodes when gpiolib is taught to handle
> gpios described by swnodes.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 8e323e93be91..929f9363e94b 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2202,10 +2202,11 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		 * and in this case fall back to using AFI per port register
>  		 * to toggle PERST# SFIO line.
>  		 */
> -		rp->reset_gpio = devm_gpiod_get_from_of_node(dev, port,
> -							     "reset-gpios", 0,
> -							     GPIOD_OUT_LOW,
> -							     label);
> +		rp->reset_gpio = devm_fwnode_gpiod_get(dev,
> +						       of_fwnode_handle(port),
> +						       "reset",
> +						       GPIOD_OUT_LOW,
> +						       label);

Why in pci-aardvark.c for PERST# reset-gpio you have used
devm_gpiod_get_optional() and here in pci-tegra.c you have used
devm_fwnode_gpiod_get()? I think that PERST# logic is same in both
drivers.

>  		if (IS_ERR(rp->reset_gpio)) {
>  			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
>  				rp->reset_gpio = NULL;
> 
> -- 
> b4 0.10.0-dev-fc921
