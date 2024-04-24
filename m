Return-Path: <linux-pci+bounces-6608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74D8B00BF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 06:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB94D2840F6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 04:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBBF1339BA;
	Wed, 24 Apr 2024 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="E6oXAzqe"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF894328DB;
	Wed, 24 Apr 2024 04:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934792; cv=none; b=AOhFdZlmoGUe0HK6Ev16PAXBUxnLfCk9EINvs4IhYr2tTavxyucEjsDFgJwX0TJk4H9o3g5ITbTDjCDphoUTgy6/IIYCttilKh2Uf9DzuggcnzAtX45jlnCUYzaeaJFOtAioemfuBbkPUiBlLyd3aFzkte+Ij2PgDlbP/tsXVIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934792; c=relaxed/simple;
	bh=osBiAtgiI/y48b+hgDmQmco3S8kOJXH2PbWG46vZP8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSmcdNdBZ3HzDt4E31zwOEkO2xzhaDJadRZ+PLPbNKi8Rq/eUO8sCoPQEenl13HCfnaVq3TUwC0LBbyIOmqyCNaFIqD2jNHZ3zjz1YO47OLFkEosh5LVF3qiaOzlP1PVGWUXlBDXJhkF63lGek10bbYbDjYd3b1UYygeOIXaQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=E6oXAzqe; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713934790; x=1745470790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=osBiAtgiI/y48b+hgDmQmco3S8kOJXH2PbWG46vZP8U=;
  b=E6oXAzqeoKDFtQRbubq9fqbQI58XFYEZIIi4iT0Ap1ndSr3HusufxzTd
   mxCkJN+XS8fCSUlrmQYeySGHEk9mxKFY0Lno+w1sDI7sw2TLZJGhKvpiy
   n51fMpLMJ54XURn27icNwNafKlEwRbsDEoU9VdW/Qdf8acZjqa3qu6jEB
   zzQV7NYJx71zP42Ti2IMPlQtztkl5LRWZWC9gDabVa99eunecDWnJPAKo
   +FkgE4Oqxmdunxhs5h7yuucXVUSKJWbod5z+99d9/17Egno9ei+Yctkb4
   gAHgV7HSPk27X/FZdZ+rWs5aFj2+vXQS0PRksiYyzcvaVAHvIhBGdnpfw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="144122128"
X-IronPort-AV: E=Sophos;i="6.07,225,1708354800"; 
   d="scan'208";a="144122128"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 13:58:37 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 56847C6905;
	Wed, 24 Apr 2024 13:58:35 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9D800D3F35;
	Wed, 24 Apr 2024 13:58:34 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 7137020059A9;
	Wed, 24 Apr 2024 13:58:34 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v6 1/2] cxl/core/regs: Add rcd_regs initialization at __rcrb_to_component()
Date: Wed, 24 Apr 2024 14:01:01 +0900
Message-ID: <20240424050102.26788-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424050102.26788-1-kobayashi.da-06@fujitsu.com>
References: <20240424050102.26788-1-kobayashi.da-06@fujitsu.com>
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

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/core/core.h |  4 +++-
 drivers/cxl/core/regs.c | 16 ++++++++++++++++
 drivers/cxl/cxl.h       |  3 +++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3b64fb1b9ed0..66f62b5bb9f7 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -74,7 +74,9 @@ resource_size_t __rcrb_to_component(struct device *dev,
 				    struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which);
 u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
-
+#define PCI_RCRB_CAP_LIST_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
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
+	offset = FIELD_GET(PCI_RCRB_CAP_LIST_MASK, readw(addr + PCI_CAPABILITY_LIST));
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


