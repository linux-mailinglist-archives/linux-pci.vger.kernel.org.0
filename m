Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4436D11
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFFHKB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 03:10:01 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:30692 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFHKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 03:10:00 -0400
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
   d="scan'208";a="36174409"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2019 00:09:59 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Jun 2019
 00:09:58 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Jun 2019
 00:09:58 -0700
Received: from NTB-Peer.microsemi.net (10.188.116.183) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Jun 2019 00:09:55 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 3/3] ntb_hw_switchtec: Fix setup MW with failure bug
Date:   Thu, 6 Jun 2019 15:09:44 +0800
Message-ID: <1559804984-24698-4-git-send-email-kelvin.cao@microchip.com>
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

Switchtec does not support setting multiple MWs simultaneously. The
driver takes a hardware lock to ensure that two peers are not doing this
simultaneously and it fails if someone else takes the lock. In most
cases, this is fine as clients only setup the MWs once on one side of
the link.

However, there's a race condition when a re-initialization is caused by
a link event. The driver will re-setup the shared memory window
asynchronously and this races with the client setting up it's memory
windows on the link up event.

To fix this we ensure do the entire initialization in a work queue and
signal the client once it's done.

Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 66 ++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 6cf15c18..fffff9a 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -95,7 +95,8 @@ struct switchtec_ntb {
 	bool link_is_up;
 	enum ntb_speed link_speed;
 	enum ntb_width link_width;
-	struct work_struct link_reinit_work;
+	struct work_struct check_link_status_work;
+	bool link_force_down;
 };
 
 static struct switchtec_ntb *ntb_sndev(struct ntb_dev *ntb)
@@ -494,33 +495,11 @@ enum switchtec_msg {
 
 static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev);
 
-static void link_reinit_work(struct work_struct *work)
-{
-	struct switchtec_ntb *sndev;
-
-	sndev = container_of(work, struct switchtec_ntb, link_reinit_work);
-
-	switchtec_ntb_reinit_peer(sndev);
-}
-
-static void switchtec_ntb_check_link(struct switchtec_ntb *sndev,
-				     enum switchtec_msg msg)
+static void switchtec_ntb_link_status_update(struct switchtec_ntb *sndev)
 {
 	int link_sta;
 	int old = sndev->link_is_up;
 
-	if (msg == MSG_LINK_FORCE_DOWN) {
-		schedule_work(&sndev->link_reinit_work);
-
-		if (sndev->link_is_up) {
-			sndev->link_is_up = 0;
-			ntb_link_event(&sndev->ntb);
-			dev_info(&sndev->stdev->dev, "ntb link forced down\n");
-		}
-
-		return;
-	}
-
 	link_sta = sndev->self_shared->link_sta;
 	if (link_sta) {
 		u64 peer = ioread64(&sndev->peer_shared->magic);
@@ -545,6 +524,38 @@ static void switchtec_ntb_check_link(struct switchtec_ntb *sndev,
 	}
 }
 
+static void check_link_status_work(struct work_struct *work)
+{
+	struct switchtec_ntb *sndev;
+
+	sndev = container_of(work, struct switchtec_ntb,
+			     check_link_status_work);
+
+	if (sndev->link_force_down) {
+		sndev->link_force_down = false;
+		switchtec_ntb_reinit_peer(sndev);
+
+		if (sndev->link_is_up) {
+			sndev->link_is_up = 0;
+			ntb_link_event(&sndev->ntb);
+			dev_info(&sndev->stdev->dev, "ntb link forced down\n");
+		}
+
+		return;
+	}
+
+	switchtec_ntb_link_status_update(sndev);
+}
+
+static void switchtec_ntb_check_link(struct switchtec_ntb *sndev,
+				      enum switchtec_msg msg)
+{
+	if (msg == MSG_LINK_FORCE_DOWN)
+		sndev->link_force_down = true;
+
+	schedule_work(&sndev->check_link_status_work);
+}
+
 static void switchtec_ntb_link_notification(struct switchtec_dev *stdev)
 {
 	struct switchtec_ntb *sndev = stdev->sndev;
@@ -577,7 +588,7 @@ static int switchtec_ntb_link_enable(struct ntb_dev *ntb,
 	sndev->self_shared->link_sta = 1;
 	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
 
-	switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
+	switchtec_ntb_link_status_update(sndev);
 
 	return 0;
 }
@@ -591,7 +602,7 @@ static int switchtec_ntb_link_disable(struct ntb_dev *ntb)
 	sndev->self_shared->link_sta = 0;
 	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_DOWN);
 
-	switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
+	switchtec_ntb_link_status_update(sndev);
 
 	return 0;
 }
@@ -844,7 +855,8 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 	sndev->ntb.topo = NTB_TOPO_SWITCH;
 	sndev->ntb.ops = &switchtec_ntb_ops;
 
-	INIT_WORK(&sndev->link_reinit_work, link_reinit_work);
+	INIT_WORK(&sndev->check_link_status_work, check_link_status_work);
+	sndev->link_force_down = false;
 
 	sndev->self_partition = sndev->stdev->partition;
 
-- 
2.7.4

