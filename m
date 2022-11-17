Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB54F62E217
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiKQQgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 11:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbiKQQgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 11:36:16 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC96870A30
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 08:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668702921; x=1700238921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMXxpVugC093Ie4OcNbXaYdZIP1EZQJ+FUItgCxhVIM=;
  b=QlhU+bhFXZtRaoGsDjnpVMhq5CDpwjcUIhczsZSRtvqyprPWd3OL6uvz
   7LfRDj2EJLu4Fucme32D3FHD/V+qgejWDIIo3tvqn+iGHor9HGvwehxrO
   UTth7Vr7+UuEDx7LCHnM6alxWs4OrHNf6Y4LIfQisD3vF5kky8NUtIPup
   L1ZXqGIAT4ZbilxnZ57KegwiDxbJm4pEfRQEsGd9SfUdEEP/zReMueVEa
   c6AIhkN3c8adD0Zr18GNg56wITeA7vNrzMORDIGrTi2WlGTlzktQIVBwA
   6bs+EaNZIeZPIyL8TrXlhBdTE1OXUgqOtNi4ksZNwc9dYwz/4QT6doY44
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="339731351"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="339731351"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:34:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642155517"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="642155517"
Received: from mtkaczyk-devel.elements.local ([10.102.105.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:34:48 -0800
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, stuart.w.hayes@gmail.com,
        dan.j.williams@intel.com
Subject: [PATCH 3/3] misc: enclosure: update sysfs api
Date:   Thu, 17 Nov 2022 17:34:07 +0100
Message-Id: <20221117163407.28472-4-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
References: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use DEVICE_ATTR RW, RO and WO macros. Update function names
accordingly.
No functional changes intended.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/misc/enclosure.c | 69 +++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 00f50fd0cc85..ab2fd918ecf6 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -473,8 +473,8 @@ static const char *const enclosure_type[] = {
 	[ENCLOSURE_COMPONENT_ARRAY_DEVICE] = "array device",
 };
 
-static ssize_t get_component_fault(struct device *cdev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t fault_show(struct device *cdev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -485,9 +485,8 @@ static ssize_t get_component_fault(struct device *cdev,
 	return sysfs_emit(buf, "%d\n", status);
 }
 
-static ssize_t set_component_fault(struct device *cdev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
+static ssize_t fault_store(struct device *cdev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -498,8 +497,8 @@ static ssize_t set_component_fault(struct device *cdev,
 	return count;
 }
 
-static ssize_t get_component_status(struct device *cdev,
-				    struct device_attribute *attr,char *buf)
+static ssize_t status_show(struct device *cdev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -510,9 +509,8 @@ static ssize_t get_component_status(struct device *cdev,
 	return sysfs_emit(buf, "%s\n", enclosure_status[status]);
 }
 
-static ssize_t set_component_status(struct device *cdev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
+static ssize_t status_store(struct device *cdev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -533,9 +531,8 @@ static ssize_t set_component_status(struct device *cdev,
 		return -EINVAL;
 }
 
-static ssize_t set_component_active(struct device *cdev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
+static ssize_t active_store(struct device *cdev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -546,8 +543,8 @@ static ssize_t set_component_active(struct device *cdev,
 	return count;
 }
 
-static ssize_t get_component_locate(struct device *cdev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t locate_show(struct device *cdev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -558,9 +555,8 @@ static ssize_t get_component_locate(struct device *cdev,
 	return sysfs_emit(buf, "%d\n", status);
 }
 
-static ssize_t set_component_locate(struct device *cdev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
+static ssize_t locate_store(struct device *cdev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -571,9 +567,8 @@ static ssize_t set_component_locate(struct device *cdev,
 	return count;
 }
 
-static ssize_t get_component_power_status(struct device *cdev,
-					  struct device_attribute *attr,
-					  char *buf)
+static ssize_t power_status_show(struct device *cdev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -588,9 +583,9 @@ static ssize_t get_component_power_status(struct device *cdev,
 	return sysfs_emit(buf, "%s\n", ecomp->power_status ? "on" : "off");
 }
 
-static ssize_t set_component_power_status(struct device *cdev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
+static ssize_t power_status_store(struct device *cdev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -610,16 +605,16 @@ static ssize_t set_component_power_status(struct device *cdev,
 	return count;
 }
 
-static ssize_t get_component_type(struct device *cdev,
-				  struct device_attribute *attr, char *buf)
+static ssize_t type_show(struct device *cdev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
 
 	return sysfs_emit(buf, "%s\n", enclosure_type[ecomp->type]);
 }
 
-static ssize_t get_component_slot(struct device *cdev,
-				  struct device_attribute *attr, char *buf)
+static ssize_t slot_show(struct device *cdev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
 	int slot;
@@ -633,17 +628,13 @@ static ssize_t get_component_slot(struct device *cdev,
 	return sysfs_emit(buf, "%d\n", slot);
 }
 
-static DEVICE_ATTR(fault, S_IRUGO | S_IWUSR, get_component_fault,
-		    set_component_fault);
-static DEVICE_ATTR(status, S_IRUGO | S_IWUSR, get_component_status,
-		   set_component_status);
-static DEVICE_ATTR(active, S_IWUSR, NULL, set_component_active);
-static DEVICE_ATTR(locate, S_IRUGO | S_IWUSR, get_component_locate,
-		   set_component_locate);
-static DEVICE_ATTR(power_status, S_IRUGO | S_IWUSR, get_component_power_status,
-		   set_component_power_status);
-static DEVICE_ATTR(type, S_IRUGO, get_component_type, NULL);
-static DEVICE_ATTR(slot, S_IRUGO, get_component_slot, NULL);
+static DEVICE_ATTR_RW(fault);
+static DEVICE_ATTR_RW(status);
+static DEVICE_ATTR_WO(active);
+static DEVICE_ATTR_RW(locate);
+static DEVICE_ATTR_RW(power_status);
+static DEVICE_ATTR_RO(type);
+static DEVICE_ATTR_RO(slot);
 
 static struct attribute *enclosure_component_attrs[] = {
 	&dev_attr_fault.attr,
-- 
2.26.2

