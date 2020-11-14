Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE72B3112
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 22:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgKNVxd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Nov 2020 16:53:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNVxc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Nov 2020 16:53:32 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134B7222C4;
        Sat, 14 Nov 2020 21:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605390811;
        bh=WdC99Ui7j78TQnjRKV46T0si0K88h60EbmiXZrTtfqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DQ894+DXIkElALKvr/Wo3J8IJFzLm8ZL/N/VlrXTg+Bgmk1su4AYNWiP1m74RViU9
         CHgV2hCGqz2NKvjNL72SQAQXMiQMaQ+sU5eu38E7YOFZXaXksK29BTwPF1zK7mLPQL
         jwVABdx73y0v9PdVATI6pVxbqBZeOB1VkQ1vcE8Q=
Date:   Sat, 14 Nov 2020 15:53:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH][V2] PCI: Fix a potential uninitentional integer overflow
 issue
Message-ID: <20201114215329.GA1197070@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110221048.3411288-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Dan]

On Tue, Nov 10, 2020 at 10:10:48PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The shift of 1 by align_order is evaluated using 32 bit arithmetic
> and the result is assigned to a resource_size_t type variable that
> is a 64 bit unsigned integer on 64 bit platforms. Fix an overflow
> before widening issue by making the 1 a ULL.
> 
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to pci/misc for v5.11 with Logan's Reviewed-by and also the
Fixes: correction.

I first applied the patch below to bounds-check the alignment as noted
by Dan.

> ---
> 
> V2: Use ULL instead of BIT_ULL(), fix spelling mistake and capitalize first
>     word of patch subject.
> 
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3ef63a101fa1..248044a7ef8c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6214,7 +6214,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  			if (align_order == -1)
>  				align = PAGE_SIZE;
>  			else
> -				align = 1 << align_order;
> +				align = 1ULL << align_order;
>  			break;
>  		} else if (ret < 0) {
>  			pr_err("PCI: Can't parse resource_alignment parameter: %s\n",

commit d6ca242c448f ("PCI: Bounds-check command-line resource alignment requests")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Nov 5 14:51:36 2020 -0600

    PCI: Bounds-check command-line resource alignment requests
    
    32-bit BARs are limited to 2GB size (2^31).  By extension, I assume 64-bit
    BARs are limited to 2^63 bytes.  Limit the alignment requested by the
    "pci=resource_alignment=" command-line parameter to 2^63.
    
    Link: https://lore.kernel.org/r/20201007123045.GS4282@kadam
    Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8b9bea8ba751..26c1b2d0bacd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6197,19 +6197,21 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	while (*p) {
 		count = 0;
 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
-							p[count] == '@') {
+		    p[count] == '@') {
 			p += count + 1;
+			if (align_order > 63) {
+				pr_err("PCI: Invalid requested alignment (order %d)\n",
+				       align_order);
+				align_order = PAGE_SHIFT;
+			}
 		} else {
-			align_order = -1;
+			align_order = PAGE_SHIFT;
 		}
 
 		ret = pci_dev_str_match(dev, p, &p);
 		if (ret == 1) {
 			*resize = true;
-			if (align_order == -1)
-				align = PAGE_SIZE;
-			else
-				align = 1 << align_order;
+			align = 1 << align_order;
 			break;
 		} else if (ret < 0) {
 			pr_err("PCI: Can't parse resource_alignment parameter: %s\n",
