Return-Path: <linux-pci+bounces-10887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DBD93E7A8
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F5628631B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5061304AD;
	Sun, 28 Jul 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaQTXGss"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126B12FF65;
	Sun, 28 Jul 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182771; cv=none; b=PdBZ3uDLg7YYMyjKtfOL4EjpBTOGo4HpFa4l/uiJw68xNUbX1nSHToyaLWWup70GO2QIaNRk3x+4bphutoh3aykmQNpiESLHeISGwR7u0Ttc+4/Yml+a4h5A8f4dfr071WVUX68jcczIWnz6XnY9Tf4f2t6fV7wPhgN+JL6Nxk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182771; c=relaxed/simple;
	bh=5bbPBNWEJ0TWEF17tF+gO8exwZoTsQqVPRyvBIYCeFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1CEGkiK89YfAVWu3LyFhx3ryVGJ2qrEDh9GpFcNqaZSIiHusmEe6ySjUQd3OVsl+JxVw9ANftd0kfBEMqrtPYu0JOb69kKUu/odxEZtpa4x2ZKIlvwu3hVS3Rx4yrvVK/HKCCPo00d1UDVXH5Y80hO/2sDw7FHtu/a5yHkGud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaQTXGss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD1DC4AF0B;
	Sun, 28 Jul 2024 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182771;
	bh=5bbPBNWEJ0TWEF17tF+gO8exwZoTsQqVPRyvBIYCeFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaQTXGss6hEFyD/nyZP3lCaoqdjnD8ciMx9DiDjLHOZ2KxY0rl4KLHgMhXBSIseZa
	 xzY4O2o4ICX4fXAtTFBJNioh36vkhYfkwn8hwvI4x6PeW+ytmitHbp3E+eTKqWtVgC
	 gCng2jCFwX+TNEaNrXf7ptzb7yMgmgukLGqWEGw0Qxqbiifa+KqLAnVSoqXyXGlS1q
	 JLro1LOgC0kGUYB+FO4gGdt/jvPLu0izYL3cIwvq3GxI9+4Is72pmx7MwwDMWsgpIh
	 icWThO024ODKVCd81obbA5echYx4W2kDyKCXTwhCZlYo9eRY2phIyxEpVE4SC2DVWu
	 8z7wHXs2lggHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 13/23] PCI/DPC: Disable DPC service on suspend
Date: Sun, 28 Jul 2024 12:04:54 -0400
Message-ID: <20240728160538.2051879-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 75c47c790f43c438761fc049fb9d438144a9db45 ]

If the link is powered off during suspend, electrical noise may cause
errors that trigger DPC.  If the DPC interrupt is enabled and shares an IRQ
with PME, that causes a spurious wakeup during suspend.

Disable DPC triggering and the DPC interrupt during suspend to prevent
this.  Clear DPC interrupt status before re-enabling DPC interrupts during
resume so we don't get an interrupt for errors that occurred during the
suspend/resume process.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
Link: https://lore.kernel.org/r/20240416043225.1462548-3-kai.heng.feng@canonical.com
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
[bhelgaas: clear status on resume, add comments, commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/dpc.c | 60 +++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a668820696dc0..2b6ef7efa3c11 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -412,13 +412,44 @@ void pci_dpc_init(struct pci_dev *pdev)
 	}
 }
 
+static void dpc_enable(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	int dpc = pdev->dpc_cap;
+	u16 ctl;
+
+	/*
+	 * Clear DPC Interrupt Status so we don't get an interrupt for an
+	 * old event when setting DPC Interrupt Enable.
+	 */
+	pci_write_config_word(pdev, dpc + PCI_EXP_DPC_STATUS,
+			      PCI_EXP_DPC_STATUS_INTERRUPT);
+
+	pci_read_config_word(pdev, dpc + PCI_EXP_DPC_CTL, &ctl);
+	ctl &= ~PCI_EXP_DPC_CTL_EN_MASK;
+	ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
+	pci_write_config_word(pdev, dpc + PCI_EXP_DPC_CTL, ctl);
+}
+
+static void dpc_disable(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	int dpc = pdev->dpc_cap;
+	u16 ctl;
+
+	/* Disable DPC triggering and DPC interrupts */
+	pci_read_config_word(pdev, dpc + PCI_EXP_DPC_CTL, &ctl);
+	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
+	pci_write_config_word(pdev, dpc + PCI_EXP_DPC_CTL, ctl);
+}
+
 #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
 static int dpc_probe(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
 	struct device *device = &dev->device;
 	int status;
-	u16 ctl, cap;
+	u16 cap;
 
 	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
@@ -433,11 +464,7 @@ static int dpc_probe(struct pcie_device *dev)
 	}
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
-
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~PCI_EXP_DPC_CTL_EN_MASK;
-	ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
-	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+	dpc_enable(dev);
 
 	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
@@ -450,14 +477,21 @@ static int dpc_probe(struct pcie_device *dev)
 	return status;
 }
 
-static void dpc_remove(struct pcie_device *dev)
+static int dpc_suspend(struct pcie_device *dev)
 {
-	struct pci_dev *pdev = dev->port;
-	u16 ctl;
+	dpc_disable(dev);
+	return 0;
+}
 
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
-	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+static int dpc_resume(struct pcie_device *dev)
+{
+	dpc_enable(dev);
+	return 0;
+}
+
+static void dpc_remove(struct pcie_device *dev)
+{
+	dpc_disable(dev);
 }
 
 static struct pcie_port_service_driver dpcdriver = {
@@ -465,6 +499,8 @@ static struct pcie_port_service_driver dpcdriver = {
 	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
+	.suspend	= dpc_suspend,
+	.resume		= dpc_resume,
 	.remove		= dpc_remove,
 };
 
-- 
2.43.0


