Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD64420291
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 18:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhJCQLX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 12:11:23 -0400
Received: from elvis.franken.de ([193.175.24.41]:57376 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhJCQLW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Oct 2021 12:11:22 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mX43M-0005aq-00; Sun, 03 Oct 2021 18:09:28 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3F223C1D2A; Sun,  3 Oct 2021 18:07:05 +0200 (CEST)
Date:   Sun, 3 Oct 2021 18:07:05 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] Revert "MIPS: ralink: don't define PC_IOBASE but
 increase IO_SPACE_LIMIT"
Message-ID: <20211003160705.GA4984@alpha.franken.de>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <20210925203224.10419-2-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925203224.10419-2-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 25, 2021 at 10:32:19PM +0200, Sergio Paracuellos wrote:
> This reverts commit 159697474db41732ef3b6c2e8d9395f09d1f659e.
> 
> There is no real need to increase IO_SPACE_LIMIT if PCI_IOBASE
> is properly set to 'mips_io_port_base'. Hence revert this commit
> first before doing anything else.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  arch/mips/include/asm/mach-ralink/spaces.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
> index 31a3525213cf..87d085c9ad61 100644
> --- a/arch/mips/include/asm/mach-ralink/spaces.h
> +++ b/arch/mips/include/asm/mach-ralink/spaces.h
> @@ -2,7 +2,9 @@
>  #ifndef __ASM_MACH_RALINK_SPACES_H_
>  #define __ASM_MACH_RALINK_SPACES_H_
>  
> -#define IO_SPACE_LIMIT	0x1fffffff
> +#define PCI_IOBASE	_AC(0xa0000000, UL)
> +#define PCI_IOSIZE	SZ_16M
> +#define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
>  
>  #include <asm/mach-generic/spaces.h>
>  #endif

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
