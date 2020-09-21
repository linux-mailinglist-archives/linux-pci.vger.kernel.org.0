Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2F272A49
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgIUPeW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 11:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIUPeW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 11:34:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9641C061755
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 08:34:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so13261853wrx.7
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uSzkynWntROh06sL5wXx2wzBkInd8hq2VCVKPuCE2JE=;
        b=A/a1iPqBbRn5pk7LFiPA12/Rvof4tKMuZI+DPafPrjPkPY2pff035R74Q++bxw02kC
         E5iGZqJShc5r3h5jklsYx18/KbgFhrbqZUHN8viV0hI2i2OV6O/icWSg1ePc1Le6gwx9
         6xYmw6sA09+5iExyG6wyRKhxdqJqVRDZnIPbK0N8rNqZ/6J/Ad1n/BKk10IrrgIo3CqN
         3PJPETEHBiOxZAsHxknJKcFeQog86phy4OKFH0SCVb8HCVuC0dzqu/VN7lxgfiEBo1qL
         hvIcklYi7oLVrJejmdtOblJ2HLN2LieiBT3vVxcr4oURQRTLGjvPgr2tCHafLiCICOIY
         t7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uSzkynWntROh06sL5wXx2wzBkInd8hq2VCVKPuCE2JE=;
        b=gIrT02vQl1R+8QvQjyaads9SlbR3foBpf77t9R3LT4AtMSnwztZhjOv2TKBfUziod1
         b88+CNIlvHIVCo1u1tVDMCQA7CBDD8BprK+CKH+6RT5gv0FXn8no88cE/wY/A7+7G+rJ
         Klsj10d4XqBb3QzwG6HXX2l/9JBB+SC+bcBED1XDdY0nJEEwZ0M2OeEXU0yn/PPtNNzI
         mXHooj5fvEqh7eVUpyaf51lbYVP6BjdvHyjHgv7JhvzqXqjgcEJfS1GmRJF7pC06G6SY
         FRq80ANnTusnRTnJ+BTdDeL1q9iz4qUskwOeRhL5rGBdCrDvlK+Pg2bARpt8LtYcx4kz
         tnGQ==
X-Gm-Message-State: AOAM530Qecvw1+0gIxwU2yPG2fNLSh4Q65JHKY2Xif9MbNZy94P3pIo4
        ksq6pQpzU4RoGJqzR4zC+MtESok1wTKby/eD
X-Google-Smtp-Source: ABdhPJzUfmqkdpWOiN4w11HpFOm4Ew4OqJdNbCkFmtQS/Rv45Z0VGZ/LIfZay2+QfeiAvoZZyNDCbA==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr340055wrr.201.1600702460451;
        Mon, 21 Sep 2020 08:34:20 -0700 (PDT)
Received: from [192.168.1.23] (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id p3sm19451678wmm.40.2020.09.21.08.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 08:34:19 -0700 (PDT)
Subject: Re: [PATCH] pci: meson: build as module by default
To:     Kevin Hilman <khilman@baylibre.com>, linux-pci@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yue Wang <yue.wang@amlogic.com>
References: <20200918181251.32423-1-khilman@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <5b84ea0b-abc1-006e-c07b-fead6c50c606@baylibre.com>
Date:   Mon, 21 Sep 2020 17:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918181251.32423-1-khilman@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/09/2020 20:12, Kevin Hilman wrote:
> Enable pci-meson to build as a module whenever ARCH_MESON is enabled.
> 
> Cc: Yue Wang <yue.wang@amlogic.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
> Tested on Khadas VIM3 and Khadas VIM3 using NVMe SSD devices.
> 
>  drivers/pci/controller/dwc/Kconfig     | 3 ++-
>  drivers/pci/controller/dwc/pci-meson.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 044a3761c44f..bc049865f8e0 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -237,8 +237,9 @@ config PCIE_HISI_STB
>  	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
>  
>  config PCI_MESON
> -	bool "MESON PCIe controller"
> +	tristate "MESON PCIe controller"
>  	depends on PCI_MSI_IRQ_DOMAIN
> +	default m if ARCH_MESON
>  	select PCIE_DW_HOST
>  	help
>  	  Say Y here if you want to enable PCI controller support on Amlogic
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 4f183b96afbb..7a1fb55ee44a 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -17,6 +17,7 @@
>  #include <linux/resource.h>
>  #include <linux/types.h>
>  #include <linux/phy/phy.h>
> +#include <linux/module.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -589,6 +590,7 @@ static const struct of_device_id meson_pcie_of_match[] = {
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, meson_pcie_of_match);
>  
>  static struct platform_driver meson_pcie_driver = {
>  	.probe = meson_pcie_probe,
> @@ -598,4 +600,8 @@ static struct platform_driver meson_pcie_driver = {
>  	},
>  };
>  
> -builtin_platform_driver(meson_pcie_driver);
> +module_platform_driver(meson_pcie_driver);
> +
> +MODULE_AUTHOR("Yue Wang <yue.wang@amlogic.com>");
> +MODULE_DESCRIPTION("Amlogic PCIe Controller driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
