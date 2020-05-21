Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8234B1DC68E
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 07:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgEUFTe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 01:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgEUFTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 01:19:34 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C7CC061A0E
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 22:19:33 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w18so5749994ilm.13
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 22:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHAfficG5kr1zSpE5liDzM3e50KvBNcdKV+OfPohQjA=;
        b=HMgHqyX6RYxUwz1hGmpLCES/Rkti7Wpn5wV8nHosHQEJ4ulgE/nFgXEpSEKD/2K1+n
         +mZkAXVwStsmljUFvqLMXCJYW2peu6mzVCLxeCPMCqVlbcOJ9TkkvkCVFu+Jit/66weJ
         yVAN3IporBXxjmYwas6ebk13qRpq8UkxX0se0O294B3DAJQAEPRKPys4fiy4PCRsUPU9
         wvZNeu0UBmMBiVde276y19klNrFDHu1N/L6Hm1jzhHTV2FXGQbzGCrBJXYEbZM+wQKJK
         kRe+YGZw2/dwiQGe4Hyg/u3xpvNj4E5YwKcA0PWY6fDtkbZP6PQ8hiKriHrEnyJtPHVN
         7rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHAfficG5kr1zSpE5liDzM3e50KvBNcdKV+OfPohQjA=;
        b=WGFwF9cO7IkTh3u6HsyPLN8XyQVCVcDgjfeN+lbDatgXEOpDyu2PdHzOdpKRRVAp+S
         tFMf/kaWgvQTIxU93o4q2VQkay3ouNep01w1qGqjBz/Vv6EixdYDA02wwQBAk27/95i1
         qZJS2aTLR/NlBTSFa/wA/0B03mOYOJdxn5WYhZF7pM6dPN4De7CgesYTkpubbsgtoMtK
         hYTys4eQWrJyM4HkTsaQEe7e7/KjDca45iRdRLL1DHuH3Jx5X5WeLZDbCzVfSLuhYzba
         4fURNjY0Slqsk+XjvAgc1DewawkZl79BeKL6pMSd7Xn0hQIt137sfei8hZ6IZattTh+y
         Jdyg==
X-Gm-Message-State: AOAM533Df/6eYgdwT51Q0Cf+TU4ySg2xbq8cIwLhHXCU2qCZnQgwENT5
        Dug+aCj8P1m0u5p8FoDattpO3/hICjAQSG5/6qelsA==
X-Google-Smtp-Source: ABdhPJycaL+NzkieFfGTxG5dtp6ak3z1+M1pI5drFoNsm9dqeE0+7c9OGzbyaFRpZ80QjPECAhulvix1UEfH3cqVbvI=
X-Received: by 2002:a05:6e02:f81:: with SMTP id v1mr6807097ilo.246.1590038373289;
 Wed, 20 May 2020 22:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 21 May 2020 10:49:21 +0530
Message-ID: <CANAwSgStorF2HwcTYFC6Q6NzZtYq9qL-LLwq9ZU10oTgXVe9aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rockchip: Enable IO base and limit registers
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 21 May 2020 at 06:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> According to RK3399 user manual, bit 9 in PCIE_RC_BAR_CONF should
> be set, otherwise accessing to IO base and limit registers would
> fail.
>
> [    0.411318] pci_bus 0000:00: root bus resource [bus 00-1f]
> [    0.411822] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
> [    0.412440] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
> [    0.413665] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    0.414698] pci 0000:01:00.0: reg 0x10: initial BAR value 0x00000000 invalid
> [    0.415412] pci 0000:01:00.0: reg 0x18: initial BAR value 0x00000000 invalid
> [    0.418456] pci 0000:00:00.0: BAR 8: assigned [mem 0xfa000000-0xfa0fffff]
> [    0.419065] pci 0000:01:00.0: BAR 1: assigned [mem 0xfa000000-0xfa007fff pref]
> [    0.419728] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa008000-0xfa00ffff pref]
> [    0.420377] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0100]
> [    0.420935] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0100]
> [    0.421526] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0004]
> [    0.422084] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0004]
> [    0.422687] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.423135] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
> [    0.423794] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
> [    0.424566] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> [    0.425182] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
>
> 01:00.0 Class 0700: Device 1c00:3853 (rev 10) (prog-if 05)
>         Subsystem: Device 1c00:3853
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 230
>         Region 0: I/O ports at <unassigned> [disabled]
>         Region 1: Memory at fa000000 (32-bit, prefetchable) [disabled] [size=32K]
>         Region 2: I/O ports at <unassigned> [disabled]
>         [virtual] Expansion ROM at fa008000 [disabled] [size=32K]
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/pci/controller/pcie-rockchip.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index c53d132..f82452b 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -407,8 +407,11 @@ void rockchip_pcie_cfg_configuration_accesses(
>  {
>         u32 ob_desc_0;
>
> -       /* Configuration Accesses for region 0 */
> -       rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
> +       /*
> +        * Configuration Accesses for region 0.
> +        * Bit 9 is for enabling IO base and limit registers.
> +        */
> +       rockchip_pcie_write(rockchip, BIT(9), PCIE_RC_BAR_CONF);
>
>         rockchip_pcie_write(rockchip,
>                             (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
> --
> 2.7.4
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
