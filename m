Return-Path: <linux-pci+bounces-43076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5879CCC065D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D0C3018F5F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 00:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4D298CC0;
	Tue, 16 Dec 2025 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzotR7ti"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B527CB35;
	Tue, 16 Dec 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846538; cv=none; b=CNnwpdxu+hXPSP+DHFP/rqGCMURQO2HRZ8cTu62XvBqozf/MjTyPDf0/bTyGfsbL7ISOuufiavP9sKRgSxIU9lg7Huv+FpS8QQxYKHwlPvsE/iXkoPBc+lO0zyRUgCeaN9Xc9AqdGEppQVWQFbEYIU8c4RcHcc6FAryBUp8hWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846538; c=relaxed/simple;
	bh=3im/o3r75eE2iLJ7BlqrvuXoMC/tLGq0o0JFtlK+2JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTjIltuDio71jpw2c0+XIE0BK6z3EbvMPJ+OFMbG173mc7IWcz8Loq3hTOSvZ1y4x5aTx/x+r1Lxx/povZdbc10Lx4tR21VVUldLFH/itO9XDztT7/bzH7SZjDCvtUqWsWytfrQ8+PpJ5xUAkL5eim397IunB+QbtAdN2A0ChYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzotR7ti; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765846536; x=1797382536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3im/o3r75eE2iLJ7BlqrvuXoMC/tLGq0o0JFtlK+2JI=;
  b=TzotR7tinZiC/dRKyESxCS7cI5hXw1ezq/ALxJbHekq55yYI3g7cN+2G
   VwbRLOk0Owao2dY+yiQjXv6xnmahw4stsiwZYsl7c+4sU90ky4ynCOnpb
   RYA3FkWh2nw/HjGiMY10vlUHwbc66yZzS5dqjJE9FoljRwMpOVUEUB650
   h/0/j8Bt2DSNzofPQq+Z5A9+MkgJKkRV40o23DrOUZzG87haBuLEKogbr
   qg6Ln2o5KLpW/El/BEC32YnsWXRDJGgCnZHP0vgSEey9PHk26VyXhwDON
   8PhrVhurR24NG3lgPHh+lxioVDpIr/ZTHy8lhbqh98snKhC000KUjBbNC
   Q==;
X-CSE-ConnectionGUID: bqHrtSvNSXmGu6ZtKW/s5Q==
X-CSE-MsgGUID: O/TqbFUfQgaNnQimwaShrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79215487"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="79215487"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 16:55:34 -0800
X-CSE-ConnectionGUID: YSXU9NG1R2Wfz2dKRXidKA==
X-CSE-MsgGUID: GnaKlRQgRlClJtiGOCWaLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="198131542"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa008.fm.intel.com with ESMTP; 15 Dec 2025 16:55:33 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	alison.schofield@intel.com,
	terry.bowman@amd.com,
	alejandro.lucero-palau@amd.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 5/6] cxl/mem: Drop @host argument to devm_cxl_add_memdev()
Date: Mon, 15 Dec 2025 16:56:15 -0800
Message-ID: <20251216005616.3090129-6-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251216005616.3090129-1-dan.j.williams@intel.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In all cases the device that created the 'struct cxl_dev_state' instance is
also the device to host the devm cleanup of devm_cxl_add_memdev(). This
simplifies the function prototype, and limits a degree of freedom of the
API.

Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com> (✓ DKIM/intel.com)
Reviewed-by: Dave Jiang <dave.jiang@intel.com> (✓ DKIM/intel.com)
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com> (✓ DKIM/amd.com)
Tested-by: Alejandro Lucero <alucerop@amd.com> (✓ DKIM/amd.com)
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxlmem.h         | 6 ++----
 drivers/cxl/core/memdev.c    | 3 +--
 drivers/cxl/mem.c            | 9 +++++----
 drivers/cxl/pci.c            | 2 +-
 tools/testing/cxl/test/mem.c | 2 +-
 5 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 012e68acad34..9db31c7993c4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -95,10 +95,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
-					 struct cxl_dev_state *cxlds);
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds);
+struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 18efbf294db5..63da2bd4436e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1093,8 +1093,7 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
  * Core helper for devm_cxl_add_memdev() that wants to both create a device and
  * assert to the caller that upon return cxl_mem::probe() has been invoked.
  */
-struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
-					 struct cxl_dev_state *cxlds)
+struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
 	struct device *dev;
 	int rc;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d62931526fd4..677996c65272 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -165,17 +165,18 @@ static int cxl_mem_probe(struct device *dev)
 
 /**
  * devm_cxl_add_memdev - Add a CXL memory device
- * @host: devres alloc/release context and parent for the memdev
  * @cxlds: CXL device state to associate with the memdev
  *
  * Upon return the device will have had a chance to attach to the
  * cxl_mem driver, but may fail if the CXL topology is not ready
  * (hardware CXL link down, or software platform CXL root not attached)
+ *
+ * The parent of the resulting device and the devm context for allocations is
+ * @cxlds->dev.
  */
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
-	return __devm_cxl_add_memdev(host, cxlds);
+	return __devm_cxl_add_memdev(cxlds);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0be4e508affe..1c6fc5334806 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1006,7 +1006,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 176dcde570cd..8a22b7601627 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1767,7 +1767,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 
 	cxl_mock_add_event_logs(&mdata->mes);
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-- 
2.51.1


