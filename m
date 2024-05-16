Return-Path: <linux-pci+bounces-7557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30258C73D5
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3A81C22D0F
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4119C136E0A;
	Thu, 16 May 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QL2IJDoM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A729414375A;
	Thu, 16 May 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852009; cv=none; b=PMAfDXx5+ITo7Pt4o5FMZAakNoUyop2DErLzR2oR+4RjMa0KSJ4IAnsnsOtdaEFlaNDPuvYsrQyOptS00lcBUdpC0Dcw0osMtC5IYEgUJV703xIgi2C+2t9LaFr0UlLSeItu5PTk+0fUEQTXA/s4G5PCnTj2FrqmwkAdZ1mDDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852009; c=relaxed/simple;
	bh=BVjR8kQOCaRR8HeUse8J/wqXd6QjtOPOLht8xEyki8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Czws62ZED3VKP21ziqxd2BJ40gOa3JWZIQ5XX5CZbPV4OG8iI0Jl20U02/FQFOWvZRe99ik8U+08VJzVycyvR3ek5/RTMcHUuI68FDA0lWzA1mZ4pGcVF5rNQBLRWe/jslEykewrVxd5Lu2ttq+mz112yWyFavVG6HxtoQ1s6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QL2IJDoM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715852008; x=1747388008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BVjR8kQOCaRR8HeUse8J/wqXd6QjtOPOLht8xEyki8E=;
  b=QL2IJDoM+4kkNYkLNXFgQM1HBF1dmZbmxIaD5AphW8qwGXP3WVBkz3fB
   yS7scP86tHBJD+23GMDtEVufle3JXmcepcdBkqaRp98Kxi/fqo9FMYsyx
   YmDJ5sjVdilFNxyBVotSeBka2zGGu0aH1wt3YRXAC3O7yF3PvCfROjmTo
   HvPuEnWidb0vV9Z2l4hIKjTJgYNT5dNx5UUkIPkGYsJsHoCBksR5UNUJC
   UXRJPYgyFhPvCElDQgv3qe6fRgm85PnzsL9BUroP8sgTgC578JxcDjmOq
   Qp9nvc9KCojiYTqOOVBMcHxl98tGrTTO+lYneKk7C6LLAs2OOgr9jyULQ
   g==;
X-CSE-ConnectionGUID: bZQTn8Q9Spmd33baNoaPiA==
X-CSE-MsgGUID: ovYjORLWQHyZonV/kg2oWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22553268"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="22553268"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:33:27 -0700
X-CSE-ConnectionGUID: xAeTtwk6RV+yOuw3JBfRrg==
X-CSE-MsgGUID: 1WKycw3kR+mp9BabvqCAvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31197217"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:33:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 3/8] PCI: Refactor pcie_update_link_speed()
Date: Thu, 16 May 2024 12:32:17 +0300
Message-Id: <20240516093222.1684-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240516093222.1684-1-ilpo.jarvinen@linux.intel.com>
References: <20240516093222.1684-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pcie_update_link_speed() is passed the Link Status register but not all
callers have that value at hand nor need the value.

Refactor pcie_update_link_speed() to include reading the Link Status
register into pcie_update_link_speed() and create
__pcie_update_link_speed() which can be used by the hotplug code that
has the register value at hand beforehand (and needs the value for
other purposes).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |  2 +-
 drivers/pci/pci.h                |  7 ++++++-
 drivers/pci/probe.c              | 12 +++++++-----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b1d0a1b3917d..0d818110af6d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -319,7 +319,7 @@ int pciehp_check_link_status(struct controller *ctrl)
 		return -1;
 	}
 
-	pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
+	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
 
 	if (!found) {
 		ctrl_info(ctrl, "Slot(%s): No device found\n",
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 48eae81a0a43..664191768395 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -297,7 +297,12 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 			   enum pcie_link_width *width);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
-void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
+
+static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
+{
+	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+}
+void pcie_update_link_speed(struct pci_bus *bus);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1b08b3f16027..65413d408b3d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -742,9 +742,13 @@ const char *pci_speed_string(enum pci_bus_speed speed)
 }
 EXPORT_SYMBOL_GPL(pci_speed_string);
 
-void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
+void pcie_update_link_speed(struct pci_bus *bus)
 {
-	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+	struct pci_dev *bridge = bus->self;
+	u16 linksta;
+
+	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
+	__pcie_update_link_speed(bus, linksta);
 }
 EXPORT_SYMBOL_GPL(pcie_update_link_speed);
 
@@ -827,15 +831,13 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 
 	if (pci_is_pcie(bridge)) {
 		u32 linkcap;
-		u16 linksta;
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
 		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
 		if (bus->max_bus_speed != PCI_SPEED_UNKNOWN)
 			bus->supported_speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
 
-		pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
-		pcie_update_link_speed(bus, linksta);
+		pcie_update_link_speed(bus);
 	}
 }
 
-- 
2.39.2


