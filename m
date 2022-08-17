Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93943596BD2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 11:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiHQJLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 05:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbiHQJLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 05:11:08 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A354641
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 02:11:07 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id OF4qoVq4HsfCIOF4qonF44; Wed, 17 Aug 2022 11:11:05 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 17 Aug 2022 11:11:05 +0200
X-ME-IP: 90.11.190.129
Message-ID: <fce4a8ca-5429-22ea-b601-bae4299ac8c0@wanadoo.fr>
Date:   Wed, 17 Aug 2022 11:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next 2/2] PCI: switch to use dev_err_probe()
Content-Language: fr
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com
References: <20220817084444.2876059-1-yangyingliang@huawei.com>
 <20220817084444.2876059-2-yangyingliang@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220817084444.2876059-2-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 17/08/2022 à 10:44, Yang Yingliang a écrit :
> Use dev_err_probe() to simplify code and print error code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/pci/probe.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0e947f24153e..f2430da8a30b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3054,10 +3054,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>   	int ret;
>   
>   	ret = pci_scan_root_bus_bridge(bridge);
> -	if (ret < 0) {
> -		dev_err(bridge->dev.parent, "Scanning root bridge failed");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(bridge->dev.parent, ret,
> +				     "Scanning root bridge failed");
>   
>   	bus = bridge->bus;
>   

Nit: you could also add a \n at the end of the message.

Just my 2c,

CJ
