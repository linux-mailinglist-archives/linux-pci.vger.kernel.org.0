Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D541DD7F3
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 22:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgEUUGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 16:06:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42484 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgEUUGb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 16:06:31 -0400
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jbrSY-0002rs-3Z; Thu, 21 May 2020 14:06:30 -0600
To:     Krzysztof Wilczynski <kw@linux.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20200521200439.1076672-1-kw@linux.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2a4bbda2-fe1d-de2d-7a0c-b2a718e88a25@deltatee.com>
Date:   Thu, 21 May 2020 14:06:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521200439.1076672-1-kw@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, kw@linux.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/switchtec: Correct bool variable type assignment
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-05-21 2:04 p.m., Krzysztof Wilczynski wrote:
> Use true instead of 1 in the assignment as the variable use_dma_mrpc is
> of a bool type.  Also, resolve the following Coccinelle warning:
> 
>   drivers/pci/switch/switchtec.c:28:12-24: WARNING: Assignment of 0/1 to
>   bool variable
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Sure,

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/pci/switch/switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index e69cac84b605..850cfeb74608 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -25,7 +25,7 @@ static int max_devices = 16;
>  module_param(max_devices, int, 0644);
>  MODULE_PARM_DESC(max_devices, "max number of switchtec device instances");
>  
> -static bool use_dma_mrpc = 1;
> +static bool use_dma_mrpc = true;
>  module_param(use_dma_mrpc, bool, 0644);
>  MODULE_PARM_DESC(use_dma_mrpc,
>  		 "Enable the use of the DMA MRPC feature");
> 
