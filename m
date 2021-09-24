Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293C5416AC1
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 06:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244101AbhIXERe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 00:17:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17512 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244133AbhIXERb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 00:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632456958; x=1663992958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2k79zXBKe+geEQxWRKze+mGukdAFu5VeVYDnouJpkdg=;
  b=WNORyVp0ps4vQZ4iffeZc6MiflqNauVSqImTvaus0oq7RCyzzWH1VUyr
   auJuU7+sRd2WrI5w3fc8keuOZHIV9/jeZ1Td2NzvHvMCx33B/qcd3aWQ3
   uOo/mh+Snydddmj9MCiC1CJBUcMOZREnnVMRff1BoLDW5LqcJCue2CzzV
   NX6gACqrGwd+deipQqa7BFuX0ZzYNZ7xwtOnYfoljRelWo2FMh1MADKft
   jwbwNl+Kvb8c7Akk7aicTK0/ployY+ResNV7i1BIMtPCpQzJpn9OiSxDe
   CkU/7Yc0BRCopls2HUYt8h+mS88OveSYJ5nkBWgcnXphJsR+PKrfVaL9e
   Q==;
IronPort-SDR: Q8tyVuWjAyH0PqpRvy5Qo+NShe+sejcA9B9uTl47yFkfPFy/jSWzDyJxlPp1TS9ymlvvVsoiRj
 cA45xuo+OdrymoSVKT62n7FkWgWROLW+aZX4YQ1g9AUiSOPb6Ucn7aHCfb0rtq4FR+SmFfLrIy
 MTmiZP0tthR/5yn45lt5KKGYIlme8ZlnJGKjAnGUWSJHEnUPfRt/lGm4X8E2TajJ5/ALBiOhvV
 K/pcfwJw+lKfqbu20P2yDtRbdvogd/tdxPp9aEhaDJ9EjYd1ZwKYUhUu8n17dXI0ZfO7w/yN4K
 cCiWL+bBxSopsMFKWrRZ2/KT
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="70411614"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 21:15:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 21:15:54 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 23 Sep 2021 21:15:54 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 5/5] PCI/switchtec: Add check of event support
Date:   Fri, 24 Sep 2021 11:08:42 +0000
Message-ID: <20210924110842.6323-6-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924110842.6323-1-kelvin.cao@microchip.com>
References: <20210924110842.6323-1-kelvin.cao@microchip.com>
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
index 20cec2367084..739e063a6b85 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1016,6 +1016,9 @@ static int event_ctl(struct switchtec_dev *stdev,
 		return PTR_ERR(reg);
 
 	hdr = ioread32(reg);
+	if (hdr & SWITCHTEC_EVENT_NOT_SUPP)
+		return -EOPNOTSUPP;
+
 	for (i = 0; i < ARRAY_SIZE(ctl->data); i++)
 		ctl->data[i] = ioread32(&reg[i + 1]);
 
@@ -1088,7 +1091,7 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
 			ctl.flags = event_flags;
 			ret = event_ctl(stdev, &ctl);
-			if (ret < 0)
+			if (ret < 0 && ret != -EOPNOTSUPP)
 				return ret;
 		}
 	} else {
@@ -1395,6 +1398,9 @@ static int mask_event(struct switchtec_dev *stdev, int eid, int idx)
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

