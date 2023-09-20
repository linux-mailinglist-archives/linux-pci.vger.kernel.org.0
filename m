Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1D7A73C8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjITHPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjITHPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 03:15:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7A893
        for <linux-pci@vger.kernel.org>; Wed, 20 Sep 2023 00:15:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38K7Etsb036802;
        Wed, 20 Sep 2023 02:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695194096;
        bh=KVcAdfq5a5X4kQHPesUltWMh4vo4p2mYilAwZCmQUcs=;
        h=From:To:CC:Subject:Date;
        b=wjg+bhyoK5euFvlqztpX/B7YsW3R4PaVwpGAzL5rIYgI9h+pkK2WcvSMXOvlJdgKi
         DOdlCueO0sYlYqXkmMFpakGNpSVKefxnyBHTqlLtUsswpxNEE05sbWqvzgClTQ+UVj
         wR6NZ33R9x192pCEkYkL5Pvt9HWlXeYXpdxK1LmU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38K7EtMN065122
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Sep 2023 02:14:55 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Sep 2023 02:14:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Sep 2023 02:14:55 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38K7EsT6005391;
        Wed, 20 Sep 2023 02:14:55 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        "Jan H . Sch_nherr" <jschoenh@amazon.de>
CC:     <linux-pci@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH v2] PCI/IOV: Add pci_ari_enabled check before adding virtual functions
Date:   Wed, 20 Sep 2023 12:44:54 +0530
Message-ID: <20230920071454.363245-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Absence of pci_ari_enabled() check in pci_iov_add_virtfn() allows addition
of virtual functions with function number > 7, even for devices which
doesn't have ARI Fowarding Support. So, adding pci_ari_enabled() check to
prevent addition of function number > 7 and thus avoid later invalid access
to such functions resulting in "Unsupported Request" error response.

Fixes: 753f61247181 ("PCI: Remove reset argument from pci_iov_{add,remove}_virtfn()")
Signed-off-by: Achal Verma <a-verma1@ti.com>
---

Changes from v1:
* Rebased on next-20230920

 drivers/pci/iov.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 25dbe85c4217..cac647ac4cd6 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -287,7 +287,7 @@ const struct attribute_group sriov_vf_dev_attr_group = {
 
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
-	int i;
+	int i, devfn;
 	int rc = -ENOMEM;
 	u64 size;
 	struct pci_dev *virtfn;
@@ -295,6 +295,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	struct pci_sriov *iov = dev->sriov;
 	struct pci_bus *bus;
 
+	devfn = pci_iov_virtfn_devfn(dev, id);
+	if ((devfn > 7) && !pci_ari_enabled(dev->bus))
+		return -ENODEV;
+
 	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
 	if (!bus)
 		goto failed;
@@ -303,7 +307,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	if (!virtfn)
 		goto failed0;
 
-	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
+	virtfn->devfn = devfn;
 	virtfn->vendor = dev->vendor;
 	virtfn->device = iov->vf_device;
 	virtfn->is_virtfn = 1;
-- 
2.25.1

