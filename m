Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332CF21BFA6
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 00:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgGJWUU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgGJWUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 18:20:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2DDC08C5DC;
        Fri, 10 Jul 2020 15:20:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so7333253wmh.2;
        Fri, 10 Jul 2020 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zBfQN+vRaGSFliSIC9sUYYBlJBWdf+Mc3nVjYABa6uc=;
        b=vBecEFbh/d0jSef2GGDkawA1rYeo7al4di1WqcRGBfvnRrTP2sQxtQ0PJwcAgiO5qe
         MGsc06bJHFGxcuKxJEQnwXXsbhVhwXOIFkM7N/BdSw7KytVkbUqwRgCgR0jvV4AXKVCM
         mNRjwHqEUbOHu7JVc+2DOTngEfZFUvsXnoFl99OezVwXeJ+rXwhReatDgo1Ck2JO/kxY
         UZ11NYvdsJyVUZJKJSsdFaD8sfkVHxddqoSvWwfDuAQZt6rXeBv1fUkNJRmaR3d9rvUQ
         1wa5IR6Xo1ZY7GKo7UgBdWpgkGe3f+hZpgf596QE3g6SXnBHKtk8tP0bakSwc4saynAE
         fqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zBfQN+vRaGSFliSIC9sUYYBlJBWdf+Mc3nVjYABa6uc=;
        b=RCAB86vdOv/lJ+qq7BPvtI8I7JSdMKXabcuog0MgKtqLWDv0zIyW7aKLHUKdHe5Fc1
         mT8bVfelxZDm3fEzdZl9Krkus1SeZAjH/lGXSAaaKocn25Ct5yVwQh6m2uORxPdA4dH0
         6syb8pN5MDBzjtkhysRfOb5LV6Tne6nT+zn1dUbhaJAqSWJzIUw94OGbPdCaTh1nA4jz
         u3nKr3UayS3ZJc7CElaAqGU/hxwZPkQ/y8kbeCn+uBEqPFV+hVGHG54Xe0pWKlHfXzJx
         tjq7n7du0St4OVfV15uKqjnHdNlfi0EiVKI6liUnuzq0tR+cbyAZaabifDOLJKBIQxk6
         S9Og==
X-Gm-Message-State: AOAM530kIlzH+7q8FtL5sWrWPwbZlNas8jH27yonhjJgaky6F9+sq0OA
        4c2FR28AyxqjuGErIQF/Pj0=
X-Google-Smtp-Source: ABdhPJyfeh9pQCHsK+AR0ZiTfubZZSMON0PFLNp3rQLm4JcDpLNUMt2j2BpVH5xqfzX/lX304gQmIg==
X-Received: by 2002:a1c:4086:: with SMTP id n128mr7445658wma.118.1594419616792;
        Fri, 10 Jul 2020 15:20:16 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id l18sm12170281wrm.52.2020.07.10.15.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:20:16 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/14 v3] PCI: pciehp: Check the return value of pcie_capability_read_*()
Date:   Fri, 10 Jul 2020 23:20:19 +0200
Message-Id: <20200710212026.27136-8-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200710212026.27136-1-refactormyself@gmail.com>
References: <20200710212026.27136-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

If pcie_capability_read_word() fail, slot_ctrl will be 0 and the switch
expression evaluates to 0. So *status = 1 "ON". However, with Patch 14/14
it is possible that slot_ctrl is set to ~0 on failure. This would 
introduce a bug because (x & x) == (~0 & x), so the switch expression
evaluates to PCI_EXP_SLTCTL_PCC. This means that on failure *status = 1
"OFF", since PCI_EXP_SLTCTL_PCC = PCI_EXP_SLTCTL_PWR_OFF.

Use an if-statement and include a check on the return value of
pcie_capability_read_word() to confirm success or failure.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

---
 drivers/pci/hotplug/pciehp_hpc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b89c9ee4a3b5..f5ef3fbace69 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -394,20 +394,16 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
+	int ret;
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	*status = 1;	/* On */
+	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
-	switch (slot_ctrl & PCI_EXP_SLTCTL_PCC) {
-	case PCI_EXP_SLTCTL_PWR_OFF:
+	if (!ret &&
+		((slot_ctrl & PCI_EXP_SLTCTL_PCC) == PCI_EXP_SLTCTL_PWR_OFF))
 		*status = 0;	/* Off */
-		break;
-	case PCI_EXP_SLTCTL_PWR_ON:
-	default:
-		*status = 1;	/* On */
-		break;
-	}
 }
 
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
-- 
2.18.2

