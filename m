Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6644D3E47F9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 16:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhHIOxM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 10:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233926AbhHIOxL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 10:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6543D610CF;
        Mon,  9 Aug 2021 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520770;
        bh=Pxvauf7CFHRqwgrPJcBCTzOuC/lUcd4Kz0wvLQ2dWzw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k3WUKO9V06mZ0vQ4uCa2lAOUl3YN47JaNN2QCJjIyypAzfPv9JEIECoBjibPRMAls
         rDKmyyc2n8fED+sdSZ8M5Y6RHWFWOaplP624T/71Aj5CBc59757HNCHYoMCJDiOFdW
         sx8lqmPZfH9wWQPAkgaYgKnNfq54QpA03qYacOyIVk/oQxdhKT2XHCm4KwMUWYWGHq
         yJzMD7yYA674d5zvVCMXYMq9mrKDy6pBQi6ysLN+fNwb/Lhd4rW4+j6zRanFgZgBNF
         JH3Rt9kosR3e07Za60Rdse+IwPPMoWepCqIU+RZzbs8DDNHEIl8jn4kb0T1LhYvn9d
         q6W6LAtgN8XNw==
Received: by mail-ed1-f45.google.com with SMTP id n12so1158090edx.8;
        Mon, 09 Aug 2021 07:52:50 -0700 (PDT)
X-Gm-Message-State: AOAM530FWLv4HfElgxKYAMLEiyz7uW3cUvdmr3wH6QEoeJ7WBICPQlDz
        P9v7Xcep7irzWmT1TB8pT0pwNdZedvVx5dZ97Q==
X-Google-Smtp-Source: ABdhPJzc6XZ8s9ydxQHfxUS1CfauBiPrkQyjudkgpPtRe58+tK6GJ3YbxcrQpiqucK1Zl64RWkT3x4DLs+goMJdOtns=
X-Received: by 2002:a05:6402:291d:: with SMTP id ee29mr30809324edb.289.1628520768969;
 Mon, 09 Aug 2021 07:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200821035420.380495-1-robh@kernel.org> <20200821035420.380495-4-robh@kernel.org>
 <68e3adfb-a79d-3b70-87ed-2e5e1bf7fc93@nvidia.com>
In-Reply-To: <68e3adfb-a79d-3b70-87ed-2e5e1bf7fc93@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Aug 2021 08:52:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJZ-BzxnEPeqirrd=yZFSWejP4PBYDgLNEn-kubFzvXCA@mail.gmail.com>
Message-ID: <CAL_JsqJZ-BzxnEPeqirrd=yZFSWejP4PBYDgLNEn-kubFzvXCA@mail.gmail.com>
Subject: Re: [PATCH v2 03/40] PCI: dwc: Allow overriding bridge pci_ops
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@amlogic.com>, Marc Zyngier <maz@kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@axis.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 8, 2021 at 9:13 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
>
>
> On 8/21/2020 9:23 AM, Rob Herring wrote:
> > In preparation to allow drivers to set their own root and child pci_ops
> > instead of using the DWC specific config space ops, we need to make
> > the pci_host_bridge pointer available and move setting the bridge->ops
> > and bridge->child_ops pointer to before the .host_init() hook.
> >
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-host.c | 15 ++++++++++-----
> >   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
> >   2 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 1d98554db009..b626cc7cd43a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -344,6 +344,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >       if (!bridge)
> >               return -ENOMEM;
> >
> > +     pp->bridge = bridge;
> > +
> >       /* Get the I/O and memory ranges from DT */
> >       resource_list_for_each_entry(win, &bridge->windows) {
> >               switch (resource_type(win->res)) {
> > @@ -445,6 +447,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >               }
> >       }
> >
> > +     /* Set default bus ops */
> > +     bridge->ops = &dw_pcie_ops;
> > +     bridge->child_ops = &dw_pcie_ops;
> > +
> >       if (pp->ops->host_init) {
> >               ret = pp->ops->host_init(pp);
> >               if (ret)
> > @@ -452,7 +458,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >       }
> >
> >       bridge->sysdata = pp;
> > -     bridge->ops = &dw_pcie_ops;
> >
> >       ret = pci_scan_root_bus_bridge(bridge);
> >       if (ret)
> > @@ -654,11 +659,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >       dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
> >
> >       /*
> > -      * If the platform provides ->rd_other_conf, it means the platform
> > -      * uses its own address translation component rather than ATU, so
> > -      * we should not program the ATU here.
> > +      * If the platform provides its own child bus config accesses, it means
> > +      * the platform uses its own address translation component rather than
> > +      * ATU, so we should not program the ATU here.
> It is possible that a platform can have its own translation for
> configuration accesses and use DWC's ATU for memory/IO address
> translations. IMHO, ATU setup for memory/IO address translations
> shouldn't be skipped based on platform's '->rd_other_conf'
> implementation. Ex:- A platform can implement configuration space access
> through the ECAM mechanism yet choose to use ATU for memory/IO address
> translations.

A platform could, but none of them upstream do that. I'm all for doing
ECAM setup (in the kernel) if possible. That could be in the DWC core
with a feature flag the platform can set or something to enable it if
we do that. It could be based on the config space size as well. I'm
not sure what else determines whether ECAM can work besides having
enough address space and at least 3 outbound iATU windows.

Rob
