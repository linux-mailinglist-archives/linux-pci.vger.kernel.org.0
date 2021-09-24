Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A6416ABB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 06:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbhIXERY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 00:17:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17497 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbhIXERX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 00:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632456951; x=1663992951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gwi5VXcZto8n90lhV0i2U8ud4d67Xh9Y2IfSACApWno=;
  b=fLKK7UyU8qUs4m0gm73VzZyp9pgMWh+Z0/t6XuKN7mXzo0/O+QHwNYQH
   84iWXYAXT8MdJwi+5OrrTh7AY3Y0FEcrG0PabgQRMzCyh2zpD6JpAd0oT
   VnzM+/xmIsceWYqNupPvM5cZaSHRJevOYwW66FbBYehxUAZNm4c+KrBEx
   Tc1zOva1uf2mzq7GgcfDV+Ldf9LkPKXwSzptcxJzjE9cBb+t4q0RvnNsa
   ax+iAOzD1LhcKcUKlLH/XpsW35OQbAm9FCb9Rkjk0NS8T3KWZpHnMcufn
   jN/HAbWecHQ9NT31b08LDjJQA7XhfJOUxRIYZDM2xycCF83MeuPlergw3
   A==;
IronPort-SDR: DwNtpqt56ARR2HoloGqTG/3R/cBHzp11YvLvtZ8xJS1baa46bl3RMT/qumCgx40t9/77So7JeW
 uDEXwwCBxQhRgyjxNwzh7aWSFp3SKzMWQ4T1lgp6JLU/ukrtaYe8gj/A9DXiQIIzc0bdiHuvlJ
 RZCzseKHNSTaGHW0posbhKH4ADe3zp6Gd5rTZXhuswmFGf9TuUW6psxql3XZ7nOPrj7R4cPteG
 CzDCs22iIbxrxv1jvFqr5d+4SNpZDzQ0gzFthgMDKxyDkEkn2D8FJrsPb1mpaqCTeudAvAh5S8
 IMj+qHcGs/j8HsH1mtuGHl/S
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="70411605"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 21:15:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 21:15:50 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 23 Sep 2021 21:15:50 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 2/5] PCI/switchtec: Fix a MRPC error status handling issue
Date:   Fri, 24 Sep 2021 11:08:39 +0000
Message-ID: <20210924110842.6323-3-kelvin.cao@microchip.com>
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
index 092653487021..76f14ed15445 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -230,7 +230,8 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
 	stuser_set_state(stuser, MRPC_DONE);
 	stuser->return_code = 0;
 
-	if (stuser->status != SWITCHTEC_MRPC_STATUS_DONE)
+	if (stuser->status != SWITCHTEC_MRPC_STATUS_DONE &&
+	    stuser->status != SWITCHTEC_MRPC_STATUS_ERROR)
 		goto out;
 
 	if (stdev->dma_mrpc)
@@ -614,7 +615,8 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
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

