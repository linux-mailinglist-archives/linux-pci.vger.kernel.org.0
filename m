Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F3C5FB28F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 14:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJKMka (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJKMka (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 08:40:30 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E812661;
        Tue, 11 Oct 2022 05:40:29 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BCeCFA110994;
        Tue, 11 Oct 2022 07:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665492012;
        bh=tUmc3Z2gbFC5iJS3cRvN7b8XBwMTR68vu9QqBE9JhyU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wZB23PlwnzNSjFZw4oBh36lhRLWPg2FvHqBwbG3QYdQ74xJItLEns6ZdxmH1gHgXt
         xinUq3BFMS7RLL+vT9cDHNoI6v7lHsXEF7iKmceUH7W+RnuV9bKh4iMa6Bfcv6u35G
         yChn5xf4PIGJoEWn75G46tESzHr22yUk3YAx3MgY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BCeCKN120737
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 07:40:12 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 07:40:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 07:40:12 -0500
Received: from [172.24.147.145] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BCe89E026172;
        Tue, 11 Oct 2022 07:40:09 -0500
Subject: Re: [PATCH v3 3/5] PCI: endpoint: Use a separate lock for protecting
 epc->pci_epf list
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <kishon@kernel.org>, <lpieralisi@kernel.org>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <vidyas@nvidia.com>,
        <vigneshr@ti.com>
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
 <20221006134927.41437-4-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5d041111-6ebc-4ac6-5693-443535545510@ti.com>
Date:   Tue, 11 Oct 2022 18:10:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20221006134927.41437-4-manivannan.sadhasivam@linaro.org>
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
> The EPC controller maintains a list of EPF drivers added to it. For
> protecting this list against the concurrent accesses, the epc->lock
> (used for protecting epc_ops) has been used so far. Since there were
> no users trying to use epc_ops and modify the pci_epf list simultaneously,
> this was not an issue.
> 
> But with the addition of callback mechanism for passing the events, this
> will be a problem. Because the pci_epf list needs to be iterated first
> for getting hold of the EPF driver and then the relevant event specific
> callback needs to be called for the driver.
> 
> If the same epc->lock is used, then it will result in a deadlock scenario.
> 
> For instance,
> 
> ...
> 	mutex_lock(&epc->lock);
> 	list_for_each_entry(epf, &epc->pci_epf, list) {
> 		epf->event_ops->core_init(epf);
> 		|
> 		|-> pci_epc_set_bar();
> 			|
> 			|-> mutex_lock(&epc->lock) # DEADLOCK
> ...
> 
> So to fix this issue, use a separate lock called "list_lock" for
> protecting the pci_epf list against the concurrent accesses. This lock
> will also be used by the callback mechanism.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/pci/endpoint/pci-epc-core.c | 9 +++++----
>   include/linux/pci-epc.h             | 2 ++
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 3bc9273d0a08..6cce430d431b 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -613,7 +613,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
>   	if (type == SECONDARY_INTERFACE && epf->sec_epc)
>   		return -EBUSY;
>   
> -	mutex_lock(&epc->lock);
> +	mutex_lock(&epc->list_lock);
>   	func_no = find_first_zero_bit(&epc->function_num_map,
>   				      BITS_PER_LONG);
>   	if (func_no >= BITS_PER_LONG) {
> @@ -640,7 +640,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
>   
>   	list_add_tail(list, &epc->pci_epf);
>   ret:
> -	mutex_unlock(&epc->lock);
> +	mutex_unlock(&epc->list_lock);
>   
>   	return ret;
>   }
> @@ -672,11 +672,11 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
>   		list = &epf->sec_epc_list;
>   	}
>   
> -	mutex_lock(&epc->lock);
> +	mutex_lock(&epc->list_lock);
>   	clear_bit(func_no, &epc->function_num_map);
>   	list_del(list);
>   	epf->epc = NULL;
> -	mutex_unlock(&epc->lock);
> +	mutex_unlock(&epc->list_lock);
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
>   
> @@ -773,6 +773,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>   	}
>   
>   	mutex_init(&epc->lock);
> +	mutex_init(&epc->list_lock);
>   	INIT_LIST_HEAD(&epc->pci_epf);
>   	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
>   
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index a48778e1a4ee..fe729dfe509b 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -122,6 +122,7 @@ struct pci_epc_mem {
>    * struct pci_epc - represents the PCI EPC device
>    * @dev: PCI EPC device
>    * @pci_epf: list of endpoint functions present in this EPC device
> + * list_lock: Mutex for protecting pci_epf list
>    * @ops: function pointers for performing endpoint operations
>    * @windows: array of address space of the endpoint controller
>    * @mem: first window of the endpoint controller, which corresponds to
> @@ -139,6 +140,7 @@ struct pci_epc_mem {
>   struct pci_epc {
>   	struct device			dev;
>   	struct list_head		pci_epf;
> +	struct mutex			list_lock;
>   	const struct pci_epc_ops	*ops;
>   	struct pci_epc_mem		**windows;
>   	struct pci_epc_mem		*mem;
> 
