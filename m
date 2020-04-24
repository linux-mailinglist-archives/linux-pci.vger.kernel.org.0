Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3A1B6F50
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 09:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDXHqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 03:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDXHqo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 03:46:44 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C058BC09B045;
        Fri, 24 Apr 2020 00:46:44 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id q204so1928945ooq.1;
        Fri, 24 Apr 2020 00:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4R3wKeI5+ippJFfSS7sqBta6fL7lg0nfBiLFTPymAw=;
        b=lFy+nxlxrdv504P7CDgFedVgTOy9OkkfW4UWhbVzuZSNdwfesb/StBMyroEFPBmc7c
         Y8zuIsohvSBHjYRek3pdipkaQFpr5xEV1kXu5MeWXxN9gdQQUOSEsb3SiDRVQ9cn/vlP
         Eiz5JIQ4UHlMIB2LTVZeFFY0BIaOdtZOgtwq6eQopBenCIGqZnOBpaJHxD9sqMNHGT27
         9efWzDMbAvzf8SKiIGRYFOLwAWvYMSaF10ZOMiMrWmsS7cQPqWITV87Kw+8FabON2tK3
         cEk8JFkzTmJwrSgIYvQM/FtqCyB0mxny/Gnfc2egod1xm019CmQZs7jXSY1cf4XgK9tX
         BnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4R3wKeI5+ippJFfSS7sqBta6fL7lg0nfBiLFTPymAw=;
        b=F9Mur5+5AsZhz0aC0H7CG3Lx9KPyou1dTz7fCO0bf5/2ywDFyhScSZ2LDZAcm9bP/s
         wNbMbaclYDle8Rosg9SUnaNy30hYBlE0SIMZw3j9OJz95qEd6jSzn+jqEYoGky1zbuz4
         hZQBOXnBm9IWtUe4YutOwUemUo+7S5hFVqu6Y9Z1jQTGoKQo+qeZDQnIDT77PTs8sqYH
         s+UwCnPuZkO8EovrG5jx15NWWOBCfWaUn9tHeuhDNphqcaOIzGhGahpsGO4vlYa31qGj
         9gCMnLLkuZ6ZaHBOCEwWr1lb4P+hBP7MFzfuu81wnUXHfqPa4cr0d8LGc96Ul/dh15dj
         YghQ==
X-Gm-Message-State: AGi0PuYeXZdqvb3wXtO5ob6f7UL1Oi5fkfcvPaM7nKq99koiYggp/0KM
        AY714hSYxcnLFGsqFjGC0xlAwi9/vReE6HkvMgA=
X-Google-Smtp-Source: APiQypJa7uzPxioHa3Cmz+0LhwfX3GIdvcU622j3vm4mfr3WiFHJA5GVLsFzvQlQaDKQ6qyK5NRQf7WoiahVMgD53f0=
X-Received: by 2002:a4a:355c:: with SMTP id w28mr6881229oog.18.1587714404059;
 Fri, 24 Apr 2020 00:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587666159-6035-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <99ff8fb8-101c-a548-7d6e-07c3a31ced2c@ti.com>
In-Reply-To: <99ff8fb8-101c-a548-7d6e-07c3a31ced2c@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 24 Apr 2020 08:46:17 +0100
Message-ID: <CA+V-a8sCLm_3hxBT+p_mjSt92rTF3+4nPBuuOdoq==ZKbTK2zg@mail.gmail.com>
Subject: Re: [PATCH v9 5/8] PCI: endpoint: Add support to handle multiple base
 for mapping outbound memory
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

Thank you for the review.

On Fri, Apr 24, 2020 at 7:13 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Prabhakar,
>
> On 4/23/2020 11:52 PM, Lad Prabhakar wrote:
> > R-Car PCIe controller has support to map multiple memory regions for
> > mapping the outbound memory in local system also the controller limits
> > single allocation for each region (that is, once a chunk is used from the
> > region it cannot be used to allocate a new one). This features inspires to
> > add support for handling multiple memory bases in endpoint framework.
> >
> > With this patch pci_epc_mem_init() initializes address space for endpoint
> > controller which support single window and pci_epc_multi_mem_init()
> > initializes multiple windows supported by endpoint controller.
>
> Have a couple of clean-up comments. See below.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  16 +-
> >  drivers/pci/endpoint/pci-epc-mem.c            | 199 ++++++++++++------
> >  include/linux/pci-epc.h                       |  33 ++-
> >  3 files changed, 170 insertions(+), 78 deletions(-)
> >
> .
> .
> <snip>
> .
> .
> > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > index cdd1d3821249..a3466da2a16f 100644
> > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > @@ -23,7 +23,7 @@
> >  static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> >  {
> >       int order;
> > -     unsigned int page_shift = ilog2(mem->page_size);
> > +     unsigned int page_shift = ilog2(mem->window.page_size);
> >
> >       size--;
> >       size >>= page_shift;
> > @@ -36,67 +36,95 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> >  }
> >
> >  /**
> > - * __pci_epc_mem_init() - initialize the pci_epc_mem structure
> > + * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
> >   * @epc: the EPC device that invoked pci_epc_mem_init
> > - * @phys_base: the physical address of the base
> > - * @size: the size of the address space
> > - * @page_size: size of each page
> > + * @windows: pointer to windows supported by the device
> > + * @num_windows: number of windows device supports
> >   *
> >   * Invoke to initialize the pci_epc_mem structure used by the
> >   * endpoint functions to allocate mapped PCI address.
> >   */
> > -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_t size,
> > -                    size_t page_size)
> > +int pci_epc_multi_mem_init(struct pci_epc *epc,
> > +                        struct pci_epc_mem_window *windows,
> > +                        unsigned int num_windows)
> >  {
> > -     int ret;
> > -     struct pci_epc_mem *mem;
> > -     unsigned long *bitmap;
> > +     struct pci_epc_mem *mem = NULL;
> > +     unsigned long *bitmap = NULL;
> >       unsigned int page_shift;
> > -     int pages;
> > +     size_t page_size;
> >       int bitmap_size;
> > +     int pages;
> > +     int ret;
> > +     int i;
> >
> > -     if (page_size < PAGE_SIZE)
> > -             page_size = PAGE_SIZE;
> > +     epc->num_windows = 0;
> >
> > -     page_shift = ilog2(page_size);
> > -     pages = size >> page_shift;
> > -     bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> > +     if (!windows || !num_windows)
> > +             return -EINVAL;
> >
> > -     mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > -     if (!mem) {
> > -             ret = -ENOMEM;
> > -             goto err;
> > -     }
> > +     epc->windows = kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
> > +     if (!epc->windows)
> > +             return -ENOMEM;
> >
> > -     bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > -     if (!bitmap) {
> > -             ret = -ENOMEM;
> > -             goto err_mem;
> > -     }
> > +     for (i = 0; i < num_windows; i++) {
> > +             page_size = windows[i].page_size;
> > +             if (page_size < PAGE_SIZE)
> > +                     page_size = PAGE_SIZE;
> > +             page_shift = ilog2(page_size);
> > +             pages = windows[i].size >> page_shift;
> > +             bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> >
> > -     mem->bitmap = bitmap;
> > -     mem->phys_base = phys_base;
> > -     mem->page_size = page_size;
> > -     mem->pages = pages;
> > -     mem->size = size;
> > -     mutex_init(&mem->lock);
> > +             mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > +             if (!mem) {
> > +                     ret = -ENOMEM;
> > +                     i--;
> > +                     goto err_mem;
> > +             }
> >
> > -     epc->mem = mem;
> > +             bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > +             if (!bitmap) {
> > +                     ret = -ENOMEM;
> > +                     kfree(mem);
> > +                     i--;
> > +                     goto err_mem;
> > +             }
> > +
> > +             mem->window.phys_base = windows[i].phys_base;
> > +             mem->window.size = windows[i].size;
> > +             mem->window.page_size = page_size;
> > +             mem->bitmap = bitmap;
> > +             mem->pages = pages;
> > +             mutex_init(&mem->lock);
> > +             epc->windows[i] = mem;
> > +     }
> > +
> > +     epc->mem = epc->windows[0];
>
> "mem" member of EPC looks unnecessary since that value is available at
> epc->windows[0].
This was suggested by Shimoda-san, as most of the current  controller
drivers support single region this pointer would be easier to access
the region instead of adding #define EPC_DEFAULT_WINDOW  0 and
accessing  as epc->windows[EPC_DEFAULT_WINDOW];

> > +     epc->num_windows = num_windows;
> >
> >       return 0;
> >
> >  err_mem:
> > -     kfree(mem);
> > +     for (; i >= 0; i--) {
> > +             mem = epc->windows[i];
> > +             kfree(mem->bitmap);
> > +             kfree(mem);
> > +     }
> > +     kfree(epc->windows);
> >
> > -err:
> > -return ret;
> > +     return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
> > +EXPORT_SYMBOL_GPL(pci_epc_multi_mem_init);
> >
> >  int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
> >                    size_t size, size_t page_size)
> >  {
> > -     return __pci_epc_mem_init(epc, base, size, page_size);
> > +     struct pci_epc_mem_window mem_window;
> > +
> > +     mem_window.phys_base = base;
> > +     mem_window.size = size;
> > +     mem_window.page_size = page_size;
> > +
> > +     return pci_epc_multi_mem_init(epc, &mem_window, 1);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_init);
> >
> > @@ -109,11 +137,22 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_init);
> >   */
> >  void pci_epc_mem_exit(struct pci_epc *epc)
> >  {
> > -     struct pci_epc_mem *mem = epc->mem;
> > +     struct pci_epc_mem *mem;
> > +     int i;
> >
> > +     if (!epc->num_windows)
> > +             return;
> > +
> > +     for (i = 0; i < epc->num_windows; i++) {
> > +             mem = epc->windows[i];
> > +             kfree(mem->bitmap);
> > +             kfree(mem);
> > +     }
> > +     kfree(epc->windows);
> > +
> > +     epc->windows = NULL;
> >       epc->mem = NULL;
> > -     kfree(mem->bitmap);
> > -     kfree(mem);
> > +     epc->num_windows = 0;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> >
> > @@ -129,31 +168,60 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> >  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> >                                    phys_addr_t *phys_addr, size_t size)
> >  {
> > -     int pageno;
> >       void __iomem *virt_addr = NULL;
> > -     struct pci_epc_mem *mem = epc->mem;
> > -     unsigned int page_shift = ilog2(mem->page_size);
> > +     struct pci_epc_mem *mem;
> > +     unsigned int page_shift;
> > +     size_t align_size;
> > +     int pageno;
> >       int order;
> > +     int i;
> >
> > -     size = ALIGN(size, mem->page_size);
> > -     order = pci_epc_mem_get_order(mem, size);
> > -
> > -     mutex_lock(&mem->lock);
> > -     pageno = bitmap_find_free_region(mem->bitmap, mem->pages, order);
> > -     if (pageno < 0)
> > -             goto ret;
> > +     for (i = 0; i < epc->num_windows; i++) {
> > +             mem = epc->windows[i];
> > +             mutex_lock(&mem->lock);
> > +             align_size = ALIGN(size, mem->window.page_size);
> > +             order = pci_epc_mem_get_order(mem, align_size);
> >
> > -     *phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
> > -     virt_addr = ioremap(*phys_addr, size);
> > -     if (!virt_addr)
> > -             bitmap_release_region(mem->bitmap, pageno, order);
> > +             pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
> > +                                              order);
> > +             if (pageno >= 0) {
> > +                     page_shift = ilog2(mem->window.page_size);
> > +                     *phys_addr = mem->window.phys_base +
> > +                             ((phys_addr_t)pageno << page_shift);
> > +                     virt_addr = ioremap(*phys_addr, align_size);
> > +                     if (!virt_addr) {
> > +                             bitmap_release_region(mem->bitmap,
> > +                                                   pageno, order);
> > +                             mutex_unlock(&mem->lock);
> > +                             continue;
> > +                     }
> > +                     mutex_unlock(&mem->lock);
> > +                     return virt_addr;
> > +             }
> > +             mutex_unlock(&mem->lock);
> > +     }
> >
> > -ret:
> > -     mutex_unlock(&mem->lock);
> >       return virt_addr;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >
> > +struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> > +                                             phys_addr_t phys_addr)
> > +{
> > +     struct pci_epc_mem *mem;
> > +     int i;
> > +
> > +     for (i = 0; i < epc->num_windows; i++) {
> > +             mem = epc->windows[i];
> > +
> > +             if (phys_addr >= mem->window.phys_base &&
> > +                 phys_addr < (mem->window.phys_base + mem->window.size))
> > +                     return mem;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> >  /**
> >   * pci_epc_mem_free_addr() - free the allocated memory address
> >   * @epc: the EPC device on which memory was allocated
> > @@ -166,14 +234,23 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
> >                          void __iomem *virt_addr, size_t size)
> >  {
> > +     struct pci_epc_mem *mem;
> > +     unsigned int page_shift;
> > +     size_t page_size;
> >       int pageno;
> > -     struct pci_epc_mem *mem = epc->mem;
> > -     unsigned int page_shift = ilog2(mem->page_size);
> >       int order;
> >
> > +     mem = pci_epc_get_matching_window(epc, phys_addr);
> > +     if (!mem) {
> > +             pr_err("failed to get matching window\n");
> > +             return;
> > +     }
> > +
> > +     page_size = mem->window.page_size;
> > +     page_shift = ilog2(page_size);
> >       iounmap(virt_addr);
> > -     pageno = (phys_addr - mem->phys_base) >> page_shift;
> > -     size = ALIGN(size, mem->page_size);
> > +     pageno = (phys_addr - mem->window.phys_base) >> page_shift;
> > +     size = ALIGN(size, page_size);
> >       order = pci_epc_mem_get_order(mem, size);
> >       mutex_lock(&mem->lock);
> >       bitmap_release_region(mem->bitmap, pageno, order);
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 5bc1de65849e..cc66bec8be90 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -65,20 +65,28 @@ struct pci_epc_ops {
> >       struct module *owner;
> >  };
> >
> > +/**
> > + * struct pci_epc_mem_window - address window of the endpoint controller
> > + * @phys_base: physical base address of the PCI address window
> > + * @size: the size of the PCI address window
> > + * @page_size: size of each page
> > + */
> > +struct pci_epc_mem_window {
> > +     phys_addr_t     phys_base;
> > +     size_t          size;
> > +     size_t          page_size;
> > +};
> > +
> >  /**
> >   * struct pci_epc_mem - address space of the endpoint controller
> > - * @phys_base: physical base address of the PCI address space
> > - * @size: the size of the PCI address space
> > + * @window: address window of the endpoint controller
> >   * @bitmap: bitmap to manage the PCI address space
> >   * @pages: number of bits representing the address region
> > - * @page_size: size of each page
> >   * @lock: mutex to protect bitmap
> >   */
> >  struct pci_epc_mem {
> > -     phys_addr_t     phys_base;
> > -     size_t          size;
> > +     struct pci_epc_mem_window window;
>
> Don't see any additional value in moving phys_base, size, page_size to a new
> structure and again including it here.
>
Controllers supporting multiple windows create a list of supported
regions (struct pci_epc_mem_window ) and pass a pointer to
pci_epc_multi_mem_init(), hence this split.

Cheers,
--Prabhakar
