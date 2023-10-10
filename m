Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61CE7C41CE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjJJUpO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjJJUpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:45:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C04D7;
        Tue, 10 Oct 2023 13:45:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8F8C433C8;
        Tue, 10 Oct 2023 20:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970708;
        bh=uerkQZGYqipwqCuFQ61J4jZM2/uJMxrOLAz96N1VUHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwwlxWpwXBzLcKJSFiDey2J05lY58C0khp27EYzOR+7j/nZisNBdsu/8yZDLrqHUH
         mmFj7mKXeCEd2bfWfkcMpA+GE2WELa4gYHOMTvZ2MUpsNFC/ZALAPteDwaVCalWSNK
         BWFuU26FvLna1VCbW7jEZRpB15InsJA21QCBt3/nkWsgnYrW0Ug846lpUpGEqKcbOk
         I8lwolSziT1FQj3ldA593/ypfivoKgcsL9qp7pSRa/aK0DfwQDvhwdkgYF/JlDo2Zh
         v5w9Y2rO4xtMQxfosYkyexokg9+Ifzj/IDzP/uV1FHo5ytx3JbMn8pA7RtPFmuezAm
         cSn9UcdQu+UuA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 10/10] PCI/portdrv: Use FIELD_GET()
Date:   Tue, 10 Oct 2023 15:44:36 -0500
Message-Id: <20231010204436.1000644-11-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
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

Use FIELD_GET() to remove dependences on the field position, i.e., the
shift value.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 46fad0d813b2..14a4b89a3b83 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -6,6 +6,7 @@
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  */
 
+#include <linux/bitfield.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -69,7 +70,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
 		    PCIE_PORT_SERVICE_BWNOTIF)) {
 		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
-		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
+		*pme = FIELD_GET(PCI_EXP_FLAGS_IRQ, reg16);
 		nvec = *pme + 1;
 	}
 
@@ -81,7 +82,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 		if (pos) {
 			pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS,
 					      &reg32);
-			*aer = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
+			*aer = FIELD_GET(PCI_ERR_ROOT_AER_IRQ, reg32);
 			nvec = max(nvec, *aer + 1);
 		}
 	}
@@ -92,7 +93,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 		if (pos) {
 			pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP,
 					     &reg16);
-			*dpc = reg16 & PCI_EXP_DPC_IRQ;
+			*dpc = FIELD_GET(PCI_EXP_DPC_IRQ, reg16);
 			nvec = max(nvec, *dpc + 1);
 		}
 	}
-- 
2.34.1

