Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448A7B155E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 09:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjI1Hwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 03:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjI1Hwe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 03:52:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB38F;
        Thu, 28 Sep 2023 00:52:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S7q3jD043240;
        Thu, 28 Sep 2023 02:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695887523;
        bh=8+LtU1GWGtZKrm76UQzPWGPiwukPzZ3p1SrdAE68OKY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=n8vUYXefbk48fkOKgox4HfoIjPn/so74vwZO0Q3DDjEIWs/uJDWUv63KF8G5ygJyQ
         bsADS/msBoSHMR6WTJrM6I2OXhCPU2A+AbvcCvcU9PwNj/GOtiVfDvKqlGXIvD5J93
         Uz9p0lK47h7/EsdaWYg4wqYg7Trccclwnp3omtJE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S7q3q0083043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Sep 2023 02:52:03 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 02:52:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 02:52:03 -0500
Received: from [172.24.227.83] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S7px6C066514;
        Thu, 28 Sep 2023 02:52:00 -0500
Message-ID: <3f0ba0d6-6027-6f2c-b548-4bbd0f69bc89@ti.com>
Date:   Thu, 28 Sep 2023 13:21:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] PCI: keystone: Fix race condition when initializing
 PHYs
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <ilpo.jarvinen@linux.intel.com>, <vigneshr@ti.com>, <srk@ti.com>
References: <20230927041845.1222080-1-s-vadapalli@ti.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20230927041845.1222080-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/27/23 9:48 AM, Siddharth Vadapalli wrote:
> The PCI driver invokes the PHY APIs using the ks_pcie_enable_phy()
> function. The PHY in this case is the Serdes. It is possible that the
> PCI instance is configured for 2 lane operation across two different
> Serdes instances, using 1 lane of each Serdes. In such a configuration,
> if the reference clock for one Serdes is provided by the other Serdes,
> it results in a race condition. After the Serdes providing the reference
> clock is initialized by the PCI driver by invoking its PHY APIs, it is
> not guaranteed that this Serdes remains powered on long enough for the
> PHY APIs based initialization of the dependent Serdes. In such cases,
> the PLL of the dependent Serdes fails to lock due to the absence of the
> reference clock from the former Serdes which has been powered off by the
> PM Core.
> 
> Fix this by obtaining reference to the PHYs before invoking the PHY
> initialization APIs and releasing reference after the initialization is
> complete.

Sounds reasonable.

Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Ravi
> 
> Fixes: 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> NOTE: This patch is based on linux-next tagged next-20230927.
> 
> v2:
> https://lore.kernel.org/r/20230926063638.1005124-1-s-vadapalli@ti.com/
> 
> Changes since v2:
> - Implement suggestion by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>   moving the phy_pm_runtime_put_sync() For-Loop section before the
>   return value of ks_pcie_enable_phy(ks_pcie) is checked, thereby
>   preventing duplication of the For-Loop.
> - Rebase patch on next-20230927.
> 
> v1:
> https://lore.kernel.org/r/20230926054200.963803-1-s-vadapalli@ti.com/
> 
> Changes since v1:
> - Add code to release reference(s) to the phy(s) when
>   ks_pcie_enable_phy(ks_pcie) fails.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 49aea6ce3e87..0ec6720cc2df 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1218,7 +1218,16 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  		goto err_link;
>  	}
>  
> +	/* Obtain reference(s) to the phy(s) */
> +	for (i = 0; i < num_lanes; i++)
> +		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
> +
>  	ret = ks_pcie_enable_phy(ks_pcie);
> +
> +	/* Release reference(s) to the phy(s) */
> +	for (i = 0; i < num_lanes; i++)
> +		phy_pm_runtime_put_sync(ks_pcie->phy[i]);
> +
>  	if (ret) {
>  		dev_err(dev, "failed to enable phy\n");
>  		goto err_link;

-- 
Regards,
Ravi
