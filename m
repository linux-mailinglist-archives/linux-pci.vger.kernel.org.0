Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B825C40C401
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhIOKyZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 06:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhIOKyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Sep 2021 06:54:24 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C9C061574;
        Wed, 15 Sep 2021 03:53:06 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id t26so1382571uao.12;
        Wed, 15 Sep 2021 03:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DxLgqizQr0ine5X3cyUxmPBVFhqUQ5aO+j4i2yYfMA=;
        b=FzAc10Z7baOW+UULCNP6NMSylWwsYs1SFqJwalCSa0FZt44X7kxyQvyLyzxCq5uFNA
         CRBiA8oZmxnXN2iFDx13gQEwPnpNlz7oZg5XnZSUnRTFR5objRsyr+rpm9PnoUN8w7xp
         kxICYkm6RgDBcCfVdcPao4yEqC/PT4hbUU8SB3LByiu7UUovu+BQeJUPrWVu6yFY+kWA
         AhOeKuFLQmfXQQgkL7JGuvn4KfXhrdT5SVPUui9Jlh4J0qfwWPyYPCsW9fb7SxAaweSh
         1a7G31CR+z6VThE7fbDuSht86+mqbNZ97Pn7wk0ySHn/M1IwwuxY8zW7OH0I6EB5FDZQ
         Qf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DxLgqizQr0ine5X3cyUxmPBVFhqUQ5aO+j4i2yYfMA=;
        b=ZmZBIAObGkvWSFT8ck5jD1owgURqLrcy4DDwL+GFvgGuvALn7V3R20gRgZp5VsNWk1
         Q0dHE9DcbQvYl0yuT+jeX8sj7a6pjQJd8h2e5sjKirx0tP4grv9ptBWRHPyJ+RN4Ap39
         3wBkiRn+LopgkrifPeHtjxFyYbw4J90ppKXds82/H93ZyOrijwX8I5Q3+hYViWLLVgH4
         4dQfU9Rtho4zMaPXOPm7vl0UWI6HGuQn7z3InH9uvaAUwFh6XiIQyOlSBBhy5KSt5UC7
         suCkHOktoIySf1qQUqk1vIwQZW8YCq6ej7XHrVuAN/fiXpkJ7aETZehxZgZcQuRUZXtO
         gpaw==
X-Gm-Message-State: AOAM532cO/gZ6L4O8LarUZLROLMYhCn74hkimGckP0ChWLMDDTER8crJ
        FD9UsTcO59My9u8eSyUg9g/66NMtzww7UnW3/fFt6CTS
X-Google-Smtp-Source: ABdhPJxZRRtKNZ8EBn0tS7fDnEdUnUqirX17Gf6FaiL2W7nVMhhIIDa8PeLu9TBIagExJgt+PaaNg32YcE4KINP/uL8=
X-Received: by 2002:ab0:72cc:: with SMTP id g12mr7768420uap.98.1631703184983;
 Wed, 15 Sep 2021 03:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com> <20210822161005.22467-3-sergio.paracuellos@gmail.com>
In-Reply-To: <20210822161005.22467-3-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 15 Sep 2021 12:52:53 +0200
Message-ID: <CAMhs-H-JW1aygOtSeWhRO-VYLVZkbj4Nhohj5r31PspjX3oTcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: fix 'pci_remap_iospace' for architectures
 with PCI_IOBASE not defined
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 22, 2021 at 6:10 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Request for I/O resources from device tree call 'pci_remap_iospace' from
> 'devm_pci_remap_iospace' which is also called from device tree function
> 'pci_parse_request_of_pci_ranges'. if PCI_IOBASE is not defined and I/O
> resources are requested the following warning appears:
>
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 1 at ../drivers/pci/pci.c:4066 pci_remap_iospace+0x3c/0x54
> This architecture does not support memory mapped I/O
> Modules linked in:
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.10.1+ #1228
> Stack : 00000000 00000000 807fa974 00000000 827ffa80 80066b48 80710000 0000000b
>         00000000 00000000 81c59aac 7d06ddec 80850000 00000001 81c59a40 7d06ddec
>         00000000 00000000 807c909c 81c598f0 00000001 81c59904 00000000 0000000a
>         203a6d6d 80708880 0000000f 70617773 80850000 00000000 00000000 807d0000
>         807ffecc 1e160000 00000001 00000200 00000000 8054e920 00000008 815e0008
>         ...
> Call Trace:
> [<80008efc>] show_stack+0x8c/0x130
> [<806e1674>] dump_stack+0x9c/0xc8
> [<80024a3c>] __warn+0xc0/0xe8
> [<80024ad0>] warn_slowpath_fmt+0x6c/0xbc
> [<80410ca8>] pci_remap_iospace+0x3c/0x54
> [<80410d20>] devm_pci_remap_iospace+0x58/0xa4
> [<8042019c>] devm_of_pci_bridge_init+0x4dc/0x55c
> [<80408de8>] devm_pci_alloc_host_bridge+0x78/0x88
> [<80424e44>] mt7621_pci_probe+0x68/0x9a4
> [<80464804>] platform_drv_probe+0x40/0x7c
> [<804628bc>] really_probe+0x2fc/0x4e4
> [<80463214>] device_driver_attach+0x4c/0x74
> [<80463384>] __driver_attach+0x148/0x150
> [<8046047c>] bus_for_each_dev+0x6c/0xb0
> [<804614dc>] bus_add_driver+0x1b4/0x1fc
> [<80463aa0>] driver_register+0xd0/0x110
> [<80001714>] do_one_initcall+0x84/0x1c0
> [<808e7fd0>] kernel_init_freeable+0x214/0x24c
> [<806e4164>] kernel_init+0x14/0x118
> [<80003358>] ret_from_kernel_thread+0x14/0x1c
>
> ---[ end trace 1c9d4412bd51b53c ]---
> mt7621-pci 1e140000.pcie: error -19: failed to map resource [io  0x1e160000-0x1e16ffff]
>
> Since there are architectures (like MIPS ralink) that can request I/O
> resources from device tree but have not mapeable I/O space and also PCI_IOBASE
> not defined, avoid this warning and just return zero to make the I/O ranges
> assignment work.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/pci/pci.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Hi Bjorn,

Any comments on this patch? Are you ok with this one also going
through the staging tree like the other two patches in the series?

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aacf575c15cf..10bb2191f376 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4102,9 +4102,9 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
>   * @phys_addr: physical address of range to be mapped
>   *
>   * Remap the memory mapped I/O space described by the @res and the CPU
> - * physical address @phys_addr into virtual address space.  Only
> - * architectures that have memory mapped IO functions defined (and the
> - * PCI_IOBASE value defined) should call this function.
> + * physical address @phys_addr into virtual address space. There
> + * are architectures that don't define PCI_IOBASE but can have not
> + * mapeable IO space. Return zero for those cases.
>   */
>  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>  {
> @@ -4122,10 +4122,10 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>  #else
>         /*
>          * This architecture does not have memory mapped I/O space,
> -        * so this function should never be called
> +        * but can have not mapeable I/O space, so just return ok
> +        * here.
>          */
> -       WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
> -       return -ENODEV;
> +       return 0;
>  #endif
>  }
>  EXPORT_SYMBOL(pci_remap_iospace);
> --
> 2.25.1
>
