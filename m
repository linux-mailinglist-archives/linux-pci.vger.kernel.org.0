Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D12C901B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 22:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbgK3VdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 16:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgK3VdL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 16:33:11 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E32C0613CF;
        Mon, 30 Nov 2020 13:32:31 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id n137so11284287pfd.3;
        Mon, 30 Nov 2020 13:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DctpeWixZedWLIe9T1LbBcTwsFUdxzd0r0hcVxTsfr4=;
        b=fhDgfe13+5vMBwPhR0Nm2sF7yPR7/+YZoRNFjaqMM7xSuS4dxZAZkL8BAxiJPjw7Uz
         muVv/yv9OoAvarZvE2MaNg7uRQZhilkPFRchY7flcG/cBaJQonzi6nvEYXn7CqYyhmJI
         5WPQOU73USzJSQGTE7FPg9jZhFYsmHw7dJzYvXElsfHM84oiht/u0v55r0X+o3p1ZwWf
         OKUk3nR9c41R6ZOrfVOAIjvHuuwXW7SG2vvxjzKoupv9CFkc4mwEFjZEXW0FouVgdoVV
         x9TNy5PFJt1srUFgIRosrbsEQQInyQYEN028L/Y3WG0UmUnpX4vaMBbeoy5GsdgrN6VY
         lKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DctpeWixZedWLIe9T1LbBcTwsFUdxzd0r0hcVxTsfr4=;
        b=Zlg3ZnJMLlta7BbC3YHMGDcROqn//TFuPqG9sVf5JFxvcrYIPeBhBDhRb21PDpCWyc
         M/c53GIEg3qTVPM858HxQiAUleYiMwo7a7j1UQcYqsd09uj0obebvxbsCRiJ1Dfy/y9m
         zIlU9guDIuIuaVYnM6lt7OQ6Sx2qBDJOxA0exmbIK/kR/pLs9KlXe8ohoxP3vbMdY2MS
         uPogD5hEvIjbAyj17b4zzN0BetJvAQLS4+FuJ+ZAcAKWFFphELP6h3TJur14CSVvBPbp
         7yVz+qF0e2Z+ahzd6dXCmWmRpRKMj5w/GYm7Bb8Pd3D44bIni3LhAW1HtGB874L2zDiZ
         KJUA==
X-Gm-Message-State: AOAM533IdwJz5DvGwghCAyzlQzm6fIf1xxtU1XXDqOEgSzUtXXf8zt9K
        XSL21tpknBHv8VdY1LfzY1iAm66mTGE=
X-Google-Smtp-Source: ABdhPJxfDZPbPmlCJKGaCYMq+K75fM2nT/D47wgF9HTC6Hmxau6KgM2AqO9qnbgPZgA1WpXm9fCSIw==
X-Received: by 2002:a63:c944:: with SMTP id y4mr19792249pgg.435.1606771950226;
        Mon, 30 Nov 2020 13:32:30 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i13sm17470708pfo.139.2020.11.30.13.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:32:29 -0800 (PST)
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Add control of EP voltage
 regulator(s)
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-3-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <154a809d-9320-f0a1-45ad-78af0303a9ac@gmail.com>
Date:   Mon, 30 Nov 2020 13:32:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130211145.3012-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/30/2020 1:11 PM, Jim Quinlan wrote:
> Control of EP regulators by the RC is needed because of the chicken-and-egg
> situation: although the regulator is "owned" by the EP and would be best
> handled on its driver, the EP cannot be discovered and probed unless its
> regulator is already turned on.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 38 ++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index bea86899bd5d..9d4ac42b3bee 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/printk.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -210,6 +211,10 @@ enum pcie_type {
>  	BCM2711,
>  };
>  
> +static const char * const ep_regulator_names[] = {
> +	"vpcie12v", "vpcie3v3", "vpcie1v8", "vpcie0v9",

Only if you need to re-spin this patch series, I would be keen on
putting each string on its own line, that way when adding a subsequent
regulator name, it is just a matter of an one line d

> +};
> +
>  struct pcie_cfg_data {
>  	const int *offsets;
>  	const enum pcie_type type;
> @@ -287,8 +292,25 @@ struct brcm_pcie {
>  	u32			hw_rev;
>  	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> +	struct regulator_bulk_data supplies[ARRAY_SIZE(ep_regulator_names)];
>  };
>  
> +static void brcm_set_regulators(struct brcm_pcie *pcie, bool on)
> +{
> +	struct device *dev = pcie->dev;
> +	int ret;
> +
> +	if (on)
> +		ret = regulator_bulk_enable(ARRAY_SIZE(ep_regulator_names),
> +					    pcie->supplies);
> +	else
> +		ret = regulator_bulk_disable(ARRAY_SIZE(ep_regulator_names),
> +					     pcie->supplies);
> +	if (ret)
> +		dev_err(dev, "failed to %s EP regulators\n",
> +			on ? "enable" : "disable");

Should not you propagate the return value to the caller here?
-- 
Florian
