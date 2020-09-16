Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AEC26BE93
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgIPHyW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 03:54:22 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:49189 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIPHyW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 03:54:22 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DFEDB22F00;
        Wed, 16 Sep 2020 09:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600242857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mrV4ooFGnJh2/RwC1ApcYKUUoJS8TkPIKcSBJOevMI=;
        b=hZYcEooibPlvGYZsIy6M1JnuIGdhF2nyPQr1geOw5eoiHM1PLx4w1uqnELsVgZaNK9oHSm
        J6p7MyQNttvX9ylL+BtvV4J5f43XLjVJl9to5980o1I2bsOOnMfHmjEWfJQwKTEZ7audCW
        GI7REFPaQWuDo39bLZ59wHfcBEUMegs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Sep 2020 09:54:10 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v2 00/40] PCI: dwc: Driver clean-ups
In-Reply-To: <CAL_JsqLHBPduSjs1L3R2vbsLygJNDzajt4XThAkRG0DEu-GnAA@mail.gmail.com>
References: <20200821035420.380495-1-robh@kernel.org>
 <20200915091218.28737-1-michael@walle.cc>
 <CAL_JsqLHBPduSjs1L3R2vbsLygJNDzajt4XThAkRG0DEu-GnAA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <346b694e43b1b6b86e4f3164e6589d25@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2020-09-16 00:02, schrieb Rob Herring:
> Can you try this? The link up check seemed unnecessary as it is racy.
> What happens if the link goes down right after checking? That's the
> only thing in the change that sticks out.
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 317ff512f8df..afee1a0e8883 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -441,6 +441,9 @@ static void __iomem
> *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>         struct pcie_port *pp = bus->sysdata;
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> 
> +       if (!dw_pcie_link_up(pci))
> +               return NULL;
> +
>         busdev = PCIE_ATU_BUS(bus->number) | 
> PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>                  PCIE_ATU_FUNC(PCI_FUNC(devfn));

This will fix the issue.

-michael
