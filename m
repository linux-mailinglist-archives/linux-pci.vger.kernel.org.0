Return-Path: <linux-pci+bounces-6167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E18A2799
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3ADCB23C3A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DF851C4F;
	Fri, 12 Apr 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TW/GKxb7"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FE524B8;
	Fri, 12 Apr 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905499; cv=none; b=tZWeBPo+oyYO2LWtc35bK40A3j/teMnATRTYxe4kJyL8gPlzXVR/5KJH/vuO6/tSxIKXRxIb86m1mhq/lLaygHIv7Rpl841V4Big0p25x8TKXjdIpoA0Sg8iLQg25BsSI/vv3dGc6V5eGQ1CXXrVW6gkd2S0D/Wth005DFjKzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905499; c=relaxed/simple;
	bh=bZoKYgzce3mt6j7p8NSqBxytIhrtz4Jf1jdPXHOwSho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMdgmlH/UaS2Zy+BINd07TwXFXtkYsBDCCGwEGASqmer24fUrJkHpGDY79BY9mD7Uq4fKQZPTn4vEZtKD6TtHl/xdgmQcF8MrSmSN2R0aaNoJEZVe7m0Ks6UC8obxXbxqRcBX7zLILDjc9ZZUirwFKyZu5kWyK+bXnaupw4Caqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TW/GKxb7; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712905497; x=1744441497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZoKYgzce3mt6j7p8NSqBxytIhrtz4Jf1jdPXHOwSho=;
  b=TW/GKxb78cK4sTIXqRzFIfnMy988CDMKX0NlposCoXSrXU7c4sAFccAJ
   xJtFz87SHtkIn7GkrKyOh8tb7aAeYgskURIstfUlyU3tA5SQhplkESIGA
   oDO5+iCn4p41UUqjU6X4fdT/0Xhp6E7YMi+zP4JrEPaXgJG4qk6kaqMJw
   /61Jt1JjuA76+EZF7Dl2Yo2t+X4J4WfpHXvDg8D25zI0is6Q+7QzA3eKE
   g3F+dDjFoWnpyvkJk6jfq6Hn/jUvQEf/bUVJBXX3CB0LretNGSp2fx43h
   OJgZtlDKSf/g1qyQJkiu4MSz5CGTHy60v6CSPbDs6F3mMNF6s4Se0lxcI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="134763264"
X-IronPort-AV: E=Sophos;i="6.07,195,1708354800"; 
   d="scan'208";a="134763264"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 16:04:48 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3CDF7DCB6A;
	Fri, 12 Apr 2024 16:04:46 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 72254106CDA;
	Fri, 12 Apr 2024 16:04:45 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 37EE9209C7C0;
	Fri, 12 Apr 2024 16:04:45 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v5 1/2] cxl/core/regs: Add rcd_regs initialization at __rcrb_to_component()
Date: Fri, 12 Apr 2024 16:07:14 +0900
Message-ID: <20240412070715.16160-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412070715.16160-1-kobayashi.da-06@fujitsu.com>
References: <20240412070715.16160-1-kobayashi.da-06@fujitsu.com>
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
 drivers/cxl/core/regs.c | 16 ++++++++++++++++
 drivers/cxl/cxl.h       |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..e0e96be0ca7d 100644
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
+	offset = FIELD_GET(GENMASK(7, 0), readw(addr + PCI_CAPABILITY_LIST));
+	cap_hdr = readl(addr + offset);
+	while ((cap_hdr & GENMASK(7, 0)) != PCI_CAP_ID_EXP) {
+		offset = (cap_hdr >> 8) & GENMASK(7, 0);
+		if (offset == 0)
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
index 003feebab79b..2dc827c301a1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -647,6 +647,9 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 struct cxl_rcrb_info {
 	resource_size_t base;
 	u16 aer_cap;
+	u16 rcd_lnkctrl;
+	u16 rcd_lnkstatus;
+	u32 rcd_lnkcap;
 };
 
 /**
-- 
2.44.0


