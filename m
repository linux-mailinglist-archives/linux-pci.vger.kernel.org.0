Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88647711C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 12:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhLPLw4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 06:52:56 -0500
Received: from mengyan1223.wang ([89.208.246.23]:34498 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230062AbhLPLw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Dec 2021 06:52:56 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2021 06:52:55 EST
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id C8EF966017;
        Thu, 16 Dec 2021 06:44:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1639655054;
        bh=e2cVfczo/NWYtUht5KxKMRgux99OifWmOFSqZcDHraQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h8j4HiuSPpak/mb7Eyxq49DwQVKHPjpPl5bicGMbqeiH4Q3NSN5G9c/NnjsrEBbLD
         2L8layQi7skSL6jlyGNr9dhtvtYkjAckfpdDOhjGefRZW20gTtYgR0Z+gJMsqLzSBJ
         moZzY3B5Dx7aXb8vT315/co9e3/3F+6vx4I79SSfuchW15GG81K6RwnCNNU4jP5kDT
         /eIrgx+JO6wAChK4KZemxGIqp86fyPcdt4FwSWi2ZleCpZlXe2uid3V6VJryDEgXoe
         tg8qT8J8uxNRI8o3x1NefSweHW2IX5lX/VSrS6myWH4Xy1i4byJth278OO+/s5d6o2
         o8zxrErGXUaqA==
Message-ID: <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
Subject: Re: [PATCH v3 5/6] MIPS: implement architecture-specific
 'pci_remap_iospace()'
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Thu, 16 Dec 2021 19:44:06 +0800
In-Reply-To: <20210925203224.10419-6-sergio.paracuellos@gmail.com>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
         <20210925203224.10419-6-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2021-09-25 at 22:32 +0200, Sergio Paracuellos wrote:
> To make PCI IO work we need to properly virtually map IO cpu physical address
> and set this virtual address as the address of the first PCI IO port which
> is set using function 'set_io_port_base()'.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Hi,

the change is causing a WARNING on loongson64g-4core-ls7a:

[    0.105781] loongson-pci 1a000000.pci:       IO 0x0018020000..0x001803ffff ->
 0x0000020000
[    0.105792] loongson-pci 1a000000.pci:      MEM 0x0040000000..0x007fffffff ->
 0x0040000000
[    0.105801] ------------[ cut here ]------------
[    0.105804] WARNING: CPU: 0 PID: 1 at arch/mips/pci/pci-generic.c:55 pci_remap_iospace+0x80/0x88
[    0.105815] resource start address is not zero

I'm not sure how to fix this one.

> ---
>  arch/mips/include/asm/pci.h |  2 ++
>  arch/mips/pci/pci-generic.c | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 9ffc8192adae..35270984a5f0 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -20,6 +20,8 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>  
> +#define pci_remap_iospace pci_remap_iospace
> +
>  #ifdef CONFIG_PCI_DRIVERS_LEGACY
>  
>  /*
> diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
> index 95b00017886c..18eb8a453a86 100644
> --- a/arch/mips/pci/pci-generic.c
> +++ b/arch/mips/pci/pci-generic.c
> @@ -46,3 +46,17 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  {
>         pci_read_bridge_bases(bus);
>  }
> +
> +int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> +{
> +       unsigned long vaddr;
> +
> +       if (res->start != 0) {
> +               WARN_ONCE(1, "resource start address is not zero\n");
> +               return -ENODEV;
> +       }
> +
> +       vaddr = (unsigned long)ioremap(phys_addr, resource_size(res));
> +       set_io_port_base(vaddr);
> +       return 0;
> +}

-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University
