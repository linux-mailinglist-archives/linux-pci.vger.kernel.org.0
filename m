Return-Path: <linux-pci+bounces-34574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96597B31D4A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B372AA4976
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6713126B6;
	Fri, 22 Aug 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ho0rXgx2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CD239E88;
	Fri, 22 Aug 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874624; cv=none; b=MagKWGPRUqoc/LFpnaBOhAdiNA2+UsSsTu8PJQ0D/Eor8dWAj2R6IUoBUVF67gvL+bqXuo83mAYjlTJZyd/MG/p0Lm/yTHCjLzHFAOPBsfr4+ESxMJ9FXZ0NH1xldsMiC+HGUr+5bG0jM5lEsv+8z7xDK/7/j4+yJ4RbnC3sxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874624; c=relaxed/simple;
	bh=wPDvnWZ5n/ZzruRde5Pq3zT/XPnm5sbjNx2qOymBYfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8EKpllvKm0543kTpfOq+ZWdBd9iVLKI8EWjvOEMNbpecJG0ivHYrF/P1uqaQk7N0iCxyuX7RM3j22jv+vdI3Uq/YnUOltBnfX0hhoU6Mfv3wrrNa29Nw32ZD/SQr2Ls/mEPJGuUjUBy4LfwkDBG8PEV1QMvIiBNDBaXqctx9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ho0rXgx2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874623; x=1787410623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wPDvnWZ5n/ZzruRde5Pq3zT/XPnm5sbjNx2qOymBYfE=;
  b=Ho0rXgx25tzf4cple4tEoHtQOM2hSyWpyVbRQ7QhnDZUbiActgyHRhwl
   lc49e0x+wFkNsZJZgbxf9GquJ2z6nAheXIGKMPQ3etnZw5Aiy1QhMXlt9
   i5sJd9IqC5c8PSGFxBQ4gd5i4w6fDUlUdEdrqWhWunE/Y3tRlNQUIRHmD
   GMsk646mAkZpJpoEshakqHWYXl6kppnP3t0hyoTIlhscNgoXwPLQvXnom
   nbCCFoYTaKduFnZoE9Q6O/vA4qY5GxO249Asu5l8NHt5PK9gZzwzZrXI1
   hn0SfO3G0pUBJFxTTQaRhMyid68KOpzf0cz5GYnpAGMWg5nq7vla272JK
   A==;
X-CSE-ConnectionGUID: o7rmB9oBR7STnKGbiilYiA==
X-CSE-MsgGUID: DeGJ2uogTMKkI0IedVuMhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69283117"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69283117"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:03 -0700
X-CSE-ConnectionGUID: qiJ59XlaQtqa4e+Z9uM3dw==
X-CSE-MsgGUID: tW3R/pfDT4eAbXWbFFh3og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169547004"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:56:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/24] PCI: Refactor find_bus_resource_of_type() logic checks
Date: Fri, 22 Aug 2025 17:55:46 +0300
Message-Id: <20250822145605.18172-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The logic checks can be simplified in find_bus_resource_of_type() by
reordering them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4097d8703b8f..c5fc4e2825be 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -158,11 +158,15 @@ static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
 	struct resource *r, *r_assigned = NULL;
 
 	pci_bus_for_each_resource(bus, r) {
-		if (r == &ioport_resource || r == &iomem_resource)
+		if (!r || r == &ioport_resource || r == &iomem_resource)
 			continue;
-		if (r && (r->flags & type_mask) == type && !r->parent)
+
+		if ((r->flags & type_mask) != type)
+			continue;
+
+		if (!r->parent)
 			return r;
-		if (r && (r->flags & type_mask) == type && !r_assigned)
+		if (!r_assigned)
 			r_assigned = r;
 	}
 	return r_assigned;
-- 
2.39.5


