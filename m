Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBD23C02C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 21:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgHDTlJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 15:41:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:29269 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbgHDTlJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 15:41:09 -0400
IronPort-SDR: D9TTt4KNr6n2/G0cywzi7CdCD8ZEuXWD3MsNviYswpKJaeaWC43on0iPIQb58JrpJVyfvySEUe
 lpRhwzbz5DRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="139991107"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="139991107"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 12:41:08 -0700
IronPort-SDR: U8cdfqDRyyNHBM/S7HlqnmOlcelXTk74oCd7roRReSyNriJAKXI/ZUGBFDN9stwMwIV6kZhGRH
 mIhbM910KgVg==
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="467199244"
Received: from viveksh1-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.255.83.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 12:41:08 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH V2 5/9] PCI/AER: Apply function level reset to RCiEP on fatal error
Date:   Tue,  4 Aug 2020 12:40:48 -0700
Message-Id: <20200804194052.193272-6-sean.v.kelley@intel.com>
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

Attempt to do function level reset for an RCiEP associated with an
RCEC device on fatal error.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 682302dfb55b..4812aa678eff 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -170,6 +170,17 @@ static void pci_walk_dev_affected(struct pci_dev *dev, int (*cb)(struct pci_dev
 	}
 }
 
+static enum pci_ers_result flr_on_rciep(struct pci_dev *dev)
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
 			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
@@ -191,15 +202,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	if (state == pci_channel_io_frozen) {
 		pci_walk_dev_affected(dev, report_frozen_detected, &status);
 		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
-			pci_warn(dev, "link reset not possible for RCiEP\n");
-			status = PCI_ERS_RESULT_NONE;
-			goto failed;
-		}
-
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(dev, "link reset failed\n");
-			goto failed;
+			status = flr_on_rciep(dev);
+			if (status != PCI_ERS_RESULT_RECOVERED) {
+				pci_warn(dev, "function level reset failed\n");
+				goto failed;
+			}
+		} else {
+			status = reset_link(dev);
+			if (status != PCI_ERS_RESULT_RECOVERED) {
+				pci_warn(dev, "link reset failed\n");
+				goto failed;
+			}
 		}
 	} else {
 		pci_walk_dev_affected(dev, report_normal_detected, &status);
-- 
2.27.0

