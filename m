Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB038A40C
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 11:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhETKAX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 06:00:23 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:44015 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhETJ6i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 05:58:38 -0400
Received: by mail-wm1-f43.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso2301364wmc.2;
        Thu, 20 May 2021 02:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kfh4qvww6RXzTsiaXxy8fLDj8PmDsjN9WNGaz00HHAQ=;
        b=m4+r4+W5CkztbMLrMFmpDWaZWGe8vlf0ylIgG61CuuWm6zVD5PodZhAJwKI9H5LOTr
         gs5d8jEpmj2kQqufN/gmlXaLo5FEOpij5deK5XfJPOizmiH8sjPu7oCrf6oywu3xSPu8
         80W2hLJKFJyQMNJ8K2bFi+4Y18jO4l7uxuFlsbiuKkHG7mmR+MNrII/IaOeu5blw3Lvm
         WhrOngPEHf4ZTtIJkVZY2PmdR81fDQ6ahIW6rimi5exGIZ/dnpAff94rxJvx8VefYGm6
         cjf86aO8QTTWVhHayMaptr6m+nHAPW0CWw7B4bwyluyJtTCRZohP+u/s0dnAuNdLbHJ9
         2ICg==
X-Gm-Message-State: AOAM5309dmL3PWsxbyhGq3vuOWhpjgfSYkHmgZd9EIcwmvQewqFHoQO8
        XZ2g6vvesTph1cb2Cj9fSwc=
X-Google-Smtp-Source: ABdhPJxTfK3/o36L0DsyxnHHp/QRwZN0AcKwfSl8Z+70RGtp8/O2TcPFD08vigVIU5/xfyEbG1+Vcg==
X-Received: by 2002:a7b:cdf0:: with SMTP id p16mr3173799wmj.27.1621504635584;
        Thu, 20 May 2021 02:57:15 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f7sm3024687wrg.34.2021.05.20.02.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 02:57:14 -0700 (PDT)
Date:   Thu, 20 May 2021 11:57:13 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
Message-ID: <20210520095713.GA647160@rocinante.localdomain>
References: <20210520090123.11814-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520090123.11814-1-jonathanh@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

> Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
> errata") caused a few build regressions for the Tegra194 PCIe driver
> which are:
> 
> 1. The Tegra194 PCIe driver can no longer be built as a module. This
>    was caused by removing the Makefile entry to build the pcie-tegra.c
>    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
>    so that we can build the driver as a module if ACPI support is not
>    enabled in the kernel.
> 2. If CONFIG_PCIE_TEGRA194 is configured to build the driver as a
>    module, at the same time that CONFIG_ACPI and CONFIG_PCI_QUIRKS are
>    selected to build the driver into the kernel, then the necessary
>    functions in the driver to probe and remove the device when booting
>    with device-tree and not compiled into to the driver. This prevents
>    the PCIe devices being probed when booting with device-tree. Fix this
>    by using the IS_ENABLED() macro.
> 3. The below build warnings to be seen with particular kernel
>    configurations. Fix these by adding the necessary guards around these
>    variable definitions.
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
>   	‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
>   drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
>   	‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
>   drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
>   	‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]
> 
> Fixes: 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata")

Thank you for fixing this!  Much appreciated!

[...]
> +#if IS_ENABLED(CONFIG_PCIE_TEGRA194)
>  static const unsigned int pcie_gen_freq[] = {
>  	GEN1_CORE_CLK_FREQ,
>  	GEN2_CORE_CLK_FREQ,
>  	GEN3_CORE_CLK_FREQ,
>  	GEN4_CORE_CLK_FREQ
>  };
> +#endif
>  
> +#if defined(CONFIG_PCIEASPM)
>  static const u32 event_cntr_ctrl_offset[] = {
>  	0x1d8,
>  	0x1a8,
> @@ -264,6 +267,7 @@ static const u32 event_cntr_data_offset[] = {
>  	0x1c8,
>  	0x1dc
>  };
> +#endif

A small note about the above - I believe Bjorn might prefer if we move
these two into the existing blocks, rather than wrapping both as done
here, so that things are grouped together.  Albeit, I leave it to Bjorn
to give us feedback on his preferred style.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
