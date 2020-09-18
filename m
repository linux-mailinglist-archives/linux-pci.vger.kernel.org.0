Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91579270295
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIRQvA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgIRQvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 12:51:00 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39776C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 09:51:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z18so3830734pfg.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i626wvoZabMUjQF03JmQZni3WGRHoiP51qRJmlnUzb0=;
        b=YKmu7ZR3YGw2pkUc7qAyLWNw1ToEY5uahh0b1nu5RQvb8S4pY4wcQ13TxT6CgW+j/R
         oj0K1BKhmkewY/6A75ltzB50km/zgemL/2F/PdATuq6vmOoX6n4qWeIg4UPMgL/pWA9p
         9FYHn/c4Yr9+fcznMotxQqSKu59kwSATZgMMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i626wvoZabMUjQF03JmQZni3WGRHoiP51qRJmlnUzb0=;
        b=I2Lf336IAoLJDKVTIrXcsco9S0ZkTL6dOW6lDYCVTS3MMbEuj0zy3arS5IgEI9mSoo
         KSFWp/nR5GB0D5mN7YsnWWgm283al7ZzV1nEjqz/H/lur0DSmONrbVb0dvVyt8t+gyew
         K1ZxLpc4aD01r2jXU6knm1zIyvSiN69/v4h/Tv9ivLatytJUg4U9UWH3VeCsJLioI4zz
         LcJfPJNfaManrZcuOx1QQ2ptbS15ofgOrcpLT+Vrvz71X6nKoCYX6ZcfxRSPDf+t1bKw
         7Ilio4J26FuWfZQw0fpXa151UqU7F+3V9HvVcs7FDVmnC2ITxs8QdkIJd2ov2/ocJu3M
         56rw==
X-Gm-Message-State: AOAM5329WUslbs42vrZL1ugeI3AbRBizM1aWUuJlZNerNVuRd5SWixJA
        Z9tznWovKc5TSafoJsRBrtSy7A==
X-Google-Smtp-Source: ABdhPJz3HEhhD/ld3oY53TTJk0XHUv+g7pkTSJgO1zGCpQBObxHFfuD8bItjZA2V95MR/YmpiFIoKQ==
X-Received: by 2002:a65:4689:: with SMTP id h9mr27004067pgr.50.1600447859418;
        Fri, 18 Sep 2020 09:50:59 -0700 (PDT)
Received: from [10.136.8.253] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a14sm3274806pju.30.2020.09.18.09.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 09:50:58 -0700 (PDT)
Subject: Re: [PATCH -next] PCI: iproc: use module_bcma_driver to simplify the
 code
To:     Liu Shixin <liushixin2@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200918030829.3946025-1-liushixin2@huawei.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <c990bc93-b5f4-2464-faf2-9b6893fc5dae@broadcom.com>
Date:   Fri, 18 Sep 2020 09:50:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918030829.3946025-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/17/2020 8:08 PM, Liu Shixin wrote:
> module_bcma_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/pci/controller/pcie-iproc-bcma.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
> index aa55b064f64d..56b8ee7bf330 100644
> --- a/drivers/pci/controller/pcie-iproc-bcma.c
> +++ b/drivers/pci/controller/pcie-iproc-bcma.c
> @@ -94,18 +94,7 @@ static struct bcma_driver iproc_pcie_bcma_driver = {
>  	.probe		= iproc_pcie_bcma_probe,
>  	.remove		= iproc_pcie_bcma_remove,
>  };
> -
> -static int __init iproc_pcie_bcma_init(void)
> -{
> -	return bcma_driver_register(&iproc_pcie_bcma_driver);
> -}
> -module_init(iproc_pcie_bcma_init);
> -
> -static void __exit iproc_pcie_bcma_exit(void)
> -{
> -	bcma_driver_unregister(&iproc_pcie_bcma_driver);
> -}
> -module_exit(iproc_pcie_bcma_exit);
> +module_bcma_driver(iproc_pcie_bcma_driver);
>  
>  MODULE_AUTHOR("Hauke Mehrtens");
>  MODULE_DESCRIPTION("Broadcom iProc PCIe BCMA driver");
> 

Looks good to me. Thanks.

Acked-by: Ray Jui <ray.jui@broadcom.com>
