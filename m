Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF844131827
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgAFTDp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:03:45 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54806 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFTDn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:43 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXfA-0005mR-AS; Mon, 06 Jan 2020 12:03:42 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXfA-0000eb-4t; Mon, 06 Jan 2020 12:03:40 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:36 -0700
Message-Id: <20200106190337.2428-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200106190337.2428-1-logang@deltatee.com>
References: <20200106190337.2428-1-logang@deltatee.com>
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
Subject: [PATCH 11/12] PCI/switchtec: Introduce gen4 variant IDS in the device ID table
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

Now that GEN4 is properly supported, advertise support in the module's
device ID table.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
[logang@deltatee.com: add commit message]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 990e0ee32f7b..db240b70fbdd 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1691,6 +1691,24 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
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

