Return-Path: <linux-pci+bounces-11166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61FB9457D1
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D511C21472
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 05:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C114778E;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTHKtKH0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0CC3D982;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578119; cv=none; b=qZUsygraCn7QhIxC2VgqdTB16lwbSXmMs4xp/LDXDf1vx/MfPt53Ml65JZ38lcWk8c9XFt7+f1b19bK7nfbFvMqjwEkIduNsyoviRbf/ZyiM1DRZjxxlReS4RvOxlzhlcjPOXV3/TaltLoK+jU7BcnKqjr64H+oMX+xYXXw/1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578119; c=relaxed/simple;
	bh=2oOLSwZBpER+fZyeqXw9zPR5Y8Qfiqz8767N5YxtuLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z221ZST/InS/r/UZdqqVy+jp7+c7Hn+tmKVahvin/TBvyUiwtQA0GimGs3a7GsCd7bVGRKNLig6B6xsjbTs8plSzWnJknpRc8WuQXSVnj5NITlJ7ggD5Cw+6t1wfGTbP7MkVzNxjG1AVOl4i3A+mF+7Wxu92WminU9l+lGk+aCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTHKtKH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43E3DC4AF0A;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722578119;
	bh=2oOLSwZBpER+fZyeqXw9zPR5Y8Qfiqz8767N5YxtuLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cTHKtKH0x0K4jUorzs3sSp+LiQefTiaCIlsbNQ1YoCsiutkgsPCCFt4AQzabQsgYs
	 o1ctamuIEayaMJ7UnvtrlBvFhegMglkP0c8YOI2bh/lU79YVjOcvVlaX7O46PrRAap
	 HdxHdDxwrfi7CnjcQjzxxibANBL2tVa35upRZcJFf0N/POrXNPsc7S9WIB5fvyx8ym
	 TKmMyVVT/5ZN7H8H3cip8llCY2c5E1+nre0zWRbpi00fiDElECw2xQjFQDB/b/OMcn
	 gelIPSQJs+dOPsyvRsPhw2xVI02fIjKXm2PoQbymReg+hA7gzNvx6u8an4epXuww8M
	 Mtr8ZJkUBHWAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A36C52D70;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 02 Aug 2024 11:25:01 +0530
Subject: [PATCH v5 2/4] PCI: Rename pci_bridge_d3_possible() to
 pci_bridge_d3_allowed()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-pci-bridge-d3-v5-2-2426dd9e8e27@linaro.org>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
In-Reply-To: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <helgaas@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8312;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=GHrE4/WAAdQZRtTkchDWpjeIs/pSQnBrSg7T9J3wJiQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmrHTCu6YnayPL+5a/XwseNd/yFsK4K2oSYiSj+
 41/m1Wj7reJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqx0wgAKCRBVnxHm/pHO
 9WAOB/9MbWubQKHItHwS3BYSnjjKo27Bx6FMGf11h2VBR9EDdPCyC63ocW4PooEzMIrjj2rVGoN
 abW5nzspKSZecn1wM3QYiQlmBcPL18dkPi2w1PbYCvt065ox9F9s7u5dSRVaa8P+5H+OGWMdJ3E
 6Ta90T2Tf7Tzxw1qCpCmxz3L5btbKLMq1Qh7+C7RM1wWb949E/xHLGdVf98AKd6C9vZNxaz+QaE
 oKhhF0mvdLRDhAGCcks4VlwDEXITH5lbUKqGCpuTbd2c8H7/W5aILE/dXruq0fN6D5DolAXioKI
 4ChVXYQHE/u9vt5pl8K7ULRm+UTfoYDRBD8mwWkVYUG26Q6t
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

As per the 'PCI Bus Power Management Interface Specification' v1.2, all
devices should support D3 states (both D3Hot and D3Cold). So the term
'possible' doesn't make sense for the bridge devices, since D3 states
should be possible as per the design. But due to various circumstances,
D3 states might not be allowed for the bridges.

In those cases, the API should be called 'pci_bridge_d3_allowed()' to
reflect the actual behavior. So let's rename it.

This also warrants renaming the variable 'bridge_d3' in 'struct pci_dev'
to 'bridge_d3_allowed' for the reason cited above.

No functional change.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaas/
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pci-acpi.c     |  8 ++++----
 drivers/pci/pci.c          | 18 +++++++++---------
 drivers/pci/pci.h          |  4 ++--
 drivers/pci/pcie/portdrv.c | 14 +++++++-------
 include/linux/pci.h        |  2 +-
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 004575091596..0f260cdc4592 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1429,12 +1429,12 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 
 	device_set_wakeup_capable(dev, true);
 	/*
-	 * For bridges that can do D3 we enable wake automatically (as
-	 * we do for the power management itself in that case). The
+	 * For bridges that are allowed to do D3, we enable wake automatically
+	 * (as we do for the power management itself in that case). The
 	 * reason is that the bridge may have additional methods such as
 	 * _DSW that need to be called.
 	 */
-	if (pci_dev->bridge_d3)
+	if (pci_dev->bridge_d3_allowed)
 		device_wakeup_enable(dev);
 
 	acpi_pci_wakeup(pci_dev, false);
@@ -1452,7 +1452,7 @@ void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)
 	pci_acpi_remove_pm_notifier(adev);
 	if (adev->wakeup.flags.valid) {
 		acpi_device_power_remove_dependent(adev, dev);
-		if (pci_dev->bridge_d3)
+		if (pci_dev->bridge_d3_allowed)
 			device_wakeup_disable(dev);
 
 		device_set_wakeup_capable(dev, false);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..0edc4e448c2d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2967,13 +2967,13 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 };
 
 /**
- * pci_bridge_d3_possible - Is it possible to put the bridge into D3
+ * pci_bridge_d3_allowed - Is it allowed to put the bridge into D3
  * @bridge: Bridge to check
  *
- * This function checks if it is possible to move the bridge to D3.
+ * This function checks if the bridge is allowed to move to D3.
  * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
  */
-bool pci_bridge_d3_possible(struct pci_dev *bridge)
+bool pci_bridge_d3_allowed(struct pci_dev *bridge)
 {
 	if (!pci_is_pcie(bridge))
 		return false;
@@ -3060,14 +3060,14 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	bool d3cold_ok = true;
 
 	bridge = pci_upstream_bridge(dev);
-	if (!bridge || !pci_bridge_d3_possible(bridge))
+	if (!bridge || !pci_bridge_d3_allowed(bridge))
 		return;
 
 	/*
 	 * If D3 is currently allowed for the bridge, removing one of its
 	 * children won't change that.
 	 */
-	if (remove && bridge->bridge_d3)
+	if (remove && bridge->bridge_d3_allowed)
 		return;
 
 	/*
@@ -3087,12 +3087,12 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	 * so we need to go through all children to find out if one of them
 	 * continues to block D3.
 	 */
-	if (d3cold_ok && !bridge->bridge_d3)
+	if (d3cold_ok && !bridge->bridge_d3_allowed)
 		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
 			     &d3cold_ok);
 
-	if (bridge->bridge_d3 != d3cold_ok) {
-		bridge->bridge_d3 = d3cold_ok;
+	if (bridge->bridge_d3_allowed != d3cold_ok) {
+		bridge->bridge_d3_allowed = d3cold_ok;
 		/* Propagate change to upstream bridges */
 		pci_bridge_d3_update(bridge);
 	}
@@ -3167,7 +3167,7 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->pm_cap = pm;
 	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
-	dev->bridge_d3 = pci_bridge_d3_possible(dev);
+	dev->bridge_d3_allowed = pci_bridge_d3_allowed(dev);
 	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..53ca75639201 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -92,7 +92,7 @@ void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
-bool pci_bridge_d3_possible(struct pci_dev *dev);
+bool pci_bridge_d3_allowed(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
@@ -113,7 +113,7 @@ static inline bool pci_power_manageable(struct pci_dev *pci_dev)
 	 * Currently we allow normal PCI devices and PCI bridges transition
 	 * into D3 if their bridge_d3 is set.
 	 */
-	return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3;
+	return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3_allowed;
 }
 
 static inline bool pcie_downstream_port(const struct pci_dev *dev)
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 1f02e5d7b2e9..8401a0f7b394 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -632,7 +632,7 @@ __setup("pcie_ports=", pcie_port_setup);
 #ifdef CONFIG_PM
 static int pcie_port_runtime_suspend(struct device *dev)
 {
-	if (!to_pci_dev(dev)->bridge_d3)
+	if (!to_pci_dev(dev)->bridge_d3_allowed)
 		return -EBUSY;
 
 	return pcie_port_device_runtime_suspend(dev);
@@ -641,11 +641,11 @@ static int pcie_port_runtime_suspend(struct device *dev)
 static int pcie_port_runtime_idle(struct device *dev)
 {
 	/*
-	 * Assume the PCI core has set bridge_d3 whenever it thinks the port
-	 * should be good to go to D3.  Everything else, including moving
+	 * Assume the PCI core has set bridge_d3_allowed whenever it thinks the
+	 * port should be good to go to D3.  Everything else, including moving
 	 * the port to D3, is handled by the PCI core.
 	 */
-	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
+	return to_pci_dev(dev)->bridge_d3_allowed ? 0 : -EBUSY;
 }
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
@@ -702,7 +702,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
 					   DPM_FLAG_SMART_SUSPEND);
 
-	if (dev->bridge_d3) {
+	if (dev->bridge_d3_allowed) {
 		/*
 		 * Keep the port resumed 100ms to make sure things like
 		 * config space accesses from userspace (lspci) will not
@@ -720,7 +720,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (dev->bridge_d3) {
+	if (dev->bridge_d3_allowed) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
@@ -733,7 +733,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 
 static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
-	if (dev->bridge_d3) {
+	if (dev->bridge_d3_allowed) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..2a48c88512e1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,7 +375,7 @@ struct pci_dev {
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
-	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
+	unsigned int	bridge_d3_allowed:1;	/* Allow D3 for bridge */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */

-- 
2.25.1



