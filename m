Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFA823A030
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 09:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgHCHQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 03:16:51 -0400
Received: from smtp1.axis.com ([195.60.68.17]:28798 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCHQt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Aug 2020 03:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2377; q=dns/txt; s=axis-central1;
  t=1596439009; x=1627975009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4eB+iWowqFuffEwqVhdlrnC6nMcvTTjY/U9qdPMCwa8=;
  b=h6z/we2ZpIVLYLtPfrlKHe8MgcoQbZkD8iF5759ykTOOzVbavYjAMZCb
   6UeD6cVC7cbZZuYc9lMk3UhEonQvPgcyFCyfNliKgBF8TwaZ7d29UkhJX
   tPeXlFbJMsUvySweDFiMkj7az8qflbGxKxrU/AwMflKohmdrF2ol1WVF+
   IN9t2ln4iOXcvcIvN9bkNgbZyD7o/WyUuT9o/azXb8c12oiYH1eqEZRhJ
   idUlzDwULCNsgpO9b7ptdU9mE9zICuE1ygPr8Ywz2clfpcdbjNPjKnKuZ
   N99Ctzr0gR7ZskdJ9cu6pmOe44Or25pz1k6OjwDf5v+XItSLntjCDCB2k
   w==;
IronPort-SDR: UaNM9T7tIvhQ2yXPgIs4QcPcTkk/tfeHxx4jq1y9AeEkV586tSbCWZGo0H5qrtreyMPTjbFCDP
 Y+y01J24Qk+f1muOB9+jFlUTw/GiCYD6ZO6oqr3An7Wu5oBT/li8icS7SKZKOzsDp1RSGVRN/P
 JHFVLeyn+a3oH1VPQGhXBUvrV08tJXL9Wa8+LfCSxrQA1U3yNOiSmezqWk0BLNTfFwG1BhdbMz
 FL4tYFSx1r3MfsJ5/LVbLSSS2e7SbjJdVyXnLyuR9Epo7K9M2bAPofd6CFKML9itofxnvwJFEr
 Bac=
X-IronPort-AV: E=Sophos;i="5.75,429,1589234400"; 
   d="scan'208";a="11438926"
Date:   Mon, 3 Aug 2020 09:16:42 +0200
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>
Subject: Re: [PATCH 01/10] PCI: dwc: Remove dev_err() when handing an error
 from platform_get_irq()
Message-ID: <20200803071642.7qgua4qnwrre4s3v@axis.com>
References: <20200802142601.1635926-1-kw@linux.com>
 <20200802142601.1635926-2-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200802142601.1635926-2-kw@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 02, 2020 at 04:25:53PM +0200, Krzysztof Wilczyński wrote:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> This change is as per suggestion from Coccinelle:
> 
>   drivers/pci/controller/dwc/pcie-armada8k.c:252:2-9: line 252 is
>   redundant because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pcie-kirin.c:459:3-10: line 459 is
>   redundant because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pci-imx6.c:872:3-10: line 872 is redundant
>   because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pcie-artpec6.c:391:3-10: line 391 is
>   redundant because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pcie-spear13xx.c:202:2-9: line 202 is
>   redundant because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pci-keystone.c:1254:2-9: line 1254 is
>   redundant because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pci-exynos.c:406:2-9: line 406 is redundant
>   because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pci-exynos.c:419:3-10: line 419 is
>   redundant because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c:2193:2-9: line 2193 is
>   redundant because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pcie-histb.c:406:3-10: line 406 is
>   redundant because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pci-meson.c:492:3-10: line 492 is redundant
>   because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pci-dra7xx.c:633:2-9: line 633 is redundant
>   because platform_get_irq() already prints an error
> 
>   drivers/pci/controller/dwc/pci-dra7xx.c:875:2-9: line 875 is redundant
>   because platform_get_irq() already prints an error
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Looks good,

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
