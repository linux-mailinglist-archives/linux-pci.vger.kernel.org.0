Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD792156118
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2020 23:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGWUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 17:20:39 -0500
Received: from ale.deltatee.com ([207.54.116.67]:35214 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgBGWUj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 17:20:39 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1j0BzJ-0004Bd-Az; Fri, 07 Feb 2020 15:20:38 -0700
To:     Andrew Maier <andrew.maier@eideticom.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200207221219.4309-1-andrew.maier@eideticom.com>
Cc:     Armen Baloyan <abaloyan@gigaio.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a70eb8eb-c584-0a53-07a9-9078b68712e4@deltatee.com>
Date:   Fri, 7 Feb 2020 15:20:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207221219.4309-1-andrew.maier@eideticom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: abaloyan@gigaio.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, andrew.maier@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        SURBL_BLOCKED,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2] PCI/P2PDMA: Add the remaining Intel Sky Lake-E root
 ports to the whitelist
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+cc Armen

On 2020-02-07 3:12 p.m., Andrew Maier wrote:
> Add the three remaining Intel Sky Lake-E host root ports to the
> whitelist of p2pdma.
> 
> P2P has been tested and is working on this system.
> 
> Signed-off-by: Andrew Maier <andrew.maier@eideticom.com>
> ---
> Resending this as I rebased it onto the latest patches.

Right, this is the same machine Armen already sent, so I've CC'd him.

Looks like we're just adding the extra possible root ports from the PCI
IDs database:

2031	Sky Lake-E PCI Express Root Port B	
2032	Sky Lake-E PCI Express Root Port C	
2033	Sky Lake-E PCI Express Root Port D

Makes sense to me, thanks,

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

>  drivers/pci/p2pdma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9a8a38384121..b73b10bce0df 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -291,6 +291,9 @@ static const struct pci_p2pdma_whitelist_entry {
>  	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
>  	/* Intel SkyLake-E */
>  	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2031, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
>  	{}
>  };
> 
