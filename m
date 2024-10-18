Return-Path: <linux-pci+bounces-14867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA59A41A3
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393871F260BA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42224202F9A;
	Fri, 18 Oct 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIgK2aek"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C28202F83;
	Fri, 18 Oct 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262950; cv=none; b=jHHuP09b35UAGzZkAc7hTPRjAe4L+p5irxe9faozZP1SEGDD004A6U+4O4k1UGzZqnnMRmqMcyIpF7Pv6Sa+cxhAL0/gjEb49agnmFSbUkQZ8joKTznyLzHYyARZWOV5cVZh153cOXt/mi+VKbMeEOEKyEvFvBnn653UNCJaXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262950; c=relaxed/simple;
	bh=5QQyg+Ek9P0IO21rIM6tZcGrmnJSsuE/iaprWXXQ5I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJxutL0MJzhphXzAPW/50O/qmKt7gfL520MDmUvi6raq/l7LY9p55zO239duAENurEldEOFDDih9RoIg5ZpgCqP+HcdLgpk3TnLsD1oGbALIBgv2krFX4/pFgro4xImKqDiV6Z6ztsyk9kXwh2CDwvkRhkLAKOT9IIll2dycPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIgK2aek; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729262948; x=1760798948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5QQyg+Ek9P0IO21rIM6tZcGrmnJSsuE/iaprWXXQ5I4=;
  b=TIgK2aekOIwxs/tIYB6UxxEh1rhCrbeh3hXRxiaLnq1RfIieymzf8TGl
   HGcDHCd0lN6aR81etg019/aJHC4WZpZx6g0Q96pThI1LN/ENcmu5y7vq8
   dPMg8M2ICN0Ws9PHLP4yt/o7tJUVnJQGUXqkCfLH7YH7dfjaXNHFzAJUQ
   f7JqGY7dM1r7am5KKichIhtV6RCHXPTqLDRBXAw5nkCGYH1ZxMjZc0Awk
   bMVDkfDMO9lUj9MerIXxgoazCoDLiI6TJRo45A8fcrXu42F6OS8tiHREa
   S86hZ5kuaESYes95MRo/X/k+fsADOeKu90SQH2pPETUhan9z75ybaJQCs
   A==;
X-CSE-ConnectionGUID: lRl85LXqTIapr0AiDjCyaA==
X-CSE-MsgGUID: lOUcUx+wRuyhriVaWlWxuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="46296990"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="46296990"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:49:05 -0700
X-CSE-ConnectionGUID: /xxIdlMWTEyi2T86Y29DAQ==
X-CSE-MsgGUID: vK+XIJRZSQeLocF27b8Tdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="109708676"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:48:59 -0700
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
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 4/9] PCI: Refactor pcie_update_link_speed()
Date: Fri, 18 Oct 2024 17:47:50 +0300
Message-Id: <20241018144755.7875-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
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
register and create __pcie_update_link_speed() which can be used by the
hotplug code that has the register value at hand beforehand (and needs
the value for other purposes).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |  2 +-
 drivers/pci/pci.h                |  7 ++++++-
 drivers/pci/probe.c              | 12 +++++++-----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 736ad8baa2a5..bb5a8d9f03ad 100644
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
index 14d00ce45bfa..6e827d47aa85 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -378,7 +378,12 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
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
index af153a8e8225..c138daf78961 100644
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
 
@@ -827,13 +831,11 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 
 	if (pci_is_pcie(bridge)) {
 		u32 linkcap;
-		u16 linksta;
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
 		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
 
-		pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
-		pcie_update_link_speed(bus, linksta);
+		pcie_update_link_speed(bus);
 	}
 }
 
-- 
2.39.5


