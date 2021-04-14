Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC2335FCA7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 22:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbhDNU1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 16:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232940AbhDNU1O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Apr 2021 16:27:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 332FA61090;
        Wed, 14 Apr 2021 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618432012;
        bh=+tL5RoPUY0L+AS8fwgMWwYIbyeP9WumdPTZtx6+OaVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rjtCFBiQsFK8cHVxOA+QVwj1EgsfDzZ7acAImmZ+sGbRsSc88oAGYdb/lwRWtclJZ
         ez4qZbimFgknQsiGSFtPYZ7QhXpCqwL6DjHlFjT9Oca1blAW71NitTL6wl+ewOdtr4
         ZEoqgXxqUpBFnOyOXw1t63J+NVCWGFQo97alxMqhupVSe3AFDXkk8Dn3fTuDukRIy2
         eTeBtVk+XBOKrL6zJJhNTrsf9Q2lWG0+3uiqPPBtyKA2SYv8uFReX8pI03Tw4Jqckm
         9uitz38zFCR5SCMziDPpyVfjT0H5oGIVdR/wWVkjRuh9mb9l4Kd2ldpKZS0HbLcAv1
         Z1XNfwWHNIv5A==
Date:   Wed, 14 Apr 2021 15:26:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huang Guobin <huangguobin4@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: Use DEFINE_SPINLOCK() for spinlock
Message-ID: <20210414202650.GA2534339@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617710797-48903-1-git-send-email-huangguobin4@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 08:06:37PM +0800, Huang Guobin wrote:
> From: Guobin Huang <huangguobin4@huawei.com>
> 
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guobin Huang <huangguobin4@huawei.com>

Applied to pci/hotplug for v5.13, thanks!

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
> 
