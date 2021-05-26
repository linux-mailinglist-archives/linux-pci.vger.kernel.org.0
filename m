Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F15391AA1
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 16:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhEZOs7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 10:48:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60482 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhEZOs6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 10:48:58 -0400
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lluog-0001Oc-CD
        for linux-pci@vger.kernel.org; Wed, 26 May 2021 14:47:26 +0000
Received: by mail-lj1-f199.google.com with SMTP id z19-20020a2eb5330000b02900eeda415d13so584175ljm.23
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 07:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKkeDIyfg5tbUDNJPi4NgjfV5qFGc/eyNl9E9obon3I=;
        b=jggROnN7wdTnPo1HNjS4FoU227DaT+tzYkPKYJZ9QB0zxOvd65PHWH0m5AKSU0MtMq
         TJEAwQHslL+eQ66DSep7wSXL2zXHNtnbI4BwEFBAy8RxJPZnw2ElPNCYocTORNQPkhfw
         3+MCvs5CCPod28lZ9j9caJwxbstQ8ACG5oWSmlGaChIRLTk072bDx6y6btxjFPRGBk5T
         2j9T7rs5B8fbdIqKCPnem+gCNtSv2ZpiiFSZm9G78/NBzQL5ndG1QgygSwH9bKpNuN8i
         h1gEHR9+oIqMaAv68/wL7xHAi9uxdIzoP6Uh6V5AaOiW7PeiSGJgYg5fjY8bLlt7Cuff
         f5HA==
X-Gm-Message-State: AOAM533CbqYQJRBjMoAghIQqmDKCSO9oNd3XB4/WVLB9JLKT21DNFWop
        2NCiK/o5jw0qDbINL3BZoT8oKdKNZrE1/eILTjLJxzH6J87S4HgL2fOdDuyZ54dUNlGLDbND7z5
        vInV0O324WVRZ+15CgCfUr6C57fofG+M+eLjd/mr3OcvsTx2z92GAbQ==
X-Received: by 2002:a2e:b892:: with SMTP id r18mr2494560ljp.402.1622040445852;
        Wed, 26 May 2021 07:47:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLrPOwOay/G7viPPeObhmAqhusdasfgLFHKjudG5zu7fmIP7duHluGrol4HR6UOtuCA0uo4/HyjqUPvqVsicI=
X-Received: by 2002:a2e:b892:: with SMTP id r18mr2494540ljp.402.1622040445600;
 Wed, 26 May 2021 07:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de> <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
 <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com> <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
 <20210526125942.GA25080@lst.de> <CAAd53p4f2ZFsVRv-Q9maPBSD_uGjj7FoYKYy9MGjBPc6chk_1Q@mail.gmail.com>
 <20210526142809.GA32077@lst.de>
In-Reply-To: <20210526142809.GA32077@lst.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 26 May 2021 22:47:13 +0800
Message-ID: <CAAd53p6TJev=LgdvGxC92A9HOy3B6jbPLymAqeB5bDe2=5Fdsw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use npss.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Koba Ko <koba.ko@canonical.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 10:28 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 26, 2021 at 10:21:59PM +0800, Kai-Heng Feng wrote:
> > To be fair, resuming the NVMe from D3hot is much slower than keep it
> > at D0, which gives us a faster s2idle resume time. And now AMD also
> > requires s2idle on their latest laptops.
>
> We'd much prefer to use it, but due to the broken platforms we can't
> unfortunately.
>
> > And it's more like NVMe controllers don't respect PCI D3hot.
>
> What do you mean with that?

Originally, we found that under s2idle, most NVMe controllers caused
substantially more power if D3hot was used.
We were told by all the major NVMe vendors that D3hot is not
supported. It may also disable APST.
And that's the reason why we have the host-managed power control for s2idle.

IIRC only Samsung NVMes respect D3hot and keeps the power consumption low.

>
> > Because the NVMe continues to work after s2idle and the symbol is
> > rather subtle, so I suspect this is not platform or vendor specific.
> > Is it possible to disable DMA for HMB NVMe on suspend?
>
> Not in shipping products.  The NVMe technical working group is working
> on a way to do that, but it will take a while until that shows up in
> products.

Hmm, then what else can we do? Because D3hot isn't support by the
vendor, does it really stop HMB?

Kai-Heng
