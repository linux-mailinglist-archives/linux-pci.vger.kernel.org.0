Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B37CE244
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344714AbjJRQJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344860AbjJRQIz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:08:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083811C;
        Wed, 18 Oct 2023 09:08:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A09C433C7;
        Wed, 18 Oct 2023 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645332;
        bh=wcbn4CqBAdmkjiDP4EL9j1mJscemmjwifau8q2H9Em4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZM73jL+QR2IDoY6JoO2lqEYBukJfnHr7rOA07LeIzyqMFkUFDcs0sgFk9OlIfd0u
         0Pps5+4EKyo8lNOkgU2LMqUHFKT2Z1wqcX1avlTndJsaqmPFg4d/88GGDcuy1Bss8f
         CVrUUIdmuZzi+CsW5dMe7kRA+RbmCVW+stlB/VQevsj868QrGt0fZ3lNrr9MfOvvl3
         E2eF9p1szgHsM/T87D1p1pBUWumwGIKWts5nAbICX7hfnf6vyRsA9YUMwXPx/+Y77V
         8Yt2NrNDmbQph2aH4/6BK/eae1RIzBX75vodZtm+2mskYwp4oYZ81MSZ3KxSbwTtTr
         5QJ84prLH+4zA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Mateusz Nowicki <mateusz.nowicki@solidigm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/8] lspci: Print PCIe Interrupt Message Numbers consistently
Date:   Wed, 18 Oct 2023 11:08:34 -0500
Message-Id: <20231018160836.1361510-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018160836.1361510-1-helgaas@kernel.org>
References: <20231018160836.1361510-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Several Capabilities include MSI/MSI-X Interrupt Message Numbers, which
were decoded in various ways:

  - MSI %02x                             PCIe Capability
  - IntMsg %d                            AER Capability
  - INT Msg #%d                          DPC Capability
  - Interrupt Message Number %03x        SR-IOV Capability
  - Interrupt Message Number %03x        DOE Capability

Print them all using the same format:

  + IntMsgNum %d

This better matches the "Interrupt Message Number" terminology used in the
spec, e.g., PCIe r6.0, sec 7.5.3.2.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 ls-caps.c  | 2 +-
 ls-ecaps.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index 6c5b73bf2dca..fce9502bd29a 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1436,7 +1436,7 @@ cap_express(struct device *d, int where, int cap)
     default:
       printf("Unknown type %d", type);
   }
-  printf(", MSI %02x\n", (cap & PCI_EXP_FLAGS_IRQ) >> 9);
+  printf(", IntMsgNum %d\n", (cap & PCI_EXP_FLAGS_IRQ) >> 9);
   if (verbose < 2)
     return type;
 
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 6028607e8217..5bc7a6907349 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -191,7 +191,7 @@ cap_aer(struct device *d, int where, int type)
 
       l = get_conf_long(d, where + PCI_ERR_ROOT_STATUS);
       printf("\t\tRootSta: CERcvd%c MultCERcvd%c UERcvd%c MultUERcvd%c\n"
-	    "\t\t\t FirstFatal%c NonFatalMsg%c FatalMsg%c IntMsg %d\n",
+	    "\t\t\t FirstFatal%c NonFatalMsg%c FatalMsg%c IntMsgNum %d\n",
 	    FLAG(l, PCI_ERR_ROOT_COR_RCV),
 	    FLAG(l, PCI_ERR_ROOT_MULTI_COR_RCV),
 	    FLAG(l, PCI_ERR_ROOT_UNCOR_RCV),
@@ -221,7 +221,7 @@ static void cap_dpc(struct device *d, int where)
     return;
 
   l = get_conf_word(d, where + PCI_DPC_CAP);
-  printf("\t\tDpcCap:\tINT Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
+  printf("\t\tDpcCap:\tIntMsgNum %d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
     PCI_DPC_CAP_INT_MSG(l), FLAG(l, PCI_DPC_CAP_RP_EXT), FLAG(l, PCI_DPC_CAP_TLP_BLOCK),
     FLAG(l, PCI_DPC_CAP_SW_TRIGGER), PCI_DPC_CAP_RP_LOG(l), FLAG(l, PCI_DPC_CAP_DL_ACT_ERR));
 
@@ -371,7 +371,7 @@ cap_sriov(struct device *d, int where)
     return;
 
   l = get_conf_long(d, where + PCI_IOV_CAP);
-  printf("\t\tIOVCap:\tMigration%c 10BitTagReq%c Interrupt Message Number: %03x\n",
+  printf("\t\tIOVCap:\tMigration%c 10BitTagReq%c IntMsgNum %d\n",
 	FLAG(l, PCI_IOV_CAP_VFM), FLAG(l, PCI_IOV_CAP_VF_10BIT_TAG_REQ), PCI_IOV_CAP_IMN(l));
   w = get_conf_word(d, where + PCI_IOV_CTRL);
   printf("\t\tIOVCtl:\tEnable%c Migration%c Interrupt%c MSE%c ARIHierarchy%c 10BitTagReq%c\n",
@@ -1394,7 +1394,7 @@ cap_doe(struct device *d, int where)
   printf("\t\tDOECap: IntSup%c\n",
 	 FLAG(l, PCI_DOE_CAP_INT_SUPP));
   if (l & PCI_DOE_CAP_INT_SUPP)
-    printf("\t\t\tInterrupt Message Number %03x\n",
+    printf("\t\t\tIntMsgNum %d\n",
 	   PCI_DOE_CAP_INT_MSG(l));
 
   l = get_conf_long(d, where + PCI_DOE_CTL);
-- 
2.34.1

