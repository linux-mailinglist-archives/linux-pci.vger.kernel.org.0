Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61925E1BA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgIDTJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 15:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgIDTJL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 15:09:11 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5860020684
        for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2020 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599246550;
        bh=TCPZF0BCr7XhHwdJhJ3pxbUkGTI8yYYTbUGfMjT6NZc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jgOEClJhvLyIIUagIf/bM3EtS0T/F/wmhfjEjONhrmfpfa3hOowhVeiSh4G5P5row
         ysXd8EJrgEG/xWtpPmfPY9w40r8N4tjY6aniPuIdNY/8FozDSdYhvJADonwPC4tmoS
         bs7AY/yw5P7v1ZHcg0xRUkk8Tqf0aL38NkNlYj7s=
Received: by mail-oi1-f181.google.com with SMTP id d189so7468823oig.12
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2020 12:09:10 -0700 (PDT)
X-Gm-Message-State: AOAM532kfzFJLQViVxjK3qEjWC4ce2EqYan6L2tCF3eBmrEK7w4GsKDP
        tcJ5fdw6GyGayJNre1mK2fZ15t0D6j2jCLmpiw==
X-Google-Smtp-Source: ABdhPJz5QN44ankXXYFuCaAywcNNTRCBjg8F44/2OgvqHCudRFlpGVdPxrIY2ITo9d3prW9E5oKhaA+bIm+eAvWnmmM=
X-Received: by 2002:aca:4cc7:: with SMTP id z190mr6372949oia.147.1599246549523;
 Fri, 04 Sep 2020 12:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200904141607.4066-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200904141607.4066-1-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Sep 2020 13:08:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+KmEFU5CG1JF1+RnMUTgvZVLn1LzwJs8i6YFE8L+prRg@mail.gmail.com>
Message-ID: <CAL_Jsq+KmEFU5CG1JF1+RnMUTgvZVLn1LzwJs8i6YFE8L+prRg@mail.gmail.com>
Subject: Re: [PATCH] ARM/PCI: Remove struct msi_controller from struct hw_pci
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 4, 2020 at 8:16 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> The msi_ctrl field in struct hw_pci is currently unused by arm/mach
> PCI host controller drivers.

And we won't be adding any new users.

>
> Remove it.

io_optional and align_resource fields are also unused.

>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> ---
>  arch/arm/include/asm/mach/pci.h | 1 -
>  arch/arm/kernel/bios32.c        | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 83d340702680..f3a284e6a90b 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -17,7 +17,6 @@ struct pci_host_bridge;
>  struct device;
>
>  struct hw_pci {
> -       struct msi_controller *msi_ctrl;
>         struct pci_ops  *ops;
>         int             nr_controllers;
>         unsigned int    io_optional:1;
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index eecec16aa708..6b73e60cf95a 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -480,7 +480,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>                                 bridge->sysdata = sys;
>                                 bridge->busnr = sys->busnr;
>                                 bridge->ops = hw->ops;
> -                               bridge->msi = hw->msi_ctrl;
>                                 bridge->align_resource =
>                                                 hw->align_resource;
>
> --
> 2.26.1
>
