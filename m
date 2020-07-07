Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8074217B83
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 01:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGGXDw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 19:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgGGXDv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 19:03:51 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EA2C061755;
        Tue,  7 Jul 2020 16:03:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n26so34521040ejx.0;
        Tue, 07 Jul 2020 16:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e4G/JDoHnmGcmiWO+UuUF925AfFaFCnVB7/GokdCrOY=;
        b=AJbEd0XqvMDu+0bE7N9RmjLOcr0Og7QcFpFp4MUIslagtlDEHgID+7gQjqwiscgzGQ
         UOj49BA0anS6lCCRP7qIzyM9iwXu8Ac9jhUfgW/dbBjH0Rbz5e+v6YH/9yQXtziXRf9q
         z7liwPyqRfbSD+mWIn/SYWtVuuaFsHEvS9Sf5qDAShA7HkRn5/K2KIJBTgCJsMAsJegm
         EZREP6gbXfPoOX9sJWg6yNUdouum4rh63F2S0UCJ0ySG+hx46sNNRjGknMq175wp3iZ2
         7wJtSXlKWXzI0ZWnre9ZTLoPWpaQAa/d1lfnMKkyVSPhhpnLZqLKoXH0hmk1V3ZQ3dT9
         HFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e4G/JDoHnmGcmiWO+UuUF925AfFaFCnVB7/GokdCrOY=;
        b=tqzQe1db8XS0TB/Y4CSv6CRJ5p52OiKUTtzjGukSgpZhY2ABMznMWdMVqstsZr7TPu
         ++y+esuH2U2pefWMuiAsCbq6ulpJBr8Y4hf36MLCSltkJXqWD8DD/ZqUjJQicUx2KTL5
         L8+06n9Z0nTXCKNBSOjB8WRLttGg58ZQZtCqMU1Ks+xCZ0TY+vv78VhQ2wYHt/wG3fTl
         GsE24H2WB7d07PnwgE5vnENC8kfabf6NaIncJybvot67yRYU/FIp4n+1CxyFgc13NqsL
         srO25HzzpW7jfu/hTNFDPIbccM8LZ7BjTJpcXJi1Wgrv4dgxeOnzd9+S+N212sXhK8DR
         J/oQ==
X-Gm-Message-State: AOAM531czt0Yo7tTq42jlQOP+3o6xbazar/a0Le1wGVkyyckWn/mro8C
        tw4zHQUVJ2VmYAlp5yKnuqc=
X-Google-Smtp-Source: ABdhPJziO2EooRxmhGRlmXsIplf+xLYmAnXBQg/xCPfOuDZzI1DJIjQoP8x71+sdMX2I61jJCh4nLQ==
X-Received: by 2002:a17:906:4942:: with SMTP id f2mr51414548ejt.125.1594163030039;
        Tue, 07 Jul 2020 16:03:50 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id f10sm27096310edx.5.2020.07.07.16.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:03:49 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/13] PCI: pciehp: Make "Power On" the default 
Date:   Wed,  8 Jul 2020 00:03:17 +0200
Message-Id: <20200707220324.8425-7-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200707220324.8425-1-refactormyself@gmail.com>
References: <20200707220324.8425-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

The default case of the switch statement is redundant since 
PCI_EXP_SLTCTL_PCC is only a single bit. pcie_capability_read_word()
currently causes "On" value to be set if it fails. Patch 13/13
changes the behaviour of pcie_capability_read_word() so on failure the
"Off" value will be set.

Make the function set status to "Power On" by default and only set to
Set "Power Off" only if pcie_capability_read_word() is successful and
(slot_ctrl & PCI_EXP_SLTCTL_PCC) == PCI_EXP_SLTCTL_PWR_OFF. 

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 0b691e37fd04..78f806a9c6f1 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -399,22 +399,16 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status)
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
-	case PCI_EXP_SLTCTL_PWR_ON:
-		*status = 1;	/* On */
-		break;
-	case PCI_EXP_SLTCTL_PWR_OFF:
+	if (!ret &&
+	    ((slot_ctrl & PCI_EXP_SLTCTL_PCC) == PCI_EXP_SLTCTL_PWR_OFF))
 		*status = 0;	/* Off */
-		break;
-	default:
-		*status = 0xFF;
-		break;
-	}
 }
 
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
-- 
2.18.2

