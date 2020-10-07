Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E10285E31
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 13:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgJGLdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 07:33:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:24771 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgJGLdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 07:33:46 -0400
IronPort-SDR: yCOKQ8ro5M+EZX8zg+EP09mS8H5meJSt7IZ1d4fGtM6ZsUkuQCqhrJ+g0IEMmv3/a3W9gWRXID
 XuLHIwR5M3gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="226492580"
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="226492580"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 04:33:45 -0700
IronPort-SDR: 0CY/lCH6vbXlSRKag9hm8sKGaehpA7EatV+ihkbaQF+EoaFo7BAJ2AZLecVnVlfG3KHvAmKOdo
 HSNifr3zNrPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="354862186"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 04:33:42 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH v8 5/6] PCI/ERR: only return true when dev io state is really changed
Date:   Wed,  7 Oct 2020 07:31:57 -0400
Message-Id: <20201007113158.48933-6-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201007113158.48933-1-haifeng.zhao@intel.com>
References: <20201007113158.48933-1-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When uncorrectable error happens, AER driver and DPC driver interrupt
handlers likely call

   pcie_do_recovery()
   ->pci_walk_bus()
     ->report_frozen_detected()

with pci_channel_io_frozen the same time.
   If pci_dev_set_io_state() return true even if the original state is
pci_channel_io_frozen, that will cause AER or DPC handler re-enter
the error detecting and recovery procedure one after another.
   The result is the recovery flow mixed between AER and DPC.
So change the pci_dev_set_io_state() function to only return true
when dev->error_state is really changed.

Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
---
Changnes:
 v2: revise description and code according to suggestion from Andy.
 v3: change code to simpler.
 v4: no change.
 v5: no change.
 v6: no change.
 v7: changed based on Bjorn's code and truth table.
 v8: according to Bjorn's suggestion, rebase on another simplification
     patch.   

 drivers/pci/pci.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bceb3f108744..a11e0f9d9bdf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -371,17 +371,14 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
  *     perm_failure  |  perm_failure*  perm_failure*  perm_failure
  */
 
-	/* Can always put a device in perm_failure state */
-	if (new == pci_channel_io_perm_failure) {
-		dev->error_state = pci_channel_io_perm_failure;
-		return true;
-	}
-
-	/* If already in perm_failure, can't set to normal or frozen */
+	/* If already in perm_failure, can't change it's state */
 	if (dev->error_state == pci_channel_io_perm_failure)
 		return false;
+	/* not change at all */
+	else if (dev->error_state == new)
+		return false;
 
-	 /* Can always change normal to frozen or vice versa */
+	 /* Can always change from normal/frozen to other different state */
 	dev->error_state = new;
 	return true;
 }
-- 
2.18.4

