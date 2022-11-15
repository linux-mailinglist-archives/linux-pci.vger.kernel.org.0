Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E5662A0E8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiKOSBY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 13:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKOSAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 13:00:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6530E2B0;
        Tue, 15 Nov 2022 10:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B60661977;
        Tue, 15 Nov 2022 18:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9A3C433C1;
        Tue, 15 Nov 2022 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668535217;
        bh=QXsDGTguq09mN4sSHHgpPG8/brgbzE21EVYdVSJ3uzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxKlIIGq9uCKDSt9xkJtoEQs1wHMD2r/lfp4TJ2f74OQUWrwNXgBsMGeJzJT7nHlH
         Ij9cJd4ztD2DdoT+VJxwc76ja6wpK+PE6Fa0JA51vmm1WvZla+kF1fg+pvOOTq2k41
         VNN721p6VXYAugsrZeh030J5NnIT3oxdtSSIgX6dK3ZU6E3MJID6GNCZtFDqV7nr01
         k9Yqvy4YM3OqzkreHA6ErDDhI0RfIO2pLdDHayHdTBiqe4K/SJ1k2NBKEn236Nem/O
         ON2w9Qsqxc8/j1yGkpE8qoI9Gx0RMMuuwJ1ggcJNPnU+K7NFrq1uyL4lHrnGsAY9ZF
         1tYXMXwCOh5Ag==
Received: by pali.im (Postfix)
        id 4DFCE805; Tue, 15 Nov 2022 19:00:14 +0100 (CET)
Date:   Tue, 15 Nov 2022 19:00:14 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] PCI: aardvark: switch to using
 devm_gpiod_get_optional()
Message-ID: <20221115180014.ktutpo37vxwde4cy@pali>
References: <Y3KMEZFv6dpxA+Gv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3KMEZFv6dpxA+Gv@google.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 14 November 2022 10:42:25 Dmitry Torokhov wrote:
> Switch the driver to the generic version of gpiod API (and away from
> OF-specific variant), so that we can stop exporting
> devm_gpiod_get_from_of_node().
> 
> Acked-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2:
>  - collected reviewed-by/acked-by tags
>  - updated commit description to remove incorrect assumption of why
>    devm_gpiod_get_from_of_node() was used in the first place
> 
> This is the last user of devm_gpiod_get_from_of_node() in the mainline
> (next), it would be great to have it in so that we can remove the API in
> the next release cycle.
> 
> Thanks!

Just a note that more aardvark patches are waiting on the list.

> 
>  drivers/pci/controller/pci-aardvark.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index ba36bbc5897d..5ecfac23c9fc 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1859,20 +1859,19 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
> -						       "reset-gpios", 0,
> -						       GPIOD_OUT_LOW,
> -						       "pcie1-reset");
> +	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>  	ret = PTR_ERR_OR_ZERO(pcie->reset_gpio);
>  	if (ret) {
> -		if (ret == -ENOENT) {
> -			pcie->reset_gpio = NULL;
> -		} else {
> -			if (ret != -EPROBE_DEFER)
> -				dev_err(dev, "Failed to get reset-gpio: %i\n",
> -					ret);
> -			return ret;
> -		}
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get reset-gpio: %i\n",
> +				ret);
> +		return ret;
> +	}
> +
> +	ret = gpiod_set_consumer_name(pcie->reset_gpio, "pcie1-reset");
> +	if (ret) {
> +		dev_err(dev, "Failed to set reset gpio name: %d\n", ret);
> +		return ret;
>  	}
>  
>  	ret = of_pci_get_max_link_speed(dev->of_node);
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
> 
> -- 
> Dmitry
