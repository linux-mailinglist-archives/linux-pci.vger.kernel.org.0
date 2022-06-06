Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772C553EB93
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiFFKZ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 06:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiFFKXb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 06:23:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8F8BF4F
        for <linux-pci@vger.kernel.org>; Mon,  6 Jun 2022 03:23:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h23so16909383ejj.12
        for <linux-pci@vger.kernel.org>; Mon, 06 Jun 2022 03:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4fC528rYEB+48Rn1G1nDF3sqdpbIgh93bu5dw33pZWc=;
        b=lIkxI9ub3el5LZsSbt11MryA5NFGSmjCuEc4lVH5mavFbJ+HQl63gfjY8yhEUEcpCk
         CsCAJSEsMv8ddLTJ284kZ0XYdgVMN6ythE4vuRyBEtVF4cDzf5gqyvcyPhB0eVMHz2o+
         Xrv64MZ5Ci2ghoqtKmPq7E6jEgMCA41nwWmBmAO2lXvKkdbqwYVZAUv4zaaUQSjVluzr
         lBlBIqkIc870WLd7CDtuTUlc52LPw68hLUd7AiMEb5vcojbAZGILNJWWVuESnnYXRJV2
         wye3BEv9t++3wvPMRcf0IfQhKU4IW6nZM4AcI65fu5OMhTurawTaVy1FVPldOhy+3VLn
         +aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4fC528rYEB+48Rn1G1nDF3sqdpbIgh93bu5dw33pZWc=;
        b=YX6ZI86bNSF6EY6TWjvUBJAGetM4/VlWNPBrFL6f7Y7kqGfMkmnvO/A3jEyJrj5YuH
         p7+9Z6o4DdIeqEcl/lcTXjzEerwdzZ1XHSphsSqvBzoIzfPaa0OXOrFFD4BKnHxlS1KB
         qd/YcqB8t2skOHDllS46KRW1KUTLcvSqyLCdZn8JQegnH57drJ6wSlL04N0vtUIA9ygC
         IeYL4fZpczdkv2AwkSrMozJrlmmJnDvNmAxljpAFaaGVpdm80Nf7+V3P+1V5xx/4JQUX
         jbyGn48+1OL2tKzuqAVgtyG77/SpHlDZU0y39rJzuPYKZh4gf4j2jEX2jA8mYlnE4e3c
         c3Mg==
X-Gm-Message-State: AOAM530q7xIL0h9p0Ma7V84RwDfZ1XLMEgCmVNfxEJxI1pvnNnnLB+jA
        m0FabD0NQRU95QoNRYMQkS/5hA==
X-Google-Smtp-Source: ABdhPJxJV4zEbNNhKx5pPCIohTcPcFDBcwVmuGZ/60/VBMrh+TCuOm/Wpi+s93Bbm/FS4taCh9d6Rg==
X-Received: by 2002:a17:906:1109:b0:711:d8fe:fe56 with SMTP id h9-20020a170906110900b00711d8fefe56mr850929eja.261.1654511007645;
        Mon, 06 Jun 2022 03:23:27 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id iy18-20020a170907819200b006fec9cf9237sm5161850ejc.130.2022.06.06.03.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 03:23:27 -0700 (PDT)
Message-ID: <5ddc30ca-df6d-d31d-e500-2faebc0f32f6@linaro.org>
Date:   Mon, 6 Jun 2022 12:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Content-Language: en-US
To:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
References: <20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
 <CGME20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p2>
 <20220603023452epcms2p22b81cfd1ee4866d5a6663c089ded6eac@epcms2p2>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220603023452epcms2p22b81cfd1ee4866d5a6663c089ded6eac@epcms2p2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/06/2022 04:34, Wangseok Lee wrote:
> Add support Axis, ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications.
> This is based on arm64 and support GEN4 & 2lane.
> This PCIe controller is based on DesignWare Hardware core
> and uses DesignWare core functions to implement the driver.
> 
> changes since v1 :
> improvement review comment of Krzysztof on driver code.
> -debug messages for probe or other functions.
> -Inconsistent coding style (different indentation in structure members).
> -Inconsistent code (artpec8_pcie_get_subsystem_resources() gets device
>   from pdev and from pci so you have two same pointers;
>   or artpec8_pcie_get_ep_mem_resources() stores dev 
>   as local variable but uses instead pdev->dev).
> -Not using devm_platform_ioremap_resource().
> -Printing messages in interrupt handlers.
> -Several local/static structures or array are not const.
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
>  drivers/pci/controller/dwc/Kconfig        |  31 ++
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-artpec8.c | 864 ++++++++++++++++++++++++++++++
>  3 files changed, 896 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-artpec8.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 62ce3ab..4aa6da8 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -222,6 +222,37 @@ config PCIE_ARTPEC6_EP
>  	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
>  	  endpoint mode. This uses the DesignWare core.
>  
> +config PCIE_ARTPEC8
> +	bool "Axis ARTPEC-8 PCIe controller"
> +
> +config PCIE_ARTPEC8_HOST
> +	bool "Axis ARTPEC-8 PCIe controller Host Mode"
> +	depends on ARCH_ARTPEC

|| COMPILE_TEST
and test it

> +	depends on PCI_MSI_IRQ_DOMAIN
> +	depends on PCI_ENDPOINT
> +	select PCI_EPF_TEST
> +	select PCIE_DW_HOST
> +	select PCIE_ARTPEC8
> +	help
> +	  Say 'Y' here to enable support for the PCIe controller in the
> +	  ARTPEC-8 SoC to work in host mode.
> +	  This PCIe controller is based on DesignWare Hardware core.
> +	  And uses DesignWare core functions to implement the driver.
> +
> +config PCIE_ARTPEC8_EP
> +	bool "Axis ARTPEC-8 PCIe controller Endpoint Mode"
> +	depends on ARCH_ARTPEC

|| COMPILE_TEST
and test it


> +	depends on PCI_ENDPOINT
> +	depends on PCI_ENDPOINT_CONFIGFS
> +	select PCI_EPF_TEST
> +	select PCIE_DW_EP
> +	select PCIE_ARTPEC8
> +	help
> +	  Say 'Y' here to enable support for the PCIe controller in the
> +	  ARTPEC-8 SoC to work in endpoint mode.
> +	  This PCIe controller is based on DesignWare Hardware core.
> +	  And uses DesignWare core functions to implement the driver.
> +
>  config PCIE_ROCKCHIP_DW_HOST
>  	bool "Rockchip DesignWare PCIe controller"
>  	select PCIE_DW
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 8ba7b67..b361022 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
> +obj-$(CONFIG_PCIE_ARTPEC8) += pcie-artpec8.o

This does not look properly ordered. Usually entries should not be added
at the end.

>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-artpec8.c b/drivers/pci/controller/dwc/pcie-artpec8.c
> new file mode 100644
> index 0000000..d9ae9bf
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-artpec8.c
> @@ -0,0 +1,864 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe controller driver for Axis ARTPEC-8 SoC
> + *
> + * Copyright (C) 2019 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Author: Jaeho Cho <jaeho79.cho@samsung.com>
> + * This file is based on driver/pci/controller/dwc/pci-exynos.c
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +#include <linux/phy/phy.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_artpec8_pcie(x)	dev_get_drvdata((x)->dev)
> +
> +/* Gen3 Control Register */
> +#define PCIE_GEN3_RELATED_OFF		0x890
> +/* Disables equilzation feature */
> +#define PCIE_GEN3_EQUALIZATION_DISABLE	(0x1 << 16)
> +#define PCIE_GEN3_EQ_PHASE_2_3		(0x1 << 9)
> +#define PCIE_GEN3_RXEQ_PH01_EN		(0x1 << 12)
> +#define PCIE_GEN3_RXEQ_RGRDLESS_RXTS	(0x1 << 13)
> +
> +#define FAST_LINK_MODE			(7)
> +
> +/* PCIe ELBI registers */
> +#define PCIE_IRQ0_STS			0x000
> +#define PCIE_IRQ1_STS			0x004
> +#define PCIE_IRQ2_STS			0x008
> +#define PCIE_IRQ5_STS			0x00C
> +#define PCIE_IRQ0_EN			0x010
> +#define PCIE_IRQ1_EN			0x014
> +#define PCIE_IRQ2_EN			0x018
> +#define PCIE_IRQ5_EN			0x01C
> +#define IRQ_MSI_ENABLE			BIT(20)
> +#define PCIE_APP_LTSSM_ENABLE		0x054
> +#define PCIE_ELBI_LTSSM_ENABLE		0x1
> +#define PCIE_ELBI_CXPL_DEBUG_00_31	0x2C8
> +#define PCIE_ELBI_CXPL_DEBUG_32_63	0x2CC
> +#define PCIE_ELBI_SMLH_LINK_UP		BIT(4)
> +#define PCIE_ARTPEC8_DEVICE_TYPE	0x080
> +#define DEVICE_TYPE_EP			0x0
> +#define DEVICE_TYPE_LEG_EP		0x1
> +#define DEVICE_TYPE_RC			0x4
> +#define PCIE_ELBI_SLV_AWMISC		0x828
> +#define PCIE_ELBI_SLV_ARMISC		0x820
> +#define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
> +#define LTSSM_STATE_MASK		0x3f
> +#define LTSSM_STATE_L0			0x11
> +
> +/* FSYS SYSREG Offsets */
> +#define FSYS_PCIE_CON			0x424
> +#define PCIE_PERSTN			BIT(5)
> +#define FSYS_PCIE_DBI_ADDR_CON		0x428
> +#define FSYS_PCIE_DBI_ADDR_OVR_CDM	0x00
> +#define FSYS_PCIE_DBI_ADDR_OVR_SHADOW	0x12
> +#define FSYS_PCIE_DBI_ADDR_OVR_ATU	0x36
> +
> +/* PMU SYSCON Offsets */
> +#define PMU_SYSCON_PCIE_ISOLATION	0x3200
> +
> +/* BUS P/S SYSCON Offsets */
> +#define BUS_SYSCON_BUS_PATH_ENABLE	0x0
> +
> +int artpec8_pcie_dbi_addr_con[] = {

1. I think I pointed before the need to constify everything which is const.
2. Missing static
3. definitions of static variables go after type declarations.

> +	FSYS_PCIE_DBI_ADDR_CON
> +};
> +
> +struct artpec8_pcie {
> +	struct dw_pcie			*pci;
> +	struct clk			*pipe_clk;
> +	struct clk			*dbi_clk;
> +	struct clk			*mstr_clk;
> +	struct clk			*slv_clk;

Not really...  Just use clk_bulk_api.

> +	const struct artpec8_pcie_pdata	*pdata;
> +	void __iomem			*elbi_base;
> +	struct regmap			*sysreg;
> +	struct regmap			*pmu_syscon;
> +	struct regmap			*bus_s_syscon;
> +	struct regmap			*bus_p_syscon;
> +	enum dw_pcie_device_mode	mode;
> +	int				link_id;
> +	/* For Generic PHY Framework */

Skip comment, it's obvious.

> +	struct phy			*phy;
> +};
> +

> +	/* fsys sysreg regmap handle */
> +	artpec8_ctrl->sysreg =
> +		syscon_regmap_lookup_by_phandle(dev->of_node,
> +			"samsung,fsys-sysreg");

NAK.

Usage of undocumented properties. Every property must be documented.

Since you do not want to merge it with existing drivers (and more people
insist on that: https://lore.kernel.org/all/Ym+u9yYrV9mxkyWX@matsya/ ),
I am actually considering to NAK entire set if you do not post a user of
this - DTS. Mainly because we cannot verify how does that user look like
and such changes are sneaked in.

Best regards,
Krzysztof
