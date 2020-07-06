Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140D7215596
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgGFKb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 06:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgGFKbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 06:31:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E4EC061794;
        Mon,  6 Jul 2020 03:31:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so32169051wrs.0;
        Mon, 06 Jul 2020 03:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zIc+ryXbVspn9u+GSLsSwM5Cff3RjamOLjlQZyxFr+U=;
        b=cg2exXge4dbjo5XG0pFDqzL4EhbxVye2Y2SrCQv/P2Dg2tU+/5QN+wUT5XfILrK669
         StfO6eeTUTyg3zJq2I3CJ+rZAEjFi03MOLGodp2ZjGdKraqFoyDCCQLbp+stXcS0rSGk
         EeJxe8rvAE8Tbp6sce9+rVFKzDBtgvB3d6wCyI5HatgTE2+x3QE6ooHDcRIP0cPGFQp7
         z1A+03J1XT8xTyK3YOYa4o61qT3mqZBb5lSTgp0LNkck2wLm8qRcpiFspO81+BGlBc4Z
         yus+TgOMZRecaarzNx1To3/r7LBqROPWCwgsUF0Y4B8XTureThhh1unrmpXQuys2tGqC
         ihZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zIc+ryXbVspn9u+GSLsSwM5Cff3RjamOLjlQZyxFr+U=;
        b=fDYAUgQ6ARu476ErYISfWRE9bO5Ctz1A7qS9/2wDUmgJrSCW6T+qsDzjrbVd1hQcwj
         g1bUFUX8EXnK3FDb1VE3iupTGrD2VKI9tm6Vc3fT80aTZfRaMGr5zJx0Tgb5g7xKKJui
         El4OO7TU3w1Cuen37zosDyLLRqM/VyUu4R/g9yLy8npTKpIC5EoNESq6F6ueCjIj/Aco
         ky+UQ5DCUHoaQhfvHRaIaR2TUXTB0fSmnAE7k9aw1e1tk75SZQYrWgXje+CMgMkoetrG
         Dmk67fmyFjnLwuY2E8DCHf/3TpzU+7Cab8d74+27WlAJ/8n0bZMQuPCI3tU58+oQcND1
         HZRg==
X-Gm-Message-State: AOAM531UeooH/NVi1BJ5WMtaiW7uN8XfreXJ0xqsrfmZ+t/MHXSG2m9v
        A2j0wReKdOeZw5oCnZo8bY+sbt1eGybM4Q==
X-Google-Smtp-Source: ABdhPJxCtqWPmnt50I/FTSU/wExRSzDqqvPU1j31/xL1NsH+jBfN84hjLCyjVT7+LEc9gP3gIrxkeA==
X-Received: by 2002:adf:91e1:: with SMTP id 88mr41365811wri.89.1594031513765;
        Mon, 06 Jul 2020 03:31:53 -0700 (PDT)
Received: from net.saheed (51B7C2DF.dsl.pool.telekom.hu. [81.183.194.223])
        by smtp.gmail.com with ESMTPSA id 22sm24216859wmb.11.2020.07.06.03.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:31:53 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, Lukas Wunner <lukas@wunner.de>,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/11 RFC] PCI: pciehp: Validate with the return value of pcie_capability_read_*()
Date:   Mon,  6 Jul 2020 11:31:13 +0200
Message-Id: <20200706093121.9731-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200706093121.9731-1-refactormyself@gmail.com>
References: <20200706093121.9731-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On any failure pcie_capability_read_word() sets it's last parameter, *val
to 0. If pci_config_read_word() fails the *val is reset to 0. Any function
which check only for a frabricated ~0 which fail in this case.

Include a check on the return value of pcie_capability_read_dword() to
confirm success or failure.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

---
 drivers/pci/hotplug/pciehp_hpc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..5af281d97d4f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -86,10 +86,11 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
+	int ret;
 
 	do {
-		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-		if (slot_status == (u16) ~0) {
+		ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		if (ret || (slot_status == (u16) ~0)) {
 			ctrl_info(ctrl, "%s: no response from device\n",
 				  __func__);
 			return 0;
@@ -156,6 +157,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl_orig, slot_ctrl;
+	int ret;
 
 	mutex_lock(&ctrl->ctrl_lock);
 
@@ -164,8 +166,8 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	 */
 	pcie_wait_cmd(ctrl);
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	if (slot_ctrl == (u16) ~0) {
+	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	if (ret || (slot_ctrl == (u16) ~0)) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		goto out;
 	}
@@ -430,7 +432,7 @@ void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
  * removed immediately after the check so the caller may need to take
  * this into account.
  *
- * It the hotplug controller itself is not available anymore returns
+ * If the hotplug controller itself is not available anymore returns
  * %-ENODEV.
  */
 int pciehp_card_present(struct controller *ctrl)
@@ -591,8 +593,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	}
 
 read_status:
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
-	if (status == (u16) ~0) {
+	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
+	if (ret || (status == (u16) ~0)) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		if (parent)
 			pm_runtime_put(parent);
-- 
2.18.2

