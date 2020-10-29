Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A276A29F76E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgJ2WJ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 18:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2WJ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:09:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E721C0613D2;
        Thu, 29 Oct 2020 15:09:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g12so3482578pgm.8;
        Thu, 29 Oct 2020 15:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=U8lXi8OOUAKAM9HahPF2MhkRdpGxM+5pjA1LOCJjWUc=;
        b=CHz77CTXIopVkDxKJbskTpevdxOSErQasxAubh+6XkNKbmt/zLZmVMXibi5/HjH/pS
         zIbuovqvbQ744DbkJN2jcoQdGJGyQwaAgfc3fjciWEMeOu4Okb0yGJEs6nXkzuKqT2jv
         95HlWsYsbQYe7Z6O1TyIZfvd0yOeIm5oh4f28/B+3RwEHyqhPQt3QsoK8RoqZySOSGL6
         iZ5S16MRosVlHePQlw6lxoW05ZwRHCvZ8Zdb3p5J8KoN9KWq899H8ajHZu+9NdJi1LkH
         Ei4CHD9QIBNsUSZ4b7X4QVRuZv6pl0yk4T1r44uSVYWRc1FlfRksdP88IOS3alDxWRhH
         YsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=U8lXi8OOUAKAM9HahPF2MhkRdpGxM+5pjA1LOCJjWUc=;
        b=f7sY/obVKpu8pVYW+KM20HsuY4X3PHKCAtmTseOusognpDnmt4g4DibTHuEg6uEjb4
         T99S9uv1080q+WxpfS2EHwLG7Ay3TbRCrtvebDuSanRT/NSH4sBQD3dFQQs/U9f5pUnQ
         bh3vxwLhepEI+jwKKZttWTDFz4279e86uAy4Y7m4tcqnx+e1M5DKBkbgt5b5qGz2boLw
         U68CqQa/5/TEvHZArG7ig1KnwumzhdLRew6StP5H8E1ADCTVg6AXaNv8IVkekjsFBk5a
         mq6/CQ2xzmGgjUsV3EjBDn2oD5fjvHTOxkm8mfzgd+1m6+KcNBVNtbZCfyebH2u8sglq
         rmUg==
X-Gm-Message-State: AOAM531xIcKH+i1jOO0mUYnY4Hp7Fg00ypvuYfEt5rY8t+CtL4gQ/UHy
        ExXajI728I962JJJqeZsEwQ=
X-Google-Smtp-Source: ABdhPJySlPJX+5wSZiGXs3aTLYF3FP4syhZTj4GSQN2pZhFq/YPl9Z6nMYMsZfnD64YioPfafQ+hGg==
X-Received: by 2002:a17:90a:ef81:: with SMTP id m1mr1995068pjy.212.1604009367153;
        Thu, 29 Oct 2020 15:09:27 -0700 (PDT)
Received: from SL2P216MB0475.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:19::5])
        by smtp.gmail.com with ESMTPSA id s38sm3556477pgm.62.2020.10.29.15.09.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:09:26 -0700 (PDT)
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
Subject: Re: [PATCH 03/13] PCI: dwc: Move "dbi", "dbi2", and "addr_space"
 resource setup into common code
Thread-Topic: [PATCH 03/13] PCI: dwc: Move "dbi", "dbi2", and "addr_space"
 resource setup into common code
Thread-Index: AQHWrWt+/uCmOjVzWE+cqKXErEipD6mvJWds
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 29 Oct 2020 22:09:15 +0000
Message-ID: <SL2P216MB04752DF9839E1CCC8D1B1706AA140@SL2P216MB0475.KORP216.PROD.OUTLOOK.COM>
References: <20201028204646.356535-1-robh@kernel.org>
 <20201028204646.356535-4-robh@kernel.org>
In-Reply-To: <20201028204646.356535-4-robh@kernel.org>
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

On 10/28/20, 4:46 PM, Rob Herring wrote:
>=20
> Most DWC drivers use the common register resource names "dbi", "dbi2", an=
d
> "addr_space", so let's move their setup into the DWC common code.
>
> This means 'dbi_base' in particular is setup later, but it looks like no
> drivers touch DBI registers before dw_pcie_host_init or dw_pcie_ep_init.
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> Cc: Mingkai Hu <mingkai.hu@nxp.com>
> Cc: Roy Zang <roy.zang@nxp.com>
> Cc: Jonathan Chocron <jonnyc@amazon.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

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
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@axis.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  8 ----
>  drivers/pci/controller/dwc/pci-keystone.c     | 29 +-----------
>  .../pci/controller/dwc/pci-layerscape-ep.c    | 37 +--------------
>  drivers/pci/controller/dwc/pcie-al.c          |  9 +---
>  drivers/pci/controller/dwc/pcie-artpec6.c     | 43 ++----------------
>  .../pci/controller/dwc/pcie-designware-ep.c   | 29 ++++++++++--
>  .../pci/controller/dwc/pcie-designware-host.c |  7 +++
>  .../pci/controller/dwc/pcie-designware-plat.c | 45 +------------------
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |  4 --
>  drivers/pci/controller/dwc/pcie-kirin.c       |  5 ---
>  drivers/pci/controller/dwc/pcie-qcom.c        |  8 ----
>  drivers/pci/controller/dwc/pcie-spear13xx.c   | 11 +----
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 22 ---------
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 38 +---------------
>  drivers/pci/controller/dwc/pcie-uniphier.c    |  6 ---
>  15 files changed, 47 insertions(+), 254 deletions(-)

[...]
