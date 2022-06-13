Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D09E54A0E7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351931AbiFMVKh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiFMVKR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:10:17 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7BC2F3A4;
        Mon, 13 Jun 2022 13:48:09 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id y16so5137583ili.13;
        Mon, 13 Jun 2022 13:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dzRBMIn98y05EN99Sgq5WDsEwo7wpH66xTE6XCo/M4=;
        b=DK0uhSJYtjiyjLQvTvTq2iUHAujLGBGBiyoTPN+vCrum3bibAC+WLkJ9pTP1QCph3N
         0MbMWb3j0SpOpgQKxnMDEs/p9N4WJ7tH4moYqsCTez94Qk67ATaGGLekMJnzDBgYVWsE
         q9i4sJtScHtQJc6fsEP8fzedyvntjY/xTCMYm9Os8uE/1lGfJDAHoC2GkMHt2UPmf1GL
         Px4osl3EhxDeLmoY+qTnRtrSD/6zLqH8OoVDAaLfJ8zoYSR5kIwV/hwFrwv7LpNqMTkq
         3a0B6WnFYkP2TXGiU3lijF3kogM8nabC/En/c6MqfDLHQTEH64SwE0qMFMG39OIBuS/D
         AkpA==
X-Gm-Message-State: AJIora+1KepHiNcoL+CpPjUXWWIPuT+VEg/BCqu+zMT+QjxiDzXctdpq
        6IU1aFCUuWzbfUbZMF6DIA==
X-Google-Smtp-Source: AGRyM1uVO/KYjaDwGOXreGf4KGdEqy/t353ouqbFZgp5s/y6kuWD2fxXl3ut4zPLn500QHJwX/rd6w==
X-Received: by 2002:a92:ca45:0:b0:2d1:b7cf:26a9 with SMTP id q5-20020a92ca45000000b002d1b7cf26a9mr962751ilo.52.1655153288816;
        Mon, 13 Jun 2022 13:48:08 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id c2-20020a92c8c2000000b002d11397f4f9sm4380280ilq.74.2022.06.13.13.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:48:08 -0700 (PDT)
Received: (nullmailer pid 56167 invoked by uid 1000);
        Mon, 13 Jun 2022 20:48:06 -0000
Date:   Mon, 13 Jun 2022 14:48:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
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
        Yue Wang <yue.wang@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 15/18] PCI: dwc: Add dw_ prefix to the pcie_port
 structure name
Message-ID: <20220613204806.GA55629-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-16-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-16-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 11:25:31AM +0300, Serge Semin wrote:
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
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on the v4 lap of the series.
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 12 +++----
>  drivers/pci/controller/dwc/pci-exynos.c       |  6 ++--
>  drivers/pci/controller/dwc/pci-imx6.c         |  6 ++--
>  drivers/pci/controller/dwc/pci-keystone.c     | 20 +++++------
>  drivers/pci/controller/dwc/pci-layerscape.c   |  2 +-
>  drivers/pci/controller/dwc/pci-meson.c        |  2 +-
>  drivers/pci/controller/dwc/pcie-al.c          |  6 ++--
>  drivers/pci/controller/dwc/pcie-armada8k.c    |  4 +--
>  drivers/pci/controller/dwc/pcie-artpec6.c     |  4 +--
>  .../pci/controller/dwc/pcie-designware-host.c | 36 +++++++++----------
>  .../pci/controller/dwc/pcie-designware-plat.c |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.h  | 30 ++++++++--------
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  4 +--
>  drivers/pci/controller/dwc/pcie-fu740.c       |  2 +-
>  drivers/pci/controller/dwc/pcie-histb.c       | 10 +++---
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |  6 ++--
>  drivers/pci/controller/dwc/pcie-keembay.c     |  4 +--
>  drivers/pci/controller/dwc/pcie-kirin.c       |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  4 +--
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |  6 ++--
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 22 ++++++------
>  drivers/pci/controller/dwc/pcie-uniphier.c    | 10 +++---
>  drivers/pci/controller/dwc/pcie-visconti.c    |  6 ++--
>  23 files changed, 103 insertions(+), 103 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
