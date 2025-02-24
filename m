Return-Path: <linux-pci+bounces-22138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE162A41439
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 04:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B13A5107
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 03:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5C81B4231;
	Mon, 24 Feb 2025 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fKiCx8CW"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148B1AAA1A;
	Mon, 24 Feb 2025 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368715; cv=none; b=tYIn3TgPMjbkrGtGQNFe1EsmeZrNENOZ4MUUaetb81tvWwgQOxdNzK9XhBmPLsl2hziqYjNlOKkYu+aQQNJH9MZjq7NPJ2nE8aO/yneR1U3mVXF1lwNS7+xp3gRzY1qJ+3T9anlAmjqRMrqvNGf1jhbTcQLaaGYPSMo1dpxYZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368715; c=relaxed/simple;
	bh=zQblHyhvwohGfU+6u4WN9LwOs0v+WagpCNoY/EchxTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Za5TJ+BIJzwdFss5m1VtUi4y7VZtQAsGvzOZv8eeMMaZNS9BTGTy2i3C8dSRod0ggFAuAEcN6UiPs44f11/NoPR2EwAheMeOHPoI0Fs3yH7bfmTPtAwWiKm/ZoMfEAlySpfsr64yO9il3Q4n7FBF6n239Tv/UGi1OzdVFYSpDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fKiCx8CW; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740368704; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4fmmqZE5L8pnbvnXPansBrSd9fl8lXiV+nvcr/YF6Og=;
	b=fKiCx8CWgN8NoEKHpnZiMiodH1NkY78SmCOtgOz9vFTEHAuMdeJu28p+4JiD4btjaeaiXbg90awTL2lzLdEZnxVmSmJ+LifBx41X8jvOn1A1xhx/8TW0X2uuOLnOrM4pjPe2Kl/2fyCmsbvybcJe1mL67Eif22BNqpHs8t75/4w=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQ1wP9u_1740368703 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 11:45:03 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	rafael@kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>,
	lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling hotplug events
Date: Mon, 24 Feb 2025 11:44:58 +0800
Message-Id: <20250224034500.23024-3-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was problem reported by firmware developers that they received
two PCIe hotplug commands in very short intervals on an ARM server,
which doesn't comply with PCIe spec, and broke their state machine and
work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
to wait at least 1 second for the command-complete event, before
resending the command or sending a new command.

In the failure case, the first PCIe hotplug command firmware received
is from get_port_device_capability(), which sends command to disable
PCIe hotplug interrupts without waiting for its completion, and the
second command comes from pcie_enable_notification() of pciehp driver,
which enables hotplug interrupts again.

Fix it by adding the necessary wait to comply with PCIe spec.

Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
Originally-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/pci/pci.h          |  2 ++
 drivers/pci/pcie/portdrv.c | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4c94a589de4a..a1138ebc2689 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -760,6 +760,7 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 void pcie_reset_lbms_count(struct pci_dev *port);
 int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
 int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms);
+void pcie_disable_hp_interrupts_early(struct pci_dev *dev);
 #else
 static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
 static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
@@ -770,6 +771,7 @@ static inline int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
 {
 	return 0;
 }
+static inline void pcie_disable_hp_interrupts_early(struct pci_dev *dev) {}
 #endif
 
 struct pci_dev_reset_methods {
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index bb00ba45ee51..ca4f21dff486 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -230,6 +230,22 @@ int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
 	return  ret;
 }
 
+void pcie_disable_hp_interrupts_early(struct pci_dev *dev)
+{
+	u16 slot_ctrl = 0;
+
+	pcie_capability_read_word(dev, PCI_EXP_SLTCTL, &slot_ctrl);
+	/* Bail out early if it is already disabled */
+	if (!(slot_ctrl & (PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE)))
+		return;
+
+	pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
+		  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+
+	if (pcie_poll_sltctl_cmd(dev, 1000))
+		pci_info(dev, "Timeout on disabling PCIe hot-plug interrupt\n");
+}
+
 /**
  * get_port_device_capability - discover capabilities of a PCI Express port
  * @dev: PCI Express port to examine
@@ -255,8 +271,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 		 * Disable hot-plug interrupts in case they have been enabled
 		 * by the BIOS and the hot-plug service driver is not loaded.
 		 */
-		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
-			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+		pcie_disable_hp_interrupts_early(dev);
 	}
 
 #ifdef CONFIG_PCIEAER
-- 
2.43.5


