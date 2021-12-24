Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D775F47EA25
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 02:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245419AbhLXBZG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 20:25:06 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25905 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245155AbhLXBZF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 20:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640309105; x=1671845105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uCi+C9tPaKaYR8lDF/Giqd8tc3Ab1VRUKhQG4JCdYUI=;
  b=xxSc2qfy0VUbfm50QeGGiK7TGGkb+j5dDE5KRI8oSgYrlm35WFWO6v8M
   pvqFuevG4gBvFGG1y+uxsBltE5iX8jyzvf20Xy8ezpXnWqpknjZONGckt
   p8AxUukM929Rxl2k6XHkwJK185tXBYWhYzDIuytPIA/Fc35bhHfT8i9I+
   dP8+o9VDVqqJ5aLa2o0QKaxBo9lUQQAeU3yeWJueRs8Ydw89pzTfe1lp5
   9+GNxTJiplX3T0AYjJPnqyhXdLaGbQFagamjiMfqfTJIlnSwJA2WX+Woq
   d802/HOU3B3h11Uxy5FAj99KR/gFMUOZnaskm7Drttw7u8lSKxDMrXCbw
   Q==;
IronPort-SDR: NInssDyEZuda0SohtKiYqIbKSJxtQsHjvBkPXHYsWFoxUXUTXKO7xp3FBVvRpUMc118EK9OnpD
 5pRZ3nzPJdjQj6LWKhlWR77WAUsGX3hDXQcAQ1sUQPQfyun2JIH/XjI8NVfdymhPP27SjbuW8l
 V8vGSULTuB5TtGaWwcx/HE/AotwBx1yJdvcpYRzSn7+RjAnlHcTzmMCZfa2QM/iUDWDySdswSw
 PvVEUIUxq5G4X7gfGgjeAnhyiQfpBkufGhwkpgFKIPOP7nF9hKwf9w/i+uQiNDJZfsR5hePu9y
 l4nCeW1Eh+tXlrD103l3wBQJ
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="80533969"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 18:25:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 18:25:04 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 18:25:04 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-ntb@googlegroups.com>, <linux-kernel@vger.kernel.org>
CC:     Kelvin Cao <kelvin.cao@microchip.com>, <kelvincao@outlook.com>,
        "Jeremy Pallotta" <jmpallotta@gmail.com>
Subject: [PATCH 1/6] ntb_hw_switchtec: Fix pff ioread to read into mmio_part_cfg_all
Date:   Thu, 23 Dec 2021 17:23:29 -0800
Message-ID: <20211224012334.89173-2-kelvin.cao@microchip.com>
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

Array mmio_part_cfg_all holds the partition configuration of all
partitions, with partition number as index. Fix this by reading into
mmio_part_cfg_all for pff.

Fixes: 0ee28f26f378 ("NTB: switchtec_ntb: Add link management")
Signed-off-by: Jeremy Pallotta <jmpallotta@gmail.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 4c6eb61a6ac6..6603c77c0a84 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -419,8 +419,8 @@ static void switchtec_ntb_part_link_speed(struct switchtec_ntb *sndev,
 					  enum ntb_width *width)
 {
 	struct switchtec_dev *stdev = sndev->stdev;
-
-	u32 pff = ioread32(&stdev->mmio_part_cfg[partition].vep_pff_inst_id);
+	u32 pff =
+		ioread32(&stdev->mmio_part_cfg_all[partition].vep_pff_inst_id);
 	u32 linksta = ioread32(&stdev->mmio_pff_csr[pff].pci_cap_region[13]);
 
 	if (speed)
-- 
2.25.1

