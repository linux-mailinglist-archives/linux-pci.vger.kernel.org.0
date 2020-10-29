Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2229F7AD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJ2WSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 18:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2WSm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:18:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560BFC0613CF;
        Thu, 29 Oct 2020 15:18:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h6so3507744pgk.4;
        Thu, 29 Oct 2020 15:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=0JLyqfoztBsM4bd8GDzwKmcvHsdDBe0Vipxzr6rfQ6o=;
        b=efjnQN8BYX87Tjs3cdlMM5rbHmXG6lM/LdGTA8BLHkD+wr3lwYOVZBW7+BdpO4MfuN
         +TlDghiZ4ZXBSa0vZBgvec8u4PN3mBdzhbeITS/6g7uOmseOxMiweI6rZW6wgDEsELgA
         5GIEsVfBMgcdeomUPNI8IW0drzniTV6u41RzzzL1eFFz/g2M/b9y9C1bkx89HRd0ewsE
         iKkqWm+ECzvRLnc685+eeX+FsIH9QcAI09kKGKWs6wHyiNsQxDhRzR8VRrcDoYOivPeO
         LxUYW7C+uSJOblQZDGo0+yJIT7QWRCLremt1WF5O1mljBaXEUpv/5tugMPqYGftgdYCw
         41FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=0JLyqfoztBsM4bd8GDzwKmcvHsdDBe0Vipxzr6rfQ6o=;
        b=Y8iB3lDjkOthfJtZwEkYSI6IJJqZslvRsK3ME7sTo2YLH+yO+sCuuzzQH9IU0B0WpH
         eoiXufw6k2JZ7/nXfs+MaENn881JIMQC2YAQqeCCC8cqM4t4jXkZfABjdk9dQEC3MG6B
         WJCmvPm8ymkKgPSlF+RR+Sgdgivpf8q8Gthjjzw5GJ92SH4l1f5MQE0vPr9U+2jYkiYs
         4Zyuk8MDZ4SgRsgw7n2N18DnrnXxA5MH+ZTMoJqovRJFDvi0W8rBSF4wyijqUleH2NlZ
         XQ+dFhPRbk8nowHPNlOmds12k0mi9N8fetNr94Sa7mNj/LBh5KofHdXyLcOkTKbXwpog
         DZ5A==
X-Gm-Message-State: AOAM533m2Pk77XSj4fAh8MfljhBpTUyoLZNFZrliaLeyoyUcEnJLackA
        4zni3+hCzUtSbO/sO9Kn97Q=
X-Google-Smtp-Source: ABdhPJyKzky7Hlxd2ju++O4t3nei2/mY1jw3pY46QxIKFwE+ZIP26mYCGKOsIJiQiTBtuu8EYwlZAg==
X-Received: by 2002:aa7:9811:0:b029:15d:2c0e:e947 with SMTP id e17-20020aa798110000b029015d2c0ee947mr6362369pfl.76.1604009920927;
        Thu, 29 Oct 2020 15:18:40 -0700 (PDT)
Received: from SL2P216MB0475.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:19::5])
        by smtp.gmail.com with ESMTPSA id 20sm3913757pfh.219.2020.10.29.15.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:18:40 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH 08/13] PCI: dwc: Move MSI interrupt setup into DWC common
 code
Thread-Topic: [PATCH 08/13] PCI: dwc: Move MSI interrupt setup into DWC common
 code
Thread-Index: AQHWrWuFOQ/rIkS/ZEGWk+b2wGddk6mvJ/u9
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 29 Oct 2020 22:18:28 +0000
Message-ID: <SL2P216MB04754345E108C4B2DD752C1FAA140@SL2P216MB0475.KORP216.PROD.OUTLOOK.COM>
References: <20201028204646.356535-1-robh@kernel.org>
 <20201028204646.356535-9-robh@kernel.org>
In-Reply-To: <20201028204646.356535-9-robh@kernel.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/28/20, 4:47 PM, Rob Herring wrote:
>=20
> Platforms using the built-in DWC MSI controller all have a dedicated
> interrupt with "msi" name or at index 0, so let's move setting up the
> interrupt to the common DWC code.
>
> spear13xx and dra7xx are the 2 oddballs with muxed interrupts, so
> we need to prevent configuring the MSI interrupt by setting msi_irq
> to negative.
>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Yue Wang <yue.wang@Amlogic.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Xiaowei Song <songxiaowei@hisilicon.com>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@axis.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  3 +++
>  drivers/pci/controller/dwc/pci-exynos.c       |  6 -----
>  drivers/pci/controller/dwc/pci-imx6.c         |  6 -----
>  drivers/pci/controller/dwc/pci-meson.c        |  6 -----
>  drivers/pci/controller/dwc/pcie-artpec6.c     |  6 -----
> .../pci/controller/dwc/pcie-designware-host.c | 11 +++++++++-
>  .../pci/controller/dwc/pcie-designware-plat.c |  6 -----
>  drivers/pci/controller/dwc/pcie-histb.c       |  6 -----
>  drivers/pci/controller/dwc/pcie-kirin.c       | 22 -------------------
>  drivers/pci/controller/dwc/pcie-qcom.c        |  8 -------
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |  1 +
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  8 -------
>  drivers/pci/controller/dwc/pcie-uniphier.c    |  6 -----
>  13 files changed, 14 insertions(+), 81 deletions(-)

[...]
