Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57777F355
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349624AbjHQJbt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 05:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349652AbjHQJbp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 05:31:45 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B11B2724;
        Thu, 17 Aug 2023 02:31:43 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37H9VY26033945;
        Thu, 17 Aug 2023 04:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692264694;
        bh=pY3LtCXAE0ywR8uVCPs1ntjEk3tZgE4po5IlIKNPoo4=;
        h=From:To:CC:Subject:Date;
        b=QlwDwaO7lKxQ4gIABGXr1kZxcYwS5INZeOoy3vy++FHZbMH3F66DEfwetAgozaeLs
         AnZ/ulj2Xe6taiQG8/4Eq8LF7VhKt3k+vWwRtgk+RLBqwxQ6sMp/TqVZFx8s6r3qSj
         xoeOVz3RC71VyF/oIQC9T7mCedROh2yR7ivrTDqk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37H9VYk2012569
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 04:31:34 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 04:31:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 04:31:33 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37H9VXc1014577;
        Thu, 17 Aug 2023 04:31:33 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        "Jan H . Sch_nherr" <jschoenh@amazon.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Achal Verma <a-verma1@ti.com>
Subject: [PATCH] PCI/IOV: Add pci_ari_enabled() check before adding virtual functions
Date:   Thu, 17 Aug 2023 15:01:32 +0530
Message-ID: <20230817093132.1078754-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
to such functions, resulting in "Unsupported Request" error response.

Fixes: 753f61247181 ("PCI: Remove reset argument from pci_iov_{add,remove}_virtfn()")
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/iov.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b2e8322755c1..611b346331e8 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -288,7 +288,7 @@ const struct attribute_group sriov_vf_dev_attr_group = {
 
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
-	int i;
+	int i, devfn;
 	int rc = -ENOMEM;
 	u64 size;
 	struct pci_dev *virtfn;
@@ -296,6 +296,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	struct pci_sriov *iov = dev->sriov;
 	struct pci_bus *bus;
 
+	devfn = pci_iov_virtfn_devfn(dev, id);
+	if ((devfn > 7) && !pci_ari_enabled(dev->bus))
+		return -ENODEV;
+
 	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
 	if (!bus)
 		goto failed;
@@ -304,7 +308,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	if (!virtfn)
 		goto failed0;
 
-	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
+	virtfn->devfn = devfn;
 	virtfn->vendor = dev->vendor;
 	virtfn->device = iov->vf_device;
 	virtfn->is_virtfn = 1;
-- 
2.25.1

