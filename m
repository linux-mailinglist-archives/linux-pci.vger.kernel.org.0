Return-Path: <linux-pci+bounces-1613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A4822579
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 00:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F95F284923
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 23:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007517740;
	Tue,  2 Jan 2024 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfpOimGx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C6B1773F;
	Tue,  2 Jan 2024 23:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6451C433C8;
	Tue,  2 Jan 2024 23:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704237964;
	bh=WuAwk7zWQxqNeWy+iKLUu2zXubSzzN/H4OfczTv4nxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfpOimGxKcd/lNdyF4JmHXBCA1H8M/3p9i1QnRTrwe0kkmqKuIwpjYOTp1+4UmaWd
	 ZVhSaYSVnLrRLosMrPA1y9wgPKDppB/zXajSlvvyn2xz/hVrEJG5oum60EeDXiOsTv
	 eh64lEOr8RehlCK97W7ZeIdrfAMQLGZBD2afvie6VcsMdnyrcKuu7TwW19Oj7tTYnD
	 X4s2UPmmqHEr5ZoclapmYC8KO3ZXVQLBu1h+Y6ULCI+9K+DVKMidEfVzMRW2LMgs0N
	 MpME5ecw+0mNBUBaFmW6nUWy5uYiSsyIl3dJHbLW7aSomdhWK+EyabwyOZWejRIkFY
	 8pod8hJoC5aZQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Schaller <michael@5challer.de>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"
Date: Tue,  2 Jan 2024 17:25:50 -0600
Message-Id: <20240102232550.1751655-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de>
References: <76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 08d0cc5f34265d1a1e3031f319f594bd1970976c.

Michael reported that when attempting to resume from suspend to RAM on ASUS
mini PC PN51-BB757MDE1 (DMI model: MINIPC PN51-E1), 08d0cc5f3426
("PCI/ASPM: Remove pcie_aspm_pm_state_change()") caused a 12-second delay
with no output, followed by a reboot.

Workarounds include:

  - Reverting 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
  - Booting with "pcie_aspm=off"
  - Booting with "pcie_aspm.policy=performance"
  - "echo 0 | sudo tee /sys/bus/pci/devices/0000:03:00.0/link/l1_aspm"
    before suspending
  - Connecting a USB flash drive

Fixes: 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
Reported-by: Michael Schaller <michael@5challer.de>
Link: https://lore.kernel.org/r/76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/pci.c       |  6 ++++++
 drivers/pci/pci.h       |  2 ++
 drivers/pci/pcie/aspm.c | 19 +++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 55bc3576a985..bdbf8a94b4d0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1335,6 +1335,9 @@ static int pci_set_full_power_state(struct pci_dev *dev)
 		pci_restore_bars(dev);
 	}
 
+	if (dev->bus->self)
+		pcie_aspm_pm_state_change(dev->bus->self);
+
 	return 0;
 }
 
@@ -1429,6 +1432,9 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
 				     pci_power_name(dev->current_state),
 				     pci_power_name(state));
 
+	if (dev->bus->self)
+		pcie_aspm_pm_state_change(dev->bus->self);
+
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..f43873049d52 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -569,10 +569,12 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
+void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
+static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #endif
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 50b04ae5c394..8715e951c491 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1008,6 +1008,25 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
+/* @pdev: the root port or switch downstream port */
+void pcie_aspm_pm_state_change(struct pci_dev *pdev)
+{
+	struct pcie_link_state *link = pdev->link_state;
+
+	if (aspm_disabled || !link)
+		return;
+	/*
+	 * Devices changed PM state, we should recheck if latency
+	 * meets all functions' requirement
+	 */
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+	pcie_update_aspm_capable(link->root);
+	pcie_config_aspm_path(link);
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+}
+
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;
-- 
2.34.1


