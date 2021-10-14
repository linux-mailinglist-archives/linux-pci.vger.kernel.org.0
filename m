Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7A42D390
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 09:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJNH2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 03:28:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11631 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhJNH20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 03:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634196382; x=1665732382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UHmw1kryPDsjtcU9cCkAUSQxb8CTwQU7xtusCYKyOf0=;
  b=wtD7m8fXgUmx8kT6StjcC6/ZgyFDZ3TlaqGE/dFTd9UPdWXIA7KuzCiP
   GwgL/deuOe0HRAeTv/D5g6QZ/RdvFKeZF+gbQops1RTwOJQ67pyBXFhB9
   BGFu1YVoezM9n0smase/YVjXQqm7fC9rIMtmeZOfzaE2JB0JDFgd93P19
   08l98gMnM/KrQ4H79PxaTd91IK5AcgUN0qSmCCxoAzNtoOfPHY88euKBW
   3/ajScFr/YE1NKgv2huoGhS1Q7wrUocllbsMlOo2aaNtJhPQNNnrUwpPH
   JJVFDIlV8ltfCrDf1lkiOC0jPSaDu91QHwCXDH4X0tkU0t0VEnszJUJxF
   w==;
IronPort-SDR: kUXduQDh71AsmlXSw10ttDqJWkuTj1VxqXStCY8lfNqMPDme6RxmpDiEeEy5r4X17PXZ9BxORh
 8dx6w2lFpJw9BSsRC4xvwx3FrKanz4WX0bR9Vu9L2U+LHNSeF8E5U/GYSZoijpbytAHx7Khk/i
 tGJwoSxRRH3rhvGuRxkXs1Z2sbd7xws8xMCJ570a/xKNel1aMLSYW9YvKY74S69uL9601LNKfs
 q2/OyFQ7vQXQiOYU5PTd48/NcBEzLsnp2muC8DbE86rja5ZAx72ERvBkbJmxxIi+Rnap5m9mtZ
 AL2f0bg7uNiZq6baQkIEVY+1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="132951847"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Oct 2021 00:26:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Oct 2021 00:26:15 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 14 Oct 2021 00:26:15 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH v2 1/5] PCI/switchtec: Error out MRPC execution when MMIO reads fail
Date:   Thu, 14 Oct 2021 14:18:55 +0000
Message-ID: <20211014141859.11444-2-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014141859.11444-1-kelvin.cao@microchip.com>
References: <20211014141859.11444-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

A firmware hard reset may be initiated by various mechanisms including a
UART interface, TWI sideband interface from BMC, MRPC command from
userspace, etc. The switchtec management driver is unaware of these
resets.

The reset clears PCI state including the BARs and Memory Space Enable
bits, so the device no longer responds to the MMIO accesses the driver
uses to operate it.

MMIO reads to the device will fail with a PCIe error. When the root
complex handles that error, it typically fabricates ~0 data to complete
the CPU read.

Check for this sort of error by reading the device ID from MMIO space.
This ID can never be ~0, so if we see that value, it probably means the
PCIe Memory Read failed and we should return an error indication to the
application using the switchtec driver.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/pci/switch/switchtec.c | 67 ++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 0b301f8be9ed..e5bb2ac0e7bb 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -45,6 +45,7 @@ enum mrpc_state {
 	MRPC_QUEUED,
 	MRPC_RUNNING,
 	MRPC_DONE,
+	MRPC_IO_ERROR,
 };
 
 struct switchtec_user {
@@ -66,6 +67,19 @@ struct switchtec_user {
 	int event_cnt;
 };
 
+/*
+ * The MMIO reads to the device_id register should always return the device ID
+ * of the device, otherwise the firmware is probably stuck or unreachable
+ * due to a firmware reset which clears PCI state including the BARs and Memory
+ * Space Enable bits.
+ */
+static int is_firmware_running(struct switchtec_dev *stdev)
+{
+	u32 device = ioread32(&stdev->mmio_sys_info->device_id);
+
+	return stdev->pdev->device == device;
+}
+
 static struct switchtec_user *stuser_create(struct switchtec_dev *stdev)
 {
 	struct switchtec_user *stuser;
@@ -113,6 +127,7 @@ static void stuser_set_state(struct switchtec_user *stuser,
 		[MRPC_QUEUED] = "QUEUED",
 		[MRPC_RUNNING] = "RUNNING",
 		[MRPC_DONE] = "DONE",
+		[MRPC_IO_ERROR] = "IO_ERROR",
 	};
 
 	stuser->state = state;
@@ -184,9 +199,26 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
 	return 0;
 }
 
+static void mrpc_cleanup_cmd(struct switchtec_dev *stdev)
+{
+	/* requires the mrpc_mutex to already be held when called */
+
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
+
 	struct switchtec_user *stuser;
 
 	if (list_empty(&stdev->mrpc_queue))
@@ -223,13 +255,7 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
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
@@ -246,6 +272,23 @@ static void mrpc_event_work(struct work_struct *work)
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
@@ -257,6 +300,11 @@ static void mrpc_timeout_work(struct work_struct *work)
 
 	mutex_lock(&stdev->mrpc_mutex);
 
+	if (!is_firmware_running(stdev)) {
+		mrpc_error_complete_cmd(stdev);
+		goto out;
+	}
+
 	if (stdev->dma_mrpc)
 		status = stdev->dma_mrpc->status;
 	else
@@ -544,6 +592,11 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
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

