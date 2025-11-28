Return-Path: <linux-pci+bounces-42258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B357EC91DF1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB4724E78DB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC24324B31;
	Fri, 28 Nov 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgD22dyc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76C31ED8C;
	Fri, 28 Nov 2025 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330644; cv=none; b=IYAnwDHdMqykuvr1TlmSZYtK/6mUjbskG92XxegN/55g6ABYyG3hW2AxocLlFaxxT2MeAUc//C5DtHSdWGLsvBCUP/t7T/SvVFX+Sd36SGfJagh6wewCHWdD0qhKuZfOCrSEHNMmivqWCLOICgSE3m4CXglu5t9VJNOz6YwyhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330644; c=relaxed/simple;
	bh=w1nn91iVTHk8FXTeuhEl2nHnCcO17OkcU6tsnZL2XZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSZ45Guv00TCVIiNN7Nsr1GI6G1/R8H/IQwzwk9hvwCKj35b/8u+0mHh12c/mAZcx17QSZU7NuR+pe0nAb0qc8eN3d5HI2+F7yKABllxwetjM6M90AFMwPh5e/VA5pbntJ0gjm4ZjOdQ5pxqVpBE0FauYTRC8NcHrKHK1HHC6So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgD22dyc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764330643; x=1795866643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w1nn91iVTHk8FXTeuhEl2nHnCcO17OkcU6tsnZL2XZ0=;
  b=RgD22dychSr9i3VSdFp48CMkCozHsy/ruaLvwIZqGbkJE0IUEFC6YYok
   aAOuNEqTwVGzpXDm8ywdrQPB1fW+XuURurZs2FGwZ6wTPGVYs6Zth91vu
   fbfF7Zr3Di49WPA1kVh9hsBgvL41hqWBQjxstu4PthTwBRW+pZ1vfJts2
   UZ9CAOhXYBzJ1GtOLELb+Ntc2iH/PCIuw5nrC7+EGbRy/dcYyn5wAUubd
   Kw6TvH10s2NGVfHNr05fI8ip9QqLa+bIuUZCgQQXWGAMZUYFMrl3DYUlH
   1l7of39wS1fNgjMpVfmWPlhQhiqhceEqKJ78fAUTavsDoQR3zfFQq95ZD
   Q==;
X-CSE-ConnectionGUID: FcvEgb8mTdqt0Ui7MH6yoQ==
X-CSE-MsgGUID: F34uvkkRTOS0CG4r3aH0kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="77050427"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="77050427"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:50:42 -0800
X-CSE-ConnectionGUID: J2ZKRN4+TMilXtqfppKkmQ==
X-CSE-MsgGUID: +8SrmPYaT2CAx3ngTkl49Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="224149171"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:50:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	=?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] PCI: Fix bridge window alignment with optional resources
Date: Fri, 28 Nov 2025 13:50:18 +0200
Message-Id: <20251128115021.4287-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251128115021.4287-1-ilpo.jarvinen@linux.intel.com>
References: <20251128115021.4287-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pbus_size_mem() has two alignments, one for required resources in
min_align and another in add_align that takes account optional
resources.

The add_align is applied to the bridge window through the realloc_head
list. It can happen, however, that add_align is larger than min_align
but calculated size1 and size0 are equal due to extra tailroom (e.g.,
hotplug reservation, tail alignment), and therefore no entry is created
to the realloc_head list. Without the bridge appearing in the realloc
head, add_align is lost when pbus_size_mem() returns.

The problem is visible in this log for 0000:05:00.0 which lacks
add_size ... add_align ... line that would indicate it was added into
the realloc_head list:

pci 0000:05:00.0: PCI bridge to [bus 06-16]
...
pci 0000:06:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 07] requires relaxed alignment rules
pci 0000:06:06.0: bridge window [mem 0x00100000-0x001fffff] to [bus 0a] requires relaxed alignment rules
pci 0000:06:07.0: bridge window [mem 0x00100000-0x003fffff] to [bus 0b] requires relaxed alignment rules
pci 0000:06:08.0: bridge window [mem 0x00800000-0x00ffffff 64bit pref] to [bus 0c-14] requires relaxed alignment rules
pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] requires relaxed alignment rules
pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] requires relaxed alignment rules
pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] add_size 100000 add_align 1000000
pci 0000:06:0c.0: bridge window [mem 0x00100000-0x001fffff] to [bus 15] requires relaxed alignment rules
pci 0000:06:0d.0: bridge window [mem 0x00100000-0x001fffff] to [bus 16] requires relaxed alignment rules
pci 0000:06:0d.0: bridge window [mem 0x00100000-0x001fffff] to [bus 16] requires relaxed alignment rules
pci 0000:05:00.0: bridge window [mem 0xd4800000-0xd97fffff]: assigned
pci 0000:05:00.0: bridge window [mem 0x1060000000-0x10607fffff 64bit pref]: assigned
pci 0000:06:08.0: bridge window [mem size 0x04900000]: can't assign; no space
pci 0000:06:08.0: bridge window [mem size 0x04900000]: failed to assign

While this bug itself seems old, it has likely become more visible
after the relaxed tail alignment that does not grossly overestimate the
size needed for the bridge window.

Make sure add_align > min_align too results in adding an entry into the
realloc head list. In addition, add handling to the cases where
add_size is zero while only alignment differs.

Fixes: d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing and assigning")
Reported-by: Malte Schröder <malte+lkml@tnxip.de>
Tested-by: Malte Schröder <malte+lkml@tnxip.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/setup-bus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4a8735b275e4..70d021ffb486 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -14,6 +14,7 @@
  *	     tighter packing. Prefetchable range support.
  */
 
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -452,7 +453,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 					"%s %pR: ignoring failure in optional allocation\n",
 					res_name, res);
 			}
-		} else if (add_size > 0) {
+		} else if (add_size > 0 || !IS_ALIGNED(res->start, align)) {
 			res->flags |= add_res->flags &
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(dev, idx, add_size, align))
@@ -1438,12 +1439,13 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
 	resource_set_range(b_res, min_align, size0);
 	b_res->flags |= IORESOURCE_STARTALIGN;
-	if (bus->self && size1 > size0 && realloc_head) {
+	if (bus->self && realloc_head && (size1 > size0 || add_align > min_align)) {
 		b_res->flags &= ~IORESOURCE_DISABLED;
-		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
+		add_size = size1 > size0 ? size1 - size0 : 0;
+		add_to_list(realloc_head, bus->self, b_res, add_size, add_align);
 		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
 			   b_res, &bus->busn_res,
-			   (unsigned long long) (size1 - size0),
+			   (unsigned long long) add_size,
 			   (unsigned long long) add_align);
 	}
 }
-- 
2.39.5


