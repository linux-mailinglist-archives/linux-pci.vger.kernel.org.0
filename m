Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C113A285
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 09:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgANIKR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 03:10:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40523 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgANIKR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 03:10:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so11765983otj.7;
        Tue, 14 Jan 2020 00:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADoHczfnfwvTHTvwEzQykNkOfVFkdqsmaGJm2GfcQqg=;
        b=EJZy9hG0LMeuJBkesqHDRBgsI1lak03o5EWwTcPsm0XV1Sjy9jZeGHd+x8m9HSLUUu
         kGnImO9rXK+21uKSB0+arziaUPK61JW7/fLPTYI6IBlLAMpa1uDDltoEkaxgngi/Y7fd
         9A+k0su7mh/0T+7fB3mlyf81lFyFel7S1J/YiQAyHgEIWnARtzzmn7Z/E06rvh73IJRr
         9Kn49GH4VsA31yuyv9gIwwI4cu5jzWZNbD6wZwJjk+KC7texmBP2WJHF8SLqcVBOeMje
         3OKg3EKsyxNhvSNukICOYTnjLGYCFI6qKEGNkKrOlPGb5qQ9bygr2jO3cvYxCAn8sXow
         cNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADoHczfnfwvTHTvwEzQykNkOfVFkdqsmaGJm2GfcQqg=;
        b=bZ70+cscHcEhJc7fKPZk1AxB3jkYsXPG/Hve10fVdcZbzBHPgXOtlIZ4iCv5XoqMxT
         2xeKMiYc9tM4QiduykUf1X9CEf61vLiFS9CASUDtWGsRrP+yA5JkBNH23nZk6Rvgd1RJ
         xBRsQydg58r5wBXue55284Bv4DA7JOTrs5J+MQy/IabhThoSknwSPYHLCo7ZPDp3hXXr
         8ka2mldK2OuSnqZw4vc3Bv1p21tOuYqvi90BsuXo7n1uu6qiXN4NCfzuKIAuOMgfNuzM
         XbokTi3TJdvMfaDWN7dBPP7c8Njxl9f7nFejXahNQDHLiQz2ogp4c/RTqRp6rgOJUFjC
         2ozA==
X-Gm-Message-State: APjAAAX/yQPICkRY6k/kM4jva3jxi1Mgolw46QPe0KBwsMrdO5UgOmoo
        EdWxXv/gauqAMLV7+6u7Q7jT8FTOrx8tX/eKItM=
X-Google-Smtp-Source: APXvYqygXu/f7SsTk/IQwbPRIFhQDBJ91FPpJ8e2VaIQ7vAfiBxNzcLSBq8YksHvkEr0WgUlfuhm6rV7ESZA9BHenTw=
X-Received: by 2002:a05:6830:147:: with SMTP id j7mr16417215otp.44.1578989415836;
 Tue, 14 Jan 2020 00:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200108162211.22358-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <53d74632-34ee-f7f7-656f-a93a6c10e7ba@ti.com> <CA+V-a8tHkqkxE_5DMtt6PbJyGz1vfKZUezE5nOFmJXarJAugkw@mail.gmail.com>
 <2b4dd351-76ee-60bd-bd91-20d5f1ac4e79@ti.com>
In-Reply-To: <2b4dd351-76ee-60bd-bd91-20d5f1ac4e79@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 14 Jan 2020 08:09:49 +0000
Message-ID: <CA+V-a8vZUU52f1683Eu2=C_w--mN0Z6mpP38d-9MssRUY0wEpQ@mail.gmail.com>
Subject: Re: [v3 3/6] PCI: endpoint: Add support to handle multiple base for
 mapping outbound memory
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Mon, Jan 13, 2020 at 8:56 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Prabhakar,
>
> On 10/01/20 11:38 PM, Lad, Prabhakar wrote:
> > Hi Kishon,
> >
> > Thank you for the review.
> >
> > On Thu, Jan 9, 2020 at 6:25 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Hi Prabhakar,
> >>
> >> On 08/01/20 9:52 PM, Lad Prabhakar wrote:
> >>> R-Car PCIe controller has support to map multiple memory regions for
> >>> mapping the outbound memory in local system also the controller limits
> >>> single allocation for each region (that is, once a chunk is used from the
> >>> region it cannot be used to allocate a new one). This features inspires to
> >>> add support for handling multiple memory bases in endpoint framework.
> >>>
> >>> With this patch pci_epc_mem_init() now accepts multiple regions, also
> >>> page_size for each memory region is passed during initialization so as
> >>> to handle single allocation for each region by setting the page_size to
> >>> window_size.
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>> ---
> >>>  .../pci/controller/cadence/pcie-cadence-ep.c  |  12 +-
> >>>  .../pci/controller/dwc/pcie-designware-ep.c   |  31 ++-
> >>>  drivers/pci/controller/pcie-rockchip-ep.c     |  14 +-
> >>>  drivers/pci/endpoint/functions/pci-epf-test.c |  29 +--
> >>>  drivers/pci/endpoint/pci-epc-core.c           |   7 +-
> >>>  drivers/pci/endpoint/pci-epc-mem.c            | 199 ++++++++++++++----
> >>>  include/linux/pci-epc.h                       |  46 ++--
> >>>  7 files changed, 245 insertions(+), 93 deletions(-)
> >>>
> >> .
> >> .
> >> <snip>
> >> .
> >> .
> >>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> >>> index 2091508c1620..289c266c2d90 100644
> >>> --- a/drivers/pci/endpoint/pci-epc-core.c
> >>> +++ b/drivers/pci/endpoint/pci-epc-core.c
> >>> @@ -358,13 +358,15 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
> >>>   * @epc: the EPC device on which address is allocated
> >>>   * @func_no: the endpoint function number in the EPC device
> >>>   * @phys_addr: physical address of the local system
> >>> + * @window: index to the window region where PCI address will be mapped
> >>>   * @pci_addr: PCI address to which the physical address should be mapped
> >>>   * @size: the size of the allocation
> >>>   *
> >>>   * Invoke to map CPU address with PCI address.
> >>>   */
> >>>  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
> >>> -                  phys_addr_t phys_addr, u64 pci_addr, size_t size)
> >>> +                  phys_addr_t phys_addr, int window,
> >>> +                  u64 pci_addr, size_t size)
> >>>  {
> >>>       int ret;
> >>>       unsigned long flags;
> >>> @@ -376,7 +378,8 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
> >>>               return 0;
> >>>
> >>>       spin_lock_irqsave(&epc->lock, flags);
> >>> -     ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
> >>> +     ret = epc->ops->map_addr(epc, func_no, phys_addr,
> >>> +                              window, pci_addr, size);
> >>>       spin_unlock_irqrestore(&epc->lock, flags);
> >>>
> >>>       return ret;
> >>> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> >>> index d2b174ce15de..f205f7819292 100644
> >>> --- a/drivers/pci/endpoint/pci-epc-mem.c
> >>> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> >>> @@ -38,57 +38,77 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> >>>  /**
> >>>   * __pci_epc_mem_init() - initialize the pci_epc_mem structure
> >>>   * @epc: the EPC device that invoked pci_epc_mem_init
> >>> - * @phys_base: the physical address of the base
> >>> - * @size: the size of the address space
> >>> - * @page_size: size of each page
> >>> + * @windows: pointer to windows supported by the device
> >>> + * @num_windows: number of windows device supports
> >>>   *
> >>>   * Invoke to initialize the pci_epc_mem structure used by the
> >>>   * endpoint functions to allocate mapped PCI address.
> >>>   */
> >>> -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_t size,
> >>> -                    size_t page_size)
> >>> +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *windows,
> >>> +                    int num_windows)
> >>>  {
> >>> -     int ret;
> >>> -     struct pci_epc_mem *mem;
> >>> -     unsigned long *bitmap;
> >>> +     struct pci_epc_mem *mem = NULL;
> >>> +     unsigned long *bitmap = NULL;
> >>>       unsigned int page_shift;
> >>> -     int pages;
> >>> +     size_t page_size;
> >>>       int bitmap_size;
> >>> +     int pages;
> >>> +     int ret;
> >>> +     int i;
> >>>
> >>> -     if (page_size < PAGE_SIZE)
> >>> -             page_size = PAGE_SIZE;
> >>> +     epc->mem_windows = 0;
> >>>
> >>> -     page_shift = ilog2(page_size);
> >>> -     pages = size >> page_shift;
> >>> -     bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> >>> +     if (!windows)
> >>> +             return -EINVAL;
> >>>
> >>> -     mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> >>> -     if (!mem) {
> >>> -             ret = -ENOMEM;
> >>> -             goto err;
> >>> -     }
> >>> +     if (num_windows <= 0)
> >>> +             return -EINVAL;
> >>>
> >>> -     bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> >>> -     if (!bitmap) {
> >>> -             ret = -ENOMEM;
> >>> -             goto err_mem;
> >>> -     }
> >>> +     epc->mem = kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
> >>> +     if (!epc->mem)
> >>> +             return -EINVAL;
> >>> +
> >>> +     for (i = 0; i < num_windows; i++) {
> >>> +             page_size = windows[i].page_size;
> >>> +             if (page_size < PAGE_SIZE)
> >>> +                     page_size = PAGE_SIZE;
> >>> +             page_shift = ilog2(page_size);
> >>> +             pages = windows[i].size >> page_shift;
> >>> +             bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> >>> +
> >>> +             mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> >>> +             if (!mem) {
> >>> +                     ret = -ENOMEM;
> >>> +                     goto err_mem;
> >>> +             }
> >>>
> >>> -     mem->bitmap = bitmap;
> >>> -     mem->phys_base = phys_base;
> >>> -     mem->page_size = page_size;
> >>> -     mem->pages = pages;
> >>> -     mem->size = size;
> >>> +             bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> >>> +             if (!bitmap) {
> >>> +                     ret = -ENOMEM;
> >>> +                     goto err_mem;
> >>> +             }
> >>>
> >>> -     epc->mem = mem;
> >>> +             mem->bitmap = bitmap;
> >>> +             mem->window.phys_base = windows[i].phys_base;
> >>> +             mem->page_size = page_size;
> >>> +             mem->pages = pages;
> >>> +             mem->window.size = windows[i].size;
> >>> +             mem->window.map_size = 0;
> >>> +
> >>> +             epc->mem[i] = mem;
> >>> +     }
> >>> +     epc->mem_windows = num_windows;
> >>>
> >>>       return 0;
> >>>
> >>>  err_mem:
> >>> -     kfree(mem);
> >>> +     for (; i >= 0; i--) {
> >>
> >> mem has to be reinitialized for every iteration of the loop.
> > not sure what exactly you mean here, could you please elaborate.
>
> You are invoking "kfree(mem->bitmap);" in a loop without re-initializing
> mem. Refer pci_epc_mem_exit() where you are doing the free properly.
>
good catch will fix that.

Cheers,
--Prabhakar

> >
> >>> +             kfree(mem->bitmap);
> >>> +             kfree(epc->mem[i]);
> >>> +     }
> >>> +     kfree(epc->mem);
> >>>
> >>> -err:
> >>> -return ret;
> >>> +     return ret;
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
> >>>
> >>> @@ -101,48 +121,127 @@ EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
> >>>   */
> >>>  void pci_epc_mem_exit(struct pci_epc *epc)
> >>>  {
> >>> -     struct pci_epc_mem *mem = epc->mem;
> >>> +     struct pci_epc_mem *mem;
> >>> +     int i;
> >>> +
> >>> +     if (!epc->mem_windows)
> >>> +             return;
> >>> +
> >>> +     for (i = 0; i <= epc->mem_windows; i++) {
> >>> +             mem = epc->mem[i];
>
> Missing the above line in the error handling above.
>
>
> >>> +             kfree(mem->bitmap);
> >>> +             kfree(epc->mem[i]);
> >>> +     }
>
> Thanks
> Kishon
