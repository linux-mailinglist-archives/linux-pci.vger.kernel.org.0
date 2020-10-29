Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA429F866
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgJ2WeF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 18:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJ2WeE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:34:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A5C0613CF;
        Thu, 29 Oct 2020 15:34:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t22so1987525plr.9;
        Thu, 29 Oct 2020 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=odZpHbQegqT56U/cV/zJ1qrd6r3mGVChHF0VMSj69o0=;
        b=gy+FevCWq3xOKFvYbDpwz/v/EbxdJwTn9QVRUJOTJih66PW1TK/3NCZSJDPw9s+lse
         bkn74gnr4dgUfMBduEsxwTi2+ufO5e/+hUGIsMqkVs/R90SRyOZN7E7Oo/Uiz4+/kdKI
         XSLd+pdpeS8hOp+w4CCkgtaXITBk3FeqS/Atf8ilvae/ogwHTlVc0Ego1liS94BkKlv+
         1upTB8XaECpXOjZFIGOHsSRwFVRuMF4SuobL1D0hQWgog7GripUtaiOtQDlhGkAE3kHv
         vTu7ty07GqlJzrf6WKLjk+wXp1xMQLRtLDu6cF6UfdcVzOs3s0GSgD61pl8eeKqYlUAH
         skUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=odZpHbQegqT56U/cV/zJ1qrd6r3mGVChHF0VMSj69o0=;
        b=toCkpp2fJVNA4rWdPnuG+nMhgntKCah4QGwv7jEIc83MveQpIwSFD0vqdlSamua1S0
         eFu0G6JGOzJ7IU9UaPRJnu55DCfG+liltECv3qI5I6Dwr1B/t+QRUebbjihJQotgLZ/A
         LYlOya6TLmqppvRj2JWaCGYzGtTBDeHCj3+6Kkhr3lsqDFI1GztQvftKDzoc/riMtsQM
         S3ngwsK82COrTYolZNfTe7L0qd6bv56VFwZlN2Dwqs4SWvCS/4STBVI4a7Pv1erP0ZHJ
         Ub6zRCZHd5hM1NYFjRYl6uOXzjd2vuYJgU3mIxAlf1bMMY9RIVYjcAsjrnE7UQ6VLgmK
         hzSQ==
X-Gm-Message-State: AOAM531s7noa3lq1DpYbk8gxCs9fKcE+qlh/DYUINuFsCD4bBSKuk3iP
        onfa5ga6HbuEZoR+YaQcUVs=
X-Google-Smtp-Source: ABdhPJz+1FMPSkLVT3GNpxHHfWtt2o0ojp3jORJQkn1z2v1aWL9snq6p3aEN0mFkDfNYztLrINb5ag==
X-Received: by 2002:a17:902:bd01:b029:d4:d73d:7644 with SMTP id p1-20020a170902bd01b02900d4d73d7644mr6117533pls.69.1604010843618;
        Thu, 29 Oct 2020 15:34:03 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id i24sm3912204pfd.7.2020.10.29.15.33.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:34:02 -0700 (PDT)
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
Subject: Re: [PATCH 12/13] PCI: dwc: Move dw_pcie_setup_rc() to DWC common
 code
Thread-Topic: [PATCH 12/13] PCI: dwc: Move dw_pcie_setup_rc() to DWC common
 code
Thread-Index: AQHWrWuNe0SVTqZ+qUiqNCgd41OCHamvKtka
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 29 Oct 2020 22:29:06 +0000
Message-ID: <SLXP216MB047727F5D8FE67D796651A8BAA140@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201028204646.356535-1-robh@kernel.org>
 <20201028204646.356535-13-robh@kernel.org>
In-Reply-To: <20201028204646.356535-13-robh@kernel.org>
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
> All RC complex drivers must call dw_pcie_setup_rc(). The ordering of the
> call shouldn't be too important other than being after any RC resets.
>
> There's a few calls of dw_pcie_setup_rc() left as drivers implementing
> suspend/resume need it.
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> Cc: Mingkai Hu <mingkai.hu@nxp.com>
> Cc: Roy Zang <roy.zang@nxp.com>
> Cc: Yue Wang <yue.wang@Amlogic.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Xiaowei Song <songxiaowei@hisilicon.com>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@axis.com
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c           | 1 -
>  drivers/pci/controller/dwc/pci-exynos.c           | 1 -
>  drivers/pci/controller/dwc/pci-imx6.c             | 1 -
>  drivers/pci/controller/dwc/pci-keystone.c         | 2 --
>  drivers/pci/controller/dwc/pci-layerscape.c       | 2 --
>  drivers/pci/controller/dwc/pci-meson.c            | 2 --
>  drivers/pci/controller/dwc/pcie-armada8k.c        | 2 --
>  drivers/pci/controller/dwc/pcie-artpec6.c         | 1 -
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 8 --------
>  drivers/pci/controller/dwc/pcie-histb.c           | 3 ---
>  drivers/pci/controller/dwc/pcie-kirin.c           | 2 --
>  drivers/pci/controller/dwc/pcie-qcom.c            | 1 -
>  drivers/pci/controller/dwc/pcie-spear13xx.c       | 2 --
>  drivers/pci/controller/dwc/pcie-uniphier.c        | 2 --
>  15 files changed, 1 insertion(+), 30 deletions(-)

[...]
