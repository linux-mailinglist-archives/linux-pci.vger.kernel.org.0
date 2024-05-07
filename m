Return-Path: <linux-pci+bounces-7156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF948BDFAC
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA5A287155
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA31514D4;
	Tue,  7 May 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FK2lQARn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7021514CE;
	Tue,  7 May 2024 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077592; cv=none; b=RTMn7b93YDof1SOVhk8Tg+kvuhrGIBvB54WxUchMG3mvFtM32UjrakRQw0vbMIonBNhkwvXA4ZwiGYqlfW/Y2i0LF/aY8TrS8VxWx4MAm0Ini8NzoctJmtF5pYQdfT04sjln/ldTP7cA9AV11nIW8exxeF13Lsrvh8dun0yHaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077592; c=relaxed/simple;
	bh=jhrlnsAO2on72ucVzVfwXWvO+qQRZl2vqCOZJh3oiMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kl1uXRV29EdXJKvsDBqSEvUwXuwrBFiKAbwCiNlZPmrYh1YIVJM7h+YTzwnx7XXJvatz9NlUgdOYiHjatknOjoWs+yEr0a5u1LRbiBxBVX+egwcULO02TzEu12Zt4/a0zFgrGPrM+56wdx/Ln1axMbFJkYxV6YiPGbmKwryjwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FK2lQARn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715077591; x=1746613591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhrlnsAO2on72ucVzVfwXWvO+qQRZl2vqCOZJh3oiMM=;
  b=FK2lQARn2xQ2XyzLbVldkK6h4TrsPJqgx1Ji0b3sgZugQzUitpYPz7Mg
   JIjJYcwN8X358FMSNyIAKiTz9wZHJNHFozhLCQoY1WllnaVd4xy3oYoCC
   e8kPUZX7CPsJALVzWm9GVYj/1sddcMifcoJ0NYPlzDcDGw7gnc0tqdrAk
   9yaPhqErl4k8lB+XdjbIqVCQuUqnjOgt5TGJ9oacUCwKbf7Ka4RRPM08Q
   dPKopHaixa0bnWVM7a+3Maf/ybi2dca2tfXkjRWAzt1mohu/5F/WJCV46
   q5SJomSuV67CHm3Rthm0T874mAnAQC//nzWeD+JghXrZ6nUSWoG40FJIz
   g==;
X-CSE-ConnectionGUID: 5ZAvAdcYTCC8t+F+6lezxA==
X-CSE-MsgGUID: CEmjIZjhRkexCOULksqFWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10987099"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="10987099"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:31 -0700
X-CSE-ConnectionGUID: xSn39xCiSA2h6foBR1GuKg==
X-CSE-MsgGUID: pkjZ2lTuTfGeJVsfy8vKew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="28535561"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lidong Wang <lidong.wang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/8] resource: Handle simple alignment inside __find_resource_space()
Date: Tue,  7 May 2024 13:25:20 +0300
Message-Id: <20240507102523.57320-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
References: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

allocate_resource() accepts ->alignf() callback to perform custom
alignment beyond constraint->align. If alignf is NULL,
simple_align_resource() is used which only returns avail->start (no
change).

Using avail->start directly is natural and can be done with a
conditional in __find_resource_space() instead which avoids
unnecessarily using callback. It makes the code inside
__find_resource_space() more obvious and removes the need for the
caller to provide constraint->alignf unnecessarily.

This is preparation for exporting find_resource_space().

Tested-by: Lidong Wang <lidong.wang@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 kernel/resource.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 26ad6f223652..35c44c23b037 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -621,14 +621,6 @@ void __weak arch_remove_reservations(struct resource *avail)
 {
 }
 
-static resource_size_t simple_align_resource(void *data,
-					     const struct resource *avail,
-					     resource_size_t size,
-					     resource_size_t align)
-{
-	return avail->start;
-}
-
 static void resource_clip(struct resource *res, resource_size_t min,
 			  resource_size_t max)
 {
@@ -648,6 +640,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 {
 	struct resource *this = root->child;
 	struct resource tmp = *new, avail, alloc;
+	resource_alignf alignf = constraint->alignf;
 
 	tmp.start = root->start;
 	/*
@@ -676,8 +669,12 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 		avail.flags = new->flags & ~IORESOURCE_UNSET;
 		if (avail.start >= tmp.start) {
 			alloc.flags = avail.flags;
-			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
-					size, constraint->align);
+			if (alignf) {
+				alloc.start = alignf(constraint->alignf_data,
+						     &avail, size, constraint->align);
+			} else {
+				alloc.start = avail.start;
+			}
 			alloc.end = alloc.start + size - 1;
 			if (alloc.start <= alloc.end &&
 			    resource_contains(&avail, &alloc)) {
@@ -788,9 +785,6 @@ int allocate_resource(struct resource *root, struct resource *new,
 	int err;
 	struct resource_constraint constraint;
 
-	if (!alignf)
-		alignf = simple_align_resource;
-
 	constraint.min = min;
 	constraint.max = max;
 	constraint.align = align;
-- 
2.39.2


