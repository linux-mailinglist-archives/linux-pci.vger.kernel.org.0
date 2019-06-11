Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F13C156
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 04:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390740AbfFKCqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 22:46:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44853 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390244AbfFKCqo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2019 22:46:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so12773622qtk.11
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2019 19:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m35NGQgea2Dtho1tkMpAy982wOOgH1ICR+Vwx3GZeE=;
        b=B7mV3IItGXU3TGMF4QJRflUaAgL4S43JkzhIxxw0iqm4+OLzf9fKB8j2JP2dVCDPil
         sW384G7A11k2gPbEjKGTOv5X2Z3ryeV9M6ryiSLro3IxjT9OZyDo3pObjYM7A1rlex5o
         JM/lbTbVKx0jeE+Hz8BQ5+xUiAB+RIJKjWpmOGWMVU2PHOUFA3YILO2buWSMwliLUQET
         D1qvaiKdx5eSJQsH2Z8ksyja4hIH3EWjs1jAF4U61bv0JbaavY2pVTYjrZaqFU5vAwOY
         NK/8qG5MN2Gn1DUikSm2ti8MCRGEJwUYBqBSQCGhBK+/QkiLzAuqnJRCDVqUQDsWMwXP
         O3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m35NGQgea2Dtho1tkMpAy982wOOgH1ICR+Vwx3GZeE=;
        b=iiQqgK5bhd9eUy994QHejFdReiWB5AXolQASD4uiSSrlnT6S9UqvX8eaxGDqeijZI5
         5qTfXfwd46sN6dS/vF83qiCVmeDRgfQlGtyQRTnGHDMgma4Y/N9fhFjFibPxKxe1RVwu
         ebx5YSF8aQS2g3Nb39YIPqduVBLT+Q3pxU2c7WiHO/3ldGzMSK4loDxozwow3EWdIYcn
         GUKxJXFde69BmLbJwaF//9+ITJmba8OiTuFo85D3efkFGplCzcvNBETqDhVqigk521nq
         OUFvB4eUd/YUNUejbp8CMFpI2ZUOrsL9KFnUicgSJzb13+dsZT2b59Zj+Zt38UmTs0lb
         Jz/A==
X-Gm-Message-State: APjAAAWvxp6dz9KetU4WLsllEWUusgh7eQBVS14wTUedTYVtOu25Ijyo
        MApKeXyvhqJOsKx2DmGwYBPcfEVTtK7Wb4qHudFCVw==
X-Google-Smtp-Source: APXvYqx/p8Wk437d+ei9zOMYRa2j+hTRwjg4+eaMD3R6/xZEyIIMKtLlMd2J9aaBFx62GGYjdo6hkJN+cGx/sK9kwI4=
X-Received: by 2002:ac8:2ec3:: with SMTP id i3mr17155681qta.110.1560221203710;
 Mon, 10 Jun 2019 19:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190610074456.2761-1-drake@endlessm.com> <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
In-Reply-To: <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 11 Jun 2019 10:46:32 +0800
Message-ID: <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
To:     Keith Busch <keith.busch@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-ide@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 11, 2019 at 12:00 AM Keith Busch <keith.busch@gmail.com> wrote:
>
> On Mon, Jun 10, 2019 at 1:45 AM Daniel Drake <drake@endlessm.com> wrote:
> > +       /* We don't support sharing MSI interrupts between these devices */
> > +       nrdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>
> And this is a problem, isn't it? Since we don't have an option to open
> the MSI implementation in RAID mode your experience will be much
> better to disable this mode when using Linux as per the current
> recommendation rather than limping along with legacy IRQ.

What's the specific problem that you see here? Is it that the
interrupt delivery mechanism is legacy wire instead of MSI, or is the
problem that the interrupt is shared over the whole set of storage
devices?

I installed Windows 10 on this product in RAID mode and it is using
the legacy interrupt too. Also, on Linux, MSI interrupts have already
been disabled on the AHCI part of such setups for a good while now:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f723fa4e69920f6a5dd5fa0d10ce90e2f14d189c

The earlier patches from Dan Williams also had the design of sharing
the legacy interrupt:
https://marc.info/?l=linux-ide&m=147709610621480&w=2

I think some kind of MSI support may be possible, perhaps something
similar to what is done by drivers/pci/controller/vmd.c, but it needs
a bit more thought, and I was hoping that we could get the base device
support in place before investigating MSI as a separate step. However,
if the concern you are raising is regarding the sharing of interrupts,
I think that cannot change because the NVMe devices PCI config space
is totally inaccessible when in this mode. That means there is no way
we can configure a per-device MSI message, so the interrupt will
continue to be shared regardless of delivery mechanism.

Thanks,
Daniel
