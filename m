Return-Path: <linux-pci+bounces-5916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B889D33D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 09:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D6E7B24237
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 07:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A79537E6;
	Tue,  9 Apr 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="E0lGS8oj"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DB7D3F7;
	Tue,  9 Apr 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648010; cv=none; b=cd1WW/bPxloexClPWdjyY8uK+6cJEYMtsP+Vv85E2z6RIijHz9ZD1djZQ8r2pYV6RYhCkRPuQOUlC6r0ZPix0SHt2cBeiwT4ySSQnNxw6P/rkLLOUreqhIoT3uL6H2y8txw4XBoZBpPvHwoxw0JtSXa6bsuEfajlWj4xz/oPiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648010; c=relaxed/simple;
	bh=WOz53IFk3XpJYU+ZqEfac1yqvSj/RaZIfJvfEww8Mcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsDhErQYPNANJ6qditcdZuGr28HujWRthLVvVGM/bpELWeYU6f41Ryr1KgA1JptMRVZ0tXmzuS92zru+2mcL08wkNJgVuB0KXEbjRbMr8ejJVyMRQSiLcwFHmegqcZIUEaEXjJa9S6F8TBS5EmxFZyi+j+zmh4oW6QY09Tsua7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=E0lGS8oj; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712648009; x=1744184009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WOz53IFk3XpJYU+ZqEfac1yqvSj/RaZIfJvfEww8Mcs=;
  b=E0lGS8ojtYXQnDOIBhAUrfF1ZHKTFHVfqkgG2hKSIkqIrR3DJxb1Pbeb
   YG1sIzjZsojsqzUXMGxlEcxV9AkZu+YlylB+ryRYIg7v7Ik/ZH/eCyuKL
   61w9qbAz+ea8fNKnnJbseRmNycu2SWSCmDx+tDfWFqiOUHorGBkgYFxbu
   SoOoeuQ68PwJMBBHwh94YRDnDvyKtcu76eXk+bG2nI5bro4rwCc0Uo8sH
   3SrzZTCX5WlFV3ze16fBhz8huQ0ujcF8OS5beDRWbd2f8LOm+B31YNBcA
   eeXhOzDWzdW95Mhi8wtbyWxLmRbfCrIDT4j+N1hGZsIRVSxiqB0g9fW4J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="134397682"
X-IronPort-AV: E=Sophos;i="6.07,189,1708354800"; 
   d="scan'208";a="134397682"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:33:24 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A9BB8D4801;
	Tue,  9 Apr 2024 16:33:21 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id DA822D3E1A;
	Tue,  9 Apr 2024 16:33:20 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id A3C07204E19D;
	Tue,  9 Apr 2024 16:33:20 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v4 2/3] cxl/core/regs: Add rcd_regs initialization at __rcrb_to_component()
Date: Tue,  9 Apr 2024 16:35:27 +0900
Message-ID: <20240409073528.13214-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
References: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Add rcd_regs initialization at __rcrb_to_component() to cache the cxl1.1
device link status information. Reduce access to the memory map area
where the RCRB is located by caching the cxl1.1 device link status information.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/core/regs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..308eb951613e 100644
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
@@ -537,6 +539,22 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	cmd = readw(addr + PCI_COMMAND);
 	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
 	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
+
+	offset = readw(addr + PCI_CAPABILITY_LIST);
+	offset &= 0x00ff;
+	cap_hdr = readl(addr + offset);
+	while ((cap_hdr & 0x000000ff) != PCI_CAP_ID_EXP) {
+		offset = (cap_hdr >> 8) & 0x000000ff;
+		if (offset == 0) // End of capability list
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
 
-- 
2.44.0


