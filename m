Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598C929F7D2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgJ2WYU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 18:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2WYS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:24:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD866C0613CF;
        Thu, 29 Oct 2020 15:24:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o3so3494158pgr.11;
        Thu, 29 Oct 2020 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=9mqbTtWDUKSZ1WPBFs+gFlrLeX5B0ppunvO1L1WoE6Q=;
        b=tBJct0dOj+8ac7g5SqfP/LNRCHS59hKwwbbqYi7lNSKlrhy/NDKVbecFO37UWLFSp/
         wslaeWTzhgor+pJeRp4v4aqxuk1RlwQu3T14KY0fe1VHrzCOVOurZfXjDiNFQNHPtvIr
         fme+iceW0Mh6HMjDSqOaLFQMu9czNnfzN6jWy7MGypoGZ+uZvmTQ+uVaVQyADFNSzfHN
         puKdoYBwGf6oN8GqUzBpQA9AV5euZaDb1HjxJBVy3nPBOiRn4DO60EX1QYShMUER2Qun
         YgvMXDLhc1c/1EIzR9jy1K6BC4jgBAnu4YWfqGnJb0qP2CCWhoYIXKftkZ6bN2osiqQk
         VJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=9mqbTtWDUKSZ1WPBFs+gFlrLeX5B0ppunvO1L1WoE6Q=;
        b=oioeGLYh86sxblERQ6YqNfEBsNTH5xp4WD7ITY71MgXwKetCDyLJTcjkXtrAsDMHqq
         uoQT7oJvU1ALnQPApxsnZobDRgr4F8SodA1fiBI/ZrwRzVDMKwOqdXqoLMoRW8bQ96jU
         c/htTrkUI9YXo74Cm3KdM7pOjvEveCITJYkOM/+l9hZX7KcxIyHjquM+mHL4jzFmAish
         DTbUYNLP7BLOB8noWgy5tndG+fet1Jr6B/0voUFjIVadexrwOKvsDUwNBazTbjDtD93X
         0xIvr5gzsqHgnPymTovOpdKUy7g4xr9cMCFEpwOj59moHqxn06XY0gvaMBPKN5OYK47w
         7d3A==
X-Gm-Message-State: AOAM531i5gIrv3rgk4Hv/BtK7ZboTP6cT4P4jNBuqr1wL4DVVRIaKD9B
        enuUv+/p05pjZAZJvPmuZJM=
X-Google-Smtp-Source: ABdhPJyf9HkO546mjW9pBJiNrvmxxbKS5PCAVoKRcNjZQMkBpSaL2UdBzGRuMr78otZem6jWtaFUtw==
X-Received: by 2002:a17:90a:7c03:: with SMTP id v3mr1953144pjf.233.1604010258165;
        Thu, 29 Oct 2020 15:24:18 -0700 (PDT)
Received: from SL2P216MB0475.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:19::5])
        by smtp.gmail.com with ESMTPSA id q16sm3686700pff.52.2020.10.29.15.24.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:24:17 -0700 (PDT)
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
Subject: Re: [PATCH 10/13] PCI: dwc: Move link handling into common code
Thread-Topic: [PATCH 10/13] PCI: dwc: Move link handling into common code
Thread-Index: AQHWrWuJoIKvQ2UL9k+TQsNhRy2uqqmvKY0c
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 29 Oct 2020 22:24:06 +0000
Message-ID: <SL2P216MB04751BBE5822E3BA7DA91D76AA140@SL2P216MB0475.KORP216.PROD.OUTLOOK.COM>
References: <20201028204646.356535-1-robh@kernel.org>
 <20201028204646.356535-11-robh@kernel.org>
In-Reply-To: <20201028204646.356535-11-robh@kernel.org>
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
> All the DWC drivers do link setup and checks at roughly the same time.
> Let's use the existing .start_link() hook (currently only used in EP
> mode) and move the link handling to the core code.
>
> The behavior for a link down was inconsistent as some drivers would fail
> probe in that case while others succeed. Let's standardize this to
> succeed as there are usecases where devices (and the link) appear later
> even without hotplug. For example, a reconfigured FPGA device.
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
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 -
>  drivers/pci/controller/dwc/pci-exynos.c       | 41 +++++++----------
>  drivers/pci/controller/dwc/pci-imx6.c         |  9 ++--
>  drivers/pci/controller/dwc/pci-keystone.c     |  9 ----
>  drivers/pci/controller/dwc/pci-meson.c        | 24 ++++------
>  drivers/pci/controller/dwc/pcie-armada8k.c    | 39 +++++++---------
>  drivers/pci/controller/dwc/pcie-artpec6.c     |  2 -
>  .../pci/controller/dwc/pcie-designware-host.c |  9 ++++
>  .../pci/controller/dwc/pcie-designware-plat.c |  3 --
>  drivers/pci/controller/dwc/pcie-histb.c       | 34 +++++++-------
>  drivers/pci/controller/dwc/pcie-kirin.c       | 23 ++--------
>  drivers/pci/controller/dwc/pcie-qcom.c        | 19 ++------
>  drivers/pci/controller/dwc/pcie-spear13xx.c   | 46 ++++++++-----------
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  1 -
>  drivers/pci/controller/dwc/pcie-uniphier.c    | 13 ++----
>  15 files changed, 103 insertions(+), 171 deletions(-)

[...]
