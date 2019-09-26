Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E04BF19B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfIZLbz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:31:55 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50206 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfIZLbx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:31:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBVj3F026099;
        Thu, 26 Sep 2019 06:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497505;
        bh=CVQLahlcO/peyrVMGcW0P4vLEQL8s6mVGnyOrqGBh9U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jpWByUMOSWnhI+HLdzHyh6cGR4z7onhGpi0yIN67E2Acv/Gdwx+zrUqnsiFQpqLPz
         An/WIkWTeFcaFcFfvxg8uao/Ggny5+Vi0mGzVvHlTPl+ei7nQ7xOzVS2vL82FN8IAB
         d8PJ8cFhWJtu7FqNnivJBURZKKCgCb7zmVpmW5uw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBVj5h092389
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:31:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:31:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:31:44 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTkA069017;
        Thu, 26 Sep 2019 06:31:41 -0500
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
Subject: [RFC PATCH 17/21] PCI: endpoint: *_free_bar() to return error codes on failure
Date:   Thu, 26 Sep 2019 16:59:29 +0530
Message-ID: <20190926112933.8922-18-kishon@ti.com>
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

Modify pci_epc_get_next_free_bar() and pci_epc_get_first_free_bar() to
return error values if there are no free BARs available.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 9 ++++-----
 include/linux/pci-epc.h             | 7 +++----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 33c745546a42..a93c78488bca 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -173,8 +173,7 @@ EXPORT_SYMBOL_GPL(of_pci_epc_get_by_name);
  * Invoke to get the first unreserved BAR that can be used by the endpoint
  * function. For any incorrect value in reserved_bar return '0'.
  */
-unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
-					*epc_features)
+int pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features)
 {
 	return pci_epc_get_next_free_bar(epc_features, BAR_0);
 }
@@ -188,8 +187,8 @@ EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
  * Invoke to get the next unreserved BAR starting from @bar that can be used
  * for endpoint function. For any incorrect value in reserved_bar return '0'.
  */
-unsigned int pci_epc_get_next_free_bar(const struct pci_epc_features
-				       *epc_features, enum pci_barno bar)
+int pci_epc_get_next_free_bar(const struct pci_epc_features
+			      *epc_features, enum pci_barno bar)
 {
 	unsigned long free_bar;
 
@@ -209,7 +208,7 @@ unsigned int pci_epc_get_next_free_bar(const struct pci_epc_features
 
 	free_bar = find_next_zero_bit(&free_bar, 6, bar);
 	if (free_bar > 5)
-		return 0;
+		return -EINVAL;
 
 	return free_bar;
 }
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 0632a4d4714d..ad8021b0efb7 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -227,10 +227,9 @@ void pci_epc_of_parse_header(struct device_node *node,
 			     struct pci_epf_header *header);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
-unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
-					*epc_features);
-unsigned int pci_epc_get_next_free_bar(const struct pci_epc_features
-				       *epc_features, enum pci_barno bar);
+int pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
+int pci_epc_get_next_free_bar(const struct pci_epc_features
+			      *epc_features, enum pci_barno bar);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 struct pci_epc *of_pci_epc_get(struct device_node *node, int index);
-- 
2.17.1

