Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A169DCEAD7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2019 19:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfJGRof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 13:44:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44972 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGRof (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2019 13:44:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so14586974ljj.11
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2019 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vk7i14T/JR7YS23mvVE1tUhQjiWMuR9VHE86a98WunI=;
        b=OLLwDwGcq0XWYoIOVOg3f18hRqsB+0FRgBDO0OmmxtqGQYby0JB5u0UHjDXgij9vYo
         Se5/pU/H1eTqNRcFiWOtVL5Hx5zYOR44QeVE0UBOryjbfM15v53lLA/oM8EV26gbHEN7
         UXRvKQeEhMekI8rhDX+Y0qFpuCB18WULcN5R+UjJb0Frfkc49Dhr7MrjPLZKDwKFhS3E
         9Fre4eNitanYVJmDpA6UEHCi9lUTvmIFQhYGhaNay+PEgLNtF1y3aAh3aEwIK3/Sy26M
         27co8CrSYmbGd8qfcq7SPlpqlhAPLlmBMcmkumdfymHaf5LfUlqhLclwLOZEcSMx8hl5
         Ndlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vk7i14T/JR7YS23mvVE1tUhQjiWMuR9VHE86a98WunI=;
        b=G7sRd8V7lR9oFiGfYtqc25/XMgm2Imz1T3al/Y8SnBPxBWNqcAUs/nPA3oQkPptqka
         ICGK1b7PRHEIQPRc1Tx8KJFB1VNMPWhJVpPIynV9T+tYVW6fNP7W/hk4T9zoByt39dWX
         c/jOCyBz9QZS5SkUYOe4f/Gxj+9xZrGt10R9meISTtxNjp8vx7Rbp+h/tn33V/bu1V5n
         040v45AJZLukSzG2b5tcScdLqT+C7h4/ZOfXvvz8rpDAxV/WeuFntgZnngGW+KymCOA9
         i3px6pS7BYHcdO7LjpF1wZnIaC+iscCk+cOWwZqs3PWUDywDXjf62TiOPM8JqPLLHyDt
         1VWA==
X-Gm-Message-State: APjAAAWS58zamcc0tXRwJc2Mx1UI+Lfw2HmGVpmT1I6Cf+kp3BJxqciA
        A9sOK7Yj0yjqp2DGeA2y1Gu5mFPRDiO9q0a4urtzm6EdZIU=
X-Google-Smtp-Source: APXvYqx5XmOHpRpqAJ92Ox0/Z3WATyleaCoIzWgtDblpyPcclaRE6YhE+RfgISgjo8lZXQBz1jQLC+J5Vp7w60iEpK0=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr19449238ljg.119.1570470272661;
 Mon, 07 Oct 2019 10:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <1570240177-8934-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1570240177-8934-1-git-send-email-alan.mikhak@sifive.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 7 Oct 2019 10:44:21 -0700
Message-ID: <CABEDWGx5MzsdcKzNzCtt3DxXAEWK69Bm-QBK0248rGAvWaU22w@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: cast the page number to phys_addr_t
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 4, 2019 at 6:49 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> From: Alan Mikhak <alan.mikhak@sifive.com>
>
> Modify pci_epc_mem_alloc_addr() to cast the variable 'pageno'
> from type 'int' to 'phys_addr_t' before shifting left. This
> cast is needed to avoid treating bit 31 of 'pageno' as the
> sign bit which would otherwise get sign-extended to produce
> a negative value. When added to the base address of PCI memory
> space, the negative value would produce an invalid physical
> address which falls before the start of the PCI memory space.
>
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/endpoint/pci-epc-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index 2bf8bd1f0563..d2b174ce15de 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -134,7 +134,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>         if (pageno < 0)
>                 return NULL;
>
> -       *phys_addr = mem->phys_base + (pageno << page_shift);
> +       *phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
>         virt_addr = ioremap(*phys_addr, size);
>         if (!virt_addr)
>                 bitmap_release_region(mem->bitmap, pageno, order);
> --
> 2.7.4
>

Hi Kishon,

This issue was observed when requesting pci_epc_mem_alloc_addr()
to allocate a region of size 0x40010000ULL (1GB + 64KB) from a
128GB PCI address space with page sizes being 64KB. This resulted
in 'pageno' value of '0x8000' as the first available page in a
contiguous region for the requested size due to other smaller
regions having been allocated earlier. With 64KB page sizes,
the variable 'page_shift' holds a value of 0x10. Shifting 'pageno'
16 bits to the left results in an 'int' value whose bit 31 is set.

[   10.565256] __pci_epc_mem_init: mem size 0x2000000000 page_size 0x10000
[   10.571613] __pci_epc_mem_init: mem pages 0x200000 bitmap_size
0x40000 page_shift 0x10

PCI memory base 0x2000000000
PCI memory size 128M 0x2000000000
page_size 64K 0x10000
page_shift  16 0x10
pages 2M 0x200000
bitmap_size 256K 0x40000

[  702.050299] pci_epc_mem_alloc_addr: size 0x10000 order 0x0 pageno
0x4 virt_add 0xffffffd0047b0000 phys_addr 0x2000040000
[  702.061424] pci_epc_mem_alloc_addr: size 0x10000 order 0x0 pageno
0x5 virt_add 0xffffffd0047d0000 phys_addr 0x2000050000
[  702.203933] pci_epc_mem_alloc_addr: size 0x40010000 order 0xf
pageno 0x8000 virt_add 0xffffffd004800000 phys_addr 0x1f80000000
[  702.216547] Oops - store (or AMO) access fault [#1]
:::
[  702.310198] sstatus: 0000000200000120 sbadaddr: ffffffd004804000
scause: 0000000000000007

Regards,
Alan
