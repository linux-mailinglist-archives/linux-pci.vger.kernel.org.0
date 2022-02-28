Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88564C62D7
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 07:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiB1GRx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 01:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiB1GRs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 01:17:48 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B23DDF6;
        Sun, 27 Feb 2022 22:17:10 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21S6Gvev118887;
        Mon, 28 Feb 2022 00:16:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646029017;
        bh=RSPhcQ8emCYB2W8uauONFfLJoAk9ctEg/vyS6yYalNU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mb2iAXvfMkkoh7kH6mxMRHOA8KNAQgBney5Y3K+K1ZppEwc1ErQRnCPx9eZHJ1aa5
         S24WGTHQV8n6b+OqrAkSeuLtNjn/vGTFCcu9mscw+crHTn8N2rBmRgkOMlDR2xWZ0j
         qGOchwQVlpuiXwYIzziaV+IIVxPcXWlFNkIUaSFA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21S6GvUs019229
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Feb 2022 00:16:57 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 28
 Feb 2022 00:16:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 28 Feb 2022 00:16:56 -0600
Received: from [10.250.232.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21S6GqAI057462;
        Mon, 28 Feb 2022 00:16:53 -0600
Subject: Re: [PATCH v2] PCI: endpoint: Use blocking notifier instead of atomic
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lorenzo.pieralisi@arm.com>, Vidya Sagar <vidyas@nvidia.com>
CC:     <kw@linux.com>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <dmitry.baryshkov@linaro.org>
References: <20220228055240.24774-1-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e151083b-c15a-7baa-3423-84bd1881105a@ti.com>
Date:   Mon, 28 Feb 2022 11:46:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220228055240.24774-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

On 28/02/22 11:22 am, Manivannan Sadhasivam wrote:
> The use of atomic notifier causes sleeping in atomic context bug when
> the EPC core functions are used in the notifier chain. This is due to the
> use of epc->lock (mutex) in core functions protecting the concurrent use of
> EPC.

The notification from the controller to the function driver is used for
propagating interrupts to function driver and should be in interrupt context.
How it should be handled maybe left to the function driver. I don't prefer
moving everything to blocking notifier.

I'm wondering how other users for CORE_INIT didn't see this issue.

Thanks,
Kishon

> 
> So switch to blocking notifier for getting rid of the bug as it runs in
> non-atomic context and allows sleeping in notifier chain.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> * Removed the changes related to non-upstreamed patches
> 
>  drivers/pci/endpoint/pci-epc-core.c | 6 +++---
>  include/linux/pci-epc.h             | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 3bc9273d0a08..c4347f472618 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -693,7 +693,7 @@ void pci_epc_linkup(struct pci_epc *epc)
>  	if (!epc || IS_ERR(epc))
>  		return;
>  
> -	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> +	blocking_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_linkup);
>  
> @@ -710,7 +710,7 @@ void pci_epc_init_notify(struct pci_epc *epc)
>  	if (!epc || IS_ERR(epc))
>  		return;
>  
> -	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> +	blocking_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_init_notify);
>  
> @@ -774,7 +774,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  
>  	mutex_init(&epc->lock);
>  	INIT_LIST_HEAD(&epc->pci_epf);
> -	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&epc->notifier);
>  
>  	device_initialize(&epc->dev);
>  	epc->dev.class = pci_epc_class;
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index a48778e1a4ee..04a2e74aed63 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -149,7 +149,7 @@ struct pci_epc {
>  	/* mutex to protect against concurrent access of EP controller */
>  	struct mutex			lock;
>  	unsigned long			function_num_map;
> -	struct atomic_notifier_head	notifier;
> +	struct blocking_notifier_head	notifier;
>  };
>  
>  /**
> @@ -195,7 +195,7 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
>  static inline int
>  pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
>  {
> -	return atomic_notifier_chain_register(&epc->notifier, nb);
> +	return blocking_notifier_chain_register(&epc->notifier, nb);
>  }
>  
>  struct pci_epc *
> 
