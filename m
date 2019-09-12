Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC12FB0660
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 03:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfILBD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 21:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfILBDZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Sep 2019 21:03:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE5220863;
        Thu, 12 Sep 2019 01:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568250205;
        bh=DNaLcHjtAram+fHXt9n0Qh+Msw5zL/BxK7rfBfFbCdY=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=WHfcMcEd5siGpnVlhfOi3HeoUu2n1CVCwXugiYRcQOgA5PLidzNvtx5w+bfY/+1wI
         C/mBQrEqNueP5fBZhnFV1nRdITVQHNm//bZ3IJS0geeKnpEGeMT/ZSf1speT+vj9QB
         GHbvtbzI6vqWlY6Lm0WmSoelZBYf8laWgucQJCJ8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f6cefef2bf6b34ec6eb82d3614054734fa5e8dd1.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org> <f6cefef2bf6b34ec6eb82d3614054734fa5e8dd1.1568239378.git.amit.kucheria@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/4] arm64: Kconfig: Fix XGENE driver dependencies
User-Agent: alot/0.8.1
Date:   Wed, 11 Sep 2019 18:03:24 -0700
Message-Id: <20190912010325.0DE5220863@mail.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Amit Kucheria (2019-09-11 15:18:45)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 801fa1cd0321..9b2790d3f18a 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -225,7 +225,7 @@ config CLK_QORIQ
> =20
>  config COMMON_CLK_XGENE
>         bool "Clock driver for APM XGene SoC"
> -       default ARCH_XGENE
> +       depends on ARCH_XGENE
>         depends on ARM64 || COMPILE_TEST

Is ARCH_XGENE supported outside of ARM64? I'd expect to see something
more like depends on ARCH_XGENE || COMPILE_TEST and default ARCH_XGENE
so that if the config is supported it becomes the default. Or at least
depends on ARCH_XGENE && ARM64 || COMPILE_TEST

>         ---help---
>           Sypport for the APM X-Gene SoC reference, PLL, and device clock=
s.
