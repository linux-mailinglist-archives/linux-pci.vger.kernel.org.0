Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E89376C07
	for <lists+linux-pci@lfdr.de>; Sat,  8 May 2021 00:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhEGWIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 18:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGWIT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 18:08:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9761961104;
        Fri,  7 May 2021 22:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620425236;
        bh=dfgH+cjku37KYRPxBOOlBSrwJex2J+/wzs8DzOvi/Hg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eVef4mRRvtmcN5u/FaON1rR3yIQZoRAwNP9choLNcoJme05d04IWhkzme0May/1He
         1SWpKPiRa0Fr9UzplHmZLUsri9l9nQJyWV0BIUXSQUs4WOP9Jv7rg88AN9hVPGaKF1
         OHxwlh6alwGWWCVcPhZQxn0QjPqUvvxdYdhSoPjvSauo2A1zFGH3Er6v0AOJsJJG4/
         jI2SBvOPZMBi+Y66mufw+16T3f/Ej90/P4wexSYVBagtBolsD5d/Y4ha/LqFGiuTm7
         LNNcufq06iR6dw3VZAqlbOt1P6UwyOYKfLFj30ecsVnpKtdBPvbD0QyKZURXSlQqsm
         C6c5XQ26K4/wg==
Date:   Fri, 7 May 2021 17:07:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Danijel Slivka <danijel.slivka@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix accessing freed memory in
 pci_remove_resource_files
Message-ID: <20210507220715.GA1545217@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507102706.7658-1-danijel.slivka@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Danijel,

Thanks for the patch.

On Fri, May 07, 2021 at 06:27:06PM +0800, Danijel Slivka wrote:
> This patch fixes segmentation fault during accessing already freed
> pci device resource files, as after freeing res_attr and res_attr_wc
> elements, in pci_remove_resource_files function, they are left as
> dangling pointers.
> 
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>  drivers/pci/pci-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index f8afd54ca3e1..bbdf6c57fcda 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1130,12 +1130,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);
> +			pdev->res_attr[i] = NULL;
>  		}
>  
>  		res_attr = pdev->res_attr_wc[i];
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);
> +			pdev->res_attr_wc[i] = NULL;

If this patch fixes something, I would expect to see a test like this
somewhere:

  if (pdev->res_attr[i])
    pdev->res_attr[i]->size = 0;

But I don't see anything like that, so I can't figure out where we
actually use res_attr[i] or res_attr_wc[i], except in
pci_remove_resource_files() itself.

Did you actually see a segmentation fault?  If so, where?

>  		}
>  	}
>  }
> -- 
> 2.20.1
> 
