Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20CC42892D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 10:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhJKIyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbhJKIyO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 04:54:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE850C061570;
        Mon, 11 Oct 2021 01:52:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z20so64712024edc.13;
        Mon, 11 Oct 2021 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EgDaikTcU3ZPE2vrvTMJwpUblaQMnmC465MWD/CtjE=;
        b=hua6DOLXhL84HQk+Q9sixuzRMOlsw5dVMgwdxf9MSeKQSG8800sKaGkOIgFCQrkEgn
         Pmu/Fb+1BHgoXACNB50rLA897B3dXZwT+Az2WPpUXp1iBCnCHMjoW+XbojiZyo/IbgvP
         lbvgtpHlXvR8SAoXIpV1Ug1GvBezgWzNz1YvMHyGA0qYfgbI++SPQRepzt/VN+iCNjAw
         0F17DSFR12ykNxZJhWk9TquqsCPR8KFcnmnTNr+nsxMwN1H51MG6K5v+oF+Z2Lx7+MEs
         rnpaUzrXQPiLbaAMtcZjf42USM4nSQIP6weva65reJ5bmqvfIJNoo+ojjL+g1CsvGEAt
         2H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EgDaikTcU3ZPE2vrvTMJwpUblaQMnmC465MWD/CtjE=;
        b=OAEYR0oTbENutpwMbCZ31rzat4HG2sPPqMmOse++nQ4XogiWsEHsA5fuBdh1NrasGR
         DXwcVuNBtDeu0o9f1p3NNkqgJlprdJ1KioWf0tGX9JeXJJXeM965DcrFBNlipREht/IL
         uC/gRZgjSmyhb1JaDZzfw6q3xdsOgfGDVwbh7DyJ8q2OksT8attGoEJDjIOOTFYBPBKM
         GFrdKC3SMhzBY8dIhbd1BMShr6rG/jWUums/RYtJBJzdPn981HguLGCvR5SyY7P1yc/Z
         HZLY37j76Vv005JKZDfWmZiS8zGcgAWqtfzVja5fPLrKmAHJGutrclOYHwv5HvwVzyjh
         oC+g==
X-Gm-Message-State: AOAM530WEn2acN6w5uxVOcC18tTuvoCbIWueUI2H2blP84RnKRXUPfd/
        z+WXRiPVmLz0Ce5CbZJh8A10XxVSmV3/KZ3/a7s=
X-Google-Smtp-Source: ABdhPJwjMX2u3XDdp1JabEVjD/UGiPIZKSXLvzmZwSlEB8qFF2+MbNv1OBxu7ZVeXkamUIaFzEuwtAdB1I9p8Y7D1mw=
X-Received: by 2002:a50:e384:: with SMTP id b4mr39659511edm.314.1633942333366;
 Mon, 11 Oct 2021 01:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211011084049.53643-1-wanghai38@huawei.com>
In-Reply-To: <20211011084049.53643-1-wanghai38@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 11 Oct 2021 21:52:02 +1300
Message-ID: <CAGsJ_4yHW5YbmErTdv7Hq3-XOVL_-t5OdDR8WEYGyXyqiQmRxA@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: fix page fault when msi_populate_sysfs() failed
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 11, 2021 at 9:24 PM Wang Hai <wanghai38@huawei.com> wrote:
>
> I got a page fault report when doing fault injection test:
>
> BUG: unable to handle page fault for address: fffffffffffffff4
> ...
> RIP: 0010:sysfs_remove_groups+0x25/0x60
> ...
> Call Trace:
>  msi_destroy_sysfs+0x30/0xa0
>  free_msi_irqs+0x11d/0x1b0
>  __pci_enable_msix_range+0x67f/0x760
>  pci_alloc_irq_vectors_affinity+0xe7/0x170
>  vp_find_vqs_msix+0x129/0x560
>  vp_find_vqs+0x52/0x230
>  vp_modern_find_vqs+0x47/0xb0
>  p9_virtio_probe+0xa1/0x460 [9pnet_virtio]
>  virtio_dev_probe+0x1ed/0x2e0
>  really_probe+0x1c7/0x400
>  __driver_probe_device+0xa4/0x120
>  driver_probe_device+0x32/0xe0
>  __driver_attach+0xbf/0x130
>  bus_for_each_dev+0xbb/0x110
>  driver_attach+0x27/0x30
>  bus_add_driver+0x1d9/0x270
>  driver_register+0xa9/0x180
>  register_virtio_driver+0x31/0x50
>  p9_virtio_init+0x3c/0x1000 [9pnet_virtio]
>  do_one_initcall+0x7b/0x380
>  do_init_module+0x5f/0x21e
>  load_module+0x265c/0x2c60
>  __do_sys_finit_module+0xb0/0xf0
>  __x64_sys_finit_module+0x1a/0x20
>  do_syscall_64+0x34/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> When populating msi_irqs sysfs failed in msi_capability_init() or
> msix_capability_init(), dev->msi_irq_groups will point to ERR_PTR(...).
> This will cause a page fault when destroying the wrong
> dev->msi_irq_groups in free_msi_irqs().
>
> Fix this by setting dev->msi_irq_groups to NULL when msi_populate_sysfs()
> failed.
>
> Fixes: 2f170814bdd2 ("genirq/msi: Move MSI sysfs handling from PCI to MSI core")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  drivers/pci/msi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0099a00af361..6f75db9f3be7 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -561,6 +561,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
>         dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
>         if (IS_ERR(dev->msi_irq_groups)) {
>                 ret = PTR_ERR(dev->msi_irq_groups);
> +               dev->msi_irq_groups = NULL;
>                 goto err;
>         }
>
> @@ -733,6 +734,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>         dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
>         if (IS_ERR(dev->msi_irq_groups)) {
>                 ret = PTR_ERR(dev->msi_irq_groups);
> +               dev->msi_irq_groups = NULL;

Can you define a temp variable and assign it to dev->msi_irq_groups if
the temp variable
is not PTR_ERR?

>                 goto out_free;
>         }
>
> --
> 2.17.1
>

Thanks
Barry
