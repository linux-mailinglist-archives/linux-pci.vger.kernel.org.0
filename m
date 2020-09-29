Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8395627D12B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgI2Oc3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 10:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgI2Oc3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 10:32:29 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D849F20C09;
        Tue, 29 Sep 2020 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601389948;
        bh=VjYWaMro1xYrDNe26Vn7kbXKrgcLLp4Ul6eqYCvWIoQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H42ozem74rjURrts0hRxe5T7CR4s7jiAxWHjUUrTYgxfrnGr0VLpdA4Aw1dCyY2XN
         F3H1cPJHIvXCrMnWjDV3iLSMTT23c4tqpcm164P6bprzHmV6oXC2ERW52N1oVptGMB
         32FTqmUy5XKdV9HwtzY+TaD8vzqFnaRvS+GdHy30=
Received: by mail-ot1-f46.google.com with SMTP id 60so4623648otw.3;
        Tue, 29 Sep 2020 07:32:27 -0700 (PDT)
X-Gm-Message-State: AOAM530hi35aVK04eo9DT35oBrTCsxBc06yqeDT+7RJyjb7kAAo18258
        LDW5TRFGJegbTh4tDbzO0PkVpUlrsBGMACKTcQ==
X-Google-Smtp-Source: ABdhPJzrYJQxmXmK64+WMD0rkZVvGC2aVs8Bric+nrdYTcuT20sY6koxQbDnQMlcrE1ulqGTm+OoF2mzSgf9Ky4PhtA=
X-Received: by 2002:a9d:6ada:: with SMTP id m26mr3041497otq.192.1601389946977;
 Tue, 29 Sep 2020 07:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200821035420.380495-1-robh@kernel.org> <20200915091218.28737-1-michael@walle.cc>
 <CAL_JsqLHBPduSjs1L3R2vbsLygJNDzajt4XThAkRG0DEu-GnAA@mail.gmail.com>
 <346b694e43b1b6b86e4f3164e6589d25@walle.cc> <6b776dda-e575-74f0-5575-0e5d30641522@ti.com>
In-Reply-To: <6b776dda-e575-74f0-5575-0e5d30641522@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Sep 2020 09:32:16 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+kQdmRfMQo-1AE+A3TxH7J99fuuuV5H0H=cOT1DK436Q@mail.gmail.com>
Message-ID: <CAL_Jsq+kQdmRfMQo-1AE+A3TxH7J99fuuuV5H0H=cOT1DK436Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] PCI: dwc: Driver clean-ups
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Michael Walle <michael@walle.cc>,
        "Gross, Andy" <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Kukjin Kim <kgene@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@axis.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawn.guo@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Song Xiaowei <songxiaowei@hisilicon.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Yue Wang <yue.wang@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 12:24 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 16/09/20 1:24 pm, Michael Walle wrote:
> > Am 2020-09-16 00:02, schrieb Rob Herring:
> >> Can you try this? The link up check seemed unnecessary as it is racy.
> >> What happens if the link goes down right after checking? That's the
> >> only thing in the change that sticks out.
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> >> b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> index 317ff512f8df..afee1a0e8883 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> @@ -441,6 +441,9 @@ static void __iomem
> >> *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
> >>         struct pcie_port *pp = bus->sysdata;
> >>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >>
> >> +       if (!dw_pcie_link_up(pci))
> >> +               return NULL;
> >> +
> >>         busdev = PCIE_ATU_BUS(bus->number) |
> >> PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> >>                  PCIE_ATU_FUNC(PCI_FUNC(devfn));
> >
> > This will fix the issue.
>
> This fix is required to get DRA7 EVM booting again in linux-next.

Did you see the discussion here[1]? Is firmware setting up the same
register in question?

Rob

[1] http://lore.kernel.org/r/HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com
