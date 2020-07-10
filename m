Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08AA21BFA7
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 00:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGJWUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 18:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGJWUU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 18:20:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AAFC08C5DC;
        Fri, 10 Jul 2020 15:20:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so7350365wrv.9;
        Fri, 10 Jul 2020 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Aw1VsrtSYtcq2poBq51sXMfz6dSvwXJUJRkwZAWrd10=;
        b=aG717Mh+yfnVzffccC3T0g+foEBFsfS7f2qjhmFbKfu/ee4DvajkEXLibWdoOSN7Gy
         O2NlqE/yED1WCoVri14mxo1nA/DhbC4TfFlh+gDBhkTm1i++nEIvYhUnzX75RuLHVhxn
         N5qjIWWQTLGympOy6JJWc3WCP5U9JJE8x4rilTRv6CObWA2Npbxl8MILdn1cGUsg8uSf
         IcFSnILXaC+/DetMjFrcZg99zlfx/4nMgcNCPUU1OEUwYVeKbACTIARFV52P8VyaIUjL
         xRZYffbDwY9H9ssJZP1M7fjNvV9Hb7XepWAyzFgoN8RL4oGs+tKFrYDoFvFNAalnk/1b
         xxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Aw1VsrtSYtcq2poBq51sXMfz6dSvwXJUJRkwZAWrd10=;
        b=iVVqeHAizx2Kvp3Pyl+syFjEYMKCt8j2ASEjJHSF33ZXAzuoZNrKaLG6nzGkzrDmiW
         Mh6dXzYjswdLQSC2sbDbJ9dWZUpPcOVfk/0wAhcsBj/EUTbtOyC4JZ6K0r6RD8+Xi58x
         oZ+HHCUHh3u9bfjtHhiVIpo8fdt4juGxrsyylf1QSzF6AJVKkcxy34mRdy/5jDpt29Ev
         /cTN7D0Wr9OV0kMXfwQjTDw+7COWw7TctB5pRqNfexz/PwhNn8OHC/WX14iKY/NFDxH+
         /G/Un3LuJ6QUpiCzIyvZ3TN4VHVcYMvz9zRiKPFjy0r09j6YhHp+a3ZIAYnPJifCm5vg
         vQPg==
X-Gm-Message-State: AOAM531ZEdFq0ei0A21hWCFYVKKh0vLW3MbmBXXngKJR06qN5ZLK8dSy
        NsoGNnb3rFleZvqyhBOvivE=
X-Google-Smtp-Source: ABdhPJyv0JZcNwPCwOQC9NfYv6P2Yb1NOOR9kLooOJDcTnXEuQTTkqbzAPMkpAORzJE7k8uyZ+FXmg==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr58545944wrw.244.1594419619001;
        Fri, 10 Jul 2020 15:20:19 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id l18sm12170281wrm.52.2020.07.10.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:20:18 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/14 v3] PCI: pciehp: Check return value of pcie_capability_read_*()
Date:   Fri, 10 Jul 2020 23:20:21 +0200
Message-Id: <20200710212026.27136-10-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200710212026.27136-1-refactormyself@gmail.com>
References: <20200710212026.27136-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0. 
However, with Patch 14/14, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided if the return value of pcie_capability_read_word
is checked to confirm success.

Check the return value of pcie_capability_read_dword() to ensure success.
Return a value that indicate the result of pcie_capability_read_word().

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

