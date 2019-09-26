Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBEFBF196
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfIZLbp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:31:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53000 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfIZLbo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:31:44 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBVad7016253;
        Thu, 26 Sep 2019 06:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497496;
        bh=zjdKeRfFg26NOLGmk6yPz1vY8BAAv5jWqap9n0vA/hI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=q0MxyEK36ITvOeAVTow3U80qAUmlqHfYuNppmkNQhQXsuDHgL3qwVxtpq5mkgdwpC
         m9+cvsST2UBLEToW+sssf9ntGI4HxIFVBtCzehXJnSxtkN4pdAGZWEOoPJnw5SgmFy
         31HApJtVjfjnsm2EBN8hzCoLLEx0XRrPRznJxy8I=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBVaT4092245
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:31:36 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:31:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:31:29 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTk8069017;
        Thu, 26 Sep 2019 06:31:32 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-ntb@googlegroups.com>
Subject: [RFC PATCH 15/21] PCI: endpoint: Remove unused pci_epf_match_device()
Date:   Thu, 26 Sep 2019 16:59:27 +0530
Message-ID: <20190926112933.8922-16-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
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
index 388966faf17a..9fa4d8d4d829 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -619,22 +619,6 @@ struct pci_epf *devm_pci_epf_of_create(struct device *dev,
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
index b5075119f3ad..80505106c770 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -189,8 +189,6 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 	return dev_get_drvdata(&epf->dev);
 }
 
-const struct pci_epf_device_id *
-pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf);
 struct pci_epf *pci_epf_create(const char *name);
 struct pci_epf *pci_epf_of_create(struct device_node *node);
 struct pci_epf *devm_pci_epf_of_create(struct device *dev,
-- 
2.17.1

