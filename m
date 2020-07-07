Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA127217B85
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 01:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgGGXDy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 19:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgGGXDy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 19:03:54 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B922AC061755;
        Tue,  7 Jul 2020 16:03:53 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d15so40116479edm.10;
        Tue, 07 Jul 2020 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eY89BPPTiAbIPWAjBEdTw0ysBE/zoRKUZt/LDQGznDA=;
        b=cR/htFZybFnDdH1v7bzSScUacdKDzpXrdA6L/nLOsL671HZYvHmh2OGx2Hvt3akKpW
         3t5KkdjRVd16s4pp2hfTJjT+wZnbO6MvAhfCfHfiKLIs+KZhYPZeTxARw5JU0MZj+Dg7
         X2v1UiKCeX9kYQOuvgmJruQaYbSg4fn+083Elaw5XkpGTqTT3L59awPZbqkrxkEcByeX
         2kk5tUfh6zL6217i2K2MxCgx2TcUR6W/sIgk99EvHaJQD1QTZgMFQqXdsVKxTPH1CS3q
         foG3/ReCC30WneVCGZhdZqRLBZRGATKLKV+Qh6hll4q6HFDgah+eQ9mvjS2bexfn5dEo
         V4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eY89BPPTiAbIPWAjBEdTw0ysBE/zoRKUZt/LDQGznDA=;
        b=jGBYmLOkZHTuxWjwiY194WwJXxnai0xgBGDqX4/0xuHqDOjuJVlZcuCeHJPFhQHLXj
         Erw43HmByGVV2rfAxrwaPbzKjDrfer8fJYQ+xUVU5wla8IlwoEumBenYHZex6dCXQiSb
         m6WtDRDgKypPCCR0yUq8/5F7XABo/LT8+qyvPo1I9V45udFMTrb9qvSiGHyL+DhEWRTf
         bpBS7G+c0noblcy1uoIVJ3fEEd/oU/guOlDe5ozJcok0TRQsZa95cdjzG/WNV0hsjBUT
         HI/6loEYWyP1ZBEH08zWCmB50O1wpGnNTo6HvaOeoleKs2ziBYwShTwc5LYwOVveL7Q8
         1ZNw==
X-Gm-Message-State: AOAM532NIGd0evppc1wVK3izfADVm3wH/1KD8YCaMcuTT35rGg2/KeEW
        6aa6rvwzQa7bjA5RlD7LSUA=
X-Google-Smtp-Source: ABdhPJxOFEpqR+ubgyyndRo9RsvV6JNskrX1ZN0pSB9QYUgDPAXxWVBf3KckcCYKJERTN+u5J1wzBA==
X-Received: by 2002:a05:6402:c06:: with SMTP id co6mr64532748edb.142.1594163032539;
        Tue, 07 Jul 2020 16:03:52 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id f10sm27096310edx.5.2020.07.07.16.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:03:52 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/13] PCI: pciehp: Check return value of pcie_capability_read_*()
Date:   Wed,  8 Jul 2020 00:03:19 +0200
Message-Id: <20200707220324.8425-9-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200707220324.8425-1-refactormyself@gmail.com>
References: <20200707220324.8425-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0. 
However, with Patch 13/13, it is possible that val is set to ~0 on
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

