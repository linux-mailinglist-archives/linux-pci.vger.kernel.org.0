Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529C53591EE
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 04:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhDICXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 22:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhDICXp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 22:23:45 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF841C061763
        for <linux-pci@vger.kernel.org>; Thu,  8 Apr 2021 19:23:33 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id h3so1193193qve.13
        for <linux-pci@vger.kernel.org>; Thu, 08 Apr 2021 19:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dr8o5YF5yqQzC2Z1k+2QkLomm0GkPLRu2hgFbkn12/A=;
        b=Ly6yeXcWyzUsF37vzaewuSXMHg8oxjVmIMpbnu20lmjf2vDNQwHhcJZLJIRDtMamKE
         K5fqcZc3UR7MK8guEJoUxEN9fadEzvmO9H0JI8yTk84XkDtJa1wFiXpzUhpDYeSC7pWG
         IGdQADOzMvd4hpC4Vbkauk7WodpWYq8eT35sLO68e1F1yv1/iQMjayD7vTvSa4cvS46W
         zbd3tYCqDJk8QD7A2TCLlL1YKuLXSDp+KL83bqmsgMlpys3Yg+GzEwtVA2voaozzvJxO
         luDpwa7GFR8AT+1Ojm/+exEFo+cV6z7jBOPvz/3DjHBm8n9reY1bscWa/dQqyBj60mvw
         hlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dr8o5YF5yqQzC2Z1k+2QkLomm0GkPLRu2hgFbkn12/A=;
        b=UMvFSzMb06/GWqAhjG3F6flNPtf14DZcRU/tyRH3Z1wRmoetmNBP+xQn1sl2Z/QWrV
         23WWZvxgQuO+KyZrMWA5kkKaU8E4AjjqzkUy4snfCITwTo/rvDubOvCUPDlastGePCG/
         DJVWqmVB8gvd1IhEQNcSk6u46q6I28We5yrzQmcZuRPyv92l8Mv0rKmF2rc6d4JPpdfH
         JJoj16ljVgxlZvC32Zhd8eR1z7yC6+UArGcrIVvRXWH4kEDTo5nREnJ1p5Cc3tCY1mqf
         N23jX/IWscuTBeQQ05Eu3FNeRvHv77D3LzpbuJoJq426uVYbjiaR7flZpAksjcdeyV/J
         7tEQ==
X-Gm-Message-State: AOAM533NX+AwUERsSQzEYGuRGpe64N49o+0syYQLz2q7FB9pMiKXN8Pl
        I8IN3ZOF5jwfAnCqm+ognXK0cjWIFndZkCA1R1Wmsw==
X-Google-Smtp-Source: ABdhPJxtimebsZ9qggqFtKnwApCerfHESWaJIl88HJu0Xf60B4QCcRWMzJJOSmFJIJ+fQt4BpDrO7Q3hF36KGFG+LhI=
X-Received: by 2002:a05:6214:f0d:: with SMTP id gw13mr11984953qvb.33.1617935012958;
 Thu, 08 Apr 2021 19:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210406092634.50465-1-greentime.hu@sifive.com> <20210408162539.GA32036@lpieralisi>
In-Reply-To: <20210408162539.GA32036@lpieralisi>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Fri, 9 Apr 2021 10:23:21 +0800
Message-ID: <CAHCEehK5vf5V_6McexFQPbcxGeC2SEb_3SXiGc2ASkcELe3fXg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, hes@sifive.com,
        Erik Danie <erik.danie@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>, robh+dt@kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> =E6=96=BC 2021=E5=B9=B44=E6=
=9C=889=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:25=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Tue, Apr 06, 2021 at 05:26:28PM +0800, Greentime Hu wrote:
> > This patchset includes SiFive FU740 PCIe host controller driver. We als=
o
> > add pcie_aux clock and pcie_power_on_reset controller to prci driver fo=
r
> > PCIe driver to use it.
> >
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
>
> I can pull the patches above into the PCI tree (but will drop patch 6 -
> dts changes), is it OK for you ? Please let me know how you would like
> to upstream it.
>

Hi Lorenzo,

Thank you.
I am ok with it. So I should ask Palmer to pick patch 6 dts changes to
RISC-V tree?
