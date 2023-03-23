Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1B6C6185
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 09:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCWIVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 04:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCWIV1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 04:21:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02465302B4;
        Thu, 23 Mar 2023 01:21:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 351C56602040;
        Thu, 23 Mar 2023 08:21:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679559684;
        bh=WkfVZaU1hGdCt/oKmuUQTlY29LYg/sO4ppTQfj1dwh0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KJiie0flpILVaELOJWrnaav8rz30ABohddv/omm6IPerUW4oWTlnIAx6u5wQKLIGR
         F6ZXCudHAKIJEft1CZZiPHlurJHPs47Ut5Hip4+W5INECYTbn4MrN5pUNHfdUvMC8h
         Mb7omBV14I8ICAiWhRJ+iszkO9yX36Q3wyOQg6oTD8rzN3cENODjdJFbyY/TYQN65V
         3k2Kzq2BwJu5185svNkw6pczDqaANoAs8UQuWDixCTcUBNq52he6foe5Wkd++3yk35
         w84koAGwMPnvVs9MExqphycz1iKr0Sm+z8TRFXSWXWqVmNNn2MY1aR1G9fxc2wie6B
         pbQkx+8g597Fg==
Message-ID: <aa682e7d-3a0c-b820-9978-3f9eb00fbfda@collabora.com>
Date:   Thu, 23 Mar 2023 09:21:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] PCI: mt7621: Use dev_err_probe()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, sergio.paracuellos@gmail.com
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <202303231145121987818@zte.com.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <202303231145121987818@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 23/03/23 04:45, ye.xingchen@zte.com.cn ha scritto:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/pci/controller/pcie-mt7621.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index 63a5f4463a9f..964de0e8c6a0 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -220,10 +220,9 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
>   	}
> 
>   	port->pcie_rst = of_reset_control_get_exclusive(node, NULL);
> -	if (PTR_ERR(port->pcie_rst) == -EPROBE_DEFER) {
> -		dev_err(dev, "failed to get pcie%d reset control\n", slot);
> -		return PTR_ERR(port->pcie_rst);
> -	}
> +
> +	return dev_err_probe(dev, PTR_ERR(port->pcie_rst),
> +			     "failed to get pcie%d reset control\n", slot);

That's breaking this function. You're unconditionally returning.

I think that this is fine as it is, but if you really want to use dev_err_probe()
here, this could be...

ret = dev_err_probe(dev, PTR_ERR(port->pcie_rst), "failed ...." ...);
if (ret)
	return ret;

Regards,
Angelo

> 
>   	snprintf(name, sizeof(name), "pcie-phy%d", slot);
>   	port->phy = devm_of_phy_get(dev, node, name);


