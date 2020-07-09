Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3885821A981
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 23:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGIVFa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 17:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgGIVFa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 17:05:30 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BE2C20672;
        Thu,  9 Jul 2020 21:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594328729;
        bh=yMAOXr1oRk4UKwWtkpx3u9hzj0GthE8WiORwgpF6Z0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nZ+gfclGCmdQDdH60kGOcV2gsQrlKEEopaZ3LEvaFtEiuOJUlyKwXUgVUfGs1OrR8
         b6jL6r+P6hiCRcVwrD3MtnPn+V6zUbZHx9sttXGXjv4NtLbOX5p4O/zKCv3fnzKyp1
         w3fcn0UqBf8+rPNFrfKW/l0he8MwAkHH/3Vau/5M=
Date:   Thu, 9 Jul 2020 16:05:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: Re: [PATCH] PCI: Replace kmalloc with kzalloc in the comment/message
Message-ID: <20200709210527.GA17678@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594279708-34369-1-git-send-email-wang.yi59@zte.com.cn>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 03:28:28PM +0800, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Use kzalloc instead of kmalloc in the comment/message according to
> the previous kzalloc() call.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

I applied the setup-bus.c change to pci/misc for v5.9, thanks!

I dropped the ibmphp_pci.c comment change because (a) it's not clear
the comment is correct even after the change, and (b) that file is so
out-of-date and hard to read that I don't want to touch it unless
we're really fixing something significant.

> ---
>  drivers/pci/hotplug/ibmphp_pci.c | 2 +-
>  drivers/pci/setup-bus.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
> index e22d023..2d36992 100644
> --- a/drivers/pci/hotplug/ibmphp_pci.c
> +++ b/drivers/pci/hotplug/ibmphp_pci.c
> @@ -205,7 +205,7 @@ int ibmphp_configure_card(struct pci_func *func, u8 slotno)
>  								cur_func->next = newfunc;
>  
>  							rc = ibmphp_configure_card(newfunc, slotno);
> -							/* This could only happen if kmalloc failed */
> +							/* This could only happen if kzalloc failed */
>  							if (rc) {
>  								/* We need to do this in case bridge itself got configured properly, but devices behind it failed */
>  								func->bus = 1; /* To indicate to the unconfigure function that this is a PPB */
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index bbcef1a..13c5a44 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -151,7 +151,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>  
>  		tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
>  		if (!tmp)
> -			panic("pdev_sort_resources(): kmalloc() failed!\n");
> +			panic("%s: kzalloc() failed!\n", __func__);
>  		tmp->res = r;
>  		tmp->dev = dev;
>  
> -- 
> 2.9.5
> 
