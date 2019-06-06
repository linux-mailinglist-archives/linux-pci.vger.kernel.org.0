Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C336D0D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 09:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfFFHJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 03:09:54 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:30682 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFHJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 03:09:53 -0400
Received-SPF: SoftFail (esa2.microchip.iphmx.com: domain of
  kelvin.cao@microchip.com is inclined to not designate
  208.19.100.22 as permitted sender) identity=mailfrom;
  client-ip=208.19.100.22; receiver=esa2.microchip.iphmx.com;
  envelope-from="kelvin.cao@microchip.com";
  x-sender="kelvin.cao@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa2.microchip.iphmx.com;
  envelope-from="kelvin.cao@microchip.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=kelvin.cao@microchip.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,558,1557212400"; 
   d="scan'208";a="36174407"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2019 00:09:52 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Jun 2019
 00:09:52 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Jun 2019
 00:09:51 -0700
Received: from NTB-Peer.microsemi.net (10.188.116.183) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Jun 2019 00:09:48 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 1/3] ntb_hw_switchtec: Remove redundant steps of switchtec_ntb_reinit_peer() function
Date:   Thu, 6 Jun 2019 15:09:42 +0800
Message-ID: <1559804984-24698-2-git-send-email-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
References: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joey Zhang <joey.zhang@microchip.com>

When a re-initialization is caused by a link event, the driver will
re-setup the shared memory window. But at that time, the shared memory
is still valid, and it's unnecessary to free, reallocate and then
initialize it again. We only need to reconfigure the hardware
registers. Remove the redundant steps from
switchtec_ntb_reinit_peer() function.

Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index d905d36..947ed0b 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1457,10 +1457,13 @@ static void switchtec_ntb_deinit_db_msg_irq(struct switchtec_ntb *sndev)
 
 static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev)
 {
-	dev_info(&sndev->stdev->dev, "peer reinitialized\n");
-	switchtec_ntb_deinit_shared_mw(sndev);
-	switchtec_ntb_init_mw(sndev);
-	return switchtec_ntb_init_shared_mw(sndev);
+	int rc;
+
+	dev_info(&sndev->stdev->dev, "reinitialize shared memory window\n");
+	rc = config_rsvd_lut_win(sndev, sndev->mmio_peer_ctrl, 0,
+				 sndev->self_partition,
+				 sndev->self_shared_dma);
+	return rc;
 }
 
 static int switchtec_ntb_add(struct device *dev,
-- 
2.7.4

