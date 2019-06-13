Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F084441B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 18:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfFMQey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 12:34:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44039 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730748AbfFMHsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 03:48:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so21444044qtk.11;
        Thu, 13 Jun 2019 00:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgT/YI2hhlyXpTA69Z5TLJrfk51LKe8sjqrg92sPdsE=;
        b=SQg+yqsmEG8/rbL5s56YYblBFrLfmJsiBXHa7ZXVgyIP0tRoUXtNYQ0UIPH/XazFfA
         L3GC1hyyy/kLMqwWeF4XpEiubJ2IzjM/pyZgoFCQX94B2q0GuqAHB0ApLWeB59IO7P1v
         AnyS4noenqQKVv6dzMO4etLQ1mVb1wdkmCuI4rwxqz14UZBvSmrtbAATR3g9MjHNw/pb
         eBzyywIV9piCmHE0zkCOuCnpQcQyl4Yshq5H5pJC6D8shazQfBM8x1Hghse9rJ9V3uey
         tbUmq81JX+mUo3MPmYHLyPxq/VrrzEfQGdWuKjKyWFW+JjD54whb/J++843Ajdw8IjGB
         Bl3A==
X-Gm-Message-State: APjAAAUiAqQlL7dK/5SpbrLTm8uDGOtFJAlWU24Cksm5CXLW7FUz6SYG
        usyGCQ/fpyaR/pUC+FF6UyNIc39dKcn/RNzAD1Q=
X-Google-Smtp-Source: APXvYqxrrnzKo+F21ENjug1XYtPxZtDHIGQHLWn6kMjV5ZWTGO0RqR8XpwT1uM7DX/d/KwMCFvP6KDGEjgTJk97GDCA=
X-Received: by 2002:ac8:3ff5:: with SMTP id v50mr69703766qtk.142.1560412088101;
 Thu, 13 Jun 2019 00:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
 <1560262374-67875-3-git-send-email-john.garry@huawei.com> <20190613032034.GE13533@google.com>
In-Reply-To: <20190613032034.GE13533@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jun 2019 09:47:51 +0200
Message-ID: <CAK8P3a0C010LEs3HmyQKHWx4EVpVH1NUtFwYkoF16syFQ9hd8w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 5:20 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 11, 2019 at 10:12:53PM +0800, John Garry wrote:
> > Currently when accessing logical indirect PIO addresses in
> > logic_{in, out}{,s}, we first ensure that the region is registered.
>
> I think logic_pio is specifically concerned with I/O port space, so
> it's a little bit unfortunate that we named this "PIO".
>
> PIO is a general term for "Programmed I/O", which just means the CPU
> is involved in each transfer, as opposed to DMA.  The transfers can be
> to either MMIO or I/O port space.
>
> So this ends up being a little confusing because I think you mean
> "Port I/O", not "Programmed I/O".

I think the terms that John uses are more common: I would also
assume that "PIO" (regardless of whether you expand it as Port
or Programmed I/O) refers only to inb/outb and PCI/ISA/LPC
I/O space, and is distinct from "MMIO", which refers to the readl/writel
accessors and PCI memory space.

That is consistent with the usage across at least the x86, powerpc
and ia64 architectures when they refer to PIO.

        Arnd
