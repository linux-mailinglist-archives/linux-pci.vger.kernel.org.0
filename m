Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6187ABF1A2
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfIZLbw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:31:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53026 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfIZLbv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:31:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBVffv016260;
        Thu, 26 Sep 2019 06:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497501;
        bh=NsBIGvSBpp7lUk2avEDthRUDCLoNlQ7B/MXYwZ1hE5A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B5a+RGTkuOC1CLJiLCiAVIJcE7HlSJuBgKSlVVgBJZZ5yP3cv1LebqLJhNi3Lb+k3
         Fui+vfi4UONozDcjlyXFFY7e42pU3FlxZeeiCLtxe+4GTirYzqRtM8OAwr7o4V/nWT
         cM89+LDDSawlxV+n6Wny0Grt2E6OKihR6+d40GTM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBVfmw050949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:31:41 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:31:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:31:40 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTk9069017;
        Thu, 26 Sep 2019 06:31:37 -0500
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
Subject: [RFC PATCH 16/21] PCI: endpoint: Fix missing mutex_unlock in error case
Date:   Thu, 26 Sep 2019 16:59:28 +0530
Message-ID: <20190926112933.8922-17-kishon@ti.com>
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

There is a missing mutex_unlock() in pci_epc_add_epf() in one of the
error scenarios. Fix it here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 797e5d323998..33c745546a42 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -686,6 +686,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 {
 	struct list_head *list;
 	u32 func_no = 0;
+	int ret = 0;
 
 	if (epf->is_vf)
 		return -EINVAL;
@@ -705,8 +706,10 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 	mutex_lock(&epc->lock);
 	func_no = find_first_zero_bit(&epc->function_num_map,
 				      BITS_PER_LONG);
-	if (func_no >= BITS_PER_LONG)
-		return -EINVAL;
+	if (func_no >= BITS_PER_LONG) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	set_bit(func_no, &epc->function_num_map);
 	if (type == PRIMARY_INTERFACE) {
@@ -720,9 +723,11 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 	}
 
 	list_add_tail(list, &epc->pci_epf);
+
+err:
 	mutex_unlock(&epc->lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epc_add_epf);
 
-- 
2.17.1

