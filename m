Return-Path: <linux-pci+bounces-26592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405D9A9970B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91834A20C4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20DE28D835;
	Wed, 23 Apr 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehpTu1u9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BE28BA95;
	Wed, 23 Apr 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430653; cv=none; b=YUfEculqDjP7Wled/nX2Je0Ab67K7yCsPzX9yXGdortimFsket8GgDQrUt8p5AerCt5R7zpg3YBliSkDNIHiVPDD3atFfCvcCURtJ8ndOIaIFVW1/ByKpNAa67RMvUno26aj4i2XWv9CwiahSixOXsGpn2ezQ+y7QBc6e9XPu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430653; c=relaxed/simple;
	bh=OkcRkYHAR4Otv+Uk66lK6k1eF+5Jp14O8IBgr67qKS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfdEo1pox6OcOtqxD8M9dHANRT0Lkaq+HP2EIQ2AlbxO2fgWnnkMfXEDXlydtL17Jr9NUSycWnRe7cvlipsfTmGF6qdr2X/ELo+OlvC0/TJDsYf0UHxklpIPFSS+i/2IiNF56kG6ag54vUU/pe+qUDGVj0HjtMuw5sfbL2onHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehpTu1u9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745430652; x=1776966652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OkcRkYHAR4Otv+Uk66lK6k1eF+5Jp14O8IBgr67qKS8=;
  b=ehpTu1u9P4nu8m3dloPjhXhViLnOzS7NRho0spGRMPBi2Q6rC3WxxPVt
   3Rwdrjs87u370zsy8DSStV2cdgbXJF9d3FOrRhS/RDGuy95vo4umj3mcb
   csHFSOyT3gjl9PcpC2x87idAYyDWlVZEobSeyxBIUVLrRE6ULkYW5ONTZ
   45aw5KBPDKZ17Jpp8ONIiW4FAQuN5LR80ktfXSezZcUMHVYTjl4IVJks8
   t+CgtZNw63AN4CPTZ5bwEi6+mq2OdQynXypcCCp/v6GhXqTYrAH463yTA
   zFCCdYTXY4vTqVPNwrSt+mSQ+7MfGemOrDymvcvEDAaep5lcBJItWgde8
   Q==;
X-CSE-ConnectionGUID: gKCw+OTgQc+XP/DjCXJk/Q==
X-CSE-MsgGUID: khOgRIAvQ6+MgvGI1z7v/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47168316"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47168316"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:50 -0700
X-CSE-ConnectionGUID: S97pBJb3RqqCtyigAulA4A==
X-CSE-MsgGUID: 27JVomB2QPekfE6KfO4oZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163350458"
Received: from ldmartin-desk2.corp.intel.com (HELO debox1-desk4.lan) ([10.125.111.241])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:50 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: corbet@lwn.net,
	bhelgaas@google.com,
	kuurtb@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	sanyog.r.kale@intel.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	david.e.box@linux.intel.com,
	dan.j.williams@intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com,
	linux-sound@vger.kernel.org
Subject: [PATCH 1/7] sysfs: Rename attribute group visibility macros
Date: Wed, 23 Apr 2025 10:50:31 -0700
Message-ID: <20250423175040.784680-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423175040.784680-1-david.e.box@linux.intel.com>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update the naming of several macros to provide clearer semantics for
controlling group and attribute visibility per Dan Williams' suggestion.
Also, add transitional aliases mapping the old macro names to the new ones
so that driver code remains functional before changes are again made in a
future macro encapsulation patch. This approach ensures that when the
encapsulation work is applied, drivers will only need to be updated once
without breaking compatibility.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 include/linux/sysfs.h | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 18f7e1fd093c..00dc88776f21 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -116,7 +116,7 @@ struct attribute_group {
 #define SYSFS_GROUP_INVISIBLE	020000
=20
 /*
- * DEFINE_SYSFS_GROUP_VISIBLE(name):
+ * DEFINE_SYSFS_GROUP_COMBO_VISIBILITY(name):
  *	A helper macro to pair with the assignment of ".is_visible =3D
  *	SYSFS_GROUP_VISIBLE(name)", that arranges for the directory
  *	associated with a named attribute_group to optionally be hidden.
@@ -142,7 +142,7 @@ struct attribute_group {
  *       return true;
  * }
  *
- * DEFINE_SYSFS_GROUP_VISIBLE(example);
+ * DEFINE_SYSFS_GROUP_COMBO_VISIBILITY(example);
  *
  * static struct attribute_group example_group =3D {
  *       .name =3D "example",
@@ -153,9 +153,9 @@ struct attribute_group {
  * Note that it expects <name>_attr_visible and <name>_group_visible to
  * be defined. For cases where individual attributes do not need
  * separate visibility consideration, only entire group visibility at
- * once, see DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE().
+ * once, see DEFINE_SYSFS_GROUP_VISIBILITY().
  */
-#define DEFINE_SYSFS_GROUP_VISIBLE(name)                             \
+#define DEFINE_SYSFS_GROUP_COMBO_VISIBILITY(name)                         =
 \
 	static inline umode_t sysfs_group_visible_##name(            \
 		struct kobject *kobj, struct attribute *attr, int n) \
 	{                                                            \
@@ -165,9 +165,9 @@ struct attribute_group {
 	}
=20
 /*
- * DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(name):
+ * DEFINE_SYSFS_GROUP_VISIBILITY(name):
  *	A helper macro to pair with SYSFS_GROUP_VISIBLE() that like
- *	DEFINE_SYSFS_GROUP_VISIBLE() controls group visibility, but does
+ *	DEFINE_SYSFS_GROUP_COMBO_VISIBILITY() controls group visibility, but do=
es
  *	not require the implementation of a per-attribute visibility
  *	callback.
  * Ex.
@@ -179,7 +179,7 @@ struct attribute_group {
  *       return true;
  * }
  *
- * DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(example);
+ * DEFINE_SYSFS_GROUP_VISIBILITY(example);
  *
  * static struct attribute_group example_group =3D {
  *       .name =3D "example",
@@ -187,7 +187,7 @@ struct attribute_group {
  *       .attrs =3D &example_attrs,
  * };
  */
-#define DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(name)                   \
+#define DEFINE_SYSFS_GROUP_VISIBILITY(name)                 \
 	static inline umode_t sysfs_group_visible_##name(         \
 		struct kobject *kobj, struct attribute *a, int n) \
 	{                                                         \
@@ -197,12 +197,12 @@ struct attribute_group {
 	}
=20
 /*
- * Same as DEFINE_SYSFS_GROUP_VISIBLE, but for groups with only binary
+ * Same as DEFINE_SYSFS_GROUP_COMBO_VISIBILITY, but for groups with only b=
inary
  * attributes. If an attribute_group defines both text and binary
  * attributes, the group visibility is determined by the function
  * specified to is_visible() not is_bin_visible()
  */
-#define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name)                              =
     \
+#define DEFINE_SYSFS_BIN_GROUP_COMBO_VISIBILITY(name)                     =
           \
 	static inline umode_t sysfs_group_visible_##name(                      \
 		struct kobject *kobj, const struct bin_attribute *attr, int n) \
 	{                                                                      \
@@ -211,7 +211,7 @@ struct attribute_group {
 		return name##_attr_visible(kobj, attr, n);                     \
 	}
=20
-#define DEFINE_SIMPLE_SYSFS_BIN_GROUP_VISIBLE(name)                       =
  \
+#define DEFINE_SYSFS_BIN_GROUP_VISIBILITY(name)                       \
 	static inline umode_t sysfs_group_visible_##name(                   \
 		struct kobject *kobj, const struct bin_attribute *a, int n) \
 	{                                                                   \
@@ -220,6 +220,12 @@ struct attribute_group {
 		return a->mode;                                             \
 	}
=20
+/* Transitional aliases: so legacy code using old names continues to work =
*/
+#define DEFINE_SYSFS_GROUP_VISIBLE(name) DEFINE_SYSFS_GROUP_COMBO_VISIBILI=
TY(name)
+#define DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(name) DEFINE_SYSFS_GROUP_VISIBIL=
ITY(name)
+#define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name) DEFINE_SYSFS_BIN_GROUP_COMBO_=
VISIBILITY(name)
+#define DEFINE_SIMPLE_SYSFS_BIN_GROUP_VISIBLE(name) DEFINE_SYSFS_BIN_GROUP=
_VISIBILITY(name)
+
 #define SYSFS_GROUP_VISIBLE(fn) sysfs_group_visible_##fn
=20
 /*
--=20
2.43.0


