Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3327A131826
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgAFTDp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:03:45 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54812 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbgAFTDo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:44 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXfA-0005mT-Ds; Mon, 06 Jan 2020 12:03:43 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXfA-0000ee-8O; Mon, 06 Jan 2020 12:03:40 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:37 -0700
Message-Id: <20200106190337.2428-13-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200106190337.2428-1-logang@deltatee.com>
References: <20200106190337.2428-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Kelvin.Cao@microchip.com, epilmore@gigaio.com, dmeyer@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 12/12] PCI: Apply switchtec DMA aliasing quirk to GEN4 devices
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add GEN4 device IDs for quirk_switchtec_ntb_dma_alias().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

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
-- 
2.20.1

