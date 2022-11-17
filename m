Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A265362E210
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 17:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiKQQfu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 11:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbiKQQfX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 11:35:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8494C25E
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668702887; x=1700238887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ZW/balMI+mVUTIrlzO33ETJ/M3NM4PfnG6G+4/JZ3w=;
  b=mGWrjxEdgUZXf3SuWqUQQ/1yNGmNeLK8nTWdWH/044ZFYNMk7k+JMBbM
   5GMCjsXLNTZQTHFGhBKRPnnkpTS6G7DxvK5Yyv8Ik1APw3YcfSJUJIy9j
   derdNbJYBhQ44x657yQAVL3d4AiIbezzzX3V5Gtv7VGsKEktXUBYJ2frH
   pLXEc/5QQ6XJINUIIGaeWPHBdOfuJRilP17bwB7xoNaOfwCJ5JcQtSVK9
   izSPKRLiJ2MauIfha+QALXP2+rGJEAN8W3rvCUlBXQa08Q05RkFLwwjoj
   sRIby0Gus8eMUD8C+Nf1LOemtegynGw5vVUBQv5fnTEks2/zM0ei8ForE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296262878"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296262878"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:34:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642155487"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="642155487"
Received: from mtkaczyk-devel.elements.local ([10.102.105.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:34:46 -0800
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, stuart.w.hayes@gmail.com,
        dan.j.williams@intel.com
Subject: [PATCH 2/3] misc: enclosure, ses: simplify some get callbacks
Date:   Thu, 17 Nov 2022 17:34:06 +0100
Message-Id: <20221117163407.28472-3-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
References: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove active, status, fault and locate variables from
enclosure_component struct. Return then directly.
No functional changes intended.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/misc/enclosure.c  | 15 +++++++++------
 drivers/scsi/ses.c        | 33 ++++++++++++++++++---------------
 include/linux/enclosure.h | 12 ++++--------
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index fd0707a8ed79..00f50fd0cc85 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -478,10 +478,11 @@ static ssize_t get_component_fault(struct device *cdev,
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+	int status = 0;
 
 	if (edev->cb->get_fault)
-		edev->cb->get_fault(edev, ecomp);
-	return sysfs_emit(buf, "%d\n", ecomp->fault);
+		status = edev->cb->get_fault(edev, ecomp);
+	return sysfs_emit(buf, "%d\n", status);
 }
 
 static ssize_t set_component_fault(struct device *cdev,
@@ -502,10 +503,11 @@ static ssize_t get_component_status(struct device *cdev,
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+	enum enclosure_status status = 0;
 
 	if (edev->cb->get_status)
-		edev->cb->get_status(edev, ecomp);
-	return sysfs_emit(buf, "%s\n", enclosure_status[ecomp->status]);
+		status = edev->cb->get_status(edev, ecomp);
+	return sysfs_emit(buf, "%s\n", enclosure_status[status]);
 }
 
 static ssize_t set_component_status(struct device *cdev,
@@ -549,10 +551,11 @@ static ssize_t get_component_locate(struct device *cdev,
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+	int status = 0;
 
 	if (edev->cb->get_locate)
-		edev->cb->get_locate(edev, ecomp);
-	return sysfs_emit(buf, "%d\n", ecomp->locate);
+		status = edev->cb->get_locate(edev, ecomp);
+	return sysfs_emit(buf, "%d\n", status);
 }
 
 static ssize_t set_component_locate(struct device *cdev,
diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 0a1734f34587..901dc94e5aeb 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -209,13 +209,14 @@ static void ses_get_fault(struct enclosure_device *edev,
 {
 	unsigned char *desc;
 
-	if (!ses_page2_supported(edev)) {
-		ecomp->fault = 0;
-		return;
-	}
+	if (!ses_page2_supported(edev))
+		return 0;
+
 	desc = ses_get_page2_descriptor(edev, ecomp);
 	if (desc)
-		ecomp->fault = (desc[3] & 0x60) >> 4;
+		return (desc[3] & 0x60) >> 4;
+
+	return 0;
 }
 
 static int ses_set_fault(struct enclosure_device *edev,
@@ -255,13 +256,14 @@ static void ses_get_status(struct enclosure_device *edev,
 {
 	unsigned char *desc;
 
-	if (!ses_page2_supported(edev)) {
-		ecomp->status = 0;
-		return;
-	}
+	if (!ses_page2_supported(edev))
+		return 0;
+
 	desc = ses_get_page2_descriptor(edev, ecomp);
 	if (desc)
-		ecomp->status = (desc[0] & 0x0f);
+		return (desc[0] & 0x0f);
+
+	return 0;
 }
 
 static void ses_get_locate(struct enclosure_device *edev,
@@ -269,13 +271,14 @@ static void ses_get_locate(struct enclosure_device *edev,
 {
 	unsigned char *desc;
 
-	if (!ses_page2_supported(edev)) {
-		ecomp->locate = 0;
-		return;
-	}
+	if (!ses_page2_supported(edev))
+		return 0;
+
 	desc = ses_get_page2_descriptor(edev, ecomp);
 	if (desc)
-		ecomp->locate = (desc[2] & 0x02) ? 1 : 0;
+		return (desc[2] & 0x02) ? 1 : 0;
+
+	return 0;
 }
 
 static int ses_set_locate(struct enclosure_device *edev,
diff --git a/include/linux/enclosure.h b/include/linux/enclosure.h
index 8d09c6d07bf1..b70e9deef3bc 100644
--- a/include/linux/enclosure.h
+++ b/include/linux/enclosure.h
@@ -52,12 +52,12 @@ enum enclosure_component_setting {
 struct enclosure_device;
 struct enclosure_component;
 struct enclosure_component_callbacks {
-	void (*get_status)(struct enclosure_device *,
+	int (*get_status)(struct enclosure_device *,
 			     struct enclosure_component *);
 	int (*set_status)(struct enclosure_device *,
 			  struct enclosure_component *,
 			  enum enclosure_status);
-	void (*get_fault)(struct enclosure_device *,
+	int (*get_fault)(struct enclosure_device *,
 			  struct enclosure_component *);
 	int (*set_fault)(struct enclosure_device *,
 			 struct enclosure_component *,
@@ -65,8 +65,8 @@ struct enclosure_component_callbacks {
 	int (*set_active)(struct enclosure_device *,
 			  struct enclosure_component *,
 			  enum enclosure_component_setting);
-	void (*get_locate)(struct enclosure_device *,
-			   struct enclosure_component *);
+	int (*get_locate)(struct enclosure_device *,
+			  struct enclosure_component *);
 	int (*set_locate)(struct enclosure_device *,
 			  struct enclosure_component *,
 			  enum enclosure_component_setting);
@@ -85,11 +85,7 @@ struct enclosure_component {
 	struct device *dev;
 	enum enclosure_component_type type;
 	int number;
-	int fault;
-	int active;
-	int locate;
 	int slot;
-	enum enclosure_status status;
 	int power_status;
 };
 
-- 
2.26.2

