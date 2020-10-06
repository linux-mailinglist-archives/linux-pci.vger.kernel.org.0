Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8192845FC
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 08:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgJFG1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 02:27:04 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8461 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFG1E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 02:27:04 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7c0e290000>; Mon, 05 Oct 2020 23:26:49 -0700
Received: from [10.25.78.32] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Oct
 2020 06:26:39 +0000
Subject: Re: [PATCH v2 0/5] PCI: dwc: improve msi handling
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Yue Wang" <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20200924190421.549cb8fc@xhacker.debian>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <b977d9b4-cc98-e817-0d51-8f2c6ba1445d@nvidia.com>
Date:   Tue, 6 Oct 2020 11:56:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200924190421.549cb8fc@xhacker.debian>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601965609; bh=+klW06t1SRSkGS8ctt+a82sY0wQKshniw25tq0QSLaQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=AK0csA0Ad2YZWQjDqG6mpJBocxrJivGMWN4Ul4Khquqsz4sXDbayWAKH2+5u2Z3hb
         Dwnnnmie9OTCA1ZI5fcvM10RVW6SwfJHdZN6r1gyuhgUp4wspP3HQiKKeaPJRlt6TS
         ftqc47lNt61dYxJBT6XlkXDgwQYBcnZRalTTLs1O2CA9N1xHXNIzMp/9BCFgF/3j4d
         FR/UwmF0Mrck4tf7j34h+cbH01kRo3EmTivl9RItdCJTzy1Ka9lt1SfGAsf/zUW7Wi
         aU56gk+7gz9xzR1PbXKZ3xMUxaPWpmb7fA52h1f/jWv9XAwAZ3SE3V+Y+LHJj7Q+fE
         l3eYB+DIUVnkA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
I would like to verify this series along with the other series "PCI: 
dwc: fix two MSI issues" on Tegra194. I tried to apply these series on 
both linux-next and Lorenzo's pci/dwc branches but there seem to be non 
trivial conflicts. Could you please tell me which branch I can use and 
apply these series cleanly?
FWIW, I acknowledge that the existing code does leak MSI target page 
every time system goes through suspend-resume sequence on Tegra194.

Thanks,
Vidya Sagar

On 9/24/2020 4:35 PM, Jisheng Zhang wrote:
> External email: Use caution opening links or attachments
> 
> 
> Improve the msi code:
> 1. Add proper error handling.
> 2. Move dw_pcie_msi_init() from each users to designware host to solve
> msi page leakage in resume path.
> 
> Since v1:
>    - add proper error handling patches.
>    - solve the msi page leakage by moving dw_pcie_msi_init() from each
>      users to designware host
> 
> 
> Jisheng Zhang (5):
>    PCI: dwc: Call dma_unmap_page() before freeing the msi page
>    PCI: dwc: Check alloc_page() return value
>    PCI: dwc: Rename dw_pcie_free_msi to dw_pcie_msi_deinit
>    PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is disabled
>    PCI: dwc: Move dw_pcie_msi_init() from each users to designware host
> 
>   drivers/pci/controller/dwc/pci-dra7xx.c       |  1 +
>   drivers/pci/controller/dwc/pci-exynos.c       |  2 -
>   drivers/pci/controller/dwc/pci-imx6.c         |  3 --
>   drivers/pci/controller/dwc/pci-meson.c        |  8 ----
>   drivers/pci/controller/dwc/pcie-artpec6.c     | 10 -----
>   .../pci/controller/dwc/pcie-designware-host.c | 43 +++++++++++++------
>   .../pci/controller/dwc/pcie-designware-plat.c |  3 --
>   drivers/pci/controller/dwc/pcie-designware.h  |  9 +++-
>   drivers/pci/controller/dwc/pcie-histb.c       |  3 --
>   drivers/pci/controller/dwc/pcie-kirin.c       |  3 --
>   drivers/pci/controller/dwc/pcie-qcom.c        |  3 --
>   drivers/pci/controller/dwc/pcie-spear13xx.c   |  1 -
>   drivers/pci/controller/dwc/pcie-tegra194.c    |  2 -
>   drivers/pci/controller/dwc/pcie-uniphier.c    |  9 +---
>   14 files changed, 38 insertions(+), 62 deletions(-)
> 
> --
> 2.28.0
> 
