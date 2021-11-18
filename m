Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D881145654D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 23:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhKRWGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 17:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhKRWGe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Nov 2021 17:06:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CB6A61A8E
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 22:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637273013;
        bh=vX3umlUBDDVxxQsh3b+QeqeE59AHALbs4H/k7p9f754=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rSoIZ7wNLppbH4GLk103ncZsnNkkF9eIiJzwQYv+awphJFhq5iCQpG8/WgSmw+nNO
         UkdSv8JFRt18SMESYoDLy2fW+0X165WmaOc8u9fmVt3DKJqLw3sr62z0Yqgrq2LZ3c
         pCaCrvorg9oW3PPXAwEee29BSqroEet9fsl/ryEkaWOOYhZT9wZkgLYeOGXdyffrSC
         0r2cm2j5UxUcTGGBbjsrC6fJFu1yL6tQHUjdjcuNb7MPSTISm96tzpuLsiP/rkdD3h
         u8CkJGVqmvys0VFMwytbLuLkRQJdha6ZTWEpfg1HSa9BEBUFcpbkTcuAjroacCdrGm
         ZBwt4+MS8E5mA==
Received: by mail-ed1-f54.google.com with SMTP id w1so33534621edc.6
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 14:03:33 -0800 (PST)
X-Gm-Message-State: AOAM532z8ELE62XdmmcIwccWMkvfPa4Lc1JfNa2xIutglRXlKJPKOqDw
        zOCnHp7fU/Quh0JZa+lH1qIcKGG+PDU5MoSWZw==
X-Google-Smtp-Source: ABdhPJzkV0NRt7yTjja986l4xn9dLSNpdagXK/ydBzFUZZz6BFw4lPI9nEyPQ7IyaLR9k/bqYbNJ0wWjB665+sOs7D8=
X-Received: by 2002:a17:907:3f24:: with SMTP id hq36mr1052387ejc.390.1637273011627;
 Thu, 18 Nov 2021 14:03:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com>
 <CAL_JsqL8ofiJv4gyP+rnDEKxjd5+ANL3XwhxaSF13aznvGpE9g@mail.gmail.com>
In-Reply-To: <CAL_JsqL8ofiJv4gyP+rnDEKxjd5+ANL3XwhxaSF13aznvGpE9g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Nov 2021 16:03:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKrfpDtQZMMuhA_tURit6fO82FzPbKA40o6_8jWRewm8g@mail.gmail.com>
Message-ID: <CAL_JsqKrfpDtQZMMuhA_tURit6fO82FzPbKA40o6_8jWRewm8g@mail.gmail.com>
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

On Thu, Nov 18, 2021 at 3:20 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Nov 18, 2021 at 12:10 PM St=C3=A9phane Graber <stgraber@ubuntu.co=
m> wrote:
> >
> > Hello,
> >
> > I've recently been given access to a set of 4 APM X-Gene2 Merlin
> > boards (old-ish development platform).
> > Running them on Ubuntu 20.04's stock 5.4 kernel worked fine but trying
> > to run anything else would fail to boot due to a NVME initialization
> > timeout preventing the main drive from showing up at all.
> >
> > Tracking this issue, I first moved to clean mainline kernels and then
> > isolated the issue to be somewhere between 5.4.0 and 5.5.0-rc1, which
> > sadly meant the merge window (so much for a quick bisect...). I've
> > then bisected between those two points and came up with:
> >
> >   6dce5aa59e0bf2430733d7a8b11c205ec10f408e (refs/bisect/bad) PCI:
> > xgene: Use inbound resources for setup
> >
> > I finally switched to the latest 5.15.2 tree, reverted that one
> > commit, built a new kernel and confirmed that those boards now work
> > flawlessly.
> >
> > Unfortunately that's about the extent of my abilities with kernel
> > debugging and I won't pretend to understand what that commit does or
> > how it may be breaking PCIe initialization on those systems.
> >
> > I'm not technically blocked on this, I can manually build my own
> > kernels by reverting that one commit every time, but that's obviously
> > not ideal and I'd much rather have this fixed upstream :)
>
> Doesn't this platform have ACPI f/w you can use? From the log, it
> looks like ACPI tables are passed to the kernel, but since a full DT
> is passed it is used by default. Does 'acpi=3Don' not work?
>
> Given no one noticed the breakage for 2 years, I'd really like to
> remove these dts and binding files otherwise someone needs to convert
> bindings to schema and fix warnings. Current stats look like this:
> Processing apm:
> warnings: 240
> undocumented compat: 114
>
> For example, I noticed that dma-ranges declares the entries are 32-bit
> (0x42000000 is 32-bit prefetch), yet the PCI bus address and sizes are
> >32-bit. AFAICT, that isn't part of the problem here.
>
> > =3D=3D Good boot on 5.15.2 (commit reverted) =3D=3D
> > Full log at: https://gist.github.com/stgraber/e489b7e55dd7ffaac9f77dd86=
34ca2ff
> >
> > root@entak:~# dmesg | grep -Ei "nvme|pci"
> > [    0.094146] PCI: CLS 0 bytes, default 64
> > [    0.130573] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
> > [    0.131324] xgene-pcie 1f2b0000.pcie: host bridge /soc/pcie@1f2b0000=
 ranges:
> > [    0.131344] xgene-pcie 1f2b0000.pcie:   No bus range found for
> > /soc/pcie@1f2b0000, using [bus 00-ff]
> > [    0.131365] xgene-pcie 1f2b0000.pcie:       IO
> > 0xc010000000..0xc01000ffff -> 0x0000000000
> > [    0.131388] xgene-pcie 1f2b0000.pcie:      MEM
> > 0xc120000000..0xc13fffffff -> 0x0020000000
> > [    0.131401] xgene-pcie 1f2b0000.pcie:      MEM
> > 0xe000000000..0xffffffffff -> 0xe000000000
> > [    0.131416] xgene-pcie 1f2b0000.pcie:   IB MEM
> > 0x8000000000..0x807fffffff -> 0x8000000000
> > [    0.131427] xgene-pcie 1f2b0000.pcie:   IB MEM
> > 0x0000000000..0x7fffffffff -> 0x0000000000
>
> My best guess is while the above is the parsed order of 'IB MEM'
> regions, we sort the entries by address now and that changes which
> inbound registers get used for each region. And one doesn't handle >
> 32-bit addresses. Can you try out this change? It's not what I want
> for a final change because the code is just as fragile:

Actually, a better change is this:

diff --git a/drivers/pci/controller/pci-xgene.c
b/drivers/pci/controller/pci-xgene.c
index 56d0d50338c8..d83dbd977418 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -465,7 +465,7 @@ static int xgene_pcie_select_ib_reg(u8
*ib_reg_mask, u64 size)
                return 1;
        }

-       if ((size > SZ_1K) && (size < SZ_1T) && !(*ib_reg_mask & (1 << 0)))=
 {
+       if ((size > SZ_1K) && (size < SZ_4G) && !(*ib_reg_mask & (1 << 0)))=
 {
                *ib_reg_mask |=3D (1 << 0);
                return 0;
        }
