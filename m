Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC629F79B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJ2WPp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 18:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2WPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:15:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09703C0613CF;
        Thu, 29 Oct 2020 15:15:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f38so3513355pgm.2;
        Thu, 29 Oct 2020 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=wb9YwAxk2NQxLFpcYqM6hbPaI2aklAiVUdGq2NV0NhI=;
        b=ATMcJHxQmcMBWJSdahPYM75Ks+3p5JFHoEoVc7wKHtTMTbGrJ5GPrQzOTiqlY/O2FA
         WcTEd1DVFH8+A73QhQ7zJ1qFHeH931aweF+gFgULPrr0iJsUs9Arm7T0zDOQ7iGDiXIr
         K62PsZ6J0HRNE6V/79CiAYGV5qsWbEjJZ4U/s4YTUzibO5SupXBCGG4Yd4cmcB6LnzJL
         ucNZ9eyosFtlWjFHFpJ4JjOOjjyB8hIRnG42xcgmVOsrZkbJkz320MI+awHTrpziRXml
         0CcGcuey+fWXuCZiaAV7DePF42FtnVFkTRchEYkAoEEQtmtloHnfynN+A7jngOoU0BUr
         hlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=wb9YwAxk2NQxLFpcYqM6hbPaI2aklAiVUdGq2NV0NhI=;
        b=J4D8UoN3un1Y/qyb212yXolOaCHMTep5PrE0l/gwAJgV9qtSSR1Zcrst2s6+TxnXeI
         ZvOggVpVRPmVvrT/r1mWjMZi1Ws+21UUgLaTPNTtvrLsEUiSedvhv/ehm8WK5HTPErce
         HtilPGqAmhfxIZMY5G0Ujdav7/4JPNzk2HicjJF/nTV2FAS7tMTYxdIATPjNneuvi5ff
         S5Bru1H9cIFwuosZlW8GnRhcftRTG6oKG0wQSP8kTvZ5KGgRneobmYYBTxHXS6MM1YU5
         2u3kM9oGas00jAepu/uirNhWwrNPAOwbyQagLZU8Yr5QgwzVNRwqb8+xNNRTAlV+zSU5
         RAww==
X-Gm-Message-State: AOAM531ijpOUvZ5XWIE+McARb+PxgrxJGiqHcOzIsV4CG+EJ/5rOlx9x
        80xX2zcZ0bcrk0CVlLrRby0=
X-Google-Smtp-Source: ABdhPJxlHYl+cZgk+KIPjNe48JdRu/zKn8ZJifDV9M3gXsbKATnx6XuuuC+nrXnuW0dPRIEWcL42zA==
X-Received: by 2002:a17:90a:bf05:: with SMTP id c5mr1353597pjs.11.1604009744576;
        Thu, 29 Oct 2020 15:15:44 -0700 (PDT)
Received: from SL2P216MB0475.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:19::5])
        by smtp.gmail.com with ESMTPSA id 34sm1704038pgv.53.2020.10.29.15.15.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:15:43 -0700 (PDT)
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
Subject: Re: [PATCH 07/13] PCI: dwc: Drop the .set_num_vectors() host op
Thread-Topic: [PATCH 07/13] PCI: dwc: Drop the .set_num_vectors() host op
Thread-Index: AQHWrWuFryq4LWMsWUG3+ygcwfeheamvJygg
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 29 Oct 2020 22:15:32 +0000
Message-ID: <SL2P216MB0475BFB1A3DF471129F61B93AA140@SL2P216MB0475.KORP216.PROD.OUTLOOK.COM>
References: <20201028204646.356535-1-robh@kernel.org>
 <20201028204646.356535-8-robh@kernel.org>
In-Reply-To: <20201028204646.356535-8-robh@kernel.org>
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
> There's no reason for the .set_num_vectors() host op. Drivers needing a
> non-default value can just initialize pcie_port.num_vectors directly.
>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 19 ++++---------------
>  .../pci/controller/dwc/pcie-designware-plat.c |  7 +------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  7 +------
>  4 files changed, 6 insertions(+), 28 deletions(-)

[...]
