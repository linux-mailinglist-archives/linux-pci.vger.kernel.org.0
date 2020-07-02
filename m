Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38FA212ADD
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgGBRJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 13:09:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:38710 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgGBRJC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 13:09:02 -0400
IronPort-SDR: +KK7p1tkNxgpf5luRU2WQWXz6WFTk/Q9kk/kySoWImA2qqumGxniry9YNDpdo6F3QgM5HlhByL
 PSHYnHliF2Kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126587471"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="126587471"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:08:58 -0700
IronPort-SDR: p8FzhZu5/WmN7nevKDHLA8328vkrXsitogdQX6dhYQ0KsuInUWUe6zpg18lJVHQaVRInRU+kbo
 dH0slAwiBvqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="481763195"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2020 10:08:57 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, bhelgaas@google.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jeffrey.t.kirsher@intel.com, olof@lixom.net,
        dan.j.williams@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/7] perf/x86/intel/uncore: Factor out uncore_pci_get_die_info()
Date:   Thu,  2 Jul 2020 10:05:12 -0700
Message-Id: <1593709517-108857-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
References: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The socket and die information is required when probing the platform
device.

Factor out the codes to get the socket and die information from a BUS
number into a separate function. The function will be used later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d5c6d3b..0651ab7 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -988,6 +988,20 @@ uncore_types_init(struct intel_uncore_type **types, bool setid)
 	return 0;
 }
 
+static int uncore_pci_get_die_info(struct pci_dev *pdev,
+				   int *phys_id, int *die)
+{
+	*phys_id = uncore_pcibus_to_physid(pdev->bus);
+	if (*phys_id < 0)
+		return -ENODEV;
+
+	*die = (topology_max_die_per_package() > 1) ? *phys_id :
+				topology_phys_to_logical_pkg(*phys_id);
+	if (*die < 0)
+		return -EINVAL;
+
+	return 0;
+}
 /*
  * add a pci uncore device
  */
@@ -998,14 +1012,9 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	struct intel_uncore_box *box;
 	int phys_id, die, ret;
 
-	phys_id = uncore_pcibus_to_physid(pdev->bus);
-	if (phys_id < 0)
-		return -ENODEV;
-
-	die = (topology_max_die_per_package() > 1) ? phys_id :
-					topology_phys_to_logical_pkg(phys_id);
-	if (die < 0)
-		return -EINVAL;
+	ret = uncore_pci_get_die_info(pdev, &phys_id, &die);
+	if (ret)
+		return ret;
 
 	if (UNCORE_PCI_DEV_TYPE(id->driver_data) == UNCORE_EXTRA_PCI_DEV) {
 		int idx = UNCORE_PCI_DEV_IDX(id->driver_data);
-- 
2.7.4

