Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445108BEA6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfHMQd0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 12:33:26 -0400
Received: from foss.arm.com ([217.140.110.172]:40390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfHMQd0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 12:33:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AFD3337;
        Tue, 13 Aug 2019 09:33:23 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C64A03F706;
        Tue, 13 Aug 2019 09:33:20 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:33:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V16 00/13] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20190813163318.GB5070@e121166-lin.cambridge.arm.com>
References: <20190813113627.27251-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813113627.27251-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 13, 2019 at 05:06:14PM +0530, Vidya Sagar wrote:
> Tegra194 has six PCIe controllers based on Synopsys DesignWare core.
> There are two Universal PHY (UPHY) blocks with each supporting 12(HSIO:
> Hisg Speed IO) and 8(NVHS: NVIDIA High Speed) lanes respectively.
> Controllers:0~4 use UPHY lanes from HSIO brick whereas Controller:5 uses
> UPHY lanes from NVHS brick. Lane mapping in HSIO UPHY brick to each PCIe
> controller (0~4) is controlled in XBAR module by BPMP-FW. Since PCIe
> core has PIPE interface, a glue module called PIPE-to-UPHY (P2U) is used
> to connect each UPHY lane (applicable to both HSIO and NVHS UPHY bricks)
> to PCIe controller
> This patch series
> - Adds support for P2U PHY driver
> - Adds support for PCIe host controller
> - Adds device tree nodes each PCIe controllers
> - Enables nodes applicable to p2972-0000 platform
> - Adds helper APIs in Designware core driver to get capability regs offset
> - Adds defines for new feature registers of PCIe spec revision 4
> - Makes changes in DesignWare core driver to get Tegra194 PCIe working
> 
> Testing done on P2972-0000 platform
> - Able to get PCIe link up with on-board Marvel eSATA controller
> - Able to get PCIe link up with NVMe cards connected to M.2 Key-M slot
> - Able to do data transfers with both SATA drives and NVMe cards
> - Able to perform suspend-resume sequence
> 
> Note
> - Enabling x8 slot on P2972-0000 platform requires pinmux driver for Tegra194.
>   It is being worked on currently and hence Controller:5 (i.e. x8 slot) is
>   disabled in this patch series. A future patch series would enable this.
> - This series is based on top of the following series
>   Jisheng's patches to add support to .remove() in Designware sub-system
>   https://patchwork.kernel.org/project/linux-pci/list/?series=98559
>   (Update: Jisheng's patches are now accepted and applied for v5.2)
>   My patches made on top of Jisheng's patches to export various symbols
>   http://patchwork.ozlabs.org/project/linux-pci/list/?series=115671
>   (Update: My above patch series is accepted and applied for v5.3)
>   Another patch of mine to enable BPMP-FW resume in noirq phase
>   http://patchwork.ozlabs.org/patch/1140973/
>   (This is already accepted)
> 
> V16:
> * Added empty lines (cosmetic changes) where required in pcie-tegra194.c file
>   to address Lorenzo's review comments.
> 
> V15:
> * Refactored pcie-tegra194.c code to call only tegra_bpmp_transfer() API
>   in both .probe() path and .resume_noirq() path.
> 
> V14:
> * Addressed Lorenzo's review comments in pcie-tegra194.c file (Patch 13/13)
> * Added a new patch to export dw_pcie_wait_for_link() API
> 
> V13:
> * Addressed Bjorn's review comments for adding Gen-4 specific defines to pci_regs.h header file
> 
> V12:
> * Modified the commit message of patch-3 in this series to address review
>   comments from Lorenzo
> 
> V11:
> * Removed device-tree patches from the series as they are applied to relevant
>   Tegra specific trees by Thierry Reding.
> * Included older Tegra chips to extend quirk that disables MSI interrupt being
>   used for Tegra PCIe root ports.
> * Addressed review comments in P2U driver file.
> 
> V10:
> * Used _relaxed() versions of readl() & writel()
> 
> V9:
> * Made the drivers dependent on ARCH_TEGRA_194_SOC directly
> * Addressed review comments from Dmitry
> 
> V8:
> * Changed P2U driver file name from pcie-p2u-tegra194.c to phy-tegra194-p2u.c
> * Addressed review comments from Thierry and Rob
> 
> V7:
> * Took care of review comments from Rob
> * Added a quirk to disable MSI for root ports
> * Removed using pcie_pme_disable_msi() API in host controller driver
> 
> V6:
> * Removed patch that exports pcie_bus_config symbol
> * Took care of review comments from Thierry and Rob
> 
> V5:
> * Removed redundant APIs in pcie-designware-ep.c file after moving them
>   to pcie-designware.c file based on Bjorn's review comments
> 
> V4:
> * Rebased on top of linux-next top of the tree
> * Addressed Gustavo's comments and added his Ack for some of the changes.
> 
> V3:
> * Addressed review comments from Thierry
> 
> V2:
> * Addressed review comments from Bjorn, Thierry, Jonathan, Rob & Kishon
> * Added more patches in v2 series
> 
> Vidya Sagar (13):
>   PCI: Add #defines for some of PCIe spec r4.0 features
>   PCI: Disable MSI for Tegra root ports
>   PCI: dwc: Perform dbi regs write lock towards the end
>   PCI: dwc: Move config space capability search API
>   PCI: dwc: Add ext config space capability search API
>   PCI: dwc: Export dw_pcie_wait_for_link() API
>   dt-bindings: PCI: designware: Add binding for CDM register check
>   PCI: dwc: Add support to enable CDM register check
>   dt-bindings: Add PCIe supports-clkreq property
>   dt-bindings: PCI: tegra: Add device tree support for Tegra194
>   dt-bindings: PHY: P2U: Add Tegra194 P2U block
>   phy: tegra: Add PCIe PIPE2UPHY support
>   PCI: tegra: Add Tegra194 PCIe support
> 
>  .../bindings/pci/designware-pcie.txt          |    5 +
>  .../bindings/pci/nvidia,tegra194-pcie.txt     |  155 ++
>  Documentation/devicetree/bindings/pci/pci.txt |    5 +
>  .../bindings/phy/phy-tegra194-p2u.txt         |   28 +
>  drivers/pci/controller/dwc/Kconfig            |   10 +
>  drivers/pci/controller/dwc/Makefile           |    1 +
>  .../pci/controller/dwc/pcie-designware-ep.c   |   37 +-
>  .../pci/controller/dwc/pcie-designware-host.c |   14 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |   88 +
>  drivers/pci/controller/dwc/pcie-designware.h  |   12 +
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 1631 +++++++++++++++++
>  drivers/pci/quirks.c                          |   53 +
>  drivers/phy/tegra/Kconfig                     |    7 +
>  drivers/phy/tegra/Makefile                    |    1 +
>  drivers/phy/tegra/phy-tegra194-p2u.c          |  120 ++
>  include/uapi/linux/pci_regs.h                 |   14 +-
>  16 files changed, 2139 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
>  create mode 100644 drivers/pci/controller/dwc/pcie-tegra194.c
>  create mode 100644 drivers/phy/tegra/phy-tegra194-p2u.c
> 

I have applied it to pci/tegra, subject to kbuild test validation,
for v5.4.

Thanks,
Lorenzo
