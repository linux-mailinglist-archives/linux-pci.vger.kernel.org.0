Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131E669929E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 12:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBPLCn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 06:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBPLCm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 06:02:42 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089F913504
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:02:41 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id d40so2211019eda.8
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ea7TLkXH9nH4DA//1th+Z+4aboDPChuuD0jgIfj0RCw=;
        b=H1baVUnJRcg8cDc1YjHMX5yBmKVB2yuz7kOfaFXzi2M87JnaU3ZH7ZFmSYmqmioNiY
         L5NydmwgfDVfi1bon2+jot0meHsl3BYpV0o2/eQzfEdy63bOv+s7f/422AoDnb9kyF9Q
         GEMIr23IMOsksGGdtc9KoJqd/GvjHE8QZhQmWg8Txwh7mw/mSa2IGdir2zCRa5Yt69Nk
         Y05jarUZjiTC7KJNHqNBgyFRB+u4B5v9oPTPb+tYqojbfLU2fiJ09sgyhDe8CS/TMem8
         3Apo17N1y0wFe10mh038/JL0BG9nlzeD9e9OWHtVG+Q0INccnlCJgj83B6fsBqGjpvOd
         H3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea7TLkXH9nH4DA//1th+Z+4aboDPChuuD0jgIfj0RCw=;
        b=HTqFfeqlhXf6gilPsu5GXeAaQHztOx4HJJAG6xDNXFAVfEz19DMTh/kS6NI6++AWEs
         GFuMUKG5v5bLgdq4zgVxksd6HPBF/QtJ++dTBYQXfHjq3aIDhYcIW+vyL9A8H9BfQJhM
         I7dAZAKTPSlME+Mdfun+mlAG3x4W1M97Aqyup3cm8GYwW4ZFw57BZm550LKubJcT95F4
         KLOarX4FVldFRWZBMn4DUXbDjCkN5seSsKt7VNZpYvmAJpnJQJqJLwhvQBfSRE05+Jdg
         kSFRZG/nhBTXDXCMTVc4pLUwTL/PBugs3Rjx3ykOogGN6QBtx1WwFs/KkiLRnJEEipK8
         ZtgA==
X-Gm-Message-State: AO0yUKVbptNmoKN2ChoED5Kz3Z496cTNJ3bb9B+saRy5Fu5SHDgHLyST
        lIhbJKs0aCAlQtpAKcOSv8ddQw==
X-Google-Smtp-Source: AK7set+G0Y1PwG7+QRividE03emGpRaIuD1Nl9H0Z7JGdPW6YUb7ULVXwZn1OpLNIQkPqQB9Ggh7Pg==
X-Received: by 2002:aa7:d846:0:b0:4ab:4c2f:a449 with SMTP id f6-20020aa7d846000000b004ab4c2fa449mr5010022eds.20.1676545359538;
        Thu, 16 Feb 2023 03:02:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y23-20020a50ce17000000b004acc1374849sm669369edi.82.2023.02.16.03.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:02:39 -0800 (PST)
Message-ID: <649a8d88-0504-5aa9-d167-d25d394f3f26@linaro.org>
Date:   Thu, 16 Feb 2023 12:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 04/16] PCI: samsung: Use clock bulk API to get clocks
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, tglx@linutronix.de,
        m.szyprowski@samsung.com, jh80.chung@samsung.co,
        pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121420epcas5p3a4419059969adfb45b379f7e7741968c@epcas5p3.samsung.com>
 <20230214121333.1837-5-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214121333.1837-5-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/02/2023 13:13, Shradha Todi wrote:
> Adopt to clock bulk API to handle clocks.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-samsung.c | 46 ++++++------------------
>  1 file changed, 11 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
> index cfe384aee754..6c07d3f151be 100644
> --- a/drivers/pci/controller/dwc/pci-samsung.c
> +++ b/drivers/pci/controller/dwc/pci-samsung.c
> @@ -54,8 +54,8 @@
>  struct exynos_pcie {
>  	struct dw_pcie			pci;
>  	void __iomem			*elbi_base;
> -	struct clk			*clk;
> -	struct clk			*bus_clk;
> +	struct clk_bulk_data		*clks;
> +	int				clk_cnt;
>  	struct phy			*phy;
>  	struct regulator_bulk_data	supplies[2];
>  };
> @@ -65,30 +65,18 @@ static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
>  	struct device *dev = ep->pci.dev;
>  	int ret;
>  
> -	ret = clk_prepare_enable(ep->clk);
> -	if (ret) {
> -		dev_err(dev, "cannot enable pcie rc clock");
> +	ret = devm_clk_bulk_get_all(dev, &ep->clks);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
> -	ret = clk_prepare_enable(ep->bus_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot enable pcie bus clock");
> -		goto err_bus_clk;
> -	}
> +	ep->clk_cnt = ret;

I think this misses check if you got two clocks.


Best regards,
Krzysztof

