Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3055A10C52A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 09:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfK1Ib4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 03:31:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:42259 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfK1Ib4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Nov 2019 03:31:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 00:31:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,252,1571727600"; 
   d="scan'208";a="199454338"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga007.jf.intel.com with ESMTP; 28 Nov 2019 00:31:52 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, rdunlap@infradead.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v1 1/1] PCI: dwc: Kconfig: Mark intel PCIe driver depends on MSI IRQ Domain
Date:   Thu, 28 Nov 2019 16:31:13 +0800
Message-Id: <96078df4bfb6bb252e9a0a447a65a47c70d1fe7d.1574929426.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1574929426.git.eswara.kota@linux.intel.com>
References: <cover.1574929426.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1574929426.git.eswara.kota@linux.intel.com>
References: <cover.1574929426.git.eswara.kota@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kernel compilation fails for i386 architecture as PCI_MSI_IRQ_DOMAIN
is not set.

Synopsys DesignWare framework depends on the PCI_MSI_IRQ_DOMAIN.
So mark the Intel PCIe controller driver dependency on PCI_MSI_IRQ_DOMAIN
as it uses the Synopsys DesignWare framework.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index e580ae036d77..d8116ed7f3a4 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -212,6 +212,7 @@ config PCIE_ARTPEC6_EP
 config PCIE_INTEL_GW
 	bool "Intel Gateway PCIe host controller support"
 	depends on OF && (X86 || COMPILE_TEST)
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
 	  Say 'Y' here to enable PCIe Host controller support on Intel
-- 
2.11.0

