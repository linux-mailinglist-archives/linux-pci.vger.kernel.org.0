Return-Path: <linux-pci+bounces-18539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 642979F3824
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E929188F74A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AEF206F0B;
	Mon, 16 Dec 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/O9ZFO7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD9206F2A;
	Mon, 16 Dec 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371841; cv=none; b=t2kBpfQaIojUZbiuyMz5frys3MNVUCzF0jmVndT/DkXvieh9rEBErAcO2fvMbJkMm7hucHBE5hjLNwXRrAxO9UO4YFYXQb38v5kd+RoLZbf23AaLOFpqrWAF2l6Bqbx6RgRpkldjuDIHh1RQx2NcEkrazF0DSF0PMsaZHu85Dto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371841; c=relaxed/simple;
	bh=kTF53d/2ZsRDzTDswO8gIjTL7H4whqcMUodbNG1Ns78=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DE3rXMSG+hUtEU51ud7RNXcjzn7LCc69X8Ea4q4kIUXuUk5zbSmfudEM220kidc+LuRraZkDjdrj9omR0KKWwTpaV+ij8jKJKR1ILoWX4uafrolMvRs3WY+524VeP3TtvJZepIk/8QNnZ7CBJK4sF7Nf00Rz2TMPXgatTqBR1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/O9ZFO7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371840; x=1765907840;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=kTF53d/2ZsRDzTDswO8gIjTL7H4whqcMUodbNG1Ns78=;
  b=g/O9ZFO7sqZJYdot7NeJr9v+Nwa63Qdyf2KMX4Uqm4Ijwz/dBx5BFH7b
   ONrXRhgye+wV5/9o4qPI6+a5OTKFfOkH8AqyYNPM5g/OZasUvxxHSWY9y
   Migv9IeWNqug4wY43VEpvBSz+w4BUAu6fdFEG27NihK6FUUvtiEPLztwL
   Oluk1GtsrTjXMCu+sVFkUBLimCQMEYg4KlXGxlmqipr/lAANlQo2S4ekn
   GlKqrZeY162vFk+vGZSOLs1d45ME3Q0o4m69Jw1OvqBsA+LOzAlJhFQ9A
   4rxnpNq47RvaO6K7NEfZsFdRtNwcsXXN/jPIGnIzyfp20qQGfWUhm7b/Q
   Q==;
X-CSE-ConnectionGUID: QluJRO1CQmqSKqtB7d0SlQ==
X-CSE-MsgGUID: fZBsV5O/QgupP30aT00tow==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57250859"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="57250859"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:18 -0800
X-CSE-ConnectionGUID: ZAcQ6WWJRt2qc/bZzg9Nzg==
X-CSE-MsgGUID: 5iOJ5ztHT3GAb25cooAg0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101418718"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/25] PCI: Optional bridge window size too may need relaxing
Date: Mon, 16 Dec 2024 19:56:11 +0200
Message-Id: <20241216175632.4175-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit 566f1dd52816 ("PCI: Relax bridge window tail sizing rules")
relaxed the bridge window requirements for non-optional size (size0)
but pbus_size_mem() also handles optional sizes (IOV resources) using
size1. This can manifest, e.g., as a failure to resize a BAR back to
its original size after it was first shrunk when device has a VF BAR
resource because the bridge window (size1) is enlarged beyond what is
strictly required to fit the downstream resources.

Allow using relaxed bridge window tail sizing rules also with the
optional resources (size1) so that the remove/realloc cycle during BAR
resize (smaller and back to the original size) does not fail
unexpectedly due to sudden increase in bridge window size demand.

Move also add_align calculation into more logical place next to size1
assignment as they are strongly related to each other.

Fixes: 566f1dd52816 ("PCI: Relax bridge window tail sizing rules")
Reported-by: Michał Winiarski <michal.winiarski@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7f4680a23c13..31f051cdac68 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1146,7 +1146,6 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	min_align = calculate_mem_align(aligns, max_order);
 	min_align = max(min_align, win_align);
 	size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
-	add_align = max(min_align, add_align);
 
 	if (bus->self && size0 &&
 	    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
@@ -1159,8 +1158,21 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	}
 
 	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
+		add_align = max(min_align, add_align);
 		size1 = calculate_memsize(size, min_size, add_size, children_add_size,
 					  resource_size(b_res), add_align);
+
+		if (bus->self && size1 &&
+		    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
+						   size1, add_align)) {
+			min_align = 1ULL << (max_order + __ffs(SZ_1M));
+			min_align = max(min_align, win_align);
+			size1 = calculate_memsize(size, min_size, add_size, children_add_size,
+						  resource_size(b_res), win_align);
+			pci_info(bus->self,
+				 "bridge window %pR to %pR requires relaxed alignment rules\n",
+				 b_res, &bus->busn_res);
+		}
 	}
 
 	if (!size0 && !size1) {
-- 
2.39.5


