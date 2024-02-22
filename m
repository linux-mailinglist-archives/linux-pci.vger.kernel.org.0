Return-Path: <linux-pci+bounces-3862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157E85F766
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 12:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3927B236D2
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3D3F9ED;
	Thu, 22 Feb 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8KFdnaf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891C208A2;
	Thu, 22 Feb 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602393; cv=none; b=AcrbAckKtc6W3Ma28JRncoWAIZhrrnt3USZohsVC0+vLraxhsYJYFO2xq9/eyj4I4QeLjzRvGvhldFTOEzR/vauwA5SvrQtMQFKL+pCf+aEvR9lU2H8ftyGWGbS2pgEwc8gncRyNaNCNw3W7cB8kKFKT6P19c29m55g+F4sUfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602393; c=relaxed/simple;
	bh=U/ODfnHwPi5+9NrV+Ux+CV06sA5Ml+gF11lFUa0pFdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BME4IREv/Ap2gGCZQCw2pte4G6rXZqg3H2M2gojNFvqYOfTMyMN1lNs7ZebghPYvA9BOvoNgQQXgVn7dBsFIk2GfB/UMJTv6Z83ximOLfqpYhIwKExlEifYZaQV5amHXkKLxU83K4VbBk5y10QrVM5JJa2bLkppkbPVFWVmFdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8KFdnaf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708602391; x=1740138391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U/ODfnHwPi5+9NrV+Ux+CV06sA5Ml+gF11lFUa0pFdY=;
  b=i8KFdnafKk0s0KRkmi87a2vigx642+bWfIXYLcUj3wl8Ue6ahv+ND/8y
   CO+qZtdAXyofUkr8bXMZPJoeBmh8Tq22p2rgY34ZuM73W201luFNQsS0e
   6iZpoOgnCOfFAsGms64L6NmgEGwzN5xAZLUoQ+Za3/syh+RfiGKmqOHuS
   NLujUsrzpKxalbAOjalQw4bQGKp+AfSzcky9zlpMTsvZ6jDCku3YZjb8e
   hQA1NkT8AUH5VW1bcryO1n9PzTt0ytkDEk4Dn3sKDTi3KyJfjHbxFbaJ2
   3dv2SgzL07RqMEZvgZPHkps6ZsKtIZhhx3uqLWroU4QyUNlNXyuPI51LW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13522191"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13522191"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 03:46:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5436460"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 03:46:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI/sysfs: Demacrofy pci_dev_resource_resize_attr(n) functions
Date: Thu, 22 Feb 2024 13:46:06 +0200
Message-Id: <20240222114607.1837-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_dev_resource_resize_attr(n) macro is invoked for six resources,
creating a large footprint function for each resource.

Rework the macro to only create a function that calls a helper function
so the compiler can decide if it warrants to inline the function or
not.

With x86_64 defconfig, this saves roughly 2.5kB:

$ scripts/bloat-o-meter drivers/pci/pci-sysfs.o{.old,.new}
add/remove: 1/0 grow/shrink: 0/6 up/down: 512/-2934 (-2422)
Function                                     old     new   delta
__resource_resize_store                        -     512    +512
resource5_resize_store                       503      14    -489
resource4_resize_store                       503      14    -489
resource3_resize_store                       503      14    -489
resource2_resize_store                       503      14    -489
resource1_resize_store                       503      14    -489
resource0_resize_store                       500      11    -489
Total: Before=13399, After=10977, chg -18.08%

(The compiler seemingly chose to still inline __resource_resize_show()
which is fine, those functions are not very complex/large.)

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 138 +++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2321fdfefd7d..613c5fc4f0a2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1410,79 +1410,89 @@ static const struct attribute_group pci_dev_reset_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
+
+	pci_config_pm_runtime_get(pdev);
+
+	ret = sysfs_emit(buf, "%016llx\n",
+			 (u64)pci_rebar_get_possible_sizes(pdev, n));
+
+	pci_config_pm_runtime_put(pdev);
+
+	return ret;
+}
+
+static ssize_t __resource_resize_store(struct device *dev, int n,
+				       const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	unsigned long size, flags;
+	int ret, i;
+	u16 cmd;
+
+	if (kstrtoul(buf, 0, &size) < 0)
+		return -EINVAL;
+
+	device_lock(dev);
+	if (dev->driver) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	pci_config_pm_runtime_get(pdev);
+
+	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {
+		ret = aperture_remove_conflicting_pci_devices(pdev,
+						"resourceN_resize");
+		if (ret)
+			goto pm_put;
+	}
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	pci_write_config_word(pdev, PCI_COMMAND,
+			      cmd & ~PCI_COMMAND_MEMORY);
+
+	flags = pci_resource_flags(pdev, n);
+
+	pci_remove_resource_files(pdev);
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (pci_resource_len(pdev, i) &&
+		    pci_resource_flags(pdev, i) == flags)
+			pci_release_resource(pdev, i);
+	}
+
+	ret = pci_resize_resource(pdev, n, size);
+
+	pci_assign_unassigned_bus_resources(pdev->bus);
+
+	if (pci_create_resource_files(pdev))
+		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");
+
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+pm_put:
+	pci_config_pm_runtime_put(pdev);
+unlock:
+	device_unlock(dev);
+
+	return ret ? ret : count;
+}
+
 #define pci_dev_resource_resize_attr(n)					\
 static ssize_t resource##n##_resize_show(struct device *dev,		\
 					 struct device_attribute *attr,	\
-					 char * buf)			\
+					 char *buf)			\
 {									\
-	struct pci_dev *pdev = to_pci_dev(dev);				\
-	ssize_t ret;							\
-									\
-	pci_config_pm_runtime_get(pdev);				\
-									\
-	ret = sysfs_emit(buf, "%016llx\n",				\
-			 (u64)pci_rebar_get_possible_sizes(pdev, n));	\
-									\
-	pci_config_pm_runtime_put(pdev);				\
-									\
-	return ret;							\
+	return __resource_resize_show(dev, n, buf);			\
 }									\
-									\
 static ssize_t resource##n##_resize_store(struct device *dev,		\
 					  struct device_attribute *attr,\
 					  const char *buf, size_t count)\
 {									\
-	struct pci_dev *pdev = to_pci_dev(dev);				\
-	unsigned long size, flags;					\
-	int ret, i;							\
-	u16 cmd;							\
-									\
-	if (kstrtoul(buf, 0, &size) < 0)				\
-		return -EINVAL;						\
-									\
-	device_lock(dev);						\
-	if (dev->driver) {						\
-		ret = -EBUSY;						\
-		goto unlock;						\
-	}								\
-									\
-	pci_config_pm_runtime_get(pdev);				\
-									\
-	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {		\
-		ret = aperture_remove_conflicting_pci_devices(pdev,	\
-						"resourceN_resize");	\
-		if (ret)						\
-			goto pm_put;					\
-	}								\
-									\
-	pci_read_config_word(pdev, PCI_COMMAND, &cmd);			\
-	pci_write_config_word(pdev, PCI_COMMAND,			\
-			      cmd & ~PCI_COMMAND_MEMORY);		\
-									\
-	flags = pci_resource_flags(pdev, n);				\
-									\
-	pci_remove_resource_files(pdev);				\
-									\
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {			\
-		if (pci_resource_len(pdev, i) &&			\
-		    pci_resource_flags(pdev, i) == flags)		\
-			pci_release_resource(pdev, i);			\
-	}								\
-									\
-	ret = pci_resize_resource(pdev, n, size);			\
-									\
-	pci_assign_unassigned_bus_resources(pdev->bus);			\
-									\
-	if (pci_create_resource_files(pdev))				\
-		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");\
-									\
-	pci_write_config_word(pdev, PCI_COMMAND, cmd);			\
-pm_put:									\
-	pci_config_pm_runtime_put(pdev);				\
-unlock:									\
-	device_unlock(dev);						\
-									\
-	return ret ? ret : count;					\
+	return __resource_resize_store(dev, n, buf, count);		\
 }									\
 static DEVICE_ATTR_RW(resource##n##_resize)
 
-- 
2.39.2


