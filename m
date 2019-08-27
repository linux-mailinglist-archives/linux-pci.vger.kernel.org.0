Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066619EC39
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfH0PS1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 11:18:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:2118 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfH0PS0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 11:18:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 08:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="180256090"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Aug 2019 08:18:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 06C3CBD; Tue, 27 Aug 2019 18:18:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] PCI/AER: Use for_each_set_bit()
Date:   Tue, 27 Aug 2019 18:18:22 +0300
Message-Id: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This simplifies and standardizes slot manipulation code
by using for_each_set_bit() library function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b45bc47d04fe..f883f81d759a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -15,6 +15,7 @@
 #define pr_fmt(fmt) "AER: " fmt
 #define dev_fmt pr_fmt
 
+#include <linux/bitops.h>
 #include <linux/cper.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
@@ -657,7 +658,8 @@ const struct attribute_group aer_stats_attr_group = {
 static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 				   struct aer_err_info *info)
 {
-	int status, i, max = -1;
+	unsigned long status = info->status & ~info->mask;
+	int i, max = -1;
 	u64 *counter = NULL;
 	struct aer_stats *aer_stats = pdev->aer_stats;
 
@@ -682,10 +684,8 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 		break;
 	}
 
-	status = (info->status & ~info->mask);
-	for (i = 0; i < max; i++)
-		if (status & (1 << i))
-			counter[i]++;
+	for_each_set_bit(i, &status, max)
+		counter[i]++;
 }
 
 static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
@@ -717,14 +717,11 @@ static void __print_tlp_header(struct pci_dev *dev,
 static void __aer_print_error(struct pci_dev *dev,
 			      struct aer_err_info *info)
 {
-	int i, status;
+	unsigned long status = info->status & ~info->mask;
 	const char *errmsg = NULL;
-	status = (info->status & ~info->mask);
-
-	for (i = 0; i < 32; i++) {
-		if (!(status & (1 << i)))
-			continue;
+	int i;
 
+	for_each_set_bit(i, &status, 32) {
 		if (info->severity == AER_CORRECTABLE)
 			errmsg = i < ARRAY_SIZE(aer_correctable_error_string) ?
 				aer_correctable_error_string[i] : NULL;
-- 
2.23.0.rc1

