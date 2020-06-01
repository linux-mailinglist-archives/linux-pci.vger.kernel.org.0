Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DED91EB0F6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 23:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgFAVcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 17:32:20 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37618 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgFAVcT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 17:32:19 -0400
Received: by mail-il1-f194.google.com with SMTP id r2so10856883ila.4;
        Mon, 01 Jun 2020 14:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KmqdPjmKi1JsFB5M9JoF0ic/ni7mUj8Ld/K9RQPC/wI=;
        b=e0a+jScmWNqrb1cqt9kF/Yf5FqXC3FnBxiWLCUg77EIAOMtOt/1/qNjLYWCJ3TNLMG
         45aBKM51Bfrk+w14s2MRm3KowkAeQhjonoy32UXYd5AUkgoZwTNPbrudydhnG1LBxLWr
         DRICS9IEPAsMnteJUhI2RNAat6M8dBbLgBZG0UowggJRbTWN0WquHOeWZZk8hSohSfOz
         YRfPIXm+ucUTr+CEBajJBRqpO4594UicjpSOjAfJV0qTcqjQ8MTu3Jv4/aOiBmfQiJZM
         O+7Du82Y52WocjNCp2B2Gj4o7fHx/eaYKdd3rn6jKQLC7vObgOYpqQDEnX74Ray/xIJx
         dr1A==
X-Gm-Message-State: AOAM5334b7qGfx+1lePR5mf6tV4DSMd2R3YxC4l0B5E8Eng59R/dlZHQ
        MO7DvXO26vO7VWCUSwPljw==
X-Google-Smtp-Source: ABdhPJxcDy18dpk1MqV1lWeF44sQZHoChgAxfWTvpW2F+X+1hLmjYqir/8cNHemHgkNLDjDLv0WK7Q==
X-Received: by 2002:a05:6e02:13a9:: with SMTP id h9mr3518316ilo.20.1591047137611;
        Mon, 01 Jun 2020 14:32:17 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b10sm396689ilb.2.2020.06.01.14.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:32:16 -0700 (PDT)
Received: (nullmailer pid 1537618 invoked by uid 1000);
        Mon, 01 Jun 2020 21:32:15 -0000
Date:   Mon, 1 Jun 2020 15:32:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 4/5] PCI: uniphier: Add iATU register support
Message-ID: <20200601213215.GA1521885@bogus>
References: <1589536743-6684-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1589536743-6684-5-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589536743-6684-5-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 15, 2020 at 06:59:02PM +0900, Kunihiko Hayashi wrote:
> This gets iATU register area from reg property. In Synopsis DWC version
> 4.80 or later, since iATU register area is separated from core register
> area, this area is necessary to get from DT independently.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index a8dda39..493f105 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -447,6 +447,13 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->pci.dbi_base))
>  		return PTR_ERR(priv->pci.dbi_base);
>  
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> +	if (res) {
> +		priv->pci.atu_base = devm_pci_remap_cfg_resource(dev, res);

This isn't config space, so this function shouldn't be used.

Use devm_platform_ioremap_resource_byname().

> +		if (IS_ERR(priv->pci.atu_base))
> +			priv->pci.atu_base = NULL;
> +	}
> +
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
>  	priv->base = devm_ioremap_resource(dev, res);

Feel free to convert this one too.

>  	if (IS_ERR(priv->base))
> -- 
> 2.7.4
> 
