Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C87212AE9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgGBRJa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 13:09:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:38697 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgGBRJC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 13:09:02 -0400
IronPort-SDR: g8Pbnfpl3/TGz/jf/wG9T4f6sCKi5oPVRIbVKHhVpo31kg29HNBo0ID3INTRmKVvYW+F+tjjrN
 29diOkSzBvkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126587489"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="126587489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:08:59 -0700
IronPort-SDR: g27ZAUaruHNYawyGV8EZm+9GD+QKdwh9iwmV2dt8gwL+wpsu7UAWBz0MbmviLXvw3P1pToxC9q
 7bsB+CZeykag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="481763212"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2020 10:08:58 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, bhelgaas@google.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jeffrey.t.kirsher@intel.com, olof@lixom.net,
        dan.j.williams@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/7] perf/x86/intel/uncore: Factor out uncore_find_pmu_by_pci_dev()
Date:   Thu,  2 Jul 2020 10:05:13 -0700
Message-Id: <1593709517-108857-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
References: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When a platform device is probed, the corresponding PMU has to be
registered.

Factor out the codes to find the corresponding PMU by comparing the
pci_device_id table. The function will be used later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 43 +++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 0651ab7..6a87c1a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1002,6 +1002,32 @@ static int uncore_pci_get_die_info(struct pci_dev *pdev,
 
 	return 0;
 }
+
+static struct intel_uncore_pmu *
+uncore_find_pmu_by_pci_dev(struct pci_dev *pdev, const struct pci_device_id *ids)
+{
+	struct intel_uncore_pmu *pmu = NULL;
+	struct intel_uncore_type *type;
+	kernel_ulong_t data;
+	unsigned int devfn;
+
+	while (ids && ids->vendor) {
+		if ((ids->vendor == pdev->vendor) &&
+		    (ids->device == pdev->device)) {
+			data = ids->driver_data;
+			devfn = PCI_DEVFN(UNCORE_PCI_DEV_DEV(data),
+					  UNCORE_PCI_DEV_FUNC(data));
+			if (devfn == pdev->devfn) {
+				type = uncore_pci_uncores[UNCORE_PCI_DEV_TYPE(data)];
+				pmu = &type->pmus[UNCORE_PCI_DEV_IDX(data)];
+				break;
+			}
+		}
+		ids++;
+	}
+	return pmu;
+}
+
 /*
  * add a pci uncore device
  */
@@ -1033,21 +1059,8 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	 */
 	if (id->driver_data & ~0xffff) {
 		struct pci_driver *pci_drv = pdev->driver;
-		const struct pci_device_id *ids = pci_drv->id_table;
-		unsigned int devfn;
-
-		while (ids && ids->vendor) {
-			if ((ids->vendor == pdev->vendor) &&
-			    (ids->device == pdev->device)) {
-				devfn = PCI_DEVFN(UNCORE_PCI_DEV_DEV(ids->driver_data),
-						  UNCORE_PCI_DEV_FUNC(ids->driver_data));
-				if (devfn == pdev->devfn) {
-					pmu = &type->pmus[UNCORE_PCI_DEV_IDX(ids->driver_data)];
-					break;
-				}
-			}
-			ids++;
-		}
+
+		pmu = uncore_find_pmu_by_pci_dev(pdev, pci_drv->id_table);
 		if (pmu == NULL)
 			return -ENODEV;
 	} else {
-- 
2.7.4

