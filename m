Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDC33D2F29
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhGVUtG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 16:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231824AbhGVUtF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 16:49:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AD7E60E8F;
        Thu, 22 Jul 2021 21:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626989380;
        bh=Lz23JGy+v1mDBP4c8nviBW9vDZbHxkZ37b5vU6RZt3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDmTIGte49hhlTJe+xP1rCOKEdVr8p17RCKsZEd79fevg3LUokOIas1nZFL+MUjT+
         AcdZpMrvj50KLJ294lgztA7l2b5ifpOcVFZ6pzQiBorvYwrjTQvSFwJKmUnjNS9fQ1
         vO6FwZB+w9a5hN5O8CdlddiwoDNadISf/LKtbQpJus4s4qgiKCKdUa4lXsAPtz46ha
         CI3VnKebZ69LcvjAhzlwfRfz7mqeLinWEqarqf1zF2A7V0wsVXkje1KYGsP85xYkHi
         cfxZOCPpYOZ7+ZeMZXE5kfSJ9OaREITYkXnoWo6IEg0nTe2UAwk45NMg4RWdtPcvQb
         MIgJP3eAL3kzQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 6/9] PCI/VGA: Prefer vga_default_device()
Date:   Thu, 22 Jul 2021 16:29:17 -0500
Message-Id: <20210722212920.347118-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722212920.347118-1-helgaas@kernel.org>
References: <20210722212920.347118-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

Use the vga_default_device() interface consistently instead of directly
testing vga_default.  No functional change intended.

[bhelgaas: split to separate patch and extended]
Link: https://lore.kernel.org/r/20210705100503.1120643-1-chenhuacai@loongson.cn
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vgaarb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 1f8fb37be5fa..a6a5864ff538 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -173,7 +173,7 @@ int vga_remove_vgacon(struct pci_dev *pdev)
 {
 	int ret = 0;
 
-	if (pdev != vga_default)
+	if (pdev != vga_default_device())
 		return 0;
 	vgaarb_info(&pdev->dev, "deactivate vga console\n");
 
@@ -707,7 +707,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	/* Deal with VGA default device. Use first enabled one
 	 * by default if arch doesn't have it's own hook
 	 */
-	if (vga_default == NULL &&
+	if (!vga_default_device() &&
 	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
 		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
 		vga_set_default_device(pdev);
@@ -744,7 +744,7 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 		goto bail;
 	}
 
-	if (vga_default == pdev)
+	if (vga_default_device() == pdev)
 		vga_set_default_device(NULL);
 
 	if (vgadev->decodes & (VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM))
-- 
2.25.1

