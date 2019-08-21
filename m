Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F0A97ED8
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfHUPgM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 11:36:12 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:47262 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbfHUPgM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 11:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566401771; x=1597937771;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=HeRAL57ZNMAXNMbqWA3TBa1f2AwnJdI9onh5PKgKyjI=;
  b=QCiPWfXp9ipE0b+jMNeAmhI4DvYOMgo+YGXXijgWxh6ltUXMRJEP3f8x
   IiMs68kM2J1GXR7I4IWk3kKLtVBgJjaDaOYhDLz7lvzB+bhjaYHmDiRro
   Dx06NEVEuTNNpHblZgeJTyGzWjX6gd/FynY6cV7XWovviF8nLteZoEe8O
   k=;
X-IronPort-AV: E=Sophos;i="5.64,412,1559520000"; 
   d="scan'208";a="696097733"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Aug 2019 15:36:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 825411A2971;
        Wed, 21 Aug 2019 15:36:07 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 15:36:07 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.160.100) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 15:36:00 +0000
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
Subject: [PATCH v4 0/7] Amazon's Annapurna Labs DT-based PCIe host controller driver
Date:   Wed, 21 Aug 2019 18:35:40 +0300
Message-ID: <20190821153545.17635-1-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D18UWC004.ant.amazon.com (10.43.162.77) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for Amazon's Annapurna Labs DT-based PCIe host
controller driver.
Additionally, it adds 3 quirks (ACS, VPD and MSI-X) and 2 generic DWC patches.

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
  PCI/VPD: Add VPD release quirk for Amazon's Annapurna Labs Root Port
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
 .../pci/controller/dwc/pcie-designware-host.c |   8 +
 drivers/pci/quirks.c                          |  37 ++
 drivers/pci/vpd.c                             |  16 +
 include/linux/pci_ids.h                       |   2 +
 9 files changed, 496 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt

-- 
2.17.1

