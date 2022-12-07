Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1070645CAE
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 15:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiLGOd4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 09:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLGOdz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 09:33:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9424874A;
        Wed,  7 Dec 2022 06:33:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D00C61A21;
        Wed,  7 Dec 2022 14:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F9DC433C1;
        Wed,  7 Dec 2022 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670423633;
        bh=c+KvtVD0WLo5gwEphtibdZzJjkwLKgNGQrH2V1E1aXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OfTWS5hUSadr7o7xtdJ0R+zDfShXDpQX3tRV0YLBAE7y1YdiWf/4TVnd6XbwyfW7D
         9pshZ5piIcEEBKGAYOwT7RUDqxscXns3qktQUeysF1bbMy9pqGvtqXK7NkBQj+jEGh
         /En73LUpdGivrTIqPQyFldJ4/nB48m+P9QyqGDgqo93wMn++Ajsb4tc10erl+gKDZo
         Ct+IenQvCaxiOaGQ6dHb8iaA9ISMa6FElcpXfhZ3cXxIpWqd5VMNravgNPjvu5xcNQ
         HZ3INZyw87gUmXf31XYLPufE79jmKXRfW7vhhprjOPwcrq1DBnbKH2i4JhAr/q3LD7
         VCg56qtXC+jmw==
Date:   Wed, 7 Dec 2022 08:33:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] PCI: aardvark: switch to using
 devm_gpiod_get_optional()
Message-ID: <20221207143351.GA1439513@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3KMEZFv6dpxA+Gv@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 10:42:25AM -0800, Dmitry Torokhov wrote:
> Switch the driver to the generic version of gpiod API (and away from
> OF-specific variant), so that we can stop exporting
> devm_gpiod_get_from_of_node().
> 
> Acked-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is unrelated to other pending aardvark changes and will help
unblock the API removal, so I applied this to pci/ctrl/aardvark for
v6.2, thanks!

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
> 
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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
