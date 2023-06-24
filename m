Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611C473C5C4
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 03:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFXBOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 21:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjFXBOx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 21:14:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965CA273E;
        Fri, 23 Jun 2023 18:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687569291; x=1719105291;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=2cDG6IN9xIZEpAOLUb24m7v8B/2dcfWa2ttLu90qgTM=;
  b=uG6YyCZcsNt7MJBUO2WFto7ucIysKuErBpmG6BGtLKTNRiKkNrqsllrJ
   jKUSa396Ju5MtFPpxSJLjgxdQ0/CXHbTvr0q6yX1H5OMPQ9Li7ZFq2WDl
   MWJETnY+M0JbQHOnSMcW8Y5sM5gdI/2GIu1pEzEodTmozHy06ByKcNLxe
   ynVpd10SFbmaXaGhgPd4PaDoYWrnbqPMuaIOwMq+J0Gg439ze/TtMCVpn
   zEpOz3+9pa5ie4UijMnRFlaU/dn1rdlcDQd1Qmn3HxLq/92Xc4FsJBKdt
   Q1MRfbSIO1StepIWdT0x9N6kttOoDtskgeJhw3wJFCqfv9kziFZTuZgRv
   A==;
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="158380521"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2023 18:14:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 23 Jun 2023 18:14:41 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 23 Jun 2023 18:14:41 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] PCI: switchtec: Add support for PCIe Gen5 devices
Date:   Fri, 23 Jun 2023 17:00:03 -0700
Message-ID: <20230624000003.2315364-3-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230624000003.2315364-1-kelvin.cao@microchip.com>
References: <20230624000003.2315364-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

Advertise support of Gen5 devices in the driver's device ID table and
add the same IDs for the switchtec quirks. Also update driver code to
accommodate them.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/pci/quirks.c           | 36 ++++++++++++++++++++++++++++
 drivers/pci/switch/switchtec.c | 44 ++++++++++++++++++++++++++++++----
 include/linux/switchtec.h      |  1 +
 3 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c525867760bf..3ec5db5861c6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5770,6 +5770,42 @@ SWITCHTEC_QUIRK(0x4428);  /* PSXA 28XG4 */
 SWITCHTEC_QUIRK(0x4552);  /* PAXA 52XG4 */
 SWITCHTEC_QUIRK(0x4536);  /* PAXA 36XG4 */
 SWITCHTEC_QUIRK(0x4528);  /* PAXA 28XG4 */
+SWITCHTEC_QUIRK(0x5000);  /* PFX 100XG5 */
+SWITCHTEC_QUIRK(0x5084);  /* PFX 84XG5 */
+SWITCHTEC_QUIRK(0x5068);  /* PFX 68XG5 */
+SWITCHTEC_QUIRK(0x5052);  /* PFX 52XG5 */
+SWITCHTEC_QUIRK(0x5036);  /* PFX 36XG5 */
+SWITCHTEC_QUIRK(0x5028);  /* PFX 28XG5 */
+SWITCHTEC_QUIRK(0x5100);  /* PSX 100XG5 */
+SWITCHTEC_QUIRK(0x5184);  /* PSX 84XG5 */
+SWITCHTEC_QUIRK(0x5168);  /* PSX 68XG5 */
+SWITCHTEC_QUIRK(0x5152);  /* PSX 52XG5 */
+SWITCHTEC_QUIRK(0x5136);  /* PSX 36XG5 */
+SWITCHTEC_QUIRK(0x5128);  /* PSX 28XG5 */
+SWITCHTEC_QUIRK(0x5200);  /* PAX 100XG5 */
+SWITCHTEC_QUIRK(0x5284);  /* PAX 84XG5 */
+SWITCHTEC_QUIRK(0x5268);  /* PAX 68XG5 */
+SWITCHTEC_QUIRK(0x5252);  /* PAX 52XG5 */
+SWITCHTEC_QUIRK(0x5236);  /* PAX 36XG5 */
+SWITCHTEC_QUIRK(0x5228);  /* PAX 28XG5 */
+SWITCHTEC_QUIRK(0x5300);  /* PFXA 100XG5 */
+SWITCHTEC_QUIRK(0x5384);  /* PFXA 84XG5 */
+SWITCHTEC_QUIRK(0x5368);  /* PFXA 68XG5 */
+SWITCHTEC_QUIRK(0x5352);  /* PFXA 52XG5 */
+SWITCHTEC_QUIRK(0x5336);  /* PFXA 36XG5 */
+SWITCHTEC_QUIRK(0x5328);  /* PFXA 28XG5 */
+SWITCHTEC_QUIRK(0x5400);  /* PSXA 100XG5 */
+SWITCHTEC_QUIRK(0x5484);  /* PSXA 84XG5 */
+SWITCHTEC_QUIRK(0x5468);  /* PSXA 68XG5 */
+SWITCHTEC_QUIRK(0x5452);  /* PSXA 52XG5 */
+SWITCHTEC_QUIRK(0x5436);  /* PSXA 36XG5 */
+SWITCHTEC_QUIRK(0x5428);  /* PSXA 28XG5 */
+SWITCHTEC_QUIRK(0x5500);  /* PAXA 100XG5 */
+SWITCHTEC_QUIRK(0x5584);  /* PAXA 84XG5 */
+SWITCHTEC_QUIRK(0x5568);  /* PAXA 68XG5 */
+SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
+SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
+SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
 
 /*
  * The PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints.
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 941e8e9cff96..5b921387eca6 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -372,7 +372,7 @@ static ssize_t field ## _show(struct device *dev, \
 	if (stdev->gen == SWITCHTEC_GEN3) \
 		return io_string_show(buf, &si->gen3.field, \
 				      sizeof(si->gen3.field)); \
-	else if (stdev->gen == SWITCHTEC_GEN4) \
+	else if (stdev->gen >= SWITCHTEC_GEN4) \
 		return io_string_show(buf, &si->gen4.field, \
 				      sizeof(si->gen4.field)); \
 	else \
@@ -663,7 +663,7 @@ static int ioctl_flash_info(struct switchtec_dev *stdev,
 	if (stdev->gen == SWITCHTEC_GEN3) {
 		info.flash_length = ioread32(&fi->gen3.flash_length);
 		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN3;
-	} else if (stdev->gen == SWITCHTEC_GEN4) {
+	} else if (stdev->gen >= SWITCHTEC_GEN4) {
 		info.flash_length = ioread32(&fi->gen4.flash_length);
 		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN4;
 	} else {
@@ -870,7 +870,7 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 		ret = flash_part_info_gen3(stdev, &info);
 		if (ret)
 			return ret;
-	} else if (stdev->gen == SWITCHTEC_GEN4) {
+	} else if (stdev->gen >= SWITCHTEC_GEN4) {
 		ret = flash_part_info_gen4(stdev, &info);
 		if (ret)
 			return ret;
@@ -1610,7 +1610,7 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 
 	if (stdev->gen == SWITCHTEC_GEN3)
 		part_id = &stdev->mmio_sys_info->gen3.partition_id;
-	else if (stdev->gen == SWITCHTEC_GEN4)
+	else if (stdev->gen >= SWITCHTEC_GEN4)
 		part_id = &stdev->mmio_sys_info->gen4.partition_id;
 	else
 		return -EOPNOTSUPP;
@@ -1784,6 +1784,42 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x4552, SWITCHTEC_GEN4),  /* PAXA 52XG4 */
 	SWITCHTEC_PCI_DEVICE(0x4536, SWITCHTEC_GEN4),  /* PAXA 36XG4 */
 	SWITCHTEC_PCI_DEVICE(0x4528, SWITCHTEC_GEN4),  /* PAXA 28XG4 */
+	SWITCHTEC_PCI_DEVICE(0x5000, SWITCHTEC_GEN5),  /* PFX 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5084, SWITCHTEC_GEN5),  /* PFX 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5068, SWITCHTEC_GEN5),  /* PFX 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5052, SWITCHTEC_GEN5),  /* PFX 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5036, SWITCHTEC_GEN5),  /* PFX 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5028, SWITCHTEC_GEN5),  /* PFX 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5100, SWITCHTEC_GEN5),  /* PSX 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5184, SWITCHTEC_GEN5),  /* PSX 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5168, SWITCHTEC_GEN5),  /* PSX 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5152, SWITCHTEC_GEN5),  /* PSX 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5136, SWITCHTEC_GEN5),  /* PSX 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5128, SWITCHTEC_GEN5),  /* PSX 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5200, SWITCHTEC_GEN5),  /* PAX 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5284, SWITCHTEC_GEN5),  /* PAX 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5268, SWITCHTEC_GEN5),  /* PAX 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5252, SWITCHTEC_GEN5),  /* PAX 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5236, SWITCHTEC_GEN5),  /* PAX 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5228, SWITCHTEC_GEN5),  /* PAX 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5300, SWITCHTEC_GEN5),  /* PFXA 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5384, SWITCHTEC_GEN5),  /* PFXA 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5368, SWITCHTEC_GEN5),  /* PFXA 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5352, SWITCHTEC_GEN5),  /* PFXA 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5336, SWITCHTEC_GEN5),  /* PFXA 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5328, SWITCHTEC_GEN5),  /* PFXA 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5400, SWITCHTEC_GEN5),  /* PSXA 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5484, SWITCHTEC_GEN5),  /* PSXA 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5468, SWITCHTEC_GEN5),  /* PSXA 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5452, SWITCHTEC_GEN5),  /* PSXA 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5436, SWITCHTEC_GEN5),  /* PSXA 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5428, SWITCHTEC_GEN5),  /* PSXA 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5500, SWITCHTEC_GEN5),  /* PAXA 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5584, SWITCHTEC_GEN5),  /* PAXA 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5568, SWITCHTEC_GEN5),  /* PAXA 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5552, SWITCHTEC_GEN5),  /* PAXA 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5536, SWITCHTEC_GEN5),  /* PAXA 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5528, SWITCHTEC_GEN5),  /* PAXA 28XG5 */
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 48fabe36509e..8d8fac1626bd 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -41,6 +41,7 @@ enum {
 enum switchtec_gen {
 	SWITCHTEC_GEN3,
 	SWITCHTEC_GEN4,
+	SWITCHTEC_GEN5,
 };
 
 struct mrpc_regs {
-- 
2.25.1

