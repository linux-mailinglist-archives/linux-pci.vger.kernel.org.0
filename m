Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC531250AC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLRSbS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 13:31:18 -0500
Received: from ale.deltatee.com ([207.54.116.67]:44468 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfLRSbS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Dec 2019 13:31:18 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ihe6O-0003JU-1c; Wed, 18 Dec 2019 11:31:17 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>, Qian Cai <cai@lca.pw>
Cc:     jamessewart@arista.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191218182412.GA115305@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <211e2c94-0be1-d17f-944a-b557463b6d06@deltatee.com>
Date:   Wed, 18 Dec 2019 11:31:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218182412.GA115305@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, jamessewart@arista.com, cai@lca.pw, helgaas@kernel.org
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



On 2019-12-18 11:24 a.m., Bjorn Helgaas wrote:
> On Wed, Dec 18, 2019 at 12:00:04PM -0500, Qian Cai wrote:
>> The commit a7d06153eea2 ("PCI: Fix pci_add_dma_alias() bitmask size")
>> introduced a compilation warning and a potential infinite loop because
>> it is no longer possible to be self-terminated as u8 is always less than
>> 256,
>>
>> In file included from ./include/linux/kernel.h:12,
>>                  from ./include/asm-generic/bug.h:19,
>>                  from ./arch/x86/include/asm/bug.h:83,
>>                  from ./include/linux/bug.h:5,
>>                  from ./include/linux/jump_label.h:250,
>>                  from ./arch/x86/include/asm/string_64.h:6,
>>                  from ./arch/x86/include/asm/string.h:5,
>>                  from ./include/linux/string.h:20,
>>                  from ./include/linux/uuid.h:12,
>>                  from ./include/linux/mod_devicetable.h:13,
>>                  from ./include/linux/pci.h:27,
>>                  from drivers/pci/search.c:11:
>> drivers/pci/search.c: In function 'pci_for_each_dma_alias':
>> ./include/linux/bitops.h:30:13: warning: comparison is always true due
>> to limited range of data type [-Wtype-limits]
>>        (bit) < (size);     \
>>              ^
>> drivers/pci/search.c:46:3: note: in expansion of macro 'for_each_set_bit'
>>    for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
>>
>> Fixed it by using u16 for "devfn" in this occasion.
> 
> Ugh, that is pretty subtle!  Would you mind if we used "unsigned int"
> instead of "u16"?  "u16" makes it look like just a mistake -- somebody
> is likely to come along and say devfn only needs "u8" and try to
> change it back.  The same might happen with "unsigned int", but at
> least it doesn't look like it was chosen specifically to fit a devfn.

I agree: you're right that we really don't need an int that's
specifically sized here. There's really shouldn't be any gain in using a
smaller integer, in theory "int" should be the most "efficient" anyway,
just using a full register in hardware.

Logan

> Provisional patch below.
> 
>> Fixes: a7d06153eea2 ("PCI: Fix pci_add_dma_alias() bitmask size")
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>>  drivers/pci/search.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
>> index 9e4dfae47252..42bc44d0e681 100644
>> --- a/drivers/pci/search.c
>> +++ b/drivers/pci/search.c
>> @@ -41,7 +41,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>>  	 * DMA, iterate over that too.
>>  	 */
>>  	if (unlikely(pdev->dma_alias_mask)) {
>> -		u8 devfn;
>> +		u16 devfn;
>>  
>>  		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
>>  			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
>> -- 
>> 2.21.0 (Apple Git-122.2)
> 
> commit f8bf2aeb651b ("PCI: Fix pci_add_dma_alias() bitmask size")
> Author: James Sewart <jamessewart@arista.com>
> Date:   Tue Dec 10 15:51:33 2019 -0600
> 
>     PCI: Fix pci_add_dma_alias() bitmask size
>     
>     The number of possible devfns is 256, but pci_add_dma_alias() allocated a
>     bitmap of size 255.  Fix this off-by-one error.
>     
>     This fixes commits 338c3149a221 ("PCI: Add support for multiple DMA
>     aliases") and c6635792737b ("PCI: Allocate dma_alias_mask with
>     bitmap_zalloc()"), but I doubt it was possible to see a problem because
>     it takes 4 64-bit longs (or 8 32-bit longs) to hold 255 bits, and
>     bitmap_zalloc() doesn't save the 255-bit size anywhere.
>     
>     [bhelgaas: commit log, move #define to drivers/pci/pci.h, include loop
>     limit fix from Qian Cai:
>     https://lore.kernel.org/r/20191218170004.5297-1-cai@lca.pw]
>     Signed-off-by: James Sewart <jamessewart@arista.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e87196cc1a7f..7b5fa2eabe09 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6017,7 +6017,7 @@ EXPORT_SYMBOL_GPL(pci_pr3_present);
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
>  	if (!dev->dma_alias_mask)
> -		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
> +		dev->dma_alias_mask = bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
>  	if (!dev->dma_alias_mask) {
>  		pci_warn(dev, "Unable to allocate DMA alias mask\n");
>  		return;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a0a53bd05a0b..6394e7746fb5 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -4,6 +4,9 @@
>  
>  #include <linux/pci.h>
>  
> +/* Number of possible devfns: 0.0 to 1f.7 inclusive */
> +#define MAX_NR_DEVFNS 256
> +
>  #define PCI_FIND_CAP_TTL	48
>  
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index bade14002fd8..e4dbdef5aef0 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -41,9 +41,9 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	 * DMA, iterate over that too.
>  	 */
>  	if (unlikely(pdev->dma_alias_mask)) {
> -		u8 devfn;
> +		unsigned int devfn;
>  
> -		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
> +		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
>  			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
>  				 data);
>  			if (ret)
> 
