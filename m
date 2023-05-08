Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A526FA060
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 08:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjEHG7s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 02:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjEHG7g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 02:59:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9B412497
        for <linux-pci@vger.kernel.org>; Sun,  7 May 2023 23:59:23 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id vuq3pLWu0unMHvuq3pBwg2; Mon, 08 May 2023 08:59:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683529161;
        bh=Ryhq4eaEWmWDYOdIXBNmYtLvCNROHD7rXvSdIVxOm0c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=h86uiNgobj8OHnUlZm8V2grAj3q3ci8iC0qVk46uo5eN377DtEykldpJIuRyDuokr
         yhrzdNzi2PUnQNxexCNSZFyWLPjMBmZ4Cgn7f48hkrWcnm0CslcYwBOubM2H/jwmMo
         b8Qait6jaUPATs5S5DicF28oXnVoT3O4mQb1o5YB78gBogK34hzFgYUY5SWXZHEOeq
         TfkcLwDzYEugRZokteWYZGVkdkv3hNroXMqdwBnAQR/Txg/TgU+cVsKmAKeUoMv+lx
         BYvGWsp7GzM3KBwCsKdHXpwwyk9AfYsMDZLV3r/e/CqFsjL4cCyGZiO+U75EMCr/OS
         nIHyjGooJiyTA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 08 May 2023 08:59:21 +0200
X-ME-IP: 86.243.2.178
Message-ID: <430d0357-d10e-db3d-bc82-722b022b519b@wanadoo.fr>
Date:   Mon, 8 May 2023 08:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] pci: controller: pci-ftpci100: Release the clock
 resources
Content-Language: fr, en-US
To:     Junyan Ye <yejunyan@hust.edu.cn>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230508043641.23807-1-yejunyan@hust.edu.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230508043641.23807-1-yejunyan@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 08/05/2023 à 06:36, Junyan Ye a écrit :
> Smatch reported:
> 1. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe() warn:
> 'clk' from clk_prepare_enable() not released on lines: 442,451,462,478,512,517.
> 2. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe() warn:
> 'p->bus_clk' from clk_prepare_enable() not released on lines: 451,462,478,512,517.
> 
> The clock resource is obtained by devm_clk_get(), and then
> clk_prepare_enable() makes the clock resource ready for use. After that,
> clk_disable_unprepare() should be called to release the clock resource
> when it is no longer needed. However, while doing some error handling
> in faraday_pci_probe(), clk_disable_unprepare() is not called to release
> clk and p->bus_clk before returning. These return lines are exactly 442,
> 451, 462, 478, 512, 517.
> 
> Fix this warning by replacing devm_clk_get() with devm_clk_get_enabled(),
> which is equivalent to devm_clk_get() + clk_prepare_enable(). And with
> devm_clk_get_enabled(), the clock will automatically be disabled,
> unprepared and freed when the device is unbound from the bus.
> 
> Fixes: b3c433efb8a3 ("PCI: faraday: Fix wrong pointer passed to PTR_ERR()")
> Fixes: 2eeb02b28579 ("PCI: faraday: Add clock handling")
> Fixes: 783a862563f7 ("PCI: faraday: Use pci_parse_request_of_pci_ranges()")
> Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
> Fixes: f1e8bd21e39e ("PCI: faraday: Convert IRQ masking to raw PCI config accessors")
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Signed-off-by: Junyan Ye <yejunyan@hust.edu.cn>
> ---
> v2 -> v3: Rebase to v6.4-rc1 and modify commit message.
> v1 -> v2: Switch from clk_disable_unprepare() to devm_clk_get_enabled() to release the clock.
> This issue is found by static analyzer.
> 
>   drivers/pci/controller/pci-ftpci100.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
> index ecd3009df586..6e7981d2ed5e 100644
> --- a/drivers/pci/controller/pci-ftpci100.c
> +++ b/drivers/pci/controller/pci-ftpci100.c
> @@ -429,22 +429,12 @@ static int faraday_pci_probe(struct platform_device *pdev)
>   	p->dev = dev;
>   
>   	/* Retrieve and enable optional clocks */

Hi,

completely unrelated to your patch, but this comments state "optional". 
The code below seems to make both clocks mandatory.

Moreover, a few lines later, we have:
     if (!IS_ERR(p->bus_clk)) {
which seems to say that bus_clk is optional.

This was introduced by 2eeb02b28579.

Just a guess, but either the comment should be updated, or the code 
modified.

Just my 2c,

CJ


> -	clk = devm_clk_get(dev, "PCLK");
> +	clk = devm_clk_get_enabled(dev, "PCLK");
>   	if (IS_ERR(clk))
>   		return PTR_ERR(clk);
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "could not prepare PCLK\n");
> -		return ret;
> -	}
> -	p->bus_clk = devm_clk_get(dev, "PCICLK");
> +	p->bus_clk = devm_clk_get_enabled(dev, "PCICLK");
>   	if (IS_ERR(p->bus_clk))
>   		return PTR_ERR(p->bus_clk);
> -	ret = clk_prepare_enable(p->bus_clk);
> -	if (ret) {
> -		dev_err(dev, "could not prepare PCICLK\n");
> -		return ret;
> -	}
>   
>   	p->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(p->base))

