Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF97129AB67
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 13:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750521AbgJ0MEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 08:04:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43435 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750519AbgJ0ME0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 08:04:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201027120413euoutp016f6ebbb2d64365ae5b554414cbae78a4~B19Vto2wF1691316913euoutp01I
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 12:04:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201027120413euoutp016f6ebbb2d64365ae5b554414cbae78a4~B19Vto2wF1691316913euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603800254;
        bh=R5GF9wkvl9fbLJ2esq+T5tYoPnaeG1QG6EWQZalRxkc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LPlJmh6yhlWkhMmN70lsIzDVrUbz8EuAHKlI66vrABeP25M6n64ahpARhDqpnFduL
         WSVJRFsez03ID25621wY47g25Z25tBXDluajIf23PwAkoYuxUrLkNM9HlMvfeNO48K
         oeny0D0iFfm4lgxkBEqnNZbWZI1C8lCBY333tFp4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201027120406eucas1p24ff1f72f661df8c969bd827c587a3b48~B19OSCJrU2567925679eucas1p2o;
        Tue, 27 Oct 2020 12:04:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E5.C2.06456.5BC089F5; Tue, 27
        Oct 2020 12:04:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201027120405eucas1p12cf1c433b1747fcd66a463cfebe4bb67~B19N6rlBM2794727947eucas1p1o;
        Tue, 27 Oct 2020 12:04:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201027120405eusmtrp1ea5539df959d6a3a71bb56d94561deaa~B19N56fq70200102001eusmtrp1M;
        Tue, 27 Oct 2020 12:04:05 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-23-5f980cb56f0b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BA.E5.06314.2BC089F5; Tue, 27
        Oct 2020 12:04:05 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201027120402eusmtip24b82ffe51834a1b0ee51489f53056cb5~B19KtOZ7W2259722597eusmtip2O;
        Tue, 27 Oct 2020 12:04:02 +0000 (GMT)
Subject: Re: [PATCH v2 5/6] pci: dwc: pci-exynos: rework the driver to
 support Exynos5433 variant
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <86df523b-cf3d-5a88-5ccc-c6f2ca9830a4@samsung.com>
Date:   Tue, 27 Oct 2020 13:04:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK+kVOzLaYS6Xk9RoK8AOpVF+n5nNC1EBS-+UxR334d3g@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSxVYRzee8+59xx3rp0uzW8ybXdpqw1Ztk5jSrO6lvWx9U9KXBxfcXGP
        j/QxUshNTRlxd0Oy+bo+JtwYicllcq9YY8JWY7lKyUeNQo7Th/+e93l+z/t7nncviUn7hHZk
        hDKeUSkVUTKRGG/uWTE5NVkWBBzQz7vTZWnhdHG3UUiPrmYI6YqlQoIenM4W0SZTPUEPt2pF
        9ECRQUQXmF4I6M8/Zwg6vb2boFvGe7GjlnJdkQ7JWzQThLykIUHeUJUlkt9vrEJyw6heIF9s
        cDhD+Ik9QpioiERG5eIZKA6v/aIlYjtDr/Sla4WpaMpHjUgSKDeYWTqlRmJSSlUg6FkxEmpk
        sXlYQvBq4SQvLCKYfzuEOIEzNN6dF/BCOYK1BysY7/iK4EdLHIetqWCoHskVcNiG2gP1H8cw
        zoBRRgzaFj7hnCCiXEE9pxZxMSSUJ6TnWXM0TjlC3nLH1shOKgjWFn9t3S+hdkBf4RTOjVtQ
        Z+Fm43GOxqjdoJ/TYjy2hbGp4q1sQJkJeJZ3G+dDe8NjvU7AY2uYNTQSPLaH/txsnDfcQvDe
        WEPwh2wEw2kFfyq7w7hxdSsoRu2DulYXnvaCDlOTgH9GKxid28GHsIKHzY8wnpbAnQwpP70X
        NIbaf2s7B4ewHCTTbGum2VZHs62O5v/eEoRXIVsmgY0OY1hXJZPkzCqi2QRlmHNwTHQD2vxg
        /euGhedoeSioC1EkkllKBufyA6RCRSKbHN2FgMRkNpJjA/2XpJIQRfJVRhUToEqIYtgutIvE
        ZbaSg6VmfykVpohnLjNMLKP6qwpIC7tUlCk61/rau3hK/y7N/8LixPrw9ciCtpQbk6mTIz69
        0+01VnW+Lz+gN6Fu3zdKLyY7N9fFjIebT0TZe407Dfuy6zF0XErSkfrKwKfzC7o4ZXlfnOs3
        QV71PZ195eHMtvzEayHmnPLZLEsP+bq9Q3dZUKRYTGrLN3r8DkXWOT5pPX9ahrPhCtf9mIpV
        /Aa5QCCtXAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7pbeWbEGxz4rWSxpCnDYv6Rc6wW
        N361sVqs+DKT3eLC0x42i/PnN7BbXN41h83i7LzjbBYzzu9jsnjz+wW7ReveI+wWO++cYHbg
        8Vgzbw2jx85Zd9k9Fmwq9di0qpPNo2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Hu3Rz2goNpFSdb57A2MD7x7GLk
        5JAQMJHY0v2BqYuRi0NIYCmjxMXWm2wQCRmJk9MaWCFsYYk/17rYIIreMkocvr6dHSQhLJAs
        0T7hOQuILSKgIrHh+S1mkCJmgXPMEqe+XmCE6Ohhkpi6uYcRpIpNwFCi6y3IKA4OXgE7idap
        wiBhFgFVialf94MNEhVIknh5YSoTiM0rIChxcuYTFpByToFAicYtbiBhZgEziXmbHzJD2PIS
        29/OgbLFJW49mc80gVFoFpLuWUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95Pzc
        TYzAuN127OfmHYyXNgYfYhTgYFTi4b3wdlq8EGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL
        8uOLSnNSiw8xmgL9NpFZSjQ5H5hS8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YW
        pBbB9DFxcEo1MNYHKHa52E53ehZ41iuM91dk5AKVuHvTpHfwbC4zTjrGc0Df8rDj2Y1Svxin
        G3+tY5q072ncSbfg613G0yvnuM3mDeK71a22eBW3dEHbKpl168tFbntprjmacuFnU9W865x7
        9Vp43n4rVk+OKv9w/cA5s6d3Hx7aEKKYOu/dgQXiaW2KNZFiokosxRmJhlrMRcWJAHIaf9jx
        AgAA
X-CMS-MailID: 20201027120405eucas1p12cf1c433b1747fcd66a463cfebe4bb67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201023075756eucas1p18765653e747842eef4b438aff32ef136
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201023075756eucas1p18765653e747842eef4b438aff32ef136
References: <CGME20201023075756eucas1p18765653e747842eef4b438aff32ef136@eucas1p1.samsung.com>
        <20201023075744.26200-1-m.szyprowski@samsung.com>
        <20201023075744.26200-6-m.szyprowski@samsung.com>
        <CAL_JsqK+kVOzLaYS6Xk9RoK8AOpVF+n5nNC1EBS-+UxR334d3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 26.10.2020 20:14, Rob Herring wrote:
> On Fri, Oct 23, 2020 at 2:58 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> From: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
>> dts: exynos: Remove Exynos5440"). Rework this driver to support DWC PCIe
>> variant found in the Exynos5433 SoCs.
>>
>> The main difference in Exynos5433 variant is lack of the MSI support
>> (the MSI interrupt is not even routed to the CPU).
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> [mszyprow: reworked the driver to support only Exynos5433 variant,
>>             simplified code, rebased onto current kernel code, added
>>             regulator support, converted to the regular platform driver,
>>             removed MSI related code, rewrote commit message]
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>   drivers/pci/controller/dwc/Kconfig      |   3 +-
>>   drivers/pci/controller/dwc/pci-exynos.c | 358 ++++++++++--------------
>>   drivers/pci/quirks.c                    |   1 +
>>   3 files changed, 145 insertions(+), 217 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index bc049865f8e0..ade07abd23c9 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -84,8 +84,7 @@ config PCIE_DW_PLAT_EP
>>
>>   config PCI_EXYNOS
>>          bool "Samsung Exynos PCIe controller"
>> -       depends on SOC_EXYNOS5440 || COMPILE_TEST
>> -       depends on PCI_MSI_IRQ_DOMAIN
>> +       depends on ARCH_EXYNOS || COMPILE_TEST
>>          select PCIE_DW_HOST
>>
>>   config PCI_IMX6
>> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
>> index 242683cde04a..58056fbdc2fa 100644
>> --- a/drivers/pci/controller/dwc/pci-exynos.c
>> +++ b/drivers/pci/controller/dwc/pci-exynos.c
>> @@ -2,26 +2,23 @@
>>   /*
>>    * PCIe host controller driver for Samsung Exynos SoCs
>>    *
>> - * Copyright (C) 2013 Samsung Electronics Co., Ltd.
>> + * Copyright (C) 2013-2020 Samsung Electronics Co., Ltd.
>>    *             https://www.samsung.com
>>    *
>>    * Author: Jingoo Han <jg1.han@samsung.com>
>> + *        Jaehoon Chung <jh80.chung@samsung.com>
>>    */
>>
>>   #include <linux/clk.h>
>>   #include <linux/delay.h>
>> -#include <linux/gpio.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>>   #include <linux/of_device.h>
>> -#include <linux/of_gpio.h>
>>   #include <linux/pci.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/phy/phy.h>
>> -#include <linux/resource.h>
>> -#include <linux/signal.h>
>> -#include <linux/types.h>
>> +#include <linux/regulator/consumer.h>
>>
>>   #include "pcie-designware.h"
>>
>> @@ -37,102 +34,47 @@
>>   #define PCIE_IRQ_SPECIAL               0x008
>>   #define PCIE_IRQ_EN_PULSE              0x00c
>>   #define PCIE_IRQ_EN_LEVEL              0x010
>> -#define IRQ_MSI_ENABLE                 BIT(2)
>>   #define PCIE_IRQ_EN_SPECIAL            0x014
>> -#define PCIE_PWR_RESET                 0x018
>> +#define PCIE_SW_WAKE                   0x018
>> +#define PCIE_BUS_EN                    BIT(1)
>>   #define PCIE_CORE_RESET                        0x01c
>>   #define PCIE_CORE_RESET_ENABLE         BIT(0)
>>   #define PCIE_STICKY_RESET              0x020
>>   #define PCIE_NONSTICKY_RESET           0x024
>>   #define PCIE_APP_INIT_RESET            0x028
>>   #define PCIE_APP_LTSSM_ENABLE          0x02c
>> -#define PCIE_ELBI_RDLH_LINKUP          0x064
>> +#define PCIE_ELBI_RDLH_LINKUP          0x074
>> +#define PCIE_ELBI_XMLH_LINKUP          BIT(4)
>>   #define PCIE_ELBI_LTSSM_ENABLE         0x1
>>   #define PCIE_ELBI_SLV_AWMISC           0x11c
>>   #define PCIE_ELBI_SLV_ARMISC           0x120
>>   #define PCIE_ELBI_SLV_DBI_ENABLE       BIT(21)
>>
>> -struct exynos_pcie_mem_res {
>> -       void __iomem *elbi_base;   /* DT 0th resource: PCIe CTRL */
>> -};
>> -
>> -struct exynos_pcie_clk_res {
>> -       struct clk *clk;
>> -       struct clk *bus_clk;
>> -};
>> +/* DBI register */
>> +#define PCIE_MISC_CONTROL_1_OFF                0x8BC
>> +#define DBI_RO_WR_EN                   BIT(0)
> Standard DWC port logic register. The core already handles this
> mostly. And provides a function to it where it doesn't. Looking at
> your use, I think you can drop the access.
>
>> ...
>> @@ -243,19 +168,25 @@ static int exynos_pcie_establish_link(struct exynos_pcie *ep)
>>          exynos_pcie_assert_core_reset(ep);
>>
>>          phy_reset(ep->phy);
>> -
>> -       exynos_pcie_writel(ep->mem_res->elbi_base, 1,
>> -                       PCIE_PWR_RESET);
>> -
>>          phy_power_on(ep->phy);
>>          phy_init(ep->phy);
>>
>>          exynos_pcie_deassert_core_reset(ep);
>> +
>> +       val = exynos_pcie_readl(ep->elbi_base, PCIE_SW_WAKE);
>> +       val &= ~PCIE_BUS_EN;
>> +       exynos_pcie_writel(ep->elbi_base, val, PCIE_SW_WAKE);
>> +
>> +       /*
>> +        * Enable DBI_RO_WR_EN bit.
>> +        * - When set to 1, some RO and HWinit bits are wriatble from
>> +        *   the local application through the DBI.
>> +        */
>> +       dw_pcie_writel_dbi(pci, PCIE_MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
>>          dw_pcie_setup_rc(pp);
> First thing this function does is set DBI_RO_WR_EN.

Indeed, this has been added to dw_pcie_setup_rc() in commit 3924bc2fd1b6 
("PCI: dwc: Group DBI registers writes requiring unlocking"), after 
initial version of this patchset. Thanks for pointing this out. I will 
remove this.

>> ...
>> @@ -450,42 +347,49 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>>          if (!ep)
>>                  return -ENOMEM;
>>
>> -       pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
>> -       if (!pci)
>> -               return -ENOMEM;
>> -
>> -       pci->dev = dev;
>> -       pci->ops = &dw_pcie_ops;
>> +       ep->pci.dev = dev;
>> +       ep->pci.ops = &dw_pcie_ops;
>>
>> -       ep->pci = pci;
>> -       ep->ops = (const struct exynos_pcie_ops *)
>> -               of_device_get_match_data(dev);
>> +       ep->phy = devm_of_phy_get(dev, np, NULL);
>> +       if (IS_ERR(ep->phy))
>> +               return PTR_ERR(ep->phy);
>>
>> -       ep->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
>> +       /* External Local Bus interface (ELBI) registers */
>> +       ep->elbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
>> +       if (IS_ERR(ep->elbi_base))
>> +               return PTR_ERR(ep->elbi_base);
>>
>> -       ep->phy = devm_of_phy_get(dev, np, NULL);
>> -       if (IS_ERR(ep->phy)) {
>> -               if (PTR_ERR(ep->phy) != -ENODEV)
>> -                       return PTR_ERR(ep->phy);
>> +       /* Data Bus Interface (DBI) registers */
>> +       ep->pci.dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
>> +       if (IS_ERR(ep->pci.dbi_base))
>> +               return PTR_ERR(ep->pci.dbi_base);
> This is going to get moved to the DWC core code.
Well, so far it is not there yet and other dw-pci drivers do it on their 
own. Could you point a patch that does this, so I can rebase onto it?
>
>> -               ep->phy = NULL;
>> +       ep->clk = devm_clk_get(dev, "pcie");
>> +       if (IS_ERR(ep->clk)) {
>> +               dev_err(dev, "Failed to get pcie rc clock\n");
>> +               return PTR_ERR(ep->clk);
>>          }
>>
>> -       if (ep->ops && ep->ops->get_mem_resources) {
>> -               ret = ep->ops->get_mem_resources(pdev, ep);
>> -               if (ret)
>> -                       return ret;
>> +       ep->bus_clk = devm_clk_get(dev, "pcie_bus");
>> +       if (IS_ERR(ep->bus_clk)) {
>> +               dev_err(dev, "Failed to get pcie bus clock\n");
>> +               return PTR_ERR(ep->bus_clk);
>>          }
>>
>> -       if (ep->ops && ep->ops->get_clk_resources &&
>> -                       ep->ops->init_clk_resources) {
>> -               ret = ep->ops->get_clk_resources(ep);
>> -               if (ret)
>> -                       return ret;
>> -               ret = ep->ops->init_clk_resources(ep);
>> -               if (ret)
>> -                       return ret;
>> -       }
>> +       ep->supplies[0].supply = "vdd18";
>> +       ep->supplies[1].supply = "vdd10";
>> +       ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ep->supplies),
>> +                                     ep->supplies);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = exynos_pcie_init_clk_resources(ep);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
>> +       if (ret)
>> +               return ret;
>>
>>          platform_set_drvdata(pdev, ep);
>>
>> @@ -497,9 +401,9 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>>
>>   fail_probe:
>>          phy_exit(ep->phy);
>> +       exynos_pcie_deinit_clk_resources(ep);
>> +       regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
>>
>> -       if (ep->ops && ep->ops->deinit_clk_resources)
>> -               ep->ops->deinit_clk_resources(ep);
>>          return ret;
>>   }
>>
>> @@ -507,32 +411,56 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
>>   {
>>          struct exynos_pcie *ep = platform_get_drvdata(pdev);
>>
>> -       if (ep->ops && ep->ops->deinit_clk_resources)
>> -               ep->ops->deinit_clk_resources(ep);
>> +       phy_power_off(ep->phy);
>> +       phy_exit(ep->phy);
>> +       exynos_pcie_deinit_clk_resources(ep);
>> +       regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
>>
>>          return 0;
>>   }
>>
>> +static int __maybe_unused exynos_pcie_suspend_noirq(struct device *dev)
>> +{
> Why noirq variant needed? Lot's of PCI host drivers do this and I've
> yet to get a reason...
Frankly, I have no idea, but switching to SET_LATE_SYSTEM_SLEEP_PM_OPS 
breaks system suspend/resume operation - the board doesn't resume from 
suspend. If this is really important I will add some more logs and try 
to find what happens between late/early and noirq phases.
> Adding suspend/resume should probably be a separate patch. What I'd
> like to do here is have common DWC suspend/resume functions that the
> platform drivers can use or wrap.

Okay, I can move adding suspend/resume to the separate patch if You 
want. However I probably know too little about PCI to extract some 
common dwc suspend/resume functions.

>> +       struct exynos_pcie *ep = dev_get_drvdata(dev);
>> +
>> +       phy_power_off(ep->phy);
>> +       phy_exit(ep->phy);
>> +       regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
>> +
>> +       return 0;
>> +}
>> +
>> +static int __maybe_unused exynos_pcie_resume_noirq(struct device *dev)
>> +{
>> +       struct exynos_pcie *ep = dev_get_drvdata(dev);
>> +       struct dw_pcie *pci = &ep->pci;
>> +       struct pcie_port *pp = &pci->pp;
>> +       int ret;
>> +
>> +       ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
>> +       if (ret)
>> +               return ret;
>> +       /* exynos_pcie_host_init controls ep->phy */
>> +       return exynos_pcie_host_init(pp);
>> +}
>> +
>> +static const struct dev_pm_ops exynos_pcie_pm_ops = {
>> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(exynos_pcie_suspend_noirq,
>> +                                     exynos_pcie_resume_noirq)
>> +};
>> +
>>   static const struct of_device_id exynos_pcie_of_match[] = {
>> -       {
>> -               .compatible = "samsung,exynos5440-pcie",
>> -               .data = &exynos5440_pcie_ops
>> -       },
>> -       {},
>> +       { .compatible = "samsung,exynos5433-pcie", },
>> +       { },
>>   };
>>
>>   static struct platform_driver exynos_pcie_driver = {
>> +       .probe          = exynos_pcie_probe,
>>          .remove         = __exit_p(exynos_pcie_remove),
>>          .driver = {
>>                  .name   = "exynos-pcie",
>>                  .of_match_table = exynos_pcie_of_match,
>> +               .pm             = &exynos_pcie_pm_ops,
>>          },
>>   };
>> -
>> -/* Exynos PCIe driver does not allow module unload */
>> -
>> -static int __init exynos_pcie_init(void)
>> -{
>> -       return platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
>> -}
>> -subsys_initcall(exynos_pcie_init);
> Good that this is gone, but...
>
>> +builtin_platform_driver(exynos_pcie_driver);
> I would like to make all the host drivers modules.

I can check if this can be easily done. If not, I would like to keep it 
builtin in this patch and leave modularization for the future.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

