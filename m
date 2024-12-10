Return-Path: <linux-pci+bounces-17984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8DD9EA710
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 05:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EE5168DE4
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 04:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA613635E;
	Tue, 10 Dec 2024 04:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LrNwwb0M"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F92248AF
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803810; cv=none; b=CnTssDgihoGPBuS/ezbRN+8MgcAl/qRWQUL5G8xEM3P0Iq204kwPi0j9FU0cgMwSHMvWTn/GaUqhkfkZx9s1nO2UqySnuTdoxxBm3hF5bfWZFFjv6GhrTz6snI2yecGOdzl1Gvr95L8knqQlaHzDbwqsk/IFNVvke9YjVVepP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803810; c=relaxed/simple;
	bh=S0MfjnLwqEwNLx8UWprx0QI2LjUg7NHVI991Am1rHrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8e3lcffJSAdrMzsdog39WVlkClmlI7EbdN9/vFO475SCWp2RP6QdiB/xNvxhJ5VEdiPBzj0OMgRgwNCK8SQ2jjwbtnWGyiT6Wd9hHtYnqfTo1+eoQhH6Rhfz9vgJdx3ojHb3VBzkjg4wIge+ziLlS7Qj8ZXxyWoWqzN/hrTySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LrNwwb0M; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1733803808; x=1765339808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0MfjnLwqEwNLx8UWprx0QI2LjUg7NHVI991Am1rHrY=;
  b=LrNwwb0MLcxBGf2diCw12dHQ7csrUZv+pHteBN94gPmVpXLt8sPPi7AY
   wf/6Sq1K96pV94Z4EM7dVnwQ4tbnM4MxuAZzt63jqFdV5sjD+6JAl7KzK
   UHCV6/wDfxaWJs95UXSeidt+Y6rpGx5GMACgBH5FYThBw8TICWJ+oIfsU
   u7XCCvdit0gyYOvgTPI+WRmncxFYpTgeqgF279OF4jzs8O8Uf7KgoVfNq
   aQKNUt4t1YBDSwYNOjYF9CI/NwQOLd1AG3ieCTEAtEICHHtzNig/woqXA
   yOW/biRLxnt/7jn+M3K8XXExW9eyrn/6FlNoe5QfQw2L1LK84h1BOyyTA
   A==;
X-CSE-ConnectionGUID: 6w0ZCRIBRNS3aEbpgyN63w==
X-CSE-MsgGUID: 3IToyVgJSmyEgTb1Dm43ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="183194435"
X-IronPort-AV: E=Sophos;i="6.12,221,1728918000"; 
   d="scan'208";a="183194435"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:08:47 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1A6E2C2260
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 13:08:45 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E5498D4C11
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 13:08:44 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id AEFB42020FA6;
	Tue, 10 Dec 2024 13:08:44 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	kw@linux.com,
	linux-pci@vger.kernel.org
Cc: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v5 1/2] Add helper functions for Power Budgeting Extended Capability
Date: Tue, 10 Dec 2024 13:08:20 +0900
Message-ID: <20241210040826.11402-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241210040826.11402-1-kobayashi.da-06@fujitsu.com>
References: <20241210040826.11402-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add functions to return a text description of the supplied
power_budget scale/base power/rail.
Export these functions so they can be used by modules.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/pci/pci.h             |  3 ++
 drivers/pci/probe.c           | 66 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |  3 +-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..967b53996694 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -374,6 +374,9 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 }
 
 const char *pci_speed_string(enum pci_bus_speed speed);
+const char *pci_power_budget_scale_string(u8 num);
+const char *pci_power_budget_alt_encode_string(u8 num);
+const char *pci_power_budget_rail_string(u8 num);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f1615805f5b0..18a920527f69 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -748,6 +748,72 @@ void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
 }
 EXPORT_SYMBOL_GPL(pcie_update_link_speed);
 
+const char *pci_power_budget_rail_string(u8 num)
+{
+	/* Indexed by the rail number */
+	static const char *rail_strings[] = {
+	    "Power(12V)",		/* 0x00 */
+	    "Power(3.3V)",		/* 0x01 */
+	    "Power(1.5Vor1.8V)",		/* 0x02 */
+	    "Power(48V)",		/* 0x03 */
+	    "Power(5V)",		/* 0x04 */
+	    "Thermal",			/* 0x05 */
+	};
+
+	if (num < ARRAY_SIZE(rail_strings))
+		return rail_strings[num];
+	return "Unknown";
+}
+EXPORT_SYMBOL_GPL(pci_power_budget_rail_string);
+
+const char *pci_power_budget_scale_string(u8 num)
+{
+	/* Indexed by the scale number */
+	static const char *scale_strings[] = {
+	    "x1.0",		/* 0x00 */
+	    "x0.1",		/* 0x01 */
+	    "x0.01",		/* 0x02 */
+	    "x0.001",		/* 0x03 */
+	    "x10",		/* 0x04 */
+	    "x100",			/* 0x05 */
+	};
+
+	if (num < ARRAY_SIZE(scale_strings))
+		return scale_strings[num];
+	return "Unknown";
+}
+EXPORT_SYMBOL_GPL(pci_power_budget_scale_string);
+
+const char *pci_power_budget_alt_encode_string(u8 num)
+{
+	u8 n;
+	n = num & 0x0f;
+	/* Indexed by the Base Power number */
+	static const char *Power_strings[] = {
+	    "> 239 W and ≤ 250 W Slot Power Limit",		/* 0xF0 */
+	    "> 250 W and ≤ 275 W Slot Power Limit",		/* 0xF1 */
+	    "> 275 W and ≤ 300 W Slot Power Limit",		/* 0xF2 */
+	    "> 300 W and ≤ 325 W Slot Power Limit",		/* 0xF3 */
+	    "> 325 W and ≤ 350 W Slot Power Limit",		/* 0xF4 */
+	    "> 350 W and ≤ 375 W Slot Power Limit",		/* 0xF5 */
+	    "> 375 W and ≤ 400 W Slot Power Limit",		/* 0xF6 */
+	    "> 400 W and ≤ 425 W Slot Power Limit",		/* 0xF7 */
+	    "> 425 W and ≤ 450 W Slot Power Limit",		/* 0xF8 */
+	    "> 450 W and ≤ 475 W Slot Power Limit",		/* 0xF9 */
+	    "> 475 W and ≤ 500 W Slot Power Limit",		/* 0xFA */
+	    "> 500 W and ≤ 525 W Slot Power Limit",		/* 0xFB */
+	    "> 525 W and ≤ 550 W Slot Power Limit",		/* 0xFC */
+	    "> 550 W and ≤ 575 W Slot Power Limit",		/* 0xFD */
+	    "> 575 W and ≤ 600 W Slot Power Limit",		/* 0xFE */
+	    "Greater than 600 W",		/* 0xFF */
+	};
+
+	if (n < ARRAY_SIZE(Power_strings))
+		return Power_strings[n];
+	return "Unknown";
+}
+EXPORT_SYMBOL_GPL(pci_power_budget_alt_encode_string);
+
 static unsigned char agp_speeds[] = {
 	AGP_UNKNOWN,
 	AGP_1X,
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 12323b3334a9..3a5e238b98d8 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -842,11 +842,12 @@
 #define PCI_PWR_DSR		0x04	/* Data Select Register */
 #define PCI_PWR_DATA		0x08	/* Data Register */
 #define  PCI_PWR_DATA_BASE(x)	((x) & 0xff)	    /* Base Power */
-#define  PCI_PWR_DATA_SCALE(x)	(((x) >> 8) & 3)    /* Data Scale */
+#define  PCI_PWR_DATA_SCALE(x)	(((x) >> 8) & 3)    /* Data Scale[1:0] */
 #define  PCI_PWR_DATA_PM_SUB(x)	(((x) >> 10) & 7)   /* PM Sub State */
 #define  PCI_PWR_DATA_PM_STATE(x) (((x) >> 13) & 3) /* PM State */
 #define  PCI_PWR_DATA_TYPE(x)	(((x) >> 15) & 7)   /* Type */
 #define  PCI_PWR_DATA_RAIL(x)	(((x) >> 18) & 7)   /* Power Rail */
+#define  PCI_PWR_DATA_SCALE_UP(x)	(((x) >> 21) & 1)    /* Data Scale[2] */
 #define PCI_PWR_CAP		0x0c	/* Capability */
 #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
 #define PCI_EXT_CAP_PWR_SIZEOF	0x10
-- 
2.45.0


