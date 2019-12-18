Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23DE125084
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 19:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLRSYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 13:24:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfLRSYQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Dec 2019 13:24:16 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46E3520716;
        Wed, 18 Dec 2019 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576693455;
        bh=xTs4fz9satT0Xu96X1ueuV9XiuG4syoDhNorBGtLyUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tkguOyQ64564f3c37kjCwxua1Ypf6qPJwTI5eLqhIxnBnUH350+bWLCeO+dAtYw1s
         PuRTbEDKIdBue5R2+L7EsiPKE0NcG2YGkSvygj+opL1Ri7TTw+LDlnkRmuRnkVY97c
         4D3/CLBaqMyUG/CpfcwKWy5ya2Ul4h1ccwbPkgHM=
Date:   Wed, 18 Dec 2019 12:24:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     jamessewart@arista.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pci: fix a -Wtype-limits compilation warning
Message-ID: <20191218182412.GA115305@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218170004.5297-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 18, 2019 at 12:00:04PM -0500, Qian Cai wrote:
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

Ugh, that is pretty subtle!  Would you mind if we used "unsigned int"
instead of "u16"?  "u16" makes it look like just a mistake -- somebody
is likely to come along and say devfn only needs "u8" and try to
change it back.  The same might happen with "unsigned int", but at
least it doesn't look like it was chosen specifically to fit a devfn.

Provisional patch below.

> Fixes: a7d06153eea2 ("PCI: Fix pci_add_dma_alias() bitmask size")
> Signed-off-by: Qian Cai <cai@lca.pw>
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
> -- 
> 2.21.0 (Apple Git-122.2)

commit f8bf2aeb651b ("PCI: Fix pci_add_dma_alias() bitmask size")
Author: James Sewart <jamessewart@arista.com>
Date:   Tue Dec 10 15:51:33 2019 -0600

    PCI: Fix pci_add_dma_alias() bitmask size
    
    The number of possible devfns is 256, but pci_add_dma_alias() allocated a
    bitmap of size 255.  Fix this off-by-one error.
    
    This fixes commits 338c3149a221 ("PCI: Add support for multiple DMA
    aliases") and c6635792737b ("PCI: Allocate dma_alias_mask with
    bitmap_zalloc()"), but I doubt it was possible to see a problem because
    it takes 4 64-bit longs (or 8 32-bit longs) to hold 255 bits, and
    bitmap_zalloc() doesn't save the 255-bit size anywhere.
    
    [bhelgaas: commit log, move #define to drivers/pci/pci.h, include loop
    limit fix from Qian Cai:
    https://lore.kernel.org/r/20191218170004.5297-1-cai@lca.pw]
    Signed-off-by: James Sewart <jamessewart@arista.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e87196cc1a7f..7b5fa2eabe09 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6017,7 +6017,7 @@ EXPORT_SYMBOL_GPL(pci_pr3_present);
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
 	if (!dev->dma_alias_mask)
-		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
+		dev->dma_alias_mask = bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
 		pci_warn(dev, "Unable to allocate DMA alias mask\n");
 		return;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a0a53bd05a0b..6394e7746fb5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,9 @@
 
 #include <linux/pci.h>
 
+/* Number of possible devfns: 0.0 to 1f.7 inclusive */
+#define MAX_NR_DEVFNS 256
+
 #define PCI_FIND_CAP_TTL	48
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bade14002fd8..e4dbdef5aef0 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -41,9 +41,9 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	 * DMA, iterate over that too.
 	 */
 	if (unlikely(pdev->dma_alias_mask)) {
-		u8 devfn;
+		unsigned int devfn;
 
-		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
+		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
 			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
 				 data);
 			if (ret)
