Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34657D3B7E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 17:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJWPwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjJWPvy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 11:51:54 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A1EFF
        for <linux-pci@vger.kernel.org>; Mon, 23 Oct 2023 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=QO0jPqp/qs2yWDaXi5BBn48i75pk74+sIYVNu39eIWI=; b=rxpc1sWGcK/0KVnixkVIxoUh4D
        zt1jbRdmvX05NlzHlf+4yw6cnDEoYeu91/I6xWIIOqTJ3hoM4kbxltimT+Wsi1+3CjsKRakfpqJtL
        usTSi0pKUmeqjiQzLLeirXu0K+Dh/5sptZhM1M4Gj315Fb+v2zwS88uIup4MK2CRreEnQGvmG4g++
        Vw+nPyeHDjf3dbAqpeUhCx5AI0Afh7IXk6cwVkbwLEgAyQ+2dwJRfmb+oDckqcxTpkf9s/UBy689F
        Ggxlu/SXS9sAqGw/50Rk2E5P9dF7nm2YDTRPp5paWdnfl1pqJYPaD5WaIJMR7ddTxn9GNiLKhQyRv
        jg4b4KIA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1quxDY-004FQC-Fo; Mon, 23 Oct 2023 09:51:49 -0600
Message-ID: <271d092e-36bd-4420-9432-ffa837e3134f@deltatee.com>
Date:   Mon, 23 Oct 2023 09:51:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     Tadeusz Struk <tstruk@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Tadeusz Struk <tstruk@gigaio.com>
References: <20231023084050.55230-1-tstruk@gmail.com>
Content-Language: en-CA
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20231023084050.55230-1-tstruk@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: tstruk@gmail.com, bhelgaas@google.com, linux-pci@vger.kernel.org, tstruk@gigaio.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] p2pdma: remove redundant goto
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-10-23 02:40, Tadeusz Struk wrote:
> Remove redundant goto in pci_alloc_p2pmem()
> 
> Signed-off-by: Tadeusz Struk <tstruk@gmail.com>

Makes sense to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan


> ---
>  drivers/pci/p2pdma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index fa7370f9561a..a7776315996c 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -837,7 +837,6 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
>  	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
>  		gen_pool_free(p2pdma->pool, (unsigned long) ret, size);
>  		ret = NULL;
> -		goto out;
>  	}
>  out:
>  	rcu_read_unlock();
