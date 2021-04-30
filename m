Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF036F6B0
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 09:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhD3Hs3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 03:48:29 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:37597 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhD3Hr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 03:47:58 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d87 with ME
        id yvn72400521Fzsu03vn7oy; Fri, 30 Apr 2021 09:47:08 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Apr 2021 09:47:08 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH][next] PCI: mediatek-gen3: Add missing null pointer check
To:     Colin King <colin.king@canonical.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210429110040.63119-1-colin.king@canonical.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <7a512e3a-2897-ac12-ac6e-06be28735279@wanadoo.fr>
Date:   Fri, 30 Apr 2021 09:47:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429110040.63119-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 29/04/2021 à 13:00, Colin King a écrit :
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to platform_get_resource_byname can potentially return null, so
> add a null pointer check to avoid a null pointer dereference issue.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: 441903d9e8f0 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 20165e4a75b2..3c5b97716d40 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -721,6 +721,8 @@ static int mtk_pcie_parse_port(struct mtk_pcie_port *port)
>   	int ret;
>   
>   	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
> +	if (!regs)
> +		return -EINVAL;
>   	port->base = devm_ioremap_resource(dev, regs);
>   	if (IS_ERR(port->base)) {
>   		dev_err(dev, "failed to map register base\n");
> 

Nitpick:
    Using 'devm_platform_ioremap_resource_byname' is slightly less 
verbose and should please Coverity.


Also, which git repo are you using? On linux-next ([1)], your proposed 
patch is already part of "PCI: mediatek-gen3: Add MediaTek Gen3 driver 
for MT8192".

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/pci/controller/pcie-mediatek-gen3.c

CJ
