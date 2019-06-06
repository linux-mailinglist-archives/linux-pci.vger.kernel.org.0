Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21DD36D0F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 09:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfFFHJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 03:09:56 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:25148 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFHJ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 03:09:56 -0400
Received-SPF: SoftFail (esa6.microchip.iphmx.com: domain of
  kelvin.cao@microchip.com is inclined to not designate
  208.19.100.22 as permitted sender) identity=mailfrom;
  client-ip=208.19.100.22; receiver=esa6.microchip.iphmx.com;
  envelope-from="kelvin.cao@microchip.com";
  x-sender="kelvin.cao@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa6.microchip.iphmx.com;
  envelope-from="kelvin.cao@microchip.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=kelvin.cao@microchip.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,558,1557212400"; 
   d="scan'208";a="33318222"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2019 00:09:56 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Jun 2019
 00:09:55 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Jun 2019
 00:09:54 -0700
Received: from NTB-Peer.microsemi.net (10.188.116.183) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Jun 2019 00:09:52 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 2/3] ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window for crosslink case
Date:   Thu, 6 Jun 2019 15:09:43 +0800
Message-ID: <1559804984-24698-3-git-send-email-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
References: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wesley Sheng <wesley.sheng@microchip.com>

In case of NTB crosslink topology, the setting of shared memory window in
the virtual partition doesn't reset on peer's reboot. So skip the
unnecessary re-setup of shared memory window for that case.

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 947ed0b..6cf15c18 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1459,6 +1459,9 @@ static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev)
 {
 	int rc;
 
+	if (crosslink_is_enabled(sndev))
+		return 0;
+
 	dev_info(&sndev->stdev->dev, "reinitialize shared memory window\n");
 	rc = config_rsvd_lut_win(sndev, sndev->mmio_peer_ctrl, 0,
 				 sndev->self_partition,
-- 
2.7.4

