Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5C665924D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 22:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiL2Vu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 16:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiL2Vu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 16:50:59 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Dec 2022 13:50:57 PST
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE3BB15708
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 13:50:57 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id B0gKp7mDjBicGB0gKpHr5U; Thu, 29 Dec 2022 22:43:25 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 29 Dec 2022 22:43:25 +0100
X-ME-IP: 86.243.100.34
Message-ID: <c0deb523-0458-5422-bed5-ee104ca7c479@wanadoo.fr>
Date:   Thu, 29 Dec 2022 22:43:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI: amlogic: The check for devm_add_action_or_reset's
 return value added
Content-Language: fr, en-US
To:     Aleksandr Burakov <a.burakov@rosalinux.ru>
Cc:     linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20221220092137.6527-1-a.burakov@rosalinux.ru>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221220092137.6527-1-a.burakov@rosalinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 20/12/2022 à 10:21, Aleksandr Burakov a écrit :
> The return value of the function devm_add_action_or_reset() was not
> checked hence an error code would not be returned.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> ---
>   drivers/pci/controller/dwc/pci-meson.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index c1527693bed9..3d82f0b65480 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -187,9 +187,13 @@ static inline struct clk *meson_pcie_probe_clock(struct device *dev,
>   		return ERR_PTR(ret);
>   	}
>   
> -	devm_add_action_or_reset(dev,
> +	ret = devm_add_action_or_reset(dev,
>   				 (void (*) (void *))clk_disable_unprepare,

Hi,

using devm_clk_get_enabled() a few lines above would be IMHO much more 
elegant than these casts.

This also saves a few LoC and avoid some other warnings/issues. (see [1])

Such an approach has already been used in [2].

Just my 2c,

CJ

[1]: https://lore.kernel.org/all/20221118233101.never.215-kees@kernel.org/
[2]: https://lore.kernel.org/all/20221202184525.gonna.423-kees@kernel.org/

>   				 clk);
> +	if (ret) {
> +		dev_err(dev, "couldn't reset clk\n");
> +		return ERR_PTR(ret);
> +	}
>   
>   	return clk;
>   }

