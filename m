Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138C64566F6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 01:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhKSAmT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 19:42:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:14030 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhKSAmS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 19:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637282357; x=1668818357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FwuZhhp4fhdZnLhGdr72rngm2ShOni2FjFsYLx/ugMk=;
  b=SPG6b3ZGcwt33SjFkGnxm3jMzzQRM7j9CUwodwS1ptOecvFbQOkg93F6
   0HEhKIK7YAEA68563IuOd2zxpIhc97zVA/ZQeCN6JgFUGdvU//g1OrsYV
   fpKTvLP4PAKYIjy66ZgnoHGq6bv5a0mAEnR91LGsPfFuF63XYFcHnaVrp
   w4EQSZkcairMSUgXzBDX+oNmwvXuuCKFrTpl0VpXrY/yZX9H07nj2NREH
   IvjV3IP7c5AkkP3uwf6vBeZ57WvZ9pvy0zZKXNF2KI/WRUbsfJrrWtlgI
   vOP85jio1n97rCCIHZSws4OoWS+HibJvD6Xab/Lt6deC1T0573etC8p9M
   A==;
IronPort-SDR: w5kXz5sKMbRlFpDlh/7k6JBJI5PHE8Z1rA3nvsRvaYxachVeERNKSOUza/iUvoODkyM8P3oXPH
 6P8oABOM8a9C7xcfto8gwS3TjmzrVJVcGn4yjY0ap+d1HaIkA9DiBWzdll23pi+MDsXsAtYXI6
 0PXeDUU32YL8s36YmyBaN6c3zKr6MveS2VamPzsuXvvLj0fkNEkkONfpH+ZeuTXv5pNlgw7STi
 NnY9wiYn2dxU/5wlILJDebnijUGOo0XUE1r3Qs9/ejuorKl3wTtDus7VGLe2kcDCE6xCZTgJyC
 UMRzOyJQVwHkUo0fw0uJnfic
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="144456935"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2021 17:39:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 17:39:15 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 18 Nov 2021 17:39:15 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kelvin Cao <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 1/2] Add device IDs for the Gen4 automotive variants
Date:   Thu, 18 Nov 2021 16:38:02 -0800
Message-ID: <20211119003803.2333-2-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119003803.2333-1-kelvin.cao@microchip.com>
References: <20211119003803.2333-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Advertise support of the Gen4 automotive variants in module's device ID
table and add the same IDs to the list of switchtec quirks.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/pci/quirks.c           | 9 +++++++++
 drivers/pci/switch/switchtec.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c738d2..25ccb2994891 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5683,6 +5683,15 @@ SWITCHTEC_QUIRK(0x4268);  /* PAX 68XG4  */
 SWITCHTEC_QUIRK(0x4252);  /* PAX 52XG4  */
 SWITCHTEC_QUIRK(0x4236);  /* PAX 36XG4  */
 SWITCHTEC_QUIRK(0x4228);  /* PAX 28XG4  */
+SWITCHTEC_QUIRK(0x4352);  /* PFXA 52XG4 */
+SWITCHTEC_QUIRK(0x4336);  /* PFXA 36XG4 */
+SWITCHTEC_QUIRK(0x4328);  /* PFXA 28XG4 */
+SWITCHTEC_QUIRK(0x4452);  /* PSXA 52XG4 */
+SWITCHTEC_QUIRK(0x4436);  /* PSXA 36XG4 */
+SWITCHTEC_QUIRK(0x4428);  /* PSXA 28XG4 */
+SWITCHTEC_QUIRK(0x4552);  /* PAXA 52XG4 */
+SWITCHTEC_QUIRK(0x4536);  /* PAXA 36XG4 */
+SWITCHTEC_QUIRK(0x4528);  /* PAXA 28XG4 */
 
 /*
  * The PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints.
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 38c2b036fb8e..6e2d6c5ea4b5 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1779,6 +1779,15 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x4252, SWITCHTEC_GEN4),  //PAX 52XG4
 	SWITCHTEC_PCI_DEVICE(0x4236, SWITCHTEC_GEN4),  //PAX 36XG4
 	SWITCHTEC_PCI_DEVICE(0x4228, SWITCHTEC_GEN4),  //PAX 28XG4
+	SWITCHTEC_PCI_DEVICE(0x4352, SWITCHTEC_GEN4),  //PFXA 52XG4
+	SWITCHTEC_PCI_DEVICE(0x4336, SWITCHTEC_GEN4),  //PFXA 36XG4
+	SWITCHTEC_PCI_DEVICE(0x4328, SWITCHTEC_GEN4),  //PFXA 28XG4
+	SWITCHTEC_PCI_DEVICE(0x4452, SWITCHTEC_GEN4),  //PSXA 52XG4
+	SWITCHTEC_PCI_DEVICE(0x4436, SWITCHTEC_GEN4),  //PSXA 36XG4
+	SWITCHTEC_PCI_DEVICE(0x4428, SWITCHTEC_GEN4),  //PSXA 28XG4
+	SWITCHTEC_PCI_DEVICE(0x4552, SWITCHTEC_GEN4),  //PAXA 52XG4
+	SWITCHTEC_PCI_DEVICE(0x4536, SWITCHTEC_GEN4),  //PAXA 36XG4
+	SWITCHTEC_PCI_DEVICE(0x4528, SWITCHTEC_GEN4),  //PAXA 28XG4
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
-- 
2.25.1

