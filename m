Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA35017738B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 11:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgCCKLN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 05:11:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37887 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728309AbgCCKLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 05:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583230272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0lKGMZz2mVXzfjH8foE9O3JFOJlrljIc2oxkVwn7z1E=;
        b=Ry6BJ4TsHQ7Tm8mNI5CGJDZ7zS6+Zm70vBkePruTpWpPg0T8iL7plJdS3/UsoNGx6EITG3
        AdAvCEoRkwdkMnpIpXp672tK2FOoGLoEY6IMkwAJUYEnH6gy3AO9xGGqfUP9C+Ex8FfAtS
        vTc0G8gVXLj6CbVyRlnqSbENTm4VBvQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-atG5fxPyNterAQutdOMNuw-1; Tue, 03 Mar 2020 05:11:06 -0500
X-MC-Unique: atG5fxPyNterAQutdOMNuw-1
Received: by mail-wm1-f71.google.com with SMTP id k65so212913wmf.7
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2020 02:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0lKGMZz2mVXzfjH8foE9O3JFOJlrljIc2oxkVwn7z1E=;
        b=t2oHUKxLCc8MjHd8+V6e+lw8RqxT0aNbou5YLQWp4DzJBkwrOKJD9bkI9GbX3TSDPL
         5JaoR1J8eVrA5o+3ks66p0ugohCfclP7RhkBItJrjjHFqgsN4GaTDORZ3rXVMmiMBc8s
         e/Uve7tt5r5rGW6DMx3+cLBGZZHssfhTbb86W4YGUEkfAkh1kh3digAt1uwFTQ2Dg/s6
         M2LlmQBhpuKUYASzhHAi5wT83JM29s7MzJglnxLm94FMusuYwk3WivehvZeq46769raW
         EbxSrtscENBQoTpLc4kappeRO0b89vYpoSsq969WGDzDdCXsUV9dgCFSU0JPfzAJ1Ttw
         NZBQ==
X-Gm-Message-State: ANhLgQ1tWfQerKqUdYrAr7gIJ+bWYLyTTX3uxb79guw41vdL4RtuN/u+
        ZydPQGrzCaE5EOIkd3Og37CX/vZlnEapv93Fo65hg2G0tIEM12B798aKVAPcf/+Yz29NmM7vqrr
        gQWhqsiIS3EcsZZ+Ll4Nd
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr3568987wmk.172.1583230264530;
        Tue, 03 Mar 2020 02:11:04 -0800 (PST)
X-Google-Smtp-Source: ADFU+vupO8zpDPGI2M251ftAIAreBbyyhVWtPWzvaf5Z4LtEpAgdcTDnuje0fNmPeffLysPi04uEaw==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr3568951wmk.172.1583230264185;
        Tue, 03 Mar 2020 02:11:04 -0800 (PST)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:482c:9537:40:83ba])
        by smtp.gmail.com with ESMTPSA id w206sm3315371wmg.11.2020.03.03.02.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 02:11:03 -0800 (PST)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH v6] pci: prevent putting nvidia GPUs into lower device states on certain intel bridges
Date:   Tue,  3 Mar 2020 11:10:52 +0100
Message-Id: <20200303101052.133631-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
states.

v2: convert to pci_dev quirk
    put a proper technical explanation of the issue as a in-code comment
v3: disable it only for certain combinations of intel and nvidia hardware
v4: simplify quirk by setting flag on the GPU itself
v5: restructure quirk to make it easier to add new IDs
    fix whitespace issues
    fix potential NULL pointer access
    update the quirk documentation
v6: move quirk into nouveau

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
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 56 +++++++++++++++++++++++++++
 drivers/pci/pci.c                     |  8 ++++
 include/linux/pci.h                   |  1 +
 3 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 2cd83849600f..51d3a7ba7731 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -618,6 +618,59 @@ nouveau_drm_device_fini(struct drm_device *dev)
 	kfree(drm);
 }
 
+/*
+ * On some Intel PCIe bridge controllers doing a
+ * D0 -> D3hot -> D3cold -> D0 sequence causes Nvidia GPUs to not reappear.
+ * Skipping the intermediate D3hot step seems to make it work again. Thise is
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
+ * with a secondary Nvidia Maxwell, Pascal or Turing GPU. Its unclear wheather
+ * this issue only occurs in combination with listed Intel PCIe bridge
+ * controllers and the mentioned GPUs or other devices as well.
+ *
+ * documentation on the PCIe bridge controller can be found in the
+ * "7th Generation Intel® Processor Families for H Platforms Datasheet Volume 2"
+ * Section "12 PCI Express* Controller (x16) Registers"
+ */
+
+static void quirk_broken_nv_runpm(struct pci_dev *dev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
+
+	if (!bridge || bridge->vendor != PCI_VENDOR_ID_INTEL)
+		return;
+
+	switch (bridge->device) {
+	case 0x1901:
+		dev->parent_d3cold = 1;
+	}
+}
+
 static int nouveau_drm_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *pent)
 {
@@ -699,6 +752,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 	if (ret)
 		goto fail_drm_dev_init;
 
+	quirk_broken_nv_runpm(pdev);
 	return 0;
 
 fail_drm_dev_init:
@@ -737,6 +791,8 @@ nouveau_drm_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	/* revert our workaround */
+	pdev->parent_d3cold = false;
 	nouveau_drm_device_remove(dev);
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 951099279192..6ece05723fa2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -860,6 +860,14 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	   || (state == PCI_D2 && !dev->d2_support))
 		return -EIO;
 
+	/*
+	 * Power management can be disabled for certain devices as they don't
+	 * come back up later on runtime_resume. We rely on platform means to
+	 * cut power consumption instead (e.g. ACPI).
+	 */
+	if (state != PCI_D0 && dev->parent_d3cold)
+		return 0;
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (pmcsr == (u16) ~0) {
 		pci_err(dev, "can't change power state from %s to %s (config space inaccessible)\n",
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 930fab293073..3e5938b91966 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -340,6 +340,7 @@ struct pci_dev {
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
+	unsigned int	parent_d3cold:1;	/* power manage the parent instead */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
 	unsigned int	wakeup_prepared:1;
-- 
2.24.1

