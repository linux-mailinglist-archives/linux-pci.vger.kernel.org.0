Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE92F65C44D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 17:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjACQzv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 11:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjACQzu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 11:55:50 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A8EB30;
        Tue,  3 Jan 2023 08:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672764949; x=1704300949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lCf3CkygM0RRymks3SyRZKTWmUhd9Lv3qTfO+5Y+XeQ=;
  b=jGzcuX5FopK9dGp4YeznBafHxbzwqgqlguEZ2IDRTrRb6zUinI0GZZRs
   aDbBXAIYs3ChsK/GE2BkqYZ5XDeCGHTUuocdx7+qTdqD6GAHDml5zLcdO
   NYyaRlw4vpeqDBdoxwBnhLWODSjjEK7HuO8bSDSn9jtRkoDLTvBr74uDO
   6U2U/uRj1+Lia+tqRtNNWhkHmRrifsqrstiShdyYJmfxo67cRbg5uOrpV
   qVLoFJZIry2ek8ucx0hhkKHpf7G8E2apshL5xGS4iNGA4LFVH0/lblknu
   kQ/nhDcM5MmsWJ00+co9SadLaHOxaJqDxmV/fKeR2QzqcVMnZcec6+tA0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="301385066"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="301385066"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:55:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="656820695"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="656820695"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:55:46 -0800
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH] PCI/AER: Rate limit the reporting of the correctable errors
Date:   Tue,  3 Jan 2023 22:25:48 +0530
Message-Id: <20230103165548.570377-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are many instances where correctable errors tend to inundate
the message buffer. We observe such instances during thunderbolt PCIe
tunneling.

It's true that they are mitigated by the hardware and are non-fatal
but we shouldn't be spamming the logs with such correctable errors as it
confuses other kernel developers less familiar with PCI errors, support
staff, and users who happen to look at the logs, hence rate limit them.

A typical example log inside an HP TBT4 dock:
[54912.661142] pcieport 0000:00:07.0: AER: Multiple Corrected error received: 0000:2b:00.0
[54912.661194] igc 0000:2b:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
[54912.661203] igc 0000:2b:00.0:   device [8086:5502] error status/mask=00001100/00002000
[54912.661211] igc 0000:2b:00.0:    [ 8] Rollover
[54912.661219] igc 0000:2b:00.0:    [12] Timeout
[54982.838760] pcieport 0000:00:07.0: AER: Corrected error received: 0000:2b:00.0
[54982.838798] igc 0000:2b:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
[54982.838808] igc 0000:2b:00.0:   device [8086:5502] error status/mask=00001000/00002000
[54982.838817] igc 0000:2b:00.0:    [12] Timeout
This gets repeated continuously, thus inundating the buffer.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 54 +++++++++++++++++++++++++++---------------
 include/linux/pci.h    |  3 +++
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e2d8a74f83c3..7ae6761a8e59 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -684,23 +684,24 @@ static void __aer_print_error(struct pci_dev *dev,
 {
 	const char **strings;
 	unsigned long status = info->status & ~info->mask;
-	const char *level, *errmsg;
+	const char *errmsg;
 	int i;
 
-	if (info->severity == AER_CORRECTABLE) {
+	if (info->severity == AER_CORRECTABLE)
 		strings = aer_correctable_error_string;
-		level = KERN_WARNING;
-	} else {
+	else
 		strings = aer_uncorrectable_error_string;
-		level = KERN_ERR;
-	}
 
 	for_each_set_bit(i, &status, 32) {
 		errmsg = strings[i];
 		if (!errmsg)
 			errmsg = "Unknown Error Bit";
 
-		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
+		if (info->severity == AER_CORRECTABLE)
+			pci_warn_ratelimited(dev, "   [%2d] %-22s%s\n", i, errmsg,
+					     info->first_error == i ? " (First)" : "");
+		else
+			pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
 	pci_dev_aer_stats_incr(dev, info);
@@ -710,7 +711,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int layer, agent;
 	int id = ((dev->bus->number << 8) | dev->devfn);
-	const char *level;
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -721,14 +718,21 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
+	if (info->severity == AER_CORRECTABLE) {
+		pci_warn_ratelimited(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
+				     aer_error_severity_string[info->severity],
+				     aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
-		   aer_error_layer[layer], aer_agent_string[agent]);
+		pci_warn_ratelimited(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
+				     dev->vendor, dev->device, info->status, info->mask);
+	} else {
+		pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
+			aer_error_severity_string[info->severity],
+			aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		   dev->vendor, dev->device, info->status, info->mask);
+		pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
+			dev->vendor, dev->device, info->status, info->mask);
+	}
 
 	__aer_print_error(dev, info);
 
@@ -748,11 +755,19 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
-		 info->multi_error_valid ? "Multiple " : "",
-		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn));
+	if (info->severity == AER_CORRECTABLE)
+		pci_info_ratelimited(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+				     info->multi_error_valid ? "Multiple " : "",
+				     aer_error_severity_string[info->severity],
+				     pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
+				     PCI_FUNC(devfn));
+	else
+		pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+			 info->multi_error_valid ? "Multiple " : "",
+			 aer_error_severity_string[info->severity],
+			 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn));
+
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 060af91bafcd..d9434bae10c8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2491,6 +2491,9 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #define pci_info_ratelimited(pdev, fmt, arg...) \
 	dev_info_ratelimited(&(pdev)->dev, fmt, ##arg)
 
+#define pci_warn_ratelimited(pdev, fmt, arg...) \
+	dev_warn_ratelimited(&(pdev)->dev, fmt, ##arg)
+
 #define pci_WARN(pdev, condition, fmt, arg...) \
 	WARN(condition, "%s %s: " fmt, \
 	     dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
-- 
2.34.1

