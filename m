Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B696F416AB9
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 06:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbhIXERW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 00:17:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17497 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhIXERW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 00:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632456949; x=1663992949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Irgi2+TJMQerZX7EqkPUuDWs1A7MVoqrPiYuyiRsMys=;
  b=rUqnFtMB/Zppw+qKAGthWARTU8ijcpBSKjN4PZOl8p9WNTJvA9k8NE4d
   kEXVifHu8VL8Es0wPXe9IJNG0tSeJmaCZJ+sDOMoP7081exFrXhTihsw7
   E9WkynrzNdDVly4MFpYrdZyWJC9+wKcEJmo6BWajlxGLTdZ7YuF+lZR2x
   VWE1i1YmudnvT0w9NnIKRRMKnTK0z9133g/O5fpbtnfVpOIjs3l44X6/N
   Fc9ZP3gTVYlPt14yximE4KXQe6DlOfWR/nMMyQlH1xKYahdoXMIbl+TFO
   Mzi9SvONJ6kf5FflxvXpseLchjNGzJKJSpJ3tUeJkMDfht36a2obuEThd
   g==;
IronPort-SDR: 7vdSxeWexCzp11lnwozW0HzV34fU91gbXGihiTjXL6sSzRQgedlOnaeKC8hwHkxDlIb6IEupQ4
 /0DstvOdWgN/N2vug+2i+RSj8QwIwYHsvSCKqIezcw4Zgy694FdPWgq405AGH6dczLdTrqHAaP
 fqS0PBNWUfxNr3WHWr8GLPaGH5/ULbMTQZETOE1Jo2dVpUuB8usDYmxw4w/Znd2M5hot+bmsur
 XYoqFVzwcHDYDcMULHi9YOXUJdNNrWCJ7EF9j/I8rM/HNRoW5YWvYAATVH0WoH7BTLpdXNewht
 4hX++wF3wv0HgEq51+Fvwu1R
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="70411604"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 21:15:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 21:15:48 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 23 Sep 2021 21:15:48 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS access
Date:   Fri, 24 Sep 2021 11:08:38 +0000
Message-ID: <20210924110842.6323-2-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924110842.6323-1-kelvin.cao@microchip.com>
References: <20210924110842.6323-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

After a firmware hard reset, MRPC command executions, which are based
on the PCI BAR (which Microchip refers to as GAS) read/write, will hang
indefinitely. This is because after a reset, the host will fail all GAS
reads (get all 1s), in which case the driver won't get a valid MRPC
status.

Add a read check to GAS access when a MRPC command execution doesn't
response timely, error out if the check fails.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/pci/switch/switchtec.c | 59 ++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 0b301f8be9ed..092653487021 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -45,6 +45,7 @@ enum mrpc_state {
 	MRPC_QUEUED,
 	MRPC_RUNNING,
 	MRPC_DONE,
+	MRPC_IO_ERROR,
 };
 
 struct switchtec_user {
@@ -66,6 +67,13 @@ struct switchtec_user {
 	int event_cnt;
 };
 
+static int check_access(struct switchtec_dev *stdev)
+{
+	u32 device = ioread32(&stdev->mmio_sys_info->device_id);
+
+	return stdev->pdev->device == device;
+}
+
 static struct switchtec_user *stuser_create(struct switchtec_dev *stdev)
 {
 	struct switchtec_user *stuser;
@@ -113,6 +121,7 @@ static void stuser_set_state(struct switchtec_user *stuser,
 		[MRPC_QUEUED] = "QUEUED",
 		[MRPC_RUNNING] = "RUNNING",
 		[MRPC_DONE] = "DONE",
+		[MRPC_IO_ERROR] = "IO_ERROR",
 	};
 
 	stuser->state = state;
@@ -184,6 +193,21 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
 	return 0;
 }
 
+static void mrpc_cleanup_cmd(struct switchtec_dev *stdev)
+{
+	/* requires the mrpc_mutex to already be held when called */
+	struct switchtec_user *stuser = list_entry(stdev->mrpc_queue.next,
+						   struct switchtec_user, list);
+
+	stuser->cmd_done = true;
+	wake_up_interruptible(&stuser->cmd_comp);
+	list_del_init(&stuser->list);
+	stuser_put(stuser);
+	stdev->mrpc_busy = 0;
+
+	mrpc_cmd_submit(stdev);
+}
+
 static void mrpc_complete_cmd(struct switchtec_dev *stdev)
 {
 	/* requires the mrpc_mutex to already be held when called */
@@ -223,13 +247,7 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
 		memcpy_fromio(stuser->data, &stdev->mmio_mrpc->output_data,
 			      stuser->read_len);
 out:
-	stuser->cmd_done = true;
-	wake_up_interruptible(&stuser->cmd_comp);
-	list_del_init(&stuser->list);
-	stuser_put(stuser);
-	stdev->mrpc_busy = 0;
-
-	mrpc_cmd_submit(stdev);
+	mrpc_cleanup_cmd(stdev);
 }
 
 static void mrpc_event_work(struct work_struct *work)
@@ -246,6 +264,23 @@ static void mrpc_event_work(struct work_struct *work)
 	mutex_unlock(&stdev->mrpc_mutex);
 }
 
+static void mrpc_error_complete_cmd(struct switchtec_dev *stdev)
+{
+	/* requires the mrpc_mutex to already be held when called */
+
+	struct switchtec_user *stuser;
+
+	if (list_empty(&stdev->mrpc_queue))
+		return;
+
+	stuser = list_entry(stdev->mrpc_queue.next,
+			    struct switchtec_user, list);
+
+	stuser_set_state(stuser, MRPC_IO_ERROR);
+
+	mrpc_cleanup_cmd(stdev);
+}
+
 static void mrpc_timeout_work(struct work_struct *work)
 {
 	struct switchtec_dev *stdev;
@@ -257,6 +292,11 @@ static void mrpc_timeout_work(struct work_struct *work)
 
 	mutex_lock(&stdev->mrpc_mutex);
 
+	if (!check_access(stdev)) {
+		mrpc_error_complete_cmd(stdev);
+		goto out;
+	}
+
 	if (stdev->dma_mrpc)
 		status = stdev->dma_mrpc->status;
 	else
@@ -544,6 +584,11 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
 	if (rc)
 		return rc;
 
+	if (stuser->state == MRPC_IO_ERROR) {
+		mutex_unlock(&stdev->mrpc_mutex);
+		return -EIO;
+	}
+
 	if (stuser->state != MRPC_DONE) {
 		mutex_unlock(&stdev->mrpc_mutex);
 		return -EBADE;
-- 
2.25.1

