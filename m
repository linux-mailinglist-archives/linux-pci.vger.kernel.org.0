Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E6B21BFA5
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 00:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGJWUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgGJWUR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 18:20:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2CC08C5DC;
        Fri, 10 Jul 2020 15:20:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so7340756wrw.5;
        Fri, 10 Jul 2020 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tdpe9RfhxuAkiRZlM5Mq/vRi1xQi0fp5aVSqheR5YGw=;
        b=px4x+Ir1Hmqt/RIHHKLA49y3QyLmG2TCU6SADKNZHStWzUpoQU6bVSjIaM7sHXrbgl
         qDzy2e4Z17ZzItXeZdT6HSFTlJXeU1FU2vH0nff6XJf2oFctdr4zH2hKnf/H70zLMUYZ
         fhe+ON8/guj9R7yGx2KvlNibtktRd8YwMjGUSGQ338kNk/6u74wgHiUKVy8qnjMEfocr
         15BUijBnxgqYv3Pch8DeXLnNIjTg8UPTC3SJDcT4FEzNLda4h8vp56xsdcsXwN7HXwgN
         AQBeFjjDfNXxoGE9/Fvro5okM26H+66moYBDNdTkANlv2C+LDDp1Lys2SmmGP63eYfH6
         wJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tdpe9RfhxuAkiRZlM5Mq/vRi1xQi0fp5aVSqheR5YGw=;
        b=jXxDRThxnQ83IGrQYVVfdjx+4LQppN5czuwSub2IkeD06Eg9IJdT0JnENLvWxcHM/I
         roAbydizd4AX2lzHQiYFVDh/jfEVYKf+Eh/F1IlR0HGpv6y+pHEb/WjuuajhpZmCRmxQ
         IaelZN75+JlOiVAvOecQij1xQi6FDPEBaIhSwQUHOIjqBwfG2FQmC3ssABKya3vkQPNJ
         wnhUDMEcoqf/AsZSelwnpZuBQQck8U+THe+n5JOfRn/Up1RNVEeRyJMZOs6B/h6ppwo3
         RJXfdKKgZQFLEKEayHT8hh+hQBGe6caMLAYsrmwkBEDJNK+ieMXNYj9O55LJdDowq4cA
         L1qg==
X-Gm-Message-State: AOAM531PHBfDZvC4DMT3CzTe7ElNN8Bv8KkRdQ/O4AgApN/2FUe1O2LQ
        6IqcEH/GmTFqtGSeFENPF0g=
X-Google-Smtp-Source: ABdhPJwTRSLucrdEPJQmfs0y7Ck7+PkTy56iEk1AKAT5c0w1w8yRotpSUquRw9umBX/oIIntquItLA==
X-Received: by 2002:adf:8b18:: with SMTP id n24mr73874175wra.372.1594419615686;
        Fri, 10 Jul 2020 15:20:15 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id l18sm12170281wrm.52.2020.07.10.15.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:20:15 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/14 v3] PCI: pciehp: Make "Power On" the default 
Date:   Fri, 10 Jul 2020 23:20:18 +0200
Message-Id: <20200710212026.27136-7-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200710212026.27136-1-refactormyself@gmail.com>
References: <20200710212026.27136-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

The default case of the switch statement is redundant since 
PCI_EXP_SLTCTL_PCC is only a single bit. pcie_capability_read_word()
currently causes "On" value to be set if it fails.

Make the switch-statement set status to "Power On" by default or when
(slot_ctrl & PCI_EXP_SLTCTL_PCC) == PCI_EXP_SLTCTL_PWR_ON. 

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

