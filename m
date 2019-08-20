Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3A95B23
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfHTJkA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 05:40:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:33236 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTJkA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 05:40:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 02:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="195734615"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 20 Aug 2019 02:39:58 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 0/3] PCI: Add map irq callback in dwc framework and add Intel PCIe driver
Date:   Tue, 20 Aug 2019 17:39:34 +0800
Message-Id: <cover.1566208109.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel PCIe is synopsys based controller utilizes the Designware
framework for host initialization and intel application
specific register configurations.

Intel PCIe driver also uses the Irq map callback for platform
specific register configurations while Irq mapping. So submitting
the Intel pcie driver series with dwc irq map callback change.

Changes on v2:
	Submitting user(intel pcie driver) changes along with core changes.

Dilip Kota (3):
  PCI: dwc: Add map irq callback
  dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
  dwc: PCI: intel: Intel PCIe RC controller driver

 .../devicetree/bindings/pci/intel-pcie.yaml        | 133 +++
 drivers/pci/controller/dwc/Kconfig                 |  13 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |   6 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   1 +
 drivers/pci/controller/dwc/pcie-intel-axi.c        | 900 +++++++++++++++++
 6 files changed, 1053 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/intel-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-intel-axi.c

-- 
2.11.0

