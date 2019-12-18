Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88B8124F07
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 18:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLRRWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 12:22:34 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43506 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfLRRWe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Dec 2019 12:22:34 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ihd1r-0001vk-SX; Wed, 18 Dec 2019 10:22:32 -0700
To:     Qian Cai <cai@lca.pw>, bhelgaas@google.com
Cc:     jamessewart@arista.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191218170004.5297-1-cai@lca.pw>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c2908ed5-b0a7-74a7-7d03-84ad38e1a95a@deltatee.com>
Date:   Wed, 18 Dec 2019 10:22:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218170004.5297-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, jamessewart@arista.com, bhelgaas@google.com, cai@lca.pw
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH -next] pci: fix a -Wtype-limits compilation warning
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-12-18 10:00 a.m., Qian Cai wrote:
> The commit a7d06153eea2 ("PCI: Fix pci_add_dma_alias() bitmask size")
> introduced a compilation warning and a potential infinite loop because
> it is no longer possible to be self-terminated as u8 is always less than
> 256,
> 
> In file included from ./include/linux/kernel.h:12,
>                  from ./include/asm-generic/bug.h:19,
>                  from ./arch/x86/include/asm/bug.h:83,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/jump_label.h:250,
>                  from ./arch/x86/include/asm/string_64.h:6,
>                  from ./arch/x86/include/asm/string.h:5,
>                  from ./include/linux/string.h:20,
>                  from ./include/linux/uuid.h:12,
>                  from ./include/linux/mod_devicetable.h:13,
>                  from ./include/linux/pci.h:27,
>                  from drivers/pci/search.c:11:
> drivers/pci/search.c: In function 'pci_for_each_dma_alias':
> ./include/linux/bitops.h:30:13: warning: comparison is always true due
> to limited range of data type [-Wtype-limits]
>        (bit) < (size);     \
>              ^
> drivers/pci/search.c:46:3: note: in expansion of macro 'for_each_set_bit'
>    for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
> 
> Fixed it by using u16 for "devfn" in this occasion.
> 
> Fixes: a7d06153eea2 ("PCI: Fix pci_add_dma_alias() bitmask size")
> Signed-off-by: Qian Cai <cai@lca.pw>

Makes sense to me,

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


> ---
>  drivers/pci/search.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 9e4dfae47252..42bc44d0e681 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -41,7 +41,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	 * DMA, iterate over that too.
>  	 */
>  	if (unlikely(pdev->dma_alias_mask)) {
> -		u8 devfn;
> +		u16 devfn;
>  
>  		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
>  			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
> 
