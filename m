Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBE2168F25
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2020 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgBVNcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Feb 2020 08:32:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34317 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgBVNcx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Feb 2020 08:32:53 -0500
Received: by mail-ot1-f68.google.com with SMTP id j16so4699961otl.1;
        Sat, 22 Feb 2020 05:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpWIKWrE1rhe4Lmz27h6MYo1+CytzQ97HcPkl1bbBQg=;
        b=b9oTOFIxxDINmliDvlwBF6mMJOD/6ljgktIYmN/KPkU7WtR4lOb9AFe6EH5HyziLre
         qKMguwRhhKSxg9xCX62l5SYyN/edvqB0MmhNoBvLFZFKPZYvpP9KzCmtk1pc5kmAW3ss
         LACpBh69lUIpEbrevh7RvETKuCunjrjciw/twSHcUMb+XVwSh3vzEToIu2f/vcdgVEeG
         8sc+ue1p08tUUCxhTVOWxF0lGXuX5ed9Zz0loKtpjP413pUVlCh8cf1XMQPJMElrcPRZ
         S6ifvsp3+nyApFoLx1ZYPHkb894aWGh1yrU1JdiK+CUqIDcQ1OQqUr23/ixILIHAB4bp
         GUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpWIKWrE1rhe4Lmz27h6MYo1+CytzQ97HcPkl1bbBQg=;
        b=FkTFnlEo8/ryfLNq6+wn3E2WICmIYdFeGm1iZpygpQo0xAp2Ar93LFbhxZ8pOes2zv
         Xs4Us6u2eTWx4jcKGstgVi5Mj5YdWHpgomtbRzLlvUzIQEdPjvVwEcNCHCGCdE4NsKkx
         TBAoZ+/GcsXCQRRpUf419hiJsQ/Yr+iohbLZQkOgppe3l+7DgmkgwFFWGyh7onrYEFRN
         dkTPo/Y7jv4cUb3bEzHhzT0I3YLnXtY7uqZYjUY6gc+8Weh0w7jrQj5yGYlhBqRhYSCB
         Dez/DlMIM24yn+/+J+tmuKylzIjQRkIsL72Y5qWEUaucVYZn2PtuWLGCGfTGm1Ho4VhY
         uRRQ==
X-Gm-Message-State: APjAAAUP5hwPP0IungF4nJ2UMjuqgCIEle4XtfbUOsh8Y0iQXpBjaPmJ
        oQzbT2ah7AuYm7poo3xT4CHQW3/xQ2KBM8cxLVg=
X-Google-Smtp-Source: APXvYqw4qJFXttjqY+CoS4blxgYb5kARD1LmNjzuInRM7DG6a1EU1Yjhik9ACboL1sc10ti/7w5rzQCjjX2r5eXSlsw=
X-Received: by 2002:a05:6830:154a:: with SMTP id l10mr33157061otp.44.1582378372460;
 Sat, 22 Feb 2020 05:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200208183641.6674-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <ea5fa2ec-3c0c-0343-0b14-9bbfa93feaa3@ti.com>
In-Reply-To: <ea5fa2ec-3c0c-0343-0b14-9bbfa93feaa3@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 22 Feb 2020 13:32:25 +0000
Message-ID: <CA+V-a8u6qOc6LvzenN9XuJi=B_LmYsEJcnrUcwJ1WdJkh1sh7g@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] PCI: endpoint: Add support to handle multiple base
 for mapping outbound memory
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

Thank you for the review.

On Fri, Feb 21, 2020 at 11:36 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Prabhakar,
>
> On 09/02/20 12:06 am, Lad Prabhakar wrote:
> > R-Car PCIe controller has support to map multiple memory regions for
> > mapping the outbound memory in local system also the controller limits
> > single allocation for each region (that is, once a chunk is used from the
> > region it cannot be used to allocate a new one). This features inspires to
> > add support for handling multiple memory bases in endpoint framework.
> >
> > With this patch pci_epc_mem_init() now accepts multiple regions, also
> > page_size for each memory region is passed during initialization so as
> > to handle single allocation for each region by setting the page_size to
> > window_size.
>
> This patch looks much better now except for one comment below..
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-ep.c |   7 +-
> >  drivers/pci/controller/dwc/pcie-designware-ep.c  |  29 ++--
> >  drivers/pci/controller/pcie-rockchip-ep.c        |   7 +-
> >  drivers/pci/endpoint/pci-epc-mem.c               | 166 ++++++++++++++++-------
> >  include/linux/pci-epc.h                          |  39 ++++--
> >  5 files changed, 168 insertions(+), 80 deletions(-)
> >
> .
> .
> <snip>
> .
> .
> > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > index d2b174c..b3eedee 100644
> > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > @@ -38,57 +38,76 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> >  /**
> >   * __pci_epc_mem_init() - initialize the pci_epc_mem structure
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
> > +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *windows,
> > +                    int num_windows)
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
> > -
> > -     if (page_size < PAGE_SIZE)
> > -             page_size = PAGE_SIZE;
> > -
> > -     page_shift = ilog2(page_size);
> > -     pages = size >> page_shift;
> > -     bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> > -
> > -     mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > -     if (!mem) {
> > -             ret = -ENOMEM;
> > -             goto err;
> > -     }
> > -
> > -     bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > -     if (!bitmap) {
> > -             ret = -ENOMEM;
> > -             goto err_mem;
> > +     int pages;
> > +     int ret;
> > +     int i;
> > +
> > +     epc->mem_windows = 0;
> > +
> > +     if (!windows)
> > +             return -EINVAL;
> > +
> > +     if (num_windows <= 0)
> > +             return -EINVAL;
> > +
> > +     epc->mem = kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
> > +     if (!epc->mem)
> > +             return -EINVAL;
> > +
> > +     for (i = 0; i < num_windows; i++) {
> > +             page_size = windows[i].page_size;
> > +             if (page_size < PAGE_SIZE)
> > +                     page_size = PAGE_SIZE;
> > +             page_shift = ilog2(page_size);
> > +             pages = windows[i].size >> page_shift;
> > +             bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> > +
> > +             mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > +             if (!mem) {
> > +                     ret = -ENOMEM;
> > +                     goto err_mem;
> > +             }
> > +
> > +             bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > +             if (!bitmap) {
> > +                     ret = -ENOMEM;
> > +                     goto err_mem;
> > +             }
> > +
> > +             mem->bitmap = bitmap;
> > +             mem->window.phys_base = windows[i].phys_base;
> > +             mem->page_size = page_size;
> > +             mem->pages = pages;
> > +             mem->window.size = windows[i].size;
> > +             epc->mem[i] = mem;
> >       }
> > -
> > -     mem->bitmap = bitmap;
> > -     mem->phys_base = phys_base;
> > -     mem->page_size = page_size;
> > -     mem->pages = pages;
> > -     mem->size = size;
> > -
> > -     epc->mem = mem;
> > +     epc->mem_windows = num_windows;
> >
> >       return 0;
> >
> >  err_mem:
> > -     kfree(mem);
> > +     for (; i >= 0; i--) {
> > +             mem = epc->mem[i];
> > +             kfree(mem->bitmap);
> > +             kfree(mem);
> > +     }
> > +     kfree(epc->mem);
> >
> > -err:
> > -return ret;
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
> >
> > @@ -101,11 +120,21 @@ EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
> >   */
> >  void pci_epc_mem_exit(struct pci_epc *epc)
> >  {
> > -     struct pci_epc_mem *mem = epc->mem;
> > +     struct pci_epc_mem *mem;
> > +     int i;
> > +
> > +     if (!epc->mem_windows)
> > +             return;
> > +
> > +     for (i = 0; i <= epc->mem_windows; i++) {
> > +             mem = epc->mem[i];
> > +             kfree(mem->bitmap);
> > +             kfree(mem);
> > +     }
> > +     kfree(epc->mem);
> >
> >       epc->mem = NULL;
> > -     kfree(mem->bitmap);
> > -     kfree(mem);
> > +     epc->mem_windows = 0;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> >
> > @@ -121,20 +150,30 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> >  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> >                                    phys_addr_t *phys_addr, size_t size)
> >  {
> > -     int pageno;
> > -     void __iomem *virt_addr;
> > -     struct pci_epc_mem *mem = epc->mem;
> > -     unsigned int page_shift = ilog2(mem->page_size);
> > +     void __iomem *virt_addr = NULL;
> > +     struct pci_epc_mem *mem;
> > +     unsigned int page_shift;
> > +     int pageno = -EINVAL;
> >       int order;
> > +     int i;
> >
> > -     size = ALIGN(size, mem->page_size);
> > -     order = pci_epc_mem_get_order(mem, size);
> > +     for (i = 0; i < epc->mem_windows; i++) {
> > +             mem = epc->mem[i];
> > +             size = ALIGN(size, mem->page_size);
> > +             order = pci_epc_mem_get_order(mem, size);
> > +
> > +             pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
> > +                                              order);
> > +             if (pageno >= 0)
> > +                     break;
> > +     }
> >
> > -     pageno = bitmap_find_free_region(mem->bitmap, mem->pages, order);
> >       if (pageno < 0)
> >               return NULL;
> >
> > -     *phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
> > +     page_shift = ilog2(mem->page_size);
> > +     *phys_addr = mem->window.phys_base +
> > +                  ((phys_addr_t)pageno << page_shift);
> >       virt_addr = ioremap(*phys_addr, size);
> >       if (!virt_addr)
> >               bitmap_release_region(mem->bitmap, pageno, order);
> > @@ -143,6 +182,22 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >
> > +struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> > +                                             phys_addr_t phys_addr)
> > +{
> > +     struct pci_epc_mem *mem;
> > +     int i;
> > +
> > +     for (i = 0; i < epc->mem_windows; i++) {
> > +             mem = epc->mem[i];
> > +
> > +             if (mem->window.phys_base == phys_addr)
> > +                     return mem;
>
> This will work only if the phys_addr is same as start of windows base.
> This need not be true for all the platforms and will fail for all the
> allocations except the first allocation.
>
Agreed, this worked for me because different windows were used for allocation.
If you are OK with below changes Ill post a V5 soon.

for (i = 0; i < epc->mem_windows; i++) {
    mem = epc->mem[i];

    if (phys_addr >= mem->window.phys_base &&
        phys_addr < (mem->window.phys_base + mem->window.size))
        return mem;
....
...
}

Cheers,
--Prabhakar Lad

> Thanks
> Kishon
