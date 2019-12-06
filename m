Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 723201158D9
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 22:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLFVx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 16:53:59 -0500
Received: from ale.deltatee.com ([207.54.116.67]:53680 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLFVx7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Dec 2019 16:53:59 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1idLXw-0005mw-LK; Fri, 06 Dec 2019 14:53:57 -0700
To:     Armen Baloyan <abaloyan@gigaio.com>, armbaloyan@gmail.com,
        epilmore@gigaio.com, bhelgaas@google.com, linux-pci@vger.kernel.org
References: <1575669165-31697-1-git-send-email-abaloyan@gigaio.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0e8cbd22-f7b3-2927-c5ea-dccbf51178ac@deltatee.com>
Date:   Fri, 6 Dec 2019 14:53:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1575669165-31697-1-git-send-email-abaloyan@gigaio.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, bhelgaas@google.com, epilmore@gigaio.com, armbaloyan@gmail.com, abaloyan@gigaio.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Add Intel SkyLake-E to the whitelist
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-12-06 2:52 p.m., Armen Baloyan wrote:
> Intel SkyLake-E was successfully tested for p2pdma
> transactions spanning over a host bridge and PCI
> bridge with IOMMU on.
> 
> Signed-off-by: Armen Baloyan <abaloyan@gigaio.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

> ---
>  drivers/pci/p2pdma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 79fcb8d8f1b1..9f8e9df8f4ca 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -324,6 +324,9 @@ static const struct pci_p2pdma_whitelist_entry {
>  	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
>  	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
>  	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
> +	/* Intel SkyLake-E. */
> +	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
>  	{}
>  };
>  
> 
