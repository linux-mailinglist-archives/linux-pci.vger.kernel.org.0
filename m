Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70955232178
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 17:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgG2P0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 11:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgG2P0W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 11:26:22 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A0D822BEA;
        Wed, 29 Jul 2020 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596036382;
        bh=e1IZGk2HLbSVU9AcuM8GnjZfSFc5InB7KRTY0ZrYV5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t3epJ9JgT70OxRHY9SR0cQhqzIwOkOkPFeVJF5ioZisTS105rlxyeVdprT+2yhYo5
         JAi69THnCauCt76IoxxgsfIKXND4ja9JKr0GMtVC76v7aJaSIi+Ovja8TMTjDqIhWo
         KL5HRjx3iPyOutLs9RESRlLoevnlz8FnwCrEce/g=
Received: by mail-oo1-f50.google.com with SMTP id x1so2422466oox.6;
        Wed, 29 Jul 2020 08:26:22 -0700 (PDT)
X-Gm-Message-State: AOAM530T6+mPn2hqL5TVm3/DWCnfL0UiIn/c7RUGUJJrJerS3hJhg4M7
        AKCXE8QHZ2jtHD0PZJFzyhzz3sNqhZ7GxSNkIQ==
X-Google-Smtp-Source: ABdhPJyHJnvAb/U1N/MkxmKfSNlaFzpRh95wJ6AQkIeYAkMZZkRld+tazFAGbEN9i2pfBjAX0CU9GBAveAt1MMRDXaQ=
X-Received: by 2002:a4a:ae07:: with SMTP id z7mr28490313oom.25.1596036381394;
 Wed, 29 Jul 2020 08:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com> <1595254921-26050-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1595254921-26050-3-git-send-email-Anson.Huang@nxp.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Jul 2020 09:26:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLXGduym51-Ej8Td4yOyP-UfGP-WCh2xeP_V90Yabm4XA@mail.gmail.com>
Message-ID: <CAL_JsqLXGduym51-Ej8Td4yOyP-UfGP-WCh2xeP_V90Yabm4XA@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] pci: imx: Select RESET_IMX7 by default
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yang-Leo Li <leoyang.li@nxp.com>, Vinod <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 20, 2020 at 8:26 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> i.MX7 reset driver now supports module build and it is no longer
> built in by default, so i.MX PCI driver needs to select it explicitly
> due to it is NOT supporting loadable module currently.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 044a376..bcf63ce 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -90,6 +90,7 @@ config PCI_EXYNOS
>
>  config PCI_IMX6
>         bool "Freescale i.MX6/7/8 PCIe controller"
> +       select RESET_IMX7

This will break as select will not cause all of RESET_IMX7's
dependencies to be met. It also doesn't scale. Are you going to do the
same thing for clocks, pinctrl, gpio, etc.?

You should make the PCI driver work as a module.

Rob

>         depends on ARCH_MXC || COMPILE_TEST
>         depends on PCI_MSI_IRQ_DOMAIN
>         select PCIE_DW_HOST
> --
> 2.7.4
>
