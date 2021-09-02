Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D433FECAF
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 13:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbhIBLJr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 07:09:47 -0400
Received: from elvis.franken.de ([193.175.24.41]:60887 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhIBLJp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 07:09:45 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mLkaL-0002IW-00; Thu, 02 Sep 2021 13:08:45 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C1C7CC09FF; Thu,  2 Sep 2021 13:08:04 +0200 (CEST)
Date:   Thu, 2 Sep 2021 13:08:04 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] MIPS: ralink: don't define PC_IOBASE but increase
 IO_SPACE_LIMIT
Message-ID: <20210902110804.GA7614@alpha.franken.de>
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
 <20210822161005.22467-2-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822161005.22467-2-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 22, 2021 at 06:10:03PM +0200, Sergio Paracuellos wrote:
> Defining PCI_IOBASE results in pci resource handling working but the
> addresses generated for IO accesses are wrong since the ioremap in the pci core
> function 'pci_parse_request_of_pci_ranges' tries to remap to a fixed virtual
> address (PC_IOBASE) which can't work for KSEG1 addresses. To get it working this
> way, we would need to put PCI_IOBASE somewhere into KSEG2 which will result in
> creating TLB entries for IO addresses, which most of the time isn't needed on
> MIPS because of access via KSEG1. So avoid to define PCI_IOBASE and increase
> IO_SPACE_LIMIT resource for ralink MIPS platform instead, to get valid IO
> addresses for resources from pci core 'pci_address_to_pio' function.
> 
> Fixes: 222b27713d7f ("MIPS: ralink: Define PCI_IOBASE)
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  arch/mips/include/asm/mach-ralink/spaces.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
> index 87d085c9ad61..31a3525213cf 100644
> --- a/arch/mips/include/asm/mach-ralink/spaces.h
> +++ b/arch/mips/include/asm/mach-ralink/spaces.h
> @@ -2,9 +2,7 @@
>  #ifndef __ASM_MACH_RALINK_SPACES_H_
>  #define __ASM_MACH_RALINK_SPACES_H_
>  
> -#define PCI_IOBASE	_AC(0xa0000000, UL)
> -#define PCI_IOSIZE	SZ_16M
> -#define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
> +#define IO_SPACE_LIMIT	0x1fffffff
>  
>  #include <asm/mach-generic/spaces.h>
>  #endif
> -- 
> 2.25.1


Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
