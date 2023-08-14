Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E377BE63
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 18:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjHNQwS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjHNQwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 12:52:15 -0400
X-Greylist: delayed 2571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 09:52:13 PDT
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A73BD2
        for <linux-pci@vger.kernel.org>; Mon, 14 Aug 2023 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=9QXxUli/HfvZrh8nreL+5LP1oT4Q98TBa8d8G2NIFhY=; b=P8l7dX8qjLjgu/+i6c681BUsPx
        F8F/ah8ruAN38lg2vO1aRsTAFgsGxuY8WIrSO0/yqL40HRAPVkF/zgAzhIwoQTr29rc4tHVL+7epL
        WFE624IVaIQao5PIXcAdkgJL2XIfsQtTDX/1aUsLI9sznR3ln7ORAy4pZw0bq/DWhNWdtoN+ZOsM7
        d4CVn0Cw4A6tN/seoiR0j6wsG3XXCYYwpNP2aWr1GkN3f8DMuPhHA96XfSxxzwlogeU7chu4iFtag
        hOc+EsjQZIAsd2It/JCqvjcX10aqyIPOBh1RUnZvTI/G0h/iPX0Q/3vDGUr6NeN1NP9/JwtDGf5Bs
        whHquWNQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qVa88-00BDKm-Fi; Mon, 14 Aug 2023 10:09:21 -0600
Message-ID: <135cf02e-9f27-96c3-1c68-2cfbb3a1261e@deltatee.com>
Date:   Mon, 14 Aug 2023 10:09:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-CA
To:     Zheng Zengkai <zhengzengkai@huawei.com>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, wangxiongfeng2@huawei.com
References: <20230811111057.31900-1-zhengzengkai@huawei.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230811111057.31900-1-zhengzengkai@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: zhengzengkai@huawei.com, bhelgaas@google.com, linux-pci@vger.kernel.org, wangxiongfeng2@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH -next] PCI/P2PDMA: Use pci_dev_id() to simplify the code
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-08-11 05:10, Zheng Zengkai wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it manually. Use pci_dev_id() to
> simplify the code a little bit.
> 
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> ---
>  drivers/pci/p2pdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 6cd98ffca198..ec04d0ed157b 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -532,8 +532,7 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b,
>  
>  static unsigned long map_types_idx(struct pci_dev *client)
>  {
> -	return (pci_domain_nr(client->bus) << 16) |
> -		(client->bus->number << 8) | client->devfn;
> +	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
>  }
>  
>  /*

Looks good to me, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
