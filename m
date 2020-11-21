Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3DD2BBAAB
	for <lists+linux-pci@lfdr.de>; Sat, 21 Nov 2020 01:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgKUALA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 19:11:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:34304 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgKUAKo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 19:10:44 -0500
IronPort-SDR: ZA2fDQLk1wA2imI8CULKAQ0dPkSZ9munyS6yEydHHXwk9JqJU1KieRWtFS/CFjtG8n836HDNqr
 SdWTUbXwB0Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="158601574"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="158601574"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 16:10:42 -0800
IronPort-SDR: lQt/cHoajcfvyRm+vuhIzJ1Bc1uwvR+fZvtsvHXSUS1sH1x2JmaovCIGsg2sxq0X7Kmfh9UuEe
 evH36t/d6nZg==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="369387312"
Received: from unknown (HELO arch-ashland-svkelley.intel.com) ([10.212.171.128])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 16:10:41 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v12 08/15] PCI/ERR: Avoid negated conditional for clarity
Date:   Fri, 20 Nov 2020 16:10:29 -0800
Message-Id: <20201121001036.8560-9-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121001036.8560-1-sean.v.kelley@intel.com>
References: <20201121001036.8560-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reverse the sense of the Root Port/Downstream Port conditional for clarity.
No functional change intended.

[bhelgaas: split to separate patch]
Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/err.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 46a5b84f8842..931e75f2549d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -159,11 +159,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * Error recovery runs on all subordinates of the bridge.  If the
 	 * bridge detected the error, it is cleared at the end.
 	 */
-	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
-	      type == PCI_EXP_TYPE_DOWNSTREAM))
-		bridge = pci_upstream_bridge(dev);
-	else
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM)
 		bridge = dev;
+	else
+		bridge = pci_upstream_bridge(dev);
 
 	bus = bridge->subordinate;
 	pci_dbg(bridge, "broadcast error_detected message\n");
-- 
2.29.2

