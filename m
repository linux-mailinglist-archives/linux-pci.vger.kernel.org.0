Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19646DC26
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 20:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhLHT2n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 14:28:43 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36876 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhLHT2m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 14:28:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DD60FCE2333;
        Wed,  8 Dec 2021 19:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEC4C00446;
        Wed,  8 Dec 2021 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638991507;
        bh=8vyuFB78UlBf9oj4qyNlqvw2Y5owe7cuGBLG7rfajMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2nxT0QF017bQkv7nttdePTZG8VfptmRW46a+ahpbY9wSlBob6LLX68ybWJBBcDbd
         OJDglUuwPRGBUdcLcgQy/7h77Lz7mem+S02SbK1Oh25j+QeDsrAMSBQ9oDhKFKUpTY
         OuKrUFI7H7GOpOmpiXoqz4BP81+sB7Q5tIo6k6IExkocm6xLwa4bhyXdplnVmDfROP
         5pfhGWujUV7/ia92KW6ECo6Wzic2uctjCoIaVGHCIYhf99b+Tj0n30+sBNgXezVywx
         PeJMyIWuUAvSPf9rv7X3kX+/yubC3tKTr0D5HXlW1Ijl4IZfdCtbbmLNrhNRMAt2+7
         1efdkxI97dmFg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 2/4] mtip32xx: remove pointless drvdata lookups
Date:   Wed,  8 Dec 2021 13:24:47 -0600
Message-Id: <20211208192449.146076-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208192449.146076-1-helgaas@kernel.org>
References: <20211208192449.146076-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we passed a struct pci_dev * to mtip_check_surprise_removal(),
which immediately looked up the driver_data.  But all callers already have
the driver_data pointer, so just pass it directly and skip the extra
lookup.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 8677ac4c3431..894020aaaaeb 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -136,16 +136,15 @@ struct mtip_compat_ide_task_request_s {
  * return value
  *	 true if device removed, else false
  */
-static bool mtip_check_surprise_removal(struct pci_dev *pdev)
+static bool mtip_check_surprise_removal(struct driver_data *dd)
 {
 	u16 vendor_id = 0;
-	struct driver_data *dd = pci_get_drvdata(pdev);
 
 	if (dd->sr)
 		return true;
 
        /* Read the vendorID from the configuration space */
-	pci_read_config_word(pdev, 0x00, &vendor_id);
+	pci_read_config_word(dd->pdev, 0x00, &vendor_id);
 	if (vendor_id == 0xFFFF) {
 		dd->sr = true;
 		if (dd->queue)
@@ -447,7 +446,7 @@ static int mtip_device_reset(struct driver_data *dd)
 {
 	int rv = 0;
 
-	if (mtip_check_surprise_removal(dd->pdev))
+	if (mtip_check_surprise_removal(dd))
 		return 0;
 
 	if (mtip_hba_reset(dd) < 0)
@@ -727,7 +726,7 @@ static inline void mtip_process_errors(struct driver_data *dd, u32 port_stat)
 		dev_warn(&dd->pdev->dev,
 			"Port stat errors %x unhandled\n",
 			(port_stat & ~PORT_IRQ_HANDLED));
-		if (mtip_check_surprise_removal(dd->pdev))
+		if (mtip_check_surprise_removal(dd))
 			return;
 	}
 	if (likely(port_stat & (PORT_IRQ_TF_ERR | PORT_IRQ_IF_ERR))) {
@@ -752,7 +751,7 @@ static inline irqreturn_t mtip_handle_irq(struct driver_data *data)
 		/* Acknowledge the interrupt status on the port.*/
 		port_stat = readl(port->mmio + PORT_IRQ_STAT);
 		if (unlikely(port_stat == 0xFFFFFFFF)) {
-			mtip_check_surprise_removal(dd->pdev);
+			mtip_check_surprise_removal(dd);
 			return IRQ_HANDLED;
 		}
 		writel(port_stat, port->mmio + PORT_IRQ_STAT);
@@ -796,7 +795,7 @@ static inline irqreturn_t mtip_handle_irq(struct driver_data *data)
 		}
 
 		if (unlikely(port_stat & PORT_IRQ_ERR)) {
-			if (unlikely(mtip_check_surprise_removal(dd->pdev))) {
+			if (unlikely(mtip_check_surprise_removal(dd))) {
 				/* don't proceed further */
 				return IRQ_HANDLED;
 			}
@@ -915,7 +914,7 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
 
 		msleep(100);
 
-		if (mtip_check_surprise_removal(port->dd->pdev))
+		if (mtip_check_surprise_removal(port->dd))
 			goto err_fault;
 
 		active = mtip_commands_active(port);
@@ -980,7 +979,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		return -EFAULT;
 	}
 
-	if (mtip_check_surprise_removal(dd->pdev))
+	if (mtip_check_surprise_removal(dd))
 		return -EFAULT;
 
 	rq = blk_mq_alloc_request(dd->queue, REQ_OP_DRV_IN, BLK_MQ_REQ_RESERVED);
@@ -1022,7 +1021,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 				fis->command, int_cmd->status);
 		rv = -EIO;
 
-		if (mtip_check_surprise_removal(dd->pdev) ||
+		if (mtip_check_surprise_removal(dd) ||
 			test_bit(MTIP_DDF_REMOVE_PENDING_BIT,
 					&dd->dd_flag)) {
 			dev_err(&dd->pdev->dev,
@@ -2513,7 +2512,7 @@ static int mtip_ftl_rebuild_poll(struct driver_data *dd)
 		if (unlikely(test_bit(MTIP_DDF_REMOVE_PENDING_BIT,
 				&dd->dd_flag)))
 			return -EFAULT;
-		if (mtip_check_surprise_removal(dd->pdev))
+		if (mtip_check_surprise_removal(dd))
 			return -EFAULT;
 
 		if (mtip_get_identify(dd->port, NULL) < 0)
@@ -2891,7 +2890,7 @@ static int mtip_hw_init(struct driver_data *dd)
 		 time_before(jiffies, timeout)) {
 		mdelay(100);
 	}
-	if (unlikely(mtip_check_surprise_removal(dd->pdev))) {
+	if (unlikely(mtip_check_surprise_removal(dd))) {
 		timetaken = jiffies - timetaken;
 		dev_warn(&dd->pdev->dev,
 			"Surprise removal detected at %u ms\n",
@@ -4098,7 +4097,7 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 	list_add(&dd->remove_list, &removing_list);
 	spin_unlock_irqrestore(&dev_lock, flags);
 
-	mtip_check_surprise_removal(pdev);
+	mtip_check_surprise_removal(dd);
 	synchronize_irq(dd->pdev->irq);
 
 	/* Spin until workers are done */
-- 
2.25.1

