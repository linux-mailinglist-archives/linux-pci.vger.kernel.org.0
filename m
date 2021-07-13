Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5523C6FC4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhGMLfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 07:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbhGMLfV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 07:35:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE252C0613EE;
        Tue, 13 Jul 2021 04:32:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w13so13399071wmc.3;
        Tue, 13 Jul 2021 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VxdNMTgC7RTJI/82gSAHHxnwIsTXy+NvVdODaOq4tmU=;
        b=jbrgQaNivHHWkIhys33LFvPyuiYLHxbq70sxVdJgim8ewGwhZtO9FUjdIMTe+omB3s
         DAxzDDGIqKo0OQ4mC/0OzgOEqLh4pCc3mhTZQ70dyfup1z3oHLB+wvyqZZKTjynnOwUX
         uNjy5YwuC3Qhe1z6V0DKxCgWr+pJv5vjLLaboqX9Fl1VGs2cX27ipJqIQ0UluoCiMNDm
         h9sIW5o7je9YRHhbDIcAQoh+Jid5V0oKBpKlgTph0zoL6xzX/+RkXYwPO4s6+XbUXbck
         alJLAHgki3I65JeyuI0yJ+rbagfm1mc6OZPVt5QCANqVd+IEQxTCzzsFjJdbUnbAjh+G
         K90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VxdNMTgC7RTJI/82gSAHHxnwIsTXy+NvVdODaOq4tmU=;
        b=b/FW6vu3GX/ddrgwq+B5IH8QTfVkdbTBxTEWNuije76ukAMfckn4amDvviuR7OKiQ6
         e9g5EavDsqeKB1vCuyryLJpjQG2MjTdWuALke3ENMRZ8Ev9Jw7H3uQ4k/vw5qWTK6AcX
         R1ea90A7CxXFFjbA0QPQ0z4O/eaigAnobipDik3wHuu9LF4CdyI5szBC5A9lswHqSrOb
         tO8+ZTnGORC3UIk8Tize525zWDSg/o9giZXjUkYQ5fRF68JF6Mj5/NMfxBkWaWDilMuk
         Q9e4emvHN5R6P+fBsLUsW1Xnur8Va5fvxAmQAQHSQXLObeOD1knfzsRLylTAibUjbRB9
         wt0w==
X-Gm-Message-State: AOAM5321p1t1pTJLzI3hzuCbQ5vTl5wdg6pNJHI9sJ3mac11QJwo+srn
        rWDpBuhGJC8o8n0p69zNVA87Fyt9DnWyUQ==
X-Google-Smtp-Source: ABdhPJxiGPc++BzEpZlBMmV+XlyZZlbgyEGXgaNiGp0hI/Tv7hPRxDVW7mz937Gx9gR/Y6p1sdMtyg==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr4495286wmc.86.1626175950253;
        Tue, 13 Jul 2021 04:32:30 -0700 (PDT)
Received: from ziggy.stardust ([213.195.127.100])
        by smtp.gmail.com with ESMTPSA id r16sm2056532wmg.11.2021.07.13.04.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 04:32:29 -0700 (PDT)
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com
Cc:     ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        yong.wu@mediatek.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210611060902.12418-1-chuanjia.liu@mediatek.com>
 <20210611060902.12418-3-chuanjia.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v10 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base address and parse node
Message-ID: <e462d9f0-2fa3-6106-f060-9753dc604b9f@gmail.com>
Date:   Tue, 13 Jul 2021 13:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210611060902.12418-3-chuanjia.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/06/2021 08:09, Chuanjia Liu wrote:
> For the new dts format, add a new method to get
> shared pcie-cfg base address and parse node.
> 
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>

You missed the
Reviewed-by: Rob Herring <robh@kernel.org>
given in v8. Or were there any substantial changes in this patch?

> ---
>  drivers/pci/controller/pcie-mediatek.c | 52 +++++++++++++++++++-------
>  1 file changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 62a042e75d9a..950f577a2f44 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -14,6 +14,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/msi.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> @@ -23,6 +24,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  #include <linux/reset.h>
>  
>  #include "../pci.h"
> @@ -207,6 +209,7 @@ struct mtk_pcie_port {
>   * struct mtk_pcie - PCIe host information
>   * @dev: pointer to PCIe device
>   * @base: IO mapped register base
> + * @cfg: IO mapped register map for PCIe config
>   * @free_ck: free-run reference clock
>   * @mem: non-prefetchable memory resource
>   * @ports: pointer to PCIe port information
> @@ -215,6 +218,7 @@ struct mtk_pcie_port {
>  struct mtk_pcie {
>  	struct device *dev;
>  	void __iomem *base;
> +	struct regmap *cfg;
>  	struct clk *free_ck;
>  
>  	struct list_head ports;
> @@ -650,7 +654,11 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
>  		return err;
>  	}
>  
> -	port->irq = platform_get_irq(pdev, port->slot);
> +	if (of_find_property(dev->of_node, "interrupt-names", NULL))
> +		port->irq = platform_get_irq_byname(pdev, "pcie_irq");
> +	else
> +		port->irq = platform_get_irq(pdev, port->slot);
> +

Do I understand that this is used for backwards compatibility with older DTS? I
just wonder why we don't need to mandate
interrupt-names = "pcie_irq"
in the binding description.

Regards,
Matthias
