Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6D2C72A9
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 23:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgK1VuO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 16:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733296AbgK1SRx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Nov 2020 13:17:53 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFDCC0258DE;
        Sat, 28 Nov 2020 07:49:04 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s63so6698201pgc.8;
        Sat, 28 Nov 2020 07:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkZK75RDOqVvghIzMCSRWV8KKsXjayA5613tB1J4VCY=;
        b=cecqxIdtNnXvYHZvKvSn+cJXABfzKkTd/GDrzvYRbiHDb1BP6cgaR7272scbX2PZDc
         s66qMOjTi5VEweErH+bMB1Pj8cjOqt25SzDMIlrVeGTpanXxTB5mJgNvRvPP694wmVss
         qg7iiVp+pUApFLXHQwv4ryBbj9qKQwxt/B8Z+e/KKQJxs3lXn3gQEn07+vDXsFiGTPRI
         sRjHUmIRtEsC4mMUdZka+dgHGh7mVTPLsE/NLNEKybr2y6OnxMm7mTlJssmKQdqfRox5
         oUdKAHsRIFzpD9vvII/060Sr2DeTQWOkGcNTyRCT8+AluWdxESQb3hETpkyh4XtkWtyE
         HKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkZK75RDOqVvghIzMCSRWV8KKsXjayA5613tB1J4VCY=;
        b=LixzY83ScElPUx+fjFaxjrup9IhUOmaxEe548wMseQA0+zhSbcsM0CzBBokWa2RsOR
         F9JyflgUFAtIn8z3rjJwd0XQMOpGrxz25VSP+NBdvhp/9M5Iq9av8Y7uFTgK345i675B
         /9mjqgK+K7tQ8kcA7aeWLhWvSSZtPplLF1AGKftRfCjJhX+YKPs+JsH4qZds+Lsh+5s5
         X6uambP2skDksGmrQVveKhEGRexFRQ4DrGjkjcFFse7NR/zycdv1TJ4fgSYQKGZrSj19
         EcWdaQ6zkO6RWhd8bHCwmTC796o5eFIexF2Y8yg95moyP4kgLHNg1ogEVrOpv3EDreIZ
         VahQ==
X-Gm-Message-State: AOAM531DlqC2hk5o+ZeY/C1sflW1kjmrVw3V9lSaTosqlC3Q2QSrD7WA
        YOzBz1m/21SrLgxSH4XGvKQ=
X-Google-Smtp-Source: ABdhPJxmSOateiAz2GwhjpxS1UWqa0G3kgwj0mii+pRLrVC3xY7iiTOsznBLTadT7na7xjXeVwo86w==
X-Received: by 2002:a17:90b:19cf:: with SMTP id nm15mr15844023pjb.63.1606578543746;
        Sat, 28 Nov 2020 07:49:03 -0800 (PST)
Received: from localhost.localdomain ([161.81.68.216])
        by smtp.gmail.com with ESMTPSA id r15sm15633028pjp.51.2020.11.28.07.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 07:49:03 -0800 (PST)
From:   Tom Yan <tom.ty89@gmail.com>
To:     hdegoede@redhat.com, hch@lst.de, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     mathias.nyman@intel.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH 1/2] uas: revert from scsi_add_host_with_dma() to scsi_add_host()
Date:   Sat, 28 Nov 2020 23:48:48 +0800
Message-Id: <20201128154849.3193-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
References: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Apparently the former (with the chosen dma_dev) may cause problem in certain
case (e.g. where thunderbolt dock and intel iommu are involved). The error
observed was:

XHCI swiotlb buffer is full / DMAR: Device bounce map failed

For now we retain the clamp for hw_max_sectors against the dma_max_mapping_size.
Since the device/size for the clamp that is applied when the scsi request queue
is initialized/allocated is different than the one used here, we invalidate the
early clamping by making a fallback blk_queue_max_hw_sectors() call.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 drivers/usb/storage/uas.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index c8a577309e8f..5db1325cea20 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -843,18 +843,21 @@ static int uas_slave_alloc(struct scsi_device *sdev)
 static int uas_slave_configure(struct scsi_device *sdev)
 {
 	struct uas_dev_info *devinfo = sdev->hostdata;
-	struct device *dev = sdev->host->dma_dev;
+	struct usb_device *udev = devinfo->udev;
 
 	if (devinfo->flags & US_FL_MAX_SECTORS_64)
 		blk_queue_max_hw_sectors(sdev->request_queue, 64);
 	else if (devinfo->flags & US_FL_MAX_SECTORS_240)
 		blk_queue_max_hw_sectors(sdev->request_queue, 240);
-	else if (devinfo->udev->speed >= USB_SPEED_SUPER)
+	else if (udev->speed >= USB_SPEED_SUPER)
 		blk_queue_max_hw_sectors(sdev->request_queue, 2048);
+	else
+		blk_queue_max_hw_sectors(sdev->request_queue,
+					 SCSI_DEFAULT_MAX_SECTORS);
 
 	blk_queue_max_hw_sectors(sdev->request_queue,
 		min_t(size_t, queue_max_hw_sectors(sdev->request_queue),
-		      dma_max_mapping_size(dev) >> SECTOR_SHIFT));
+		      dma_max_mapping_size(udev->bus->sysdev) >> SECTOR_SHIFT));
 
 	if (devinfo->flags & US_FL_NO_REPORT_OPCODES)
 		sdev->no_report_opcodes = 1;
@@ -1040,7 +1043,7 @@ static int uas_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	shost->can_queue = devinfo->qdepth - 2;
 
 	usb_set_intfdata(intf, shost);
-	result = scsi_add_host_with_dma(shost, &intf->dev, udev->bus->sysdev);
+	result = scsi_add_host(shost, &intf->dev);
 	if (result)
 		goto free_streams;
 
-- 
2.29.2

