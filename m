Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F05FB284
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 14:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJKMiW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJKMiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 08:38:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3E08FD78;
        Tue, 11 Oct 2022 05:38:14 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BCbpMs110354;
        Tue, 11 Oct 2022 07:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665491871;
        bh=o0FMuuOqO5sVPoUhe2g+esNGeWnSgMWyctTadE2TlKk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iUXQGYTgJ5VVFl+9wq+mfHnmTxV/6iuUymQ5TvWfIrzefixHLJRvd8/YgThg1E7C/
         ww4DB3RR272QCLhNDdi4HQXtMi4BivN8ePwa09C+4gKMRt/R282aERE6NoBdUrNbE5
         sPmY/nmujC3EveyjK3M4h2+5yvicQfQzhTGZYt+8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BCbprI105978
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 07:37:51 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 07:37:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 07:37:51 -0500
Received: from [172.24.147.145] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BCbl1f108093;
        Tue, 11 Oct 2022 07:37:48 -0500
Subject: Re: [PATCH v3 1/5] PCI: dra7xx: Use threaded IRQ handler for
 "dra7xx-pcie-main" IRQ
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <kishon@kernel.org>, <lpieralisi@kernel.org>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <vidyas@nvidia.com>,
        <vigneshr@ti.com>
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
 <20221006134927.41437-2-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b2cc2e0a-ea18-6e2a-d428-edce03d113b2@ti.com>
Date:   Tue, 11 Oct 2022 18:07:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20221006134927.41437-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 06/10/22 7:19 pm, Manivannan Sadhasivam wrote:
> The "dra7xx-pcie-main" hard IRQ handler is just printing the IRQ status
> and calling the dw_pcie_ep_linkup() API if LINK_UP status is set. But the
> execution of dw_pcie_ep_linkup() depends on the EPF driver and may take
> more time depending on the EPF implementation.
> 
> In general, hard IRQ handlers are supposed to return quickly and not block
> for so long. Moreover, there is no real need of the current IRQ handler to
> be a hard IRQ handler. So switch to the threaded IRQ handler for the
> "dra7xx-pcie-main" IRQ.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/pci/controller/dwc/pci-dra7xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 38462ed11d07..4ae807e7cf79 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -840,7 +840,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>   	}
>   	dra7xx->mode = mode;
>   
> -	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
> +	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
>   			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
>   	if (ret) {
>   		dev_err(dev, "failed to request irq\n");
> 
