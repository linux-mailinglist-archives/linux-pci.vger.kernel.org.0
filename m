Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12186608A98
	for <lists+linux-pci@lfdr.de>; Sat, 22 Oct 2022 11:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiJVJCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Oct 2022 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiJVJBb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Oct 2022 05:01:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1165B2F82C4;
        Sat, 22 Oct 2022 01:17:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0259860B6B;
        Sat, 22 Oct 2022 08:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F93C433D7;
        Sat, 22 Oct 2022 08:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666425972;
        bh=0sc7pZ0kQbpvTSEgZwUB5XBCnmITI1rrNWQTuHQ/qqI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jWTd6UfwV5jSwf9RzNKM3PEVuQd7ABwLDPhl41KZjwVeaOICugwADv/ExK0iSEEpD
         Ei+by3btZkM5xJWabuYfWHeqg9F9yewRpqapyfji9NHKiLzOd/BCT+RIz/7Mmn7+qQ
         hBjtbb1bxrRtOfynABPXPWr5WnVlCHXIHpb6cBaSjl3g/GZP7TxYthKgq/5MnzT0SQ
         0H5SC8HWiUQIp6XVyqoeJ/A5ci0UyFb9dU04o8nphudFFuV4MSVfhJSx7Q0xg091YV
         nEEcy337NxsHE0j36FIH5sgrW05x6ooj2E5/aXVkFxgNhvFPH6HW4OcQhVfczkEXVV
         qn4CboXOd9GiQ==
Received: by mail-ed1-f42.google.com with SMTP id e18so13797707edj.3;
        Sat, 22 Oct 2022 01:06:12 -0700 (PDT)
X-Gm-Message-State: ACrzQf3tIhBFquF1e5lnoRy9xUSzV2JZUBGArcMuY+lWo3htGV796mXU
        ZHRhgzRIAHEhvpHgGEJbgAhdgj1Mc2ICL8AsNlo=
X-Google-Smtp-Source: AMsMyM5emVi0xiH/tcLk8WIfKcO6mBG6El1sDLRfAWJwDsTRbazvgH+a8vqAbytV7mhHndxHo9l+sidtvpnDv3t7wGg=
X-Received: by 2002:a17:907:a06e:b0:79f:e42d:8d54 with SMTP id
 ia14-20020a170907a06e00b0079fe42d8d54mr2885325ejc.72.1666425970661; Sat, 22
 Oct 2022 01:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221022075955.11726-1-lvjianmin@loongson.cn>
In-Reply-To: <20221022075955.11726-1-lvjianmin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 22 Oct 2022 16:05:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7DrvgXwuGe5ayAKjP2YdNPoaT3xZg1vU2RDjReNkV9PQ@mail.gmail.com>
Message-ID: <CAAhV-H7DrvgXwuGe5ayAKjP2YdNPoaT3xZg1vU2RDjReNkV9PQ@mail.gmail.com>
Subject: Re: [PATCH V5 0/4] irqchip: Support to set irq type for ACPI path
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For the whole series:
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Sat, Oct 22, 2022 at 4:00 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
> For ACPI path of pch-pic and liointc driver, setting irq
> type is not supported yet, so the patch series add code
> to implement it.
>
> And a bug in translate callback of irqchip/loongson-pch-pic, which
> is introduced by previous patch, is fixed.
>
> GSI for legacy irqs of PCI devices are mapped in pch-pic domain, after
> supporting setting_irq_type for pch-pic domain, we add the workaround
> for LoongArch based PCI controller with high-level trigger intterrupt
> so that the high-level trigger type is passed into acpi_register_gsi().
>
> V1 -> V2
> - Change comment information and fix a bug for DT path in patch[1].
>
> V2 -> V3
> - Separate original patch[1] to three patches[1][2][3].
>
> V3 -> V4
> - Improve commit log
>
> V4 -> V5
> - Improve commit log for patch[1]
>
> Jianmin Lv (4):
>   ACPI / PCI: fix LPIC IRQ model default PCI IRQ polarity
>   irqchip/loongson-pch-pic: fix translate callback for DT path
>   irqchip/loongson-pch-pic: Support to set IRQ type for ACPI path
>   irqchip/loongson-liointc: Support to set IRQ type for ACPI path
>
>  drivers/acpi/pci_irq.c                 |  6 ++++--
>  drivers/irqchip/irq-loongson-liointc.c |  7 ++++++-
>  drivers/irqchip/irq-loongson-pch-pic.c | 14 ++++++++++----
>  3 files changed, 20 insertions(+), 7 deletions(-)
>
> --
> 2.31.1
>
>
