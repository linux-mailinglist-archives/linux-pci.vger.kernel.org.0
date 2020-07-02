Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4D4212AE7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgGBRJZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 13:09:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:38715 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgGBRJD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 13:09:03 -0400
IronPort-SDR: 9tjw6hfnIWa0riwUyVhfo4dtZ9hHk+1mGoIKKdQrP3X37XamGQ3AQtqW44g16atPfoCUOxk1zN
 APM3fcRNWWCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126587492"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="126587492"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:09:00 -0700
IronPort-SDR: srNeTjt1GmBU9ISPSF0dXga4dUs7tGdLLQrTS8Aa/yK0mgupkqEdaUS0x/efJhHBP4F/NxZ0hn
 icZEeKx6NMmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="481763214"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2020 10:08:59 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, bhelgaas@google.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jeffrey.t.kirsher@intel.com, olof@lixom.net,
        dan.j.williams@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/7] perf/x86/intel/uncore: Factor out uncore_pci_pmu_register()
Date:   Thu,  2 Jul 2020 10:05:14 -0700
Message-Id: <1593709517-108857-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
References: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU registration of a platform device is similar as a PCI device.

Factor out the codes of register PCI PMU into a separate function. The
function will be used later.

pci_set_drvdata() is not included in uncore_pci_pmu_register(). Because
a platform device has its own function to set the drvdata.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 74 ++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 6a87c1a..ccc90b0 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1028,6 +1028,47 @@ uncore_find_pmu_by_pci_dev(struct pci_dev *pdev, const struct pci_device_id *ids
 	return pmu;
 }
 
+static int uncore_pci_pmu_register(struct pci_dev *pdev,
+				   struct intel_uncore_type *type,
+				   struct intel_uncore_pmu *pmu,
+				   int phys_id, int die)
+{
+	struct intel_uncore_box *box;
+	int ret;
+
+	if (WARN_ON_ONCE(pmu->boxes[die] != NULL))
+		return -EINVAL;
+
+	box = uncore_alloc_box(type, NUMA_NO_NODE);
+	if (!box)
+		return -ENOMEM;
+
+	if (pmu->func_id < 0)
+		pmu->func_id = pdev->devfn;
+	else
+		 WARN_ON_ONCE(pmu->func_id != pdev->devfn);
+
+	atomic_inc(&box->refcnt);
+	box->pci_phys_id = phys_id;
+	box->dieid = die;
+	box->pci_dev = pdev;
+	box->pmu = pmu;
+	uncore_box_init(box);
+
+	pmu->boxes[die] = box;
+	if (atomic_inc_return(&pmu->activeboxes) > 1)
+		return 0;
+
+	/* First active box registers the pmu */
+	ret = uncore_pmu_register(pmu);
+	if (ret) {
+		pmu->boxes[die] = NULL;
+		uncore_box_exit(box);
+		kfree(box);
+	}
+	return ret;
+}
+
 /*
  * add a pci uncore device
  */
@@ -1035,7 +1076,6 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 {
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu = NULL;
-	struct intel_uncore_box *box;
 	int phys_id, die, ret;
 
 	ret = uncore_pci_get_die_info(pdev, &phys_id, &die);
@@ -1071,38 +1111,10 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		pmu = &type->pmus[UNCORE_PCI_DEV_IDX(id->driver_data)];
 	}
 
-	if (WARN_ON_ONCE(pmu->boxes[die] != NULL))
-		return -EINVAL;
-
-	box = uncore_alloc_box(type, NUMA_NO_NODE);
-	if (!box)
-		return -ENOMEM;
-
-	if (pmu->func_id < 0)
-		pmu->func_id = pdev->devfn;
-	else
-		WARN_ON_ONCE(pmu->func_id != pdev->devfn);
-
-	atomic_inc(&box->refcnt);
-	box->pci_phys_id = phys_id;
-	box->dieid = die;
-	box->pci_dev = pdev;
-	box->pmu = pmu;
-	uncore_box_init(box);
-	pci_set_drvdata(pdev, box);
+	ret = uncore_pci_pmu_register(pdev, type, pmu, phys_id, die);
 
-	pmu->boxes[die] = box;
-	if (atomic_inc_return(&pmu->activeboxes) > 1)
-		return 0;
+	pci_set_drvdata(pdev, pmu->boxes[die]);
 
-	/* First active box registers the pmu */
-	ret = uncore_pmu_register(pmu);
-	if (ret) {
-		pci_set_drvdata(pdev, NULL);
-		pmu->boxes[die] = NULL;
-		uncore_box_exit(box);
-		kfree(box);
-	}
 	return ret;
 }
 
-- 
2.7.4

