Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB3D21559E
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgGFKcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgGFKb4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 06:31:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E09C061794;
        Mon,  6 Jul 2020 03:31:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so38663092wmj.2;
        Mon, 06 Jul 2020 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RPTa/b9ulSr2LIoV7+9N5nhgam/KG2MWD7MpfjJwUI4=;
        b=TG4pzGRbEwH/BSJarGEyRYf1QP7euiq3ZvuQTcexU3ZoYSD+b8fqCNHTZEOCWFGXWf
         FfSoXFkDiMaB+pSiKoOy6gl2ISBkzY6SenyTzPtviHoLi+PZSSC3+dbUqBIv64wSLyzm
         l0L815djwPABf2iKVNWgUMkhl0Yu6//iDVLTkxJiy+M9FZQAt+fa9aGp4nPF3j0dptnL
         TAmviTKz/G7eCqJ686+bgEzJGbI15po6Pwlk1VRKHHCjT+539hC3LuaA0aynuNXG41u8
         I/O6EoGxYhVaVdls2XfiIzdklTWKIwJmOhKz9wYHDk5JmkqCw7WUMtJUFLSmRwxrf6su
         qjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RPTa/b9ulSr2LIoV7+9N5nhgam/KG2MWD7MpfjJwUI4=;
        b=n+KjJPvbR3Y9HUPlnadPYwlW5CAdm/JGYqFprFJF06vDny/lmxDXlVEJa1q1Fqm8Xy
         TKQGItJTnoOW5dnsctah9RKchLz85SddToTVIKHkpLSuPsfZxIpQq1uZAOG97jClWDvL
         O6ktBo5ZOQ1urBeOpAoIQ6nyHi9d6zqCfxlXj3b9ixyE0ROl44cx3/nG1WZLo2wX8ZI1
         1AaUCInB1BwoAAzuIjSQZlDfaKETZmtuOjGV/L4nQoy4Z7MJF7Sb5EAq8upJBWQ8lcnc
         Uw0wtIh0jKXuBYj+kP1vvreZZXe1H7A1yPebbuh3zM9+K43UBnVsy0Bst7QO4PubFphl
         YU2Q==
X-Gm-Message-State: AOAM531wmeWobjY296S3Y3r6v9oQ2rasceK6jRIaBD2sumYRpB1XE5Xm
        f+W4ePgdtDJWTYZQ4YGJ+IA=
X-Google-Smtp-Source: ABdhPJywhsCbkbFGmRLpYBAbKoNOxH4X7OJZCSZcE5Hy9HRvf3pC50XF2xqZYYR9LVEyfSHQgxlr7A==
X-Received: by 2002:a1c:9911:: with SMTP id b17mr44258657wme.135.1594031514919;
        Mon, 06 Jul 2020 03:31:54 -0700 (PDT)
Received: from net.saheed (51B7C2DF.dsl.pool.telekom.hu. [81.183.194.223])
        by smtp.gmail.com with ESMTPSA id 22sm24216859wmb.11.2020.07.06.03.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:31:54 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/11 RFC] PCI: pciehp: Validate with the return value of pcie_capability_read_*()
Date:   Mon,  6 Jul 2020 11:31:14 +0200
Message-Id: <20200706093121.9731-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200706093121.9731-1-refactormyself@gmail.com>
References: <20200706093121.9731-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0. 
However, with Patch 11/11, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided if the return value of pcie_capability_read_dword
is checked to confirm success.

Check the return value of pcie_capability_read_dword() to ensure success.
Return a value that indicate the result of pcie_capability_read_dword().

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 5af281d97d4f..0b691e37fd04 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -277,10 +277,11 @@ static void pcie_wait_for_presence(struct pci_dev *pdev)
 {
 	int timeout = 1250;
 	u16 slot_status;
+	int ret;
 
 	do {
-		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-		if (slot_status & PCI_EXP_SLTSTA_PDS)
+		ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		if (!ret && (slot_status & PCI_EXP_SLTSTA_PDS))
 			return;
 		msleep(10);
 		timeout -= 10;
@@ -354,12 +355,13 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
+	int ret;
 
 	pci_config_pm_runtime_get(pdev);
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	pci_config_pm_runtime_put(pdev);
 	*status = (slot_ctrl & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
-	return 0;
+	return pcibios_err_to_errno(ret);
 }
 
 int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
@@ -367,9 +369,10 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
+	int ret;
 
 	pci_config_pm_runtime_get(pdev);
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	pci_config_pm_runtime_put(pdev);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x, value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
@@ -389,7 +392,7 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
 		break;
 	}
 
-	return 0;
+	return pcibios_err_to_errno(ret);
 }
 
 void pciehp_get_power_status(struct controller *ctrl, u8 *status)
-- 
2.18.2

