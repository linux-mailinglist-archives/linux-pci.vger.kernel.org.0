Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B308823C02A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgHDTlH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 15:41:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:29261 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgHDTlG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 15:41:06 -0400
IronPort-SDR: xKwuZZT5ew76HI8ztKtjKyxdllxz9ACfTwI/lAyU6w5O2nq8KBnLmn+NN+Q3BTlF13FQizPEYN
 KZkOXLgzYRuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="139991093"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="139991093"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 12:41:05 -0700
IronPort-SDR: uWxkq0mQn7iPLMM7bR39htIKoCVIv38Zn81itKyGKU6I73lZ/zIg8sWxBJFEjOa7M4vuARbPxd
 WslAfl0HM9nQ==
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="467199225"
Received: from viveksh1-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.255.83.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 12:41:05 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH V2 2/9] PCI: Extend Root Port Driver to support RCEC
Date:   Tue,  4 Aug 2020 12:40:45 -0700
Message-Id: <20200804194052.193272-3-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200804194052.193272-1-sean.v.kelley@intel.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

If a Root Complex Integrated Endpoint (RCiEP) is implemented, errors may
optionally be sent to a corresponding Root Complex Event Collector (RCEC).
Each RCiEP must be associated with no more than one RCEC. Interface errors
are reported to the OS by RCECs.

For an RCEC (technically not a Bridge), error messages "received" from
associated RCiEPs must be enabled for "transmission" in order to cause a
System Error via the Root Control register or (when the Advanced Error
Reporting Capability is present) reporting via the Root Error Command
register and logging in the Root Error Status register and Error Source
Identification register.

Given the commonality with Root Ports and the need to also support AER
and PME services for RCECs, extend the Root Port driver to support RCEC
devices through the addition of the RCEC Class ID to the driver
structure.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/portdrv_core.c | 8 ++++----
 drivers/pci/pcie/portdrv_pci.c  | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522ab07d..5d4a400094fc 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -234,11 +234,11 @@ static int get_port_device_capability(struct pci_dev *dev)
 #endif
 
 	/*
-	 * Root ports are capable of generating PME too.  Root Complex
-	 * Event Collectors can also generate PMEs, but we don't handle
-	 * those yet.
+	 * Root ports and Root Complex Event Collectors are capable
+	 * of generating PME too.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    (pcie_ports_native || host->native_pme)) {
 		services |= PCIE_PORT_SERVICE_PME;
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 3a3ce40ae1ab..4d880679b9b1 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
-	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
 		return -ENODEV;
 
 	status = pcie_port_device_register(dev);
@@ -195,6 +196,8 @@ static const struct pci_device_id port_pci_ids[] = {
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
 	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
+	/* handle any Root Complex Event Collector */
+	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
 	{ },
 };
 
-- 
2.27.0

