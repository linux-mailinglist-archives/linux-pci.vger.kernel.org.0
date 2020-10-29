Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1263B29F7EB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJ2W0b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 18:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgJ2W0a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:26:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B189C0613CF;
        Thu, 29 Oct 2020 15:26:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 15so3496112pgd.12;
        Thu, 29 Oct 2020 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=mkEgROIngf3O0w1+XcYDyb5JIBk2dNaftiZ6UBvH2VU=;
        b=Y9nHCkewbzooPqcIlQFiHkBNDQnXob8eGJMErBn5Kx5FzCfsDuykMaviTzO3vZ7Qnh
         8zWQwRu8DPDT73CdsSIaxrCemeuUruBmPaHs6ieXkGYxgjSxFi/844DmgHOiojMnWXeQ
         NajtcKpsAZ9W/cfZb9bzIkHwOP7aMyTJ4e/LGWa2RGc99u7NDIEplSRzWdGJuhjGU+2O
         KKm4xeT85V500fvlJX8STmkmnn2dRn/OFxCbq1WY6zZ5uIl14OnSbjUgeNZZrEQ+THvZ
         Z2vRyPIq5jyc1DFSExiBvPSOpvbduMcgnKoUE9ixwXQNytNE+9ahAJxbj7dzXASdEjpf
         PsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=mkEgROIngf3O0w1+XcYDyb5JIBk2dNaftiZ6UBvH2VU=;
        b=T9gudzojgkgwQB0GBD8qdwpYTO34CurHWzfOGUwC60gA3AYBTzDeYHjkUzle3GXYko
         SZ3TEINX2ouoOGohIUWdftFRsFswxBCOTd20vTEKtbOGDH6wI069B/U3sJRG4AzmkcTP
         O6N4yxvGaTyIt56xIaL3J7LxdpvD9zwF+juvdnm6F64am2jQPoTLiCIVMpqh8piZ/Rs8
         dZGBv+wZFbBALjfRy/L83LbUqP+qChLJlJ2kTWI+MnSb1XuPdcOyuu3gSllvfK0txL4g
         FZjf4u6XYmip0PM3iPmG3u6/NDtqYe/Mz2nshRlMX2avQ9bHOx1sdclXfxnpUdqcVq8X
         SofA==
X-Gm-Message-State: AOAM530pZQcECzMASC7JJ2nTJTXYANSbbrWW0iYYkf+6lJN/F/R6kguH
        O/kzyY5rkhLL/+YsgobBV2A=
X-Google-Smtp-Source: ABdhPJxLiaVskm2lyywheCpLlw6KpmmKQnxfOGZyB+6+99Bzc075kKu5TiLbCw/mexj2EE4uIqrGNg==
X-Received: by 2002:a62:dd56:0:b029:155:8165:c6c2 with SMTP id w83-20020a62dd560000b02901558165c6c2mr6220236pff.3.1604010389698;
        Thu, 29 Oct 2020 15:26:29 -0700 (PDT)
Received: from SL2P216MB0475.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:19::5])
        by smtp.gmail.com with ESMTPSA id q123sm3967727pfq.56.2020.10.29.15.26.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:26:28 -0700 (PDT)
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
Subject: Re: [PATCH 11/13] PCI: dwc: Move dw_pcie_msi_init() into core
Thread-Topic: [PATCH 11/13] PCI: dwc: Move dw_pcie_msi_init() into core
Thread-Index: AQHWrWuMH1iwupoOnEKPhemhbtsXGKmvKimM
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 29 Oct 2020 22:26:17 +0000
Message-ID: <SL2P216MB0475B8EB98EF27395F5D381FAA140@SL2P216MB0475.KORP216.PROD.OUTLOOK.COM>
References: <20201028204646.356535-1-robh@kernel.org>
 <20201028204646.356535-12-robh@kernel.org>
In-Reply-To: <20201028204646.356535-12-robh@kernel.org>
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
> The host drivers which call dw_pcie_msi_init() are all the ones using
> the built-in MSI controller, so let's move it into the common DWC code.
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
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@axis.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c           |  2 --
>  drivers/pci/controller/dwc/pci-exynos.c           |  4 ----
>  drivers/pci/controller/dwc/pci-imx6.c             |  1 -
>  drivers/pci/controller/dwc/pci-meson.c            |  1 -
>  drivers/pci/controller/dwc/pcie-artpec6.c         |  1 -
>  drivers/pci/controller/dwc/pcie-designware-host.c |  8 +++++---
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  1 -
>  drivers/pci/controller/dwc/pcie-designware.h      | 10 ----------
>  drivers/pci/controller/dwc/pcie-histb.c           |  2 --
>  drivers/pci/controller/dwc/pcie-kirin.c           |  1 -
>  drivers/pci/controller/dwc/pcie-qcom.c            |  2 --
>  drivers/pci/controller/dwc/pcie-spear13xx.c       |  6 +-----
>  drivers/pci/controller/dwc/pcie-tegra194.c        |  2 --
>  drivers/pci/controller/dwc/pcie-uniphier.c        |  1 -
>  14 files changed, 6 insertions(+), 36 deletions(-)

[...]
