Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010FF217B81
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 01:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgGGXDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 19:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGGXDu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 19:03:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63A3C061755;
        Tue,  7 Jul 2020 16:03:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so44013275eje.7;
        Tue, 07 Jul 2020 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x34hXCcOq59WMJYswPIxPqVvlEOUWxWGz29l8+4Mdjw=;
        b=d1wMkPbjCRoYy7TJn/HYtJHqbPRdbaCl9YnetgtC3UW52u/JOaVgwix9/i2yGw77LC
         r50eNX0fUNjMOiVj+XEKZMjAaQp+qT93i5Db/X5tSN7V1YnKbTgnV2wn2afqodBgRClN
         CBbGjwiNWrGSsfBhxIWybQZvDfdzbRisgvH4XWGSI5qPpF2UU9iH20AzzjEWhFColZEO
         87QIjpQz2rzfXjNXlX1ZIL6fqUReVqNcuJtUFIwXMRceNd509uB0tszSaSNrgDwHOYa5
         BIi4wMmyG0MAMbl1p5Ue8tXRTmMN4Lgik+gsr0QN1FIBXhMjv+h/pZR7CnXO00h1GbG0
         KV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x34hXCcOq59WMJYswPIxPqVvlEOUWxWGz29l8+4Mdjw=;
        b=S9ON8//aXuRJ8kO6ZkOtsUx1Y4mE16L1mau/gJn+vlcZkEy12sJtMv7M+6/GcaGLmK
         OkdfCvC2WyIqs5Lt31/ne70nL0GVNsLgxc+9VbBdKJ+6gyf8WqVehhcrcNOai4AxmZyC
         P7nuegzWljYLPXERtAbcaV0qN+FAV2wp2kvlAyW4kv7NXLB7Jyeo84yr9hkWOewKXEE+
         Dij/6QcWNwTm1GwziXEaxQbUtKY8f6gMEzzx501vTQRZjKf2NcopzNI2nVCtm4xz8ClY
         V2aMSfZ1RWnq/oCgLuzv6NZlA1wF5LYqMiJr5Pf4EnkCDAE9lZYMszee1iF47xC8BHbH
         gHWw==
X-Gm-Message-State: AOAM5305KnkNL6dNo8mAeYAfmMH1iJL5g5JGSN7lkNYhUbo1Fx4olRxW
        4JRQl1ClLAF6MlemRaIT+AA=
X-Google-Smtp-Source: ABdhPJwMi5t8+SwOH4qQAhVQzCugy87cSLNBZoVzPV8TP8kjpAMnP7DLxA+3/V4kzTpmayrI9WZM0w==
X-Received: by 2002:a17:906:95d9:: with SMTP id n25mr50823340ejy.437.1594163028584;
        Tue, 07 Jul 2020 16:03:48 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id f10sm27096310edx.5.2020.07.07.16.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:03:48 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, Lukas Wunner <lukas@wunner.de>,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/13] PCI: pciehp: Check the return value of pcie_capability_read_*()
Date:   Wed,  8 Jul 2020 00:03:16 +0200
Message-Id: <20200707220324.8425-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200707220324.8425-1-refactormyself@gmail.com>
References: <20200707220324.8425-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On any failure pcie_capability_read_word() sets it's last parameter, *val
to 0. If pci_config_read_word() fails the *val is reset to 0. Any function
which check only for a frabricated ~0 which fail in this case.

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

