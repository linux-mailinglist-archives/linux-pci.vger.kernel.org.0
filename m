Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF239372677
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 09:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEDHVI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhEDHVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 03:21:07 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9FBC061761
        for <linux-pci@vger.kernel.org>; Tue,  4 May 2021 00:20:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o27so7631821qkj.9
        for <linux-pci@vger.kernel.org>; Tue, 04 May 2021 00:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JggnRH2z+C5c6q5fwkNF9u7IZivIlxcnTgChvJQFvSA=;
        b=csBKU8aJUh6TfQKqWkRRJuwzqfCx/gxbV1DQ6d4id1eoGXBhg76xsbhY2fA34UDX22
         sZhPa7vaekhSABqSq3q7znGNkTGTxRXlf8Kiac//bM/Z3oVYKoZXXB9zyWWTH7tsAue2
         1B3yweWVmqGH2oSfzokpJ9flNMRRfs9Ch/TZUvIWlFbtChX6zJmSSKrgWOdoAyamxI4t
         MWCSaYfX4b6HMUDdhbJ98JhjtDEInNQGjQWG3kd5N5U5xZzC2NZbKSwi8I2ED9rQfmrz
         7UAGrCn8PAB1iTBuS+TzkQAplICSN9l3apNNyz3X/NdhP+azrqtYr3WMCOS/YtBXCUbQ
         fB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JggnRH2z+C5c6q5fwkNF9u7IZivIlxcnTgChvJQFvSA=;
        b=N4l+Ji7DWESOgGPTJ2k0qNHYKIfzrrwwD0AY+pZ/BGKw1Jg8sg74wsVgGmm7im/9vQ
         cCDa9m75EiXIm9dvX07dJe8E0guYVw28mTaK+Na3j1maU0fX1EfY7Bm3glJvRVsQGATL
         rnmt3twrNfx73t8fpYQVPJRHwLQqYUSrkztJIbvYEJLaHhM7rU6nWJDvWs9ZlpxO1WOB
         KPps5RW2uXT/XV//8UimPQSXrWSawxjoCuN5Gz8Z2KRjSAiwoGUTgufuW8WUO/Aazblf
         fQkTBuIPkvNfLmBATSt3ZJk3mpecSU2kUmmTjrKnR2j1dS79faay8YGII/N1iSBHvgdz
         xitg==
X-Gm-Message-State: AOAM532om4DG++YIsvg3H5SzeB25VANzdVqmmjau89kT/RJLFy8QQgpd
        05EBqLFSjomLItJG4t5nQQ27/29T53H+4fxYrSyMgw==
X-Google-Smtp-Source: ABdhPJwSV0cJLUMNNy0lL94PwJnsWKOoPmVIkjaGTOqFfwKqrXom5YgkvcZWXnSt5nztkk0zIFsVQOCkdjO4/mVSk1Q=
X-Received: by 2002:a05:620a:29c4:: with SMTP id s4mr20672337qkp.401.1620112812489;
 Tue, 04 May 2021 00:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210406092634.50465-1-greentime.hu@sifive.com> <20210503164023.GA919777@bjorn-Precision-5520>
In-Reply-To: <20210503164023.GA919777@bjorn-Precision-5520>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 4 May 2021 15:20:00 +0800
Message-ID: <CAHCEeh+cMrEnHNG3W3ZNzdgT-m7BMorDawF6D8qkFYGg=RJMOw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, hes@sifive.com,
        Erik Danie <erik.danie@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>, robh+dt@kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> =E6=96=BC 2021=E5=B9=B45=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Apr 06, 2021 at 05:26:28PM +0800, Greentime Hu wrote:
> > This patchset includes SiFive FU740 PCIe host controller driver. We als=
o
> > add pcie_aux clock and pcie_power_on_reset controller to prci driver fo=
r
> > PCIe driver to use it.
>
> I dropped this series because of the build problem I mentioned [1].
> It will not be included in v5.13 unless the build problem is fixed
> ASAP.
>
> [1] https://lore.kernel.org/r/20210428194713.GA314975@bjorn-Precision-552=
0
>

Hi all,

This build failed in x86_64 is because CONFIG_GPIOLIB is disabled in
the testing config.

diff --git a/drivers/pci/controller/dwc/Kconfig
b/drivers/pci/controller/dwc/Kconfig
index 0a37d21ed64e..56b66e1fed53 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -323,6 +323,7 @@ config PCIE_FU740
        depends on PCI_MSI_IRQ_DOMAIN
        depends on SOC_SIFIVE || COMPILE_TEST
        select PCIE_DW_HOST
+       select GPIOLIB
        help
          Say Y here if you want PCIe controller support for the SiFive
          FU740.

After applying this change, it can build pass.

> > This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon =
R5
> > 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based o=
n
> > v5.11 Linux kernel.
> >
> > Changes in v5:
> >  - Fix typo in comments
> >  - Keep comments style consistent
> >  - Refine some error handling codes
> >  - Remove unneeded header file including
> >  - Merge fu740_pcie_ltssm_enable implementation to fu740_pcie_start_lin=
k
> >
> > Changes in v4:
> >  - Fix Wunused-but-set-variable warning in prci driver
> >
> > Changes in v3:
> >  - Remove items that has been defined
> >  - Refine format of sifive,fu740-pcie.yaml
> >  - Replace perstn-gpios with the common one
> >  - Change DBI mapping space to 2GB from 4GB
> >  - Refine drivers/reset/Kconfig
> >
> > Changes in v2:
> >  - Refine codes based on reviewers' feedback
> >  - Remove define and use the common one
> >  - Replace __raw_writel with writel_relaxed
> >  - Split fu740_phyregreadwrite to write function
> >  - Use readl_poll_timeout in stead of while loop checking
> >  - Use dwc common codes
> >  - Use gpio descriptors and the gpiod_* api.
> >  - Replace devm_ioremap_resource with devm_platform_ioremap_resource_by=
name
> >  - Replace devm_reset_control_get with devm_reset_control_get_exclusive
> >  - Add more comments for delay and sleep
> >  - Remove "phy ? x : y" expressions
> >  - Refine code logic to remove possible infinite loop
> >  - Replace magic number with meaningful define
> >  - Remove fu740_pcie_pm_ops
> >  - Use builtin_platform_driver
> >
> > Greentime Hu (5):
> >   clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
> >   clk: sifive: Use reset-simple in prci driver for PCIe driver
> >   MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
> >   dt-bindings: PCI: Add SiFive FU740 PCIe host controller
> >   riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
> >
> > Paul Walmsley (1):
> >   PCI: fu740: Add SiFive FU740 PCIe host controller driver
> >
> >  .../bindings/pci/sifive,fu740-pcie.yaml       | 113 +++++++
> >  MAINTAINERS                                   |   8 +
> >  arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  33 ++
> >  drivers/clk/sifive/Kconfig                    |   2 +
> >  drivers/clk/sifive/fu740-prci.c               |  11 +
> >  drivers/clk/sifive/fu740-prci.h               |   2 +-
> >  drivers/clk/sifive/sifive-prci.c              |  54 +++
> >  drivers/clk/sifive/sifive-prci.h              |  13 +
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   1 +
> >  drivers/pci/controller/dwc/pcie-fu740.c       | 308 ++++++++++++++++++
> >  drivers/reset/Kconfig                         |   1 +
> >  include/dt-bindings/clock/sifive-fu740-prci.h |   1 +
> >  13 files changed, 555 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-=
pcie.yaml
> >  create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c
> >
> > --
> > 2.30.2
> >
