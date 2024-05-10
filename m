Return-Path: <linux-pci+bounces-7324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A218C1F09
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 09:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D391C2173F
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 07:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D420309;
	Fri, 10 May 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dvdzCCD5"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF715ECDF;
	Fri, 10 May 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715326571; cv=none; b=t69C77LAtPA+1nS8E0pv3xh+nXizoFbKkugFJYXxbWCn28bg/9bV5XYfXIVFiJvbMTLKPuG1L5R7JSOWk4RNLyWp0uAL2zW2Q9rSUxk/bm4sB5SSEdKK6eBgL+0vyhhCHxZ/TfJdio+zOdP3ws17ecSramh4ItjbxxCv6AFrXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715326571; c=relaxed/simple;
	bh=hOdurdp2lVjX4G1Rzv+cZ224UyrXPp8qXi9rHu/n88k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uP3Iy9IfpYH0aFBZ0DiPaxloCbddGpXppxkv1ACqr7pvdS/1iuHFXdCAElgnPVWSkDyLe+MRX6vf78fK0Yr3gF28NeoytYaTm4Fq3EgWXtiBIDw+T28OYFD3kNivmcok2DdzVPDShkcrEDdQo4uzvXP8g3SwmNOgwZOi4RsFguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dvdzCCD5; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1715326569; x=1746862569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOdurdp2lVjX4G1Rzv+cZ224UyrXPp8qXi9rHu/n88k=;
  b=dvdzCCD5C5EkjvaSS3ppnfYzU+02w/b+Wq0JSi0R6JlhIrHCqItLB/4p
   Q0IKapF6tJzu8ACeWEFGeHNjV8Ksn7N0PCqDgBRdOoA5JkHsFoD4QBxBg
   BOZk37S/+X8T/e7ObbrgrlsXd0ho27258SxKiOBDljbSOK/LsPv5MsiMV
   mSPWTNWu3HW7O//r6/uyIofwbQNcoNAOYmCDr/riTlr9Xyc3sh/vvwqU6
   KCaDuq+G4atbAOQmRexJAvtYXJOkSnMhlY8LNUqpU7VhLu+DQ+i3fhn7e
   XoxIxNypN5lz6UCC5kgxftT+1oLbU9wuoypqVMFQXaNA5t3FR48zqMlbe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="157886733"
X-IronPort-AV: E=Sophos;i="6.08,150,1712588400"; 
   d="scan'208";a="157886733"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 16:34:46 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E65A0C2AC5;
	Fri, 10 May 2024 16:34:43 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D6FFEA195;
	Fri, 10 May 2024 16:34:43 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 019B7204F433;
	Fri, 10 May 2024 16:34:42 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 1/2] cxl/core/regs: Add rcd_regs initialization at __rcrb_to_component()
Date: Fri, 10 May 2024 16:37:09 +0900
Message-ID: <20240510073710.98953-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510073710.98953-1-kobayashi.da-06@fujitsu.com>
References: <20240510073710.98953-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Add rcd_regs and its initialization at __rcrb_to_component() to cache
the cxl1.1 device link status information. Reduce access to the memory
map area where the RCRB is located by caching the cxl1.1 device
link status information.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/core/core.h |  4 ++++
 drivers/cxl/core/regs.c | 16 ++++++++++++++++
 drivers/cxl/cxl.h       |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3b64fb1b9ed0..42e3483b4a14 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -75,6 +75,10 @@ resource_size_t __rcrb_to_component(struct device *dev,
 				    enum cxl_rcrb which);
 u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 
+#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
+
 extern struct rw_semaphore cxl_dpa_rwsem;
 extern struct rw_semaphore cxl_region_rwsem;
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..1ad58c464488 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -514,6 +514,8 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	u32 bar0, bar1;
 	u16 cmd;
 	u32 id;
+	u16 offset;
+	u32 cap_hdr;
 
 	if (which == CXL_RCRB_UPSTREAM)
 		rcrb += SZ_4K;
@@ -537,6 +539,20 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	cmd = readw(addr + PCI_COMMAND);
 	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
 	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
+	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));
+	cap_hdr = readl(addr + offset);
+	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) != PCI_CAP_ID_EXP) {
+		offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
+		if (offset == 0 || offset > SZ_4K)
+			break;
+		cap_hdr = readl(addr + offset);
+	}
+	if (offset) {
+		ri->rcd_lnkcap = readl(addr + offset + PCI_EXP_LNKCAP);
+		ri->rcd_lnkctrl = readl(addr + offset + PCI_EXP_LNKCTL);
+		ri->rcd_lnkstatus = readl(addr + offset + PCI_EXP_LNKSTA);
+	}
+
 	iounmap(addr);
 	release_mem_region(rcrb, SZ_4K);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 003feebab79b..808818ccc255 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -646,6 +646,9 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 
 struct cxl_rcrb_info {
 	resource_size_t base;
+	u16 rcd_lnkstatus;
+	u16 rcd_lnkctrl;
+	u32 rcd_lnkcap;
 	u16 aer_cap;
 };
 
-- 
2.44.0


