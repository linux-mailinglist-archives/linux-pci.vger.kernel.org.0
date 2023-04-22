Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642066EB9F5
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 17:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjDVPRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDVPRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 11:17:07 -0400
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A8A9E
        for <linux-pci@vger.kernel.org>; Sat, 22 Apr 2023 08:17:05 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id qEyvpze6qLbpDqEyvpaKkO; Sat, 22 Apr 2023 17:17:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682176622;
        bh=3H0scDFKyehOgT0V6d/W2chtkfq7ZCGqxH+0r3owNTc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=d+I+RI9QA70aL4CBNXknbwd9lmwZNk2qAl1wJ+DKPc5xtafv3H98XLQ4TrD9x/krA
         Vm7u3lgqthfsF4X62ViOVJ/ejGOpdjrHBm1BGd3SIJ7l7wDiySHhLTobjPQzjI3m5t
         iWvYIKNuDs29kcPMVbY+f+IDXCiJoCVFVWBeSCO0VQeYM7dhPkm2c/lWfGQGr0eTK5
         oR6CaRsf0IcSNEWhBAnhM5v9yw6mJOhcyDNZWCADkYaN+Z04l4wJJINDj650XwVwF5
         9YGzyNNAIpfKlR8M9YNNn0GAZxxAZq4N9taRAgzmThwT346kxZrwD57DbsPCNStqFC
         Wf0KIGPhMJXQg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Apr 2023 17:17:02 +0200
X-ME-IP: 86.243.2.178
Message-ID: <5fe7ba30-5a87-74cc-d817-9384fa340e6e@wanadoo.fr>
Date:   Sat, 22 Apr 2023 17:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pci: controller: pci-ftpci100: Release the clock
 resources
Content-Language: fr
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
References: <20230422074254.14473-1-yejunyan@hust.edu.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230422074254.14473-1-yejunyan@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 22/04/2023 à 09:42, Junyan Ye a écrit :
> Smatch reported:
> 1. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe()
> warn: 'clk' from clk_prepare_enable() not released on lines:
> 442,451,462,478,512,517.
> 2. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe()
> warn: 'p->bus_clk' from clk_prepare_enable() not released on lines:
> 451,462,478,512,517.
> 
> The clock resource is obtained by the devm_clk_get function. The
> clk_prepare_enable function then makes the clock resource ready for use,
> notifying the system that the clock resource should be run. After that,
> the clock resource should be released when it is no longer needed. This
> includes notifying the system that the clock resource is no longer needed
> and revoking the prepared clock. The corresponding function is
> clk_disable_unprepare. However, while doing some error handling in the
> faraday_pci_probe function, the clk_disable_unprepare function is not
> called to release the clk and p->bus_clk resources.
> 
> Fix the warning by adding the clk_disable_unprepare function before
> returning the error message.
> 
> Fixes: b3c433efb8a3 ("PCI: faraday: Fix wrong pointer passed to PTR_ERR()")
> Fixes: 2eeb02b28579 ("PCI: faraday: Add clock handling")
> Fixes: 783a862563f7 ("PCI: faraday: Use pci_parse_request_of_pci_ranges()")
> Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
> Fixes: f1e8bd21e39e ("PCI: faraday: Convert IRQ masking to raw PCI config accessors")
> Signed-off-by: Junyan Ye <yejunyan@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> This issue is found by static analyzer.
> 
>   drivers/pci/controller/pci-ftpci100.c | 31 +++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
> index ecd3009df586..ca3ba377b3dd 100644
> --- a/drivers/pci/controller/pci-ftpci100.c
> +++ b/drivers/pci/controller/pci-ftpci100.c
> @@ -438,17 +438,21 @@ static int faraday_pci_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   	p->bus_clk = devm_clk_get(dev, "PCICLK");
> -	if (IS_ERR(p->bus_clk))
> -		return PTR_ERR(p->bus_clk);

Hi,

switching to devm_clk_get_enabled() would
   - fix the leak you reported
   - fix the same leak hapening in the (non-existent) remove() function
   - remove some lines of code, which is always great.

CJ


> +	if (IS_ERR(p->bus_clk)) {
> +		ret = PTR_ERR(p->bus_clk);
> +		goto err_release_clk;
> +	}
>   	ret = clk_prepare_enable(p->bus_clk);
>   	if (ret) {
>   		dev_err(dev, "could not prepare PCICLK\n");
> -		return ret;
> +		goto err_release_clk;
>   	}
>   
>   	p->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(p->base))
> -		return PTR_ERR(p->base);
> +	if (IS_ERR(p->base)) {
> +		ret = PTR_ERR(p->base);
> +		goto err_release_p_bus_clk;
> +	}
>   
>   	win = resource_list_first_type(&host->windows, IORESOURCE_IO);
>   	if (win) {
> @@ -459,7 +463,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
>   			writel(val, p->base + FTPCI_IOSIZE);
>   		} else {
>   			dev_err(dev, "illegal IO mem size\n");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err_release_p_bus_clk;
>   		}
>   	}
>   
> @@ -475,7 +480,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
>   		ret = faraday_pci_setup_cascaded_irq(p);
>   		if (ret) {
>   			dev_err(dev, "failed to setup cascaded IRQ\n");
> -			return ret;
> +			goto err_release_p_bus_clk;
>   		}
>   	}
>   
> @@ -509,12 +514,12 @@ static int faraday_pci_probe(struct platform_device *pdev)
>   
>   	ret = faraday_pci_parse_map_dma_ranges(p);
>   	if (ret)
> -		return ret;
> +		goto err_release_p_bus_clk;
>   
>   	ret = pci_scan_root_bus_bridge(host);
>   	if (ret) {
>   		dev_err(dev, "failed to scan host: %d\n", ret);
> -		return ret;
> +		goto err_release_p_bus_clk;
>   	}
>   	p->bus = host->bus;
>   	p->bus->max_bus_speed = max_bus_speed;
> @@ -524,6 +529,14 @@ static int faraday_pci_probe(struct platform_device *pdev)
>   	pci_bus_add_devices(p->bus);
>   
>   	return 0;
> +
> +err_release_p_bus_clk:
> +	clk_disable_unprepare(p->bus_clk);
> +
> +err_release_clk:
> +	clk_disable_unprepare(clk);
> +
> +	return ret;
>   }
>   
>   /*

