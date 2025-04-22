Return-Path: <linux-pci+bounces-26390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B98A9683D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62383A96DC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672E727BF89;
	Tue, 22 Apr 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mX4QKfZn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255A1BD01F;
	Tue, 22 Apr 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322964; cv=none; b=W6t/HMlO1cA4+NNa3QAYMyEQJBdI4dtIQOjlAWjnw1O0pv6ax1eUtvdpB2TwuWFyqkjdwngBwhwkmiDcetxkfLjlcJnqO1aEKRle7GkoyU+G2my4L4S9MnsIkYwSM659AQHm+P4q6qX7hSoDi/yGE1Sr/6mDsv9UyPw2JyPwfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322964; c=relaxed/simple;
	bh=gkHzVAMMkbJ6Fap0nJjFklUMUY/ruYl+4tM/Sb7pVjc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k88eysrcmvm8leragHwYNdxBtGww5n8h1tk4xKMrR6fK9cdtkF6oYKkkW5qfB/akP0lDuFNCyHmuyYGWC1G35SP9kVtz96OxDWqopm0pGscaK0Goehr9YLWZNcBNnLAL8LbOc14DXbyyFaAelyuEUtGJp/JMy4rLsm7Mx72IqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mX4QKfZn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745322962; x=1776858962;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gkHzVAMMkbJ6Fap0nJjFklUMUY/ruYl+4tM/Sb7pVjc=;
  b=mX4QKfZnHA8nwlRyd0eGmQ2QrBeKe3hE5NzvfIgl9HDToyV2tdSMU07x
   iYgXJuPs2prtMMqIb7k5iIF2RW+CQQWNA3w7utn8trY5vxz5ig8Sac0ZR
   /u7hg6kTf9J1I70tvZDcmIE3KsPKPjdZzQEr9uDaWIdDD58wY+Bgw81Uo
   oy4Wey0Uo8Ky/e5vzmJIlVvHy20cczV47mfXZri0uU5FdJd8xcWCMqsMj
   z2tc3QVRXGKNAfM2qombG9XZkeq18U4PP8BXdpj03MDc4XuKXZuDKPEE2
   zNc4TDXY+kavsYqDGCUUePKr+yuHPU/nPeKiz9FfZOUvWHmt8lrF30oOU
   w==;
X-CSE-ConnectionGUID: K+Le+dpvQIeTu73CVZhkBQ==
X-CSE-MsgGUID: r3LJ/RDQQqibRp8znelQWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="57541944"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="57541944"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 04:56:02 -0700
X-CSE-ConnectionGUID: VMNAYFGeSKiT43Vo4IlbRw==
X-CSE-MsgGUID: LFVXNem+S3aHCrCxPInQ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="131842035"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 04:56:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN flag
Date: Tue, 22 Apr 2025 14:55:47 +0300
Message-Id: <20250422115548.1483-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe BW controller counts LBMS assertions for the purposes of the
Target Speed quirk. It was also a plan to expose the LBMS count through
sysfs to allow better diagnosing link related issues. Lukas Wunner
suggested, however, that adding a trace event would be better for
diagnostics purposes. Leaving only Target Speed quirk as an user of the
lbms_count.

The logic in the Target Speed quirk does not require keeping count of
LBMS assertions but a simple flag is enough which can be placed into
pci_dev's priv_flags. The reduced complexity allows removing
pcie_bwctrl_lbms_rwsem.

As bwctrl is not yet probed when the Target Speed quirk runs during
boot, the LBMS in Link Status register has to still be checked by
the quirk.

The priv_flags numbering is not continuous because hotplug code added
a few flags to fill numbers 4-5 (hotplug and bwctrl changes are routed
through in different branches).

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

This will conflict with the new flags Lukas added due to the hp fixes
but it should be simple to deal with that conflict while merging the
topic branches.

v2:
- Change flag value to 6 to make merging with the newly added HP flags easier
- Renamed flag to PCI_LINK_LBMS_SEEN to match the naming of the new HP flags

 drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
 drivers/pci/pci.c                 |  2 +-
 drivers/pci/pci.h                 | 10 ++---
 drivers/pci/pcie/bwctrl.c         | 63 +++++++++----------------------
 drivers/pci/quirks.c              | 10 ++---
 5 files changed, 25 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index d603a7aa7483..bcc938d4420f 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -131,7 +131,7 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
 			      INDICATOR_NOOP);
 
 	/* Don't carry LBMS indications across */
-	pcie_reset_lbms_count(ctrl->pcie->port);
+	pcie_reset_lbms(ctrl->pcie->port);
 }
 
 static int pciehp_enable_slot(struct controller *ctrl);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24..3d94cf33c1b6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4757,7 +4757,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	 * to track link speed or width changes made by hardware itself
 	 * in attempt to correct unreliable link operation.
 	 */
-	pcie_reset_lbms_count(pdev);
+	pcie_reset_lbms(pdev);
 	return rc;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..887811fbe722 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -557,6 +557,7 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 #define PCI_DPC_RECOVERED 1
 #define PCI_DPC_RECOVERING 2
 #define PCI_DEV_REMOVED 3
+#define PCI_LINK_LBMS_SEEN	6
 
 static inline void pci_dev_assign_added(struct pci_dev *dev)
 {
@@ -824,14 +825,9 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
-void pcie_reset_lbms_count(struct pci_dev *port);
-int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
+void pcie_reset_lbms(struct pci_dev *port);
 #else
-static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
-static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
-{
-	return -EOPNOTSUPP;
-}
+static inline void pcie_reset_lbms(struct pci_dev *port) {}
 #endif
 
 struct pci_dev_reset_methods {
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index d8d2aa85a229..ab0387ff2de2 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -38,12 +38,10 @@
 /**
  * struct pcie_bwctrl_data - PCIe bandwidth controller
  * @set_speed_mutex:	Serializes link speed changes
- * @lbms_count:		Count for LBMS (since last reset)
  * @cdev:		Thermal cooling device associated with the port
  */
 struct pcie_bwctrl_data {
 	struct mutex set_speed_mutex;
-	atomic_t lbms_count;
 	struct thermal_cooling_device *cdev;
 };
 
@@ -202,15 +200,14 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {
-	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
 	struct pci_dev *port = srv->port;
 	u16 link_status;
 	int ret;
 
-	/* Count LBMS seen so far as one */
+	/* Note down if LBMS has been seen so far */
 	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
 	if (ret == PCIBIOS_SUCCESSFUL && link_status & PCI_EXP_LNKSTA_LBMS)
-		atomic_inc(&data->lbms_count);
+		set_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
 
 	pcie_capability_set_word(port, PCI_EXP_LNKCTL,
 				 PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
@@ -233,7 +230,6 @@ static void pcie_bwnotif_disable(struct pci_dev *port)
 static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
 {
 	struct pcie_device *srv = context;
-	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
 	struct pci_dev *port = srv->port;
 	u16 link_status, events;
 	int ret;
@@ -247,7 +243,7 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
 		return IRQ_NONE;
 
 	if (events & PCI_EXP_LNKSTA_LBMS)
-		atomic_inc(&data->lbms_count);
+		set_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
 
 	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
 
@@ -262,31 +258,10 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
-void pcie_reset_lbms_count(struct pci_dev *port)
+void pcie_reset_lbms(struct pci_dev *port)
 {
-	struct pcie_bwctrl_data *data;
-
-	guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
-	data = port->link_bwctrl;
-	if (data)
-		atomic_set(&data->lbms_count, 0);
-	else
-		pcie_capability_write_word(port, PCI_EXP_LNKSTA,
-					   PCI_EXP_LNKSTA_LBMS);
-}
-
-int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
-{
-	struct pcie_bwctrl_data *data;
-
-	guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
-	data = port->link_bwctrl;
-	if (!data)
-		return -ENOTTY;
-
-	*val = atomic_read(&data->lbms_count);
-
-	return 0;
+	clear_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
+	pcie_capability_write_word(port, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
 }
 
 static int pcie_bwnotif_probe(struct pcie_device *srv)
@@ -308,18 +283,16 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 		return ret;
 
 	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
-		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
-			port->link_bwctrl = data;
+		port->link_bwctrl = data;
 
-			ret = request_irq(srv->irq, pcie_bwnotif_irq,
-					  IRQF_SHARED, "PCIe bwctrl", srv);
-			if (ret) {
-				port->link_bwctrl = NULL;
-				return ret;
-			}
-
-			pcie_bwnotif_enable(srv);
+		ret = request_irq(srv->irq, pcie_bwnotif_irq,
+				  IRQF_SHARED, "PCIe bwctrl", srv);
+		if (ret) {
+			port->link_bwctrl = NULL;
+			return ret;
 		}
+
+		pcie_bwnotif_enable(srv);
 	}
 
 	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
@@ -339,13 +312,11 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 	pcie_cooling_device_unregister(data->cdev);
 
 	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
-		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
-			pcie_bwnotif_disable(srv->port);
+		pcie_bwnotif_disable(srv->port);
 
-			free_irq(srv->irq, srv);
+		free_irq(srv->irq, srv);
 
-			srv->port->link_bwctrl = NULL;
-		}
+		srv->port->link_bwctrl = NULL;
 	}
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8d610c17e0f2..64ac1ee944d3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -38,14 +38,10 @@
 
 static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
 {
-	unsigned long count;
-	int ret;
-
-	ret = pcie_lbms_count(dev, &count);
-	if (ret < 0)
-		return lnksta & PCI_EXP_LNKSTA_LBMS;
+	if (test_bit(PCI_LINK_LBMS_SEEN, &dev->priv_flags))
+		return true;
 
-	return count > 0;
+	return lnksta & PCI_EXP_LNKSTA_LBMS;
 }
 
 /*

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.39.5


