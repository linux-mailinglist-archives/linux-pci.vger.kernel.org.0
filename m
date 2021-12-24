Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135B347EA2F
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 02:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350615AbhLXBZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 20:25:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25905 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245480AbhLXBZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 20:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640309106; x=1671845106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mOv/6rLMt4SDkUiGk7Ojpht57PKBUSaOXxuqg25I/Y8=;
  b=Ip2ULqruoiifD3u5O739oWPACbDrykk6E6GEK+0K+2gNM5ejTdDIfdVZ
   mkIAwjWEA0yUOTJMK3KYTHKilfVPjJDfcF5OVuXNqRYYoAip9tIiiicIx
   3zPbA76JSCg8i1K/CyKOu6HZJc0KcIe4WNv2hp0GBC3ydCkz9a80vYctS
   5K3JJxSNJhILKBabjqU06N5mYg/pLqSFYzTUc1s5y5dvFPyykhkm61yJl
   YByhmzyoELas0mrf9QTK89o1afASXl6Spv3lD7fOFLqQWQrb+9KjWBwuy
   BARBe8HzuQbbYgMj0yitxXlV6bkgf9YamUPtRZwv9OIIbbQQSa9/3arMg
   Q==;
IronPort-SDR: ysZDHzWD+HTWkk4QhHD+2AZiNDoz70cbZgLM00YzXL6zfE0W/Np5w+Fm2Blhg/igh/GXs5YknS
 vuekBw6nEkAf+H++NZjThqOxibeLCxnzrPFdfumrVUFDJrMNNE9zLMv1boIY0M6WkNwfrzYxqq
 pcDQGYAoIg0dvt//4Rc5G8+jLlCYk3eTBfFl35xF2zdS3c00IG9T97HfvNPsjxenz2goLPwo7G
 E8nBCf+M2RpV0yUJ3UQF0+Zo9PTa8aPrI5iDgBQhipXsu1Vc4ogqVQ9CVRhXW0Okpu81JC6WXG
 FFpf/Ci7ibqyvnJdy0E+9ZC1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="80533979"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 18:25:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 18:25:05 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 18:25:05 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-ntb@googlegroups.com>, <linux-kernel@vger.kernel.org>
CC:     Kelvin Cao <kelvin.cao@microchip.com>, <kelvincao@outlook.com>,
        "Jeremy Pallotta" <jmpallotta@gmail.com>
Subject: [PATCH 3/6] ntb_hw_switchtec: AND with the part_map for a valid tpart_vec
Date:   Thu, 23 Dec 2021 17:23:31 -0800
Message-ID: <20211224012334.89173-4-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224012334.89173-1-kelvin.cao@microchip.com>
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jeremy Pallotta <jmpallotta@gmail.com>

Some firmware versions return 1 in the target partition vector for
undefined partitions. AND with the part_map to give a valid tpart_vec.

Signed-off-by: Jeremy Pallotta <jmpallotta@gmail.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index ec9cb6c81eda..25302a384a7d 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -858,6 +858,7 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 	tpart_vec |= ioread32(&sndev->mmio_ntb->ntp_info[self].target_part_low);
 
 	part_map = ioread64(&sndev->mmio_ntb->ep_map);
+	tpart_vec &= part_map;
 	part_map &= ~(1 << sndev->self_partition);
 
 	if (!tpart_vec) {
-- 
2.25.1

