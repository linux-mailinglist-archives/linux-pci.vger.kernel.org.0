Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE121BFA0
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 00:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgGJWUQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 18:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgGJWUQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 18:20:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEE5C08C5DC;
        Fri, 10 Jul 2020 15:20:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so7350274wrv.9;
        Fri, 10 Jul 2020 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4W35ujYJlxKgHmJjOxh/l83E+9wVDyy9zXN8EsZkeBk=;
        b=s5cw7rCE0EWbF55kNa6MNaVUq9gxiw+DyerLx6J8txZcNXN19MIjAyBDqnoBlEoP1h
         OV4Jf4zPg4eoXxh6lRNIg//4gI/0L4lpCXVaKg5TBN6L/9m+NiW8BwXmYlbEzuabJ0te
         jLOZiyK1vLPR9AiJmAiEZeCWWxf8niZ1CEI90IICoBeecmKquzqhTb1PltP2NHM98Sob
         iIIlbZMhMCt3Ylsgi/MEpQujQAYKFP49Dk7kQkX//ko9E6xQs24vUmNBF397HgFDKadZ
         g9eVCpQO3O6FhhbMsdJrFi1Ufvy7Mfr1Xbev5QW4v2Y1ZBAWUEP5gqmyE9qse3fqBdfQ
         zCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4W35ujYJlxKgHmJjOxh/l83E+9wVDyy9zXN8EsZkeBk=;
        b=TxOfyD0zDrt/dMQyrKkj2McBX9/9m+VOBtxNOdk24fiZc2A8dMt8oNdNQIMr3rg/A4
         Nk5oP1HNkPoPqGuhtOlyykW77voK170kDa/fBexSVOC0DWP0BzX95QZ+EpJ8DTyMDPDD
         av3RNuydhWti1KJwnIuUh5dhTCjbo6dc/XUNJE1zoFobvVhHj4P0G5QeULr3TpiYPsYK
         XyrBM47dZhYGhhVG8cRWph84UnllZFKsprQytJ+3W3Q1ohvjftKQPp+j3lzTEfojw4uL
         PnAytchskRKvJ3TMn8pzcELktOm7VBUFDI7dVDuMsWVt/I4up3zNwOF0hj2bhrVFaTCY
         TvmQ==
X-Gm-Message-State: AOAM5332iffJetQlB0hlJvORA8nWP1p2YWt/vgmZZ34PzNqFTbmae14a
        UR/Pbkaj8VAObFV417H8kuk=
X-Google-Smtp-Source: ABdhPJzPwatony6Cjt8uiw1I+bb2q4igHjoQj2S+/ZwwO9vnHpqlg5m64LJZADjKjjMfX4mcscdugQ==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr69427633wrs.393.1594419614348;
        Fri, 10 Jul 2020 15:20:14 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id l18sm12170281wrm.52.2020.07.10.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:20:13 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, Lukas Wunner <lukas@wunner.de>,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/14 v3] PCI: pciehp: Check the return value of pcie_capability_read_*()
Date:   Fri, 10 Jul 2020 23:20:17 +0200
Message-Id: <20200710212026.27136-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200710212026.27136-1-refactormyself@gmail.com>
References: <20200710212026.27136-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On any failure pcie_capability_read_word() sets it's last parameter,
*val to 0, this value may have be earlier set by pci_config_read_word()
to ~0. So, any function which check only for a frabricated ~0 will fail
in this case.

Checking for the return value of pcie_capability_read_dword() will help
assert failure or success of this function. But more checks may be needed
to assure the validity of the value.

Include a check on the return value of pcie_capability_read_word() to
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

