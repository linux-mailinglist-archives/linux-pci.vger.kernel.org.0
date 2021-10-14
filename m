Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07D242D38E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 09:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhJNH2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 03:28:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:56343 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhJNH20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 03:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634196382; x=1665732382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X1a8UGdzQQhtEDv2nq1V9v/r5V0ijSfYG3NKu7KoekY=;
  b=rtQayLCK+pS+HEdHwsIh7sZuAz4SVZLPN12MtfdIC+GXFOAJpol47xhp
   M5M2YTmjRa/xig3Y8ZsWLCNr0UXSBNqzOeARf7hxB6o1lzVW1UAJIEs8o
   mEpODfihE6fz0oMDSbI+1ay15OtEh6e2JxeIznFmdQP0ShcucQe6xQxOL
   rGQqJhxiUtHGNXdCaHTUoUoNfUrQ3ZQwXdgtgMkKEOzMTGANpC+TpdOnc
   kGfvIJsseZtGDIID119Otc3IjX9Ayrp9QbWbE18ZV0/g+r8ACw35kt1tL
   aJDarUZ6dMwHpCSXDuogvYf3rivUN6yTI8UwPBbmCfyZ8DGyEs8++tdf+
   g==;
IronPort-SDR: xEzB5GJX8fP4hivAizfOzAipt5UgqDrV9BmGjtAjCXvW/NXwgtnYMhmHV76q73hgbgOz8Usv0p
 CMwp+abf4u9FXVZ7SYg5A3cEoCTRnBB4xrAQF2AvF28AoPsz41N8H5C/DjExGU9M56X2SqUn8v
 OOpJTRjI2lXD7+7KRCz498LZbkmVVqiwWfLFXvlnOq6HTF8vKhfTXiWmKidko9GJMzN3f0/LlG
 eTt2valLyXxtm1gtOxySnnNmL5LiZvdWTkiPyiVntm4ov/lthmNyd08PSxraaqJFTXZzmcjeuU
 J6W6KdGLmNqsh29JzO4aiFjy
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="148045650"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Oct 2021 00:26:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Oct 2021 00:26:22 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 14 Oct 2021 00:26:21 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH v2 5/5] PCI/switchtec: Add check of event support
Date:   Thu, 14 Oct 2021 14:18:59 +0000
Message-ID: <20211014141859.11444-6-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014141859.11444-1-kelvin.cao@microchip.com>
References: <20211014141859.11444-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

Not all events are supported by every gen/variant of the Switchtec
firmware. To solve this, since Gen4, a new bit in each event header
is introduced to indicate if an event is supported by the firmware.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/pci/switch/switchtec.c | 8 +++++++-
 include/linux/switchtec.h      | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 236cb40cc7c5..38c2b036fb8e 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1024,6 +1024,9 @@ static int event_ctl(struct switchtec_dev *stdev,
 		return PTR_ERR(reg);
 
 	hdr = ioread32(reg);
+	if (hdr & SWITCHTEC_EVENT_NOT_SUPP)
+		return -EOPNOTSUPP;
+
 	for (i = 0; i < ARRAY_SIZE(ctl->data); i++)
 		ctl->data[i] = ioread32(&reg[i + 1]);
 
@@ -1096,7 +1099,7 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
 			ctl.flags = event_flags;
 			ret = event_ctl(stdev, &ctl);
-			if (ret < 0)
+			if (ret < 0 && ret != -EOPNOTSUPP)
 				return ret;
 		}
 	} else {
@@ -1403,6 +1406,9 @@ static int mask_event(struct switchtec_dev *stdev, int eid, int idx)
 	hdr_reg = event_regs[eid].map_reg(stdev, off, idx);
 	hdr = ioread32(hdr_reg);
 
+	if (hdr & SWITCHTEC_EVENT_NOT_SUPP)
+		return 0;
+
 	if (!(hdr & SWITCHTEC_EVENT_OCCURRED && hdr & SWITCHTEC_EVENT_EN_IRQ))
 		return 0;
 
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 082f1d51957a..be24056ac00f 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -19,6 +19,7 @@
 #define SWITCHTEC_EVENT_EN_CLI   BIT(2)
 #define SWITCHTEC_EVENT_EN_IRQ   BIT(3)
 #define SWITCHTEC_EVENT_FATAL    BIT(4)
+#define SWITCHTEC_EVENT_NOT_SUPP BIT(31)
 
 #define SWITCHTEC_DMA_MRPC_EN	BIT(0)
 
-- 
2.25.1

