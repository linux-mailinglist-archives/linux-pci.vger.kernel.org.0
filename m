Return-Path: <linux-pci+bounces-27520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05261AB1BFF
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 20:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3233D1C45624
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0C22D4C9;
	Fri,  9 May 2025 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="efOz47Ne"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B522192F3;
	Fri,  9 May 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814101; cv=none; b=U1dr0Td07YqbLeh7zsivRSHYo3CGG7pyhbHUvhMfattjXvsPVw+Pd3uG173JGyeMuQeEnIwNKPopckBDJVQIqFQn8N1wFDlUIDT6r3l+cdB/CoyROhGgKppzhOtGGRn5wRv9Lbfu8rESkK+2KKlJ2VWi3ZiELxKokWg00lU62xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814101; c=relaxed/simple;
	bh=f17tyyZdnLA4sCUSpuUgHTeIbGOQ7gE1slCM/MWvW+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z4x7IfiYdFFpHr/b9zNxrl2ZteFpl6KBWOdxqy8QGHw2h3Axa7aKHimly7KCMeHt/PX8J8juMwLWBAzv4q2uA0uqmYiJH1+jd4Yn3HPlJmxkkTcAOyXWsccjYU4rExWeWQVyaiq9MOaK6x63mApi5n6Q/ikbl/TuTFn1YTgdzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=efOz47Ne; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 481268288923;
	Fri,  9 May 2025 13:08:18 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ob-T11UPjxWJ; Fri,  9 May 2025 13:08:16 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 4249982889A9;
	Fri,  9 May 2025 13:08:16 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 4249982889A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1746814096; bh=tq2VzEjyj42ovjedBCjYqS3IU6FW+hRJF41bXqaJe6Q=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=efOz47NeYsyBgRfSHKP8t7oe7iojTehXmex67qtmBkFjFboZ4k5u/ugauzdCSgswK
	 F9Q390zcKEgBr++ir1yexmX6Elr/lq1SQ4IL29So8dTMk+NRfea1uZv4xuosFlLjdM
	 8a9EpKrifA3fAHdntHrWaFKsbFg3k9c3lnyl6Mow=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TrcmAPt3Eo3y; Fri,  9 May 2025 13:08:15 -0500 (CDT)
Received: from raptor-ewks-026.lan (5.edge.rptsys.com [23.155.224.38])
	by mail.rptsys.com (Postfix) with ESMTPSA id 08ED78288923;
	Fri,  9 May 2025 13:08:14 -0500 (CDT)
From: Shawn Anastasio <sanastasio@raptorengineering.com>
To: linux-pci@vger.kernel.org,
	"Lukas Wunner" <lukas@wunner.de>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
	"Lorenzo Pieralisi" <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
	"Rob Herring" <robh@kernel.o>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"chaitanya chundru" <quic_krichai@quicinc.com>,
	"Bjorn Andersson" <andersson@kernel.org>,
	"Konrad Dybcio" <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	"Jingoo Han" <jingoohan1@gmail.com>,
	"Bartosz Golaszewski" <brgl@bgdev.pl>,
	quic_vbadigan@quicnic.com,
	amitk@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	jorge.ramirez@oss.qualcomm.com,
	Dmitry Baryshkov <lumag@kernel.org>,
	Timothy Pearson <tpearson@raptorengineering.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: [RESEND PATCH v6] PCI: PCI: Add pcie_link_is_active() to determine if the PCIe link is active
Date: Fri,  9 May 2025 13:08:12 -0500
Message-Id: <20250509180813.2200312-1-sanastasio@raptorengineering.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Date: Sat, 12 Apr 2025 07:19:56 +0530

Introduce a common API to check if the PCIe link is active, replacing
duplicate code in multiple locations.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
---
(Resent since git-send-email failed to detect the Subject field from the patch
file previously -- apologies!)

This is an updated patch pulled from Krishna's v5 series:
https://patchwork.kernel.org/project/linux-pci/list/?series=952665

The following changes to Krishna's v5 were made by me:
  - Revert pcie_link_is_active return type back to int per Lukas' review
    comments
  - Handle non-zero error returns at call site of the new function in
    pci.c/pci_bridge_wait_for_secondary_bus

 drivers/pci/hotplug/pciehp.h      |  1 -
 drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c  | 33 +++----------------------------
 drivers/pci/pci.c                 | 26 +++++++++++++++++++++---
 include/linux/pci.h               |  4 ++++
 5 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 273dd8c66f4e..acef728530e3 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller *ctrl);
 int pciehp_card_present(struct controller *ctrl);
 int pciehp_card_present_or_link_active(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
-int pciehp_check_link_active(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);

 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index d603a7aa7483..4bb58ba1c766 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -260,7 +260,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	/* Turn the slot on if it's occupied or link is up */
 	mutex_lock(&ctrl->state_lock);
 	present = pciehp_card_present(ctrl);
-	link_active = pciehp_check_link_active(ctrl);
+	link_active = pcie_link_is_active(ctrl->pcie->port);
 	if (present <= 0 && link_active <= 0) {
 		if (ctrl->state == BLINKINGON_STATE) {
 			ctrl->state = OFF_STATE;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8a09fb6083e2..278bc21d531d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
 	pcie_do_write_cmd(ctrl, cmd, mask, false);
 }

-/**
- * pciehp_check_link_active() - Is the link active
- * @ctrl: PCIe hotplug controller
- *
- * Check whether the downstream link is currently active. Note it is
- * possible that the card is removed immediately after this so the
- * caller may need to take it into account.
- *
- * If the hotplug controller itself is not available anymore returns
- * %-ENODEV.
- */
-int pciehp_check_link_active(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_status;
-	int ret;
-
-	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
-		return -ENODEV;
-
-	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
-	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
-
-	return ret;
-}
-
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 {
 	u32 l;
@@ -467,7 +440,7 @@ int pciehp_card_present_or_link_active(struct controller *ctrl)
 	if (ret)
 		return ret;

-	return pciehp_check_link_active(ctrl);
+	return pcie_link_is_active(ctrl_dev(ctrl));
 }

 int pciehp_query_power_fault(struct controller *ctrl)
@@ -584,7 +557,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
 	 * Synthesize it to ensure that it is acted on.
 	 */
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
-	if (!pciehp_check_link_active(ctrl))
+	if (!pcie_link_is_active(ctrl_dev(ctrl)))
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
 	up_read(&ctrl->reset_lock);
 }
@@ -884,7 +857,7 @@ int pciehp_slot_reset(struct pcie_device *dev)
 	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
 				   PCI_EXP_SLTSTA_DLLSC);

-	if (!pciehp_check_link_active(ctrl))
+	if (!pcie_link_is_active(ctrl_dev(ctrl)))
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);

 	return 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e77d5b53c0ce..3bb8354b14bf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4926,7 +4926,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return 0;

 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
-		u16 status;

 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
@@ -4942,8 +4941,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		if (!dev->link_active_reporting)
 			return -ENOTTY;

-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
-		if (!(status & PCI_EXP_LNKSTA_DLLLA))
+		if (pcie_link_is_active(dev) <= 0)
 			return -ENOTTY;

 		return pci_dev_wait(child, reset_type,
@@ -6247,6 +6245,28 @@ void pcie_print_link_status(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pcie_print_link_status);

+/**
+ * pcie_link_is_active() - Checks if the link is active or not
+ * @pdev: PCI device to query
+ *
+ * Check whether the link is active or not.
+ *
+ * Return: link state, or -ENODEV if the config read failes.
+ */
+int pcie_link_is_active(struct pci_dev *pdev)
+{
+	u16 lnk_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
+		return -ENODEV;
+
+	pci_dbg(pdev, "lnk_status = %x\n", lnk_status);
+	return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+}
+EXPORT_SYMBOL(pcie_link_is_active);
+
 /**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51e2bd6405cd..a79a9919320c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1945,6 +1945,7 @@ pci_release_mem_regions(struct pci_dev *pdev)
 			    pci_select_bars(pdev, IORESOURCE_MEM));
 }

+int pcie_link_is_active(struct pci_dev *dev);
 #else /* CONFIG_PCI is not enabled */

 static inline void pci_set_flags(int flags) { }
@@ -2093,6 +2094,9 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 {
 	return -ENOSPC;
 }
+
+static inline bool pcie_link_is_active(struct pci_dev *dev)
+{ return false; }
 #endif /* CONFIG_PCI */

 /* Include architecture-dependent settings and functions */
--
2.30.2


