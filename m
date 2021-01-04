Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149382E93D8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 12:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbhADLCQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 06:02:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37542 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADLCQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 06:02:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104B0lxi067821;
        Mon, 4 Jan 2021 05:00:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609758047;
        bh=nU0QXzcYjxUXyNhlJEPsHs1vQHfjG7/yfEack7+6TUs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GCZAMn6W6E9WSGxwUMj4InLxgkUAcf1wlFml6z59Ixk4e2MLou/UKaWdIZaIEJzob
         8fUgL3JErRFNRl2ktPldoIbSwxAdPGYUtf0jrrTCKIQOmtf9scpNGE6wlKti9DyM0q
         Qt51T27/JQJwvd4O8CwvhcWQKbri2vfsC6cMocYk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104B0lfo081309
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 05:00:47 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 05:00:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 05:00:47 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104B0hxi030137;
        Mon, 4 Jan 2021 05:00:44 -0600
Subject: Re: [PATCH 4/4] PCI: j721e: Add support to provide refclk to PCIe
 connector
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201224115658.2795-1-kishon@ti.com>
 <20201224115658.2795-5-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <da620ca1-d72a-b086-f8a8-f5aede0d4c56@ti.com>
Date:   Mon, 4 Jan 2021 16:30:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201224115658.2795-5-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 24/12/20 5:26 pm, Kishon Vijay Abraham I wrote:
> Add support to provide refclk to PCIe connector.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index dac1ac8a7615..8ec6d9c3e164 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -6,6 +6,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/io.h>
> @@ -50,6 +51,7 @@ enum link_status {
>  
>  struct j721e_pcie {
>  	struct device		*dev;
> +	struct clk		*refclk;
>  	u32			mode;
>  	u32			num_lanes;
>  	struct cdns_pcie	*cdns_pcie;
> @@ -310,6 +312,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	struct cdns_pcie_ep *ep;
>  	struct gpio_desc *gpiod;
>  	void __iomem *base;
> +	struct clk *clk;
>  	u32 num_lanes;
>  	u32 mode;
>  	int ret;
> @@ -408,6 +411,19 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  			goto err_get_sync;
>  		}
>  
> +		clk = devm_clk_get_optional(dev, "pcie_refclk");
> +		if (IS_ERR(clk)) {
> +			dev_err(dev, "failed to get pcie_refclk\n");

missed initializing "ret" here. Will fix this and re-send new version.

Thanks
Kishon
