Return-Path: <linux-pci+bounces-8795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697790894D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A881C26A86
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4749194132;
	Fri, 14 Jun 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPOVNJ18"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B13F1922C1;
	Fri, 14 Jun 2024 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359591; cv=none; b=ZLVW2XgKm67Og/VtLdJyKiKYEQN7izv3DL1on0HdpuKoEA1iB1xiXLgue7FAIygqqo092WxmkAlpwgK/T+2GnBXW1GpgJzfVWJB2W0XDyX3DBoUe8H7WmUsClIYTJuPJ0VXYxNG0CxmnVGTjcutogl8+gKannrKf7qFYaVBKYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359591; c=relaxed/simple;
	bh=1v9oA92V3WbTtGsB8nsfVc3j8l6i5OSwnc8kPlM6iCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoJIHx/JqpHQdZ7WrnZnwe0jWzAsKtEkVvBabE2mclnUsPQfWCfJTXgGrz1oYdml5GYrZvhAu1MVQafEnr2rHEvKHXKO8MU5r2VZ5uvDFgYjbtMndTiuNlKfaYKCFrMwpoD5NndA9DTiUpNs2wbkHY07sR+RkwUYeQHSTU/df/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPOVNJ18; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359591; x=1749895591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1v9oA92V3WbTtGsB8nsfVc3j8l6i5OSwnc8kPlM6iCU=;
  b=mPOVNJ18ZXkYFIBQEcsjVv8QiusV5Ne53ly7Paw4lyqvcsHFe2e5C/j4
   dmPTXx6ZwCC9lbdYaWBnMHfn5Y1bLCGlXx+HqvwRNY8R4goGfAU0MQkhh
   EDN2TDaoqicgqHdG8BfiEsLGAo+Wmzp9qXweBkPlR4nDSdtZakYCsAFBd
   qm2AYP2xvjwj+tqx1QGHyP3JvNy1i5xRY0PLTB/W1lI5TYfEN1zKmfb/f
   /ORWWrITNzbeJ30lChemZsSCuj4MyTIjr+1VN2dBil4TyEDhSXcrERDXk
   gFlgY6mW0YgTFwvgay+ahi1knMXsG/iDAkcG0Aw3gcSL4eSYEWhRU4n4K
   A==;
X-CSE-ConnectionGUID: 83dMjNZfRZKK6tBzZrI/9w==
X-CSE-MsgGUID: NB+6TCAXRJmLLDZAFi3L6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="32715827"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="32715827"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:06:30 -0700
X-CSE-ConnectionGUID: yujZaWoMQ5Cd1nQnAzBzHg==
X-CSE-MsgGUID: Wq1AyD18QhWmvvsyMZIiSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45575897"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:06:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Robert Richter <rric@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/4] resource: Add resource set range and size helpers
Date: Fri, 14 Jun 2024 13:06:03 +0300
Message-Id: <20240614100606.15830-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614100606.15830-1-ilpo.jarvinen@linux.intel.com>
References: <20240614100606.15830-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Setting the end address for a resource with a given size lacks a helper
and is therefore coded manually unlike the getter side which has a
helper for resource size calculation. Also, almost all callsites that
calculate the end address for a resource also set the start address
right before it like this:

	res->start = start_addr;
	res->end = res->start + size - 1;

Thus, add resource_set_range(res, start_addr, size) that sets the start
address and calculates the end address to simplify this often repeated
fragment. In addition, introduce resource_set_size() for the cases
where setting the start address of the resource is not necessary but
mention in its kerneldoc resource_set_range() is preferred when setting
both addresses.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/ioport.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index db7fe25f3370..2a1d33ad151c 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -216,6 +216,38 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
 resource_size_t resource_alignment(struct resource *res);
+
+/**
+ * resource_set_size - Calculates resource end address from size and start address
+ * @res: The resource descriptor
+ * @size: The size of the resource
+ *
+ * Calculates the end address for @res based on @size.
+ *
+ * Note: The start address of @res must be set when calling this function.
+ * Use resource_set_range() if setting both the start address and @size.
+ */
+static inline void resource_set_size(struct resource *res, resource_size_t size)
+{
+	res->end = res->start + size - 1;
+}
+
+/**
+ * resource_set_range - Sets resource start and end addresses
+ * @res: The resource descriptor
+ * @start: The start address for the resource
+ * @size: The size of the resource
+ *
+ * Sets @res start address and calculates the end address based on @size.
+ */
+static inline void resource_set_range(struct resource *res,
+				      resource_size_t start,
+				      resource_size_t size)
+{
+	res->start = start;
+	resource_set_size(res, size);
+}
+
 static inline resource_size_t resource_size(const struct resource *res)
 {
 	return res->end - res->start + 1;
-- 
2.39.2


