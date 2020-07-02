Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455B5212ADE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGBRJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 13:09:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:38715 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgGBRJE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 13:09:04 -0400
IronPort-SDR: D2i86kJ6/RYRPOA3yJ1X4fHsfaOQtwn0JB/2MS98JSrBmjIMC3zge13EFC76AMso5f8Q7gH7+4
 HCoq8ldtPDTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126587506"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="126587506"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:09:02 -0700
IronPort-SDR: Pjp5X2Uc37/gx6NmEW9bhvmr6klonJndJUF6lvUu/ydVmGHB6KYJ/757q6gY04Df3HdwTbg/ZU
 oP4DqCxLL+2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="481763231"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2020 10:09:01 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, bhelgaas@google.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jeffrey.t.kirsher@intel.com, olof@lixom.net,
        dan.j.williams@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/7] perf/x86/intel/uncore: Factor out uncore_pci_pmu_unregister()
Date:   Thu,  2 Jul 2020 10:05:15 -0700
Message-Id: <1593709517-108857-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
References: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU unregistration of a platform device is similar as a PCI device.

Factor out the codes of unregister a PCI PMU into a separate function. The
function will be used later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index ccc90b0..b702dc3 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1118,6 +1118,16 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	return ret;
 }
 
+static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu,
+				      struct intel_uncore_box *box)
+{
+	pmu->boxes[box->dieid] = NULL;
+	if (atomic_dec_return(&pmu->activeboxes) == 0)
+		uncore_pmu_unregister(pmu);
+	uncore_box_exit(box);
+	kfree(box);
+}
+
 static void uncore_pci_remove(struct pci_dev *pdev)
 {
 	struct intel_uncore_box *box;
@@ -1145,11 +1155,8 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 		return;
 
 	pci_set_drvdata(pdev, NULL);
-	pmu->boxes[box->dieid] = NULL;
-	if (atomic_dec_return(&pmu->activeboxes) == 0)
-		uncore_pmu_unregister(pmu);
-	uncore_box_exit(box);
-	kfree(box);
+
+	uncore_pci_pmu_unregister(pmu, box);
 }
 
 static int __init uncore_pci_init(void)
-- 
2.7.4

