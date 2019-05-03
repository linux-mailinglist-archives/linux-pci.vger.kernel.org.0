Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B433131D7
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 18:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfECQG5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 12:06:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35056 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfECQG5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 12:06:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so7351751wmd.0
        for <linux-pci@vger.kernel.org>; Fri, 03 May 2019 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VC/Snkdb47YXCrhgoVCm8m87mFow4IXpldKitSIRUm4=;
        b=WPW2uuEQYZhVva1B/kFnzPjaUlaLUB7LHz6G2b/8uJ84ih5o3328e4rXxAUboiXgUM
         J/wO/bHE9XT2eWIiMQWFFY5/3GImZUeiGivUZ/JkzYISpmhpqGhUZgckgutcZLdPVu2S
         UhqkY4W/e+7AWHeB+jtIcDwEjVA+2jagvE048=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VC/Snkdb47YXCrhgoVCm8m87mFow4IXpldKitSIRUm4=;
        b=qEfquGedtO+A4x9cn0uQr3ajswndyXhgj7FOjUH1aDNmb6I1nyAiqgrMh4JB2CNhaZ
         AUOc1qaAUQRCmlVyvJFxQcC+dA9rCr78sKfLGCQs8c8GEyDsqoXt/r7OB8coTeEQkhfk
         CWUBKjb66TxWxACWlTkKhyUO5nSfAeKcv4EgUfNQOyXiLPmfGNByRrXdYThyGGJoEXvC
         2HRzsE2koWMnbgFC04C+vswtYYS1Zff9YCA396WB6IO8BbrlteYLPvfKUNt2uRog9rES
         w9juac7LQOuLzhAn1H/NOieg1hlho9XNS95ZMLPC20M/QDU0/kd7FCwrd/lmbScGmVIM
         VnwA==
X-Gm-Message-State: APjAAAXlUrbTiNyrVawQh5iuLmmk4Lt5dSMbwwOHTzTVuwYqurMbR0Ta
        RjaUhQCy9cUpkqaLecEjbFPh7S5iwCx+4gZjtQQdlg==
X-Google-Smtp-Source: APXvYqyFNFaVsmW8OnGepbzg6L4B75nNvpeBtq+W+EyuOasPwlpVHMRBxacV7yDrHYb0ES1XvOUdH+XTu4EYyVOp/1w=
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr7183118wmg.53.1556899615681;
 Fri, 03 May 2019 09:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com> <20190503155306.GA6461@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190503155306.GA6461@e121166-lin.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 3 May 2019 21:36:44 +0530
Message-ID: <CABe79T4gMT723uZ1tJ6b4CDZ8y97CshSKtd0MRqXCktJx85+jA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] PCIe Host request to reserve IOVA
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Thanks a lot.

Regards,
Srinath.

On Fri, May 3, 2019 at 9:23 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, May 03, 2019 at 07:35:31PM +0530, Srinath Mannam wrote:
> > This patch set will reserve IOVA addresses for DMA memory holes.
> >
> > The IPROC host controller allows only a few ranges of physical address
> > as inbound PCI addresses which are listed through dma-ranges DT property.
> > Added dma_ranges list field of PCI host bridge structure to hold these
> > allowed inbound address ranges in sorted order.
> >
> > Process this list and reserve IOVA addresses that are not present in its
> > resource entries (ie DMA memory holes) to prevent allocating IOVA
> > addresses that cannot be allocated as inbound addresses.
> >
> > This patch set is based on Linux-5.1-rc3.
> >
> > Changes from v5:
> >   - Addressed Robin Murphy, Lorenzo review comments.
> >     - Error handling in dma ranges list processing.
> >     - Used commit messages given by Lorenzo to all patches.
> >
> > Changes from v4:
> >   - Addressed Bjorn, Robin Murphy and Auger Eric review comments.
> >     - Commit message modification.
> >     - Change DMA_BIT_MASK to "~(dma_addr_t)0".
> >
> > Changes from v3:
> >   - Addressed Robin Murphy review comments.
> >     - pcie-iproc: parse dma-ranges and make sorted resource list.
> >     - dma-iommu: process list and reserve gaps between entries
> >
> > Changes from v2:
> >   - Patch set rebased to Linux-5.0-rc2
> >
> > Changes from v1:
> >   - Addressed Oza review comments.
> >
> > Srinath Mannam (3):
> >   PCI: Add dma_ranges window list
> >   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
> >   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> >
> >  drivers/iommu/dma-iommu.c           | 35 ++++++++++++++++++++++++++---
> >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> >  drivers/pci/probe.c                 |  3 +++
> >  include/linux/pci.h                 |  1 +
> >  4 files changed, 79 insertions(+), 4 deletions(-)
>
> I have applied the series to pci/iova-dma-ranges, targeting v5.2,
> thanks.
>
> Lorenzo
