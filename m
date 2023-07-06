Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D083974A3F5
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 20:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGFSzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 14:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGFSzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 14:55:23 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7287E1FC3;
        Thu,  6 Jul 2023 11:55:14 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-54290603887so653080a12.1;
        Thu, 06 Jul 2023 11:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688669714; x=1691261714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBdd5s/FFVxO5TNekWl/KPTrNBlLui+t78ttnXuS8gU=;
        b=XgXPuXKCOAO4qwC59XzFb+0A6UUBkgp4PjUWuo2QLC59uuzB3KZiEXLWffwsdjhAn4
         dcjHQb091LIvxoeZsx950sp60gDtKdX7p+ypgm4mB1lfBiVH0pjx+PbcN/m3zX95fGtK
         1BbD0ZUYw1RJtVGGQ64CW7ppMkCcJiwsURlM171J9ufJkLocsBdX89c/pYUhFq19ElOF
         sEbY52zz6byEbhGtv3oqZPdbeIz5Dwr0ujhYL81mJl1E38dKNSnreEDDO3YdoWYDXIBS
         uyBqFzSQ93TDvdCA3rgxYijiyVfCZfVndQd/p9mfFC7Y/xF04P9iDu3oDGcmZZqyaRYV
         hLBg==
X-Gm-Message-State: ABy/qLZZcmSOJxNR/yDhkZ1n+jGUFQyKzsL3IGNCSjSMfM6nUGe6DC3Q
        Zz/10g8iuqfH8imnlaiMEpY=
X-Google-Smtp-Source: APBJJlFsQ1/jF9uNltaaWujnF/CS5XXrxSMTlDsYnORVl0qazEKAiGMdtHdLHk3hIswpLHSe6pOVhA==
X-Received: by 2002:a05:6a20:d7:b0:12d:2abd:73f4 with SMTP id 23-20020a056a2000d700b0012d2abd73f4mr1847877pzh.26.1688669713779;
        Thu, 06 Jul 2023 11:55:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id z21-20020aa791d5000000b0063b898b3502sm1580622pfa.153.2023.07.06.11.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 11:55:12 -0700 (PDT)
Date:   Fri, 7 Jul 2023 03:55:11 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH 3/4] PCI: v3-semi: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230706185511.GA3380331@rocinante>
References: <20230706092047.18599-1-frank.li@vivo.com>
 <20230706092047.18599-3-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706092047.18599-3-frank.li@vivo.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Cc Yang]

Hello,

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

A very similar series was posted a while ago.  Patches 1, 2 and 4 in this
series are identical, except for this patch, which adds one more very nice
refactoring,

The other series:

  https://lore.kernel.org/linux-pci/20230626110226.GA569947@rocinante

What I can do would be to pick this patch and squash it with the other ones
that are already applied.  I will then attribute both you and Yang Li as
the authors.  Let me know if this is fine with you, Yangtao and Yang.

That said...

> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> index ca44b0c83d1b..0f993328dba2 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -736,8 +736,7 @@ static int v3_pci_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	v3->base = devm_ioremap_resource(dev, regs);
> +	v3->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);

Are you sure about the variable name here? This might be a small copy-and-paste
mistake that snuck up here.  Have a closer look, or better yet, try to compile
and test this. :)

> -	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	v3->config_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);

Same as above.

> +	if (IS_ERR(v3->config_base))
> +		return PTR_ERR(v3->config_base);
>  	if (resource_size(regs) != SZ_16M) {
>  		dev_err(dev, "config mem is not 16MB!\n");
>  		return -EINVAL;
>  	}
>  	v3->config_mem = regs->start;
> -	v3->config_base = devm_ioremap_resource(dev, regs);
> -	if (IS_ERR(v3->config_base))
> -		return PTR_ERR(v3->config_base);

This could be made such that the assignments are together.

	Krzysztof
