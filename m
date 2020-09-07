Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0125F696
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 11:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgIGJgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 05:36:10 -0400
Received: from foss.arm.com ([217.140.110.172]:58790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgIGJgH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 05:36:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D06430E;
        Mon,  7 Sep 2020 02:36:06 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BF733F66E;
        Mon,  7 Sep 2020 02:36:01 -0700 (PDT)
Date:   Mon, 7 Sep 2020 10:35:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 00/40] PCI: dwc: Driver clean-ups
Message-ID: <20200907093558.GC6428@e121166-lin.cambridge.arm.com>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 20, 2020 at 09:53:40PM -0600, Rob Herring wrote:
> This is a series of clean-ups for the Designware PCI driver. The series
> initially reworks the config space accessors to use the existing pci_ops
> struct. Then there's removal of various private data that's also present
> in the pci_host_bridge struct. There's also some duplicated common (PCI
> and DWC) register defines which I converted to use the common defines.
> Finally, the initialization for speed/gen, number of lanes, and N_FTS
> are all moved to the common DWC code.
> 
> This is compile tested only as I don't have any DWC based h/w, so any
> testing would be helpful. A branch is here[1].

Applied the series to pci/dwc, thanks.

Lorenzo

> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-dw-cleanups
> 
> Rob Herring (40):
>   PCI: Allow root and child buses to have different pci_ops
>   PCI: dwc: Use DBI accessors instead of own config accessors
>   PCI: dwc: Allow overriding bridge pci_ops
>   PCI: dwc: Add a default pci_ops.map_bus for root port
>   PCI: dwc: al: Use pci_ops for child config space accessors
>   PCI: dwc: keystone: Use pci_ops for config space accessors
>   PCI: dwc: tegra: Use pci_ops for root config space accessors
>   PCI: dwc: meson: Use pci_ops for root config space accessors
>   PCI: dwc: kirin: Use pci_ops for root config space accessors
>   PCI: dwc: exynos: Use pci_ops for root config space accessors
>   PCI: dwc: histb: Use pci_ops for root config space accessors
>   PCI: dwc: Remove dwc specific config accessor ops
>   PCI: dwc: Use generic config accessors
>   PCI: Also call .add_bus() callback for root bus
>   PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus
>   PCI: dwc: Convert to use pci_host_probe()
>   PCI: dwc: Remove root_bus pointer
>   PCI: dwc: Remove storing of PCI resources
>   PCI: dwc: Simplify config space handling
>   PCI: dwc/keystone: Drop duplicated 'num-viewport'
>   PCI: dwc: Check CONFIG_PCI_MSI inside dw_pcie_msi_init()
>   PCI: dwc/imx6: Remove duplicate define PCIE_LINK_WIDTH_SPEED_CONTROL
>   PCI: dwc: Add a 'num_lanes' field to struct dw_pcie
>   PCI: dwc: Ensure FAST_LINK_MODE is cleared
>   PCI: dwc/meson: Drop the duplicate number of lanes setup
>   PCI: dwc/meson: Drop unnecessary RC config space initialization
>   PCI: dwc/meson: Rework PCI config and DW port logic register accesses
>   PCI: dwc/imx6: Use common PCI register definitions
>   PCI: dwc/qcom: Use common PCI register definitions
>   PCI: dwc: Remove hardcoded PCI_CAP_ID_EXP offset
>   PCI: dwc/tegra: Use common Designware port logic register definitions
>   PCI: dwc: Remove read_dbi2 code
>   PCI: dwc: Make ATU accessors private
>   PCI: dwc: Centralize link gen setting
>   PCI: dwc: Set PORT_LINK_DLL_LINK_EN in common setup code
>   PCI: dwc/intel-gw: Drop unnecessary checking of DT 'device_type'
>     property
>   PCI: dwc/intel-gw: Move getting PCI_CAP_ID_EXP offset to
>     intel_pcie_link_setup()
>   PCI: dwc/intel-gw: Drop unused max_width
>   PCI: dwc: Move N_FTS setup to common setup
>   PCI: dwc: Use DBI accessors
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  29 +-
>  drivers/pci/controller/dwc/pci-exynos.c       |  45 +--
>  drivers/pci/controller/dwc/pci-imx6.c         |  52 +--
>  drivers/pci/controller/dwc/pci-keystone.c     | 126 ++-----
>  drivers/pci/controller/dwc/pci-meson.c        | 156 ++-------
>  drivers/pci/controller/dwc/pcie-al.c          |  70 +---
>  drivers/pci/controller/dwc/pcie-artpec6.c     |  48 +--
>  .../pci/controller/dwc/pcie-designware-ep.c   |  11 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 319 ++++++------------
>  .../pci/controller/dwc/pcie-designware-plat.c |   4 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 104 +++---
>  drivers/pci/controller/dwc/pcie-designware.h  |  54 +--
>  drivers/pci/controller/dwc/pcie-histb.c       |  45 +--
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |  65 +---
>  drivers/pci/controller/dwc/pcie-kirin.c       |  43 +--
>  drivers/pci/controller/dwc/pcie-qcom.c        |  33 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |  39 +--
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 120 ++-----
>  drivers/pci/controller/dwc/pcie-uniphier.c    |   3 +-
>  drivers/pci/probe.c                           |  14 +-
>  include/linux/pci.h                           |   1 +
>  21 files changed, 443 insertions(+), 938 deletions(-)
> 
> --
> 2.25.1
