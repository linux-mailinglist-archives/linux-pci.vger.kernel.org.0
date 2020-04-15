Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC151AA174
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 14:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369990AbgDOMlB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 08:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409043AbgDOLn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 07:43:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8381520737;
        Wed, 15 Apr 2020 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951035;
        bh=+J1rnpev1mWG2DjbDUlUXV/sV3CYW4t3iOt9gosTfsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WG/RnBdq/Y29xhbRQBT7r9cM9lAlHFnlbIjQrD5jUFYvbjQmGu86zc28tf1AAKXBJ
         6faXt7L6YrZSp5wu9mRfet+3CjqF3FETUO//L1U2cKnDRAsf4cUYg+V7DBuQDqNsmM
         V1slExToiiwoqXMVjbVscBPAM+VPQPblewZQ0Uvk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 072/106] drm/nouveau: workaround runpm fail by disabling PCI power management on certain intel bridges
Date:   Wed, 15 Apr 2020 07:41:52 -0400
Message-Id: <20200415114226.13103-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Karol Herbst <kherbst@redhat.com>

[ Upstream commit 434fdb51513bf3057ac144d152e6f2f2b509e857 ]

Fixes the infamous 'runtime PM' bug many users are facing on Laptops with
Nvidia Pascal GPUs by skipping said PCI power state changes on the GPU.

Depending on the used kernel there might be messages like those in demsg:

"nouveau 0000:01:00.0: Refused to change power state, currently in D3"
"nouveau 0000:01:00.0: can't change power state from D3cold to D0 (config
space inaccessible)"
followed by backtraces of kernel crashes or timeouts within nouveau.

It's still unkown why this issue exists, but this is a reliable workaround
and solves a very annoying issue for user having to choose between a
crashing kernel or higher power consumption of their Laptops.

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205623
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 63 +++++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_drv.h |  2 +
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 2cd83849600f3..b1beed40e746a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -618,6 +618,64 @@ nouveau_drm_device_fini(struct drm_device *dev)
 	kfree(drm);
 }
 
+/*
+ * On some Intel PCIe bridge controllers doing a
+ * D0 -> D3hot -> D3cold -> D0 sequence causes Nvidia GPUs to not reappear.
+ * Skipping the intermediate D3hot step seems to make it work again. This is
+ * probably caused by not meeting the expectation the involved AML code has
+ * when the GPU is put into D3hot state before invoking it.
+ *
+ * This leads to various manifestations of this issue:
+ *  - AML code execution to power on the GPU hits an infinite loop (as the
+ *    code waits on device memory to change).
+ *  - kernel crashes, as all PCI reads return -1, which most code isn't able
+ *    to handle well enough.
+ *
+ * In all cases dmesg will contain at least one line like this:
+ * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
+ * followed by a lot of nouveau timeouts.
+ *
+ * In the \_SB.PCI0.PEG0.PG00._OFF code deeper down writes bit 0x80 to the not
+ * documented PCI config space register 0x248 of the Intel PCIe bridge
+ * controller (0x1901) in order to change the state of the PCIe link between
+ * the PCIe port and the GPU. There are alternative code paths using other
+ * registers, which seem to work fine (executed pre Windows 8):
+ *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
+ *  - 0xb0 bit 0x10 (link disable)
+ * Changing the conditions inside the firmware by poking into the relevant
+ * addresses does resolve the issue, but it seemed to be ACPI private memory
+ * and not any device accessible memory at all, so there is no portable way of
+ * changing the conditions.
+ * On a XPS 9560 that means bits [0,3] on \CPEX need to be cleared.
+ *
+ * The only systems where this behavior can be seen are hybrid graphics laptops
+ * with a secondary Nvidia Maxwell, Pascal or Turing GPU. It's unclear whether
+ * this issue only occurs in combination with listed Intel PCIe bridge
+ * controllers and the mentioned GPUs or other devices as well.
+ *
+ * documentation on the PCIe bridge controller can be found in the
+ * "7th Generation Intel® Processor Families for H Platforms Datasheet Volume 2"
+ * Section "12 PCI Express* Controller (x16) Registers"
+ */
+
+static void quirk_broken_nv_runpm(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct nouveau_drm *drm = nouveau_drm(dev);
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
+
+	if (!bridge || bridge->vendor != PCI_VENDOR_ID_INTEL)
+		return;
+
+	switch (bridge->device) {
+	case 0x1901:
+		drm->old_pm_cap = pdev->pm_cap;
+		pdev->pm_cap = 0;
+		NV_INFO(drm, "Disabling PCI power management to avoid bug\n");
+		break;
+	}
+}
+
 static int nouveau_drm_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *pent)
 {
@@ -699,6 +757,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 	if (ret)
 		goto fail_drm_dev_init;
 
+	quirk_broken_nv_runpm(pdev);
 	return 0;
 
 fail_drm_dev_init:
@@ -736,7 +795,11 @@ static void
 nouveau_drm_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct nouveau_drm *drm = nouveau_drm(dev);
 
+	/* revert our workaround */
+	if (drm->old_pm_cap)
+		pdev->pm_cap = drm->old_pm_cap;
 	nouveau_drm_device_remove(dev);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 70f34cacc552c..8104e3806499d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -138,6 +138,8 @@ struct nouveau_drm {
 
 	struct list_head clients;
 
+	u8 old_pm_cap;
+
 	struct {
 		struct agp_bridge_data *bridge;
 		u32 base;
-- 
2.20.1

