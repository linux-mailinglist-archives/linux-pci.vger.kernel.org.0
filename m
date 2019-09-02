Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC9A5A95
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfIBPa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 11:30:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43399 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfIBPa3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 11:30:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so9150766pfn.10;
        Mon, 02 Sep 2019 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7fRcUp1tbqTpziT5RMv5XSX+Ysbr7LLSA811sn9L4Ks=;
        b=iBa75ROkxwAhIZ+6ZVDuKDz2CV6Jg4Jlk5QW+/JXAnpzhMBeqcqFGlZ1m48Vnw+POu
         djStDAENEXC0I2ipEtIfHxSdBPf1zhjL3ykjd3KhMvb6CczSAIqpi9NSeCMSuhvwbr/1
         hCEFiJv72JMOPw7Oy2v6k38q+3lOAMlHrttuzF83P5TSIaixSggAn0Um0B7HmgUgFLQl
         Toc1kEkCpDpQciMnK0lDRdhYsKxMkJXzM2cF7oNy3JCZ34DOEX8s/Z1iutBMXgSxfZvW
         tU4YirB96796j2CHeAuvEujEq9qBzHEiSQSVnEISifUX7FafELxjsQufaH7VdCYGd2bO
         A0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7fRcUp1tbqTpziT5RMv5XSX+Ysbr7LLSA811sn9L4Ks=;
        b=ppp6ikJGeg7nEuRkWfMcZYCwFZ5b2NOWw/w9GWRMPfWJOHXVs6CV3r1AFSsENeRDLB
         peqjYAxLT9w2XZ7pEuX+ELmfXLY71R8WkliOf5W7TbZ3OdrTpWVl9OvkB11jh2Gzz70R
         3BQPqCjFLpswqeOj0N/HXZSq7H7Al7UD3TpbLHXRtMjR11/XOQSeKBPV3y9/exU3Oaj5
         7zzZY16pECrAkb2uypLJbz6wzL+RUAUwVp2J1Xu9f1iGRAgVKoid7EVb+usbZOJ884Ko
         Lus8xN1+0C6E30iErApH4rcQvVTOnOSrxh3UNR1iWJAXgwKK5ke/zpU5B6U9qy1D3tGZ
         RQLg==
X-Gm-Message-State: APjAAAXvzgvJs/3H5vozE+nmjJC1qcJVix9Mco6yVmrof0FQUpxaW3BB
        tiqiZnIJoIdMobuV/AtK/QwahRNq
X-Google-Smtp-Source: APXvYqy7Giggf6pgZFvOqn0lpoOUoUBkW/82V7Q/4G3iRI75IXIlcvyqGB+wbn2iwza7DTcHB1nUTQ==
X-Received: by 2002:a63:2026:: with SMTP id g38mr25237832pgg.172.1567438228801;
        Mon, 02 Sep 2019 08:30:28 -0700 (PDT)
Received: from hyd1358.marvell.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id i6sm10249114pfq.20.2019.09.02.08.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Sep 2019 08:30:28 -0700 (PDT)
From:   sundeep.lkml@gmail.com
To:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.stalley@intel.com,
        bhelgaas@google.com
Cc:     sgoutham@marvell.com, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH] PCI: Do not use bus number zero from EA capability
Date:   Mon,  2 Sep 2019 21:00:03 +0530
Message-Id: <1567438203-8405-1-git-send-email-sundeep.lkml@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Subbaraya Sundeep <sbhatta@marvell.com>

As per the spec, "Enhanced Allocation (EA) for Memory
and I/O Resources" ECN, approved 23 October 2014,
sec 6.9.1.2, fixed bus numbers of a bridge can be zero
when no function that uses EA is located behind it.
Hence assign bus numbers sequentially when fixed bus
numbers are zero.

Fixes: 2dbce590117981196fe355efc0569bc6f949ae9b

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/pci/probe.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a3c7338..c06ca4c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1095,27 +1095,28 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
  * @sub: updated with subordinate bus number from EA
  *
  * If @dev is a bridge with EA capability, update @sec and @sub with
- * fixed bus numbers from the capability and return true.  Otherwise,
- * return false.
+ * fixed bus numbers from the capability. Otherwise @sec and @sub
+ * will be zeroed.
  */
-static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
+static void pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 {
 	int ea, offset;
 	u32 dw;
 
+	*sec = *sub = 0;
+
 	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
-		return false;
+		return;
 
 	/* find PCI EA capability in list */
 	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
 	if (!ea)
-		return false;
+		return;
 
 	offset = ea + PCI_EA_FIRST_ENT;
 	pci_read_config_dword(dev, offset, &dw);
 	*sec =  dw & PCI_EA_SEC_BUS_MASK;
 	*sub = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
-	return true;
 }
 
 /*
@@ -1151,7 +1152,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	u16 bctl;
 	u8 primary, secondary, subordinate;
 	int broken = 0;
-	bool fixed_buses;
 	u8 fixed_sec, fixed_sub;
 	int next_busnr;
 
@@ -1254,11 +1254,12 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
 		/* Read bus numbers from EA Capability (if present) */
-		fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
-		if (fixed_buses)
+		pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
+
+		next_busnr = max + 1;
+		/* Use secondary bus number in EA */
+		if (fixed_sec)
 			next_busnr = fixed_sec;
-		else
-			next_busnr = max + 1;
 
 		/*
 		 * Prevent assigning a bus number that already exists.
@@ -1336,7 +1337,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * If fixed subordinate bus number exists from EA
 		 * capability then use it.
 		 */
-		if (fixed_buses)
+		if (fixed_sub)
 			max = fixed_sub;
 		pci_bus_update_busn_res_end(child, max);
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
-- 
2.7.4

