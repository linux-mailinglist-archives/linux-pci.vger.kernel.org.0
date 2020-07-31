Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E850C234606
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 14:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbgGaMnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733281AbgGaMnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2020 08:43:14 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD4EC061574;
        Fri, 31 Jul 2020 05:43:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id kq25so18332432ejb.3;
        Fri, 31 Jul 2020 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W3jrzpfEeWtPMNu6ebBkWvuMrQ1sgOT+1rw4Pu7mEnM=;
        b=ld0t00pEM0MZcb/2HS5Hxc5/1Alb6cpV0465TUImsXBfXqlUiXv3qgnP5THp7GdyWt
         8PN897B99gz/5u30giINZNvDMT6/mWuvIXe+TcNMuLxTvnH9PCytRwpSraftTJMgQpWe
         spoy/g9Lh0dsyUDMi87W9NTpVJ2/JlZ3B2T3++DAouHdqUuMr4fStgrbobkymQoX5/nx
         LG/NUMGNDA29W4D704MLbhgeamT2vFggAA15Dd8orS57Vd6d1CNKgfLP7fpy87FzJkLH
         UPK/9ubqDzWSkKxoO8jdts69q2aW31ePssin6RT9S8aPsvQphdqn8XgF5w3oA6zSoxmE
         Dw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W3jrzpfEeWtPMNu6ebBkWvuMrQ1sgOT+1rw4Pu7mEnM=;
        b=UjJdcjDUKeH2U/VGuQ92H9MlzmpTciwNYvS81MamMaxEVXXF+zcZ+FAPBqdQ1lZXRW
         DYVRIgvGJIT25G4GnvCI3Z6HobcRakFqTIId36WHbfKOwpdOllaDGsIvUMDBaEGTTTqU
         J+bbk4ZycEtJ6SV5tYhLGc+GS2MXbcciRr0xdlvCqWqpt0jgQXRcapeXqjjLUZkfLXI3
         EaV8CtygCkBzB1E1zTbvdkylnmw85gkWqefza0VIJ39o3LKQY1QUAe72T3CJB9zLZZK7
         i9kVHP/UVU3cbW0bFFYhWbKDC0IaLZ22eKfa/X6MZgQjqRugmqL1pX3205LKmLZaBa/m
         W+cA==
X-Gm-Message-State: AOAM531R7adiB8z2rn2pXQ2jm/sJr+H54x3es+HLwp3jQRdQ4a3GYu/2
        9WBtKCWu3fbqnQHr0L4MFI1CvACss45Ytw==
X-Google-Smtp-Source: ABdhPJyJ0iZIhz348o3l6wmkHxHvqln6F0gnPCiag58gIVbti5JjZMxnOWyTHRJJZGkCk1hWy3BckA==
X-Received: by 2002:a17:906:1f53:: with SMTP id d19mr3799144ejk.327.1596199392870;
        Fri, 31 Jul 2020 05:43:12 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id g23sm8668514ejb.24.2020.07.31.05.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:43:12 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/12] PCI/ASPM: Check if pcie_capability_read_*() reads ~0
Date:   Fri, 31 Jul 2020 13:43:28 +0200
Message-Id: <20200731114329.100848-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731114329.100848-1-refactormyself@gmail.com>
References: <20200731114329.100848-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On failure pcie_capability_read_*() sets it's last parameter, val
to 0. However, with Patch 12/12, it is possible that val is set
to ~0 on failure. This would introduce a bug because
(x & x) == (~0 & x).

Since ~0 is an invalid value in here,

Add extra check for ~0 to the if condition to confirm failure.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ffd31b1..5e84a5ee94b0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -223,7 +223,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
 	do {
 		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+		if ((reg16 == (u16)~0) || !(reg16 & PCI_EXP_LNKSTA_LT))
 			break;
 		msleep(1);
 	} while (time_before(jiffies, end_jiffies));
@@ -250,23 +250,23 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 
 	/* Check downstream component if bit Slot Clock Configuration is 1 */
 	pcie_capability_read_word(child, PCI_EXP_LNKSTA, &reg16);
-	if (!(reg16 & PCI_EXP_LNKSTA_SLC))
+	if ((reg16 == (u16)~0) || !(reg16 & PCI_EXP_LNKSTA_SLC))
 		same_clock = 0;
 
 	/* Check upstream component if bit Slot Clock Configuration is 1 */
 	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-	if (!(reg16 & PCI_EXP_LNKSTA_SLC))
+	if ((reg16 == (u16)~0) || !(reg16 & PCI_EXP_LNKSTA_SLC))
 		same_clock = 0;
 
 	/* Port might be already in common clock mode */
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
-	if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
+	if ((reg16 != (u16)~0) && same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
 		bool consistent = true;
 
 		list_for_each_entry(child, &linkbus->devices, bus_list) {
 			pcie_capability_read_word(child, PCI_EXP_LNKCTL,
 						  &reg16);
-			if (!(reg16 & PCI_EXP_LNKCTL_CCC)) {
+			if ((reg16 == (u16)~0) || !(reg16 & PCI_EXP_LNKCTL_CCC)) {
 				consistent = false;
 				break;
 			}
-- 
2.18.4

