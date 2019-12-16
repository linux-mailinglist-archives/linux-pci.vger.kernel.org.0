Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD27511FF9E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 09:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLPIWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 03:22:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46623 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfLPIWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Dec 2019 03:22:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id g18so8079509otj.13;
        Mon, 16 Dec 2019 00:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2zr+SxGgQJRKPjCI0ZlCNLHKl8Hq+JbhUCM9tDaYbk=;
        b=duCNJEibi83CQtLO3lJy8ZeTakoP8uvN3rYY/wkMtOGdcEAoS3hikmezHKWm0CA5Pm
         9dL0Oz8Qoh2fSfXuethC2UUonF9dhfVvzIhos/7OF5APUXaGD+ozKlWRvy5oN71OKV97
         O9chmuVrwmzS6M/f8BQsn6RDt+beAkjXHGQHMEqlTRiRl7F4YpovwtXu3z01fBv9t/JU
         m1RwuykieOwvhYNmnGjevq6+CmQSVn9QW96K+HLJbb3UkIfaKwPx/jivTNNGnMj89B0I
         oZ7BHnvjJJS4ZrWzDkrsyxIX+gEODf8o+n/a9w5+NEi4szuQ5RjtJHNummuyoNBNNIDb
         /spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2zr+SxGgQJRKPjCI0ZlCNLHKl8Hq+JbhUCM9tDaYbk=;
        b=KGnonN9UZE3RiRnYo67kXkumhqBtpQ2tOElH3qEcFYfHIy09sRoTtQJbZlk76Ponor
         78DavZiQ1uk12M/siczGyySH/V9LXSsV+2MGMeWHjHVX5mMzeYK+77JGGWXifzZObD3o
         ZaTYA1mFh2d+g3ds2nOY3ebH0AADElBKoV2b+QHzHAjru0tkZkXyJ3krtBTfhUQHd/5k
         CmJZNFJLyUJcKLMuv5C8mEb5Gi2RR4JUVXE8UUmIFV2/K5K1EbwPmWxMYBQHvV6ky7l+
         mjUOpwmJciJkHEpG0yhpX1cb23dSOkSHKvwCTSU07pqzQZJ0ZKspLeLj2Ev/khA4Y9zx
         gHxQ==
X-Gm-Message-State: APjAAAXJHXQNc4kNfis/AjL5nNYNYRe1NdoYKeMuoSRSnnit8REyJib4
        WZmU8QkGQnwX6ilb4aGLJskcMCIQQo25s87TC20=
X-Google-Smtp-Source: APXvYqxQ2QA/IJOqMGi2skPvLoXCAHWfqvnNsrhuIWnq8ZJXE69aNr5mcARZx/rneXf34MbVxtEMNdjkpDEu0iV67GE=
X-Received: by 2002:a05:6830:147:: with SMTP id j7mr14990640otp.44.1576484518648;
 Mon, 16 Dec 2019 00:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <20191213195727.GA170874@google.com>
In-Reply-To: <20191213195727.GA170874@google.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 16 Dec 2019 08:21:31 +0000
Message-ID: <CA+V-a8saLrvuTiQWaSGK9j6BA=waOSAwNdm_2Ae-EpMKOq-73A@mail.gmail.com>
Subject: Re: [v2 2/6] pci: endpoint: add support to handle features of
 outbound memory
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
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
        linux-rockchip@lists.infradead.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

thank you for the review.

On Fri, Dec 13, 2019 at 9:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Dec 13, 2019 at 08:47:44AM +0000, Lad Prabhakar wrote:
> > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > rcar pcie controller has support to map multiple memory regions
> > for mapping the outbound memory in local system, this feature
> > inspires to add support for handling such features in endpoint
> > framework. similar features exists on other controllers where
> > outbound regions can be specifically used for low/high priority
> > transactions, and regions can be flagged and used for allocation
> > of large/small memory allocations.
> > This patch adds support to handle such features, where the
> > properties described for outbound regions are used whenever a
> > request to memory is made.
>
> For this and the other patches, please:
>
>   - start sentences with a capital letter
>   - leave a blank line between paragraphs
>   - wrap commit log text to use the whole 80 character line (I wrap to
>     75 characters to account for "git log" indenting by 4 spaces)
>   - check your signed-off-by: it shows your name as "Lad, Prabhakar",
>     while your email From: line shows "Lad Prabhakar".  Choose one :)
>
sure will fix it next version.

> > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > index 2bf8bd1..4b610cd 100644
> > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > +++ b/drivers/pci/endpoint/pci-epc-mem.c
>
> > -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_t size,
> > -                    size_t page_size)
> > +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *windows,
> > +                    int num_windows, size_t page_size)
> >  {
> > -     int ret;
> > -     struct pci_epc_mem *mem;
> > -     unsigned long *bitmap;
> > +     struct pci_epc_mem *mem = NULL;
> > +     unsigned long *bitmap = NULL;
> >       unsigned int page_shift;
> > -     int pages;
> >       int bitmap_size;
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
>
> Why is num_windows signed?
>
> >  void pci_epc_mem_exit(struct pci_epc *epc)
> >  {
> > -     struct pci_epc_mem *mem = epc->mem;
> > +     struct pci_epc_mem *mem;
> > +     int i;
> > +
> > +     if (!epc->mem_windows)
> > +             return;
>
> If you fix the loop below, why do you even need to test this?
>
yes makes sense will drop this check.

> > +     for (i = 0; i <= epc->mem_windows; i--) {
>
> Huh?  "<="?  "i--"?  Surely you mean
>
>         for (i = 0; i < epc->mem_windows; i++) {
>
oops my bad, will fix it.

> > +             mem = epc->mem[i];
> > +             kfree(mem->bitmap);
> > +             kfree(epc->mem[i]);
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
> > +static int pci_epc_find_best_fit_window(struct pci_epc *epc, size_t size,
> > +                                     u32 flags)
>
> Can this just return a struct pci_epc_mem *, so the caller doesn't
> have to lookup epc->mem[i] again?
>
yes makes sense will change it to return struct pci_epc_mem *

> > +{
> > +     size_t window_least_size = 0;
> > +     int best_fit_window = -1;
> > +     struct pci_epc_mem *mem;
> > +     size_t actual_size;
> > +     size_t avail_size;
> > +     u32 win_flags;
> > +     int i;
> > +
> > +     for (i = 0; i < epc->mem_windows; i++) {
> > +             mem = epc->mem[i];
> > +             win_flags = mem->window.flags;
> > +
> > +             actual_size = ALIGN(size, mem->page_size);
> > +             avail_size = mem->window.size - mem->window.map_size;
> > +
> > +             if (win_flags == 0x0) {
> > +                     if (best_fit_window == -1) {
> > +                             if (actual_size <= avail_size) {
> > +                                     best_fit_window = i;
> > +                                     window_least_size = mem->window.size;
> > +                             }
> > +                     } else {
> > +                             if (actual_size <= avail_size &&
> > +                                 mem->window.size < window_least_size) {
> > +                                     best_fit_window = i;
> > +                                     window_least_size = mem->window.size;
> > +                             }
> > +                     }
> > +             } else {
> > +                     if (mem->window.map_size &&
> > +                         (win_flags | PCI_EPC_WINDOW_FLAG_NON_MULTI_ALLOC))
> > +                             continue;
> > +
> > +                     if (!(win_flags | flags))
> > +                             continue;
> > +
> > +                     if (best_fit_window == -1) {
> > +                             if (actual_size <= avail_size) {
> > +                                     best_fit_window = i;
> > +                                     window_least_size = mem->window.size;
> > +                             }
> > +                     } else {
> > +                             if (actual_size <= avail_size &&
> > +                                 mem->window.size < window_least_size) {
> > +                                     best_fit_window = i;
> > +                                     window_least_size = mem->window.size;
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +
> > +     return best_fit_window;
> > +}
> > +
> >  /**
> >   * pci_epc_mem_alloc_addr() - allocate memory address from EPC addr space
> >   * @epc: the EPC device on which memory has to be allocated
> >   * @phys_addr: populate the allocated physical address here
> > + * @window: populate the window here which will be used to map PCI address
> >   * @size: the size of the address space that has to be allocated
> > + * @flags: look for window as requested in flags
> >   *
> >   * Invoke to allocate memory address from the EPC address space. This
> >   * is usually done to map the remote RC address into the local system.
> >   */
> >  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> > -                                  phys_addr_t *phys_addr, size_t size)
> > +                                  phys_addr_t *phys_addr,
> > +                                  int *window, size_t size, uint32_t flags)
> >  {
> > +     int best_fit = PCI_EPC_DEFAULT_WINDOW;
> > +     void __iomem *virt_addr = NULL;
> > +     struct pci_epc_mem *mem;
> > +     unsigned int page_shift;
> >       int pageno;
> > -     void __iomem *virt_addr;
> > -     struct pci_epc_mem *mem = epc->mem;
> > -     unsigned int page_shift = ilog2(mem->page_size);
> >       int order;
> >
> > +     if (epc->mem_windows <= 0)
> > +             return NULL;
> > +
> > +     if (epc->mem_windows > 1) {
>
> Why bother testing epc->mem_windows here?  Just make sure
> pci_epc_find_best_fit_window() returns the correct thing for
> "mem_windows == 0" and "mem_windows == 1", and remove both the tests
> above.
>
will fix that.

> > +             best_fit = pci_epc_find_best_fit_window(epc, size, flags);
> > +             if (best_fit < 0)
> > +                     return NULL;
> > +     }
> > +
> > +     mem = epc->mem[best_fit];
> >       size = ALIGN(size, mem->page_size);
> > +     if (size > (mem->window.size - mem->window.map_size))
> > +             return NULL;
> > +     page_shift = ilog2(mem->page_size);
> >       order = pci_epc_mem_get_order(mem, size);
> >
> >       pageno = bitmap_find_free_region(mem->bitmap, mem->pages, order);
> >       if (pageno < 0)
> >               return NULL;
> >
> > -     *phys_addr = mem->phys_base + (pageno << page_shift);
> > +     *phys_addr = mem->window.phys_base + (pageno << page_shift);
> >       virt_addr = ioremap(*phys_addr, size);
> > -     if (!virt_addr)
> > +     if (!virt_addr) {
> >               bitmap_release_region(mem->bitmap, pageno, order);
> > +     } else {
> > +             mem->window.map_size += size;
> > +             *window = best_fit;
> > +     }
> >
> >       return virt_addr;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >
> > +static int pci_epc_get_matching_window(struct pci_epc *epc,
> > +                                    phys_addr_t phys_addr)
>
> Return struct pci_epc_mem * again?
>
yes makes sense.

> > +{
> > +     struct pci_epc_mem *mem;
> > +     int i;
> > +
> > +     for (i = 0; i < epc->mem_windows; i++) {
> > +             mem = epc->mem[i];
> > +
> > +             if (mem->window.phys_base == phys_addr)
> > +                     return i;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> >  /**
> >   * pci_epc_mem_free_addr() - free the allocated memory address
> >   * @epc: the EPC device on which memory was allocated
> > @@ -155,16 +281,26 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
> >                          void __iomem *virt_addr, size_t size)
> >  {
> > +     struct pci_epc_mem *mem;
> > +     unsigned int page_shift;
> > +     int window = 0;
> >       int pageno;
> > -     struct pci_epc_mem *mem = epc->mem;
> > -     unsigned int page_shift = ilog2(mem->page_size);
> >       int order;
> >
> > +     if (epc->mem_windows > 1) {
>
> Same here (unnecessary test).
>
will drop it.

> > +             window = pci_epc_get_matching_window(epc, phys_addr);
> > +             if (window < 0)
> > +                     return;
> > +     }
> > +
> > +     mem = epc->mem[window];
> > +     page_shift = ilog2(mem->page_size);
> >       iounmap(virt_addr);
> > -     pageno = (phys_addr - mem->phys_base) >> page_shift;
> > +     pageno = (phys_addr - mem->window.phys_base) >> page_shift;
> >       size = ALIGN(size, mem->page_size);
> >       order = pci_epc_mem_get_order(mem, size);
> >       bitmap_release_region(mem->bitmap, pageno, order);
> > +     mem->window.map_size -= size;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
>
> > @@ -85,7 +126,8 @@ struct pci_epc_mem {
> >   * @dev: PCI EPC device
> >   * @pci_epf: list of endpoint functions present in this EPC device
> >   * @ops: function pointers for performing endpoint operations
> > - * @mem: address space of the endpoint controller
> > + * @mem: array of address space of the endpoint controller
> > + * @mem_windows: number of windows supported by device
> >   * @max_functions: max number of functions that can be configured in this EPC
> >   * @group: configfs group representing the PCI EPC device
> >   * @lock: spinlock to protect pci_epc ops
> > @@ -94,7 +136,8 @@ struct pci_epc {
> >       struct device                   dev;
> >       struct list_head                pci_epf;
> >       const struct pci_epc_ops        *ops;
> > -     struct pci_epc_mem              *mem;
> > +     struct pci_epc_mem              **mem;
> > +     int                             mem_windows;
>
> Can't this be unsigned int and then there's no need to check
> "mem_windows < 0"?
>
yes will change it unsigned int.

Cheers,
--Prabhakar

> >       u8                              max_functions;
> >       struct config_group             *group;
> >       /* spinlock to protect against concurrent access of EP controller */
