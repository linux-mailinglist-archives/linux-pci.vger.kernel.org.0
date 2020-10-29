Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B593829DC1D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 01:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbgJ2AV3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 20:21:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44765 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbgJ2AV1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 20:21:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CM5hY1c5jz9sTf;
        Thu, 29 Oct 2020 11:21:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1603930883;
        bh=1H+0lWYSxaRNRPccmOFzTYzYgErk8Jx3rJ+1kAphuRA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fBZNMVGf2DpDigzvlO5EFKrSfhcHEKaclKWRSpd0rMT3nijHNgh+K7YZaMcJgG+I1
         Sqp0aSWWEEdsZy58/OpXsqjKdLh1Go0930GvCaNP/rPdkcm6jj8VLu+RtZAYju7Lwv
         1OyJzCDTJEPo7fb3YVK+7vVSD947EigxRUEp47FaWl3boTdjoiwTlcbdL3lqCGS/Ir
         HjS3q0q57c4NP98/lAG95E/PIIhVcbnSgznNbTvydd0ukv+wu90vIX/fgrejZmKL/x
         fFgnf7BJJuzQ19szmCiiqO1GyzQ9nRbhKLLimDSXto/YVs3qcf351XsGaZm3WEkFCR
         8YPZdn5UhcwWA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pci@vger.kernel.org,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@axis.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-samsung-soc@vger.kernel.org,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-msm@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yue Wang <yue.wang@Amlogic.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linuxppc-dev@lists.ozlabs.org, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 01/13] PCI: dwc/imx6: Drop setting PCI_MSI_FLAGS_ENABLE
In-Reply-To: <20201028204646.356535-2-robh@kernel.org>
References: <20201028204646.356535-1-robh@kernel.org> <20201028204646.356535-2-robh@kernel.org>
Date:   Thu, 29 Oct 2020 11:21:16 +1100
Message-ID: <87h7qdx4oz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> No other host driver sets the PCI_MSI_FLAGS_ENABLE bit, so it must not
> be necessary. If it is, a comment is needed.

Yeah, but git blame directly points to:

  75cb8d20c112 ("PCI: imx: Enable MSI from downstream components")

Which has a pretty long explanation. The relevant bit probably being:

  ... on i.MX6, the MSI Enable bit controls delivery of MSI interrupts
  from components below the Root Port.


So it seems a little rash to just remove the code.

cheers


> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5cf1ef12fb9b..7dd137d62dca 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1002,7 +1002,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
>  	int ret;
> -	u16 val;
>  
>  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>  	if (!imx6_pcie)
> @@ -1167,13 +1166,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (pci_msi_enabled()) {
> -		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> -		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> -		val |= PCI_MSI_FLAGS_ENABLE;
> -		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> -	}
> -
>  	return 0;
>  }
>  
> -- 
> 2.25.1
