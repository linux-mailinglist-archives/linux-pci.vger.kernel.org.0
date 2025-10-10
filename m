Return-Path: <linux-pci+bounces-37814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7EBCD96A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854F9540734
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806C32F5A33;
	Fri, 10 Oct 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIN/0eVm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E72F6560;
	Fri, 10 Oct 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107394; cv=none; b=QPWrXKbTnEWteqYCYOOfcJdY0e72aBfKmRPmoua0FzSIVJxFBL9DkENoO1eAUCrtIpBeEjXKRq7l4skEQThItuZxdL+CvNnJra1njFfB/Ai7R32Wjm4b47VOp0c2GoZlJFfxIgSUkK4b2PFK0pUShJxGdLt3EPihrlH+9Xyt2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107394; c=relaxed/simple;
	bh=c553U0H/z/bCC1272Ow+lGztpoU5p2QncIMSPsjy4ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPQxJBMVFAypIEYMTLUnlO3pZQHZD3nepCmrumfDznNg4koFJP8S1eKGlBmyVhcLROU2Jcv6aOug9GmSobMx12OYd3k5eQY0y7t4F605e5QjDTsTJf7RdmuNa7H0zF3DthLztIfnghRQL+p5HqpVbPxvkqSJ/20PUZsDAkPkG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIN/0eVm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760107393; x=1791643393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c553U0H/z/bCC1272Ow+lGztpoU5p2QncIMSPsjy4ZE=;
  b=oIN/0eVmqYUOLflRWIjAMJ8Xcb60US8agfZHbIgBnGWbRMS6gUtLQxph
   sNuibTz+RBb6ubboWvbze6L43SgS/R/yzNa85SGMWI1PtCNCnhiM+6jvd
   jkQ2KIZgkNPSUmKZFOB7GSARY3QfSVSUjXTHQNwacU/z0I274/lNwah5P
   lW/OyvClZpkQ/YlqEZOXMDb5NA9qKSTD1RdjtvVk20ltolRexZDW4D7SI
   2toV4JFjHFUNtmzq93NP7dj6jC3epCY0UdE42+10FBwfwqVdbIY/zvoBc
   KlCtcOQDE8zqlOW2ahegICMtb656ALa4+Rx3v1KVmEOum/CzrKJK5BRKT
   A==;
X-CSE-ConnectionGUID: PLGsdZ4YQEeF/x+IyCMpZw==
X-CSE-MsgGUID: YDtS+YD2Rq+7haJ50pNS/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62370447"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="62370447"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 07:43:12 -0700
X-CSE-ConnectionGUID: tGwq278OQfq3lgEiZFUNig==
X-CSE-MsgGUID: wgBjgDyXQpSXs5xcsVyFtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180574092"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 07:43:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] resource, kunit: add test case for resource_coalesce()
Date: Fri, 10 Oct 2025 17:42:31 +0300
Message-Id: <20251010144231.15773-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test case for resource_coalesce() which has both parent and
children resources to adjust.

Add framework to build resource trees in a human-readable way and to
verify them which could be used to kunit test also other resource tree
manipulation functions.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/ioport.h  |   5 ++
 kernel/resource.c       |   8 ++-
 kernel/resource_kunit.c | 121 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..56f4d1cfde29 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -426,5 +426,10 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
 
 extern struct address_space *iomem_get_mapping(void);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int resource_coalesce(struct resource *res, struct resource *next_res,
+		      struct resource *new_res);
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index c6e1872abb78..f7e7b49dc9a4 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -10,6 +10,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/visibility.h>
+
 #include <linux/cleanup.h>
 #include <linux/export.h>
 #include <linux/errno.h>
@@ -299,8 +301,9 @@ static bool resource_mergeable(struct resource *r1, struct resource *r2)
 	return false;
 }
 
-static int resource_coalesce(struct resource *res, struct resource *next_res,
-			     struct resource *new_res)
+VISIBLE_IF_KUNIT int resource_coalesce(struct resource *res,
+				       struct resource *next_res,
+				       struct resource *new_res)
 {
 	struct resource *parent, *tmp;
 	struct resource **p, **c;
@@ -367,6 +370,7 @@ static int resource_coalesce(struct resource *res, struct resource *next_res,
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(resource_coalesce);
 
 /**
  * request_resource_conflict - request and reserve an I/O or memory resource
diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index b8ef75b99eb2..3b5d09bb612a 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -4,6 +4,8 @@
  */
 
 #include <kunit/test.h>
+
+#include <linux/array_size.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -20,6 +22,16 @@
 #define R3_END		0x789a
 #define R4_START	0x2000
 #define R4_END		0x7000
+#define  R4A_START	0x2000
+#define  R4A_END	0x3000
+#define  R4B_START	0x3001
+#define  R4B_END	0x4000
+#define R5_START	0x7001
+#define R5_END		0x8000
+#define  R5A_START	0x7001
+#define  R5A_END	0x7800
+#define  R5B_START	0x7801
+#define  R5B_END	0x7c00
 
 static struct resource r0 = { .start = R0_START, .end = R0_END };
 static struct resource r1 = { .start = R1_START, .end = R1_END };
@@ -34,6 +46,11 @@ struct result {
 	bool ret;
 };
 
+struct resource_tree_def {
+	struct resource r;
+	unsigned int parent, child, sibling;
+};
+
 static struct result results_for_union[] = {
 	{
 		.r1 = &r1, .r2 = &r0, .r.start = R0_START, .r.end = R0_END, .ret = true,
@@ -139,6 +156,107 @@ static void resource_test_intersection(struct kunit *test)
 	} while (++i < ARRAY_SIZE(results_for_intersection));
 }
 
+static struct resource *copy_resource_tree(struct kunit *test,
+					   struct resource_tree_def *def,
+					   size_t len, size_t extra)
+{
+	struct resource *tree;
+	unsigned int i;
+
+	tree = kunit_kcalloc(test, len + extra, sizeof(*tree), GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, tree);
+
+	for (i = 0; i < len; i++) {
+		tree[i] = def[i].r;
+
+		if (def[i].parent)
+			tree[i].parent = &tree[def[i].parent];
+		if (def[i].child)
+			tree[i].child = &tree[def[i].child];
+		if (def[i].sibling)
+			tree[i].sibling = &tree[def[i].sibling];
+	}
+
+	return tree;
+}
+
+static void resource_do_test_tree(struct kunit *test, struct resource *tree,
+				  struct resource_tree_def *exp_tree,
+				  size_t len)
+{
+	unsigned int link, i;
+
+	for (i = 0; i < len; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, tree[i].start, exp_tree[i].r.start,
+				    "Start elements for resource %u are not equal", i);
+		KUNIT_EXPECT_EQ_MSG(test, tree[i].end, exp_tree[i].r.end,
+				    "End elements for resource %u are not equal", i);
+
+		link = tree[i].parent ? tree[i].parent - &tree[0] : 0;
+		KUNIT_EXPECT_EQ_MSG(test, link, exp_tree[i].parent,
+				    "Parent link for resource %u is not equal", i);
+
+		link = tree[i].child ? tree[i].child - &tree[0] : 0;
+		KUNIT_EXPECT_EQ_MSG(test, link, exp_tree[i].child,
+				    "Child link for resource %u is not equal", i);
+
+		link = tree[i].sibling ? tree[i].sibling - &tree[0] : 0;
+		KUNIT_EXPECT_EQ_MSG(test, link, exp_tree[i].sibling,
+				    "Sibling link for resource %u is not equal", i);
+	}
+}
+
+struct resource_tree_def resource_test_tree[8] = {
+	/* [0] is empty intentionally. */
+	[1] = { .r.start = R0_START, .r.end = R0_END, .child = 2 },
+	[2] = { .r.start = R4_START, .r.end = R4_END, .parent = 1, .sibling = 3, .child = 4 },
+	[3] = { .r.start = R5_START, .r.end = R5_END, .parent = 1, .child = 6 },
+	[4] = { .r.start = R4A_START, .r.end = R4A_END, .parent = 2, .sibling = 5 },
+	[5] = { .r.start = R4B_START, .r.end = R4B_END, .parent = 2 },
+	[6] = { .r.start = R5A_START, .r.end = R5A_END, .parent = 3, .sibling = 7 },
+	[7] = { .r.start = R5B_START, .r.end = R5B_END, .parent = 3 },
+};
+
+struct resource_tree_def result_for_coalesce_2_and_3[9] = {
+	/* [0] is empty intentionally. */
+	[1] = { .r.start = R0_START, .r.end = R0_END, .child = 8 },
+	[2] = { .r.start = R4_START, .r.end = R4_END },
+	[3] = { .r.start = R5_START, .r.end = R5_END },
+	[4] = { .r.start = R4A_START, .r.end = R4A_END, .parent = 8, .sibling = 5 },
+	[5] = { .r.start = R4B_START, .r.end = R4B_END, .parent = 8, .sibling = 6 },
+	[6] = { .r.start = R5A_START, .r.end = R5A_END, .parent = 8, .sibling = 7 },
+	[7] = { .r.start = R5B_START, .r.end = R5B_END, .parent = 8 },
+	[8] = { .r.start = R4_START, .r.end = R5_END, .parent = 1, .child = 4 },
+};
+
+static void resource_test_tree_test_harness(struct kunit *test)
+{
+	struct resource *tree;
+
+	tree = copy_resource_tree(test, resource_test_tree,
+				  ARRAY_SIZE(resource_test_tree), 0);
+
+	/* Sanity-check test harness with identity check */
+	resource_do_test_tree(test, tree, resource_test_tree,
+			      ARRAY_SIZE(resource_test_tree));
+}
+
+static void resource_test_coalesce(struct kunit *test)
+{
+	struct resource *tree, *result;
+	int ret;
+
+	tree = copy_resource_tree(test, resource_test_tree,
+				  ARRAY_SIZE(resource_test_tree), 1);
+
+	result = &tree[ARRAY_SIZE(resource_test_tree)];
+
+	ret = resource_coalesce(&tree[2], &tree[3], result);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	resource_do_test_tree(test, tree, result_for_coalesce_2_and_3,
+			      ARRAY_SIZE(result_for_coalesce_2_and_3));
+}
+
 /*
  * The test resource tree for region_intersects() test:
  *
@@ -292,6 +410,8 @@ static void resource_test_region_intersects(struct kunit *test)
 static struct kunit_case resource_test_cases[] = {
 	KUNIT_CASE(resource_test_union),
 	KUNIT_CASE(resource_test_intersection),
+	KUNIT_CASE(resource_test_tree_test_harness),
+	KUNIT_CASE(resource_test_coalesce),
 	KUNIT_CASE(resource_test_region_intersects),
 	{}
 };
@@ -304,3 +424,4 @@ kunit_test_suite(resource_test_suite);
 
 MODULE_DESCRIPTION("I/O Port & Memory Resource manager unit tests");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
-- 
2.39.5


