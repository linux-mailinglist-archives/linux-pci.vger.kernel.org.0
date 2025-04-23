Return-Path: <linux-pci+bounces-26596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF349A9971A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776D54A24A4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71BC28F523;
	Wed, 23 Apr 2025 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPooBr7l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385F28D85D;
	Wed, 23 Apr 2025 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430656; cv=none; b=rZUo1Ub18D4EsR/nnpHyTqM1ZzwtAl1+DI83ku6nIQZrxiyXNKP7zMa/3u2jJFMN5nPxz8DM5B9P+MCrFJX1VjTw4eLohkFeAlqt0+HSuKYB5f6i+1W1PtnOn5dqFBJhKuWJm1PZQSo4UNBN+NVtOgDRcsbAMCp6NhmXiiFFRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430656; c=relaxed/simple;
	bh=pspP0LoaB25ewweJpkQNKt1iGCUbJ6t/mkm9l0BSOVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxfuWen+cTAwU+6hcvZlLK9iS5Fe4kGW5VVn4hdI6pgWWXncKiMTtNbOhlX5HcTs7X6H+rvKbDlhBfo3LQ4VnOe49wp2y9EL1Nx5DyBOVMEvEIIJR14cvf2fH5QjdiSO743aZZT2Ijbd7SJ4Ihw41HTKvN5NhOvzAsx/idxmx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPooBr7l; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745430655; x=1776966655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pspP0LoaB25ewweJpkQNKt1iGCUbJ6t/mkm9l0BSOVU=;
  b=IPooBr7lFf1+faR8WHphNIrnWXXxlevJ6tDgrQihw1kqjyUC3+V3Pst0
   W5HhhMMiYCIZ2okCl1jkhGF6F0tm3K1Bwo0cuJvd+gcKH9G9X9a0wG8Xh
   X3q7ZvP8BtJRVSRoOhkvqwcyXUC/7eXzHYBKcUe536lqDj4EP1nX7iWAX
   Xbq1yPdL7zrM3CqFfgo19iKvxMM4/8xXEamfxk5w6x9LGMM8K8a8Na9vq
   3Fff/hPHxdxWB+j/FwqJZz8ToLbOQxOFNVb9Ore50yEwlyKzv/X4uSfON
   SMsZKtygw0V+V0K9PSl9Ti7uxoZ0mw9Sf55jupDn/mP1uIBhHELQOYrKR
   w==;
X-CSE-ConnectionGUID: I9ztMGPQRP6foR41NcRO3w==
X-CSE-MsgGUID: y9s1ZnT5R2ODGOWmE3v0Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47168352"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47168352"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:52 -0700
X-CSE-ConnectionGUID: xwHH6O9mSkq8biLXi0V1ig==
X-CSE-MsgGUID: H3DH1ZQyT1+9xMampYd3Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163350474"
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
Subject: [PATCH 5/7] soundwire: sysfs: Use ATTRIBUTE_GROUP_VISIBLE()
Date: Wed, 23 Apr 2025 10:50:35 -0700
Message-ID: <20250423175040.784680-6-david.e.box@linux.intel.com>
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

Replace the manual definition of the dp0 attribute group with the newly
introduced ATTRIBUTE_GROUP_VISIBLE() macro, simplifying the code and
improving maintainability.

Consolidate the definition of dp0_attrs and move the attribute array above
the macro so that they are visibly tied together.  While here, also remove
the unneeded trailing comma after NULL at the end of all attribute arrays.
No functional changes are intended.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/soundwire/sysfs_slave.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slav=
e.c
index c5c22d1708ec..400f2a17f140 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -103,7 +103,7 @@ static DEVICE_ATTR_RO(modalias);
=20
 static struct attribute *slave_attrs[] =3D {
 	&dev_attr_modalias.attr,
-	NULL,
+	NULL
 };
=20
 static const struct attribute_group slave_attr_group =3D {
@@ -126,7 +126,7 @@ static struct attribute *slave_dev_attrs[] =3D {
 	&dev_attr_master_count.attr,
 	&dev_attr_source_ports.attr,
 	&dev_attr_sink_ports.attr,
-	NULL,
+	NULL
 };
=20
 static const struct attribute_group sdw_slave_dev_attr_group =3D {
@@ -170,16 +170,6 @@ static ssize_t words_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(words);
=20
-static struct attribute *dp0_attrs[] =3D {
-	&dev_attr_max_word.attr,
-	&dev_attr_min_word.attr,
-	&dev_attr_words.attr,
-	&dev_attr_BRA_flow_controlled.attr,
-	&dev_attr_simple_ch_prep_sm.attr,
-	&dev_attr_imp_def_interrupts.attr,
-	NULL,
-};
-
 static umode_t dp0_attr_visible(struct kobject *kobj, struct attribute *at=
tr,
 			      int n)
 {
@@ -198,19 +188,23 @@ static bool dp0_group_visible(struct kobject *kobj)
 		return true;
 	return false;
 }
-DEFINE_SYSFS_GROUP_VISIBLE(dp0);
=20
-static const struct attribute_group dp0_group =3D {
-	.attrs =3D dp0_attrs,
-	.is_visible =3D SYSFS_GROUP_VISIBLE(dp0),
-	.name =3D "dp0",
+static struct attribute *dp0_attrs[] =3D {
+	&dev_attr_max_word.attr,
+	&dev_attr_min_word.attr,
+	&dev_attr_words.attr,
+	&dev_attr_BRA_flow_controlled.attr,
+	&dev_attr_simple_ch_prep_sm.attr,
+	&dev_attr_imp_def_interrupts.attr,
+	NULL
 };
+NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(dp0);
=20
 const struct attribute_group *sdw_attr_groups[] =3D {
 	&slave_attr_group,
 	&sdw_slave_dev_attr_group,
 	&dp0_group,
-	NULL,
+	NULL
 };
=20
 /*
@@ -249,7 +243,7 @@ static DEVICE_ATTR_RO(device_number);
 static struct attribute *slave_status_attrs[] =3D {
 	&dev_attr_status.attr,
 	&dev_attr_device_number.attr,
-	NULL,
+	NULL
 };
=20
 /*
--=20
2.43.0


