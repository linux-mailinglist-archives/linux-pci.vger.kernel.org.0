Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F225BC4D7
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiISI6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 04:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiISI6s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 04:58:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52094DF38;
        Mon, 19 Sep 2022 01:58:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28J8wbH1117539;
        Mon, 19 Sep 2022 03:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663577917;
        bh=IXLMHWUkQ1/UfxnozwqM7KTDO5eoiFJuWB4vsAMnciQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=yEst9XgETXDujKhnQSzOEbVTK3I5pQrSNY5mZkwMY321CbwpaCVUh1LtCTalLEGtt
         VdhD7i1+Km5tnAZOdiPOboyV2U9pzupy075wKGmcUKFjkr1noD5fcOuJRxbG/t5pVM
         C3sEX2zh+OhiTuVAfeY6soK65+jLj4r9LMsa+u7k=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28J8wbpu099242
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Sep 2022 03:58:37 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 19
 Sep 2022 03:58:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 19 Sep 2022 03:58:37 -0500
Received: from [172.24.147.145] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28J8wYMh125164;
        Mon, 19 Sep 2022 03:58:34 -0500
Message-ID: <04506b2a-dbcb-0bb5-496e-35ccfc9cc18b@ti.com>
Date:   Mon, 19 Sep 2022 14:28:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] PCI: endpoint: Use link_up() callback in place of
 LINK_UP notifier
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>
CC:     <kw@linux.com>, <robh@kernel.org>, <vidyas@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220910090508.61157-1-manivannan.sadhasivam@linaro.org>
 <20220910090508.61157-4-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20220910090508.61157-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,

On 10/09/22 14:35, Manivannan Sadhasivam wrote:
> As a part of the transition towards callback mechanism for signalling the
> events from EPC to EPF, let's use the link_up() callback in the place of
> the LINK_UP notifier. This also removes the notifier support completely
> from the PCI endpoint framework.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 33 ++++++-------------
>  drivers/pci/endpoint/pci-epc-core.c           | 12 +++++--
>  include/linux/pci-epc.h                       |  8 -----
>  include/linux/pci-epf.h                       |  8 ++---
>  4 files changed, 22 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 868de17e1ad2..f75045f2dee3 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -826,30 +826,21 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  	return 0;
>  }
>  
> -static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> -	.core_init = pci_epf_test_core_init,
> -};
> -
> -static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
> -				 void *data)
> +int pci_epf_test_link_up(struct pci_epf *epf)
>  {
> -	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  
> -	switch (val) {
> -	case LINK_UP:
> -		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
> -				   msecs_to_jiffies(1));
> -		break;
> -
> -	default:
> -		dev_err(&epf->dev, "Invalid EPF test notifier event\n");
> -		return NOTIFY_BAD;
> -	}
> +	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
> +			   msecs_to_jiffies(1));
>  
> -	return NOTIFY_OK;
> +	return 0;
>  }
>  
> +static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> +	.core_init = pci_epf_test_core_init,
> +	.link_up = pci_epf_test_link_up,
> +};
> +
>  static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> @@ -976,12 +967,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		epf_test->dma_supported = false;
>  
> -	if (linkup_notifier || core_init_notifier) {
> -		epf->nb.notifier_call = pci_epf_test_notifier;
> -		pci_epc_register_notifier(epc, &epf->nb);
> -	} else {
> +	if (!linkup_notifier && !core_init_notifier)
>  		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
> -	}
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index ba54f17ae06f..5dac1496cf16 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -690,10 +690,19 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
>   */
>  void pci_epc_linkup(struct pci_epc *epc)
>  {
> +	struct pci_epf *epf;
> +
>  	if (!epc || IS_ERR(epc))
>  		return;
>  
> -	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> +	mutex_lock(&epc->list_lock);

This will break pci-dra7xx which invokes pci_epc_linkup() in interrupt
context.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-dra7xx.c#n332

dra7xx_pcie_irq_handler()
	|
	|
	dw_pcie_ep_linkup()
		|
		|
		pci_epc_linkup()
			|
			|
			mutex_lock()

Thanks,
Kishon
