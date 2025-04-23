Return-Path: <linux-pci+bounces-26597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EDFA9971D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10854A255D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3B128F94C;
	Wed, 23 Apr 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmbtD7zJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4928DF1D;
	Wed, 23 Apr 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430657; cv=none; b=cKC/0H/XFkGIX70pudGtN6aU4APy6pgA8nL9dIvbn4vLRY8vFzZ4qm1hJTzTGhzCZWrI9TZV51bcT5c6zjlO1IpW2+U1TYf8dTPuBS1HsficZHy0I4SvYervFFjTGfYKoxK6hlDvV2fpUlWUq/yZM+2H2RxHd1bucs7M1fp1Z3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430657; c=relaxed/simple;
	bh=IBk/naibZDvcxq96fwpE5v2/BJFqKlCrOvkCRVqKOtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gu+upIIaN5FNu6CWvcbA1l9SVRYDrCzvA5ktjDQdfvdVUtdaQYcwql1mlCGjf/qI8Vk3V3dUhlTGj9c1/7lEyYSLbmJGdSq+uWa4js5QCe8IulV3S0M+Ce4MpXpPZ8R/sVdRj2R11iDEFOdquWCvvJDSizZd0hBvzkoz1iJikZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmbtD7zJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745430655; x=1776966655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IBk/naibZDvcxq96fwpE5v2/BJFqKlCrOvkCRVqKOtg=;
  b=bmbtD7zJa9bOi/fNz+6bGuMRfvDUhuEccyn/xUQNRu62Eb5GqNM45px7
   V5sdQPH3k0qda9x8qIPCY0AHef59R37IBArp8FVVNtCrG4gu3lzgOiWpk
   2t3f8uzRDSNVqdMxQKgZtZ0HgPrb46Bas5bhZ0Qc5k2ih4YUd/lF+Zk68
   fqcVd9KAVpCjet69TrmlI/OBir/vJHsovQWkCxbvI5Lt4SvW8FlS3KQc6
   UCz4z2mcnxolnV4jXmSDQ5IDVEvlKvsuQNqg0Ywnnd+FwIoVtG3a/AMlj
   bYweVm71qsv5xllbMm0RagC2OwUK6zAk7GV0a7bPrL8DQpfPjIfLw5iip
   A==;
X-CSE-ConnectionGUID: xGK/yia6TWS1j7QymFhjJw==
X-CSE-MsgGUID: FYp+35JkQ+iwq4jgwww7rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47168361"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47168361"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:52 -0700
X-CSE-ConnectionGUID: dOxbRnqNSNSFZoq87BiKHA==
X-CSE-MsgGUID: d8u3x7iUQFS0pjwR1InBCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163350482"
Received: from ldmartin-desk2.corp.intel.com (HELO debox1-desk4.lan) ([10.125.111.241])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:52 -0700
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
Subject: [PATCH 6/7] platform/x86/dell: alienware-wmi: update sysfs visibility macros
Date: Wed, 23 Apr 2025 10:50:36 -0700
Message-ID: <20250423175040.784680-7-david.e.box@linux.intel.com>
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

Replace deprecated visibility macros and align group naming with new API.

In alienware-wmi-base.c, use NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(rgb_zones)
to define the rgb_zones attribute group concisely. To preserve the existing
userspace ABI, rename zone_attr_visible and rgb_zones_attr_visible to
zone_group_visible and rgb_zones_group_visible, respectively, to reflect the
'rgb_zones' group.

In alienware-wmi-wmax.c, replace DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() with
the renamed DEFINE_SYSFS_GROUP_VISIBILITY() macro for the hdmi, amplifier,
and deepsleep attributes to match the updated API.

While here, add missing sysfs.h include and sort headers alphabetically. No
functional changes are intended.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 .../platform/x86/dell/alienware-wmi-base.c    | 23 ++++++++-----------
 .../platform/x86/dell/alienware-wmi-wmax.c    |  7 +++---
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-base.c b/drivers/platf=
orm/x86/dell/alienware-wmi-base.c
index 64562b92314f..ee41892e562c 100644
--- a/drivers/platform/x86/dell/alienware-wmi-base.c
+++ b/drivers/platform/x86/dell/alienware-wmi-base.c
@@ -10,10 +10,11 @@
=20
 #include <linux/acpi.h>
 #include <linux/cleanup.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/dmi.h>
 #include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
 #include "alienware-wmi.h"
=20
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
@@ -326,8 +327,8 @@ static ssize_t lighting_control_state_store(struct devi=
ce *dev,
=20
 static DEVICE_ATTR_RW(lighting_control_state);
=20
-static umode_t zone_attr_visible(struct kobject *kobj,
-				 struct attribute *attr, int n)
+static umode_t rgb_zones_attr_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
 {
 	if (n < alienfx->num_zones + 1)
 		return attr->mode;
@@ -335,13 +336,12 @@ static umode_t zone_attr_visible(struct kobject *kobj,
 	return 0;
 }
=20
-static bool zone_group_visible(struct kobject *kobj)
+static bool rgb_zones_group_visible(struct kobject *kobj)
 {
 	return alienfx->num_zones > 0;
 }
-DEFINE_SYSFS_GROUP_VISIBLE(zone);
=20
-static struct attribute *zone_attrs[] =3D {
+static struct attribute *rgb_zones_attrs[] =3D {
 	&dev_attr_lighting_control_state.attr,
 	&dev_attr_zone00.attr,
 	&dev_attr_zone01.attr,
@@ -349,12 +349,7 @@ static struct attribute *zone_attrs[] =3D {
 	&dev_attr_zone03.attr,
 	NULL
 };
-
-static struct attribute_group zone_attribute_group =3D {
-	.name =3D "rgb_zones",
-	.is_visible =3D SYSFS_GROUP_VISIBLE(zone),
-	.attrs =3D zone_attrs,
-};
+NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(rgb_zones);
=20
 /*
  * LED Brightness (Global)
@@ -410,7 +405,7 @@ static int alienfx_probe(struct platform_device *pdev)
 }
=20
 static const struct attribute_group *alienfx_groups[] =3D {
-	&zone_attribute_group,
+	&rgb_zones_group,
 	WMAX_DEV_GROUPS
 	NULL
 };
diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platf=
orm/x86/dell/alienware-wmi-wmax.c
index 0c3be03385f8..559415849bcc 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -13,6 +13,7 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_profile.h>
+#include <linux/sysfs.h>
 #include <linux/wmi.h>
 #include "alienware-wmi.h"
=20
@@ -356,7 +357,7 @@ static bool hdmi_group_visible(struct kobject *kobj)
 {
 	return alienware_interface =3D=3D WMAX && alienfx->hdmi_mux;
 }
-DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(hdmi);
+DEFINE_SYSFS_GROUP_VISIBILITY(hdmi);
=20
 static struct attribute *hdmi_attrs[] =3D {
 	&dev_attr_cable.attr,
@@ -404,7 +405,7 @@ static bool amplifier_group_visible(struct kobject *kob=
j)
 {
 	return alienware_interface =3D=3D WMAX && alienfx->amplifier;
 }
-DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(amplifier);
+DEFINE_SYSFS_GROUP_VISIBILITY(amplifier);
=20
 static struct attribute *amplifier_attrs[] =3D {
 	&dev_attr_status.attr,
@@ -475,7 +476,7 @@ static bool deepsleep_group_visible(struct kobject *kob=
j)
 {
 	return alienware_interface =3D=3D WMAX && alienfx->deepslp;
 }
-DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(deepsleep);
+DEFINE_SYSFS_GROUP_VISIBILITY(deepsleep);
=20
 static struct attribute *deepsleep_attrs[] =3D {
 	&dev_attr_deepsleep.attr,
--=20
2.43.0


