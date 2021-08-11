Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B2F3E94D1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 17:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhHKPoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 11:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhHKPoM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 11:44:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F44C061765
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=HJbEGF0fRNvL1coIUznwprQYc6wm50ZpOqbAL5LqJzU=; b=lQzXQdpLdw6uapbcyjs0QBvux0
        RqMYZdAmwhEB02g8SvbIwXUPx0xcFyflMQpE3vfDbeLTKDJ3/HWwamJzCyOzrdztGVH3l8XxdBy6L
        oCC0Z85gI/TUnX3q2cv6dhOkL7R+2IaYM55sLLeO7h9Q2IQlqv5YAlNyz6Nk+7ZY9h62wyawmClYV
        SCUNAFTSeNSshLdrrDnyCnwwQSaMWDX8Dk9ySFh8MFPD6zBn8s2OhOx7YAxM2K9i1K1T5q8PzLLAn
        EmM4tj4THdUY4TWeqtQZXWWOnHa9WrRMTAeS+qAK5kS5U/6pMwC/NXY/l53Z82vXO5qLghfybV+pt
        PiQzuLDw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDqOO-007bW2-RE; Wed, 11 Aug 2021 15:43:44 +0000
Subject: Re: [PATCH] PCI: vmd: depend on !UML
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-pci@vger.kernel.org
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-um@lists.infradead.org,
        Johannes Berg <johannes.berg@intel.com>
References: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dcd547a5-3ebc-3034-2614-d60000fc1594@infradead.org>
Date:   Wed, 11 Aug 2021 08:43:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/11/21 7:25 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> With UML having enabled (simulated) PCI on UML, VMD breaks
> allyesconfig/allmodconfig compilation because it assumes
> it's running on X86_64 bare metal, and has hardcoded API
> use of ARCH=x86. Make it depend on !UML to fix this.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   drivers/pci/controller/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 64e2f5e379aa..297bbd86806a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -257,7 +257,7 @@ config PCIE_TANGO_SMP8759
>   	  config and MMIO accesses.
>   
>   config VMD
> -	depends on PCI_MSI && X86_64 && SRCU
> +	depends on PCI_MSI && X86_64 && SRCU && !UML
>   	tristate "Intel Volume Management Device Driver"
>   	help
>   	  Adds support for the Intel Volume Management Device (VMD). VMD is a
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

-- 
~Randy

