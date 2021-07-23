Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69E43D316D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 03:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhGWBPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 21:15:42 -0400
Received: from mx20.baidu.com ([111.202.115.85]:58432 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230318AbhGWBPk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 21:15:40 -0400
Received: from BC-Mail-Ex19.internal.baidu.com (unknown [172.31.51.13])
        by Forcepoint Email with ESMTPS id 9E39AB17E4BDB5205D7B;
        Fri, 23 Jul 2021 09:56:12 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex19.internal.baidu.com (172.31.51.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 23 Jul 2021 09:56:12 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 23 Jul 2021 09:56:11 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <bhelgaas@google.com>, <jonathan.derrick@intel.com>,
        <kw@linux.com>, <lorenzo.pieralisi@arm.com>, <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH v2 1/2] PCI: Make use of PCI_DEVICE_SUB/_CLASS() helper function
Date:   Fri, 23 Jul 2021 09:55:58 +0800
Message-ID: <20210723015559.695-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723015559.695-1-caihuoqing@baidu.com>
References: <20210723015559.695-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We could make use of PCI_DEVICE_SUB/CLASS() helper function

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/pci/hotplug/cpqphp_core.c | 13 ++-----------
 drivers/pci/search.c              | 14 ++------------
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index f99a7927e5a8..407206a233c8 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -1357,18 +1357,9 @@ static void __exit unload_cpqphpd(void)
 }
 
 static const struct pci_device_id hpcd_pci_tbl[] = {
-	{
 	/* handle any PCI Hotplug controller */
-	.class =        ((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
-	.class_mask =   ~0,
-
-	/* no matter who makes it */
-	.vendor =       PCI_ANY_ID,
-	.device =       PCI_ANY_ID,
-	.subvendor =    PCI_ANY_ID,
-	.subdevice =    PCI_ANY_ID,
-
-	}, { /* end: all zeroes */ }
+	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00), ~0) },
+	{ /* end: all zeroes */ },
 };
 
 MODULE_DEVICE_TABLE(pci, hpcd_pci_tbl);
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index b4c138a6ec02..528c4fe33171 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -303,11 +303,7 @@ struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
 			       struct pci_dev *from)
 {
 	struct pci_device_id id = {
-		.vendor = vendor,
-		.device = device,
-		.subvendor = ss_vendor,
-		.subdevice = ss_device,
-	};
+		PCI_DEVICE_SUB(vendor, device, ss_vendor, ss_device) };
 
 	return pci_get_dev_by_id(&id, from);
 }
@@ -351,13 +347,7 @@ EXPORT_SYMBOL(pci_get_device);
 struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from)
 {
 	struct pci_device_id id = {
-		.vendor = PCI_ANY_ID,
-		.device = PCI_ANY_ID,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.class_mask = PCI_ANY_ID,
-		.class = class,
-	};
+		PCI_DEVICE_CLASS(PCI_ANY_ID, class) };
 
 	return pci_get_dev_by_id(&id, from);
 }
-- 
2.25.1

