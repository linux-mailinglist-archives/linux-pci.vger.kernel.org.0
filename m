Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576892BB973
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 23:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgKTWvz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 17:51:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:15001 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgKTWvz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 17:51:55 -0500
IronPort-SDR: jPx03cqxmX60jmhcjoX0l35s0DW5rzgas7+3sBkKSUxsThKooXTmuAsZimEAoNVJAM89rbNqAh
 GsEPlr+qrpNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168985727"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="168985727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:54 -0800
IronPort-SDR: SoAnqL7h9NPD//Gask9LNY0SxdkDVwHPl4yYMZAlTDs6jta9v57xjICgpGxMqMySShRI9Tc5b2
 a/k4f0nV6DeA==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="357852074"
Received: from sabakhle-mobl1.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.213.165.80])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:53 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/5] PCI: Add a reset quirk for VMD
Date:   Fri, 20 Nov 2020 15:51:41 -0700
Message-Id: <20201120225144.15138-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201120225144.15138-1-jonathan.derrick@intel.com>
References: <20201120225144.15138-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD domains should be reset in-between special attachment such as VFIO
users. VMD does not offer a reset, however the subdevice domain itself
can be reset starting at the Root Bus. Add a Secondary Bus Reset on each
of the individual root port devices immediately downstream of the VMD
root bus.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/quirks.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f70692a..ee58b51 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3744,6 +3744,49 @@ static int reset_ivb_igd(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/* Issues SBR to VMD domain to clear PCI configuration */
+static int reset_vmd_sbr(struct pci_dev *dev, int probe)
+{
+	char __iomem *cfgbar, *base;
+	int rp;
+	u16 ctl;
+
+	if (probe)
+		return 0;
+
+	if (dev->dev.driver)
+		return 0;
+
+	cfgbar = pci_iomap(dev, 0, 0);
+	if (!cfgbar)
+		return -ENOMEM;
+
+	/*
+	 * Subdevice config space is mapped linearly using 4k config space
+	 * increments. Use increments of 0x8000 to locate root port devices.
+	 */
+	for (rp = 0; rp < 4; rp++) {
+		base = cfgbar + rp * 0x8000;
+		if (readl(base + PCI_COMMAND) == 0xFFFFFFFF)
+			continue;
+
+		/* pci_reset_secondary_bus() */
+		ctl = readw(base + PCI_BRIDGE_CONTROL);
+		ctl |= PCI_BRIDGE_CTL_BUS_RESET;
+		writew(ctl, base + PCI_BRIDGE_CONTROL);
+		readw(base + PCI_BRIDGE_CONTROL);
+		msleep(2);
+
+		ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+		writew(ctl, base + PCI_BRIDGE_CONTROL);
+		readw(base + PCI_BRIDGE_CONTROL);
+	}
+
+	ssleep(1);
+	pci_iounmap(dev, cfgbar);
+	return 0;
+}
+
 /* Device-specific reset method for Chelsio T4-based adapters */
 static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 {
@@ -3919,6 +3962,11 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 		reset_ivb_igd },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
 		reset_ivb_igd },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D, reset_vmd_sbr },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0, reset_vmd_sbr },
+	{ PCI_VENDOR_ID_INTEL, 0x467f, reset_vmd_sbr },
+	{ PCI_VENDOR_ID_INTEL, 0x4c3d, reset_vmd_sbr },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B, reset_vmd_sbr },
 	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
 	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
-- 
1.8.3.1

