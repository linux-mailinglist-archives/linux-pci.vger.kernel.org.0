Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457BF270776
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 22:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgIRUv3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 16:51:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:61896 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgIRUv2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Sep 2020 16:51:28 -0400
IronPort-SDR: V54LbZyadlwHfUPRPumQArHldmbxWTMV31kdkENlQow+I3lcBrQbGafHfSNywhhMFT6Dm2unTE
 OYXJEvjSacEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="178120876"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="178120876"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 13:46:29 -0700
IronPort-SDR: fR54aEQL44WUOiy5BLLp8IW6mnLvtP7GlBlpngPNgp4W1fYKVqzLM5pbxV8vl6GG9YNDFgFj4G
 0idIDVWzD3yA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484366827"
Received: from xsunzhou-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.251.153.106])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 13:46:28 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/10] PCI/AER: Apply function level reset to RCiEP on fatal error
Date:   Fri, 18 Sep 2020 13:45:58 -0700
Message-Id: <20200918204603.62100-6-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918204603.62100-1-sean.v.kelley@intel.com>
References: <20200918204603.62100-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Attempt to do function level reset for an RCiEP associated with an
RCEC device on fatal error.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index e575fa6cee63..5380ecc41506 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -169,6 +169,17 @@ static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct pci_dev *,
 		cb(bridge, userdata);
 }
 
+static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
+{
+	if (!pcie_has_flr(dev))
+		return PCI_ERS_RESULT_NONE;
+
+	if (pcie_flr(dev))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_channel_state_t state,
 			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
@@ -195,15 +206,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	if (state == pci_channel_io_frozen) {
 		pci_bridge_walk(bridge, report_frozen_detected, &status);
 		if (type == PCI_EXP_TYPE_RC_END) {
-			pci_warn(dev, "link reset not possible for RCiEP\n");
-			status = PCI_ERS_RESULT_NONE;
-			goto failed;
-		}
-
-		status = reset_subordinate_devices(bridge);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(dev, "subordinate device reset failed\n");
-			goto failed;
+			status = flr_on_rciep(dev);
+			if (status != PCI_ERS_RESULT_RECOVERED) {
+				pci_warn(dev, "function level reset failed\n");
+				goto failed;
+			}
+		} else {
+			status = reset_subordinate_devices(bridge);
+			if (status != PCI_ERS_RESULT_RECOVERED) {
+				pci_warn(dev, "subordinate device reset failed\n");
+				goto failed;
+			}
 		}
 	} else {
 		pci_bridge_walk(bridge, report_normal_detected, &status);
-- 
2.28.0

