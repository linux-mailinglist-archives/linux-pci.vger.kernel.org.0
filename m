Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF325AA5F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 13:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgIBLcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 07:32:15 -0400
Received: from foss.arm.com ([217.140.110.172]:36158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgIBLcP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 07:32:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1AC2101E;
        Wed,  2 Sep 2020 04:32:13 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9C83F66F;
        Wed,  2 Sep 2020 04:32:12 -0700 (PDT)
Date:   Wed, 2 Sep 2020 12:32:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Clint Sbisa <csbisa@amazon.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        benh@kernel.crashing.org
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 31, 2020 at 03:18:27PM +0000, Clint Sbisa wrote:
> Using write-combine is crucial for performance of PCI devices where
> significant amounts of transactions go over PCI BARs.

Write-combine is an x86ism that means nothing on ARM64 platforms
so this should be rewritten to say what you actually mean, namely,
you want to allow prefetchable resources to be mapped with
"write combine" semantics (which means normal non-cacheable
memory on arm64) through proc/sysfs.

This is an outright can of worms and the PCI specs don't help in this
respect, since we may end up mapping resources that have read
side-effects with normal NC mappings (ie that's what "write combine" is
in arm64 - pgprot_writecombine() and that's speculative memory).

I am referring to "Additional Guidance on the Prefetchable Bit
in Memory Space BARs" in the PCI specifications - it does not make
any sense and must be removed because people use it to design
endpoints.

True - this is a problem even in kernel drivers but at least there
the ioremap_ semantics is in the driver and can be vetted.

This patch would make it user space ABI so I am a little nervous
about merging this code TBH.

> arm64 supports write-combine PCI mappings, so the appropriate define
> has been added which will expose write-combine mappings under sysfs
> for prefetchable PCI resources.
> 
> Signed-off-by: Clint Sbisa <csbisa@amazon.com>
> ---
>  arch/arm64/include/asm/pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index 70b323cf8300..b33ca260e3c9 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -17,6 +17,7 @@
>  #define pcibios_assign_all_busses() \
>  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
>  
> +#define arch_can_pci_mmap_wc() 1

I am not comfortable with this blanket enable. Some existing drivers,
eg:

drivers/infiniband/hw/mlx5

use this macro to detect WC capability which again, it is x86 specific,
on arm64 it means nothing and can have consequences on the driver
operations.

Thanks,
Lorenzo

>  #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
>  
>  extern int isa_dma_bridge_buggy;
> -- 
> 2.23.3
> 
