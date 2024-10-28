Return-Path: <linux-pci+bounces-15468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0769B3816
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 18:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C471F21CB6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC41DF99B;
	Mon, 28 Oct 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3xtsFtl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555C1DF998;
	Mon, 28 Oct 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137264; cv=none; b=g9OIYRh3s7KNQWLsoj/toabIk5pNYnNfZp6HrcmSPuqHZ6YxjMYRjI4W6MoBr1ACdRLWTyZPxqvuwbLxxRFNvHhRlpk3W/p/eE7vd8Rq4RiMjvXUgXHP44Qq7Dhg/qvId/233KklM5R3u6VY+wVHIp2lXEnEXPmVAptUeF7CEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137264; c=relaxed/simple;
	bh=0NZy39BfjUh2rWKkQukilOTO2WhZ2KItYCoVK7C3ORw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l61KrFYYdaSJujDvlpvZccHCZY5n00AX5q1HZ7fZC7d7dlv6+gxSj9+CvHHxSynhLdL8MKu3LRrALK6gmiIuv/6CU3RnwR26LXl96TGxh3x6FnFPJNeWnbsgQAW727LEpUZbc2H4g6J416XhMEluZLapezid+1T6IKFEZgU3TWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3xtsFtl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730137262; x=1761673262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0NZy39BfjUh2rWKkQukilOTO2WhZ2KItYCoVK7C3ORw=;
  b=d3xtsFtlT0pZXNjH8hYjw0MeciHZRAHNiUcg7e/koThICUblcCZLKoky
   gVo8k2C6yvSk/cUXxvBSUz+y69kRdVCvg30MEqV5wNRkt6i7sPR4D/W43
   fnxTDoOkF+prz/3dG45YTgsjl7UNZqFATqGMZM4cG31fqIjIgi38QKLq3
   RkuiR6ebkk+aYVGh/cMt+dWgbVYkJWWCH/DiHW1SJq1rH8gyab+Pd/XKP
   0aTNfkbieBSWLWzCNn2kx4L+0XM8cyfzPuvgZVJSV9BpH9HUX6y3bRPN0
   IBdm3oWbcQclPxA3g0tD3OXUnUsl5zJ3BvRFhGV7g/cRJXbouXWjXo7OH
   g==;
X-CSE-ConnectionGUID: ooZCepYFRnypHI0TvWKGbQ==
X-CSE-MsgGUID: ZlX+eJKkQ7ijNJmd3/G1Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33440548"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33440548"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:41:02 -0700
X-CSE-ConnectionGUID: cY9LakQjR9KmUDRxzL/TMw==
X-CSE-MsgGUID: vTBi5yglQBqF8s4ZBfnaig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="105015005"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:40:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] PCI/sysfs: Move reset related sysfs code to correct file
Date: Mon, 28 Oct 2024 19:40:44 +0200
Message-Id: <20241028174046.1736-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>
References: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Most PCI sysfs code and structs are in a dedicated file but a few reset
related things remain in pci.c. Move also them to pci-sysfs.c and drop
pci_dev_reset_method_attr_is_visible() as it is 100% duplicate of
pci_dev_reset_attr_is_visible().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 112 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c       | 125 +---------------------------------------
 drivers/pci/pci.h       |   3 +-
 3 files changed, 114 insertions(+), 126 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d0f4db1cab7..507478082454 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1391,6 +1391,118 @@ static const struct attribute_group pci_dev_reset_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+static ssize_t reset_method_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t len = 0;
+	int i, m;
+
+	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
+		m = pdev->reset_methods[i];
+		if (!m)
+			break;
+
+		len += sysfs_emit_at(buf, len, "%s%s", len ? " " : "",
+				     pci_reset_fn_methods[m].name);
+	}
+
+	if (len)
+		len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
+static int reset_method_lookup(const char *name)
+{
+	int m;
+
+	for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
+		if (sysfs_streq(name, pci_reset_fn_methods[m].name))
+			return m;
+	}
+
+	return 0;	/* not found */
+}
+
+static ssize_t reset_method_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	char *options, *tmp_options, *name;
+	int m, n;
+	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
+
+	if (sysfs_streq(buf, "")) {
+		pdev->reset_methods[0] = 0;
+		pci_warn(pdev, "All device reset methods disabled by user");
+		return count;
+	}
+
+	if (sysfs_streq(buf, "default")) {
+		pci_init_reset_methods(pdev);
+		return count;
+	}
+
+	options = kstrndup(buf, count, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	n = 0;
+	tmp_options = options;
+	while ((name = strsep(&tmp_options, " ")) != NULL) {
+		if (sysfs_streq(name, ""))
+			continue;
+
+		name = strim(name);
+
+		m = reset_method_lookup(name);
+		if (!m) {
+			pci_err(pdev, "Invalid reset method '%s'", name);
+			goto error;
+		}
+
+		if (pci_reset_fn_methods[m].reset_fn(pdev, PCI_RESET_PROBE)) {
+			pci_err(pdev, "Unsupported reset method '%s'", name);
+			goto error;
+		}
+
+		if (n == PCI_NUM_RESET_METHODS - 1) {
+			pci_err(pdev, "Too many reset methods\n");
+			goto error;
+		}
+
+		reset_methods[n++] = m;
+	}
+
+	reset_methods[n] = 0;
+
+	/* Warn if dev-specific supported but not highest priority */
+	if (pci_reset_fn_methods[1].reset_fn(pdev, PCI_RESET_PROBE) == 0 &&
+	    reset_methods[0] != 1)
+		pci_warn(pdev, "Device-specific reset disabled/de-prioritized by user");
+	memcpy(pdev->reset_methods, reset_methods, sizeof(pdev->reset_methods));
+	kfree(options);
+	return count;
+
+error:
+	/* Leave previous methods unchanged */
+	kfree(options);
+	return -EINVAL;
+}
+static DEVICE_ATTR_RW(reset_method);
+
+static struct attribute *pci_dev_reset_method_attrs[] = {
+	&dev_attr_reset_method.attr,
+	NULL,
+};
+
+static const struct attribute_group pci_dev_reset_method_attr_group = {
+	.attrs = pci_dev_reset_method_attrs,
+	.is_visible = pci_dev_reset_attr_is_visible,
+};
+
 static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0e6562ff3dcf..17831b7d9531 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5194,7 +5194,7 @@ static void pci_dev_restore(struct pci_dev *dev)
 }
 
 /* dev->reset_methods[] is a 0-terminated list of indices into this array */
-static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
+const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
 	{ pci_dev_acpi_reset, .name = "acpi" },
@@ -5205,129 +5205,6 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
 };
 
-static ssize_t reset_method_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	ssize_t len = 0;
-	int i, m;
-
-	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
-		m = pdev->reset_methods[i];
-		if (!m)
-			break;
-
-		len += sysfs_emit_at(buf, len, "%s%s", len ? " " : "",
-				     pci_reset_fn_methods[m].name);
-	}
-
-	if (len)
-		len += sysfs_emit_at(buf, len, "\n");
-
-	return len;
-}
-
-static int reset_method_lookup(const char *name)
-{
-	int m;
-
-	for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
-		if (sysfs_streq(name, pci_reset_fn_methods[m].name))
-			return m;
-	}
-
-	return 0;	/* not found */
-}
-
-static ssize_t reset_method_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	char *options, *tmp_options, *name;
-	int m, n;
-	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
-
-	if (sysfs_streq(buf, "")) {
-		pdev->reset_methods[0] = 0;
-		pci_warn(pdev, "All device reset methods disabled by user");
-		return count;
-	}
-
-	if (sysfs_streq(buf, "default")) {
-		pci_init_reset_methods(pdev);
-		return count;
-	}
-
-	options = kstrndup(buf, count, GFP_KERNEL);
-	if (!options)
-		return -ENOMEM;
-
-	n = 0;
-	tmp_options = options;
-	while ((name = strsep(&tmp_options, " ")) != NULL) {
-		if (sysfs_streq(name, ""))
-			continue;
-
-		name = strim(name);
-
-		m = reset_method_lookup(name);
-		if (!m) {
-			pci_err(pdev, "Invalid reset method '%s'", name);
-			goto error;
-		}
-
-		if (pci_reset_fn_methods[m].reset_fn(pdev, PCI_RESET_PROBE)) {
-			pci_err(pdev, "Unsupported reset method '%s'", name);
-			goto error;
-		}
-
-		if (n == PCI_NUM_RESET_METHODS - 1) {
-			pci_err(pdev, "Too many reset methods\n");
-			goto error;
-		}
-
-		reset_methods[n++] = m;
-	}
-
-	reset_methods[n] = 0;
-
-	/* Warn if dev-specific supported but not highest priority */
-	if (pci_reset_fn_methods[1].reset_fn(pdev, PCI_RESET_PROBE) == 0 &&
-	    reset_methods[0] != 1)
-		pci_warn(pdev, "Device-specific reset disabled/de-prioritized by user");
-	memcpy(pdev->reset_methods, reset_methods, sizeof(pdev->reset_methods));
-	kfree(options);
-	return count;
-
-error:
-	/* Leave previous methods unchanged */
-	kfree(options);
-	return -EINVAL;
-}
-static DEVICE_ATTR_RW(reset_method);
-
-static struct attribute *pci_dev_reset_method_attrs[] = {
-	&dev_attr_reset_method.attr,
-	NULL,
-};
-
-static umode_t pci_dev_reset_method_attr_is_visible(struct kobject *kobj,
-						    struct attribute *a, int n)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-
-	if (!pci_reset_supported(pdev))
-		return 0;
-
-	return a->mode;
-}
-
-const struct attribute_group pci_dev_reset_method_attr_group = {
-	.attrs = pci_dev_reset_method_attrs,
-	.is_visible = pci_dev_reset_method_attr_is_visible,
-};
-
 /**
  * __pci_reset_function_locked - reset a PCI device function while holding
  * the @dev mutex lock.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..e65dcc8e4832 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -702,6 +702,7 @@ struct pci_reset_fn_method {
 	int (*reset_fn)(struct pci_dev *pdev, bool probe);
 	char *name;
 };
+extern const struct pci_reset_fn_method pci_reset_fn_methods[];
 
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_reset(struct pci_dev *dev, bool probe);
@@ -891,8 +892,6 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 extern const struct attribute_group aspm_ctrl_attr_group;
 #endif
 
-extern const struct attribute_group pci_dev_reset_method_attr_group;
-
 #ifdef CONFIG_X86_INTEL_MID
 bool pci_use_mid_pm(void);
 int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state);
-- 
2.39.5


