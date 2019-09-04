Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59024A8017
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 12:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfIDKLF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 06:11:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:43792 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfIDKLF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Sep 2019 06:11:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 03:11:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="198998159"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2019 03:11:02 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v3 0/2] PCI: Add Intel PCIe Driver and respective dt-binding yaml file
Date:   Wed,  4 Sep 2019 18:10:29 +0800
Message-Id: <cover.1567585181.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel PCIe is synopsys based controller utilizes the Designware
framework for host initialization and intel application
specific register configurations.

Changes on v3:
        Compared to v2, map_irq() patch is removed as it is no longer
          required for Intel PCIe driver. Intel PCIe driver does platform
          specific interrupt configuration during core initialization. So
          changed the subject line too.
        Address v2 review comments for DT binding and PCIe driver

Dilip Kota (2):
  dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
  dwc: PCI: intel: Intel PCIe RC controller driver

 .../devicetree/bindings/pci/intel,lgm-pcie.yaml    | 137 ++++
 drivers/pci/controller/dwc/Kconfig                 |  13 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-intel-axi.c        | 840 +++++++++++++++++++++
 4 files changed, 991 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-intel-axi.c

-- 
2.11.0

