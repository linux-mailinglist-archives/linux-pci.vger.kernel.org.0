Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF37AE538
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 07:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjIZFtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 01:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZFtV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 01:49:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4968EF0;
        Mon, 25 Sep 2023 22:49:14 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38Q5n6E2114681;
        Tue, 26 Sep 2023 00:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695707346;
        bh=6yM0KH/OFNdiqifrALwi7ox3FMuqovyQ0nkJFVv0Lr0=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=Q2b8L9MOFcrlF75Xa1a1EtNf9skgsw1XySqphZ87qcKyDZRhN344olCXDuncmheos
         gPxkXExDMpJNtb5oP8f19E6nftxpQOisq/vk839pD5+3k2os5bO3W1H1+tk7k75F4N
         ImMMt3d2R4lZ3KCaP6U38LdqaY5YN8CIaehgzlYA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38Q5n6U5118150
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 00:49:06 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 00:49:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 00:49:05 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38Q5n2Op039725;
        Tue, 26 Sep 2023 00:49:02 -0500
Message-ID: <b9909bef-3bc5-b163-5660-ad3b6cbe97b6@ti.com>
Date:   Tue, 26 Sep 2023 11:19:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: keystone: Fix race condition when initializing PHYs
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
References: <20230926054200.963803-1-s-vadapalli@ti.com>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230926054200.963803-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Kindly ignore this patch. The reference to the phy(s) need to be released in the
error path as well which I have missed in this patch. I will address that and
post the v2 patch.

On 26/09/23 11:12, Siddharth Vadapalli wrote:
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
> 
> Fixes: 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 49aea6ce3e87..526b68100a4a 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1218,12 +1218,20 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  		goto err_link;
>  	}
>  
> +	/* Obtain reference(s) to the phy(s) */
> +	for (i = 0; i < num_lanes; i++)
> +		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
> +
>  	ret = ks_pcie_enable_phy(ks_pcie);
>  	if (ret) {
>  		dev_err(dev, "failed to enable phy\n");
>  		goto err_link;
>  	}
>  
> +	/* Release reference(s) to the phy(s) */
> +	for (i = 0; i < num_lanes; i++)
> +		phy_pm_runtime_put_sync(ks_pcie->phy[i]);
> +
>  	platform_set_drvdata(pdev, ks_pcie);
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);

-- 
Regards,
Siddharth.
