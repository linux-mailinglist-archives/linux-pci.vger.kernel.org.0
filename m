Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5A6CC27
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2019 11:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389818AbfGRJpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jul 2019 05:45:55 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:26400 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRJpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jul 2019 05:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563443154; x=1594979154;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=u1OZ0RKFDA8KTxhSUk4edGI+HfrldPAbhHw2+/kPPjo=;
  b=Q6QQutm6/Vex5FifA6XSDS6jl5fu+KZSbkSNSmro8XNE0KeF1Zr6a60E
   y+DcsqIt+lmKA8Homgv7YpscgSHEdHOeA80oDONo9qGOa86mbqFsyYHu7
   k9MIS+7x3VFSPDClNygPIHwVq9ZA8TiyFgMVjRii7xyi7BB9AeVQKoABm
   M=;
X-IronPort-AV: E=Sophos;i="5.64,276,1559520000"; 
   d="scan'208";a="411235357"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 18 Jul 2019 09:45:53 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 6014C1419F0;
        Thu, 18 Jul 2019 09:45:50 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:45:49 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.162.67) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:45:43 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v2 0/8] Amazon's Annapurna Labs DT-based PCIe host controller driver
Date:   Thu, 18 Jul 2019 12:45:23 +0300
Message-ID: <20190718094531.21423-1-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.67]
X-ClientProxiedBy: EX13P01UWA004.ant.amazon.com (10.43.160.127) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for Amazon's Annapurna Labs DT-based PCIe host
controller driver.
Additionally, it adds 3 quirks (ACS, VPD and MSI-X) and 2 generic DWC patches.

Regarding the 2nd DWC patch (PCI flags support), do you think this should
be done in the context of a host-bridge driver at all (as opposed to PCI
system-wide code)?

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

Jonathan Chocron (7):
  PCI: Add Amazon's Annapurna Labs vendor ID
  PCI/VPD: Add VPD release quirk for Amazon's Annapurna Labs Root Port
  PCI: Add quirk to disable MSI-X support for Amazon's Annapurna Labs
    Root Port
  dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host bridge binding
  PCI: al: Add support for DW based driver type
  PCI: dw: Add validation that PCIe core is set to correct mode
  PCI: dw: Add support for PCI_PROBE_ONLY/PCI_REASSIGN_ALL_BUS flags

 .../devicetree/bindings/pci/pcie-al.txt       |  45 +++
 MAINTAINERS                                   |   3 +-
 drivers/pci/controller/dwc/Kconfig            |  12 +
 drivers/pci/controller/dwc/pcie-al.c          | 373 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   8 +
 .../pci/controller/dwc/pcie-designware-host.c |  31 +-
 drivers/pci/quirks.c                          |  34 ++
 drivers/pci/vpd.c                             |  16 +
 include/linux/pci_ids.h                       |   2 +
 9 files changed, 519 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt

-- 
2.17.1

