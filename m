Return-Path: <linux-pci+bounces-28514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F8AC70BB
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 20:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719874E08C2
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899BA28DF4A;
	Wed, 28 May 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N2vKWmS6"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1175199939;
	Wed, 28 May 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455850; cv=none; b=jFhqdn6dFz7S1q6ACDz11WsBC2TiE+Hb2nkjbFrF9mk6BKRjZHkfY6nAwLJPx9+n80D8Xm1P6soI6b9/fR3SfBHiPmoHFCs55n87nO0dHKptvvC7RpX7ULuAOMf29F7P2szI7ZJf/W/eFqKDIuiB4WYS1twlr3TPQi9Sp/LeTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455850; c=relaxed/simple;
	bh=tJgGaeL8lDq9uscvebOcn4+6B6FshQVjhO0hl3B3BdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pq6a3+O/6wcFdt4EKskPYEY3bLUITIxAGeW8UfrOLjIaL2JIdeh8322cY401qT49lQm31sZN1VEM6B2RjHEWWRwrslaQsaUJE/0pbZY7BG61ALs5j3Ei8z4cxiUOoTmNTh7lgghh0jWykdLrJIYu508Zjr8+8d2MInpX+PNEXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N2vKWmS6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-grwhy-1BDK8.redmond.corp.microsoft.com (unknown [70.37.26.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 65C62207860A;
	Wed, 28 May 2025 11:10:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65C62207860A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748455848;
	bh=BN4btWrgT6mTRx8CSI6Tnm6/WQ8RUzdUec/ttgLYXhY=;
	h=From:To:Cc:Subject:Date:From;
	b=N2vKWmS6UItT4oQ1mziW5lSnPP3CcGCEpdMKxoVnYFrgfIFgpZ+1EXwAv2gAMqeBb
	 Co8n0qAUWkV6ND2NgIEK3RgSu5M3zd4OmYs63LXBYB3+yNh1MMs8ktxnCbpfUADsd/
	 pyqQEL3zEAAhJFCKQYCxCuyNe5A0fp7DVmBXZsi8=
From: grwhyte@linux.microsoft.com
To: linux-pci@vger.kernel.org
Cc: shyamsaini@linux.microsoft.com,
	code@tyhicks.com,
	Okaya@kernel.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Reduce delay after FLR of Microsoft MANA devices
Date: Wed, 28 May 2025 18:10:47 +0000
Message-Id: <20250528181047.1748794-1-grwhyte@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Graham Whyte <grwhyte@linux.microsoft.com>

Add a device-specific reset for Microsoft MANA devices with the FLR
delay reduced from 100ms to 10ms. While this is not compliant with the pci
spec, these devices safely complete the FLR much quicker than 100ms and
this can be reduced to optimize certain scenarios

Signed-off-by: Graham Whyte <grwhyte@linux.microsoft.com>

---
Changes in v2:
- Removed unnecessary EXPORT_SYMBOL_GPL for function pci_dev_wait
- Link to v1:https://lore.kernel.org/linux-pci/20250522085253.GN7435@unreal/T/#m7453647902a1b22840f5e39434a631fd7b2515ce
---
 drivers/pci/pci.c    |  2 +-
 drivers/pci/pci.h    |  1 +
 drivers/pci/quirks.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9cb1de7658b5..28f3bfd24357 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1262,7 +1262,7 @@ void pci_resume_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_resume_one, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 {
 	int delay = 1;
 	bool retrain = false;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f2958318d259..3a98e00eb02a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -109,6 +109,7 @@ void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int __pci_reset_bus(struct pci_bus *bus);
+int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout);
 
 struct pci_cap_saved_data {
 	u16		cap_nr;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c354276d4bac..94bd2c82cbbd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4205,6 +4205,55 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+#define MSFT_PCIE_RESET_READY_POLL_MS 60000 /* msec */
+#define MICROSOFT_2051_SVC 0xb210
+#define MICROSOFT_2051_MANA_MGMT 0x00b8
+#define MICROSOFT_2051_MANA_MGMT_GFT 0xb290
+
+/* Device specific reset for msft GFT and gdma devices */
+static int msft_pcie_flr(struct pci_dev *dev)
+{
+	if (!pci_wait_for_pending_transaction(dev))
+		pci_err(dev, "timed out waiting for pending transaction; "
+			"performing function level reset anyway\n");
+
+	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
+
+	if (dev->imm_ready)
+		return 0;
+
+	/*
+	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress. However, 100ms is much longer than required for modern
+	 * devices, so we can afford to reduce the timeout to 10ms.
+	 */
+	usleep_range(10000, 10001);
+
+	return pci_dev_wait(dev, "FLR", MSFT_PCIE_RESET_READY_POLL_MS);
+}
+
+/*
+ * msft_pcie_reset_flr - initiate a PCIe function level reset
+ * @dev: device to reset
+ * @probe: if true, return 0 if device can be reset this way
+ *
+ * Initiate a function level reset on @dev.
+ */
+static int msft_pcie_reset_flr(struct pci_dev *dev, bool probe)
+{
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
+		return -ENOTTY;
+
+	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return msft_pcie_flr(dev);
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4220,6 +4269,12 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_SVC,
+		msft_pcie_reset_flr},
+	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT,
+		msft_pcie_reset_flr},
+	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT_GFT,
+		msft_pcie_reset_flr},
 	{ 0 }
 };
 
-- 
2.25.1


