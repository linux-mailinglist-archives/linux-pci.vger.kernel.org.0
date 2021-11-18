Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08D74564FD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 22:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhKRVYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 16:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhKRVYJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Nov 2021 16:24:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF35611C4
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 21:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637270468;
        bh=8+4QaSmgKHT5mc8WsQD+7ObwcrhjfhaDLN9egxbyGY0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jBp9WgLUMQs0OCDhpHvvkXGC2Lar8lR0FsixA3bAMSdx6USJjr8YiugfzfEeNNto4
         Ycr4IuD5d4XaF8m/gwJUpGxJ9DwkqqNQ61lvG8JYnvoIVy+NSGrANIksKq3FklqBsI
         14m8W5w1OtL9ED42RhulvOJiWva1p64piMPmTIg/0sgWGVsyym7YClZX/fpJlCUIiJ
         v9YNrrCWZMAPnOxFaAHFeJK2PjrMTtR0/ICwvFsigYmrIMVUouBagqTqdKSh0TTdTa
         IAMp1QR4XRFAUjiH/bAezflcOg90LoEsFblUptA23SbPbKye6QB9MJl07j7dXdJC5h
         /vzOnPFtolBjQ==
Received: by mail-ed1-f54.google.com with SMTP id y12so33039779eda.12
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 13:21:08 -0800 (PST)
X-Gm-Message-State: AOAM533TY9jE/zxvUvOAz7E8xi2VMEQo13AG9X44i+Nez0CsykPCls9t
        jYuZdeQyL5msm4Oq2T2mQnFwyg7p76ciEYS0zw==
X-Google-Smtp-Source: ABdhPJwXjw9gbrBu5jOQxSYldcAMBsrfAx3gbrbawtQtIsRGycmlCb8B1wgc8fl8QEUpLb2IwHrenN7CLuNpffLoFS8=
X-Received: by 2002:a17:907:a411:: with SMTP id sg17mr776101ejc.84.1637270466925;
 Thu, 18 Nov 2021 13:21:06 -0800 (PST)
MIME-Version: 1.0
References: <CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com>
In-Reply-To: <CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Nov 2021 15:20:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL8ofiJv4gyP+rnDEKxjd5+ANL3XwhxaSF13aznvGpE9g@mail.gmail.com>
Message-ID: <CAL_JsqL8ofiJv4gyP+rnDEKxjd5+ANL3XwhxaSF13aznvGpE9g@mail.gmail.com>
Subject: Re: PCIe regression on APM Merlin (aarch64 dev platform) preventing
 NVME initialization
To:     =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 18, 2021 at 12:10 PM St=C3=A9phane Graber <stgraber@ubuntu.com>=
 wrote:
>
> Hello,
>
> I've recently been given access to a set of 4 APM X-Gene2 Merlin
> boards (old-ish development platform).
> Running them on Ubuntu 20.04's stock 5.4 kernel worked fine but trying
> to run anything else would fail to boot due to a NVME initialization
> timeout preventing the main drive from showing up at all.
>
> Tracking this issue, I first moved to clean mainline kernels and then
> isolated the issue to be somewhere between 5.4.0 and 5.5.0-rc1, which
> sadly meant the merge window (so much for a quick bisect...). I've
> then bisected between those two points and came up with:
>
>   6dce5aa59e0bf2430733d7a8b11c205ec10f408e (refs/bisect/bad) PCI:
> xgene: Use inbound resources for setup
>
> I finally switched to the latest 5.15.2 tree, reverted that one
> commit, built a new kernel and confirmed that those boards now work
> flawlessly.
>
> Unfortunately that's about the extent of my abilities with kernel
> debugging and I won't pretend to understand what that commit does or
> how it may be breaking PCIe initialization on those systems.
>
> I'm not technically blocked on this, I can manually build my own
> kernels by reverting that one commit every time, but that's obviously
> not ideal and I'd much rather have this fixed upstream :)

Doesn't this platform have ACPI f/w you can use? From the log, it
looks like ACPI tables are passed to the kernel, but since a full DT
is passed it is used by default. Does 'acpi=3Don' not work?

Given no one noticed the breakage for 2 years, I'd really like to
remove these dts and binding files otherwise someone needs to convert
bindings to schema and fix warnings. Current stats look like this:
Processing apm:
warnings: 240
undocumented compat: 114

For example, I noticed that dma-ranges declares the entries are 32-bit
(0x42000000 is 32-bit prefetch), yet the PCI bus address and sizes are
>32-bit. AFAICT, that isn't part of the problem here.

> =3D=3D Good boot on 5.15.2 (commit reverted) =3D=3D
> Full log at: https://gist.github.com/stgraber/e489b7e55dd7ffaac9f77dd8634=
ca2ff
>
> root@entak:~# dmesg | grep -Ei "nvme|pci"
> [    0.094146] PCI: CLS 0 bytes, default 64
> [    0.130573] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
.4
> [    0.131324] xgene-pcie 1f2b0000.pcie: host bridge /soc/pcie@1f2b0000 r=
anges:
> [    0.131344] xgene-pcie 1f2b0000.pcie:   No bus range found for
> /soc/pcie@1f2b0000, using [bus 00-ff]
> [    0.131365] xgene-pcie 1f2b0000.pcie:       IO
> 0xc010000000..0xc01000ffff -> 0x0000000000
> [    0.131388] xgene-pcie 1f2b0000.pcie:      MEM
> 0xc120000000..0xc13fffffff -> 0x0020000000
> [    0.131401] xgene-pcie 1f2b0000.pcie:      MEM
> 0xe000000000..0xffffffffff -> 0xe000000000
> [    0.131416] xgene-pcie 1f2b0000.pcie:   IB MEM
> 0x8000000000..0x807fffffff -> 0x8000000000
> [    0.131427] xgene-pcie 1f2b0000.pcie:   IB MEM
> 0x0000000000..0x7fffffffff -> 0x0000000000

My best guess is while the above is the parsed order of 'IB MEM'
regions, we sort the entries by address now and that changes which
inbound registers get used for each region. And one doesn't handle >
32-bit addresses. Can you try out this change? It's not what I want
for a final change because the code is just as fragile:

diff --git a/drivers/pci/controller/pci-xgene.c
b/drivers/pci/controller/pci-xgene.c
index 56d0d50338c8..18f05b65439e 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -465,16 +465,16 @@ static int xgene_pcie_select_ib_reg(u8
*ib_reg_mask, u64 size)
                return 1;
        }

-       if ((size > SZ_1K) && (size < SZ_1T) && !(*ib_reg_mask & (1 << 0)))=
 {
-               *ib_reg_mask |=3D (1 << 0);
-               return 0;
-       }
-
        if ((size > SZ_1M) && (size < SZ_1T) && !(*ib_reg_mask & (1 << 2)))=
 {
                *ib_reg_mask |=3D (1 << 2);
                return 2;
        }

+       if ((size > SZ_1K) && (size < SZ_1T) && !(*ib_reg_mask & (1 << 0)))=
 {
+               *ib_reg_mask |=3D (1 << 0);
+               return 0;
+       }
+
        return -EINVAL;
 }
