Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8034B215597
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgGFKb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 06:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgGFKb5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 06:31:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43176C061794;
        Mon,  6 Jul 2020 03:31:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so38663139wmj.2;
        Mon, 06 Jul 2020 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gLOVpKwfnzdqPjeF9FisBhEgOhhTDNWgNNsho9uiBK8=;
        b=PNS1AOdhKTtQLZQyI5JQWqsfSKn6StXnzQ9fS+uIkFKt/eYOI3XsDToqjFRZ8Uquu0
         5aEvnYw7rdO3qku9pKGyrBh4S8b8PdsY48PxlH1g2BODDaHYIdbqj+ZQYHbgRbV9Xfr7
         dVqET9v2e1LhxYB9b6sUSd2yvSB4NGKussrpxDxU84gw5SCZT3xIljO6U7jpLF+C+oZ6
         uQmGF7YTWB7i7ulAKINHdEhfOMstQHpk0/8mjw3IRY9/EiJ/nvuekRLXAL4BFgaxRBEH
         MqLuCoFx4859jBxZP4AqdeBycYg5TURUtuTIkGoiPh1jPxJCIlUdU1gR1+DsQYrhttpK
         Gr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gLOVpKwfnzdqPjeF9FisBhEgOhhTDNWgNNsho9uiBK8=;
        b=GyYz5RlT3lZtE96tpmw0WXsj3+q6ETxGpMzCdG5MR3c/pdPrnsBBn5YkcA01SYzBne
         0OXzTs1kx/oxzPuRuWD3vjKs2y1R09Pgy8jBVT/kkxwXCowPKcrDsfJf9F185AOpfjaa
         8eb+FcgXhyxmhvkB78+Fzv0+Xtuh0dk+O+vntJBVn24RdkTxWyPmOJs/yf62WY1+UGwF
         6VzjxdkQUrhzUj94lEUOmNY+ZbgNWgNu5phbEAP8Kxa2eNW6StO2JzHy6o4PCBB+1rDE
         InMBshcBIsUNhrLrQLy2/ESzC6JHb0NPlWh0G6qEDTmAQeEE0XxTapC20tRIcpV6JrBI
         RaCA==
X-Gm-Message-State: AOAM531ze1Kjh6JzjI8uBLl/F9upLNOMl77FLtchzh/wha5CDs1UnCV4
        6QbvTljeQQpKaMcID4nBz1Q=
X-Google-Smtp-Source: ABdhPJxwFsuaA1UtVrdWVLhkh7v8Bjopk63guA9Az8X8ssMRTKHtPQSA15Wy/yavGlrGm3dAMS6F+Q==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr19176296wmc.109.1594031515995;
        Mon, 06 Jul 2020 03:31:55 -0700 (PDT)
Received: from net.saheed (51B7C2DF.dsl.pool.telekom.hu. [81.183.194.223])
        by smtp.gmail.com with ESMTPSA id 22sm24216859wmb.11.2020.07.06.03.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:31:55 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/11 RFC] PCI: pciehp: Make "Power On" the default 
Date:   Mon,  6 Jul 2020 11:31:15 +0200
Message-Id: <20200706093121.9731-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200706093121.9731-1-refactormyself@gmail.com>
References: <20200706093121.9731-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

The default case of the switch statement is redundant since 
PCI_EXP_SLTCTL_PCC is only a single bit. pcie_capability_read_word()
currently causes "On" value to be set if it fails. Patch 11/11
changes the behaviour of pcie_capability_read_word() so on falure the
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

