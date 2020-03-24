Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29FFE191B01
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 21:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgCXUaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 16:30:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52090 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbgCXUaI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 16:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585081807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oqlWAFHesN/RHI+MMNc8I7K/onEOpyLu9QGbne4wi5Y=;
        b=D7pF3nPHO1IpZK3Oh2APCNzVHanIS2F+C+JMzE67l09luJOVtwiLCnQ5xfx3NNCbCRSI2n
        ZEVtJmhxmEAOfUR4ZsZpvbjSj9Aem3ASI3484d3q2FI9hJ9gkmwL/W+T3STnO5NZPflfJM
        2Acnjv2S3GP6be2wpCR03/tJloK5qFc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-cslXHNXjM0O0hWTJB3ggMg-1; Tue, 24 Mar 2020 16:30:02 -0400
X-MC-Unique: cslXHNXjM0O0hWTJB3ggMg-1
Received: by mail-wm1-f69.google.com with SMTP id v184so44253wme.7
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2020 13:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqlWAFHesN/RHI+MMNc8I7K/onEOpyLu9QGbne4wi5Y=;
        b=AxEamg/8OQIOW2nMbCWwuCKZ4HDH9qboq99i8J5/TIWKSq3vCWed4ZYG/neQtBDiSD
         RAX14fXGY+SFdQKbliot86Vy77Ea+h5AQeBa7eu3LvTnCXf1AF73E0qX96xZZSgKfgpU
         RMIRhV2hr+5USlafH+wWinQ+4huZVXHUU0BXBR3anekyy0qUQAdUq0TwibGszUq4pQfP
         mfpa1PcFn7INcWWYjGVY6mudYbKRnv/LHnfHTwal6R3nQY5HvkxZrXGses1agXFohgAn
         +//4bgZN8NwRYi/KXtxmcYlXHfw0yilhQGCEx8fBHI52trf+/MXzjYxSUL6NF+5U3XvH
         2TpQ==
X-Gm-Message-State: ANhLgQ0C3xXaMHRn3Zq5dvwverHGStylJkl+3EaDwa+MSriSFDf5nF5B
        kevTvcResSix8GYCv+1cpc2riKX6ONLMgDNOWdGTzSZLF7lLXfj2kr83clOvgfKNSOXb8xpS95A
        zjKiYMMnjuNhElgl3bPGS
X-Received: by 2002:a1c:6885:: with SMTP id d127mr7753872wmc.33.1585081800435;
        Tue, 24 Mar 2020 13:30:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvIY5CA/8Fe50Ih+Aod7V43o1+7JOiD1nO06uMbkDwbr1OCRti+bQ3gJPU5pQHHiCISFfOB/g==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr7753841wmc.33.1585081800140;
        Tue, 24 Mar 2020 13:30:00 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:482c:9537:40:83ba])
        by smtp.gmail.com with ESMTPSA id k204sm5982051wma.17.2020.03.24.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 13:29:59 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH v8] pci: prevent putting nvidia GPUs into lower device states on certain intel bridges
Date:   Tue, 24 Mar 2020 21:29:23 +0100
Message-Id: <20200324202923.64625-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
---
v2: convert to pci_dev quirk
    put a proper technical explanation of the issue as a in-code comment
v3: disable it only for certain combinations of intel and nvidia hardware
v4: simplify quirk by setting flag on the GPU itself
v5: restructure quirk to make it easier to add new IDs
    fix whitespace issues
    fix potential NULL pointer access
    update the quirk documentation
v6: move quirk into nouveau
v7: fix typos and commit message
v8: reset the pm_cap field to get rid of changes in pci core (thanks to
    Bjorn for this idea)

 drivers/gpu/drm/nouveau/nouveau_drm.c | 63 +++++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_drv.h |  2 +
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 2cd83849600f..b1beed40e746 100644
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
index 70f34cacc552..8104e3806499 100644
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
2.25.1

