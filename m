Return-Path: <linux-pci+bounces-7764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536708CCA0B
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 02:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1434281F5F
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 00:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE16193;
	Thu, 23 May 2024 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ddz/z1CM"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2FE191
	for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716423059; cv=none; b=IQDvIuhclq/ZJTdgE8U9++YiNUJKreBfWaee8VbOWc5Ns1MRkO/bPDLi14cQhlLMPjpgKlWsey6EI/qFROVSv03NBDoJ+mT9HqXzjnyByBpPy+MeRHOClYpWEfrx3JTMRGQonPYl9XY3q+N9aWEhfvWyTVNI4JV5rw2ViPU27G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716423059; c=relaxed/simple;
	bh=ufZiyROEYhyXGPyDzftuRvadjU8HDWTyXGjXTU0VeNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QeFDslDn0KFRljmjfTdtaL82HAs8PO8JVgnU63EwISHl0WyfJbb4SlEglB1eVb5f04UqKyh0MiGdpTc40ajYZ3XCw7KUt1/vz4bwJy38h14e13ELtte2TYnjpnqfJ0M/0TdcgRgZxu7+0meUFWLYdoXwWBsWkN3MBSJoHtug/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ddz/z1CM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from thinkpad-p16sg1.vs.shawcable.net (S010600cb7a0d6c8b.vs.shawcable.net [96.55.224.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id CC5FC20679CC;
	Wed, 22 May 2024 17:10:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC5FC20679CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716423052;
	bh=vi4cljN34wEOGOq+bVo6SKAOYfGzkVR5ty5XyoIkqOg=;
	h=From:To:Cc:Subject:Date:From;
	b=Ddz/z1CM71KRX8/cby0HIe0x56OMyU0Z4aAj6CSB83EEyWYFgOnOStI11vZsQdV2d
	 EHUgctpZS9yIyyPhqqQOREA4KniGXmWbGcWZjx4l+G3mqXDgToFGtdJH54FErx+HJP
	 pmOcGGjdJLhiwVU+BncGOPebrWkfGdkv6W67mR90=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: linux-pci@vger.kernel.org
Cc: jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	Sergey.Semin@baikalelectronics.ru,
	code@tyhicks.com,
	okaya@kernel.org,
	srivatsa@csail.mit.edu,
	apais@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	tballasi@linux.microsoft.com,
	bboscaccy@linux.microsoft.com
Subject: [PATCH] drivers: pci: dwc: dynamically set pci region limit
Date: Wed, 22 May 2024 17:10:46 -0700
Message-Id: <20240523001046.1413579-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 89473aa9ab26 ("PCI: dwc: Add iATU regions size detection procedure")
hardcodes the pci region limit to 4G. This causes regression on
systems with PCI memory region higher than 4G.

Fix this by dynamically setting pci region limit based on maximum
size of memory ranges in the PCI device tree node.

Fixes: 89473aa9ab26 ("PCI: dwc: Add iATU regions size detection procedure")
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b85..9b8975b35dd9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -783,6 +783,9 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
 	int max_region, ob, ib;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct resource_entry *entry;
+	u64 max_mem_sz = 0;
 	u32 val, min, dir;
 	u64 max;
 
@@ -832,10 +835,25 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 		max = 0;
 	}
 
+	resource_list_for_each_entry(entry, &pp->bridge->windows) {
+		if (resource_type(entry->res) != IORESOURCE_MEM)
+			continue;
+		max_mem_sz = (max_mem_sz < resource_size(entry->res)) ?
+						resource_size(entry->res) : max_mem_sz;
+	}
+
+	if (max_mem_sz <= SZ_4G)
+		pci->region_limit = (max << 32) | (SZ_4G - 1);
+	else if ((max_mem_sz > SZ_4G) && (max_mem_sz <= SZ_8G))
+		pci->region_limit = (max << 32) | (SZ_8G - 1);
+	else if ((max_mem_sz > SZ_8G) && (max_mem_sz <= SZ_16G))
+		pci->region_limit = (max << 32) | (SZ_16G - 1);
+	else
+		pci->region_limit = (max << 32) | (SZ_32G - 1);
+
 	pci->num_ob_windows = ob;
 	pci->num_ib_windows = ib;
 	pci->region_align = 1 << fls(min);
-	pci->region_limit = (max << 32) | (SZ_4G - 1);
 
 	dev_info(pci->dev, "iATU: unroll %s, %u ob, %u ib, align %uK, limit %lluG\n",
 		 dw_pcie_cap_is(pci, IATU_UNROLL) ? "T" : "F",
-- 
2.34.1


