Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D954C3D2F27
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 23:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhGVUtE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 16:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231824AbhGVUtE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 16:49:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F1B060C41;
        Thu, 22 Jul 2021 21:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626989378;
        bh=jzI4K0thGJA1hYgjMq9AeGLmE9HeNM6DZi9oIzIppys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/Cz/zr3klCDL8wPUjP5VrC4X/FslhOLTp7JbvxX+f0NBrSFiTiIEKOFbecMBGbtE
         ZOKxnjYy+XbsYdkEWspu64XXYlxq205X4H81mQnWKAl7CAjHeMeN85/4YMvJQOt4Hp
         +5Fb2gljR+gsviWyxROLE0evWIr0fnKBzp529KiypXrwW70THxu3BLfXQxNcPOMf9N
         i5mX7KWhsPIm7m0ABC1yiU+HFzgStMdWbueDYlPt/Ge0OSbn8C5a5azqQBCFAignl5
         pUrPAavTxITT0v/jlSqxt5oowCIcGZ+KN2U51oWt02sft/dG3FNWUrPmgLJil3Krd6
         +MfANMJEmrHhw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 5/9] PCI/VGA: Move vga_arb_integrated_gpu() earlier in file
Date:   Thu, 22 Jul 2021 16:29:16 -0500
Message-Id: <20210722212920.347118-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722212920.347118-1-helgaas@kernel.org>
References: <20210722212920.347118-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

Move vga_arb_integrated_gpu() earlier in file to prepare for future patch.
No functional change intended.

[bhelgaas: split to separate patch]
Link: https://lore.kernel.org/r/20210705100503.1120643-1-chenhuacai@loongson.cn
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vgaarb.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index c984c76b3fd7..1f8fb37be5fa 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -563,6 +563,20 @@ void vga_put(struct pci_dev *pdev, unsigned int rsrc)
 }
 EXPORT_SYMBOL(vga_put);
 
+#if defined(CONFIG_ACPI)
+static bool vga_arb_integrated_gpu(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
+}
+#else
+static bool vga_arb_integrated_gpu(struct device *dev)
+{
+	return false;
+}
+#endif
+
 /*
  * Rules for using a bridge to control a VGA descendant decoding: if a bridge
  * has only one VGA descendant then it can be used to control the VGA routing
@@ -1416,20 +1430,6 @@ static struct miscdevice vga_arb_device = {
 	MISC_DYNAMIC_MINOR, "vga_arbiter", &vga_arb_device_fops
 };
 
-#if defined(CONFIG_ACPI)
-static bool vga_arb_integrated_gpu(struct device *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-
-	return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
-}
-#else
-static bool vga_arb_integrated_gpu(struct device *dev)
-{
-	return false;
-}
-#endif
-
 static void __init vga_arb_select_default_device(void)
 {
 	struct pci_dev *pdev, *found = NULL;
-- 
2.25.1

