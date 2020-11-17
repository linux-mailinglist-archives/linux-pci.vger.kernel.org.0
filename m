Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5F2B5B11
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 09:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgKQIgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 03:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQIgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 03:36:10 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1D8C0617A6
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 00:36:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so2411240wmb.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 00:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oCpWij6gQyPaU0VsGijaHqphTca/arxfImIfEjChlFk=;
        b=H4WJcFMk7ybStripjq6pImq7T4vKPCDBqz9gxHbKlbwxlcJgqxvkoUQ0GKHthVOzb+
         wMvVVoSzUQryWumh/dPk07y941+4xUxY62F3o48hIJLf9LbGNltrK+oMiWKRv3MgqnTL
         D1W8LzyNfZ48OtFx/83H1iFYFwqP+dr7abNy89Iq43dePt1+ZL2/NR0ITGZW8PMbmWFn
         cfebziSlQdydAIV6M9bqV1mzDa3pnpvVqhF3F/xOMh6dSzvHAUIDJmw1gEslc3J7DE49
         QoQlmM7sn2v5w/jVWNaUBI3ulbovQlBnuO280VWVtWjP8BaJ7W7qZEvVcX5X7+oukhtN
         CAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oCpWij6gQyPaU0VsGijaHqphTca/arxfImIfEjChlFk=;
        b=sY9AVua8njlujJLteVQPQDIkeMNJonkN39AEcMqIl1vcYSJsYv7kC9g4vUKzcYmF3L
         MWtRIq1Cp7oMAUsSyk4nw3wQzhQOMlTlgyWY7MG8zKG5DGZyA6oUCKON+liIuMw3XSOV
         0O5sd7O9cfSD6dfsrQ4TX7OjqbSPOnpLzzJGhOqnrGMpOxfasl4JSVwFbZOVOrX3yq0g
         hjuTcgGvvgKpKUuBsxsUTk3HyVkxn6mh70cKOeoD+mr/cXM+0ukvqCj0aZXeqzf04Ljy
         jqUgiSGtTzQC/dqeSpiL3jAssEW+Xt+vjfilcMuNEqObP38R16CnL5y5s36LdnAxlQOW
         1Bxg==
X-Gm-Message-State: AOAM533irVUL/dMPBagWkkSd+V6weuCu3WrqfcDty3PbwU1KKgN+9rDZ
        j5NIO5iGaAmJIhPBB/dB5y7jwA==
X-Google-Smtp-Source: ABdhPJzYK/i1ToG58uJL5Cw871V01CgeVejEN/wGuWFWUMips8GzYBv83TCZCupcrwucrJMY9b+rsA==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr3222912wmg.155.1605602168327;
        Tue, 17 Nov 2020 00:36:08 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:1561:9f4b:5829:8e26? ([2a01:e35:2ec0:82b0:1561:9f4b:5829:8e26])
        by smtp.gmail.com with ESMTPSA id p4sm26794274wrm.51.2020.11.17.00.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 00:36:07 -0800 (PST)
Subject: Re: [PATCH] PCI: dwc/meson: Use PTR_ERR_OR_ZERO
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20201116163418.10529-1-sudipm.mukherjee@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <b28005c3-de6d-79db-34e6-b5298b9f0224@baylibre.com>
Date:   Tue, 17 Nov 2020 09:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116163418.10529-1-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/11/2020 17:34, Sudip Mukherjee wrote:
> Coccinelle suggested using PTR_ERR_OR_ZERO() and looking at the code,
> we can use PTR_ERR_OR_ZERO() instead of checking IS_ERR() and then
> doing 'return 0'.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 1913dc2c8fa0..f4261f5aceb1 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -115,10 +115,8 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>  		return PTR_ERR(pci->dbi_base);
>  
>  	mp->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> -	if (IS_ERR(mp->cfg_base))
> -		return PTR_ERR(mp->cfg_base);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(mp->cfg_base);
>  }
>  
>  static int meson_pcie_power_on(struct meson_pcie *mp)
> @@ -208,10 +206,8 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
>  		return PTR_ERR(res->general_clk);
>  
>  	res->clk = meson_pcie_probe_clock(dev, "pclk", 0);
> -	if (IS_ERR(res->clk))
> -		return PTR_ERR(res->clk);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(res->clk);
>  }
>  
>  static inline u32 meson_cfg_readl(struct meson_pcie *mp, u32 reg)
> 

Hi,

This has been nacked multiple times already:
https://lore.kernel.org/linux-pci/20190527140952.GB7202@ulmo/

Neil
