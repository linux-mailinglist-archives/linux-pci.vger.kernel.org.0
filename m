Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD98626B031
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 00:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgIOWEW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 18:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbgIOWDM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 18:03:12 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62E121974;
        Tue, 15 Sep 2020 22:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600207391;
        bh=6zE0t0oBSXBMiJpCVysJvWDi1OuIiOE0z/RDPqK5QEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nNCs3AKsNhyvwcxJiuYiwuCZk8aJhCrWu2hHimpp/80ZVp0COd9LLbRvKE7dYfj9M
         UORNn/A+ChZMXAgv8WUY92cLPIDrP1OUaIAq8koeKyYALz8L3fH6X5tH8exC0BtO4g
         z6E2UHuTiI3HCcJiuVDfh+u+2xN/iP4Lh+BzdNkg=
Received: by mail-ot1-f53.google.com with SMTP id w25so4761987otk.8;
        Tue, 15 Sep 2020 15:03:11 -0700 (PDT)
X-Gm-Message-State: AOAM531NQIIxLzhVLM+Klo3Lx2z7QE5n1nnjONnDPwOguca9waIswJfS
        P05c7x7FHnG6Ool8ckXG//iLxvI+/IWdRMWzFQ==
X-Google-Smtp-Source: ABdhPJyEQLpI+Is0tXGd/BZAER5EHEJNoezWAKvaE8B6IPjEqoZXnEMY3dBYYK0F9I37uCwuUgkTqRhbfRj/m0u6ldo=
X-Received: by 2002:a9d:6ada:: with SMTP id m26mr560428otq.192.1600207390980;
 Tue, 15 Sep 2020 15:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200821035420.380495-1-robh@kernel.org> <20200915091218.28737-1-michael@walle.cc>
In-Reply-To: <20200915091218.28737-1-michael@walle.cc>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Sep 2020 16:02:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLHBPduSjs1L3R2vbsLygJNDzajt4XThAkRG0DEu-GnAA@mail.gmail.com>
Message-ID: <CAL_JsqLHBPduSjs1L3R2vbsLygJNDzajt4XThAkRG0DEu-GnAA@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] PCI: dwc: Driver clean-ups
To:     Michael Walle <michael@walle.cc>
Cc:     "Gross, Andy" <agross@kernel.org>,
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
        Kishon Vijay Abraham I <kishon@ti.com>,
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
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 3:12 AM Michael Walle <michael@walle.cc> wrote:
>
> Hi Rob,
>
> > This is a series of clean-ups for the Designware PCI driver. The series
> > initially reworks the config space accessors to use the existing pci_ops
> > struct. Then there's removal of various private data that's also present
> > in the pci_host_bridge struct. There's also some duplicated common (PCI
> > and DWC) register defines which I converted to use the common defines.
> > Finally, the initialization for speed/gen, number of lanes, and N_FTS
> > are all moved to the common DWC code.
>
> > This is compile tested only as I don't have any DWC based h/w, so any
> > testing would be helpful. A branch is here[1].
>
> I've noticed that with the latest linux-next, my board doesn't boot
> anymore. I've traced it back to this series. There is a similar
> board in kernelci [1,2] where you can have a look at the backtrace.
>
> I've bisected this to the following patch:
>   PCI: dwc: Use generic config accessors

That's helpful.

> I'm pretty much lost here. It seems that the kernel tries to read from
> an invalid/unmapped memory address.
>
> [1] https://kernelci.org/test/plan/id/5f5f4992d1c53777a0a6092d/
> [2] https://storage.kernelci.org/next/master/next-20200914/arm64/defconfig/gcc-8/lab-nxp/baseline-fsl-ls1028a-rdb.txt

Thanks for the pointers. I was wondering if kernelci had any boards with DWC.

Can you try this? The link up check seemed unnecessary as it is racy.
What happens if the link goes down right after checking? That's the
only thing in the change that sticks out.

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
b/drivers/pci/controller/dwc/pcie-designware-host.c
index 317ff512f8df..afee1a0e8883 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -441,6 +441,9 @@ static void __iomem
*dw_pcie_other_conf_map_bus(struct pci_bus *bus,
        struct pcie_port *pp = bus->sysdata;
        struct dw_pcie *pci = to_dw_pcie_from_pp(pp);

+       if (!dw_pcie_link_up(pci))
+               return NULL;
+
        busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
                 PCIE_ATU_FUNC(PCI_FUNC(devfn));
