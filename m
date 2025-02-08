Return-Path: <linux-pci+bounces-21014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F477A2D3F3
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 06:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB421188D426
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 05:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFAC1A38E3;
	Sat,  8 Feb 2025 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTr03tVr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371E1A2C29;
	Sat,  8 Feb 2025 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738991018; cv=none; b=WPRX4cGMRC+sICARWZNwSzZgtDyY6Qxfiw0oH6CHgxcpCIUu/nP0sIsRGLPgbPzACfWj9rSJPlSzxcooNVXoKwZr/4PEkCYaHef8lyyyoAhAALDADQOONmS+q3UtsyBotVl9MvD0r6oTZzS41CQMNlaWAn5NMj62Fhr9NrSnmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738991018; c=relaxed/simple;
	bh=0mykn84dG9D2ONSFmXFeEpUD90P096gYCkiHrYqJSdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UeUCnSCtWhvBt8DFFDJOWUceLiTIsHTx0ye0ou4jgtfLSGMY8zZVeUMYSlwn0nitAGFJilUmlqloHkgZu8dRU7FaIGvNVJcuoeawX3KF8ZjKlaoW2/VaYh1z6L8vLeecyMvUNcWeMlOAskThedDCtso2mr+UaSuUkSgTaLWy84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTr03tVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7278C4CEDF;
	Sat,  8 Feb 2025 05:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738991018;
	bh=0mykn84dG9D2ONSFmXFeEpUD90P096gYCkiHrYqJSdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTr03tVrUin0okrlPb6XzfF5KTJcH4eVK9PgcB5elORDKRh1dFdIMkenQL6k2YtcP
	 qo4YDaTtIVEGCszPCoUu4RTyacaY//Ok/6uB6gv3ZPSD1QVxRekmVCrR4tUy6Re/1F
	 QSYkbktEiC6FfQvVNZAAqslwieEmUd+EH72Hac9ItM0kOTYgAsUKl2BZg8ssm3JxbM
	 RciaNVlxMK1vMZX8afKCPIRu42v+3+JeH/GHzKm3VX6E0BwIx/UeLUJiDY8OT6ky60
	 gj/sP/eHkRFKRjW+KDNYH7wM/+Y3+GD+X/K0hg/gHLII2KrxTRh809Y2x/uflEgH4H
	 q1f1dKKak4rzQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI: Cache offset of Resizable BAR capability
Date: Fri,  7 Feb 2025 23:03:29 -0600
Message-Id: <20250208050329.1092214-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208050329.1092214-1-helgaas@kernel.org>
References: <20250208050329.1092214-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously most resizable BAR interfaces (pci_rebar_get_possible_sizes(),
pci_rebar_set_size(), etc) as well as pci_restore_state() searched config
space for a Resizable BAR capability.  Most devices don't have such a
capability, so this is wasted effort, especially for pci_restore_state().

Search for a Resizable BAR capability once at enumeration-time and cache
the offset so we don't have to search every time we need it.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   | 9 +++++++--
 drivers/pci/pci.h   | 1 +
 drivers/pci/probe.c | 1 +
 include/linux/pci.h | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 503376bf7e75..cf2632080a94 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1872,7 +1872,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 	unsigned int pos, nbars, i;
 	u32 ctrl;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	pos = pdev->rebar_cap;
 	if (!pos)
 		return;
 
@@ -3719,6 +3719,11 @@ void pci_acs_init(struct pci_dev *dev)
 	pci_enable_acs(dev);
 }
 
+void pci_rebar_init(struct pci_dev *pdev)
+{
+	pdev->rebar_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+}
+
 /**
  * pci_rebar_find_pos - find position of resize ctrl reg for BAR
  * @pdev: PCI device
@@ -3733,7 +3738,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
 	unsigned int pos, nbars, i;
 	u32 ctrl;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	pos = pdev->rebar_cap;
 	if (!pos)
 		return -ENOTSUPP;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..d7b46ddfd6d2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -799,6 +799,7 @@ static inline int acpi_get_rc_resources(struct device *dev, const char *hid,
 }
 #endif
 
+void pci_rebar_init(struct pci_dev *pdev);
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
 static inline u64 pci_rebar_size_to_bytes(int size)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..24dd3dcfd223 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2564,6 +2564,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
+	pci_rebar_init(dev);		/* Resizable BAR */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..9e5bbd996c83 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -353,6 +353,7 @@ struct pci_dev {
 	struct pci_dev  *rcec;          /* Associated RCEC device */
 #endif
 	u32		devcap;		/* PCIe Device Capabilities */
+	u16		rebar_cap;	/* Resizable BAR capability offset */
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
-- 
2.34.1


