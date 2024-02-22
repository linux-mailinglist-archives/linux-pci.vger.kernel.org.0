Return-Path: <linux-pci+bounces-3889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA158603C5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 21:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C961E28C951
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3085371754;
	Thu, 22 Feb 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eq2Iy0KN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5157175E;
	Thu, 22 Feb 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634469; cv=none; b=Yh//QczpZQMlB4OG+YHHiMUfjsQ+gdtgG1gN5NxUoo3h+l6Z9OQbcyD9BvvC/yX5l06eF1Etq7cMQFXJrCf2RjrKW9SMhOnklWF7mIMu6ZvIscJjgLJQtdPFwF3rMWgSeKWL9ruECx/tAH3o5wMdZnkL6dSZl6IXuTxE5aMOAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634469; c=relaxed/simple;
	bh=Q25YWzyNxF/3XAunjCUhzH+lE8FRgGWMvmbdobYKats=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEHPT7hUT5alJFRfn4Nh8P9c5m6M1RmSLkFQs8cD4h+XIX2QWJzuMFXsBMMFJjv2EpGfXycJ3hjjKxI1neMuj75wWDcn+cE0wFa6fwfWzRNv/F7uIr8EFekg6da6SCU7M10lXW1eBEiKx+hwIi4WdFg8yoPX5hF8HLQCChxBOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eq2Iy0KN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708634467; x=1740170467;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q25YWzyNxF/3XAunjCUhzH+lE8FRgGWMvmbdobYKats=;
  b=Eq2Iy0KNvDp4ts+eidwERr0eBKriU7fTGaS+t/fUZLi9tsMp3Q5+K6t4
   SNv/zLHniX1MfxRkCIhEykWXH+aR/pkG/QjeSWYXiCe/e7Tafd+nRxlf3
   sKn1AYISq95y0rA/WsbTMJQz+MltzQGen/Fd5E7UnM88FqgVI7Sw2z9sR
   3MJRPXaezYJBx6I3G1aSe8xVJx7VmW9OoIRg7Y6dTDMNbza4lS+Xjv0Mp
   nzIn0ioC7EL1+0Ua8fMqKhA/WB12oInMe2j6HK2XD3fouu9vyBs1DA8gY
   rUnEqrf+oa+36Dwsafibgq/Xq9dnZzN5DBS975g2x+YRKPc3IYyJSosxS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="25358687"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="25358687"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:41:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913585407"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913585407"
Received: from wyeh-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.77.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:41:06 -0800
Subject: [PATCH 3/3] sysfs: Introduce DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE()
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Date: Thu, 22 Feb 2024 12:41:06 -0800
Message-ID: <170863446625.1479840.10593839479268727913.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

One of the first users of DEFINE_SYSFS_GROUP_VISIBLE() did this:

	static umode_t dp0_attr_visible(struct kobject *kobj,
					struct attribute *attr,
					int n)
	{
		struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));

		if (slave->prop.dp0_prop)
			return attr->mode;
		return 0;
	}

	static bool dp0_group_visible(struct kobject *kobj)
	{
		struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));

		if (slave->prop.dp0_prop)
			return true;
		return false;
	}
	DEFINE_SYSFS_GROUP_VISIBLE(dp0);

...i.e. the _group_visible() helper is identical to the _attr_visible()
helper. Use the "simple" helper to reduce that to:

	static bool dp0_group_visible(struct kobject *kobj)
	{
		struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));

		if (slave->prop.dp0_prop)
			return true;
		return false;
	}
	DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(dp0);

Remove the need to specify per attribute visibility if the goal is to
hide the entire group.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/sysfs.h |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index dabf7f4f3581..326341c62385 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -140,7 +140,9 @@ struct attribute_group {
  * };
  *
  * Note that it expects <name>_attr_visible and <name>_group_visible to
- * be defined.
+ * be defined. For cases where individual attributes do not need
+ * separate visibility consideration, only entire group visibility at
+ * once, see DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE().
  */
 #define DEFINE_SYSFS_GROUP_VISIBLE(name)                             \
 	static inline umode_t sysfs_group_visible_##name(            \
@@ -151,6 +153,38 @@ struct attribute_group {
 		return name##_attr_visible(kobj, attr, n);           \
 	}
 
+/*
+ * DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(name):
+ *	A helper macro to pair with SYSFS_GROUP_VISIBLE() that like
+ *	DEFINE_SYSFS_GROUP_VISIBLE() controls group visibility, but does
+ *	not require the implementation of a per-attribute visibility
+ *	callback.
+ * Ex.
+ *
+ * static bool example_group_visible(struct kobject *kobj)
+ * {
+ *       if (example_group_condition)
+ *               return false;
+ *       return true;
+ * }
+ *
+ * DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(example);
+ *
+ * static struct attribute_group example_group = {
+ *       .name = "example",
+ *       .is_visible = SYSFS_GROUP_VISIBLE(example),
+ *       .attrs = &example_attrs,
+ * };
+ */
+#define DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(name)                   \
+	static inline umode_t sysfs_group_visible_##name(         \
+		struct kobject *kobj, struct attribute *a, int n) \
+	{                                                         \
+		if (n == 0 && !name##_group_visible(kobj))        \
+			return SYSFS_GROUP_INVISIBLE;             \
+		return a->mode;                                   \
+	}
+
 /*
  * Same as DEFINE_SYSFS_GROUP_VISIBLE, but for groups with only binary
  * attributes. If an attribute_group defines both text and binary
@@ -166,6 +200,15 @@ struct attribute_group {
 		return name##_attr_visible(kobj, attr, n);               \
 	}
 
+#define DEFINE_SIMPLE_SYSFS_BIN_GROUP_VISIBLE(name)                   \
+	static inline umode_t sysfs_group_visible_##name(             \
+		struct kobject *kobj, struct bin_attribute *a, int n) \
+	{                                                             \
+		if (n == 0 && !name##_group_visible(kobj))            \
+			return SYSFS_GROUP_INVISIBLE;                 \
+		return a->mode;                                       \
+	}
+
 #define SYSFS_GROUP_VISIBLE(fn) sysfs_group_visible_##fn
 
 /*


