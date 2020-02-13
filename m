Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5099315B801
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 04:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgBMD6u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 22:58:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39741 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbgBMD6t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 22:58:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so1783915plp.6;
        Wed, 12 Feb 2020 19:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nbjlYlfhBY+UHixlStQoXg09UzzSEedx4Ji7HfMzHdM=;
        b=r83nfN4fsprCVE1aSKVNuRsBosnAaXuj8OAOXQnK9NZcEZoax/+3O9pDtiT0ckjr/3
         Jr2Zd0Wu9B2NqDMPiHJLDUURZ5eIcgHbzRmHFiEc+SYOGuIhC2luO5w0lAXxAWpU960L
         ATr43Qc3e5BSwGROmyt+nUO316SSXw+8xQQYh9ETGmL73E6erZhF7+WuhOiYU6Q/zKNZ
         vJmapTmBUmrzpmIbKXRCbvg6utUsXIwLcgu+j/HioTKNBg7aW+DwManzcsP0kXRZSWzT
         oOwDchiZLcRLuvd4XwBnS+Mu2u7p1CLQJ3URYG+Y6Nw53uvnKClepBDg5kjq9yPfztWv
         GYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nbjlYlfhBY+UHixlStQoXg09UzzSEedx4Ji7HfMzHdM=;
        b=HME02aybe9G6/iGHPzsNocIP7kecChhTdpbvBhAB0dAMzGKmUJnR3HfsGJKWx1WILs
         7x7mXm0yS/020710pqUyTdKVgvAJokcWBRNx2KvuGRS2VeUBmf7JDxeoaKTdMTztzaru
         KDC29zlXtotraxdrdmAJZlczb0+DfgvJATTnrkKQ9bWlpcV+qTJFoRrYamKyV/dXEfEW
         jqlDRfVf2+KHZ8Xg7O/A/DdCmHC+yN02xpGnMpRk3GhP/02n49CpdaqW1S516a1fZPUS
         WnAX1MlzAUVKWcnP22auLBN31pa910U0dpWEcXinuKOg2Qz60xjWeC0azOvuxN/rGLTH
         JeVg==
X-Gm-Message-State: APjAAAUpWj2lMkQJE99JHPW1O6RaRKIXfotg4awbVOBVp9DU7//+//vN
        Spy7VzOQX2a18q8fxRiDq7QjQhKe
X-Google-Smtp-Source: APXvYqwqtvCWTmCYtQaF20qYQgf9s9NKbxvuHishOIDtG3QhneQz0PtJAh8BwsO/OvTmuRHBWtVUjQ==
X-Received: by 2002:a17:902:b696:: with SMTP id c22mr25276386pls.97.1581566328537;
        Wed, 12 Feb 2020 19:58:48 -0800 (PST)
Received: from [10.230.28.123] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a35sm638912pgl.20.2020.02.12.19.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 19:58:48 -0800 (PST)
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add regulator support
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <james.quinlan@Broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
References: <20200213025930.27943-1-jaedon.shin@gmail.com>
 <20200213025930.27943-3-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Message-ID: <aaa85a4d-8b36-893e-3e7a-dc27b4d6bae5@gmail.com>
Date:   Wed, 12 Feb 2020 19:58:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200213025930.27943-3-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/12/2020 6:59 PM, Jaedon Shin wrote:
> ARM-based Broadcom STB SoCs have GPIO-based voltage regulator for PCIe
> turning off/on power supplies.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/gpio/gpio-brcmstb.c           | 13 ++++-
>  drivers/pci/controller/pcie-brcmstb.c | 76 +++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
> index 05e3f99ae59c..0cee5fcd2782 100644
> --- a/drivers/gpio/gpio-brcmstb.c
> +++ b/drivers/gpio/gpio-brcmstb.c
> @@ -777,7 +777,18 @@ static struct platform_driver brcmstb_gpio_driver = {
>  	.remove = brcmstb_gpio_remove,
>  	.shutdown = brcmstb_gpio_shutdown,
>  };
> -module_platform_driver(brcmstb_gpio_driver);
> +
> +static int __init brcmstb_gpio_init(void)
> +{
> +	return platform_driver_register(&brcmstb_gpio_driver);
> +}
> +subsys_initcall(brcmstb_gpio_init);
> +
> +static void __exit brcmstb_gpio_exit(void)
> +{
> +	platform_driver_unregister(&brcmstb_gpio_driver);
> +}
> +module_exit(brcmstb_gpio_exit);

We do this in the downstream tree, but there is no reason, we should
just deal with EPROBE_DEFER being returned from the regulator subsystem
until the GPIO provide is available.

[snip]

> +static void brcm_pcie_regulator_init(struct brcm_pcie *pcie)
> +{
> +	struct device_node *np = pcie->dev->of_node;
> +	struct device *dev = pcie->dev;
> +	const char *name;
> +	struct regulator *reg;
> +	int i;
> +
> +	pcie->num_regs = of_property_count_strings(np, "supply-names");
> +	if (pcie->num_regs <= 0) {
> +		pcie->num_regs = 0;
> +		return;
> +	}
> +
> +	pcie->regs = devm_kcalloc(dev, pcie->num_regs, sizeof(pcie->regs[0]),
> +				  GFP_KERNEL);
> +	if (!pcie->regs) {
> +		pcie->num_regs = 0;
> +		return;
> +	}
> +
> +	for (i = 0; i < pcie->num_regs; i++) {
> +		if (of_property_read_string_index(np, "supply-names", i, &name))
> +			continue;
> +
> +		reg = devm_regulator_get_optional(dev, name);
> +		if (IS_ERR(reg))
> +			continue;

You need to handle EPROBE_DEFER here and propagate that back to the
caller to defer the entire driver from probing until the regulator
providers are available.

> +
> +		pcie->regs[i] = reg;
> +	}
> +}
> +#else
> +static inline void brcm_pcie_regulator_enable(struct brcm_pcie *pcie) { }
> +static inline void brcm_pcie_regulator_disable(struct brcm_pcie *pcie) { }
> +static inline void brcm_pcie_regulator_init(struct brcm_pcie *pcie) { }
> +#endif
> +
>  /*
>   * This is to convert the size of the inbound "BAR" region to the
>   * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
> @@ -898,6 +970,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  {
>  	brcm_msi_remove(pcie);
>  	brcm_pcie_turn_off(pcie);
> +	brcm_pcie_regulator_disable(pcie);
>  	clk_disable_unprepare(pcie->clk);
>  	clk_put(pcie->clk);
>  }
> @@ -955,6 +1028,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	brcm_pcie_regulator_init(pcie);
> +	brcm_pcie_regulator_enable(pcie);

And deal with errors here.

> +
>  	ret = brcm_pcie_setup(pcie);
>  	if (ret)
>  		goto fail;
> 

-- 
Florian
