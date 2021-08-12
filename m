Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B268C3EAAB8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 21:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhHLTRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 15:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhHLTRL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 15:17:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3162360EFE;
        Thu, 12 Aug 2021 19:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628795805;
        bh=J5uyPdx+WRfWEYcLFMnAKChnf2yXlxrYuvCB3WS17mY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qKM7x9e839DKYHhoV4KkRvK/36wpXBIDh8j0P6+DBZDMKZMB5Zhrfzbo2QgO8MuP4
         E3yKU8zVtTBVwNI40pcdSI9YzGLfcLMPowpq/1iYx6V2oEmehhMthF1+nXvfmaxOVk
         YGRiMrkpJuVErMgcx9OFHdu9Ns0Zj0ETgekY7A3+g74/4Loi/Mgdz7MplMK4VWfEeN
         hGWRBEYPAZYeptvnmj8QOim0ch/KdTzwSC50C87mPQv7Wqct7LK0Ab/dLVe7fUnUym
         ErKY0oxUwmH/evVgYoFm984+q89+TyM11ZXnMIu38e3xGJ0Dc4TwFrgWR4//+w/P/z
         8NH3h8xV9+y6A==
Date:   Thu, 12 Aug 2021 14:16:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Stephen Bates <sbates@raithlin.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: fix a scheduling in atomic bug
Message-ID: <20210812191643.GA2499987@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812070004.GC31863@kili>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 12, 2021 at 10:00:04AM +0300, Dan Carpenter wrote:
> This function is often called with a spinlock held so the allocation has
> to be atomic.  The call tree is:
> 
> pci_specified_resource_alignment() <-- takes spin_lock();
>  -> pci_dev_str_match()
>     -> pci_dev_str_match_path()
> 
> Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied with Logan's Reviewed-by and Fixes: update to pci/misc for
v5.15, thanks!

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6714c58ce321..71baf5ff48fc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -269,7 +269,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
>  
>  	*endptr = strchrnul(path, ';');
>  
> -	wpath = kmemdup_nul(path, *endptr - path, GFP_KERNEL);
> +	wpath = kmemdup_nul(path, *endptr - path, GFP_ATOMIC);
>  	if (!wpath)
>  		return -ENOMEM;
>  
> -- 
> 2.20.1
> 
