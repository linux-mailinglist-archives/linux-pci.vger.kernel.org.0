Return-Path: <linux-pci+bounces-7158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88E08BDFB0
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73D2B25373
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE6E14EC65;
	Tue,  7 May 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0Jxd/oT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64514F11B;
	Tue,  7 May 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077612; cv=none; b=XSReHzGDQKfo7e+ruhaOZ5wtXlL6fFNjZRSOARjCjeKeyTSbJ+WFcmYtMK3q+oqeE7rCcelLRFMFaIFUJZRNPG/6Bq5cU7qS5pfv5B3oPjB8zfVA1d4/TpSnH3X2up6JUbDbu7xy7LMoLfxOh8LvHo6LQzmhDzglAo9ZSQTXtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077612; c=relaxed/simple;
	bh=sRJlzCczuj0xPegba6C3Pnkn/jUNQt5RNJg+ram5wAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkgMgl2X5CIwLT4oI3MNkSYWuYeU2tUUilnrA43LEiw9McYJfCkNMqyP9A470sbsnN2q7d8OeobQSsvUGFmjONSA18rIlwU5lD9E6y4JYd9GLYOklg7h4Tv7gE2YGa9yUKc/0pVR9dmhi3ICR+3kD9PyFLztFVdGs5eQnDyxgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0Jxd/oT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715077611; x=1746613611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sRJlzCczuj0xPegba6C3Pnkn/jUNQt5RNJg+ram5wAc=;
  b=a0Jxd/oTFxAkJsa1j5Ftm3eQSSmKzlnaB1FNyXfIGb/H08JnFPtDWxZV
   JVvQ85fVtfAJap2BJX1mF4JkE+7ueR6HnwHbiwWxBUVGerWP/H/rTnKzZ
   IVlfk7FwMIUqcCWPRKt2zycpEAbrPfAyWR3T7VL5CYqFvGyBmVKKZTrFC
   Hd19ML2UOif2SaMYONsMwNpDjX1GQKnA3vbsZpPK5X8NBnhISESgIL8DH
   uuWaOnlOeiByrQA/uPZ+x/ElB6rxlvnyB+Q60sfCABaxVwfOx2HBkHdoY
   8UeWeGHS5aUYcbU0MzhUll1emQr9YC11xKWBGcZkRqnZUil9A4aQBqSaW
   A==;
X-CSE-ConnectionGUID: hm+2YKm8TJSSKR3dCZ6CaA==
X-CSE-MsgGUID: AnCBI0BqTCeTOqIYjBeZeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10729877"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="10729877"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:51 -0700
X-CSE-ConnectionGUID: LULzOzlnReebYa+E5zhaYQ==
X-CSE-MsgGUID: TJBtTMT6SLu5DzVmxvDw9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="33280303"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:47 -0700
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
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 7/8] PCI: Make minimum bridge window alignment reference more obvious
Date: Tue,  7 May 2024 13:25:22 +0300
Message-Id: <20240507102523.57320-8-ilpo.jarvinen@linux.intel.com>
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

Calculations related to bridge window size contain literal 20 that is
the minimum alignment for a bridge window. Make the code more obvious
by converting the literal 20 to __ffs(SZ_1MB).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 141d6b31959b..bca1df46f19c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -14,6 +14,7 @@
  *	     tighter packing. Prefetchable range support.
  */
 
+#include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -21,6 +22,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/cache.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include "pci.h"
@@ -957,7 +959,7 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
 	for (order = 0; order <= max_order; order++) {
 		resource_size_t align1 = 1;
 
-		align1 <<= (order + 20);
+		align1 <<= (order + __ffs(SZ_1M));
 
 		if (!align)
 			min_align = align1;
@@ -1047,7 +1049,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 * resources.
 			 */
 			align = pci_resource_alignment(dev, r);
-			order = __ffs(align) - 20;
+			order = __ffs(align) - __ffs(SZ_1M);
 			if (order < 0)
 				order = 0;
 			if (order >= ARRAY_SIZE(aligns)) {
-- 
2.39.2


