Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE611654C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 04:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLIDUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Dec 2019 22:20:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:17890 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfLIDUO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 8 Dec 2019 22:20:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2019 19:20:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="219892592"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 08 Dec 2019 19:20:10 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v11 0/3] PCI: Add Intel PCIe Driver and respective dt-binding yaml file
Date:   Mon,  9 Dec 2019 11:20:03 +0800
Message-Id: <cover.1575860791.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel PCIe is Synopsys based controller. Intel PCIe driver uses
DesignWare PCIe framework for host initialization and register
configurations.

Changes on v11:
	Patches rebase on kernel v5.5-rc1

Dilip Kota (3):
  dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
  PCI: dwc: intel: PCIe RC controller driver
  PCI: artpec6: Configure FTS with dwc helper function

 .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 ++++++
 drivers/pci/controller/dwc/Kconfig                 |  11 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-artpec6.c          |   8 +-
 drivers/pci/controller/dwc/pcie-designware.c       |  57 +++
 drivers/pci/controller/dwc/pcie-designware.h       |  12 +
 drivers/pci/controller/dwc/pcie-intel-gw.c         | 545 +++++++++++++++++++++
 include/uapi/linux/pci_regs.h                      |   1 +
 8 files changed, 766 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c

-- 
2.11.0

