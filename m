Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07FD2D3661
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 23:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgLHWkS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 17:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgLHWkS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 17:40:18 -0500
Date:   Tue, 8 Dec 2020 16:39:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607467177;
        bh=s4Tp2AuMSwCWrrWKuGICh1cer33TDsIcdnhZ6OEZzcA=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=lZ2UnChpx34jg61wbnOlKZ9IkoZnXwNt6qD4FcGKZz30X2E6pIuuXW7c3nhYp14Qo
         XVleVdYxZzfAxbMvGzwKpFHYg+UFZeJpXGXG6Hr8//NeIicg10NWZtQj9sfS9PxL+0
         Ko9G78HQ6HXFWAvSk1Is2V3tio+TgBhZbf/2EkgG7hYyzC3I8TWCCp+dtLYq6+w4Qk
         t8XZUVsd6L3HFBT37LWinDc0nagKENir3AB7CvsPalwhnJXbEeFHnbNspP1s2pf2T/
         NXLcjweY/qSyCklF5vwrMxCCDnd6jER+ZTI9U/rIWXc4PNGzla8r4tAQWxMl7xANgY
         hko7wM6Jkh24w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Change message to debug level in
 pci_set_cacheline_size
Message-ID: <20201208223936.GA2427660@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1ed3a2-98b9-ee1d-20b8-477f3d93961d@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 08, 2020 at 06:57:02PM +0100, Heiner Kallweit wrote:
> Drivers like ehci_hcd and xhci_hcd use pci_set_mwi() and emit an
> annnoying message like the following that results in user questions
> whether something is broken.
> xhci_hcd 0000:00:15.0: cache line size of 64 is not supported
> 
> Root cause of the message is that on several (most?) chips the
> cache line size register is hard-wired to 0.

Interesting.  Per spec, for PCIe, I think the Cache Line Size is
supposed to be read/write except on virtual functions, where it is RO
Zero (and the example above doesn't look like a VF).  It doesn't *do*
anything for most PCIe devices, but it's still supposed to be
writable.

But it's not completely clear for conventional PCI -- PCI r3.0, sec
6.2.4, says the register "must be implemented by master devices that
can generate the Memory Write and Invalidate command."  So I guess if
a device doesn't support MWI, maybe it doesn't have to be writable.

Applied to pci/misc for v5.11, thanks!

> Change this message to debug level, an interested caller can still
> inform the user (if deemed helpful) based on the return code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b7f0883d6..9a5500287 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4324,7 +4324,7 @@ int pci_set_cacheline_size(struct pci_dev *dev)
>  	if (cacheline_size == pci_cache_line_size)
>  		return 0;
>  
> -	pci_info(dev, "cache line size of %d is not supported\n",
> +	pci_dbg(dev, "cache line size of %d is not supported\n",
>  		   pci_cache_line_size << 2);
>  
>  	return -EINVAL;
> -- 
> 2.29.2
> 
