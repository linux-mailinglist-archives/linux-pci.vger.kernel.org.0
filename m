Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCACE62E20E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 17:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiKQQft (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiKQQfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 11:35:22 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697D845EC3
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 08:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668702885; x=1700238885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nxFB8NR1SbMSv18c/1yFzRM4z8Qq4CPBOZO4kFUnQrM=;
  b=VWWLaUPeiZWeCHq9xZSjZy0KgUNEntrIVMU6SiAxapfvci7pd4w5VsM2
   PYJ4HsLvjc7e8hQJtolOrfz/Kso5yH63DFz5sl8vK8dVUwrzXqZSyFMVL
   wzoHOHjEFVVMzvhWWutYk6g2MCFWNIAyZFPUt6yi7nek8DFi5qZ9+4QLm
   +Js9wm/w+pUXc91iLMttvW9oUw0O89SD+uisbI/9DU+2X5jrRuNUSzdA0
   rNY3Pmwvdp+J28va2KR80bSqKHeAiHaqJk5A9grDgPUXpY01PbRNp7NBb
   spr+Fjo4xuZVenkMRxS3DTvCSxNRYwagoC5jDvQoZU9vTTShcvfGSALJc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296262865"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296262865"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:34:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642155452"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="642155452"
Received: from mtkaczyk-devel.elements.local ([10.102.105.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:34:43 -0800
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, stuart.w.hayes@gmail.com,
        dan.j.williams@intel.com
Subject: [PATCH 1/3] misc: enclosure: remove get_active() callback
Date:   Thu, 17 Nov 2022 17:34:05 +0100
Message-Id: <20221117163407.28472-2-mariusz.tkaczyk@linux.intel.com>
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

The callback is not used, remove it.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/misc/enclosure.c  | 14 +-------------
 include/linux/enclosure.h |  2 --
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 1b010d9267c9..fd0707a8ed79 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -531,17 +531,6 @@ static ssize_t set_component_status(struct device *cdev,
 		return -EINVAL;
 }
 
-static ssize_t get_component_active(struct device *cdev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
-	struct enclosure_component *ecomp = to_enclosure_component(cdev);
-
-	if (edev->cb->get_active)
-		edev->cb->get_active(edev, ecomp);
-	return sysfs_emit(buf, "%d\n", ecomp->active);
-}
-
 static ssize_t set_component_active(struct device *cdev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
@@ -645,8 +634,7 @@ static DEVICE_ATTR(fault, S_IRUGO | S_IWUSR, get_component_fault,
 		    set_component_fault);
 static DEVICE_ATTR(status, S_IRUGO | S_IWUSR, get_component_status,
 		   set_component_status);
-static DEVICE_ATTR(active, S_IRUGO | S_IWUSR, get_component_active,
-		   set_component_active);
+static DEVICE_ATTR(active, S_IWUSR, NULL, set_component_active);
 static DEVICE_ATTR(locate, S_IRUGO | S_IWUSR, get_component_locate,
 		   set_component_locate);
 static DEVICE_ATTR(power_status, S_IRUGO | S_IWUSR, get_component_power_status,
diff --git a/include/linux/enclosure.h b/include/linux/enclosure.h
index 1c630e2c2756..8d09c6d07bf1 100644
--- a/include/linux/enclosure.h
+++ b/include/linux/enclosure.h
@@ -62,8 +62,6 @@ struct enclosure_component_callbacks {
 	int (*set_fault)(struct enclosure_device *,
 			 struct enclosure_component *,
 			 enum enclosure_component_setting);
-	void (*get_active)(struct enclosure_device *,
-			   struct enclosure_component *);
 	int (*set_active)(struct enclosure_device *,
 			  struct enclosure_component *,
 			  enum enclosure_component_setting);
-- 
2.26.2

