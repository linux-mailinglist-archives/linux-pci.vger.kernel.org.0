Return-Path: <linux-pci+bounces-26649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CAA9A01A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 06:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFE5444783
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 04:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F419CC3D;
	Thu, 24 Apr 2025 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxitGitN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43649198A11
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745469165; cv=none; b=T9bQ9g1+8qgecigIrDH+rHipFk0ESKWGCRBI+tWnzwEZS5zKCsWSxgZNnSYqCCMScShVrIi/AUuc1Jv3GxolRVHqZaDybIc/KUqoSYC41RepB4wt9Pw/W3zIesnkS/zIqAlrbz8+WzNi9doAi84pZK7lFrm46EP6+U0/3K2txck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745469165; c=relaxed/simple;
	bh=u6uQYJdX8Oz8Z9hjkBsp0CddLir4+K6KfWB8KSlUSmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCZfKMZQpRijZxcpR2KOqeLWnVL3Qsyrjd8TWYU0JSRDL27OIgg7oIMz/8oL+483E2HSRQgpHxlAeCBvgVWYP6T99kfAIp5gCqIHGvczaKRzL9lCjmDxVles8Rr0+GB1J7WmxlatrNrzcyXxVbt/4LuEApui+C2Fr6eO1+xm7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxitGitN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AE5C4CEE3;
	Thu, 24 Apr 2025 04:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745469164;
	bh=u6uQYJdX8Oz8Z9hjkBsp0CddLir4+K6KfWB8KSlUSmA=;
	h=From:To:Cc:Subject:Date:From;
	b=fxitGitNAVj9r72h5ZxhZy4Jn/lrkK7td0ACpnwJ569lhMg3tt4mFs+XN3m8clYOK
	 oIJ6UiaSZ8/ta2kkdWf/iTMqXsASZbxnq0wzN7I+BzBrlSc7cuS6bt0eWkRVz+KXXJ
	 V1TCsOcfO0uXWUB/V3OSLMwQIS7NzyipTZzzposAPBM1OuW1SEf4xvZh0VlDC7ht3y
	 H8Dr7+55n/RMEqlHS7IumcGgOyzd8sNKzSNvBQ3iDrNZfY93qxpDL/1q94TnDeNZA0
	 cX7f1dHvIdT/oCYVs+XI/Xc+A3hi9jQP4SozZpBrKjFyhgoKnT8fJpGmqOQOH8IhWv
	 xLd85eTp1rRBQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com,
	rafael.j.wysocki@intel.com,
	huang.ying.caritas@gmail.com,
	stern@rowland.harvard.edu
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
Date: Wed, 23 Apr 2025 23:31:32 -0500
Message-ID: <20250424043232.1848107-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

AMD BIOS team has root caused an issue that NVME storage failed to come
back from suspend to a lack of a call to _REG when NVME device was probed.

commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
added support for calling _REG when transitioning D-states, but this only
works if the device actually "transitions" D-states.

commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
devices") added support for runtime PM on PCI devices, but never actually
'explicitly' sets the device to D0.

To make sure that devices are in D0 and that platform methods such as
_REG are called, explicitly set all devices into D0 during initialization.

Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Move runtime PM calls after setting to D0
 * Use pci_pm_power_up_and_verify_state()
---
 drivers/pci/pci-driver.c |  6 ------
 drivers/pci/pci.c        | 13 ++++++++++---
 drivers/pci/pci.h        |  1 +
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index c8bd71a739f72..082918ce03d8a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -555,12 +555,6 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
 	pci_enable_wake(pci_dev, PCI_D0, false);
 }
 
-static void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
-{
-	pci_power_up(pci_dev);
-	pci_update_current_state(pci_dev, PCI_D0);
-}
-
 static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 {
 	pci_pm_power_up_and_verify_state(pci_dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e77d5b53c0cec..8d125998b30b7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3192,6 +3192,12 @@ void pci_d3cold_disable(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_disable);
 
+void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
+{
+	pci_power_up(pci_dev);
+	pci_update_current_state(pci_dev, PCI_D0);
+}
+
 /**
  * pci_pm_init - Initialize PM functions of given PCI device
  * @dev: PCI device to handle.
@@ -3202,9 +3208,6 @@ void pci_pm_init(struct pci_dev *dev)
 	u16 status;
 	u16 pmc;
 
-	pm_runtime_forbid(&dev->dev);
-	pm_runtime_set_active(&dev->dev);
-	pm_runtime_enable(&dev->dev);
 	device_enable_async_suspend(&dev->dev);
 	dev->wakeup_prepared = false;
 
@@ -3266,6 +3269,10 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_STATUS, &status);
 	if (status & PCI_STATUS_IMM_READY)
 		dev->imm_ready = 1;
+	pci_pm_power_up_and_verify_state(dev);
+	pm_runtime_forbid(&dev->dev);
+	pm_runtime_set_active(&dev->dev);
+	pm_runtime_enable(&dev->dev);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62a..49165b739138b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -148,6 +148,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);
 void pci_dev_complete_resume(struct pci_dev *pci_dev);
 void pci_config_pm_runtime_get(struct pci_dev *dev);
 void pci_config_pm_runtime_put(struct pci_dev *dev);
+void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
 void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_msi_init(struct pci_dev *dev);
-- 
2.43.0


