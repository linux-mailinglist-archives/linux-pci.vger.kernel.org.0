Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2261737011A
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 21:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhD3TUD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 15:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhD3TUC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 15:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B90C661449;
        Fri, 30 Apr 2021 19:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619810354;
        bh=gW1gk4ouB0+Hd+er2zV80RviBQHXQw2JTTAJh1fZpqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LP3Jbep1HsS2OXa4Gr2S00fsZedBlGGyYcOimovKj3C7fCPAXsnHrcrSRAS4RvX/Q
         PRY3f7i1XI6Q9YtfqeV4lXn7sHHnzOogChmeUNWZHrHrgZYtSCfsew+wkBgtmZvuoU
         EDknGseFyu3kicyciT9Po84VieTPJ/X9prFPI+5HodI+zdEqcXIxWIlnL7gb2uaPd+
         yZiWTNX0HC11nprM1VOpDhNLVMbQQdtpEnAHYOsWLQelifvr7YxQ0uWKWp9KMPaY6g
         fNh5yI5k5m5GSmjhpuEBtkaPhxfjIsIkjr6Rbz+Sb39iOk27W0QMqnr/3fYfKUUjRr
         TvhmoO2k4tL9Q==
Date:   Fri, 30 Apr 2021 14:19:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Remove unused assignment to variable info
Message-ID: <20210430191912.GA673690@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420210913.1137116-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 20, 2021 at 09:09:13PM +0000, Krzysztof Wilczyński wrote:
> The value returned from the alloc_pci_root_info() function that is
> assigned to the "info" variable within the loop body is never used for
> anything once the loop finishes its run, and it is overridden later
> within another loop body where the value returned from the
> find_pci_root_info() will be assigned to it.
> 
> When the function alloc_pci_root_info() is executed within the body of
> the first loop, it would allocate a new struct pci_root_info and then
> store pointer to it in a global linked list called "pci_root_infos",
> thus the value that the "info" variable would contain after the loop
> finishes would reference the struct pci_root_info that was allocated the
> last, thus it might not necessarily be of use.
> 
> Additionally, the function find_pci_root_info() can be used to find and
> retrieve the relevant pci_root_info stored on the aforementioned linked
> list.
> 
> Since the value of the "info" variable following the first loop is never
> used in any meaningful way the assigned can be removed.
> 
> Related:
>   commit d28e5ac2a07e ("x86/PCI: dynamically allocate pci_root_info for native host bridge drivers")
>   commit a10bb128b64f ("x86/PCI: put busn resource in pci_root_info for native host bridge drivers")
> 
> Addresses-Coverity-ID: 1222153 ("Unused value")
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/misc for v5.13, thanks!

> ---
>  arch/x86/pci/amd_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
> index bfa50e65ef6c..ae744b6a0785 100644
> --- a/arch/x86/pci/amd_bus.c
> +++ b/arch/x86/pci/amd_bus.c
> @@ -126,7 +126,7 @@ static int __init early_root_info_init(void)
>  		node = (reg >> 4) & 0x07;
>  		link = (reg >> 8) & 0x03;
>  
> -		info = alloc_pci_root_info(min_bus, max_bus, node, link);
> +		alloc_pci_root_info(min_bus, max_bus, node, link);
>  	}
>  
>  	/*
> -- 
> 2.31.0
> 
