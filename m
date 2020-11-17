Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF13E2B6E7A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 20:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgKQTUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 14:20:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:31769 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbgKQTUj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 14:20:39 -0500
IronPort-SDR: 8z+f2OHCAEl/T+/9/h82vwPzui0tEWVs9UU7GXb+i1p4DHX2Dy7vPLedZVQfRZaP1R9/0Rb9uK
 eX8i1+ONi6+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168417212"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="168417212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:39 -0800
IronPort-SDR: mmYVhT0xmuvGwsXRBaCINpd455va+wYIN3pInBcOOYm4HPTc9QyCOQDDR17ys/TtnnQYFu0UDH
 K0mEfCYLHLSg==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="533931694"
Received: from rojasmor-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.255.231.24])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:38 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v11 03/16] PCI/RCEC: Bind RCEC devices to the Root Port driver
Date:   Tue, 17 Nov 2020 11:19:41 -0800
Message-Id: <20201117191954.1322844-4-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117191954.1322844-1-sean.v.kelley@intel.com>
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

If a Root Complex Integrated Endpoint (RCiEP) is implemented, it may signal
errors through a Root Complex Event Collector (RCEC).  Each RCiEP must be
associated with no more than one RCEC.

For an RCEC (which is technically not a Bridge), error messages "received"
from associated RCiEPs must be enabled for "transmission" in order to cause
a System Error via the Root Control register or (when the Advanced Error
Reporting Capability is present) reporting via the Root Error Command
register and logging in the Root Error Status register and Error Source
Identification register.

Given the commonality with Root Ports and the need to also support AER and
PME services for RCECs, extend the Root Port driver to support RCEC devices
by adding the RCEC Class ID to the driver structure.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-3-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/portdrv_pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
2.29.2

