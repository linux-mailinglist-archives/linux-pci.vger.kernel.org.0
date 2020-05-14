Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26851D3421
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 17:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgENPBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 11:01:18 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50614 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgENPBS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 11:01:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04EF0Phg032575;
        Thu, 14 May 2020 10:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589468425;
        bh=d0fOtFl25Y4cCZ7iJrJTiA5KGVWfErtqvxcwYo2KWNQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oNLXtvgOPfB3H8/8nGIgiRRFe7SlvkuW9s9MiHlhx94X9hXrLdnjIFUV/G6bClN/s
         FRJLKDe2QH7gYCKYHiDLeUKMKSdS9nfh30ul3MagTvrkwt5Dh5+Q759fwAqrb/twQy
         Sl0kqa9Q5ZMunI/Iyup8cc7IE0ZBdgvRiasTD/5M=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04EF0P3r103450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 10:00:25 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 10:00:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 10:00:25 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04EExgAq019279;
        Thu, 14 May 2020 10:00:21 -0500
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
Subject: [PATCH 08/19] PCI: endpoint: Make *_free_bar() to return error codes on failure
Date:   Thu, 14 May 2020 20:29:16 +0530
Message-ID: <20200514145927.17555-9-kishon@ti.com>
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

Modify pci_epc_get_next_free_bar() and pci_epc_get_first_free_bar() to
return error values if there are no free BARs available.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 ++
 drivers/pci/endpoint/pci-epc-core.c           | 12 ++++++------
 include/linux/pci-epc.h                       |  8 ++++----
 include/linux/pci-epf.h                       |  1 +
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 60330f3e3751..ba43e1e05958 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -831,6 +831,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		linkup_notifier = epc_features->linkup_notifier;
 		core_init_notifier = epc_features->core_init_notifier;
 		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
+		if (test_reg_bar < 0)
+			return -EINVAL;
 		pci_epf_configure_bar(epf, epc_features);
 	}
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 85e542aae617..df8789fee01e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -150,8 +150,8 @@ EXPORT_SYMBOL_GPL(of_pci_epc_get_by_name);
  * Invoke to get the first unreserved BAR that can be used by the endpoint
  * function. For any incorrect value in reserved_bar return '0'.
  */
-unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
-					*epc_features)
+enum pci_barno
+pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features)
 {
 	return pci_epc_get_next_free_bar(epc_features, BAR_0);
 }
@@ -165,13 +165,13 @@ EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
  * Invoke to get the next unreserved BAR starting from @bar that can be used
  * for endpoint function. For any incorrect value in reserved_bar return '0'.
  */
-unsigned int pci_epc_get_next_free_bar(const struct pci_epc_features
-				       *epc_features, enum pci_barno bar)
+enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
+					 *epc_features, enum pci_barno bar)
 {
 	unsigned long free_bar;
 
 	if (!epc_features)
-		return 0;
+		return BAR_0;
 
 	/* If 'bar - 1' is a 64-bit BAR, move to the next BAR */
 	if ((epc_features->bar_fixed_64bit << 1) & 1 << bar)
@@ -186,7 +186,7 @@ unsigned int pci_epc_get_next_free_bar(const struct pci_epc_features
 
 	free_bar = find_next_zero_bit(&free_bar, 6, bar);
 	if (free_bar > 5)
-		return 0;
+		return NO_BAR;
 
 	return free_bar;
 }
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 68f7c0d81442..463586889453 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -201,10 +201,10 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no);
-unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
-					*epc_features);
-unsigned int pci_epc_get_next_free_bar(const struct pci_epc_features
-				       *epc_features, enum pci_barno bar);
+enum pci_barno
+pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
+enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
+					 *epc_features, enum pci_barno bar);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 8fb77ab1968f..e51f3070bcc4 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -22,6 +22,7 @@ enum pci_notify_event {
 };
 
 enum pci_barno {
+	NO_BAR = -1,
 	BAR_0,
 	BAR_1,
 	BAR_2,
-- 
2.17.1

