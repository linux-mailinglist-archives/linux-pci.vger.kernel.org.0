Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E9D7E98F4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 10:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjKMJa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 04:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjKMJa2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 04:30:28 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5560310D0;
        Mon, 13 Nov 2023 01:30:24 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c72e275d96so57179801fa.2;
        Mon, 13 Nov 2023 01:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699867822; x=1700472622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BFLwO1MEkjZNVx3zv0RItJg/q41xvxnn7YY3auNWQXc=;
        b=Yp02YClFC1vwh1xEUISqcbYUKKAHN5WGdDK0zEbZOcLQl/Gd3DD3ivfOAR5UxF/yNj
         /Vv/2YGMUISE8a/EQwn7fR+2uRO9bs5sR5FVKMu8eolyGnhV9BAy2ykyun16PBqjpW9W
         3l8o5c42vK73aqyQ61cYloXdoHiUL1+nO298NZm0R/Mc01C/BHC/Y0DiHHz9httXvPqm
         gl+kN1ZBL8SHAMfhAigo1rm8npdJ30RbTBwdVN4VKcd4sans3+CTd1tFGRdSkvi/4m26
         PFEffKfVM9GnZlJRFA8qDdqo4710fGjUw6QZKxmOEU4ettVXSHVpyIJDiJA8qJYcWBO7
         RPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699867822; x=1700472622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFLwO1MEkjZNVx3zv0RItJg/q41xvxnn7YY3auNWQXc=;
        b=ZPc1ssmFK4gLa12iEyTSly5Q2YpKhFGrM2sdcOdH9wjc5u5E4iOkE33wn2QIEnBbqZ
         kmSrsYjakDgoWer+ShrfkTZkDl0EJJI0DolEViji7yXu//gxHv+mdQCQYJunqkgQshw9
         oAzZ64VGORDC6vhmKptePOzIvLs0mOCLscNrVslcw5pbWC8LXB/jXUNno01P1CLE4jPN
         YIlTprkPfU1y7w0351B3uJZUcfnN0pKWfMmD4KbWqq7RWG47okdyyUMMBQHoVjU4BwBs
         c3g2H9Ht/hcjC4rzBlbP/Fv+BwVmwQONoapJDWdgMB96ow5hnuF/nMfjcKjpEHld97K1
         8bxg==
X-Gm-Message-State: AOJu0YwgHUEJYAzt+P5KtQxvKhurFhwUM00NMtJludJDzPXc6Srwm7lC
        Lr3xTbKFAPi6Gl6obcMlGj2glg2uZ7w=
X-Google-Smtp-Source: AGHT+IFO1L5y4VCYchUO/+Ru5DQJLpUskWOSpOWPlKQgLGuKmBaWcFPS1HVVv7QSvPdjU/uY5cEqXg==
X-Received: by 2002:a2e:a4db:0:b0:2bd:1f83:8d4 with SMTP id p27-20020a2ea4db000000b002bd1f8308d4mr4074045ljm.22.1699867822192;
        Mon, 13 Nov 2023 01:30:22 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t4-20020a2e9d04000000b002bf7fd1d336sm923551lji.14.2023.11.13.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 01:30:21 -0800 (PST)
Date:   Mon, 13 Nov 2023 12:30:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: Use devm_kasprintf()
Message-ID: <nx24ea6ur7mbhrmb46cwf3hrierz3qryzqhq6a6eo5ynem477g@fju4d4zmt4mz>
References: <085fc5ac70fc8d73d5da197967e76d18f2ab5208.1699774592.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085fc5ac70fc8d73d5da197967e76d18f2ab5208.1699774592.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 12, 2023 at 08:37:01AM +0100, Christophe JAILLET wrote:
> Use devm_kasprintf() instead of hand writing it.
> This saves the need of an intermediate buffer.
> 
> There was also no reason to use the _const() version of devm_kstrdup().
> The string was known be not constant.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Neat cleanup. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 2ee146767971..d9e3514de0a0 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -366,7 +366,6 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
>  				      struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	char name[32];
>  	int ret, i;
>  
>  	/* This is an optional property */
> @@ -387,9 +386,8 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
>  		if (pcie->gpio_id_clkreq[i] < 0)
>  			return pcie->gpio_id_clkreq[i];
>  
> -		sprintf(name, "pcie_clkreq_%d", i);
> -		pcie->clkreq_names[i] = devm_kstrdup_const(dev, name,
> -							    GFP_KERNEL);
> +		pcie->clkreq_names[i] = devm_kasprintf(dev, GFP_KERNEL,
> +						       "pcie_clkreq_%d", i);
>  		if (!pcie->clkreq_names[i])
>  			return -ENOMEM;
>  	}
> -- 
> 2.34.1
> 
