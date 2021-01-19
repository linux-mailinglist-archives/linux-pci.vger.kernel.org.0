Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B342FAFA0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 05:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbhASEhc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 23:37:32 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:40048 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbhASEdl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2021 23:33:41 -0500
Received: by mail-lf1-f50.google.com with SMTP id v24so20577847lfr.7;
        Mon, 18 Jan 2021 20:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6N+mtJnAllpPqS59taAIm6aHXmVEI3uucSUB9g2qkoQ=;
        b=VIPWjiecJyU8Lw2ZPDoI5NjzdbI72osiUVxaFoEadamdVx1uvG4KozptDDYE37pDQX
         /JJ6ugdGuGIgS6RnQEJZaYe+AXNjh9Ytk5/NSs6uUmABgqgyoBA2QKx0Qm04iHz88TeL
         OFWGwJRHR12PJhsVFkMygzsz2NXnZlmW+Da7EZXDEN7oSpw9xvEJXy28QtO950wKSSJl
         ea/vqVgOKLsTmP0telCJIfpJr5cmw3pD1TlNtplSa6150eX+r64oAEWnRHDFEiZRhZIo
         305ediMKx3wWKwBuswRqeoLJ7qhyOmCMCVZYNjmmHPeEXAdhDwmpcHeNECg8sUXPxW/1
         1DiA==
X-Gm-Message-State: AOAM532zhopB3UiffNqKimlr1cRxcQAJ07cUf6QbJo0nNfxkEEDDgR6D
        Eb1m9Bj7tcYJkgxsjAvQiB0r2sU8gOU39Q==
X-Google-Smtp-Source: ABdhPJytOkHd/csUxWnIN9wrsx6Xzf/CwbF8B2rkm2tnFbLQr7/fpL6gx2O0kj9naDGK3tioA8JBOA==
X-Received: by 2002:a19:991:: with SMTP id 139mr1042089lfj.637.1611030777529;
        Mon, 18 Jan 2021 20:32:57 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id h1sm2147623lfc.121.2021.01.18.20.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 20:32:57 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id v24so20577782lfr.7;
        Mon, 18 Jan 2021 20:32:56 -0800 (PST)
X-Received: by 2002:ac2:4d44:: with SMTP id 4mr1116418lfp.296.1611030776537;
 Mon, 18 Jan 2021 20:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20210106134617.391-1-wens@kernel.org>
In-Reply-To: <20210106134617.391-1-wens@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 19 Jan 2021 12:32:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v64oCaS14ATUi+y6ZQTkZCqGxnskM=zFkoQp_-jVanu_Vw@mail.gmail.com>
Message-ID: <CAGb2v64oCaS14ATUi+y6ZQTkZCqGxnskM=zFkoQp_-jVanu_Vw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] arm64: rockchip: Fix PCIe ep-gpios requirement and
 Add Nanopi M4B
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Jan 6, 2021 at 9:46 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> Hi everyone,
>
> This is v3 of my Nanopi M4B series. Changes since v2 include:
>
>   - Replaced dev_err() with dev_err_probe() for gpiod_get_optional() error
>   - Added Reviewed-by tag from Robin Murphy for patch 3
>
> Changes since v1 include:
>
>   - Rewrite subject of patch 1 to match existing convention and reference
>     'ep-gpios' DT property instead of the 'ep_gpio' field
>
> This series mainly adds support for the new Nanopi M4B, which is a newer
> variant of the Nanopi M4.
>
> The differences against the original Nanopi M4 that are common with the
> other M4V2 revision include:
>
>   - microphone header removed
>   - power button added
>   - recovery button added
>
> Additional changes specific to the M4B:
>
>   - USB 3.0 hub removed; board now has 2x USB 3.0 type-A ports and 2x
>     USB 2.0 ports
>   - ADB toggle switch added; this changes the top USB 3.0 host port to
>     a peripheral port
>   - Type-C port no longer supports data or PD
>   - WiFi/Bluetooth combo chip switched to AP6256, which supports BT 5.0
>     but only 1T1R (down from 2T2R) for WiFi
>
> While working on this, I found that for the M4 family, the PCIe reset
> pin (from the M.2 expansion board) was not wired to the SoC. Only the
> NanoPC T4 has this wired. This ended up in patches 1 and 3.
>
> Patch 1 makes ep_gpio in the Rockchip PCIe driver optional. This property
> is optional in the DT binding, so this just makes the driver adhere to
> the binding.
>
> Patch 2 adds a new compatible string for the new board.
>
> Patch 3 moves the ep-gpios property of the pcie controller from the
> common nanopi4.dtsi file to the nanopc-t4.dts file.
>
> Patch 4 adds a new device tree file for the new board. It includes the
> original device tree for the M4, and then lists the differences.
>
> Given that patch 3 would make PCIe unusable without patch 1, I suggest
> merging patch 1 through the PCI tree as a fix for 5.10, and the rest
> for 5.11 through the Rockchip tree.

Gentle ping. I would really like to get the PCIe controller fix merged
before -rc6 (cut-off for arm-soc -next) and be able to get the new board
into 5.12. Or we could have all of them merged for 5.12, though depending
on the order the PRs are sent and merged by Linus there would be a possible
window where PCIe doesn't work for the Nanopi M4's.


Thanks
ChenYu

> Please have a look. The changes are mostly trivial.
>
>
> Regards
> ChenYu
>
> Chen-Yu Tsai (4):
>   PCI: rockchip: Make 'ep-gpios' DT property optional
>   dt-bindings: arm: rockchip: Add FriendlyARM NanoPi M4B
>   arm64: dts: rockchip: nanopi4: Move ep-gpios property to nanopc-t4
>   arm64: dts: rockchip: rk3399: Add NanoPi M4B
>
>  .../devicetree/bindings/arm/rockchip.yaml     |  1 +
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../boot/dts/rockchip/rk3399-nanopc-t4.dts    |  1 +
>  .../boot/dts/rockchip/rk3399-nanopi-m4b.dts   | 52 +++++++++++++++++++
>  .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |  1 -
>  drivers/pci/controller/pcie-rockchip.c        |  5 +-
>  6 files changed, 58 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts
>
> --
> 2.29.2
>
