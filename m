Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6A390E1E
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 04:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhEZCEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 22:04:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40543 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhEZCEQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 22:04:16 -0400
Received: from mail-oo1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <koba.ko@canonical.com>)
        id 1llisf-0007Ql-3T
        for linux-pci@vger.kernel.org; Wed, 26 May 2021 02:02:45 +0000
Received: by mail-oo1-f69.google.com with SMTP id o28-20020a4a385c0000b029023ec5d3d5ccso1697367oof.8
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 19:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80Q9luL+LwQCDuf3BgkOvtEc2OIfkbeDzIrwJ3hVNYg=;
        b=MRra8dBUCEpOOUj+pL38ZuPSmufPCMAkcPFUz9fT8eob6cNKQSwfKXFWxiqGn275Pl
         jWWBgzT7YS+kD2Nm8+JAMtUMOu4QaN0BLKFdXJzNjYCJIVqLpb1KrXS06zJqj+Ovu9T8
         1cDbjFFs+Ulf1XmNZDF4vemgxyhGOU6amQhItEUXVk4QWYtg1H9xdtkTfG7ZPatyWC4h
         iD/+FkWUn4JHYRUaik3aeZu9MsgJtMl4LZWjt1bt22m3zOGfZmO9H6YkzPlb5B4Go7/Q
         Olaz+OZgA1JBNyw1FsiB18AnAxD1D1W46OEavQm0oeFF8C/Emx5nCcooPhvbfj4OH9sC
         jP4w==
X-Gm-Message-State: AOAM533g1OM4XO2O2IELwt4msbgT9Rrn6vgzuN+C/LrhqQHZyu3qOOn/
        2jDh2MQ8Kh2gnnT67RM+ZOYtGCFLdc4QqKnZLwTwqIdsXsGPTJznx2Brby+m94Yh0Y1TXbxdv9P
        dA8m/DqWtTCTYuIGZcnP5Ab9Mlso/nqUvtFXSDieDf0t6lSsALkhsvw==
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr353841oif.17.1621994559114;
        Tue, 25 May 2021 19:02:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVyQJj1wQcjhyCbkjhZWLHzSkdMbj1UW7fzQW9m2Wo4G/waP+Gb8xrdYJnlCIdJUeKJb5TO7XDHgGKxBL1qrs=
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr353825oif.17.1621994558803;
 Tue, 25 May 2021 19:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com> <20210525074426.GA14916@lst.de>
In-Reply-To: <20210525074426.GA14916@lst.de>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Wed, 26 May 2021 10:02:27 +0800
Message-ID: <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use npss.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
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
As per Kai-Heng said, it's a regression introduced by commit
b97120b15ebd ("nvme-pci:
use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.
the target nvme ssd uses HMB and the target machine would put nvme to d3cold.
During suspend, nvme driver would shutdown the nvme controller caused by
commit b97120b15ebd ("nvme-pci: use simple suspend when a HMB is enabled").
During resuming, the nvme controller can't change the power state from
d3cold to d0.
    # nvme 0000:58:00.0: can't change power state from D3cold to D0
(config space inaccessible)
Tried some machines, they only put nvme to d3hot so even if nvme is
forced to shutdown,
it could be resumed correctly.

As per commit b97120b15ebd , the TP spec would allow nvme to access
the host memory in any power state in S3.
but the Host would fail to manage. I agree with Kai-Heng's suggestion
but this TP would be broken.

>
> > For these devices, just avoid to go deeper than d3hot.
>
> What are "these devices"?

It's a Samsung ssd using HMB.

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

Thanks, I will refine this.

>
> > +             pdev->d3cold_allowed = false;
> > +             pci_d3cold_disable(pdev);
> > +             pm_runtime_resume(&pdev->dev);
>
> Why do we need to both set d3cold_allowed and call pci_d3cold_disable?
>
> What is the pm_runtime_resume doing here?
I referenced the codes of d3cold_allowed_store@d3cold_allowed_store fun,
As per Bjorn and search in multiple drivers, only pci_d3cold_disable is enough.
