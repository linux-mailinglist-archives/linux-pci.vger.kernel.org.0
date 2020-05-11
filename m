Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231E51CE22D
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 20:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgEKSCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 14:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729643AbgEKSCh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2020 14:02:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F35C061A0E
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2020 11:02:36 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d21so2871910ljg.9
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2020 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KN4Bw4jdoDlNbb2x0GKSiOiWfddLAMYHfygVxNpIf6g=;
        b=SvZpKz7yYJU/v4SDDIo5TOzIj+jwoV/TpTBN3rKCL602OojQJglY2dw5xOeiunPOFi
         DyzhSP/Fy5UBdfge/am/cx04rOkqTbKWuxOjxqsp+K/Okzus3lAn3dbBKJ/ZCJ6HxuVq
         h39u7djqdlksyB3tKveo/W8quLa8tPXg7veTON0HABVQg+M+e7pjqhtcNTCkt/TMbnSd
         pN3CVJwzAKb5Ge7s+venQ9Nw4IxBg2uM87+P3w0lHhVzCAZjiNOP0HW0I/ovgLPoNSb8
         nXG3b+J9z5POi+mxIRKklmwiOkmQ4nrSM4G66SUjogC5jXd4xS5Qd0ky++iU4xkLdE/O
         nPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KN4Bw4jdoDlNbb2x0GKSiOiWfddLAMYHfygVxNpIf6g=;
        b=M5MpyM7TMHKfBCLi/PpKEMrd47eACDtGBN3NodgYHfTuXXOXwETIN0+aJ8C1a123Nx
         vlTd9ByMUtsRWQ7YPKyHg/TZxmSH34+hhYQLP7BSAWucpX4tT87rVKAE+dGjcgI0nZ0W
         nj1/puiKkBWNplBgY/LT25Kz3xkbHV8HISjqzBttvuUdTXKz+1Ndk9SgpcATUuIb7xGV
         ChdG3lYOSHZkTF0StiIc2dUL1MfeYt9llMubzDK6veUjgK3KjNs73CtGOO6Dp5RRQ0kv
         Dzau2YUucLnaPXupKBtW8C6jytEki1kMi2BVTddPI3YlXojvlRXcwvQ9/ZiRDYHNNOwM
         WXjw==
X-Gm-Message-State: AOAM530yJ9Q5PIe+/paFVCQzHEvw9+gL0kIrtE7u0nsK0q6P2sBjpKc0
        o1JKfcp0T8YaZZht7M/3oWlSTYn8gFq1PNcigj+s4A==
X-Google-Smtp-Source: ABdhPJxGkpgqjRn8BVvDcLIEp5cLnJADuGxbnHoJriKzo/Q9RHfyD4Lbjurxqz0QK3XVSAVu71GUD3ugQHO/GuSk9AQ=
X-Received: by 2002:a2e:b52a:: with SMTP id z10mr322629ljm.200.1589220154131;
 Mon, 11 May 2020 11:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <1588379352-22550-1-git-send-email-alan.mikhak@sifive.com> <20200507214418.GA22159@bogus>
In-Reply-To: <20200507214418.GA22159@bogus>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 11 May 2020 11:02:23 -0700
Message-ID: <CABEDWGxhCCrVT4Dj=o+9sKtL1EvrOZjNkyuXqYYcZoQ8b-aXEg@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: functions/pci-epf-test: Support slave DMA transfer
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        efremov@linux.com, b.zolnierkie@samsung.com, vidyas@nvidia.com,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 7, 2020 at 2:44 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, May 01, 2020 at 05:29:12PM -0700, Alan Mikhak wrote:
> > From: Alan Mikhak <alan.mikhak@sifive.com>
> >
> > Modify pci_epf_test_data_transfer() to also support slave DMA transfers.
> > Adds a direction parameter so caller can specify one of the supported DMA
> > transfer directions: DMA_MEM_TO_MEM, DMA_MEM_TO_DEV, and DMA_DEV_TO_MEM.
> > For DMA_MEM_TO_MEM, the function calls dmaengine_prep_dma_memcpy() as it
> > did before. For DMA_MEM_TO_DEV or DMA_DEV_TO_MEM direction, the function
> > calls dmaengine_slave_config() to configure the slave channel before it
> > calls dmaengine_prep_slave_single().
> >
> > Modify existing callers to specify DMA_MEM_TO_MEM since that is the only
> > possible option so far. Rename the phys_addr local variable in some of the
> > callers for more readability. Tighten some of the timing function calls to
> > avoid counting error print time in case of error.
>
> Looks fine, but also needs a user. The last sentence sounds like a
> separate change.

Thanks Rob for your comment.

I will address your concern in a future v2 patch.

Regards,
Alan

>
> >
> > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 67 ++++++++++++++++++---------
> >  1 file changed, 44 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 60330f3e3751..1d026682febb 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -104,25 +104,41 @@ static void pci_epf_test_dma_callback(void *param)
> >   * The function returns '0' on success and negative value on failure.
> >   */
> >  static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> > -                                   dma_addr_t dma_dst, dma_addr_t dma_src,
> > -                                   size_t len)
> > +                                   dma_addr_t dma_dst,
> > +                                   dma_addr_t dma_src,
> > +                                   size_t len,
> > +                                   enum dma_transfer_direction dir)
> >  {
> >       enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> >       struct dma_chan *chan = epf_test->dma_chan;
> >       struct pci_epf *epf = epf_test->epf;
> > +     struct dma_slave_config sconf;
> >       struct dma_async_tx_descriptor *tx;
> >       struct device *dev = &epf->dev;
> >       dma_cookie_t cookie;
> > +     dma_addr_t buf;
> >       int ret;
> >
> >       if (IS_ERR_OR_NULL(chan)) {
> > -             dev_err(dev, "Invalid DMA memcpy channel\n");
> > +             dev_err(dev, "Invalid DMA channel\n");
> >               return -EINVAL;
> >       }
> >
> > -     tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> > +     if (dir == DMA_MEM_TO_MEM) {
> > +             tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src,
> > +                                            len, flags);
> > +     } else {
> > +             memset(&sconf, 0, sizeof(sconf));
> > +             sconf.direction = dir;
> > +             sconf.dst_addr = dma_dst;
> > +             sconf.src_addr = dma_src;
> > +             dmaengine_slave_config(chan, &sconf);
> > +
> > +             buf = (dir == DMA_MEM_TO_DEV) ? dma_dst : dma_src;
> > +             tx = dmaengine_prep_slave_single(chan, buf, len, dir, flags);
> > +     }
> >       if (!tx) {
> > -             dev_err(dev, "Failed to prepare DMA memcpy\n");
> > +             dev_err(dev, "Failed to prepare DMA transfer\n");
> >               return -EIO;
> >       }
> >
> > @@ -268,7 +284,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> >               goto err_dst_addr;
> >       }
> >
> > -     ktime_get_ts64(&start);
> >       use_dma = !!(reg->flags & FLAG_USE_DMA);
> >       if (use_dma) {
> >               if (!epf_test->dma_supported) {
> > @@ -277,14 +292,18 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> >                       goto err_map_addr;
> >               }
> >
> > +             ktime_get_ts64(&start);
> >               ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> > -                                              src_phys_addr, reg->size);
> > +                                              src_phys_addr, reg->size,
> > +                                              DMA_MEM_TO_MEM);
> > +             ktime_get_ts64(&end);
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> >       } else {
> > +             ktime_get_ts64(&start);
> >               memcpy(dst_addr, src_addr, reg->size);
> > +             ktime_get_ts64(&end);
> >       }
> > -     ktime_get_ts64(&end);
> >       pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
> >
> >  err_map_addr:
> > @@ -310,7 +329,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> >       void *buf;
> >       u32 crc32;
> >       bool use_dma;
> > -     phys_addr_t phys_addr;
> > +     phys_addr_t src_phys_addr;
> >       phys_addr_t dst_phys_addr;
> >       struct timespec64 start, end;
> >       struct pci_epf *epf = epf_test->epf;
> > @@ -319,8 +338,9 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> >       struct device *dma_dev = epf->epc->dev.parent;
> >       enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> >       struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > +     enum dma_transfer_direction dir = DMA_MEM_TO_MEM;
> >
> > -     src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> > +     src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
> >       if (!src_addr) {
> >               dev_err(dev, "Failed to allocate address\n");
> >               reg->status = STATUS_SRC_ADDR_INVALID;
> > @@ -328,7 +348,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> >               goto err;
> >       }
> >
> > -     ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
> > +     ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
> >                              reg->size);
> >       if (ret) {
> >               dev_err(dev, "Failed to map address\n");
> > @@ -360,10 +380,10 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> >
> >               ktime_get_ts64(&start);
> >               ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> > -                                              phys_addr, reg->size);
> > +                                              src_phys_addr, reg->size, dir);
> > +             ktime_get_ts64(&end);
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> > -             ktime_get_ts64(&end);
> >
> >               dma_unmap_single(dma_dev, dst_phys_addr, reg->size,
> >                                DMA_FROM_DEVICE);
> > @@ -383,10 +403,10 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> >       kfree(buf);
> >
> >  err_map_addr:
> > -     pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
> > +     pci_epc_unmap_addr(epc, epf->func_no, src_phys_addr);
> >
> >  err_addr:
> > -     pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
> > +     pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
> >
> >  err:
> >       return ret;
> > @@ -398,7 +418,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >       void __iomem *dst_addr;
> >       void *buf;
> >       bool use_dma;
> > -     phys_addr_t phys_addr;
> > +     phys_addr_t dst_phys_addr;
> >       phys_addr_t src_phys_addr;
> >       struct timespec64 start, end;
> >       struct pci_epf *epf = epf_test->epf;
> > @@ -407,8 +427,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >       struct device *dma_dev = epf->epc->dev.parent;
> >       enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> >       struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > +     enum dma_transfer_direction dir = DMA_MEM_TO_MEM;
> >
> > -     dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> > +     dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
> >       if (!dst_addr) {
> >               dev_err(dev, "Failed to allocate address\n");
> >               reg->status = STATUS_DST_ADDR_INVALID;
> > @@ -416,7 +437,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >               goto err;
> >       }
> >
> > -     ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
> > +     ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
> >                              reg->size);
> >       if (ret) {
> >               dev_err(dev, "Failed to map address\n");
> > @@ -450,11 +471,11 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >               }
> >
> >               ktime_get_ts64(&start);
> > -             ret = pci_epf_test_data_transfer(epf_test, phys_addr,
> > -                                              src_phys_addr, reg->size);
> > +             ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> > +                                              src_phys_addr, reg->size, dir);
> > +             ktime_get_ts64(&end);
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> > -             ktime_get_ts64(&end);
> >
> >               dma_unmap_single(dma_dev, src_phys_addr, reg->size,
> >                                DMA_TO_DEVICE);
> > @@ -476,10 +497,10 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >       kfree(buf);
> >
> >  err_map_addr:
> > -     pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
> > +     pci_epc_unmap_addr(epc, epf->func_no, dst_phys_addr);
> >
> >  err_addr:
> > -     pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
> > +     pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
> >
> >  err:
> >       return ret;
> > --
> > 2.7.4
> >
