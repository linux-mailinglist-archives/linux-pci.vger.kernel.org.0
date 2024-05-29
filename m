Return-Path: <linux-pci+bounces-8050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17448D3D0D
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7164281DF9
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D781181D06;
	Wed, 29 May 2024 16:44:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0E1836CE;
	Wed, 29 May 2024 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001052; cv=none; b=N9IbuiKbP51yEQIRGyCSAerQ+WS5p+d+AGGBQ+ePkBHQUhbnOMjoeJtN1oFGGqBVQh7l67EekMOmEFrUkePKuo1FFtGrpdXWxVdKwWL9pBdkUABX2zXOz0HcYpJ11vzlAVhkP5lX9ebq9FWdtWGQvlGniiKjTyMeSx95o5yu/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001052; c=relaxed/simple;
	bh=wrm5GeYkst4lwVJAHdOczrKLGYE1ebDvPZ1eFKGYzWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvfN/oAVdT+IZ+xvhXwdVnCmhnsnM8EUtT7gRzha8a1ul/XL0OcV3emu8mmVg98062OiQlewT6wQcJgUfbUw9OARIw1oHTOAKKXq3t4lVajI0/uYoYnDqi6SyFU0rDb/IdyqLj0GxqbbrsFM/dkwkg2tgvbAeFuTaeYZzLDbjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqFV24Z0Rz6K5sQ;
	Thu, 30 May 2024 00:39:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D0A97140B2A;
	Thu, 30 May 2024 00:44:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:44:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Will Deacon <will@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linuxarm@huawei.com>, <terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH 6/9] cxl: Move CPMU register definitions to header
Date: Wed, 29 May 2024 17:41:00 +0100
Message-ID: <20240529164103.31671-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
References: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

To do probing for maximum interrupt, the PCIe port driver needs
to access a few of these. Keep them all together by moving htem
all to driver/cxl/pmu.h.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/pmu.h      | 54 ++++++++++++++++++++++++++++++++++++++++++
 drivers/perf/cxl_pmu.c | 54 ------------------------------------------
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/cxl/pmu.h b/drivers/cxl/pmu.h
index b1e9bcd9f28c..a69ac6facad6 100644
--- a/drivers/cxl/pmu.h
+++ b/drivers/cxl/pmu.h
@@ -25,4 +25,58 @@ struct cxl_pmu_regs;
 int devm_cxl_pmu_add(struct device *parent, struct cxl_pmu_regs *regs,
 		     int assoc_id, int idx, enum cxl_pmu_type type);
 
+#define CXL_PMU_CAP_REG			0x0
+#define   CXL_PMU_CAP_NUM_COUNTERS_MSK			GENMASK_ULL(5, 0)
+#define   CXL_PMU_CAP_COUNTER_WIDTH_MSK			GENMASK_ULL(15, 8)
+#define   CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK		GENMASK_ULL(24, 20)
+#define   CXL_PMU_CAP_FILTERS_SUP_MSK			GENMASK_ULL(39, 32)
+#define     CXL_PMU_FILTER_HDM				BIT(0)
+#define     CXL_PMU_FILTER_CHAN_RANK_BANK		BIT(1)
+#define   CXL_PMU_CAP_MSI_N_MSK				GENMASK_ULL(47, 44)
+#define   CXL_PMU_CAP_WRITEABLE_WHEN_FROZEN		BIT_ULL(48)
+#define   CXL_PMU_CAP_FREEZE				BIT_ULL(49)
+#define   CXL_PMU_CAP_INT				BIT_ULL(50)
+#define   CXL_PMU_CAP_VERSION_MSK			GENMASK_ULL(63, 60)
+
+#define CXL_PMU_OVERFLOW_REG		0x10
+#define CXL_PMU_FREEZE_REG		0x18
+#define CXL_PMU_EVENT_CAP_REG(n)	(0x100 + 8 * (n))
+#define   CXL_PMU_EVENT_CAP_SUPPORTED_EVENTS_MSK	GENMASK_ULL(31, 0)
+#define   CXL_PMU_EVENT_CAP_GROUP_ID_MSK		GENMASK_ULL(47, 32)
+#define   CXL_PMU_EVENT_CAP_VENDOR_ID_MSK		GENMASK_ULL(63, 48)
+
+#define CXL_PMU_COUNTER_CFG_REG(n)	(0x200 + 8 * (n))
+#define   CXL_PMU_COUNTER_CFG_TYPE_MSK			GENMASK_ULL(1, 0)
+#define     CXL_PMU_COUNTER_CFG_TYPE_FREE_RUN		0
+#define     CXL_PMU_COUNTER_CFG_TYPE_FIXED_FUN		1
+#define     CXL_PMU_COUNTER_CFG_TYPE_CONFIGURABLE	2
+#define   CXL_PMU_COUNTER_CFG_ENABLE			BIT_ULL(8)
+#define   CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW		BIT_ULL(9)
+#define   CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW		BIT_ULL(10)
+#define   CXL_PMU_COUNTER_CFG_EDGE			BIT_ULL(11)
+#define   CXL_PMU_COUNTER_CFG_INVERT			BIT_ULL(12)
+#define   CXL_PMU_COUNTER_CFG_THRESHOLD_MSK		GENMASK_ULL(23, 16)
+#define   CXL_PMU_COUNTER_CFG_EVENTS_MSK		GENMASK_ULL(55, 24)
+#define   CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK	GENMASK_ULL(63, 59)
+
+#define CXL_PMU_FILTER_CFG_REG(n, f)	(0x400 + 4 * ((f) + (n) * 8))
+#define   CXL_PMU_FILTER_CFG_VALUE_MSK			GENMASK(31, 0)
+
+#define CXL_PMU_COUNTER_REG(n)		(0xc00 + 8 * (n))
+
+/* CXL rev 3.0 Table 13-5 Events under CXL Vendor ID */
+#define CXL_PMU_GID_CLOCK_TICKS		0x00
+#define CXL_PMU_GID_D2H_REQ		0x0010
+#define CXL_PMU_GID_D2H_RSP		0x0011
+#define CXL_PMU_GID_H2D_REQ		0x0012
+#define CXL_PMU_GID_H2D_RSP		0x0013
+#define CXL_PMU_GID_CACHE_DATA		0x0014
+#define CXL_PMU_GID_M2S_REQ		0x0020
+#define CXL_PMU_GID_M2S_RWD		0x0021
+#define CXL_PMU_GID_M2S_BIRSP		0x0022
+#define CXL_PMU_GID_S2M_BISNP		0x0023
+#define CXL_PMU_GID_S2M_NDR		0x0024
+#define CXL_PMU_GID_S2M_DRS		0x0025
+#define CXL_PMU_GID_DDR			0x8000
+
 #endif
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 1f93a66eff5b..65a8437ee236 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -24,60 +24,6 @@
 #include "../cxl/cxl.h"
 #include "../cxl/pmu.h"
 
-#define CXL_PMU_CAP_REG			0x0
-#define   CXL_PMU_CAP_NUM_COUNTERS_MSK			GENMASK_ULL(5, 0)
-#define   CXL_PMU_CAP_COUNTER_WIDTH_MSK			GENMASK_ULL(15, 8)
-#define   CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK		GENMASK_ULL(24, 20)
-#define   CXL_PMU_CAP_FILTERS_SUP_MSK			GENMASK_ULL(39, 32)
-#define     CXL_PMU_FILTER_HDM				BIT(0)
-#define     CXL_PMU_FILTER_CHAN_RANK_BANK		BIT(1)
-#define   CXL_PMU_CAP_MSI_N_MSK				GENMASK_ULL(47, 44)
-#define   CXL_PMU_CAP_WRITEABLE_WHEN_FROZEN		BIT_ULL(48)
-#define   CXL_PMU_CAP_FREEZE				BIT_ULL(49)
-#define   CXL_PMU_CAP_INT				BIT_ULL(50)
-#define   CXL_PMU_CAP_VERSION_MSK			GENMASK_ULL(63, 60)
-
-#define CXL_PMU_OVERFLOW_REG		0x10
-#define CXL_PMU_FREEZE_REG		0x18
-#define CXL_PMU_EVENT_CAP_REG(n)	(0x100 + 8 * (n))
-#define   CXL_PMU_EVENT_CAP_SUPPORTED_EVENTS_MSK	GENMASK_ULL(31, 0)
-#define   CXL_PMU_EVENT_CAP_GROUP_ID_MSK		GENMASK_ULL(47, 32)
-#define   CXL_PMU_EVENT_CAP_VENDOR_ID_MSK		GENMASK_ULL(63, 48)
-
-#define CXL_PMU_COUNTER_CFG_REG(n)	(0x200 + 8 * (n))
-#define   CXL_PMU_COUNTER_CFG_TYPE_MSK			GENMASK_ULL(1, 0)
-#define     CXL_PMU_COUNTER_CFG_TYPE_FREE_RUN		0
-#define     CXL_PMU_COUNTER_CFG_TYPE_FIXED_FUN		1
-#define     CXL_PMU_COUNTER_CFG_TYPE_CONFIGURABLE	2
-#define   CXL_PMU_COUNTER_CFG_ENABLE			BIT_ULL(8)
-#define   CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW		BIT_ULL(9)
-#define   CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW		BIT_ULL(10)
-#define   CXL_PMU_COUNTER_CFG_EDGE			BIT_ULL(11)
-#define   CXL_PMU_COUNTER_CFG_INVERT			BIT_ULL(12)
-#define   CXL_PMU_COUNTER_CFG_THRESHOLD_MSK		GENMASK_ULL(23, 16)
-#define   CXL_PMU_COUNTER_CFG_EVENTS_MSK		GENMASK_ULL(55, 24)
-#define   CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK	GENMASK_ULL(63, 59)
-
-#define CXL_PMU_FILTER_CFG_REG(n, f)	(0x400 + 4 * ((f) + (n) * 8))
-#define   CXL_PMU_FILTER_CFG_VALUE_MSK			GENMASK(31, 0)
-
-#define CXL_PMU_COUNTER_REG(n)		(0xc00 + 8 * (n))
-
-/* CXL rev 3.0 Table 13-5 Events under CXL Vendor ID */
-#define CXL_PMU_GID_CLOCK_TICKS		0x00
-#define CXL_PMU_GID_D2H_REQ		0x0010
-#define CXL_PMU_GID_D2H_RSP		0x0011
-#define CXL_PMU_GID_H2D_REQ		0x0012
-#define CXL_PMU_GID_H2D_RSP		0x0013
-#define CXL_PMU_GID_CACHE_DATA		0x0014
-#define CXL_PMU_GID_M2S_REQ		0x0020
-#define CXL_PMU_GID_M2S_RWD		0x0021
-#define CXL_PMU_GID_M2S_BIRSP		0x0022
-#define CXL_PMU_GID_S2M_BISNP		0x0023
-#define CXL_PMU_GID_S2M_NDR		0x0024
-#define CXL_PMU_GID_S2M_DRS		0x0025
-#define CXL_PMU_GID_DDR			0x8000
-
 static int cxl_pmu_cpuhp_state_num;
 
 struct cxl_pmu_ev_cap {
-- 
2.39.2


