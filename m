Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69892116837
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 09:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfLIIcY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 03:32:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53437 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfLIIcX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 03:32:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id n9so13922466wmd.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 00:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=emf4IJEEMsmxfQFP3fayTObEfLJTqttr7F9XFtfzuqY=;
        b=l2RINiniKcey/jhYyNEjboTgQuFh87XyROBMa0gj84/Vm4tnZlbyZamK6aJYwRdYBn
         uqHL+5kmm95wY5dB41OWQXTWCUveOtySqUfhMwfer/v8Zb1TYo9st7wgVs1pPSWwjQnE
         CTWybUczEiNtygy24UTDLkRuDSYBdDwHu6Rw5oEQYbRCuQN3N1sOmM/QgTGJrqYK/+gd
         ZsBs5IBMow3rG8I+aOTopBP+NLYSYP93vryqBdFCNpkC9MIh76Nwq73qdxpBNEwpOy40
         MLrjAHDJQUIoyS8+q75zjNhm3Z0PuAC7sNYZQKTbpnxuI+nQ0TAGdRfv5aoeVP8gz0BD
         SLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=emf4IJEEMsmxfQFP3fayTObEfLJTqttr7F9XFtfzuqY=;
        b=Pk5okkjecSVB5rQW3mTrj/ezlH1bXt8TtVnvJ/G8SCLgfMfemR1nx4EGFZhGY9p5Zm
         nifS/ymGh0bnCB+R10xENuYyBxaas1OsjWI2xPbG++DFI7oY/ny8mKhSsq1D42sbK82x
         aKzX+i8weJU5gPvFi0IvLFhW/b+K62e6DJNCfqaOTvWnqKBYtJT97CI/Ojkm8uYUfcbe
         gH9PpfXhzlIhjUfgKNWP0JkUsdgIKqG3ZFY5e9NK3jjfCiisg2Vxwbc0k8nVin6w939E
         6BdncFG2MV442+B36mUww2Lrf4d4FMqKGYV0bJFI/AVjp5/pEJaQIsv43DxgH4XrMARL
         pmrA==
X-Gm-Message-State: APjAAAUfDTaDOLecbDLfjf2vfrRwdoDsYuzWHJOQ0b5YE26jXZmzewOQ
        W7WMtsyn7umTgqUK4c9Quywp9Q==
X-Google-Smtp-Source: APXvYqzCeYkH/XjSzuD2xv6U2QTFu/p0/ipUgx0/xb5fgeGV8FOzVH5MhgwTY08LUaCdUwXNjXg2fA==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr22522732wml.141.1575880340584;
        Mon, 09 Dec 2019 00:32:20 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id v188sm13242989wma.10.2019.12.09.00.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:32:19 -0800 (PST)
References: <20191208210320.15539-1-repk@triplefau.lt>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@Amlogic.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: amlogic: Make PCIe working reliably on AXG platforms
In-reply-to: <20191208210320.15539-1-repk@triplefau.lt>
Date:   Mon, 09 Dec 2019 09:32:18 +0100
Message-ID: <1jpngxew6l.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Sun 08 Dec 2019 at 22:03, Remi Pommarel <repk@triplefau.lt> wrote:

> PCIe device probing failures have been seen on some AXG platforms and were
> due to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit
> solved the problem. After being contacted about this, vendor reported that
> this bit was linked to PCIe PLL CML output.

Thanks for reporting the problem.

As Martin pointed out, the CML outputs already exist in the AXG clock
controller but are handled using HHI_PCIE_PLL_CNTL6. Although
incomplete, it seems to be aligned with the datasheet I have (v0.9)

According to the same document, HHI_MIPI_CNTL0 belong to the MIPI Phy.
Unfortunately bit 26 is not documented

AFAICT, the clock controller is not appropriate driver to deal with this
register/bit

>
> This serie adds a way to set this bit through AXG clock gating logic.
> Platforms having this kind of issue could make use of this gating by
> applying a patch to their devicetree similar to:
>
>                 clocks = <&clkc CLKID_USB
>                         &clkc CLKID_MIPI_ENABLE
>                         &clkc CLKID_PCIE_A
> -                       &clkc CLKID_PCIE_CML_EN0>;
> +                       &clkc CLKID_PCIE_CML_EN0
> +                       &clkc CLKID_PCIE_PLL_CML_ENABLE>;
>                 clock-names = "pcie_general",
>                                 "pcie_mipi_en",
>                                 "pcie",
> -                               "port";
> +                               "port",
> +                               "pll_cml_en";
>                 resets = <&reset RESET_PCIE_PHY>,
>                         <&reset RESET_PCIE_A>,
>                         <&reset RESET_PCIE_APB>;

A few remarks for your future patches:

* You need to document any need binding you introduce:
  It means that there should have been a patch in
  Documentation/devicetree/... before using your newclock name in the
  pcie driver. As Martin pointed out, dt-bindings should be dealt with
  in their own patches

>
>
> Remi Pommarel (2):
>   clk: meson: axg: add pcie pll cml gating

Whenever possible, patches intended for different maintainers should be
sent separately (different series)

>   PCI: amlogic: Use PCIe pll gate when available
>
>  drivers/clk/meson/axg.c                | 3 +++
>  drivers/clk/meson/axg.h                | 2 +-
>  drivers/pci/controller/dwc/pci-meson.c | 5 +++++
>  include/dt-bindings/clock/axg-clkc.h   | 1 +
>  4 files changed, 10 insertions(+), 1 deletion(-)

