Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4463131836
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgAFTEH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:04:07 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54880 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgAFTDv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:51 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0005m8-NR; Mon, 06 Jan 2020 12:03:49 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0000eJ-HN; Mon, 06 Jan 2020 12:03:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:30 -0700
Message-Id: <20200106190337.2428-6-logang@deltatee.com>
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
Subject: [PATCH 05/12] PCI/switchtec: Move check event id from mask_event() to switchtec_event_isr()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wesley Sheng <wesley.sheng@microchip.com>

Event id check doesn't depend on anything in the mask_all_events()
to mask_event() path, doing it in switchtec_event_isr() would
avoid the CSR read in mask_event().

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 231499da2899..05d4cb49219b 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1180,10 +1180,6 @@ static int mask_event(struct switchtec_dev *stdev, int eid, int idx)
 	if (!(hdr & SWITCHTEC_EVENT_OCCURRED && hdr & SWITCHTEC_EVENT_EN_IRQ))
 		return 0;
 
-	if (eid == SWITCHTEC_IOCTL_EVENT_LINK_STATE ||
-	    eid == SWITCHTEC_IOCTL_EVENT_MRPC_COMP)
-		return 0;
-
 	dev_dbg(&stdev->dev, "%s: %d %d %x\n", __func__, eid, idx, hdr);
 	hdr &= ~(SWITCHTEC_EVENT_EN_IRQ | SWITCHTEC_EVENT_OCCURRED);
 	iowrite32(hdr, hdr_reg);
@@ -1230,8 +1226,13 @@ static irqreturn_t switchtec_event_isr(int irq, void *dev)
 
 	check_link_state_events(stdev);
 
-	for (eid = 0; eid < SWITCHTEC_IOCTL_MAX_EVENTS; eid++)
+	for (eid = 0; eid < SWITCHTEC_IOCTL_MAX_EVENTS; eid++) {
+		if (eid == SWITCHTEC_IOCTL_EVENT_LINK_STATE ||
+		    eid == SWITCHTEC_IOCTL_EVENT_MRPC_COMP)
+			continue;
+
 		event_count += mask_all_events(stdev, eid);
+	}
 
 	if (event_count) {
 		atomic_inc(&stdev->event_cnt);
-- 
2.20.1

