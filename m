Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F161A2D13BB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 15:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgLGOau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 09:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgLGOat (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 09:30:49 -0500
X-Gm-Message-State: AOAM531uUYEkv20U0x0x2NbUH97S9gG3b529ogGu3WDi/DdXa3o1IfiQ
        mlYzIXHcniBzVphIQtmM/6DqHsuWQf6oO3aPpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607351409;
        bh=acaha1SjfBv/rkDKX7PJ34f0Uv6akVa2YH1Mnph46kk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mnL+QVn4XfChBXwRU4uL+LPIm0t8gkJfPUr5o7aUnVO0vCXhYgWGsnQzabgewze9G
         RwAAm7m5MEkbY8Njkwcwt3Ry4NqISWYMJUiRr07a9BWHt9BrXh+jlL/G5TyuVQ7tkE
         A/lehEiSSIw5xfknLsKPj7w1pfXPokXC2EjsKNoUhCi1WVW/ymbPcMJul6R2VZclp1
         kFf4vKfMEAbetN+Zjml9P9fbaxDjmtcJnKkm89RGOq56XMNlKvUle32UUbj6G5kZKa
         yC1L29LbP0XtyU8wZlFUfFg5NI6hWrfliqVlHVc8InmeDip3wvMXw+pDZfiwcIZtO+
         2BR9fRCC4k4rg==
X-Google-Smtp-Source: ABdhPJxqklrPX0IcyP2tknUeh4lHzwv6f3av77/80EoJOH5kKzWCM4KP12Iq8W8OLFXe/QMgg1+h0jK4qQ6XczDGlSo=
X-Received: by 2002:a17:906:6713:: with SMTP id a19mr19850972ejp.468.1607351407416;
 Mon, 07 Dec 2020 06:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20201204075117.10430-1-kishon@ti.com> <20201204075117.10430-2-kishon@ti.com>
In-Reply-To: <20201204075117.10430-2-kishon@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 7 Dec 2020 08:29:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQju8TUZA-wu=WA-5XH4H9s2ifO8Hf4TnT5epa=Gg1ng@mail.gmail.com>
Message-ID: <CAL_JsqJQju8TUZA-wu=WA-5XH4H9s2ifO8Hf4TnT5epa=Gg1ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: pci: ti,j721e: Fix
 "ti,syscon-pcie-ctrl" to take argument
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 4, 2020 at 1:52 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Fix binding documentation of "ti,syscon-pcie-ctrl" to take phandle with
> argument. The argument is the register offset within "syscon" used to
> configure PCIe controller. This change is as discussed in [1]
>
> [1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
>
> Fixes: 431b53b81cdc ("dt-bindings: PCI: Add host mode dt-bindings for TI's J721E SoC")
> Fixes: 45b39e928966 ("dt-bindings: PCI: Add EP mode dt-bindings for TI's J721E SoC")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml      | 11 +++++++----
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml    | 11 +++++++----
>  2 files changed, 14 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
