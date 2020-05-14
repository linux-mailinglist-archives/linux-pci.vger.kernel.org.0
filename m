Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF10F1D3411
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 17:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgENPBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 11:01:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47210 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgENPBI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 11:01:08 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04EF0U5h000451;
        Thu, 14 May 2020 10:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589468430;
        bh=qWW3b6wKFGM1AGP1VPxedbqz8b5wEZNj4elQBEhNLLA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=t9jN4f7JPiZltBE2Yw8PUP+EsCaGEDkxaiq4ozUB+aMFHNjJdw2P2nB+HUST87ORg
         mmrPZjWV5hgRwOkx4bT8hA5b+47wWQ+WOKUzo83AaBzX7c4QBrYHgwIY5iCG17lyo9
         H2xJzAykWyDXhsr/v3TKrcx05RLpEjctfnTkGBK4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04EF0U7t103553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 10:00:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 10:00:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 10:00:29 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04EExgAr019279;
        Thu, 14 May 2020 10:00:25 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 09/19] PCI: endpoint: Remove unused pci_epf_match_device()
Date:   Thu, 14 May 2020 20:29:17 +0530
Message-ID: <20200514145927.17555-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused pci_epf_match_device() function added in pci-epf-core.c

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 16 ----------------
 include/linux/pci-epf.h             |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index cb6c7b886325..f9ba2e8d4a99 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -347,22 +347,6 @@ struct pci_epf *devm_pci_epf_of_create(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pci_epf_of_create);
 
-const struct pci_epf_device_id *
-pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf)
-{
-	if (!id || !epf)
-		return NULL;
-
-	while (*id->name) {
-		if (strcmp(epf->name, id->name) == 0)
-			return id;
-		id++;
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(pci_epf_match_device);
-
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index e51f3070bcc4..9bd89f1be1c3 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -168,8 +168,6 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 	return dev_get_drvdata(&epf->dev);
 }
 
-const struct pci_epf_device_id *
-pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf);
 struct pci_epf *pci_epf_create(const char *name);
 struct pci_epf *pci_epf_of_create(struct device_node *node);
 struct pci_epf *devm_pci_epf_of_create(struct device *dev,
-- 
2.17.1

