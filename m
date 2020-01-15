Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43D13B86F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 04:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgAOD5E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 22:57:04 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43364 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbgAOD5C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 22:57:02 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZna-0001ip-35; Tue, 14 Jan 2020 20:57:00 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZnX-0000gk-Mm; Tue, 14 Jan 2020 20:56:51 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 14 Jan 2020 20:56:48 -0700
Message-Id: <20200115035648.2578-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115035648.2578-1-logang@deltatee.com>
References: <20200115035648.2578-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, epilmore@gigaio.com, dmeyer@gigaio.com, Kelvin.Cao@microchip.com, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v2 7/7] PCI/switchtec: Introduce gen4 variant IDS in the device ID table
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

Now that GEN4 is properly supported, advertise support in the module's
device ID table and add the same IDs to the list of switchtec quirks.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
[logang@deltatee.com: add commit message and quirk IDs]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/quirks.c           | 18 ++++++++++++++++++
 drivers/pci/switch/switchtec.c | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4937a088d7d8..d54692bc3af4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5373,6 +5373,24 @@ SWITCHTEC_QUIRK(0x8573);  /* PFXI 48XG3 */
 SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
 SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
 SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
+SWITCHTEC_QUIRK(0x4000);  /* PFX 100XG4 */
+SWITCHTEC_QUIRK(0x4084);  /* PFX 84XG4  */
+SWITCHTEC_QUIRK(0x4068);  /* PFX 68XG4  */
+SWITCHTEC_QUIRK(0x4052);  /* PFX 52XG4  */
+SWITCHTEC_QUIRK(0x4036);  /* PFX 36XG4  */
+SWITCHTEC_QUIRK(0x4028);  /* PFX 28XG4  */
+SWITCHTEC_QUIRK(0x4100);  /* PSX 100XG4 */
+SWITCHTEC_QUIRK(0x4184);  /* PSX 84XG4  */
+SWITCHTEC_QUIRK(0x4168);  /* PSX 68XG4  */
+SWITCHTEC_QUIRK(0x4152);  /* PSX 52XG4  */
+SWITCHTEC_QUIRK(0x4136);  /* PSX 36XG4  */
+SWITCHTEC_QUIRK(0x4128);  /* PSX 28XG4  */
+SWITCHTEC_QUIRK(0x4200);  /* PAX 100XG4 */
+SWITCHTEC_QUIRK(0x4284);  /* PAX 84XG4  */
+SWITCHTEC_QUIRK(0x4268);  /* PAX 68XG4  */
+SWITCHTEC_QUIRK(0x4252);  /* PAX 52XG4  */
+SWITCHTEC_QUIRK(0x4236);  /* PAX 36XG4  */
+SWITCHTEC_QUIRK(0x4228);  /* PAX 28XG4  */
 
 /*
  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS does
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 92b95e8067c0..a823b4b8ef8a 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1696,6 +1696,24 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x8574, SWITCHTEC_GEN3),  //PFXI 64XG3
 	SWITCHTEC_PCI_DEVICE(0x8575, SWITCHTEC_GEN3),  //PFXI 80XG3
 	SWITCHTEC_PCI_DEVICE(0x8576, SWITCHTEC_GEN3),  //PFXI 96XG3
+	SWITCHTEC_PCI_DEVICE(0x4000, SWITCHTEC_GEN4),  //PFX 100XG4
+	SWITCHTEC_PCI_DEVICE(0x4084, SWITCHTEC_GEN4),  //PFX 84XG4
+	SWITCHTEC_PCI_DEVICE(0x4068, SWITCHTEC_GEN4),  //PFX 68XG4
+	SWITCHTEC_PCI_DEVICE(0x4052, SWITCHTEC_GEN4),  //PFX 52XG4
+	SWITCHTEC_PCI_DEVICE(0x4036, SWITCHTEC_GEN4),  //PFX 36XG4
+	SWITCHTEC_PCI_DEVICE(0x4028, SWITCHTEC_GEN4),  //PFX 28XG4
+	SWITCHTEC_PCI_DEVICE(0x4100, SWITCHTEC_GEN4),  //PSX 100XG4
+	SWITCHTEC_PCI_DEVICE(0x4184, SWITCHTEC_GEN4),  //PSX 84XG4
+	SWITCHTEC_PCI_DEVICE(0x4168, SWITCHTEC_GEN4),  //PSX 68XG4
+	SWITCHTEC_PCI_DEVICE(0x4152, SWITCHTEC_GEN4),  //PSX 52XG4
+	SWITCHTEC_PCI_DEVICE(0x4136, SWITCHTEC_GEN4),  //PSX 36XG4
+	SWITCHTEC_PCI_DEVICE(0x4128, SWITCHTEC_GEN4),  //PSX 28XG4
+	SWITCHTEC_PCI_DEVICE(0x4200, SWITCHTEC_GEN4),  //PAX 100XG4
+	SWITCHTEC_PCI_DEVICE(0x4284, SWITCHTEC_GEN4),  //PAX 84XG4
+	SWITCHTEC_PCI_DEVICE(0x4268, SWITCHTEC_GEN4),  //PAX 68XG4
+	SWITCHTEC_PCI_DEVICE(0x4252, SWITCHTEC_GEN4),  //PAX 52XG4
+	SWITCHTEC_PCI_DEVICE(0x4236, SWITCHTEC_GEN4),  //PAX 36XG4
+	SWITCHTEC_PCI_DEVICE(0x4228, SWITCHTEC_GEN4),  //PAX 28XG4
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
-- 
2.20.1

