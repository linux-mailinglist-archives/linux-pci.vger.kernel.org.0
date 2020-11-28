Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138892C72A7
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 23:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbgK1VuO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 16:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733298AbgK1SR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Nov 2020 13:17:58 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583AC0258E3;
        Sat, 28 Nov 2020 07:49:07 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so7091854pfu.1;
        Sat, 28 Nov 2020 07:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbAVYycY6YOfQw07HUrLEWpQeZLRTY8vh8sqwjHNiYY=;
        b=DtROul4bAe96EerB/u5UR8/qYs4S5tUL/0CAxmjLJHQNZu7mtMPSnynDuIWhq7jz6M
         MEpzCCOV5BDoML+9aa4z8ZDgQVrrVZIq6A8S+inZtG2XWw4AF5dHQ+iwbSjZRo2HMtw8
         kNw52H7bxje5MRPxTo/J1uOUaCGhIN/Xekmn0Eg6XeDKOM5U98+tlsGv7RmwbVoaGc2n
         OovuXXNsucrO5GEQxA2bGRyfo0SoTyir4sLw9QrJTxcHNsyRsayfhr30k22vxg7NTle6
         kI3Mmh0bkUc1wrwFaBWvbRfJS/eF2q7EjrDdWk0cojd6jDhcGZVWRqaXrua0iT+AwAah
         IKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbAVYycY6YOfQw07HUrLEWpQeZLRTY8vh8sqwjHNiYY=;
        b=pHmxm4GNnfs8alFm/TurbqONhVx5U7bl6/bLUJlU630HxXHFlgm1sf1LQqPd5uHvsw
         /2uy1JfE8cfPntEkSWv/pfsCnPOqWxCePnbQQTeX8hdt8gUOqnQGnXica5y4UJWAF4pt
         7yS0qf53Lq9pcne8CTyrQg2borV91Pmj5ZHqfJcunS0fV58FbnSBjeAfaWesEW10/XkJ
         ujtFV1/H1KO3xhxgYziIMJ4YURDy7qZtO5D10JQ7tLxNT2FZrfbr6ZPGUIUN3ZHAwCM6
         P8Kn5auFlf6TwhpqVc8dFN4LYsKOa33SFCo57kameDbzrgFCVt4+mc7e3HeWBsV2VjLf
         lpew==
X-Gm-Message-State: AOAM531q0jMeBTZLK5yeNLyI1n+5HlK8gO0tXVvJIO0590Xjc7h1H2dK
        5giUPlbKjby5UBTMAdI/h30=
X-Google-Smtp-Source: ABdhPJyqCBQR8A2d6dk1sHRfwPArNMLZS2bh0nKxDeJ2+RQ3RuWqznNT1xQ4Bg05XoqYbGq8pU3+SQ==
X-Received: by 2002:a17:90a:bc83:: with SMTP id x3mr16905963pjr.90.1606578547558;
        Sat, 28 Nov 2020 07:49:07 -0800 (PST)
Received: from localhost.localdomain ([161.81.68.216])
        by smtp.gmail.com with ESMTPSA id r15sm15633028pjp.51.2020.11.28.07.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 07:49:06 -0800 (PST)
From:   Tom Yan <tom.ty89@gmail.com>
To:     hdegoede@redhat.com, hch@lst.de, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     mathias.nyman@intel.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH 2/2] usb-storage: revert from scsi_add_host_with_dma() to scsi_add_host()
Date:   Sat, 28 Nov 2020 23:48:49 +0800
Message-Id: <20201128154849.3193-2-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128154849.3193-1-tom.ty89@gmail.com>
References: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
 <20201128154849.3193-1-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While the change only seemed to have caused issue on uas drives, we
probably want to avoid it in the usb-storage driver as well, until
we are sure it is the right thing to do.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 drivers/usb/storage/scsiglue.c | 40 +++++++++++++++++-----------------
 drivers/usb/storage/usb.c      |  3 +--
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 560efd1479ba..6539bae1c188 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -92,7 +92,7 @@ static int slave_alloc (struct scsi_device *sdev)
 static int slave_configure(struct scsi_device *sdev)
 {
 	struct us_data *us = host_to_us(sdev->host);
-	struct device *dev = sdev->host->dma_dev;
+	struct device *dev = us->pusb_dev->bus->sysdev;
 
 	/*
 	 * Many devices have trouble transferring more than 32KB at a time,
@@ -120,6 +120,25 @@ static int slave_configure(struct scsi_device *sdev)
 		 * better throughput on most devices.
 		 */
 		blk_queue_max_hw_sectors(sdev->request_queue, 2048);
+	} else {
+		/*
+		 * Limit the total size of a transfer to 120 KB.
+		 *
+		 * Some devices are known to choke with anything larger. It seems like
+		 * the problem stems from the fact that original IDE controllers had
+		 * only an 8-bit register to hold the number of sectors in one transfer
+		 * and even those couldn't handle a full 256 sectors.
+		 *
+		 * Because we want to make sure we interoperate with as many devices as
+		 * possible, we will maintain a 240 sector transfer size limit for USB
+		 * Mass Storage devices.
+		 *
+		 * Tests show that other operating have similar limits with Microsoft
+		 * Windows 7 limiting transfers to 128 sectors for both USB2 and USB3
+		 * and Apple Mac OS X 10.11 limiting transfers to 256 sectors for USB2
+		 * and 2048 for USB3 devices.
+		 */
+		blk_queue_max_hw_sectors(sdev->request_queue, 240);
 	}
 
 	/*
@@ -627,25 +646,6 @@ static const struct scsi_host_template usb_stor_host_template = {
 	.sg_tablesize =			SG_MAX_SEGMENTS,
 
 
-	/*
-	 * Limit the total size of a transfer to 120 KB.
-	 *
-	 * Some devices are known to choke with anything larger. It seems like
-	 * the problem stems from the fact that original IDE controllers had
-	 * only an 8-bit register to hold the number of sectors in one transfer
-	 * and even those couldn't handle a full 256 sectors.
-	 *
-	 * Because we want to make sure we interoperate with as many devices as
-	 * possible, we will maintain a 240 sector transfer size limit for USB
-	 * Mass Storage devices.
-	 *
-	 * Tests show that other operating have similar limits with Microsoft
-	 * Windows 7 limiting transfers to 128 sectors for both USB2 and USB3
-	 * and Apple Mac OS X 10.11 limiting transfers to 256 sectors for USB2
-	 * and 2048 for USB3 devices.
-	 */
-	.max_sectors =                  240,
-
 	/* emulated HBA */
 	.emulated =			1,
 
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index c2ef367cf257..f177da4ff1bc 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -1050,8 +1050,7 @@ int usb_stor_probe2(struct us_data *us)
 	usb_autopm_get_interface_no_resume(us->pusb_intf);
 	snprintf(us->scsi_name, sizeof(us->scsi_name), "usb-storage %s",
 					dev_name(dev));
-	result = scsi_add_host_with_dma(us_to_host(us), dev,
-					us->pusb_dev->bus->sysdev);
+	result = scsi_add_host(us_to_host(us), dev);
 	if (result) {
 		dev_warn(dev,
 				"Unable to add the scsi host\n");
-- 
2.29.2

