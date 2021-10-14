Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893F242D392
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 09:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJNH2d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 03:28:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11623 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhJNH22 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 03:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634196384; x=1665732384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+8mF3sqV2xOWK+dcpeuMZ3yH9s2tu4BY2TtKtFoCb+g=;
  b=ELiCCUZXiJLP0CpLsYy2QUmagGXmqzadt+7h7pTiRTuuWDxcOGiEMdph
   P60mDYHrO3tJ06HiBxM5pfxRQIs2wXp5iqseRTPgqr1ZCijzIbjhU81HC
   5w+O1jfZ1eonK+a0XcUdom7+ttIpPGJc+5TeSkZu/S0MpLk39t80L/bQ3
   OtNhHZoK4iKG3FTEhKhZ/G5Qw2rOVArMUzkGwf7UsczmIn6NNMXEuLhMR
   +0DVJ5eaQZIodD5GQMQeLNaHbR0GYZ2ABAPh3USHsaXj4IPuub/8j3lmT
   r4VfOPj5smyv6qG97i3WoZ11tNbCvp31cqJbgWDQ/yVXJfpjZh7tPJB2l
   A==;
IronPort-SDR: kxaBU1UUv4IAdGQSxlUc9Xu1UkxyhI95VmExwY5GMdONCPXx1Js/6opcT6u0TBwVYwyx4QOPyo
 0h12BoYKANAQRHnl12b3vUedWzK2y21dp578wdfb4gRoDpapuTh7vlKBxD9sXrEk2Hq68kwI5c
 trKdQtrV8lJAcwUjOWU6kseIgYs0++NNAdezUoFoRUIfVUNh9y9JPOJwe29HYrlAVjobHYOQo1
 v7lC38kFXvk8sMYqWApHPJe95DTBH00Gj0FtCOxBPawobkgCvzYhnQBO/ie+7hZBiQ3zwltCrt
 29z375kUJJLJ5Zi4/5BZtXhj
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="132951855"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Oct 2021 00:26:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Oct 2021 00:26:17 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 14 Oct 2021 00:26:17 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH v2 2/5] PCI/switchtec: Fix a MRPC error status handling issue
Date:   Thu, 14 Oct 2021 14:18:56 +0000
Message-ID: <20211014141859.11444-3-kelvin.cao@microchip.com>
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

If an error is encountered when executing a MRPC command, the firmware
will set the status register to SWITCHTEC_MRPC_STATUS_ERROR and return
the error code in the return value register.

Add handling of SWITCHTEC_MRPC_STATUS_ERROR on status register when
completing a MRPC command.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/pci/switch/switchtec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index e5bb2ac0e7bb..5c300ff3921d 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -238,7 +238,8 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
 	stuser_set_state(stuser, MRPC_DONE);
 	stuser->return_code = 0;
 
-	if (stuser->status != SWITCHTEC_MRPC_STATUS_DONE)
+	if (stuser->status != SWITCHTEC_MRPC_STATUS_DONE &&
+	    stuser->status != SWITCHTEC_MRPC_STATUS_ERROR)
 		goto out;
 
 	if (stdev->dma_mrpc)
@@ -622,7 +623,8 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
 out:
 	mutex_unlock(&stdev->mrpc_mutex);
 
-	if (stuser->status == SWITCHTEC_MRPC_STATUS_DONE)
+	if (stuser->status == SWITCHTEC_MRPC_STATUS_DONE ||
+	    stuser->status == SWITCHTEC_MRPC_STATUS_ERROR)
 		return size;
 	else if (stuser->status == SWITCHTEC_MRPC_STATUS_INTERRUPTED)
 		return -ENXIO;
-- 
2.25.1

