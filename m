Return-Path: <linux-pci+bounces-36498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D2B89E1E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C69C3B7B16
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911A31355E;
	Fri, 19 Sep 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ty/uMXc6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA332314B68
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291769; cv=none; b=ZanXfUNxIfcQEOM9zn1o27d1CDl2g2EL2DAzf0K4i3jDBD9wqJsIEfOqpypDgP2MkBxLDfnX5ceuLzemeqE8Qv6Mfd3C6qdZKXD8vYcdZu7NwecmqfCnAZgDXL02A9JFesejy4szVtmFxHW1M3LkeYvQ+gwGeMQyq9g7ooz8leE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291769; c=relaxed/simple;
	bh=Wf140bUYMuvWmLegSAfiHi4jwPQqHXipglSAal1VBI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/h7haRfFxrRISq593gVFjaWD+xL2K2/FRKoWT+7j336Kees34BAIPjiu5anvIK5wCO+I+vyUIIjMD6xCu+sHwxRHGUcJMisKVry/n0jBvnNoPdjEaSZJ3e3OWAZrYQhFPHxbZBWu/OIGWiGYcyrv0uXRGLEJ982PH4DZeXNZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ty/uMXc6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291767; x=1789827767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wf140bUYMuvWmLegSAfiHi4jwPQqHXipglSAal1VBI8=;
  b=Ty/uMXc6C78bN8XQeTSQT4QdQNYP8iFMONbJAdJSoIhtpR1NxDUTns6b
   S+Tn20ZDW37OiqqiZgrFxc1LVObt7vSORNmTTeMeglDJwl7oYmzAsyoPq
   kw6HufLeL5kHXAjkhw02iKqH4Y0hyQI355UJlEPY4sLDDuX3AUjxB3KG3
   Y1ViONDzWhX7CLKXk+Ut3FaD8NoLIzXaWtBW/fRVAH17MlpKx+cEntWk2
   Bluot4oDDWdk9lGUHe2eElEQaxRvG9efxEAfEyG1ZipWbbczzjdP435CV
   N9pQw0Mr8YfWtJlrdsM/ksEVUbBChp3qgvCx/FZSSJ9IW/2+sALQyjF5Y
   g==;
X-CSE-ConnectionGUID: SBy5ijJ3SwiyWFcahViv3Q==
X-CSE-MsgGUID: H4Ww0CqOSberBS5kRBKuWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750555"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750555"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:39 -0700
X-CSE-ConnectionGUID: Bqy7T1DwRO20/LSQhqFzjw==
X-CSE-MsgGUID: niQdgvIcSKeCugN4xfvQ5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655044"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 17/27] iommu/vt-d: Export a helper to do function for each dmar_drhd_unit
Date: Fri, 19 Sep 2025 07:22:26 -0700
Message-ID: <20250919142237.418648-18-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@linux.intel.com>

Enable the tdx-host module to get VTBAR address for every IOMMU device.
The VTBAR address is for TDX Module to identify the IOMMU device and
setup its trusted configuraion.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/iommu/intel/dmar.c | 16 ++++++++++++++++
 include/linux/dmar.h       |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 3ae177463774..222d66bff80a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2429,3 +2429,19 @@ bool dmar_platform_optin(void)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dmar_platform_optin);
+
+int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *))
+{
+	struct dmar_drhd_unit *drhd;
+	int ret;
+
+	guard(rwsem_read)(&dmar_global_lock);
+
+	for_each_drhd_unit(drhd) {
+		ret = fn(drhd);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(do_for_each_drhd_unit);
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 692b2b445761..f4ca8e0c67e5 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -86,6 +86,8 @@ extern struct list_head dmar_drhd_units;
 				dmar_rcu_check())			\
 		if (i=drhd->iommu, 0) {} else 
 
+extern int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *));
+
 static inline bool dmar_rcu_check(void)
 {
 	return rwsem_is_locked(&dmar_global_lock) ||
-- 
2.51.0


