Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BCA3A8AEF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 23:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhFOVUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 17:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhFOVUe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 17:20:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 520DD613B1;
        Tue, 15 Jun 2021 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623791909;
        bh=HvzPcdHo85fJo2BuQWKIos2eC9Gp+mz4aSYW3NOFLvY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iTryfXvN1dqS0YOr65+sQbfAeQ+Hk+TOZQ7ajsfbPem1YDIfNacvRQBtSIW+/EKJF
         kbYHskVsqrDD45K+xqPXn4UEWPrn8q/VvZFkPh6Swrnc8I0M5ID6LB2ldSL4nI2qFH
         XcJE506v09LOpTJZyCF1T+Y4Qi4KyTRD+7GHhQhl7dljH2Jt0ZBYleKFIPMVtfNqoK
         RF8hOkZH+/4ZgeijRy130qy0NGXSF/6pauO4kkbZIyqCtTH6mRBhqM6M9n6JDnMHfR
         GmDGyISJdX6IPssI5wnCkin5BWgXHYQpp7BojjQoCgv10tzpzrs5ybMGi56sU1iwb8
         vz0ui0A19SeCQ==
Received: by mail-ed1-f50.google.com with SMTP id s15so12076620edt.13;
        Tue, 15 Jun 2021 14:18:29 -0700 (PDT)
X-Gm-Message-State: AOAM530iAPIVP7hZGwHwVOyJ5z9pXneF3OVufXg8FUje4Dc2V6nnnaja
        ulOepFg/15HDYEfgAGdORE0l1idmi85EfzF6aA==
X-Google-Smtp-Source: ABdhPJxXvtatFAsBpPXonzYiVjnjQgygge8MCylwXVfui349mdZRVbpYrxDh5A9gZdo3Biv9dVEhLIbhHGduZl6mTuQ=
X-Received: by 2002:a05:6402:cb0:: with SMTP id cn16mr163687edb.165.1623791907827;
 Tue, 15 Jun 2021 14:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210614230457.752811-1-punitagrawal@gmail.com>
In-Reply-To: <20210614230457.752811-1-punitagrawal@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Jun 2021 15:18:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLhOFHwBwtMFMnuEaXsDs9sqzUPS=68t+bDnbFsfXgo+Q@mail.gmail.com>
Message-ID: <CAL_JsqLhOFHwBwtMFMnuEaXsDs9sqzUPS=68t+bDnbFsfXgo+Q@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: of: Clear 64-bit flag for non-prefetchable memory
 below 4GB
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 14, 2021 at 5:05 PM Punit Agrawal <punitagrawal@gmail.com> wrote:
>
> Alexandru and Qu reported this resource allocation failure on
> ROCKPro64 v2 and ROCK Pi 4B, both based on the RK3399:
>
>   pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
>   pci 0000:00:00.0: PCI bridge to [bus 01]
>   pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
>   pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
>
> "BAR 14" is the PCI bridge's 32-bit non-prefetchable window, and our
> PCI allocation code isn't smart enough to allocate it in a host
> bridge window marked as 64-bit, even though this should work fine.
>
> A DT host bridge description includes the windows from the CPU
> address space to the PCI bus space.  On a few architectures
> (microblaze, powerpc, sparc), the DT may also describe PCI devices
> themselves, including their BARs.
>
> Before 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
> flags for 64-bit memory addresses"), of_bus_pci_get_flags() ignored
> the fact that some DT addresses described 64-bit windows and BARs.
> That was a problem because the virtio virtual NIC has a 32-bit BAR
> and a 64-bit BAR, and the driver couldn't distinguish them.
>
> 9d57e61bf723 set IORESOURCE_MEM_64 for those 64-bit DT ranges, which
> fixed the virtio driver.  But it also set IORESOURCE_MEM_64 for host
> bridge windows, which exposed the fact that the PCI allocator isn't
> smart enough to put 32-bit resources in those 64-bit windows.
>
> Clear IORESOURCE_MEM_64 from host bridge windows since we don't need
> that information.
>
> Fixes: 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
> Reported-at: https://lore.kernel.org/lkml/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com/
> Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Reported-by: Qu Wenruo <wqu@suse.com>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>

I think we've beat this one to death.

Reviewed-by: Rob Herring <robh@kernel.org>
