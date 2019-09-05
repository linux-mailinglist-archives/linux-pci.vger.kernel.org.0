Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C838AA961
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbfIEQx2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 12:53:28 -0400
Received: from foss.arm.com ([217.140.110.172]:47530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbfIEQx2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 12:53:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A06128;
        Thu,  5 Sep 2019 09:53:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 529E83F718;
        Thu,  5 Sep 2019 09:53:25 -0700 (PDT)
Date:   Thu, 5 Sep 2019 17:53:16 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jonathan Chocron <jonnyc@amazon.com>, bhelgaas@google.com
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andrew.murray@arm.com,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, alisaidi@amazon.com,
        ronenk@amazon.com, barakw@amazon.com, talel@amazon.com,
        hanochu@amazon.com, hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/7] Amazon's Annapurna Labs DT-based PCIe host
 controller driver
Message-ID: <20190905165309.GA10248@e121166-lin.cambridge.arm.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905140018.5139-1-jonnyc@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 05:00:14PM +0300, Jonathan Chocron wrote:
> This series adds support for Amazon's Annapurna Labs DT-based PCIe host
> controller driver.
> Additionally, it adds 3 quirks (ACS, VPD and MSI-X) and 2 generic DWC patches.
> 
> Changes since v4:
> - Moved the HEADER_TYPE validations to after pp->ops->host_init() and
>   ep->ops->ep_init()
> - Changed to dw_pcie_rd_own_conf() instead of dw_pcie_readb_dbi() for
>   reading the HEADER_TYPE
> - Used exsitng quirk_blacklist_vpd() instead of quirk_al_vpd_release()
> - Added a newline in ACS quirk comment
> 
> Changes since v3:
> - Removed PATCH 8/8 since the usage of the PCI flags will be discussed
>   in the upcoming LPC
> - Align commit subject with the folder convention
> - Added explanation regarding ECAM "overload" mechanism
> - Switched to read/write{_relaxed} APIs
> - Modified a dev_err to dev_dbg
> - Removed unnecessary variable
> - Removed driver details from dt-binding description
> - Changed to SoC specific compatibles
> - Fixed typo in a commit message
> - Added comment regarding MSI in the MSI-X quirk
> 
> Changes since v2:
> - Added al_pcie_controller_readl/writel() wrappers
> - Reorganized local vars in several functions according to reverse
>   tree structure
> - Removed unnecessary check of ret value
> - Changed return type of al_pcie_config_prepare() from int to void
> - Removed check if link is up from probe() [done internally in
>   dw_pcie_rd/wr_conf()]
> 
> Changes since v1:
> - Added comment regarding 0x0031 being used as a dev_id for non root-port devices as well
> - Fixed different message/comment/print wordings
> - Added panic stacktrace to commit message of MSI-x quirk patch
> - Changed to pci_warn() instead of dev_warn()
> - Added unit_address after node_name in dt-binding
> - Updated Kconfig help description
> - Used GENMASK and FIELD_PREP/GET where appropriate
> - Removed leftover field from struct al_pcie and moved all ptrs to
>   the beginning
> - Re-wrapped function definitions and invocations to use fewer lines
> - Change %p to %px in dbg prints in rd/wr_conf() functions
> - Removed validation that the port is configured to RC mode (as this is
>   added generically in PATCH 7/8)
> - Removed unnecessary variable initializations
> - Swtiched to %pR for printing resources
> 
> 
> Ali Saidi (1):
>   PCI: Add ACS quirk for Amazon Annapurna Labs root ports
> 
> Jonathan Chocron (6):
>   PCI: Add Amazon's Annapurna Labs vendor ID
>   PCI/VPD: Prevent VPD access for Amazon's Annapurna Labs Root Port
>   PCI: Add quirk to disable MSI-X support for Amazon's Annapurna Labs
>     Root Port
>   dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host bridge binding
>   PCI: dwc: al: Add support for DW based driver type
>   PCI: dwc: Add validation that PCIe core is set to correct mode
> 
>  .../devicetree/bindings/pci/pcie-al.txt       |  46 +++
>  MAINTAINERS                                   |   3 +-
>  drivers/pci/controller/dwc/Kconfig            |  12 +
>  drivers/pci/controller/dwc/pcie-al.c          | 365 ++++++++++++++++++
>  .../pci/controller/dwc/pcie-designware-ep.c   |   8 +
>  .../pci/controller/dwc/pcie-designware-host.c |  16 +
>  drivers/pci/quirks.c                          |  38 ++
>  drivers/pci/vpd.c                             |   6 +
>  include/linux/pci_ids.h                       |   2 +
>  9 files changed, 495 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt

Hi Bjorn,

I would like to queue this series for v5.4 but I need your ACK on
patches 2/3/4 for that to happen, please let me know.

Thanks,
Lorenzo
