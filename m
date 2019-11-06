Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713FAF0D2E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 04:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfKFDoT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 22:44:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:60811 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfKFDoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 22:44:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 19:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,272,1569308400"; 
   d="scan'208";a="212679185"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2019 19:44:15 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v5 0/3] PCI: Add Intel PCIe Driver and respective dt-binding yaml file
Date:   Wed,  6 Nov 2019 11:44:00 +0800
Message-Id: <cover.1572950559.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel PCIe is Synopsys based controller utilizes the DesignWare
framework for host initialization and Intel application
specific register configurations.

Changes on v5:
	Add Reviewed-by: Andrew Murray for device tree YAML schema patch.
	Address patchv4 review comments.
	Sysfs patch work in progress, so not submitted in this patch revision.
	Add changes in artpec6 PCI driver to call dw helper function
	 for programming FTS.

Dilip Kota (3):
  dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
  dwc: PCI: intel: PCIe RC controller driver
  PCI: artpec6: Configure FTS with dwc helper function

 .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 ++++++
 drivers/pci/controller/dwc/Kconfig                 |  10 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-artpec6.c          |   8 +-
 drivers/pci/controller/dwc/pcie-designware.c       |  57 +++
 drivers/pci/controller/dwc/pcie-designware.h       |  12 +
 drivers/pci/controller/dwc/pcie-intel-gw.c         | 538 ++++++++++++++++
 include/uapi/linux/pci_regs.h                      |   1 +
 8 files changed, 758 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c

-- 
2.11.0

