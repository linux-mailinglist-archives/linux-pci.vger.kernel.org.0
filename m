Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86640269D00
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 06:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgIOEWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 00:22:05 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36350 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgIOEWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 00:22:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08F4Li9I001418;
        Mon, 14 Sep 2020 23:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600143704;
        bh=7qF2OVbWDyaTlnP441W+A6WtQychKbyb9MpcDopQVLo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hbhARPU1Jy0qJbdO1SBKgo+gAl9x9B6JNgMnZZf5uhhBtP4EBIxS+2PJ9n1v/q4KV
         yBwGQXd+7lH3l2x7R1V51y/ffHlgYwgyDAcvk2n1CBk7Tno+xmisWrfS2jdDG7rT4X
         Nj8YMAu2sFt+pC6tqRGi0F4CBSxWVXxqNEItrpwk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08F4LiCU042740
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 23:21:44 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Sep 2020 23:21:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Sep 2020 23:21:43 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08F4LDMj028615;
        Mon, 14 Sep 2020 23:21:38 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ntb@googlegroups.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 03/17] PCI: endpoint: Add helper API to get the 'next' unreserved BAR
Date:   Tue, 15 Sep 2020 09:50:56 +0530
Message-ID: <20200915042110.3015-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915042110.3015-1-kishon@ti.com>
References: <20200915042110.3015-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add an API to get the next unreserved BAR starting from a given BAR
number that can be used by the endpoint function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++----
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 25e57672e1a1..1afe5d9afb0d 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -87,17 +87,36 @@ EXPORT_SYMBOL_GPL(pci_epc_get);
  * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
  * @epc_features: pci_epc_features structure that holds the reserved bar bitmap
  *
- * Invoke to get the first unreserved BAR that can be used for endpoint
+ * Invoke to get the first unreserved BAR that can be used by the endpoint
  * function. For any incorrect value in reserved_bar return '0'.
  */
 unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
 					*epc_features)
+{
+	return pci_epc_get_next_free_bar(epc_features, BAR_0);
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
+
+/**
+ * pci_epc_get_next_free_bar() - helper to get unreserved BAR starting from @bar
+ * @epc_features: pci_epc_features structure that holds the reserved bar bitmap
+ * @bar: the starting BAR number from where unreserved BAR should be searched
+ *
+ * Invoke to get the next unreserved BAR starting from @bar that can be used
+ * for endpoint function. For any incorrect value in reserved_bar return '0'.
+ */
+unsigned int pci_epc_get_next_free_bar(const struct pci_epc_features
+				       *epc_features, enum pci_barno bar)
 {
 	unsigned long free_bar;
 
 	if (!epc_features)
 		return 0;
 
+	/* If 'bar - 1' is a 64-bit BAR, move to the next BAR */
+	if ((epc_features->bar_fixed_64bit << 1) & 1 << bar)
+		bar++;
+
 	/* Find if the reserved BAR is also a 64-bit BAR */
 	free_bar = epc_features->reserved_bar & epc_features->bar_fixed_64bit;
 
@@ -105,14 +124,13 @@ unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
 	free_bar <<= 1;
 	free_bar |= epc_features->reserved_bar;
 
-	/* Now find the free BAR */
-	free_bar = ffz(free_bar);
+	free_bar = find_next_zero_bit(&free_bar, 6, bar);
 	if (free_bar > 5)
 		return 0;
 
 	return free_bar;
 }
-EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
+EXPORT_SYMBOL_GPL(pci_epc_get_next_free_bar);
 
 /**
  * pci_epc_get_features() - get the features supported by EPC
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index cc66bec8be90..cfe9b427e6b7 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -203,6 +203,8 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no);
 unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
 					*epc_features);
+unsigned int pci_epc_get_next_free_bar(const struct pci_epc_features
+				       *epc_features, enum pci_barno bar);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
-- 
2.17.1

