Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44BD755C5C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 09:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGQHE4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 03:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGQHEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 03:04:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13106F0;
        Mon, 17 Jul 2023 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=J3SpWbUvUGuVpILHK2hXPXXEibcgL2uZztFPxd0MnWE=; b=lOFiGkrOfGyoOBFTDPzl7rghfR
        utk51ktw/y3RzZC5CglFkM4pNhozew1T14IkP8BcVH6FBln7ZDthyEazquzLGU3TbF9KBfnLIveF7
        iWHKfvP4FV80m/ctoW8h0CUuNQApLL3Bi9og8wQTVY78coT/JwJlUNd8u3jlYm6evSqaW+0Cor5HH
        c3n0hSb8VywxEY+l/L5WAEE9ozCP5hpCY8GbfZXvr7X4PYepOBTbkMZlaK8idDi1Gx3+QPFrGSi5O
        ANk80nS6/2h0HVQG9i1xJvtjPH02aC9HZoIq4SlLmZvzNxbtlYn2RiTOb1/pFf4zvX2/YUsXc6S1H
        lDPRznZg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qLIHq-003Gpg-0T;
        Mon, 17 Jul 2023 07:04:51 +0000
Message-ID: <87abc308-16a9-014c-20a1-46186d49a259@infradead.org>
Date:   Mon, 17 Jul 2023 00:04:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 7/7] PCI: endpoint: Add kernel-doc for
 pci_epc_mem_init() API
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230717065459.14138-1-manivannan.sadhasivam@linaro.org>
 <20230717065459.14138-8-manivannan.sadhasivam@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230717065459.14138-8-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/16/23 23:54, Manivannan Sadhasivam wrote:
> Add missing kernel-doc for pci_epc_mem_init() API.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/pci/endpoint/pci-epc-mem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index 7dcf6f480b82..a9c028f58da1 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -115,6 +115,16 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_multi_mem_init);
>  
> +/**
> + * pci_epc_mem_init() - Initialize the pci_epc_mem structure
> + * @epc: the EPC device that invoked pci_epc_mem_init
> + * @base: Physical address of the window region
> + * @size: Total Size of the window region
> + * @page_size: Page size of the window region
> + *
> + * Invoke to initialize a single pci_epc_mem structure used by the
> + * endpoint functions to allocate memory for mapping the PCI host memory
> + */
>  int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
>  		     size_t size, size_t page_size)
>  {

-- 
~Randy
