Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3A72EC3B3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 20:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhAFTIt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 14:08:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbhAFTIs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 14:08:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3C0D2311B;
        Wed,  6 Jan 2021 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609960088;
        bh=zgEf98l2WxjGcgd+9qDl49RJQUpN8/npwqJ4hE++1oA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gxJ4uM1ePzDHX6/+tNDNtFwkUGdg1+pNia9VRrZP9o+CqfZljT4dOquhyepKxoumX
         C+MB/L/CDQIA98TREq+f0OdbavD/LAntGneAgs/e4y2IRERUZUAr5GdXJaSZUDjLc6
         JFHsV7LcPQr0oYfgtXkU/DrHMIG/5neu35cN+f2PJ7Hufx/QdI4etBvqdIt1nDyAmc
         3FeGbbcMCBqdF9EuwjaaSUD06N9jYkLhXr9+pLAbFzaQDDjJe4lU4snTTglixftsPu
         ZouNvBYU18jd/dxSIUHu6gzlglO+S9l4KhjzUKG9mY7z6vR8/7cE7PBjKMow8uBi3E
         mESKPtb6YkrEw==
Date:   Wed, 6 Jan 2021 13:08:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH -next] pci: hotplug: Use DEFINE_SPINLOCK() for spinlock
Message-ID: <20210106190806.GA1327819@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228135038.28401-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 28, 2020 at 09:50:38PM +0800, Zheng Yongjun wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().

See this again:

https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/pci/hotplug/cpqphp_nvram.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp_nvram.c b/drivers/pci/hotplug/cpqphp_nvram.c
> index 00cd2b43364f..7a65d427ac11 100644
> --- a/drivers/pci/hotplug/cpqphp_nvram.c
> +++ b/drivers/pci/hotplug/cpqphp_nvram.c
> @@ -80,7 +80,7 @@ static u8 evbuffer[1024];
>  static void __iomem *compaq_int15_entry_point;
>  
>  /* lock for ordering int15_bios_call() */
> -static spinlock_t int15_lock;
> +static DEFINE_SPINLOCK(int15_lock);
>  
>  
>  /* This is a series of function that deals with
> @@ -415,9 +415,6 @@ void compaq_nvram_init(void __iomem *rom_start)
>  		compaq_int15_entry_point = (rom_start + ROM_INT15_PHY_ADDR - ROM_PHY_ADDR);
>  
>  	dbg("int15 entry  = %p\n", compaq_int15_entry_point);
> -
> -	/* initialize our int15 lock */
> -	spin_lock_init(&int15_lock);
>  }
>  
>  
> -- 
> 2.22.0
> 
