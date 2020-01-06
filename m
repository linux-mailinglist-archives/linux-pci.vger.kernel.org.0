Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A1131830
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgAFTDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:03:50 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54866 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbgAFTDt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:49 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0005m7-NM; Mon, 06 Jan 2020 12:03:48 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0000eG-EO; Mon, 06 Jan 2020 12:03:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:29 -0700
Message-Id: <20200106190337.2428-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200106190337.2428-1-logang@deltatee.com>
References: <20200106190337.2428-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, epilmore@gigaio.com, dmeyer@gigaio.com, Kelvin.Cao@microchip.com, wesley.sheng@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 04/12] PCI/switchtec: Remove redundant valid PFF number count
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wesley Sheng <wesley.sheng@microchip.com>

init_pff() function has already counted the valid PFF number, so there
is no requirement to count it again in ioctl_event_summary().

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 218e67428cf9..231499da2899 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -683,11 +683,7 @@ static int ioctl_event_summary(struct switchtec_dev *stdev,
 		s->part[i] = reg;
 	}
 
-	for (i = 0; i < SWITCHTEC_MAX_PFF_CSR; i++) {
-		reg = ioread16(&stdev->mmio_pff_csr[i].vendor_id);
-		if (reg != PCI_VENDOR_ID_MICROSEMI)
-			break;
-
+	for (i = 0; i < stdev->pff_csr_count; i++) {
 		reg = ioread32(&stdev->mmio_pff_csr[i].pff_event_summary);
 		s->pff[i] = reg;
 	}
@@ -1327,16 +1323,16 @@ static void init_pff(struct switchtec_dev *stdev)
 	stdev->pff_csr_count = i;
 
 	reg = ioread32(&pcfg->usp_pff_inst_id);
-	if (reg < SWITCHTEC_MAX_PFF_CSR)
+	if (reg < stdev->pff_csr_count)
 		stdev->pff_local[reg] = 1;
 
 	reg = ioread32(&pcfg->vep_pff_inst_id);
-	if (reg < SWITCHTEC_MAX_PFF_CSR)
+	if (reg < stdev->pff_csr_count)
 		stdev->pff_local[reg] = 1;
 
 	for (i = 0; i < ARRAY_SIZE(pcfg->dsp_pff_inst_id); i++) {
 		reg = ioread32(&pcfg->dsp_pff_inst_id[i]);
-		if (reg < SWITCHTEC_MAX_PFF_CSR)
+		if (reg < stdev->pff_csr_count)
 			stdev->pff_local[reg] = 1;
 	}
 }
-- 
2.20.1

