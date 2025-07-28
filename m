Return-Path: <linux-pci+bounces-33020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42B0B13694
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560E03BA984
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2502263C9E;
	Mon, 28 Jul 2025 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLlR69pm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6561263C69;
	Mon, 28 Jul 2025 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691100; cv=none; b=rnd2oIhotiNwNvx3L5dR9Sw75e+VnTArNawimCeYCFQCAxK6yD0emLRc5aA8LwmD1Wk0ZuJlhwbjRZum37FVubTTV1bKmsuaBQCH4iuFQSc042kjQojmcMPZUg+8tF5QXygnLtyTTn0U0YwJEj6spV0woAEJ94ocOteyG3Bke9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691100; c=relaxed/simple;
	bh=RjQ9lLOR+hqYsdRtALB8u/DoMGz57ed2p6m/XA4z51M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jrheq7u5D3ABT494diiJMrxa8ltd7C4EIKcdDwQKKHNf46KkQGWk/B9o6WXDmFGAJenxtaK/FqqLUGf1qxu/iolItVkBKo6HBNgXvae2JVXCizcvTJ9+52Jf79JqbTfOMXR3saTEK2luXqnPGTBlM5taZ3kj7lgCrbGgRJ0BWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLlR69pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B243C4CEF7;
	Mon, 28 Jul 2025 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691100;
	bh=RjQ9lLOR+hqYsdRtALB8u/DoMGz57ed2p6m/XA4z51M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oLlR69pmP3SQeDZGMr749Syy24vgZydvIfXbHoj1wzhIihnJ4nOFUu5ksoMab+95b
	 66r4qIR5wFVPCwIpIYaS5iohWMrk7LUiyX5B9wm1BjZ34yjyTkYTkuiecAfc6Cg16x
	 BgbM4buzW036gj5F8gk6xyg/Z0W+mgXFv3c63TFhk2jEY8MuIJOSncjTjBEN35R7am
	 yIqrjsc7QQ4dXGpqztvF5jXSKJEbaynmxRn0NpYxdEHgf7LV6RTU5NHC2qBfgUTfY1
	 xApAJpIoI2usKRc57c6d0V1CI5dskEY6HXSSO0rZjquZUf6TE0h0+BSphVJfoCSfgJ
	 YtPI+YURtzP1g==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:50 -0700
Subject: [PATCH RFC 20/25] PCI/LUO: Avoid write to liveupdate devices at
 boot
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-20-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
In-Reply-To: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

The liveupdate devices are already initialized by the kernel before the
kexec. During the kexec the device is still running. Avoid write to the
liveupdate devices during the new kernel boot up.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/ats.c            |  7 ++--
 drivers/pci/iov.c            | 58 ++++++++++++++++++------------
 drivers/pci/msi/msi.c        | 32 ++++++++++++-----
 drivers/pci/msi/pcidev_msi.c |  4 +--
 drivers/pci/pci-acpi.c       |  3 ++
 drivers/pci/pci.c            | 85 +++++++++++++++++++++++++++++---------------
 drivers/pci/pci.h            |  9 ++++-
 drivers/pci/pcie/aspm.c      |  7 ++--
 drivers/pci/pcie/pme.c       | 11 ++++--
 drivers/pci/probe.c          | 43 +++++++++++++++-------
 drivers/pci/setup-bus.c      | 10 +++++-
 11 files changed, 184 insertions(+), 85 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9c9959e822e016ab301bf483713a5..284f43c82593903058dee58ce64b82bad8aed710 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -75,7 +75,9 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 
 	dev->ats_stu = ps;
 	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
-	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
+
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_prepare_ats);
@@ -114,7 +116,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 		dev->ats_stu = ps;
 		ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
 	}
-	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
 
 	dev->ats_enabled = 1;
 	return 0;
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 10693b5d7eb66bbbfb9b70ffe6e89eb89c8dc3a3..df27bcf840d9fc0dbce29810e288c1c2b74a70c9 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -85,7 +85,8 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
 {
 	struct pci_sriov *iov = dev->sriov;
 
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &iov->offset);
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
 }
@@ -694,10 +695,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 	pci_iov_set_numvfs(dev, nr_virtfn);
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
-	pci_cfg_access_lock(dev);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	msleep(100);
-	pci_cfg_access_unlock(dev);
+	if (!pci_lu_adopt(dev)) {
+		pci_cfg_access_lock(dev);
+		pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
+		msleep(100);
+		pci_cfg_access_unlock(dev);
+	}
 
 	rc = sriov_add_vfs(dev, initial);
 	if (rc)
@@ -710,10 +713,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 err_pcibios:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
-	pci_cfg_access_lock(dev);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	ssleep(1);
-	pci_cfg_access_unlock(dev);
+	if (!pci_lu_adopt(dev)) {
+		pci_cfg_access_lock(dev);
+		pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
+		ssleep(1);
+		pci_cfg_access_unlock(dev);
+	}
 
 	pcibios_sriov_disable(dev);
 
@@ -741,11 +746,13 @@ static void sriov_disable(struct pci_dev *dev)
 		return;
 
 	sriov_del_vfs(dev);
-	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
-	pci_cfg_access_lock(dev);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	ssleep(1);
-	pci_cfg_access_unlock(dev);
+	if (!pci_lu_adopt(dev)) {
+		iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
+		pci_cfg_access_lock(dev);
+		pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
+		ssleep(1);
+		pci_cfg_access_unlock(dev);
+	}
 
 	pcibios_sriov_disable(dev);
 
@@ -770,7 +777,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	u32 sriovbars[PCI_SRIOV_NUM_BARS];
 
 	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
-	if (ctrl & PCI_SRIOV_CTRL_VFE) {
+	if (!pci_lu_adopt(dev) && ctrl & PCI_SRIOV_CTRL_VFE) {
 		pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, 0);
 		ssleep(1);
 	}
@@ -785,7 +792,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 		ctrl |= PCI_SRIOV_CTRL_ARI;
 
 found:
-	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
 
 	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
 	if (!total)
@@ -798,7 +806,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 		return -EIO;
 
 	pgsz &= ~(pgsz - 1);
-	pci_write_config_dword(dev, pos + PCI_SRIOV_SYS_PGSIZE, pgsz);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_dword(dev, pos + PCI_SRIOV_SYS_PGSIZE, pgsz);
 
 	iov = kzalloc(sizeof(*iov), GFP_KERNEL);
 	if (!iov)
@@ -904,14 +913,17 @@ static void sriov_restore_state(struct pci_dev *dev)
 	 */
 	ctrl &= ~PCI_SRIOV_CTRL_ARI;
 	ctrl |= iov->ctrl & PCI_SRIOV_CTRL_ARI;
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, ctrl);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, ctrl);
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
 		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
 
-	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
 	pci_iov_set_numvfs(dev, iov->num_VFs);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	if (iov->ctrl & PCI_SRIOV_CTRL_VFE)
 		msleep(100);
 }
@@ -1013,10 +1025,12 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno)
 	new |= res->flags & ~PCI_BASE_ADDRESS_MEM_MASK;
 
 	reg = iov->pos + PCI_SRIOV_BAR + 4 * vf_bar;
-	pci_write_config_dword(dev, reg, new);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_dword(dev, reg, new);
 	if (res->flags & IORESOURCE_MEM_64) {
 		new = region.start >> 16 >> 16;
-		pci_write_config_dword(dev, reg + 4, new);
+		if (!pci_lu_adopt(dev))
+			pci_write_config_dword(dev, reg + 4, new);
 	}
 }
 
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6ede55a7c5e652c80b51b10e58f0290eb6556430..7c40fde1ba0f89ad1d72064ac9e80696faeab426 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -113,7 +113,8 @@ static int pci_setup_msi_context(struct pci_dev *dev)
 
 void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 {
-	raw_spinlock_t *lock = &to_pci_dev(desc->dev)->msi_lock;
+	struct pci_dev *pci_dev = to_pci_dev(desc->dev);
+	raw_spinlock_t *lock = &pci_dev->msi_lock;
 	unsigned long flags;
 
 	if (!desc->pci.msi_attrib.can_mask)
@@ -122,8 +123,9 @@ void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 	raw_spin_lock_irqsave(lock, flags);
 	desc->pci.msi_mask &= ~clear;
 	desc->pci.msi_mask |= set;
-	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
-			       desc->pci.msi_mask);
+	if (!pci_lu_adopt(pci_dev))
+		pci_write_config_dword(pci_dev, desc->pci.mask_pos,
+				       desc->pci.msi_mask);
 	raw_spin_unlock_irqrestore(lock, flags);
 }
 
@@ -190,6 +192,9 @@ static inline void pci_write_msg_msi(struct pci_dev *dev, struct msi_desc *desc,
 	int pos = dev->msi_cap;
 	u16 msgctl;
 
+	if (pci_lu_adopt(dev))
+		return;
+
 	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
 	msgctl &= ~PCI_MSI_FLAGS_QSIZE;
 	msgctl |= FIELD_PREP(PCI_MSI_FLAGS_QSIZE, desc->pci.msi_attrib.multiple);
@@ -214,6 +219,8 @@ static inline void pci_write_msg_msix(struct msi_desc *desc, struct msi_msg *msg
 
 	if (desc->pci.msi_attrib.is_virtual)
 		return;
+	if (pci_lu_adopt(to_pci_dev(desc->dev)))
+		return;
 	/*
 	 * The specification mandates that the entry is masked
 	 * when the message is modified:
@@ -279,7 +286,8 @@ static void pci_msi_set_enable(struct pci_dev *dev, int enable)
 	control &= ~PCI_MSI_FLAGS_ENABLE;
 	if (enable)
 		control |= PCI_MSI_FLAGS_ENABLE;
-	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
 static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
@@ -553,6 +561,7 @@ static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
 {
 	u16 ctrl;
 
+	BUG_ON(pci_lu_adopt(dev));
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
 	ctrl &= ~clear;
 	ctrl |= set;
@@ -720,8 +729,9 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	 * registers can be accessed.  Mask all the vectors to prevent
 	 * interrupts coming in before they're fully set up.
 	 */
-	pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
-				    PCI_MSIX_FLAGS_ENABLE);
+	if (!pci_lu_adopt(dev))
+		pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
+					    PCI_MSIX_FLAGS_ENABLE);
 
 	/* Mark it enabled so setup functions can query it */
 	dev->msix_enabled = 1;
@@ -753,14 +763,16 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 		 */
 		msix_mask_all(dev->msix_base, tsize);
 	}
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
+	if (!pci_lu_adopt(dev))
+		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);
 	return 0;
 
 out_disable:
 	dev->msix_enabled = 0;
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
+	if (!pci_lu_adopt(dev))
+		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
 
 	return ret;
 }
@@ -864,6 +876,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 	if (!dev->msix_enabled)
 		return;
 
+	BUG_ON(pci_lu_adopt(dev));
 	/* route the table */
 	pci_intx_for_msi(dev, 0);
 	pci_msix_clear_and_set_ctrl(dev, 0,
@@ -898,7 +911,8 @@ void pci_msix_shutdown(struct pci_dev *dev)
 	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL)
 		pci_msix_mask(desc);
 
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	if (!pci_lu_adopt(dev))
+		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msix_enabled = 0;
 	pcibios_alloc_irq(dev);
diff --git a/drivers/pci/msi/pcidev_msi.c b/drivers/pci/msi/pcidev_msi.c
index 5520aff53b5670e70311c63f0f358228bf03c309..f9f682a84a05ef47ff4d85e7d0e724cc7c2f5cdc 100644
--- a/drivers/pci/msi/pcidev_msi.c
+++ b/drivers/pci/msi/pcidev_msi.c
@@ -18,7 +18,7 @@ void pci_msi_init(struct pci_dev *dev)
 		return;
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &ctrl);
-	if (ctrl & PCI_MSI_FLAGS_ENABLE) {
+	if (!pci_lu_adopt(dev) && ctrl & PCI_MSI_FLAGS_ENABLE) {
 		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
 				      ctrl & ~PCI_MSI_FLAGS_ENABLE);
 	}
@@ -36,7 +36,7 @@ void pci_msix_init(struct pci_dev *dev)
 		return;
 
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
-	if (ctrl & PCI_MSIX_FLAGS_ENABLE) {
+	if (!pci_lu_adopt(dev) && ctrl & PCI_MSIX_FLAGS_ENABLE) {
 		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
 				      ctrl & ~PCI_MSIX_FLAGS_ENABLE);
 	}
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e58393aa0cbdf6d283b3afe33e5effb5..b9e42a1352c87443dd5c4ee9f03bc8a0d343d714 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -172,6 +172,9 @@ static void program_hpx_type0(struct pci_dev *dev, struct hpx_type0 *hpx)
 		hpx = &pci_default_type0;
 	}
 
+	if (pci_lu_adopt(dev))
+		return;
+
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, hpx->cache_line_size);
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, hpx->latency_timer);
 	pci_read_config_word(dev, PCI_COMMAND, &pci_cmd);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 46fb80dbca590c251fcad3bf2f011a16f6898810..c1cc723f979ae881cf07ad06e1fa0d472e8b89c6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -218,7 +218,7 @@ int pci_status_get_and_clear_errors(struct pci_dev *pdev)
 		return -EIO;
 
 	status &= PCI_STATUS_ERROR_BITS;
-	if (status)
+	if (status && !pci_lu_adopt(pdev))
 		pci_write_config_word(pdev, PCI_STATUS, status);
 
 	return status;
@@ -628,7 +628,7 @@ u64 pci_get_dsn(struct pci_dev *dev)
 	int pos;
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DSN);
-	if (!pos)
+	if (!pos && !pci_lu_adopt(dev))
 		return 0;
 
 	/*
@@ -1103,7 +1103,8 @@ static void pci_enable_acs(struct pci_dev *dev)
 			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
 
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
 }
 
 /**
@@ -1394,7 +1395,8 @@ int pci_power_up(struct pci_dev *dev)
 	 * Force the entire word to 0. This doesn't affect PME_Status, disables
 	 * PME_En, and sets PowerState to 0.
 	 */
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
 
 	/* Mandatory transition delays; see PCI PM 1.2. */
 	if (state == PCI_D3hot)
@@ -1552,7 +1554,8 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
 	pmcsr |= state;
 
 	/* Enter specified state */
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
 
 	/* Mandatory power management transition delays; see PCI PM 1.2. */
 	if (state == PCI_D3hot)
@@ -1781,7 +1784,8 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
 		return;
 	cap = (u16 *)&save_state->cap.data[0];
 
-	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
 }
 
 /**
@@ -2090,7 +2094,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
-		if (cmd & PCI_COMMAND_INTX_DISABLE)
+		if (!pci_lu_adopt(dev) && cmd & PCI_COMMAND_INTX_DISABLE)
 			pci_write_config_word(dev, PCI_COMMAND,
 					      cmd & ~PCI_COMMAND_INTX_DISABLE);
 	}
@@ -2248,7 +2252,8 @@ static void do_pci_disable_device(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
-		pci_write_config_word(dev, PCI_COMMAND, pci_command);
+		if (!pci_lu_adopt(dev))
+			pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
 
 	pcibios_disable_device(dev);
@@ -2369,7 +2374,8 @@ bool pci_check_pme_status(struct pci_dev *dev)
 		ret = true;
 	}
 
-	pci_write_config_word(dev, pmcsr_pos, pmcsr);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, pmcsr_pos, pmcsr);
 
 	return ret;
 }
@@ -2484,7 +2490,8 @@ static void __pci_pme_active(struct pci_dev *dev, bool enable)
 	if (!enable)
 		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
 
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
 }
 
 /**
@@ -2506,7 +2513,8 @@ void pci_pme_restore(struct pci_dev *dev)
 		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
 		pmcsr |= PCI_PM_CTRL_PME_STATUS;
 	}
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
 }
 
 /**
@@ -3587,12 +3595,14 @@ void pci_configure_ari(struct pci_dev *dev)
 		return;
 
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
-		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
-					 PCI_EXP_DEVCTL2_ARI);
+		if (!pci_lu_adopt(dev))
+			pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
+						 PCI_EXP_DEVCTL2_ARI);
 		bridge->ari_enabled = 1;
 	} else {
-		pcie_capability_clear_word(bridge, PCI_EXP_DEVCTL2,
-					   PCI_EXP_DEVCTL2_ARI);
+		if (!pci_lu_adopt(dev))
+			pcie_capability_clear_word(bridge, PCI_EXP_DEVCTL2,
+						   PCI_EXP_DEVCTL2_ARI);
 		bridge->ari_enabled = 0;
 	}
 }
@@ -4286,7 +4296,8 @@ static void __pci_set_master(struct pci_dev *dev, bool enable)
 	if (cmd != old_cmd) {
 		pci_dbg(dev, "%s bus mastering\n",
 			enable ? "enabling" : "disabling");
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
+		if (!pci_lu_adopt(dev))
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	dev->is_busmaster = enable;
 }
@@ -4416,7 +4427,8 @@ int pci_set_mwi(struct pci_dev *dev)
 	if (!(cmd & PCI_COMMAND_INVALIDATE)) {
 		pci_dbg(dev, "enabling Mem-Wr-Inval\n");
 		cmd |= PCI_COMMAND_INVALIDATE;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
+		if (!pci_lu_adopt(dev))
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
 #endif
@@ -4456,7 +4468,8 @@ void pci_clear_mwi(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	if (cmd & PCI_COMMAND_INVALIDATE) {
 		cmd &= ~PCI_COMMAND_INVALIDATE;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
+		if (!pci_lu_adopt(dev))
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 #endif
 }
@@ -4475,7 +4488,8 @@ void pci_disable_parity(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	if (cmd & PCI_COMMAND_PARITY) {
 		cmd &= ~PCI_COMMAND_PARITY;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
+		if (!pci_lu_adopt(dev))
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 }
 
@@ -4500,7 +4514,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
 	if (new == pci_command)
 		return;
 
-	pci_write_config_word(pdev, PCI_COMMAND, new);
+	if (!pci_lu_adopt(pdev))
+			pci_write_config_word(pdev, PCI_COMMAND, new);
 }
 EXPORT_SYMBOL_GPL(pci_intx);
 
@@ -4648,12 +4663,14 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D3hot;
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D0;
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
 	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
@@ -4959,6 +4976,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
 
+	BUG_ON(pci_lu_adopt(dev));
 	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
 	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
@@ -5186,7 +5204,8 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 * DMA from the device including MSI/MSI-X interrupts.  For PCI 2.3
 	 * compliant devices, INTx-disable prevents legacy interrupts.
 	 */
-	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
 }
 
 static void pci_dev_restore(struct pci_dev *dev)
@@ -5897,8 +5916,9 @@ int pcix_set_mmrbc(struct pci_dev *dev, int mmrbc)
 
 		cmd &= ~PCI_X_CMD_MAX_READ;
 		cmd |= FIELD_PREP(PCI_X_CMD_MAX_READ, v);
-		if (pci_write_config_word(dev, cap + PCI_X_CMD, cmd))
-			return -EIO;
+		if (!pci_lu_adopt(dev))
+			if (pci_write_config_word(dev, cap + PCI_X_CMD, cmd))
+				return -EIO;
 	}
 	return 0;
 }
@@ -5960,6 +5980,8 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 		}
 	}
 
+	if (pci_lu_adopt(dev))
+		return 0;
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_READRQ, v);
 
@@ -6004,6 +6026,8 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 		return -EINVAL;
 	v = FIELD_PREP(PCI_EXP_DEVCTL_PAYLOAD, v);
 
+	if (pci_lu_adopt(dev))
+		return 0;
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_PAYLOAD, v);
 
@@ -6304,7 +6328,8 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 			cmd |= command_bits;
 		else
 			cmd &= ~command_bits;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
+		if (!pci_lu_adopt(dev))
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 
 	if (!(flags & PCI_VGA_STATE_CHANGE_BRIDGE))
@@ -6320,8 +6345,9 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 				cmd |= PCI_BRIDGE_CTL_VGA;
 			else
 				cmd &= ~PCI_BRIDGE_CTL_VGA;
-			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL,
-					      cmd);
+			if (!pci_lu_adopt(bridge))
+				pci_write_config_word(bridge, PCI_BRIDGE_CONTROL,
+						      cmd);
 		}
 		bus = bus->parent;
 	}
@@ -6621,7 +6647,8 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	command &= ~PCI_COMMAND_MEMORY;
-	pci_write_config_word(dev, PCI_COMMAND, command);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, PCI_COMMAND, command);
 
 	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
 		pci_request_resource_alignment(dev, i, align, resize);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a8acc986a5aac808ec64395d7d946ee036270f5b..bd198227ae3cf687f4ddae76c2f53125681ca91d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1188,11 +1188,18 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
 
 void pci_liveupdate_restore(struct pci_dev *dev);
 void pci_liveupdate_override_driver(struct pci_dev *dev);
+static inline struct pci_dev_ser *pci_lu_adopt(struct pci_dev *dev)
+{
+	return dev->dev.lu.requested ? dev->dev.lu.dev_state : NULL;
+}
 #else
 #define PCI_SER_GET(__dev, __var, __def) __def
 
 static inline void pci_liveupdate_restore(struct pci_dev *dev) {}
 static inline void pci_liveupdate_override_driver(struct pci_dev *dev) {}
+static inline struct pci_dev_ser *pci_lu_adopt(struct pci_dev *dev)
+{
+	return NULL;
+}
 #endif
-
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 29fcb0689a918f9cb123691e1680de5a1af2c115..61f9a443f6ad2bad57d3fc5958e8855117f79598 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -788,7 +788,7 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
 }
 
-static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
+static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist, bool lu_restore)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 parent_lnkcap, child_lnkcap;
@@ -812,7 +812,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		return;
 
 	/* Configure common clock before checking latencies */
-	pcie_aspm_configure_common_clock(link);
+	if (!lu_restore)
+		pcie_aspm_configure_common_clock(link);
 
 	/*
 	 * Re-read upstream/downstream components' register state after
@@ -1130,7 +1131,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	 * upstream links also because capable state of them can be
 	 * update through pcie_aspm_cap_init().
 	 */
-	pcie_aspm_cap_init(link, blacklist);
+	pcie_aspm_cap_init(link, blacklist, pci_lu_adopt(pdev));
 
 	/* Setup initial Clock PM state */
 	pcie_clkpm_cap_init(link, blacklist);
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index a2daebd9806cd7273ee331406201402a758bd7b8..da093a5ba7ee1f9d20652c71e8e78662fdab176c 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -53,6 +53,8 @@ struct pcie_pme_service_data {
  */
 void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable)
 {
+	if (pci_lu_adopt(dev))
+		return;
 	if (enable)
 		pcie_capability_set_word(dev, PCI_EXP_RTCTL,
 					 PCI_EXP_RTCTL_PMEIE);
@@ -344,8 +346,10 @@ static int pcie_pme_probe(struct pcie_device *srv)
 	data->srv = srv;
 	set_service_data(srv, data);
 
-	pcie_pme_interrupt_enable(port, false);
-	pcie_clear_root_pme_status(port);
+	if (!pci_lu_adopt(port)) {
+		pcie_pme_interrupt_enable(port, false);
+		pcie_clear_root_pme_status(port);
+	}
 
 	ret = request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED, "PCIe PME", srv);
 	if (ret) {
@@ -356,7 +360,8 @@ static int pcie_pme_probe(struct pcie_device *srv)
 	pci_info(port, "Signaling with IRQ %d\n", srv->irq);
 
 	pcie_pme_mark_devices(port);
-	pcie_pme_interrupt_enable(port, true);
+	if (!pci_lu_adopt(port))
+		pcie_pme_interrupt_enable(port, true);
 	return 0;
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d8b80e1c4fb35289208d7c953fb5c1e137a5c1a8..5c30d1d52a96b17a92794756cab5db0972548267 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -358,7 +358,7 @@ static __always_inline void pci_read_bases(struct pci_dev *dev,
 		return;
 
 	/* No printks while decoding is disabled! */
-	if (!dev->mmio_always_on) {
+	if (!pci_lu_adopt(dev) && !dev->mmio_always_on) {
 		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
 		if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
 			pci_write_config_word(dev, PCI_COMMAND,
@@ -366,11 +366,13 @@ static __always_inline void pci_read_bases(struct pci_dev *dev,
 		}
 	}
 
-	__pci_size_stdbars(dev, howmany, PCI_BASE_ADDRESS_0, stdbars);
-	if (rom)
-		__pci_size_rom(dev, rom, &rombar);
+	if (!pci_lu_adopt(dev)) {
+		__pci_size_stdbars(dev, howmany, PCI_BASE_ADDRESS_0, stdbars);
+		if (rom)
+			__pci_size_rom(dev, rom, &rombar);
+	}
 
-	if (!dev->mmio_always_on &&
+	if (!pci_lu_adopt(dev) && !dev->mmio_always_on &&
 	    (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
 		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
 
@@ -1269,8 +1271,9 @@ static void pci_enable_rrs_sv(struct pci_dev *pdev)
 	/* Enable Configuration RRS Software Visibility if supported */
 	pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
 	if (root_cap & PCI_EXP_RTCAP_RRS_SV) {
-		pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
-					 PCI_EXP_RTCTL_RRS_SVE);
+		if (!pci_lu_adopt(pdev))
+			pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
+						 PCI_EXP_RTCTL_RRS_SVE);
 		pdev->config_rrs_sv = 1;
 	}
 }
@@ -1384,8 +1387,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	 * bus errors in some architectures.
 	 */
 	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
-			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
+				      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
 	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
 	    !is_cardbus && !broken) {
@@ -1404,6 +1408,10 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * more than one bridge. The second case can happen with
 		 * the i450NX chipset.
 		 */
+		if (pci_lu_adopt(dev)) {
+			/* Verify bus number here */
+		}
+
 		child = pci_find_bus(pci_domain_nr(bus), secondary);
 		if (!child) {
 			child = pci_add_new_bus(bus, dev, secondary);
@@ -1558,7 +1566,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	/* Clear errors in the Secondary Status Register */
 	pci_write_config_word(dev, PCI_SEC_STATUS, 0xffff);
 
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
+	if (!pci_lu_adopt(dev))
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
 
 	pm_runtime_put(&dev->dev);
 
@@ -2035,7 +2044,10 @@ int pci_setup_device(struct pci_dev *dev)
 	 * If we are not booted from liveupdate, default
 	 * "Unknown power state".
 	 */
-	dev->current_state = PCI_SER_GET(dev, current_state, PCI_UNKNOWN);
+	if (pci_lu_adopt(dev))
+		dev->current_state = 0; /* FIXME */
+	else
+		dev->current_state = PCI_SER_GET(dev, current_state, PCI_UNKNOWN);
 
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
@@ -2075,7 +2087,8 @@ int pci_setup_device(struct pci_dev *dev)
 						   dev->hotplug_user_indicators);
 	dev->pref_window = PCI_SER_GET(dev, pref_window,
 				       dev->pref_window);
-	dev->pref_64_window = PCI_SER_GET(dev, pref_64_window,
+	if (!pci_lu_adopt(dev))
+		dev->pref_64_window = PCI_SER_GET(dev, pref_64_window,
 					  dev->pref_64_window);
 
 	switch (dev->hdr_type) {		    /* header type */
@@ -2269,6 +2282,10 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 	if (!host)
 		return 0;
 
+
+	if (pci_lu_adopt(dev))
+		return 0;
+
 	/*
 	 * If some device in the hierarchy doesn't handle Extended Tags
 	 * correctly, make sure they're disabled.
@@ -2373,7 +2390,7 @@ static void pci_configure_serr(struct pci_dev *dev)
 		 * endpoint unless SERR# forwarding is enabled.
 		 */
 		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
-		if (!(control & PCI_BRIDGE_CTL_SERR)) {
+		if (!pci_lu_adopt(dev) && !(control & PCI_BRIDGE_CTL_SERR)) {
 			control |= PCI_BRIDGE_CTL_SERR;
 			pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
 		}
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 07c3d021a47ec794aaae13e1c12a667cfb47cb45..276a62c6957218c0c89d8881b1a4d6f6d419dacf 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -706,6 +706,9 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 		io_upper16 = 0;
 		l = 0x00f0;
 	}
+
+	if (pci_lu_adopt(bridge))
+		return;
 	/* Temporarily disable the I/O range before updating PCI_IO_BASE */
 	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0x0000ffff);
 	/* Update lower 16 bits of I/O base/limit */
@@ -732,6 +735,8 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	} else {
 		l = 0x0000fff0;
 	}
+	if (pci_lu_adopt(bridge))
+		return;
 	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
 }
 
@@ -765,6 +770,8 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	} else {
 		l = 0x0000fff0;
 	}
+	if (pci_lu_adopt(bridge))
+		return;
 	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
 
 	/* Set the upper 32 bits of PREF base & limit */
@@ -787,7 +794,8 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 	if (type & IORESOURCE_PREFETCH)
 		pci_setup_bridge_mmio_pref(bridge);
 
-	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
+	if (!pci_lu_adopt(bridge))
+		pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
 }
 
 void __weak pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)

-- 
2.50.1.487.gc89ff58d15-goog


