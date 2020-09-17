Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED22326E0B0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgIQQ10 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 12:27:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:44131 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgIQQ1S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 12:27:18 -0400
IronPort-SDR: 8kqIn/5D+96oYI6vecgaLXNRA0slqDESHigs+TG/fe/vgkJ8BV1zpAR0AVxChb3ifeSFJwv2Lh
 HjtsFNx5FkmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139236831"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="139236831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:25:54 -0700
IronPort-SDR: WawaegHppG7HBPxkZ8sCyMKkz+tOb0BP1EkUOVj8hKYCRcUF2dwAV1mAqGqZRobWKyyoSnKUr6
 jhFJevZRuV8w==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="332220082"
Received: from mbair-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.181.111])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:25:54 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/10] PCI/AER: Apply function level reset to RCiEP on fatal error
Date:   Thu, 17 Sep 2020 09:25:43 -0700
Message-Id: <20200917162548.2079894-6-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917162548.2079894-1-sean.v.kelley@intel.com>
References: <20200917162548.2079894-1-sean.v.kelley@intel.com>
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

