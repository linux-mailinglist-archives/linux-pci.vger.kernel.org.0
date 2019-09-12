Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9555DB0B45
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 11:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfILJXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 05:23:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39781 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbfILJXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 05:23:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so28781728qtb.6;
        Thu, 12 Sep 2019 02:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXQcfTndnrpIGvk9sB9a9gWQqmEHMhawitV9TbB2g8E=;
        b=EFC7Pzc2RJMO0kYGJY36B6M/KiGYRXH34bY3unVZ4f8E0v6kvTTDr1MhCuFTowLzj7
         tj5RG4fkbt5/xCdfAxg7gFGlN7GA7q4JnDrhVGD7kTU9IeJnx9p7DZsRCD8w476mlLn/
         UW/vayWu0r1BQqBEGEajHhBBN4gUlxvedR5iU8vS4Pw/5bUdtz7zDegk4bxTpIjIC9GP
         0SqOacOUHywwYNrShU4Fei9l32K+S12f57O9zSrxehjdOhzMZXp7Vl4BSXd737Ue7XXT
         4NoGM0rDHwyPCNrlfTa+ehntgy/DTJm+IBYiBJQHz467FTCLxIZvESTTLDefx8a5jUKa
         dn2w==
X-Gm-Message-State: APjAAAVs+OGWqJr76OkTp0nWYIVHgiBhTqOQ/fb5JNQeOQZyaaaHmj/0
        2BlOcbBx+7ZGBoFHyCgk2XSpRZYz9ck+A+/GrSA=
X-Google-Smtp-Source: APXvYqziwk60aLJSQdoVYvx52qn+2u/NADJ4HuF3YjYBj52OuDv7Y0SaYvYRwH+Wen8XN74tjClsdCK2jrcZk15F5go=
X-Received: by 2002:ad4:4529:: with SMTP id l9mr21307225qvu.45.1568280224996;
 Thu, 12 Sep 2019 02:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568239378.git.amit.kucheria@linaro.org> <f6cefef2bf6b34ec6eb82d3614054734fa5e8dd1.1568239378.git.amit.kucheria@linaro.org>
In-Reply-To: <f6cefef2bf6b34ec6eb82d3614054734fa5e8dd1.1568239378.git.amit.kucheria@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Sep 2019 11:23:29 +0200
Message-ID: <CAK8P3a0uxZWF85+v73KtvQECErA64yPE7BT3VRZMa=oq3rFtRA@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: Kconfig: Fix XGENE driver dependencies
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 12:19 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Push various XGENE drivers behind ARCH_XGENE dependency so that it
> doesn't get enabled by default on other platforms.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/Kconfig.platforms   | 3 +++
>  drivers/clk/Kconfig            | 2 +-
>  drivers/gpio/Kconfig           | 1 +
>  drivers/pci/controller/Kconfig | 1 +
>  drivers/phy/Kconfig            | 1 +
>  drivers/power/reset/Kconfig    | 2 +-
>  6 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 4778c775de1b..cdf4e452e34c 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -281,6 +281,9 @@ config ARCH_VULCAN
>
>  config ARCH_XGENE
>         bool "AppliedMicro X-Gene SOC Family"
> +       select COMMON_CLK_XGENE
> +       select PCI_XGENE
> +       select GPIO_XGENE
>         help
>           This enables support for AppliedMicro X-Gene SOC Family

I'd rather not 'select' drivers that might be optional, the 'default y'
should be sufficient as long as it's in theory possible to have
them disabled or as loadable modules.

> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 801fa1cd0321..9b2790d3f18a 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -225,7 +225,7 @@ config CLK_QORIQ
>
>  config COMMON_CLK_XGENE
>         bool "Clock driver for APM XGene SoC"
> -       default ARCH_XGENE
> +       depends on ARCH_XGENE
>         depends on ARM64 || COMPILE_TEST
>         ---help---
>           Sypport for the APM X-Gene SoC reference, PLL, and device clocks.

This breaks compile-testing, and existing defconfigs
that don't list the driver.

       Arnd
