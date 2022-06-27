Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC855D568
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiF0Lxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbiF0LxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 07:53:04 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C653DF53;
        Mon, 27 Jun 2022 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1656330456;
  x=1687866456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HvYHOeFy99wGwq/w2fx0FEcTo66gkhtePc7lFcpF/fs=;
  b=YrScMb56OEuqc9o6FhUutnD/8QeywtmPSgdmJVGgOjiGve7Rk4JVR94p
   OmgEcEZZtvVnYg8H2pm66ekaT1ksGnX3BD5bOVro6njJDTuf4P469THMN
   nukZ0UD0zMDP+exFbknv/aXk3yp/hLUO3AwzMyfAEDqViKimHRbJFcCqj
   vTG9e9Z4s3IVfxlIa2PH0qbwNz8C9FPt8SVzBbpx5WW+iY5uHelZJoQr1
   D5B6lJizOvq4fYM5wA1G06UvpmU/v3/JPbH/N4iF1nZQpHIShZ2imSQwK
   7l6oF+7nq2WGcKczL2gV8rLQzkKmvhes81lHwLspEL7qHaFMYXlnpkkLE
   g==;
Date:   Mon, 27 Jun 2022 13:47:33 +0200
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH RESEND v5 15/18] PCI: dwc: Add dw_ prefix to the
 pcie_port structure name
Message-ID: <20220627114733.GG13332@axis.com>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143428.8334-16-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220624143428.8334-16-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 04:34:25PM +0200, Serge Semin wrote:
> All of the DW PCIe core driver entities have names with the dw_ prefix in
> order to easily distinguish local and common PCIe name spaces. All except
> the pcie_port structure which contains the DW PCIe Root Port descriptor.
> For historical reason the structure has retained the original name since
> commit 340cba6092c2 ("pci: Add PCIe driver for Samsung Exynos") when
> the DW PCIe IP-core support was added to the kernel. Let's finally fix
> that by adding the dw_ prefix to the structure name and by adding the _rp
> suffix to be similar to the EP counterpart. Thus the name will be coherent
> with the common driver naming policy. It shall make the driver code more
> readable eliminating visual confusion between the local and generic PCI
> name spaces.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>

Sorry, I never replied in the thread for the last patch,
your reasoning for not changing the parameter name made sense.

For the ARTPEC-6 parts,

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
