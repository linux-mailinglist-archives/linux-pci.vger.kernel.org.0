Return-Path: <linux-pci+bounces-9053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8FF911848
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 04:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F781C21DB3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 02:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08361537FF;
	Fri, 21 Jun 2024 02:06:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-44.us.a.mail.aliyun.com (out198-44.us.a.mail.aliyun.com [47.90.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B3259C;
	Fri, 21 Jun 2024 02:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935603; cv=none; b=GYZoD41v8QptubvFkrSrzH7GOmuVLS6qRVA0r+3GVYg2uef8Ecg3EArfbrgxx0d6W1tBNp9/VCZ75v12lOmcIBW02oV2xcoZQz3aVWoRLNSxIzKCAutjdUEg9Dz2bKi4R3Zqneyjpg7jEfGXhhq7glml61ukO2pOtCaByyNA+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935603; c=relaxed/simple;
	bh=/Fv5W48fTiOaQN8+0LAacCvmeX4j9L7ks9Fp1fUPZH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t0jKpOhyuHjKu37Ixguff4xsrBq6DHxf/OOtBsQOceXahyXKjQjmLQ72v030N6XMc0YOaSI8pfHdj3naFmvGSmmw5pageGN3vFQ8rG7jmFUoZgcAEOBDtFIJ29EdVf4sLCCCd1cXyj1pRLEncSwxP5drY1gIoRGY2rRYxhDcxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=47.90.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09405448|-1;BR=01201311R241S19rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0120384-0.0012689-0.986693;FP=0|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040120151;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Y6aXtYh_1718935577;
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.Y6aXtYh_1718935577)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 10:06:18 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: zhoushengqing@ttyinfo.com
Subject: [PATCH] PCI: Enable io space 1k granularity for intel cpu root port
Date: Fri, 21 Jun 2024 02:06:08 +0000
Message-Id: <20240621020608.28964-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch add 1k granularity for intel root port bridge.Intel latest
server CPU support 1K granularity,And there is an BIOS setup item named
"EN1K",but linux doesn't support it. if an IIO has 5 IOU (SPR has 5 IOUs)
all are bifurcated 2x8.In a 2P server system,There are 20 P2P bridges
present.if keep 4K granularity allocation,it need 20*4=80k io space,
exceeding 64k.I test it in a 16*nvidia 4090s system under intel eaglestrem
platform.There are six 4090s that cannot be allocated I/O resources.
So I applied this patch.And I found a similar implementation in quirks.c,
but it only targets the Intel P64H2 platform.

Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
---
 drivers/pci/probe.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5fbabb4e3425..3f0c901c6653 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -461,6 +461,8 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 	u32 buses;
 	u16 io;
 	u32 pmem, tmp;
+	u16 ven_id, dev_id;
+	u16 en1k = 0;
 	struct resource res;
 
 	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
@@ -478,6 +480,26 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 	}
 	if (io) {
 		bridge->io_window = 1;
+		if (pci_is_root_bus(bridge->bus)) {
+			list_for_each_entry(dev, &bridge->bus->devices, bus_list) {
+				pci_read_config_word(dev, PCI_VENDOR_ID, &ven_id);
+				pci_read_config_word(dev, PCI_DEVICE_ID, &dev_id);
+				if (ven_id == PCI_VENDOR_ID_INTEL && dev_id == 0x09a2) {
+					/*IIO MISC Control offset 0x1c0*/
+					pci_read_config_word(dev, 0x1c0, &en1k);
+				}
+			}
+		/*
+		 *Intel ICX SPR EMR GNR
+		 *IIO MISC Control (IIOMISCCTRL_1_5_0_CFG) — Offset 1C0h
+		 *bit 2:Enable 1K (EN1K)
+		 *This bit when set, enables 1K granularity for I/O space decode
+		 *in each of the virtual P2P bridges
+		 *corresponding to root ports, and DMI ports.
+		 */
+		if (en1k & 0x4)
+			bridge->io_window_1k = 1;
+		}
 		pci_read_bridge_io(bridge, &res, true);
 	}
 
-- 
2.39.2


