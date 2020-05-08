Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7B1CB4E6
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHQXs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 12:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgEHQXs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 12:23:48 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD56206B8;
        Fri,  8 May 2020 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588955027;
        bh=mNvRgCgp5lj6v/7ha3rMzXotMRBar0BmlAUl4yoXTm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1M8fUwtiv4YcUAhctse798JtD1sXYOtGak8fvjVj7DKC9eoA6+TBI/bwX7JoDYK5u
         cVYzZi9H42Eouwk7Fd1lzhmIjwfMBJ5MkmngCqAr86fih7JJ/RM8UewNX/ivD+pqBa
         q8eBxBVxXQl9S4LDarX0CIpeMWEMMNo35rw39vE8=
Date:   Fri, 8 May 2020 11:23:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: endpoint: use kmemdup_nul() in
 pci_epf_create()
Message-ID: <20200508162345.GA76373@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508121029.167018-1-chenzhou10@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 08, 2020 at 08:10:29PM +0800, Chen Zhou wrote:
> It is more efficient to use kmemdup_nul() if the size is known exactly.
> 
> The doc in kernel:
> "Note: Use kmemdup_nul() instead if the size is known exactly."

If you want to do this, I want to do at least the entire drivers/pci
directory at once so we don't have a bunch of onesy-twosy patches.  It
looks like there's at least one more potential change in
pci_dev_str_match_path().

Also, please mention that the doc is from the kstrndup() function
comment.

> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 244e00f48c5c..f035d2ebcae5 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -252,7 +252,7 @@ struct pci_epf *pci_epf_create(const char *name)
>  		return ERR_PTR(-ENOMEM);
>  
>  	len = strchrnul(name, '.') - name;
> -	epf->name = kstrndup(name, len, GFP_KERNEL);
> +	epf->name = kmemdup_nul(name, len, GFP_KERNEL);
>  	if (!epf->name) {
>  		kfree(epf);
>  		return ERR_PTR(-ENOMEM);
> -- 
> 2.20.1
> 
