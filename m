Return-Path: <linux-pci+bounces-7154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175168BDFA5
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C132DB24729
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17517150991;
	Tue,  7 May 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Epb6r02H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0D14EC6E;
	Tue,  7 May 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077573; cv=none; b=ARJlkfmonHIvtTRcIK7D8VjavSYMy8kYPUW5ZxcT9Y0MMdc5dq68yXWAe3uyY/A5TaBEGLsTfyhfA9Yn/1WS3VOQNo7igR14UMZ4Zu7OWjT4FiMyunU5/A8wF9QiAtVf/EKpfi4YQOE1562nlk9pKABnLmcxXxKKg2ZyKO1DR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077573; c=relaxed/simple;
	bh=0pOejR4b1nnv+vutW3rPvxAwbOICY8dGGQ7kTWbPnwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJLzGVpFn2nYpPkVRhq9Iz7jsjrfQt2NDnXSbZAwimIfyuzg6+wrWqfD87HzGutA0WMvsNzXiswMusoqEg0uZe3GIPfGn1biJ8tGjIIqyqjN09jD7//3ZE7KM4l/PZ6zb0cS2lPOgSJ27DGrCWfUYrahFtixGgDWmgSd7fVW0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Epb6r02H; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715077572; x=1746613572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0pOejR4b1nnv+vutW3rPvxAwbOICY8dGGQ7kTWbPnwo=;
  b=Epb6r02HCavWcDolNFTcklydn7pJRjjf2dRtg+7D1YsXvZPw+J0XhTg8
   RPhvO7Xh6MatfjK5NU6fSNbh/vXr8VNAd7kAprYY/T7XFBiuAH36aOhzd
   sPD5GvWiP9hWm9AfahL3U/MN8EAllTVCozDBKgjrTnI+z+ns/7J/u8nGy
   9t8ea/ZJa659HVMWs+aR7a8iMqlkt5CjGxh4gAYwl4j+fhMiUvXkOMV6j
   Gi3zDS1LCk+NzzMAjtUM0gp6U3jG8pyUijNRBOOV89pSP9EZDsWo0neGr
   /FoxG2NPGmueDN1x3u1qBlulokIAJQksb8/8SHSmc8pojLqQ7Qc70TCxW
   A==;
X-CSE-ConnectionGUID: 5eP9nW5EThqzPWOZ0ZG5xw==
X-CSE-MsgGUID: 1/v+zRgUTI6vas3MO+EXZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="14647108"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="14647108"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:11 -0700
X-CSE-ConnectionGUID: Sj6dYPp+THiCZ04++GKnvg==
X-CSE-MsgGUID: ULSpPTdrSRKZkllcY+5eFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="29059922"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:06 -0700
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
Subject: [PATCH v3 3/8] resource: Document find_resource_space() and resource_constraint
Date: Tue,  7 May 2024 13:25:18 +0300
Message-Id: <20240507102523.57320-4-ilpo.jarvinen@linux.intel.com>
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

Document find_resource_space() and the struct resource_constraint as
they are going to be exposed outside of resource.c.

Tested-by: Lidong Wang <lidong.wang@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 kernel/resource.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index e163e0a8f2f8..3f15a32d9c42 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -48,7 +48,19 @@ struct resource iomem_resource = {
 };
 EXPORT_SYMBOL(iomem_resource);
 
-/* constraints to be met while allocating resources */
+/**
+ * struct resource_constraint - constraints to be met while searching empty
+ *				resource space
+ * @min:		The minimum address for the memory range
+ * @max:		The maximum address for the memory range
+ * @align:		Alignment for the start address of the empty space
+ * @alignf:		Additional alignment constraints callback
+ * @alignf_data:	Data provided for @alignf callback
+ *
+ * Contains the range and alignment constraints that have to be met during
+ * find_resource_space(). @alignf can be NULL indicating no alignment beyond
+ * @align is necessary.
+ */
 struct resource_constraint {
 	resource_size_t min, max, align;
 	resource_size_t (*alignf)(void *, const struct resource *,
@@ -686,8 +698,19 @@ next:		if (!this || this->end == root->end)
 	return -EBUSY;
 }
 
-/*
- * Find empty space in the resource tree given range and alignment.
+/**
+ * find_resource_space - Find empty space in the resource tree
+ * @root:	Root resource descriptor
+ * @new:	Resource descriptor awaiting an empty resource space
+ * @size:	The minimum size of the empty space
+ * @constraint:	The range and alignment constraints to be met
+ *
+ * Finds an empty space under @root in the resource tree satisfying range and
+ * alignment @constraints.
+ *
+ * Return:
+ * * %0		- if successful, @new members start, end, and flags are altered.
+ * * %-EBUSY	- if no empty space was found.
  */
 static int find_resource_space(struct resource *root, struct resource *new,
 			       resource_size_t size,
-- 
2.39.2


