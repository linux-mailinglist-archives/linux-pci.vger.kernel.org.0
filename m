Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6DBB0F64
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 15:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfILNBk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 09:01:40 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:28222 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILNBk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 09:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568293298; x=1599829298;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5vMnttMVn1m3hZniO4vh6FvR91fgQ2Rf01D6DZD1UBk=;
  b=vu5ODvkm4RTFnqNVsEe3Gl1Q7ynW5saSNfTJ7aicsoEreE89+Wfm0Gov
   3UaJVfK/ubTDiWJohe1CAwIdIpj/9/nJEwuEgzJnePC0CZBjdTIsnq+OU
   LRnCxgvZHphTNInogmuUV5KBTsh/YpoaFLD0fMfnN9s7bTqQjlAD9PwnL
   4=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="420818728"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 12 Sep 2019 13:01:37 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 42812A2403;
        Thu, 12 Sep 2019 13:01:33 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:01:33 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.82) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:01:27 +0000
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
Subject: [PATCH v6 0/7] Amazon's Annapurna Labs DT-based PCIe host controller driver
Date:   Thu, 12 Sep 2019 16:00:38 +0300
Message-ID: <20190912130042.14597-1-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.82]
X-ClientProxiedBy: EX13D02UWC003.ant.amazon.com (10.43.162.199) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for Amazon's Annapurna Labs DT-based PCIe host
controller driver.
Additionally, it adds 3 quirks (ACS, VPD and MSI-X) and 2 generic DWC patches.

Changes since v5:
- Modified commit subject of PATCH 6/7
- Removed timestamps from commit message of PATCH 4/7
- Modified ACS quirk according to Bjorn's comments

Changes since v4:
- Moved the HEADER_TYPE validations to after pp->ops->host_init() and
  ep->ops->ep_init()
- Changed to dw_pcie_rd_own_conf() instead of dw_pcie_readb_dbi() for
  reading the HEADER_TYPE
- Used existing quirk_blacklist_vpd() instead of quirk_al_vpd_release()
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
- Switched to %pR for printing resources


Ali Saidi (1):
  PCI: Add ACS quirk for Amazon Annapurna Labs root ports

Jonathan Chocron (6):
  PCI: Add Amazon's Annapurna Labs vendor ID
  PCI/VPD: Prevent VPD access for Amazon's Annapurna Labs Root Port
  PCI: Add quirk to disable MSI-X support for Amazon's Annapurna Labs
    Root Port
  dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host bridge binding
  PCI: dwc: al: Add Amazon Annapurna Labs PCIe controller driver
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

