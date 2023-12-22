Return-Path: <linux-pci+bounces-1294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D14F81C9FC
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320A41F25D40
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 12:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FF010A0D;
	Fri, 22 Dec 2023 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7vgg2ex"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A5199A1;
	Fri, 22 Dec 2023 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703248168; x=1734784168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LCe+OPVf6ypAOTjFWig95nNeJVsgngMAJh/hD3RJ254=;
  b=L7vgg2exjtHCbQFLj8azE2qQZPp1P/e1KlT2Bl+bdqyNxCM536S767yd
   lo1V9FNCaW3QkGUp3Ac5Bx74DlSs+nU2lNNJ5teENNfkO4nDJYI37TMqv
   Ua7XKpSF3Fsmx/K/uwpVI2jpbEwW6Njk5O3A3c9sgUsI83LMtffpttWQS
   YAB1GPE3Sqvfgb6cgN1CR1dsqfuLCILRd5P8yBOYcQ6aihXlQR10rwEf3
   yj3z3fHWxDBKepEs1uboAtF41orgbZzJOziJETKAJ981e2UMOy2STU/5q
   2oIQ8dDayblUVt6qDpZaowZ24LKAY7WTlbEddV2MDHY5VRU2Tnip9Dhy3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="17681298"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="17681298"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="950263952"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="950263952"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.105])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:29:22 -0800
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
Subject: [PATCH 1/7] PCI: Fix resource double counting on remove & rescan
Date: Fri, 22 Dec 2023 14:28:55 +0200
Message-Id: <20231222122901.49538-2-ilpo.jarvinen@linux.intel.com>
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

pbus_size_mem() keeps the size of the optional resources in
children_add_size. When calculating the PCI bridge window size,
calculate_memsize() lower bounds size by old_size before adding
children_add_size and performing the window size alignment. This
results in double counting for the resources in children_add_size
because old_size may be based on the previous size of the bridge
window after it has already included children_add_size (that is,
size1 in pbus_size_mem() from an earlier invocation of that
function).

As a result, on repeated remove of the bus & rescan cycles the resource
size keeps increasing when children_add_size is non-zero as can be seen
from this extract:

iomem0:  23fffd00000-23fffdfffff : PCI Bus 0000:03
iomem1:  20000000000-200001fffff : PCI Bus 0000:03
iomem2:  20000000000-200002fffff : PCI Bus 0000:03
iomem3:  20000000000-200003fffff : PCI Bus 0000:03
iomem4:  20000000000-200004fffff : PCI Bus 0000:03

Solve the double counting by moving old_size check later in
calculate_memsize() so that children_add_size is already accounted for.

After the patch, the bridge window retains its size as expected:

iomem0:  23fffd00000-23fffdfffff : PCI Bus 0000:03
iomem1:  20000000000-200000fffff : PCI Bus 0000:03
iomem2:  20000000000-200000fffff : PCI Bus 0000:03

Fixes: a4ac9fea016f ("PCI : Calculate right add_size")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index fd74f1c99dba..e3e6ff8854a7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -820,11 +820,9 @@ static resource_size_t calculate_memsize(resource_size_t size,
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
-	if (size < old_size)
-		size = old_size;
 
-	size = ALIGN(max(size, add_size) + children_add_size, align);
-	return size;
+	size = max(size, add_size) + children_add_size;
+	return ALIGN(max(size, old_size), align);
 }
 
 resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
-- 
2.30.2


