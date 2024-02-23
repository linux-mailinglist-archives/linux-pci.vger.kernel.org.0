Return-Path: <linux-pci+bounces-3948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E46861E4F
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 21:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EBE1C252ED
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5992F14CAB0;
	Fri, 23 Feb 2024 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5aQf8va"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138014CAB1;
	Fri, 23 Feb 2024 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721942; cv=none; b=uikbhXimspTFSqMC3ZZXH1kSICM1oW1srr6z6yIa4kwl+jj62YOmp6n8JumVKGvx5DsGxI2EfJ4hIjJcdS3envpGwVIppUBAAUBY79LAx2ZVpUG8eAbE9iiMPfd4/dqZBq28tj0AoNho2JWxIluscvbICE9VRbGnqBYCos4ZXQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721942; c=relaxed/simple;
	bh=3kOdjLWSBzyCR8MnX5A46CuygIj+MZWFIthe0qZ9HaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hAaDlASmHetT/kiX+3EAKoD7DE58iSC34A/FvLX90oSfDV7d7LcD4x9WqQn6GrHYaKL0E/cH3f9tANNuCdJEK7aBIbbY0WSJ5+TESaMfKv/hDHq5SrKmmvbgI6kLLXZw3y0MMsDZWFuNZ5jvlZBa0ZS1JKcIu+ejxJ5tD6y86Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5aQf8va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8856C43394;
	Fri, 23 Feb 2024 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721942;
	bh=3kOdjLWSBzyCR8MnX5A46CuygIj+MZWFIthe0qZ9HaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5aQf8vaFkyJd6khdYNq7kyhkQZRX4+APSt07igYODyQiN2NQ6uDjbfgJIPC+l+DG
	 4Eyo2zvCedHcant2K+ylNM2GDqJNb1fTG5IR8S99mP2/P41zw6aeer4ulujiaPv3SY
	 RYqYtNqLHw/DFuTkwq6ZBe/c+dQp8PJ/bP1uzo8fDPn4XlwbY/f/kxHL4XKP5g9w9p
	 TG04Yk2fogISZWjmKGdp4T2OUn1EHilckNcfl2ZP1/+O0gPMbY0vfMzTVFdumDBQIe
	 jK5A/gCr/45t3byzD6f9B5T9Z/GrLfa5WqR3OLMEZ1phSrcdetxUr7MhMF+UqLl9Ta
	 SByIQZDizsMdw==
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
	Koba Ko <koba.ko@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7 4/5] PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
Date: Fri, 23 Feb 2024 14:58:50 -0600
Message-Id: <20240223205851.114931-5-helgaas@kernel.org>
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

4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
suspend/resume") restored the L1 PM Substates Capability after resume,
which reduced power consumption by making the ASPM L1.x states work after
resume.

a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for
suspend/resume"") reverted 4ff116d0d5fd because resume failed on some
systems, so power consumption after resume increased again.

a7152be79b62 mentioned that we restore L1 PM substate configuration even
though ASPM L1 may already be enabled. This is due the fact that the
pci_restore_aspm_l1ss_state() was called before pci_restore_pcie_state().

Save and restore the L1 PM Substates Capability, following PCIe r6.1, sec
5.5.4 more closely by:

  1) Do not restore ASPM configuration in pci_restore_pcie_state() but
     do that after PCIe capability is restored in pci_restore_aspm_state()
     following PCIe r6.1, sec 5.5.4.

  2) If BIOS reenables L1SS, particularly L1.2, we need to clear the
     enables in the right order, downstream before upstream. Defer
     restoring the L1SS config until we are at the downstream component.
     Then update the config for both ends of the link in the prescribed
     order.

  3) Program ASPM L1 PM substate configuration before L1 enables.

  4) Program ASPM L1 PM substate enables last, after rest of the fields
     in the capability are programmed.

Link: https://lore.kernel.org/r/20240128233212.1139663-3-david.e.box@linux.intel.com
Link: https://lore.kernel.org/r/20240128233212.1139663-4-david.e.box@linux.intel.com
Reported-by: Koba Ko <koba.ko@canonical.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217321
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216782
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216877
Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Co-developed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
[bhelgaas: commit log, squash L1SS-related patches, do both LNKCTL restores
in pci_restore_pcie_state()]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tasev Nikola <tasev.stefanoska@skynet.be>
Cc: Mark Enriquez <enriquezmark36@gmail.com>
Cc: Thomas Witt <kernel@witt.link>
Cc: Werner Sembach <wse@tuxedocomputers.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c       |  17 ++++++-
 drivers/pci/pci.h       |   3 ++
 drivers/pci/pcie/aspm.c | 102 ++++++++++++++++++++++++++++++++++++++--
 drivers/pci/probe.c     |   1 +
 include/linux/pci.h     |   2 +-
 5 files changed, 119 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 564e2cf2dde5..ca6673588bc0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1623,6 +1623,8 @@ static int pci_save_pcie_state(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
 	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
 
+	pci_save_aspm_l1ss_state(dev);
+
 	return 0;
 }
 
@@ -1630,7 +1632,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 {
 	int i = 0;
 	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	u16 *cap, lnkctl;
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
 	if (!save_state)
@@ -1645,12 +1647,23 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 
 	cap = (u16 *)&save_state->cap.data[0];
 	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
+
+	/* Restore LNKCTL register with ASPM control field clear */
+	lnkctl = cap[i++];
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL,
+				   lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_RTCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
+
+	pci_restore_aspm_l1ss_state(dev);
+
+	/* Restore ASPM control after restoring L1SS state */
+	pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
+				 lnkctl & PCI_EXP_LNKCTL_ASPMC);
 }
 
 static int pci_save_pcix_state(struct pci_dev *dev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ad3add45345c..eca5938deb07 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -571,6 +571,9 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 /* ASPM-related functionality we need even without CONFIG_PCIEASPM */
 void pci_save_ltr_state(struct pci_dev *dev);
 void pci_restore_ltr_state(struct pci_dev *dev);
+void pci_configure_aspm_l1ss(struct pci_dev *dev);
+void pci_save_aspm_l1ss_state(struct pci_dev *dev);
+void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
 
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 21731b232fb8..977eca893b2a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -64,6 +64,105 @@ void pci_restore_ltr_state(struct pci_dev *dev)
 	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
 }
 
+void pci_configure_aspm_l1ss(struct pci_dev *pdev)
+{
+	int rc;
+
+	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+
+	rc = pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_L1SS,
+					 2 * sizeof(u32));
+	if (rc)
+		pci_err(pdev, "unable to allocate ASPM L1SS save buffer (%pe)\n",
+			ERR_PTR(rc));
+}
+
+void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 l1ss = pdev->l1ss;
+	u32 *cap;
+
+	/*
+	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
+	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
+	 */
+	if (!l1ss)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
+}
+
+void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
+	struct pci_dev *parent = pdev->bus->self;
+	u32 *cap, pl_ctl1, pl_ctl2, pl_l1_2_enable;
+	u32 cl_ctl1, cl_ctl2, cl_l1_2_enable;
+
+	/*
+	 * In case BIOS enabled L1.2 when resuming, we need to disable it first
+	 * on the downstream component before the upstream. So, don't attempt to
+	 * restore either until we are at the downstream component.
+	 */
+	if (pcie_downstream_port(pdev) || !parent)
+		return;
+
+	if (!pdev->l1ss || !parent->l1ss)
+		return;
+
+	cl_save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
+	if (!cl_save_state || !pl_save_state)
+		return;
+
+	cap = &cl_save_state->cap.data[0];
+	cl_ctl2 = *cap++;
+	cl_ctl1 = *cap;
+	cap = &pl_save_state->cap.data[0];
+	pl_ctl2 = *cap++;
+	pl_ctl1 = *cap;
+
+	/*
+	 * Disable L1.2 on this downstream endpoint device first, followed
+	 * by the upstream
+	 */
+	pci_clear_and_set_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1_2_MASK, 0);
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1_2_MASK, 0);
+
+	/*
+	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD
+	 * in PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
+	 * enable bits, even though they're all in PCI_L1SS_CTL1.
+	 */
+	pl_l1_2_enable = pl_ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	pl_ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
+	cl_l1_2_enable = cl_ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	cl_ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
+
+	/* Write back without enables first (above we cleared them in ctl1) */
+	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, pl_ctl2);
+	pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cl_ctl2);
+	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, pl_ctl1);
+	pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cl_ctl1);
+
+	/* Then write back the enables */
+	if (pl_l1_2_enable || cl_l1_2_enable) {
+		pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       pl_ctl1 | pl_l1_2_enable);
+		pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
+				       cl_ctl1 | cl_l1_2_enable);
+	}
+}
+
 #ifdef CONFIG_PCIEASPM
 
 #ifdef MODULE_PARAM_PREFIX
@@ -1005,9 +1104,6 @@ void pci_configure_ltr(struct pci_dev *pdev)
 	if (!pci_is_pcie(pdev))
 		return;
 
-	/* Read L1 PM substate capabilities */
-	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-
 	pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &cap);
 	if (!(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b809c0b0e0e5..1434bf495db3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2259,6 +2259,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
 	pci_configure_ltr(dev);
+	pci_configure_aspm_l1ss(dev);
 	pci_configure_eetlp_prefix(dev);
 	pci_configure_serr(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index add9368e6314..6967ae7b4115 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -390,9 +390,9 @@ struct pci_dev {
 	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
+	u16		l1ss;		/* L1SS Capability pointer */
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
-	u16		l1ss;		/* L1SS Capability pointer */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
 #endif
-- 
2.34.1


