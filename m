Return-Path: <linux-pci+bounces-26594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCF3A9970D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2977AA727
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4028DF1C;
	Wed, 23 Apr 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijI5Bs2y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6D28D826;
	Wed, 23 Apr 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430655; cv=none; b=FJysrOLpJ5Zf8+6vY5V9cmaQhUgDX8h33C/XDBBeVS1oE7+3TyZfmJ9nouDWSaH5MGJ2UiEJOvQ/zKp3oqtrbSuPAYZ01CRM2ZFZwwAQHCdFvGDolXNj8xRFrOveeZxZp9TTb99ToU+JjZSDFKHjw+OJ2SmDDchlXyyZo44uDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430655; c=relaxed/simple;
	bh=IJCyRhnBl/jq8ICFiPmQRSjel5Gqz/wB2SAcG7SGuTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEF1ziNqKikJJgVSzL1R8Z4MC+wlJVzjLE5fL/n6v289rDY5mFNcMgMIA8wXG8Y+j2OPGvUHTP52SSU5sRXZ0gCgp0B+SN8SH6VaROYvLhoLojah2GSWS1tYytgXdp6zCs41n/3gXdQ1tFk2S8d0vpJDUFGEO+ePp2AbnuhDlbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijI5Bs2y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745430653; x=1776966653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJCyRhnBl/jq8ICFiPmQRSjel5Gqz/wB2SAcG7SGuTU=;
  b=ijI5Bs2yRe42iEeYQe8KyfDmovTappy5+nE8jRknXWFzradmdswjz2EP
   4nUQYXhkkj1TnyIkRgawAzQOETeJXpzjnh7857mYkcB+0SkVI7Z0SnLHf
   jIPMmK+ON+DTLhOLoLAIfJouW2OySN+k2GE2KGldeWECN3cRmLc0BZp9B
   BjTN2V+PhWD7isQq3dfchPX6HiFHwN+CInt7SJsBUMBNqDckTBxHzxx3M
   q3zWIkyyIFYSH97BymiLawAUFNps66iHA6ChTiN5TNIrqaL8Dacey8+dE
   8IfwNCIaQDdDV+mivdEozTR8MxY7XQHYqnw3i3C7po72fkdEw31udxFYz
   g==;
X-CSE-ConnectionGUID: Ov0x0mhxRh2EhHNKOOJM2Q==
X-CSE-MsgGUID: PWcvIQMWQzqdXPGPD2/aPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47168334"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47168334"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:51 -0700
X-CSE-ConnectionGUID: 485ZsBaRRHeCIEPewcWQNQ==
X-CSE-MsgGUID: BQw05VOXTYqOkMhR2d36PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163350466"
Received: from ldmartin-desk2.corp.intel.com (HELO debox1-desk4.lan) ([10.125.111.241])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:51 -0700
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
Subject: [PATCH 3/7] docs: sysfs.rst: document additional attribute group macros
Date: Wed, 23 Apr 2025 10:50:33 -0700
Message-ID: <20250423175040.784680-4-david.e.box@linux.intel.com>
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

Add documentation to Documentation/filesystems/sysfs.rst for several sysfs
helper macros, including recently introduced and previously undocumented
helpers.

Document the following macros:

	__ATTR_IGNORE_LOCKDEP
	DEFINE_SYSFS_GROUP_VISIBILITY
	DEFINE_SYSFS_BIN_GROUP_VISIBILITY
	DEFINE_SYSFS_BIN_GROUP_COMBO_VISIBILITY
	ATTRIBUTE_GROUPS
	BIN_ATTRIBUTE_GROUPS
	NAMED_ATTRIBUTE_GROUP_VISIBLE
	NAMED_ATTRIBUTE_GROUPS_VISIBLE
	NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE
	NAMED_ATTRIBUTE_GROUPS_COMBO_VISIBLE

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 Documentation/filesystems/sysfs.rst | 244 ++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystem=
s/sysfs.rst
index c32993bc83c7..16bcc3e7c80c 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -147,6 +147,250 @@ __ATTR_RW(name):
 __ATTR_NULL:
 	         which sets the name to NULL and is used as end of list
                  indicator (see: kernel/workqueue.c)
+__ATTR_IGNORE_LOCKDEP(name, mode, show, store):
+                 like __ATTR() but disables lockdep checks; used in cases
+                 where lockdep may emit false positives
+
+Additional Attribute Helpers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+ATTRIBUTE_GROUPS(name):
+       Convenience macro to create an array of attribute group pointers.
+
+Example::
+
+    static struct attribute *foo_attrs[] =3D {
+            &attr1.attr,
+            &attr2.attr,
+            NULL
+    };
+    ATTRIBUTE_GROUPS(foo);
+
+BIN_ATTRIBUTE_GROUPS(name):
+        Same as ATTRIBUTE_GROUPS(), but for bin_attribute_group structures.
+
+Example::
+
+    static struct bin_attribute *foo_attrs[] =3D {
+            &bin_attr1.attr,
+            &bin_attr2.attr,
+            NULL
+    };
+    BIN_ATTRIBUTE_GROUPS(bin_foo);
+
+DEFINE_SYSFS_GROUP_COMBO_VISIBILITY(name):
+        A helper macro to pair with the assignment of
+
+                ".is_visible =3D SYSFS_GROUP_VISIBLE(name)",
+
+        that arranges for the directory associated with a named attribute_=
group
+        to optionally be hidden.  This allows for static declaration of
+        attribute_groups, and the simplification of attribute visibility
+        lifetime that implies, without polluting sysfs with empty attribute
+        directories.
+
+Example::
+
+    static umode_t example_attr_visible(struct kobject *kobj,
+                                        struct attribute *attr, int n)
+    {
+            if (example_attr_condition)
+                    return 0;
+            if (ro_attr_condition)
+                    return 0444;
+            return a->mode;
+    }
+
+    static bool example_group_visible(struct kobject *kobj)
+    {
+            if (example_group_condition)
+                    return false;
+            return true;
+    }
+
+    DEFINE_SYSFS_GROUP_COMBO_VISIBILITY(example);
+
+    static struct attribute_group example_group =3D {
+            .name =3D "example",
+            .is_visible =3D SYSFS_GROUP_VISIBLE(example),
+            .attrs =3D &example_attrs,
+    };
+
+Note that it expects <name>_attr_visible and <name>_group_visible to
+be defined. For cases where individual attributes do not need
+separate visibility consideration, only entire group visibility at
+once, see DEFINE_SYSFS_GROUP_VISIBILITY().
+
+DEFINE_SYSFS_GROUP_VISIBILITY(name):
+        A helper macro to pair with SYSFS_GROUP_VISIBLE() that, like
+        DEFINE_SYSFS_GROUP_COMBO_VISIBILITY(), controls group visibility, =
but
+        does not require the implementation of a per-attribute visibility
+        callback.
+
+Example::
+
+    static bool example_group_visible(struct kobject *kobj)
+    {
+            if (example_group_condition)
+                    return false;
+            return true;
+    }
+
+    DEFINE_SYSFS_GROUP_VISIBILITY(example);
+
+    static struct attribute_group example_group =3D {
+            .name =3D "example",
+            .is_visible =3D SYSFS_GROUP_VISIBLE(example),
+            .attrs =3D &example_attrs,
+    };
+
+DEFINE_SYSFS_BIN_GROUP_COMBO_VISIBILITY(name):
+DEFINE_SYSFS_BIN_GROUP_VISIBILITY(name):
+        Same as DEFINE_SYSFS_GROUP_VISIBILITY(), but for groups with only =
binary
+        attributes. If an attribute_group defines both text and binary
+        attributes, the group visibility is determined by the function
+        specified to is_visible() not is_bin_visible().
+
+Named Attribute Group Macros (with visibility)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+These macros define struct attribute_group objects with a static name and
+visibility function(s). They are useful for creating named directories in =
sysfs
+where individual attributes can be conditionally exposed.
+
+NAMED_ATTRIBUTE_GROUP_VISIBLE(name):
+        Defines an attribute group with a fixed directory name (matching n=
ame)
+        with a group visibility function. Expects an attribute array
+        <name>_attrs. The macro automatically defines the visibility funct=
ion.
+
+Example::
+
+    static ssize_t foo_show(struct device *dev, struct device_attribute *a=
ttr,
+                            char *buf)
+    {
+            ...
+    }
+
+    static ssize_t foo_store(struct device *dev, struct device_attribute *=
attr,
+                             const char *buf, size_t count)
+    {
+            ...
+    }
+    static DEVICE_ATTR_RW(foo);
+
+    static bool bar_group_visible(struct kobject *kobj)
+    {
+            if (bar_group_condition)
+                    return false;
+            return true;
+    }
+
+    static struct attribute *bar_attrs[] =3D {
+            &dev_attr_foo.attr,
+            NULL
+    };
+    NAMED_ATTRIBUTE_GROUP_VISIBLE(bar);
+
+Creates::
+
+    static const struct attribute_group bar_group =3D {
+            .name =3D "bar",
+            .attrs =3D bar_attrs,
+            .is_visible =3D SYSFS_GROUP_VISIBLE(bar),
+    };
+
+    /*
+     * Where SYSFS_GROUP_VISIBLE(bar) is a function created by
+     * DEFINE_SYSFS_GROUP_VISIBILITY(bar) that calls bar_group_visible().
+     */
+
+NAMED_ATTRIBUTE_GROUPS_VISIBLE(name):
+        Like NAMED_ATTRIBUTE_GROUP_VISIBLE(), defines the visible attribute
+        group but also creates the group list <name>_groups[].
+
+Example::
+
+    ...
+
+    static struct attribute *bar_attrs[] =3D {
+            &attr1.attr,
+            &attr2.attr,
+            NULL
+    };
+    NAMED_ATTRIBUTE_GROUPS_VISIBLE(bar);
+
+Creates::
+
+    static const struct attribute_group bar_group =3D {
+            .name =3D "bar",
+            .attrs =3D bar_attrs,
+            .is_visible =3D SYSFS_GROUP_VISIBLE(bar),
+    };
+
+    static const struct attribute_group *bar_groups[] =3D {
+            &bar_group,
+            NULL
+    };
+
+NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(name):
+        Same as NAMED_ATTRIBUTE_GROUP_VISIBLE(), but uses the "combo" visi=
bility
+        variant to support both group and per-attribute visibility control.
+        Automatically generates the combo visibility boilerplate.
+
+Example::
+
+    static ssize_t foo_show(struct device *dev, struct device_attribute *a=
ttr,
+                            char *buf)
+    {
+            ...
+    }
+
+    static ssize_t foo_store(struct device *dev, struct device_attribute *=
attr,
+                             const char *buf, size_t count)
+    {
+            ...
+    }
+    static DEVICE_ATTR_RW(foo);
+
+    static umode_t foo_attr_visible(struct kobject *kobj,
+                                    struct attribute *attr, int n)
+    {
+            if (example_attr_condition)
+                    return 0;
+            return attr->mode;
+    }
+
+    static bool foo_group_visible(struct kobject *kobj)
+    {
+            if (foo_group_condition)
+                    return false;
+            return true;
+    }
+
+    static struct attribute *foo_attrs[] =3D {
+            &dev_attr_foo.attr,
+            NULL
+    };
+    NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(foo);
+
+Creates::
+
+    static const struct attribute_group foo_group =3D {
+            .name =3D "foo",
+            .attrs =3D foo_attrs,
+            .is_visible =3D SYSFS_GROUP_VISIBLE(foo),
+    };
+
+    /*
+     * Where SYSFS_GROUP_VISIBLE(foo) is a function created by
+     * DEFINE_SYSFS_GROUP_COMBO_VISIBILITY(foo) that calls foo_group_visib=
le()
+     * and foo_attr_visible().
+     */
+
+NAMED_ATTRIBUTE_GROUPS_COMBO_VISIBLE(name):
+        Like NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE() defines the attribute g=
roup,
+        supporting both group and per-attribute visibility control, but al=
so
+        creates the group list <name>_groups[].
=20
 Subsystem-Specific Callbacks
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--=20
2.43.0


