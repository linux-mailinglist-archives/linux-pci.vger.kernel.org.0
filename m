Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC284202A6
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhJCQXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 12:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhJCQXW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Oct 2021 12:23:22 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6418C0613EC;
        Sun,  3 Oct 2021 09:21:34 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id s137so6582603vke.11;
        Sun, 03 Oct 2021 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qRRfwZJhmxqi+2+u51qjiYBwGnqaigXoaasxBjBoXM=;
        b=eU3IOaOfGUBKRGL01mmNBtatdgLAThBzQygaEg2nojL5I3fcIM4hDJIBBXPyTpPbcf
         tf7RgHJc5Uym8beolT86Enl4lq00cNlryN5j8UIOB1miFrS7ElgzSKMOyVG0DFlhoE2s
         IQUYiTQ/skgV5HOOoCfaQ6/YnsZyclubnECM3XfAXNdrNEut691HKDdq+toxDNp6kbbN
         9inWayh6k+h3HyYV8r9TBecU1tkOTqFKj7t8b6qdNE6K8u4CSo/HAfj2WbE8xdCnrZcE
         UsHcVQJOYf5da7cwM5UWDAX6tMGR+5ij5KvsK7CbGb748ckt3F8f50wSxAzk0oL1XNI9
         fT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qRRfwZJhmxqi+2+u51qjiYBwGnqaigXoaasxBjBoXM=;
        b=TIn2x1IDa4AIbkwMcH1jYlBvW61ZIGK0rmJdlSq1lV00TNvR3LPrtgPkRZDVfFLMmA
         o8Zw1rw6yLsv1E4P37xELTZgTrjF/dNAKfdj3rqKwgJwMJfBkiJuOOea+vUSsWWP4Rfl
         VDaZPt8/MnzJs8G+/s/Km23/ltS8Jg9w7YwJ6iDTcjUfrFxMw3kRVP0r1NzdTDeL/Uqz
         K/wk0R0nWkHs7xwkbo+jICw87P4u3qQ9UH1lCL4rYakBtyZqg7N4qs6h9c7xvDFRqdGT
         +yEVkOjSF/1W9K6wMvT1O3PDWa9MOOeAT74bPivwQol9Rlrn/MreJ2cQbAA+VHmEZa9s
         UegQ==
X-Gm-Message-State: AOAM531JU8Xgxcj+EZdTg4p1CiZMI+Z5alAzDMJvyiqcQ5WMIlqvrPvw
        poyhwIoEIlMnw9U/IV/UMfLUWpgaaOzdOzFYEHU=
X-Google-Smtp-Source: ABdhPJxIZ8XYcpRKD5CmGahKwC2rLWUaIZzEBxfK9VvV+gVjRUFAErPJc3kLFKGfmEE+1JRpNf9Drt6ivnXuIAKrqpA=
X-Received: by 2002:a1f:1c57:: with SMTP id c84mr12626251vkc.22.1633278093113;
 Sun, 03 Oct 2021 09:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 3 Oct 2021 18:21:21 +0200
Message-ID: <CAMhs-H9p4xmPO2F_byk4DQncTGZayW1HwAzrPn_W0eEW5UUn9A@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] MIPS: ralink: fix PCI IO resources
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg,

On Sat, Sep 25, 2021 at 10:32 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> MIPs ralink need a special tratement regarding the way it handles PCI IO
> resources. On MIPS I/O ports are memory mapped, so we access them using normal
> load/store instructions. MIPS 'plat_mem_setup()' function does a call to
> 'set_io_port_base(KSEG1)'. There, variable 'mips_io_port_base'
> is set then using this address which is a virtual address to which all
> ports are being mapped. Ralink I/O space has a mapping of bus address
> equal to the window into the mmio space, with an offset of IO start range
> cpu address. This means that to have this working we need:
> - linux port numbers in the range 0-0xffff.
> - pci port numbers in the range 0-0xffff.
> - io_offset being zero.
>
> These means at the end to have bus address 0 mapped to IO range cpu address.
> We need a way of properly set 'mips_io_port_base' with a virtually mapped
> value of the IO cpu address.
>
> This series do the following approach:
> 1) Revert two bad commit from a previous attempt of make this work [0].
> 2) Set PCI_IOBASE to mips 'mips_io_port_base'.
> 3) Allow architecture dependent 'pci_remap_iospace'.
> 4) Implement 'pci_remap_iospace' for MIPS.
> 5) Be sure IOBASE address for IO window is set with correct value.
>
> More context about this series appoach in this mail thread [1].
>
> Patches related with reverts are from this merge cycle so they are only
> added to the staging git tree. So to have all stuff together I'd like to
> get everybody Ack's to get all of this series through staging tree if
> possible :).
>
> Thanks in advance for your time.
>
> Changes in v3:
>  - Collect Arnd's Acked-by for the patches.
>  - Be sure IO resource start address is zero and WARN_ONCE if it is not
>    on MIPS pci_remap_iospace() patch. Also make use of 'resource_size'
>    instead of do the logic explicitly again.

I think nothing is missing to get this added through the staging tree.

Thanks in advance for your time.

Best regards,
   Sergio Paracuellos

>
> Changes in v2:
>  - re-do commit messages for PCI patch as Bjorn pointed out in previous series.
>  - Add Bjorn's Acked-by for PCI subsystem patch.
>  - Re-do commit message of MIPS 'pci_remap_iospace()' patch to align with changes
>    in the PCI patch (s/architecture dependent/architecture-specific/)
>  - Add Fixes-by tag for MIPS set PCI_IOBASE patch.
>
> [0]: https://www.spinics.net/lists/kernel/msg4051474.html
> [1]: https://lkml.org/lkml/2021/9/22/6
> Sergio Paracuellos (6):
>   Revert "MIPS: ralink: don't define PC_IOBASE but increase
>     IO_SPACE_LIMIT"
>   Revert "staging: mt7621-pci: set end limit for 'ioport_resource'"
>   MIPS: ralink: set PCI_IOBASE to 'mips_io_port_base'
>   PCI: Allow architecture-specific pci_remap_iospace()
>   MIPS: implement architecture-specific 'pci_remap_iospace()'
>   staging: mt7621-pci: properly adjust base address for the IO window
>
>  arch/mips/include/asm/mach-ralink/spaces.h |  4 +++-
>  arch/mips/include/asm/pci.h                |  2 ++
>  arch/mips/pci/pci-generic.c                | 14 ++++++++++++++
>  drivers/pci/pci.c                          |  2 ++
>  drivers/staging/mt7621-pci/pci-mt7621.c    |  4 +---
>  5 files changed, 22 insertions(+), 4 deletions(-)
>
> --
> 2.25.1
>
