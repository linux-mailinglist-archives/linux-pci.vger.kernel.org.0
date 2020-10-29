Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394DD29F7BA
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgJ2WUe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 18:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2WUd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:20:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EA9C0613CF;
        Thu, 29 Oct 2020 15:20:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 133so3546183pfx.11;
        Thu, 29 Oct 2020 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=FOoaeCn33/ipYh2zHeIJMAsJ57EgPtJEMeLEEZX4GBg=;
        b=JXYioUG+T5BQ59RxZlgLJQH7xPvNe0cS4rzH12hBu8Sym70lt57gs1Pkds6SaAC90f
         C3p4B/4Q6npqOo5DKBxAKnFr8Kr4AF1uO+D+Ybt8FQbFC+7/aOyWoa6f6jO36vPhv0gf
         Jjtf9S6d68AHuDpRG+QKdxw5bSxHZGZXSEik17nQFn+f68Wqy2q3nvCZtN6+WU98ZRAG
         VszFLN/zelOKJe17cacdXwXVg7TJ/4AjuBm4KJpsj6U1SK4lG4aAOMOWRXgBcboPoO8U
         tsx9Md4BKIalifnFtjCPMfAoZtgsGDdYTZBqkx2AAhFMAKZyDqleF9XqFeOmr5LPiz12
         Ereg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=FOoaeCn33/ipYh2zHeIJMAsJ57EgPtJEMeLEEZX4GBg=;
        b=fJuUV8D476/iczqjxtEx1cqy4FsNsh9hiwWOwQH8XYexLGaRvn0XDmfVAkgolJlvHZ
         2ueRsnzoClIs1fJy7eSI/piuBkwsukbVOaCMjvfG72XfbYtVOPLT5BP1/31q6LgmTEyv
         PSQaX5kdPhuJ7YoOP1ldKn3l+RMvj8mPUNMVf4iozW/YRIRjMKs2BzJOlOiTmI56mdsp
         X4dOnqOzD4O4EAwrHUI2rBRmHWgDCTQ5TZgHb5KM3iFXjba5TstEiKUub5tDIga6Jm1r
         cYGDgfiOrs248visslmRyMv2wQxvIK8AtW7wtWaM8r8XAMvtMvcfahdHAps6kdVAddcd
         QWBg==
X-Gm-Message-State: AOAM5324ggPGvdY0Si7Nsw68sSripJMXiL5btok3nQ/PiuzVxiNBzH08
        vyDfVyGEjeSi2XMCjXAmsjM=
X-Google-Smtp-Source: ABdhPJzIHxSZFeeHkKrEYBnNoJGKIQEtuuPzw7YrhdkseS3FZyrRqbwhxcs5J9Iyjnq9UuKpbBh01Q==
X-Received: by 2002:a17:90a:ab8b:: with SMTP id n11mr1378340pjq.162.1604010031783;
        Thu, 29 Oct 2020 15:20:31 -0700 (PDT)
Received: from SL2P216MB0475.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:19::5])
        by smtp.gmail.com with ESMTPSA id i30sm3772040pgb.81.2020.10.29.15.20.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:20:30 -0700 (PDT)
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
Subject: Re: [PATCH 09/13] PCI: dwc: Rework MSI initialization
Thread-Topic: [PATCH 09/13] PCI: dwc: Rework MSI initialization
Thread-Index: AQHWrWuJaaGDQXSS2Eu3W5SQBB5/HqmvKH4y
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 29 Oct 2020 22:20:19 +0000
Message-ID: <SL2P216MB0475953C235B27D3E6C01CE2AA140@SL2P216MB0475.KORP216.PROD.OUTLOOK.COM>
References: <20201028204646.356535-1-robh@kernel.org>
 <20201028204646.356535-10-robh@kernel.org>
In-Reply-To: <20201028204646.356535-10-robh@kernel.org>
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
> There are 3 possible MSI implementations for the DWC host. The first is
> using the built-in DWC MSI controller. The 2nd is a custom MSI
> controller as part of the PCI host (keystone only). The 3rd is an
> external MSI controller (typically GICv3 ITS). Currently, the last 2
> are distinguished with a .msi_host_init() hook with the 3rd option using
> an empty function. However we can detect the 3rd case with the presence
> of 'msi-parent' or 'msi-map' properties, so let's do that instead and
> remove the empty functions.
>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> Cc: Mingkai Hu <mingkai.hu@nxp.com>
> Cc: Roy Zang <roy.zang@nxp.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c     |  9 -------
>  drivers/pci/controller/dwc/pci-layerscape.c   | 25 -------------------
>  .../pci/controller/dwc/pcie-designware-host.c | 20 +++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |  9 -------
>  5 files changed, 13 insertions(+), 51 deletions(-)

[...]
