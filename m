Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3965E27D535
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgI2Rzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 13:55:54 -0400
Received: from disco-boy.misterjones.org ([51.254.78.96]:44116 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI2Rzx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 13:55:53 -0400
X-Greylist: delayed 1527 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 13:55:51 EDT
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@misterjones.org>)
        id 1kNJRo-00FuDq-Bp; Tue, 29 Sep 2020 18:29:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Sep 2020 18:29:52 +0100
From:   Marc Zyngier <maz@misterjones.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] PCI: dwc: Check alloc_page() return value
In-Reply-To: <20200924190623.3251c2ac@xhacker.debian>
References: <20200924190421.549cb8fc@xhacker.debian>
 <20200924190623.3251c2ac@xhacker.debian>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <74af578c79bd09f2111e5438917f2c6e@misterjones.org>
X-Sender: maz@misterjones.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Jisheng.Zhang@synaptics.com, kishon@ti.com, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, kgene@kernel.org, krzk@kernel.org, hongxing.zhu@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, yue.wang@amlogic.com, khilman@baylibre.com, narmstrong@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, jesper.nilsson@axis.com, gustavo.pimentel@synopsys.com, songxiaowei@hisilicon.com, wangbinghui@hisilicon.com, agross@kernel.org, bjorn.andersson@linaro.org, svarbanov@mm-sol.com, pratyush.anand@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com, hayashi.kunihiko@socionext.com, yamada.masahiro@socionext.com, linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-09-24 12:06, Jisheng Zhang wrote:
> We need to check alloc_page() succeed or not before continuing.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 0a19de946351..9e04e8ef3aa4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -303,6 +303,11 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>  	u64 msi_target;
> 
>  	pp->msi_page = alloc_page(GFP_KERNEL);
> +	if (!pp->msi_page) {
> +		dev_err(dev, "Failed to alloc MSI page\n");

A failing allocation will already scream, so there is no need to
add insult to injury.

More importantly, what is this MSI page ever used for? If I remember
well, this is just a random address that never gets written to.

So why do we allocate a page here? Why do we bother with this DMA
mapping?

         M.
-- 
Who you jivin' with that Cosmik Debris?
