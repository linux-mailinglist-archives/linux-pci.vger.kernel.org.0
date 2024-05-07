Return-Path: <linux-pci+bounces-7153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAC68BDFA3
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FB81F24001
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA7A14F115;
	Tue,  7 May 2024 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCqgXBSW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABF14EC4D;
	Tue,  7 May 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077564; cv=none; b=l4sTgQCdJvtgXluO0gG6nT63V7pQtU9F0qAv5u+2HLS0NST0IqlUSBPCv9+193ZJWSJBt2FlTxtqGyXeWka7VjrCDKm5UJCSsHMMYK7VICoNwgTMJ/APkHvTGDAdiLtOugInKgk5wmaiAmbkhXGtTTFv+IumrNFSAccqYGsw0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077564; c=relaxed/simple;
	bh=W/1p5rLCE7EfDYekQAv2sivheXm6yRukXo8sDbl94r4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1LsJxdLETV/gQuLvI2aMmTG8eP8KDNtiam3DP+XMBj2t9oZqCtGJUCCeCNMaLwdI4QBm9ZT88PL1Mts+9e/5L24No/DRkS5ENuMz5cWpxJzBi1gcZiqzI2maJ6ha4PQc24N7AJ8bKGXiZp4WmXjqNHDeobKxITo3qxaw6oMIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCqgXBSW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715077561; x=1746613561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/1p5rLCE7EfDYekQAv2sivheXm6yRukXo8sDbl94r4=;
  b=CCqgXBSWNnqpLmAmfEgx0ntx027cmcU/xgolEB7UyKfhBC/8YmATkrPn
   3G1mQ7zTLYflEd9Y3FAJhCLcR/KKBfWIxmITSi+6t+6WhUllttBXmwl1J
   kZ/l2hXlPlTRbWxgk9lk+E6llYN32tvOUtvGCuXgtzjRCq26Sb8hOQhbe
   ifkt6j67IR9cu0MhP7bYpmcdBj3yA+gHbwf9ckUqNafDy1Yk6Odgg1EOM
   kGg3cHt91e7xtn0U7FPOpczLpb28rQrCN0QAJm36EF00k/wv3aeD/NjqA
   57Kj9Px1yN4oZnl5D6Fxr1lMoVinOGD3PXxRkHHZkw2eyB4rGueMJhg1g
   g==;
X-CSE-ConnectionGUID: FCVUeelfQZucYO9jy2tb/A==
X-CSE-MsgGUID: L24ZPt+xRvS+tf1VYG83jA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10746752"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="10746752"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:00 -0700
X-CSE-ConnectionGUID: izw6jrMIT2qzxXAzWAkc2A==
X-CSE-MsgGUID: iIg+bEoTSIaBdp/zD8jIRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="59647773"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:25:56 -0700
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
Subject: [PATCH v3 2/8] resource: Rename find_resource() to find_resource_space()
Date: Tue,  7 May 2024 13:25:17 +0300
Message-Id: <20240507102523.57320-3-ilpo.jarvinen@linux.intel.com>
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

Rename find_resource() to find_resource_space() to better describe what
the functions does. This is a preparation for exposing it beyond
resource.c which is needed by PCI core. Also rename the __ variant to
match the names.

Tested-by: Lidong Wang <lidong.wang@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 kernel/resource.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index fcbca39dbc45..e163e0a8f2f8 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -628,13 +628,12 @@ static void resource_clip(struct resource *res, resource_size_t min,
 }
 
 /*
- * Find empty slot in the resource tree with the given range and
+ * Find empty space in the resource tree with the given range and
  * alignment constraints
  */
-static int __find_resource(struct resource *root, struct resource *old,
-			 struct resource *new,
-			 resource_size_t  size,
-			 struct resource_constraint *constraint)
+static int __find_resource_space(struct resource *root, struct resource *old,
+				 struct resource *new, resource_size_t size,
+				 struct resource_constraint *constraint)
 {
 	struct resource *this = root->child;
 	struct resource tmp = *new, avail, alloc;
@@ -688,13 +687,13 @@ next:		if (!this || this->end == root->end)
 }
 
 /*
- * Find empty slot in the resource tree given range and alignment.
+ * Find empty space in the resource tree given range and alignment.
  */
-static int find_resource(struct resource *root, struct resource *new,
-			resource_size_t size,
-			struct resource_constraint  *constraint)
+static int find_resource_space(struct resource *root, struct resource *new,
+			       resource_size_t size,
+			       struct resource_constraint *constraint)
 {
-	return  __find_resource(root, NULL, new, size, constraint);
+	return  __find_resource_space(root, NULL, new, size, constraint);
 }
 
 /**
@@ -717,7 +716,7 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 
 	write_lock(&resource_lock);
 
-	if ((err = __find_resource(root, old, &new, newsize, constraint)))
+	if ((err = __find_resource_space(root, old, &new, newsize, constraint)))
 		goto out;
 
 	if (resource_contains(&new, old)) {
@@ -786,7 +785,7 @@ int allocate_resource(struct resource *root, struct resource *new,
 	}
 
 	write_lock(&resource_lock);
-	err = find_resource(root, new, size, &constraint);
+	err = find_resource_space(root, new, size, &constraint);
 	if (err >= 0 && __request_resource(root, new))
 		err = -EBUSY;
 	write_unlock(&resource_lock);
-- 
2.39.2


