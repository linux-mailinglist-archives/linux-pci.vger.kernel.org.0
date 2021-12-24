Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C9747EA2A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 02:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350584AbhLXBZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 20:25:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25905 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245423AbhLXBZG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 20:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640309106; x=1671845106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2BLqHxCg2vluzkUWaKHLiNKiQukkKyvUGf/eBL4mwj8=;
  b=O00WXEGGaLK0Bpw+kaBLjTtbf9PwnizugYLfdUy6SYBPeBoBZm2Rm0G6
   p88ti7T6mkcRisPK5mqpdcz5GSQuEDeA0+XIG85cw6gJpIePNUctgVWdb
   kH4IqZloFgxkv3VSObP1DWaBzR1N33dl0VeoqK43pXZO2HlpIe9ISHCEJ
   waOj5SxjTHL1poH/Pey+ni06QO1plR0C++o+/AgvRyMGzadGX9it5Hyij
   qUolUKN+mZfTYg3xuc/RcPft7BInt1ehY8yeIrlVOYi22sGFGSncDE/iL
   q3JnaL84XeBpnv6QqgpDQ7KJPHqOH7fvJ0iLsNHT4qlb8jeYZABDK5r9D
   w==;
IronPort-SDR: tkmUnsOcxxdvBt4adn7HB+XcqbAS1YBFqrVt/Hvn2wi4vKQ4TQJDUHeTTyA8SB4SeH2pSCgBZE
 VLD6SW53cYsuUCdAOOajwy4heJS4q+gMfH93BXNj8ZrRB/RZOKJuhCVnZRGdVbiE4UAujNIkiL
 uw/DjOnLag+RyszPjpA1CK/ejOxFTmWhwNKJICDHYmDfg/JuBiVapkhKrM/f2GFZve7BEHWsOs
 uEwbTx3vup0WWhbUvQRjXYldrru7i+2shXTllw7on5lSx0aXMWsE9nJ1Cebw3ICdnBaEL8HDDF
 ACTu80ZalhPBb5UAhBp70p/v
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="80533977"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 18:25:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 18:25:05 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
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
Subject: [PATCH 2/6] ntb_hw_switchtec: Fix bug with more than 32 partitions
Date:   Thu, 23 Dec 2021 17:23:30 -0800
Message-ID: <20211224012334.89173-3-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224012334.89173-1-kelvin.cao@microchip.com>
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wesley Sheng <wesley.sheng@microchip.com>

Switchtec could support as mush as 48 partitions, but ffs & fls are
for 32 bit argument, in case of partition index larger than 31, the
current code could not parse the peer partition index correctly.
Change to the 64 bit version __ffs64 & fls64 accordingly to fix this
bug.

Fixes: 3df54c870f52 ("ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups")
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 6603c77c0a84..ec9cb6c81eda 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -840,7 +840,6 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 	u64 tpart_vec;
 	int self;
 	u64 part_map;
-	int bit;
 
 	sndev->ntb.pdev = sndev->stdev->pdev;
 	sndev->ntb.topo = NTB_TOPO_SWITCH;
@@ -861,29 +860,28 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 	part_map = ioread64(&sndev->mmio_ntb->ep_map);
 	part_map &= ~(1 << sndev->self_partition);
 
-	if (!ffs(tpart_vec)) {
+	if (!tpart_vec) {
 		if (sndev->stdev->partition_count != 2) {
 			dev_err(&sndev->stdev->dev,
 				"ntb target partition not defined\n");
 			return -ENODEV;
 		}
 
-		bit = ffs(part_map);
-		if (!bit) {
+		if (!part_map) {
 			dev_err(&sndev->stdev->dev,
 				"peer partition is not NT partition\n");
 			return -ENODEV;
 		}
 
-		sndev->peer_partition = bit - 1;
+		sndev->peer_partition = __ffs64(part_map);
 	} else {
-		if (ffs(tpart_vec) != fls(tpart_vec)) {
+		if (__ffs64(tpart_vec) != (fls64(tpart_vec) - 1)) {
 			dev_err(&sndev->stdev->dev,
 				"ntb driver only supports 1 pair of 1-1 ntb mapping\n");
 			return -ENODEV;
 		}
 
-		sndev->peer_partition = ffs(tpart_vec) - 1;
+		sndev->peer_partition = __ffs64(tpart_vec);
 		if (!(part_map & (1ULL << sndev->peer_partition))) {
 			dev_err(&sndev->stdev->dev,
 				"ntb target partition is not NT partition\n");
-- 
2.25.1

