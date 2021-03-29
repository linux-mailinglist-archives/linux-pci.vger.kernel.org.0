Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96534D7ED
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhC2TO2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 15:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhC2TOH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 15:14:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36C9461936;
        Mon, 29 Mar 2021 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617045243;
        bh=ToS0MidpfphiNtS55x67RiSvWClxRs/ZhbXeO1EBtAw=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=oQfZOPcCqmdWePI7Lw64BaJIMp8Fg02xLSjbmILupDBGx799hmQd5C/AhhnXHzQPh
         Fo5TIF3XxWugMx0k7kmS8Ub6sBSGHfY8Pu5uk3SgFlHTuHOhPS0/l2ulNsQzLRsyry
         iQUpHuII7FhbQZDUyDqx5our/WCk8VKvumz8VEwUPLkHxyZoFrJ+iG5/NBTnpIgHhe
         ba8T5QPdvcUOTLUrJhsIQt0T3nqIJYvxBhwZ9gmmxDPeT8QDBvAgZcJoNndcspOyw8
         RvPJunEY33GrQTQsxgpSTYG+qxr+qMtywMxS3CcMthZ2PpH3T2TYfJFvaAew8UQeGF
         MW7BaGRcOa81g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <91d016e59bab9d9175168a63e7bcd81fdb69b549.1615954046.git.greentime.hu@sifive.com>
References: <cover.1615954045.git.greentime.hu@sifive.com> <91d016e59bab9d9175168a63e7bcd81fdb69b549.1615954046.git.greentime.hu@sifive.com>
Subject: Re: [PATCH v2 2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
From:   Stephen Boyd <sboyd@kernel.org>
To:     alex.dewar90@gmail.com, aou@eecs.berkeley.edu, bhelgaas@google.com,
        devicetree@vger.kernel.org, erik.danie@sifive.com,
        greentime.hu@sifive.com, hayashi.kunihiko@socionext.com,
        helgaas@kernel.org, hes@sifive.com, jh80.chung@samsung.com,
        khilman@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, lorenzo.pieralisi@arm.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        vidyas@nvidia.com, zong.li@sifive.com
Date:   Mon, 29 Mar 2021 12:14:02 -0700
Message-ID: <161704524201.3012082.13807741329367593907@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Greentime Hu (2021-03-17 23:08:09)
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 71ab75a46491..f094df93d911 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -173,7 +173,7 @@ config RESET_SCMI
> =20
>  config RESET_SIMPLE
>         bool "Simple Reset Controller Driver" if COMPILE_TEST
> -       default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_REALTE=
K || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC
> +       default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_REALTE=
K || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC || RISCV

This conflicts. Can this default be part of the riscv defconfig instead?

>         help
>           This enables a simple reset controller driver for reset lines t=
hat
>           that can be asserted and deasserted by toggling bits in a conti=
guous,
> @@ -187,6 +187,7 @@ config RESET_SIMPLE
>            - RCC reset controller in STM32 MCUs
>            - Allwinner SoCs
>            - ZTE's zx2967 family
> +          - SiFive FU740 SoCs
> =20
>  config RESET_STM32MP157
>         bool "STM32MP157 Reset Driver" if COMPILE_TEST
