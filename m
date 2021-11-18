Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E954555AE
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 08:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbhKRHes (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 02:34:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46414 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243872AbhKRHeb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 02:34:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 43B0F218D5;
        Thu, 18 Nov 2021 07:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ceeUZsEANBE1OI2itMTxNUsgiAvwJdrWPdj7FRW59Qk=;
        b=YT7/5r0k5iNHAmyfkPyTEgW+QQYulHtCHUy8U9RMNqST9X7rWMEIdpH6jnr5vQCLPbI0FP
        dpIIQZEJXyUJ4/9M5LIfapaXDuebxno6BJBHJ1cUielJJv+mbd5ETzJi/nToI9JJ3cSKpV
        IAtEa4Cd/JwDaNuoftg8FdM/1pfBzCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ceeUZsEANBE1OI2itMTxNUsgiAvwJdrWPdj7FRW59Qk=;
        b=26YSBxG0ieL1E3D24jSfXaTZUDYoJ6uBd6hKTUUZ9Agt+4CxjI1E6T+varVjePjnAzG6hr
        q675MvvlCmohdVDw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 10CFCA3B83;
        Thu, 18 Nov 2021 07:31:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 18/19] mxser: move ids from pci_ids.h here
Date:   Thu, 18 Nov 2021 08:31:24 +0100
Message-Id: <20211118073125.12283-19-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no point having MOXA PCI device IDs in include/linux/pci_ids.h.
Move them to the driver and sort them all by the ID.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/tty/mxser.c     | 20 +++++++++++++++++++-
 include/linux/pci_ids.h | 18 ------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index f6842089459a..ba96ffed193a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -159,14 +159,32 @@
 #define MXSER_BAUD_BASE		921600
 #define MXSER_CUSTOM_DIVISOR	(MXSER_BAUD_BASE * 16)
 
+#define PCI_DEVICE_ID_MOXA_RC7000	0x0001
+#define PCI_DEVICE_ID_MOXA_CP102	0x1020
+#define PCI_DEVICE_ID_MOXA_CP102UL	0x1021
+#define PCI_DEVICE_ID_MOXA_CP102U	0x1022
+#define PCI_DEVICE_ID_MOXA_CP102UF	0x1023
+#define PCI_DEVICE_ID_MOXA_C104		0x1040
+#define PCI_DEVICE_ID_MOXA_CP104U	0x1041
+#define PCI_DEVICE_ID_MOXA_CP104JU	0x1042
+#define PCI_DEVICE_ID_MOXA_CP104EL	0x1043
 #define PCI_DEVICE_ID_MOXA_POS104UL	0x1044
 #define PCI_DEVICE_ID_MOXA_CB108	0x1080
-#define PCI_DEVICE_ID_MOXA_CP102UF	0x1023
 #define PCI_DEVICE_ID_MOXA_CP112UL	0x1120
+#define PCI_DEVICE_ID_MOXA_CT114	0x1140
+#define PCI_DEVICE_ID_MOXA_CP114	0x1141
 #define PCI_DEVICE_ID_MOXA_CB114	0x1142
 #define PCI_DEVICE_ID_MOXA_CP114UL	0x1143
+#define PCI_DEVICE_ID_MOXA_CP118U	0x1180
+#define PCI_DEVICE_ID_MOXA_CP118EL	0x1181
+#define PCI_DEVICE_ID_MOXA_CP132	0x1320
+#define PCI_DEVICE_ID_MOXA_CP132U	0x1321
+#define PCI_DEVICE_ID_MOXA_CP134U	0x1340
 #define PCI_DEVICE_ID_MOXA_CB134I	0x1341
 #define PCI_DEVICE_ID_MOXA_CP138U	0x1380
+#define PCI_DEVICE_ID_MOXA_C168		0x1680
+#define PCI_DEVICE_ID_MOXA_CP168U	0x1681
+#define PCI_DEVICE_ID_MOXA_CP168EL	0x1682
 
 #define MXSER_NPORTS(ddata)		((ddata) & 0xffU)
 #define MXSER_HIGHBAUD			0x0100
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b5248f27910e..86678588d191 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1965,24 +1965,6 @@
 #define PCI_DEVICE_ID_APPLICOM_PCI2000PFB 0x0003
 
 #define PCI_VENDOR_ID_MOXA		0x1393
-#define PCI_DEVICE_ID_MOXA_RC7000	0x0001
-#define PCI_DEVICE_ID_MOXA_CP102	0x1020
-#define PCI_DEVICE_ID_MOXA_CP102UL	0x1021
-#define PCI_DEVICE_ID_MOXA_CP102U	0x1022
-#define PCI_DEVICE_ID_MOXA_C104		0x1040
-#define PCI_DEVICE_ID_MOXA_CP104U	0x1041
-#define PCI_DEVICE_ID_MOXA_CP104JU	0x1042
-#define PCI_DEVICE_ID_MOXA_CP104EL	0x1043
-#define PCI_DEVICE_ID_MOXA_CT114	0x1140
-#define PCI_DEVICE_ID_MOXA_CP114	0x1141
-#define PCI_DEVICE_ID_MOXA_CP118U	0x1180
-#define PCI_DEVICE_ID_MOXA_CP118EL	0x1181
-#define PCI_DEVICE_ID_MOXA_CP132	0x1320
-#define PCI_DEVICE_ID_MOXA_CP132U	0x1321
-#define PCI_DEVICE_ID_MOXA_CP134U	0x1340
-#define PCI_DEVICE_ID_MOXA_C168		0x1680
-#define PCI_DEVICE_ID_MOXA_CP168U	0x1681
-#define PCI_DEVICE_ID_MOXA_CP168EL	0x1682
 #define PCI_DEVICE_ID_MOXA_CP204J	0x2040
 #define PCI_DEVICE_ID_MOXA_C218		0x2180
 #define PCI_DEVICE_ID_MOXA_C320		0x3200
-- 
2.33.1

