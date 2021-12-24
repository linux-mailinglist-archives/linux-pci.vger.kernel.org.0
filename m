Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B04447EA32
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 02:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244989AbhLXBZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 20:25:10 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25922 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350539AbhLXBZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 20:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640309107; x=1671845107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4sdPVIs9Jjw3pyvV0CLKiGsbnFQZVkRWh8tbvb+iRnc=;
  b=crbdQUHvWAI8cr+hpwSreG8h/yId1EPcpHzKSC6OpRrOtrRsu3BZxOFc
   5Dj/QG1FZVSoQKVXD1vLTDaN5u5mmN4tMLkfENHuhpTmRnc3UVCugjuhP
   QYklOETNJ/l0Byfb5Ze/nlK2iIChVNgLsBpt/TTYyD++2mZAYXvo67Mqv
   qAKVeO3rpfr8N68dCXhZlRz0e9Mtud+BrnhAlXszZx9YSJlEo4eDUZdBa
   UdD5Wm/G00lfR58UXTp+QzZ2Z23fecHH0tJzsiLAb1capPHCBo/egnYUu
   AIrTeouH1wnghY0tmDKFkq7QbmIWNRJbb8IQmg0F+D/KWsFvXvvBDiNLa
   w==;
IronPort-SDR: FQW/+CiLjkhFTMpKv8M6lhxcIk3BBZYBoUdh49L2V/A8xvkDc7QNRN2+MZVg4/krJI4VQD4ges
 Md+7wdDfLu/1jAsDtVxfJlt61i3xSJTsHpdUS7oDNUtvEZlk4LQSFdf0iOBOPw56auV7Nd1vy0
 B8In17ZvJEdae0gMChY1E5s7sEavTb8T08pVOBLwtRZtQA3QRYp6FNguV88pnaHuBnL5+TPoDu
 tEefVHptu6wVkQeS5aLul9ftON7iGggF4QVSHLFbt+QvBEy4Buh8ne+H71x/U7iA3a8y25IDON
 5axLB/e4mO88C7547szHl8GT
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="80533980"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 18:25:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 18:25:06 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 18:25:06 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-ntb@googlegroups.com>, <linux-kernel@vger.kernel.org>
CC:     Kelvin Cao <kelvin.cao@microchip.com>, <kelvincao@outlook.com>,
        "Jeremy Pallotta" <jmpallotta@gmail.com>
Subject: [PATCH 4/6] ntb_hw_switchtec: Update the way of getting VEP instance ID
Date:   Thu, 23 Dec 2021 17:23:32 -0800
Message-ID: <20211224012334.89173-5-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224012334.89173-1-kelvin.cao@microchip.com>
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gen4 firmware adds DMA VEP and NVMe VEP support in VEP (virtual EP)
instance ID register in addtion to management EP. Update the way of
getting management VEP instance ID.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 25302a384a7d..03839346233d 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -419,8 +419,10 @@ static void switchtec_ntb_part_link_speed(struct switchtec_ntb *sndev,
 					  enum ntb_width *width)
 {
 	struct switchtec_dev *stdev = sndev->stdev;
-	u32 pff =
-		ioread32(&stdev->mmio_part_cfg_all[partition].vep_pff_inst_id);
+	struct part_cfg_regs __iomem *part_cfg =
+		&stdev->mmio_part_cfg_all[partition];
+
+	u32 pff = ioread32(&part_cfg->vep_pff_inst_id) & 0xFF;
 	u32 linksta = ioread32(&stdev->mmio_pff_csr[pff].pci_cap_region[13]);
 
 	if (speed)
@@ -1089,7 +1091,7 @@ static int crosslink_enum_partition(struct switchtec_ntb *sndev,
 {
 	struct part_cfg_regs __iomem *part_cfg =
 		&sndev->stdev->mmio_part_cfg_all[sndev->peer_partition];
-	u32 pff = ioread32(&part_cfg->vep_pff_inst_id);
+	u32 pff = ioread32(&part_cfg->vep_pff_inst_id) & 0xFF;
 	struct pff_csr_regs __iomem *mmio_pff =
 		&sndev->stdev->mmio_pff_csr[pff];
 	const u64 bar_space = 0x1000000000LL;
-- 
2.25.1

