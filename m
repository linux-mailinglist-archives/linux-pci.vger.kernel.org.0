Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E573B5BAFFF
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 17:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiIPPNK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIPPNE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 11:13:04 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF949AA35E
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=batTMZSsT6gUBgwcVykA5t6q21mZRUaYnhdtHaOUr0E=; b=UNvcthOB2DGdGnjiBAbrx7TQkX
        obHHD1RAN6sH6pneyEUEZQEGwuA3M3xZgEySn00NNQLPvbSnox7PlJpIwKx9SdVxUPSPKFHd+5F1T
        q4jEYYUmm0ktJ4qz11nHsRQpxgqoSwy/DSvlIZ/36bMsiJvavRJZgNIh31lWvCwo8ukhsfWkFm0hM
        ibksAGoq6qelQVNrRWQWT5ixbMoFuDzr2nM9i0k8D5cXEMe/kDo0seIl6x1bEpKuXo3mJtlXFJZIF
        X55icyzm3AT3UkbVqBrsqndT0C3hkhmck5BP9bdp4/RkpufXIt5yQPuPlfiSZoR5GO91VJezJsyhF
        YyzYmhhw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oZD1W-003Gn9-Sc; Fri, 16 Sep 2022 09:12:59 -0600
Message-ID: <3695796a-31f5-f6ed-48c6-3c24d581db11@deltatee.com>
Date:   Fri, 16 Sep 2022 09:12:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, hch@lst.de
References: <20220916140329.679633-1-yangyingliang@huawei.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220916140329.679633-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: yangyingliang@huawei.com, linux-pci@vger.kernel.org, bhelgaas@google.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH -next] PCI/P2PDMA: Switch to use for_each_pci_dev() helper
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-09-16 08:03, Yang Yingliang wrote:
> Use for_each_pci_dev() instead of open-coding it.
> No functional change.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan

> ---
>  drivers/pci/p2pdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4496a7c5c478..88dc66ee1c46 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -649,7 +649,7 @@ struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients)
>  	if (!closest_pdevs)
>  		return NULL;
>  
> -	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev))) {
> +	for_each_pci_dev(pdev) {
>  		if (!pci_has_p2pmem(pdev))
>  			continue;
>  
