Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F4DDE4AB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 08:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfJUGjc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 02:39:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:14496 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfJUGjb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 02:39:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 23:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,322,1566889200"; 
   d="scan'208";a="209378615"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2019 23:39:28 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v4 0/3] PCI: Add Intel PCIe Driver and respective dt-binding yaml file
Date:   Mon, 21 Oct 2019 14:39:17 +0800
Message-Id: <cover.1571638827.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel PCIe is synopsys based controller utilizes the Designware
framework for host initialization and intel application
specific register configurations.

Changes on v4:
	Add lane resizing API in PCIe DesignWare driver.
	Intel PCIe driver uses it for lane resizing which
	 is being exposed through sysfs attributes.
	Add Intel PCIe sysfs attributes is in separate patch.
	Address review comments given on v3.

Changes on v3:
	Compared to v2, map_irq() patch is removed as it is no longer
	  required for Intel PCIe driver. Intel PCIe driver does platform
	  specific interrupt configuration during core initialization. So
	  changed the subject line too.
	Address v2 review comments for DT binding and PCIe driver

Dilip Kota (3):
  dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
  dwc: PCI: intel: PCIe RC controller driver
  pci: intel: Add sysfs attributes to configure pcie link

 .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 135 ++++
 drivers/pci/controller/dwc/Kconfig                 |  10 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-designware.c       |  43 ++
 drivers/pci/controller/dwc/pcie-designware.h       |  15 +
 drivers/pci/controller/dwc/pcie-intel-gw.c         | 700 +++++++++++++++
 include/uapi/linux/pci_regs.h                      |   1 +
 7 files changed, 905 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c

-- 
2.11.0

