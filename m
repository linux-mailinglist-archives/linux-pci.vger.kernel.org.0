Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D4C3906E6
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 18:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhEYQvL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 12:51:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhEYQvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 12:51:10 -0400
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1llaFP-0002ag-5G
        for linux-pci@vger.kernel.org; Tue, 25 May 2021 16:49:39 +0000
Received: by mail-lf1-f70.google.com with SMTP id h6-20020ac24d260000b02901c679f8f74cso7941750lfk.10
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 09:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJaCYdrDxV6hFjr7P9dKxuwmpFAJtjJ9oxxDaSIJ6Go=;
        b=LyaDZlV4XmNajLfxqZjIWSyRu55EsYaaekRvtYwXSlHnYCuiXM7JIsMApNlz1Itka6
         xc00lIc3pLUI+i6t5PMgspai4y1pffINR9YhJmlwzCcrnB5qe6rApiYbzzWIQb6R5+XY
         Mf/tKjAPhGzuOg1a/g/A+qo3BifHrgBgBj2qIiWBhCrh9oTKvtw16dLmKoo7e4vJnCp4
         HsPi/fO5zAywoSFjYY578ljdiVHhdPTE7mrfFdXLY1kumnYDFxMd1lDBG5z8KO4mFH6z
         Lg8oH0wClWIw+bVghjQvzrdNUPHyVQFkDgKbE8Y+YMGR/RaUN+yVLCSLDHyxuz6uHHZj
         bUhg==
X-Gm-Message-State: AOAM530yGsssjqYU4+DfMCvUbC6Df759y4TwDOKYs+TLaqQOBhbDvD4Z
        DyZjRAUzlqxQbAHj8FmFt6VAl+8pV9JI2j9sh7z/QK+ckvW95Zd17lWEteZwN3+uCh0z1DYQVlf
        yj7m1iZbw25mwIKlEmWPgyN+lBAlCjgJGTkBGALhPu5Np3i/DfYBUwQ==
X-Received: by 2002:a05:6512:1153:: with SMTP id m19mr8111649lfg.290.1621961378514;
        Tue, 25 May 2021 09:49:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymQiimH+CbsO7SXttRtmgzlQND/9nKiElblzw2Wx5kB4zclyWI8q+1Em3tAhbyMgEgXsZlONs6r6p26Y0E4nY=
X-Received: by 2002:a05:6512:1153:: with SMTP id m19mr8111630lfg.290.1621961378269;
 Tue, 25 May 2021 09:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com> <20210525074426.GA14916@lst.de>
In-Reply-To: <20210525074426.GA14916@lst.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 26 May 2021 00:49:26 +0800
Message-ID: <CAAd53p7Qw1d+P_SirjOT=6YLvap+OLGAgdeW7dyMUwbqdHHfyQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use npss.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Koba Ko <koba.ko@canonical.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > After resume, host can't change power state of the closed controller
> > from D3cold to D0.
>
> Why?

IIUC it's a regression introduced by commit b97120b15ebd ("nvme-pci:
use simple suspend when a HMB is enabled"). The affected NVMe is using
HMB.

That commit intentionally put the device to D3hot instead of D0 on
suspend, as the root port of the NVMe device has _PR3, the NVMe was
put to D3cold as a result. I believe because the other OS doesn't put
the NVMe to D3cold, so turning off the power resource is untested by
the vendor.

I think the proper fix would be reverting that commit, and
teardown/setup DMA on suspend/resume for HMB NVMes.

Kai-Heng

>
> > For these devices, just avoid to go deeper than d3hot.
>
> What are "these devices"?
>
> > @@ -2958,6 +2959,15 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >
> >       dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
> >
> > +     if (pm_suspend_via_firmware() || !dev->ctrl.npss ||
> > +         !pcie_aspm_enabled(pdev) ||
> > +         dev->nr_host_mem_descs ||
> > +         (dev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {
>
> Before we start open coding this in even more places we really want a
> little helper function for these checks, which should be accomodated with
> the comment near the existing copy of the checks.
>
> > +             pdev->d3cold_allowed = false;
> > +             pci_d3cold_disable(pdev);
> > +             pm_runtime_resume(&pdev->dev);
>
> Why do we need to both set d3cold_allowed and call pci_d3cold_disable?
>
> What is the pm_runtime_resume doing here?
