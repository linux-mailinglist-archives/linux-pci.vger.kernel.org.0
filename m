Return-Path: <linux-pci+bounces-3949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A672A861E52
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8801F24989
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 21:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5914CAD1;
	Fri, 23 Feb 2024 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9Bwwffo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D9146E93;
	Fri, 23 Feb 2024 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721944; cv=none; b=ZxkPK1xRMa08eBfCGLpj9B3Y/fKZsuvfaXvG+0NnE6GLxWkqIGDJDIagRJ1TKehIaMNGQz/Hjv3yUFRiLKS+12bPZS7t1O+3oyBMcm6jKdFwxlQIsJYRS4VVvLh9fNLF15Fu1koEmLKt2v+KvPjnKbojjxAC0jId9fsZYwfQQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721944; c=relaxed/simple;
	bh=edfl9Qyi1j5BIY4+eq7G/coY2cxhe7prrDOpLepU/Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b4FFaGST6nowmUcelnFLewqAqr9FRytW5lQhm1Vxpo6Pz9Vrq5y3kQXUwo4gVUD4E8hBNxoZJjED79joxrMcZdwQ/W2f/6CpR8vL4ovw6anh8EmR0iO+OocnGVzL1o+jjiqGOx65maqDBEsGdlyDlWqabAEevbEglOYkJCzAuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9Bwwffo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD5AC433F1;
	Fri, 23 Feb 2024 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721943;
	bh=edfl9Qyi1j5BIY4+eq7G/coY2cxhe7prrDOpLepU/Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9BwwffoTSjhsPYDQ27tETDYUNRORa092Hi0lrS0GK2AQ4fPwZc4yjjpLDR0h5pxj
	 1HEhjHR676WDULoG70M4YdPrupwn0L+u7f0cCDfKk3gfHfGovrlQ/tH0FfPDu5v19s
	 JFDIb3HTNJVSew7BBpI8ax7IhEzoD8m+FEMyxCV+tQk/smk2HUHXD/WIJq2oLW/wGA
	 8QwYBQIdUClTMwt+3qUjGSMmjfkx8kS/Tja9/obW9fDtXWeUhQQ5bMNNpDNX0gS3DK
	 qfaLOmrQIPnCeX60xWnafWeu9zLg5Zuf9AhHzYbl8k8PWIeFua85zpfedahqUHR7h4
	 wJk6tczGAoX5A==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tasev Nikola <tasev.stefanoska@skynet.be>,
	Mark Enriquez <enriquezmark36@gmail.com>,
	Thomas Witt <kernel@witt.link>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7 5/5] PCI/ASPM: Call pci_save_ltr_state() from pci_save_pcie_state()
Date: Fri, 23 Feb 2024 14:58:51 -0600
Message-Id: <20240223205851.114931-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223205851.114931-1-helgaas@kernel.org>
References: <20240223205851.114931-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David E. Box" <david.e.box@linux.intel.com>

ASPM state is saved and restored from pci_save/restore_pcie_state().  Since
the LTR Capability is linked with ASPM, move the LTR save and restore calls
there as well.  No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20240128233212.1139663-6-david.e.box@linux.intel.com
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ca6673588bc0..4ea98665172d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1624,6 +1624,7 @@ static int pci_save_pcie_state(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
 
 	pci_save_aspm_l1ss_state(dev);
+	pci_save_ltr_state(dev);
 
 	return 0;
 }
@@ -1634,6 +1635,12 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	struct pci_cap_saved_state *save_state;
 	u16 *cap, lnkctl;
 
+	/*
+	 * Restore max latencies (in the LTR capability) before enabling
+	 * LTR itself in PCI_EXP_DEVCTL2.
+	 */
+	pci_restore_ltr_state(dev);
+
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
 	if (!save_state)
 		return;
@@ -1726,7 +1733,6 @@ int pci_save_state(struct pci_dev *dev)
 	if (i != 0)
 		return i;
 
-	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
@@ -1827,12 +1833,6 @@ void pci_restore_state(struct pci_dev *dev)
 	if (!dev->state_saved)
 		return;
 
-	/*
-	 * Restore max latencies (in the LTR capability) before enabling
-	 * LTR itself (in the PCIe capability).
-	 */
-	pci_restore_ltr_state(dev);
-
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
 	pci_restore_pri_state(dev);
-- 
2.34.1


