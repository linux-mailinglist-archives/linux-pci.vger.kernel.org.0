Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA17AA53F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfIEOAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 10:00:45 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:38982 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfIEOAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 10:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567692045; x=1599228045;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=mOTha34gu7LiNjrKRb5+XMuiqCCl6REbYMmzCsT4pk0=;
  b=mZoYWvbbbuWJjUthitgqqn/CPhKaIQk4nZoEWKX8tpmx7DCm0pHTc/Cp
   /n6VaN+OD8mF7wZcnfdb/LHwc28SY1ogxtSO9QoUm34/8jC9x6OUSfT5U
   rcr4vm5NDr41wIsr+Mero4/FOmU1j4nx+ZfWkugGA2djQB78R94doAYD1
   I=;
X-IronPort-AV: E=Sophos;i="5.64,470,1559520000"; 
   d="scan'208";a="827733109"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Sep 2019 14:00:42 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id A241CA1E4C;
        Thu,  5 Sep 2019 14:00:38 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Sep 2019 14:00:38 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.160.20) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Sep 2019 14:00:31 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <andrew.murray@arm.com>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <alisaidi@amazon.com>,
        <ronenk@amazon.com>, <barakw@amazon.com>, <talel@amazon.com>,
        <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v5 0/7] Amazon's Annapurna Labs DT-based PCIe host controller driver
Date:   Thu, 5 Sep 2019 17:00:14 +0300
Message-ID: <20190905140018.5139-1-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.20]
X-ClientProxiedBy: EX13D06UWA002.ant.amazon.com (10.43.160.143) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for Amazon's Annapurna Labs DT-based PCIe host
controller driver.
Additionally, it adds 3 quirks (ACS, VPD and MSI-X) and 2 generic DWC patches.

Changes since v4:
- Moved the HEADER_TYPE validations to after pp->ops->host_init() and
  ep->ops->ep_init()
- Changed to dw_pcie_rd_own_conf() instead of dw_pcie_readb_dbi() for
  reading the HEADER_TYPE
- Used exsitng quirk_blacklist_vpd() instead of quirk_al_vpd_release()
- Added a newline in ACS quirk comment

Changes since v3:
- Removed PATCH 8/8 since the usage of the PCI flags will be discussed
  in the upcoming LPC
- Align commit subject with the folder convention
- Added explanation regarding ECAM "overload" mechanism
- Switched to read/write{_relaxed} APIs
- Modified a dev_err to dev_dbg
- Removed unnecessary variable
- Removed driver details from dt-binding description
- Changed to SoC specific compatibles
- Fixed typo in a commit message
- Added comment regarding MSI in the MSI-X quirk

Changes since v2:
- Added al_pcie_controller_readl/writel() wrappers
- Reorganized local vars in several functions according to reverse
  tree structure
- Removed unnecessary check of ret value
- Changed return type of al_pcie_config_prepare() from int to void
- Removed check if link is up from probe() [done internally in
  dw_pcie_rd/wr_conf()]

Changes since v1:
- Added comment regarding 0x0031 being used as a dev_id for non root-port devices as well
- Fixed different message/comment/print wordings
- Added panic stacktrace to commit message of MSI-x quirk patch
- Changed to pci_warn() instead of dev_warn()
- Added unit_address after node_name in dt-binding
- Updated Kconfig help description
- Used GENMASK and FIELD_PREP/GET where appropriate
- Removed leftover field from struct al_pcie and moved all ptrs to
  the beginning
- Re-wrapped function definitions and invocations to use fewer lines
- Change %p to %px in dbg prints in rd/wr_conf() functions
- Removed validation that the port is configured to RC mode (as this is
  added generically in PATCH 7/8)
- Removed unnecessary variable initializations
- Swtiched to %pR for printing resources


Ali Saidi (1):
  PCI: Add ACS quirk for Amazon Annapurna Labs root ports

Jonathan Chocron (6):
  PCI: Add Amazon's Annapurna Labs vendor ID
  PCI/VPD: Prevent VPD access for Amazon's Annapurna Labs Root Port
  PCI: Add quirk to disable MSI-X support for Amazon's Annapurna Labs
    Root Port
  dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host bridge binding
  PCI: dwc: al: Add support for DW based driver type
  PCI: dwc: Add validation that PCIe core is set to correct mode

 .../devicetree/bindings/pci/pcie-al.txt       |  46 +++
 MAINTAINERS                                   |   3 +-
 drivers/pci/controller/dwc/Kconfig            |  12 +
 drivers/pci/controller/dwc/pcie-al.c          | 365 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   8 +
 .../pci/controller/dwc/pcie-designware-host.c |  16 +
 drivers/pci/quirks.c                          |  38 ++
 drivers/pci/vpd.c                             |   6 +
 include/linux/pci_ids.h                       |   2 +
 9 files changed, 495 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt

-- 
2.17.1

