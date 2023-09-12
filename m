Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4844E79CE79
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 12:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjILKhK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 12 Sep 2023 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjILKg6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 06:36:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43D7CC3;
        Tue, 12 Sep 2023 03:35:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlKjR4qCNz6K6lQ;
        Tue, 12 Sep 2023 18:35:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 11:35:52 +0100
Date:   Tue, 12 Sep 2023 11:35:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with
 Link Width fields
Message-ID: <20230912113552.00000087@Huawei.com>
In-Reply-To: <20230911121501.21910-5-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
        <20230911121501.21910-5-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Sep 2023 15:14:57 +0300
Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
> custom masking and shifting.
> 
> Similarly, change custom code that misleadingly used
> PCI_EXP_LNKSTA_NLW_SHIFT to prepare value for PCI_EXP_LNKCAP write
> to use FIELD_PREP() with correct field define (PCI_EXP_LNKCAP_MLW).

Excellent example for why this changes is a good cleanup beyond
reducing line lengths.  Harder to use the wrong define if you
are using one rather that two :)

Jonathan

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4bba31502ce1..248cd9347e8f 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -9,6 +9,7 @@
>   * Author: Vidya Sagar <vidyas@nvidia.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> @@ -346,8 +347,7 @@ static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
>  	 */
>  	val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
>  	if (val & PCI_EXP_LNKSTA_LBMS) {
> -		current_link_width = (val & PCI_EXP_LNKSTA_NLW) >>
> -				     PCI_EXP_LNKSTA_NLW_SHIFT;
> +		current_link_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
>  		if (pcie->init_link_width > current_link_width) {
>  			dev_warn(pci->dev, "PCIe link is bad, width reduced\n");
>  			val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
> @@ -760,8 +760,7 @@ static void tegra_pcie_enable_system_interrupts(struct dw_pcie_rp *pp)
>  
>  	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
>  				  PCI_EXP_LNKSTA);
> -	pcie->init_link_width = (val_w & PCI_EXP_LNKSTA_NLW) >>
> -				PCI_EXP_LNKSTA_NLW_SHIFT;
> +	pcie->init_link_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val_w);
>  
>  	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
>  				  PCI_EXP_LNKCTL);
> @@ -920,7 +919,7 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>  	/* Configure Max lane width from DT */
>  	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
>  	val &= ~PCI_EXP_LNKCAP_MLW;
> -	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
> +	val |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, pcie->num_lanes);
>  	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
>  
>  	/* Clear Slot Clock Configuration bit if SRNS configuration */

