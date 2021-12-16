Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA164779B4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 17:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbhLPQvz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 11:51:55 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45933 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbhLPQvv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 11:51:51 -0500
Received: by mail-wr1-f47.google.com with SMTP id o13so45236897wrs.12;
        Thu, 16 Dec 2021 08:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Ba3x56xjocitS2MZSEfS0BywGmujU1rIxnCuO82Q5A=;
        b=BgiZyDfNAKNGTyBRpUapJs0oDbQhg+JP0iWm4FwXW2TfBg4VZBfkWWCi84lbhwNF1J
         SQ+2sH0nTKnM0+ZoMU78D4TK6K1CMuyZc5crectlfMBsznJ4X1HYtABh+lR1OzoLZ3uI
         vVgGC28ThDt0R5OF6HfOdrTCTlBF8CrgKrQx0J/dH0PMzbpkUr1lX6HYJuGBkTCbv/1A
         JYPqw73Kfd0O7SKX59ZU6mk3/M86m5eosEyQQYibDwNWn9E5Eu7cY2DAPqxvEVM6NDzf
         eJmhOrdNAwHtuboUc2rR6dS7UsbkVQo+yJLAJdQXuBRod5hAe6JdUvqHSx83ReNv8b8M
         MJ+g==
X-Gm-Message-State: AOAM531ldrGcyxydKRFtpIFj5hCx58Zbf8MwuBpi7ZnivSahdEK/Bm+G
        brtlmVXoW2Esmg3w8yaZM2M=
X-Google-Smtp-Source: ABdhPJzv8g3rSkXzJ5+wU0BtvmOWy+ft4bUfk3k7rdWIj2p3tp/0xgZynAgZR2kYv7SYsOxhwFve4Q==
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr9525086wrr.456.1639673509542;
        Thu, 16 Dec 2021 08:51:49 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b13sm5384793wrh.32.2021.12.16.08.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:51:48 -0800 (PST)
Date:   Thu, 16 Dec 2021 17:51:47 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v7 8/8] PCI: imx: Add the imx8mm pcie support
Message-ID: <Ybtuo0CzfUhoJwsT@rocinante>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-9-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1638432158-4119-9-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

Apologies for a very late review!  Especially since Lorenzo already took
patches as per:

  https://lore.kernel.org/linux-pci/163965080404.20006.5241609551643501749.b4-ty@arm.com/

However, perhaps it's not too late.

[...]
> @@ -446,6 +452,13 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		break;
>  	case IMX7D:
>  		break;
> +	case IMX8MM:
> +		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> +		if (ret) {
> +			dev_err(dev, "unable to enable pcie_aux clock\n");
> +			break;
> +		}
> +		break;

You can drop the inner break, it wouldn't do much here, unless this was
intended to be a return?

> @@ -538,6 +559,10 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	case IMX8MQ:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
>  		break;
> +	case IMX8MM:
> +		if (phy_init(imx6_pcie->phy) != 0)
> +			dev_err(dev, "Waiting for PHY ready timeout!\n");
> +		break;

If the above, you can keep the same style as used throughout the file
already, so it would just simply be:

  if (phy_init(imx6_pcie->phy))

Also, a nitpick: to be consistent with other such messages here, the error
message would be all lower-case letters.

[...]
> @@ -614,6 +639,8 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
>  static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  {
>  	switch (imx6_pcie->drvdata->variant) {
> +	case IMX8MM:
> +		break;
>  	case IMX8MQ:

Would it warrant a comment that adds a note there to this single bare
break?  Perhaps this version is not support, lack this particular
functionality, etc.

[...]
> @@ -1089,10 +1122,39 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  			dev_err(dev, "Failed to get PCIE APPS reset control\n");
>  			return PTR_ERR(imx6_pcie->apps_reset);
>  		}
> +		break;
> +	case IMX8MM:
> +		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> +		if (IS_ERR(imx6_pcie->pcie_aux))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> +					     "pcie_aux clock source missing or invalid\n");
> +		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> +									 "apps");
> +		if (IS_ERR(imx6_pcie->apps_reset)) {
> +			dev_err(dev, "Failed to get PCIE APPS reset control\n");
> +			return PTR_ERR(imx6_pcie->apps_reset);
> +		}
> +
> +		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> +		if (IS_ERR(imx6_pcie->phy)) {
> +			if (PTR_ERR(imx6_pcie->phy) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			dev_err(dev, "Failed to get PCIE PHY\n");
> +			return PTR_ERR(imx6_pcie->phy);
> +		}

A question about handling of the -EPROBE_DEFER above: why not to use the
dev_err_probe() helper similarly to the code above and below?  Would there
be something different preventing the use of dev_err_probe() here too?

>  		break;
>  	default:
>  		break;
>  	}
> +	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
> +	if (imx6_pcie->phy == NULL) {
> +		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> +		if (IS_ERR(imx6_pcie->pcie_phy))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
> +					     "pcie_phy clock source missing or invalid\n");
> +	}

Thank you for another amazing patch!

	Krzysztof
