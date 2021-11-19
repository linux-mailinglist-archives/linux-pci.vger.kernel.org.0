Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E720945694F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 05:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhKSErI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 18 Nov 2021 23:47:08 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34846
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhKSErI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 23:47:08 -0500
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4A21E40079
        for <linux-pci@vger.kernel.org>; Fri, 19 Nov 2021 04:44:06 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id m27so37203029lfj.12
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 20:44:06 -0800 (PST)
X-Gm-Message-State: AOAM530WlR2K+eu70P228yIL6ix/Wmnagat7cckWMXBt0l9D/4jv4eN7
        +4eQFh7J6AKh1yDMmuinloI+J5fDxnCL0vt8hhpDug==
X-Google-Smtp-Source: ABdhPJxxVw3CxiCDUCwoHU2pcBXmDs3+8o9d5fBniGdWGBnDBI0uh+Mk9UpDIf4ZR7Tgqc9Cba5Nk+tDPxWCdzGetnA=
X-Received: by 2002:ac2:4281:: with SMTP id m1mr30335872lfh.168.1637297045646;
 Thu, 18 Nov 2021 20:44:05 -0800 (PST)
MIME-Version: 1.0
References: <CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com>
 <CAL_JsqL8ofiJv4gyP+rnDEKxjd5+ANL3XwhxaSF13aznvGpE9g@mail.gmail.com> <CAL_JsqKrfpDtQZMMuhA_tURit6fO82FzPbKA40o6_8jWRewm8g@mail.gmail.com>
In-Reply-To: <CAL_JsqKrfpDtQZMMuhA_tURit6fO82FzPbKA40o6_8jWRewm8g@mail.gmail.com>
From:   =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>
Date:   Thu, 18 Nov 2021 23:43:54 -0500
X-Gmail-Original-Message-ID: <CA+enf=uZex3hC+HxahV25cSFyp9Hz7bLC-h=PnUKEUydDh1Tmw@mail.gmail.com>
Message-ID: <CA+enf=uZex3hC+HxahV25cSFyp9Hz7bLC-h=PnUKEUydDh1Tmw@mail.gmail.com>
Subject: Re: PCIe regression on APM Merlin (aarch64 dev platform) preventing
 NVME initialization
To:     Rob Herring <robh@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 18, 2021 at 5:03 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Nov 18, 2021 at 3:20 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Nov 18, 2021 at 12:10 PM Stéphane Graber <stgraber@ubuntu.com> wrote:
> > >
> > > Hello,
> > >
> > > I've recently been given access to a set of 4 APM X-Gene2 Merlin
> > > boards (old-ish development platform).
> > > Running them on Ubuntu 20.04's stock 5.4 kernel worked fine but trying
> > > to run anything else would fail to boot due to a NVME initialization
> > > timeout preventing the main drive from showing up at all.
> > >
> > > Tracking this issue, I first moved to clean mainline kernels and then
> > > isolated the issue to be somewhere between 5.4.0 and 5.5.0-rc1, which
> > > sadly meant the merge window (so much for a quick bisect...). I've
> > > then bisected between those two points and came up with:
> > >
> > >   6dce5aa59e0bf2430733d7a8b11c205ec10f408e (refs/bisect/bad) PCI:
> > > xgene: Use inbound resources for setup
> > >
> > > I finally switched to the latest 5.15.2 tree, reverted that one
> > > commit, built a new kernel and confirmed that those boards now work
> > > flawlessly.
> > >
> > > Unfortunately that's about the extent of my abilities with kernel
> > > debugging and I won't pretend to understand what that commit does or
> > > how it may be breaking PCIe initialization on those systems.
> > >
> > > I'm not technically blocked on this, I can manually build my own
> > > kernels by reverting that one commit every time, but that's obviously
> > > not ideal and I'd much rather have this fixed upstream :)
> >
> > Doesn't this platform have ACPI f/w you can use? From the log, it
> > looks like ACPI tables are passed to the kernel, but since a full DT
> > is passed it is used by default. Does 'acpi=on' not work?

Gave that a try with a clean 5.15.2 and unfortunately it's not booting
at all, all I get is:

Loading Linux 5.15.2 ...
Loading initial ramdisk ...
EFI stub: Booting Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable
EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 64k boundary
EFI stub: ERROR: FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...
L3C: 8MB

> > Given no one noticed the breakage for 2 years, I'd really like to
> > remove these dts and binding files otherwise someone needs to convert
> > bindings to schema and fix warnings. Current stats look like this:
> > Processing apm:
> > warnings: 240
> > undocumented compat: 114
> >
> > For example, I noticed that dma-ranges declares the entries are 32-bit
> > (0x42000000 is 32-bit prefetch), yet the PCI bus address and sizes are
> > >32-bit. AFAICT, that isn't part of the problem here.
> >
> > > == Good boot on 5.15.2 (commit reverted) ==
> > > Full log at: https://gist.github.com/stgraber/e489b7e55dd7ffaac9f77dd8634ca2ff
> > >
> > > root@entak:~# dmesg | grep -Ei "nvme|pci"
> > > [    0.094146] PCI: CLS 0 bytes, default 64
> > > [    0.130573] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > > [    0.131324] xgene-pcie 1f2b0000.pcie: host bridge /soc/pcie@1f2b0000 ranges:
> > > [    0.131344] xgene-pcie 1f2b0000.pcie:   No bus range found for
> > > /soc/pcie@1f2b0000, using [bus 00-ff]
> > > [    0.131365] xgene-pcie 1f2b0000.pcie:       IO
> > > 0xc010000000..0xc01000ffff -> 0x0000000000
> > > [    0.131388] xgene-pcie 1f2b0000.pcie:      MEM
> > > 0xc120000000..0xc13fffffff -> 0x0020000000
> > > [    0.131401] xgene-pcie 1f2b0000.pcie:      MEM
> > > 0xe000000000..0xffffffffff -> 0xe000000000
> > > [    0.131416] xgene-pcie 1f2b0000.pcie:   IB MEM
> > > 0x8000000000..0x807fffffff -> 0x8000000000
> > > [    0.131427] xgene-pcie 1f2b0000.pcie:   IB MEM
> > > 0x0000000000..0x7fffffffff -> 0x0000000000
> >
> > My best guess is while the above is the parsed order of 'IB MEM'
> > regions, we sort the entries by address now and that changes which
> > inbound registers get used for each region. And one doesn't handle >
> > 32-bit addresses. Can you try out this change? It's not what I want
> > for a final change because the code is just as fragile:
>
> Actually, a better change is this:
>
> diff --git a/drivers/pci/controller/pci-xgene.c
> b/drivers/pci/controller/pci-xgene.c
> index 56d0d50338c8..d83dbd977418 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -465,7 +465,7 @@ static int xgene_pcie_select_ib_reg(u8
> *ib_reg_mask, u64 size)
>                 return 1;
>         }
>
> -       if ((size > SZ_1K) && (size < SZ_1T) && !(*ib_reg_mask & (1 << 0))) {
> +       if ((size > SZ_1K) && (size < SZ_4G) && !(*ib_reg_mask & (1 << 0))) {
>                 *ib_reg_mask |= (1 << 0);
>                 return 0;
>         }

Just tested it, and it booted just fine!

Full boot log: https://gist.github.com/stgraber/41b2419ef88611ab7a2b4dceb028b4f7

Stéphane
