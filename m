Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA26AF21B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2019 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfIJT65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Sep 2019 15:58:57 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34618 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbfIJT65 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Sep 2019 15:58:57 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i7mHu-00037R-Av; Tue, 10 Sep 2019 13:58:55 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i7mHt-00011V-GF; Tue, 10 Sep 2019 13:58:53 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kelvin Cao <Kelvin.Cao@microchip.com>
Date:   Tue, 10 Sep 2019 13:58:33 -0600
Message-Id: <20190910195833.3891-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, logang@deltatee.com, dmeyer@gigaio.com, bhelgaas@google.com, Kelvin.Cao@microchip.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH] PCI/switchtec: read all 64bits of part_event_bitmap
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The part_event_bitmap register is 64 bits wide and should be read with
ioread64 instead of the 32-bit ioread32.

Reported-by: Doug Meyer <dmeyer@gigaio.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kelvin Cao <Kelvin.Cao@microchip.com>
---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 8c94cd3fd1f2..465d6afd826e 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -675,7 +675,7 @@ static int ioctl_event_summary(struct switchtec_dev *stdev,
 		return -ENOMEM;
 
 	s->global = ioread32(&stdev->mmio_sw_event->global_summary);
-	s->part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
+	s->part_bitmap = ioread64(&stdev->mmio_sw_event->part_event_bitmap);
 	s->local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
 
 	for (i = 0; i < stdev->partition_count; i++) {
-- 
2.20.1

