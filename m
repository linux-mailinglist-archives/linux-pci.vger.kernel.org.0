Return-Path: <linux-pci+bounces-1296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34A681CA01
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA25B2508D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D7310A0D;
	Fri, 22 Dec 2023 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXXrO801"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C218026;
	Fri, 22 Dec 2023 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703248189; x=1734784189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SPf7dIwu/u/tUoIaF73pw1QNlo/ef/Z/+GNbum46mDI=;
  b=JXXrO801MSdlKvcv99uRptsPnECD/eb/2tit8Cuquf9hTi9zMhTSYRaB
   +5n2Et2pIGDvsmov0XVqkWBQvygk80VzhU/CHFSaCS7oIaAyl1UvZDw39
   cgI38674OliU7h9RlM7LI/xDCb0ofY54w9tKio4eqsC2V6rCOGPwmPpfB
   TDOraIWJjCeX8BuHuRnEmaQF49gzeaEtrm58Zwg8odGYNpo9IoUCl+x9C
   rhT/816JCeWNYoAPm/X+ZYYmUcCBd57aeQAD25UYa4SNfRr1NWwiRJu7L
   iPffobaqNuCBRgTjoDxkm36G2mq/EpOcWf3yKyZSDd8tmNCAwAtTOriQI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3195422"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="3195422"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:29:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="950263970"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="950263970"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.105])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:29:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/7] resource: Document find_empty_resource_slot() and resource_constraint
Date: Fri, 22 Dec 2023 14:28:57 +0200
Message-Id: <20231222122901.49538-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document find_empty_resource_slot() and the struct resource_constraint
as they are going to be exposed outside of resource.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 kernel/resource.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 94f67005e1e2..ed4bb8ad701a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -46,7 +46,18 @@ struct resource iomem_resource = {
 };
 EXPORT_SYMBOL(iomem_resource);
 
-/* constraints to be met while allocating resources */
+/**
+ * resource_constraint - constraints to be met while searching empty resource slots
+ * @min:		The minimum address for the memory range
+ * @max:		The maximum address for the memory range
+ * @align:		Alignment for the start address of the empty slot
+ * @alignf:		Additional alignment constraints callback
+ * @alignf_data:	Data provided for @alignf callback
+ *
+ * Contains the range and alignment constraints that have to be met during
+ * find_empty_resource_slot(). @alignf can be NULL indicating no alignment
+ * beyond @align is necessary.
+ */
 struct resource_constraint {
 	resource_size_t min, max, align;
 	resource_size_t (*alignf)(void *, const struct resource *,
@@ -629,8 +640,19 @@ next:		if (!this || this->end == root->end)
 	return -EBUSY;
 }
 
-/*
- * Find empty slot in the resource tree given range and alignment.
+/**
+ * find_empty_resource_slot - Find empty slot in the resource tree
+ * @root:	Root resource descriptor
+ * @new:	Resource descriptor awaiting an empty resource slot
+ * @size:	The minimum size of the empty slot
+ * @constraint:	The range and alignment constraints to be met
+ *
+ * Finds an empty slot under @root in the resource tree satisfying range and
+ * alignment @constraints.
+ *
+ * Return:
+ * * %0		- if successful, @new members start, end, and flags are altered.
+ * * %-EBUSY	- if no empty slot was found.
  */
 static int find_empty_resource_slot(struct resource *root, struct resource *new,
 				    resource_size_t size,
-- 
2.30.2


