Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8993627930D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 23:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgIYVNh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 17:13:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38858 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbgIYVNh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 17:13:37 -0400
Received: by mail-io1-f67.google.com with SMTP id q4so4513799iop.5;
        Fri, 25 Sep 2020 14:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8kwDPxGWO4Zarxs+976VhrgRShKS6L8rrmLcdeo03XU=;
        b=bH/1qrFFXBB+RdHaYuesSn2ZJcCnGGEyTyLGosZ/9cVR1NiXHaLXberYDX69X1uKLN
         zIgF7TTeuuoBevGkEQ8r2CyYWhHHTN8xgBLs97grXMuTfD+ZT7gNkY4LyA1DeJBY4zT0
         5N1klZwobGIOUtZhpVSlaSQX2lDJaLn8ob9rZRyIgRCrQ8e7FOfqnuBWk8akltqiOvde
         I1XTm0ZYdEBHpQoY+7dvk8eDSuSPaNJerLilpz+/61bPUW3f9EJdlE1KTDAFWpXRjBin
         hlMwwarAeD+x1K5KrpBrsJ3u4V1qqL4oPpN+j/zHs4WwKaJdl7ykLD8HwEHTDqMSBEYL
         Zg+Q==
X-Gm-Message-State: AOAM530BesOfRlxhKsESc1x0g3xIqut4R18wfkpd5ekObIPoluxgoh62
        L/zcOsbd5HSsh933SDx7Pe1hoYa8C3EH
X-Google-Smtp-Source: ABdhPJzcS6KJxgxXK5xNBZe2qTu3yKbC+yVLPJn/UV/Er3LVgOvC7c2afoKP/sKN6F+XgON+lf0dUQ==
X-Received: by 2002:a5d:97cd:: with SMTP id k13mr367521ios.164.1601068416055;
        Fri, 25 Sep 2020 14:13:36 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o13sm2302386ilk.40.2020.09.25.14.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 14:13:35 -0700 (PDT)
Received: (nullmailer pid 980712 invoked by uid 1000);
        Fri, 25 Sep 2020 21:13:34 -0000
Date:   Fri, 25 Sep 2020 15:13:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Yue Wang <yue.wang@amlogic.com>, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] pci: meson: build as module by default
Message-ID: <20200925211334.GA972187@bogus>
References: <20200918181251.32423-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918181251.32423-1-khilman@baylibre.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 11:12:51AM -0700, Kevin Hilman wrote:
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

You need a remove hook to tear down the PCI bus at least. 

Really I'd like to add a devres hook in pci_host_probe to do that for 
all the drivers.

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

First line is: SPDX-License-Identifier: GPL-2.0

> -- 
> 2.28.0
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
