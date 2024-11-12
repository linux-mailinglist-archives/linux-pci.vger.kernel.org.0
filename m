Return-Path: <linux-pci+bounces-16508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32749C4F74
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17580B24E41
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BE01A727D;
	Tue, 12 Nov 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SxyEzqCi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65902849C;
	Tue, 12 Nov 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396773; cv=none; b=Y3rrDhEoUwk5WoZDT/26qxHYAib8eZWSrI9n2Fk1Lpz3HqOKyhTlJykm7GnO1wuagv+PNFZZ6fxNYioeeJaZOQryHIdRUlLTuOpWm2GdK8kwtS+9B1VQJFyhU+/gr2z9xRwEEJTBmCywuSRLNP8Aogin4Up7UB7g7A4pB7b1GoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396773; c=relaxed/simple;
	bh=RsESNqOlUc8V8/RTBTiJtNxNY+ozt41Sv0NXoEaWhVs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=byhlkCNdPKT+Nq7H4Tmhtq+NFyFezAIFBEueZYjWeIBSXyN96MZJlu/jN5C7tJ7P8216pwGegjQLf0XW2nxmuy5//BmmcMQN8J/G2hy1c9Zxc3mTDMGkKUtItwl2WZ7oKOdeITiIQvqUof4rozwhlRhyMSB5UPneB6CPidBRF0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SxyEzqCi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC2V4hQ026848;
	Mon, 11 Nov 2024 23:32:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=M2D0/VtKDqUpRog+5t5t5Dm
	Si0ECoMEow8bXhuzPCIA=; b=SxyEzqCiLj5X6uDxcgGg8nqKCTeAu03VsQrmC5V
	kfkYFsL2Qol8JP9XZ2ypB8eTo7VeQ+V9lQ10pwcWDOYI89TBOoJ1lLKAalGGSxvx
	0gFtPi98iEa+t51H+9JfyF9ktWwPd3kX/jFZSyS0qf9HCOOY5tnw2VumFZu/oRwK
	wDiFcuf51MQmTdmrYUYjTHuvw1GZAZ1WWbFaL3IP+FtvdUF9QfdBeidk3AvknHnj
	Id8lQ5hApakcIywd4h5LH4joNaVdyWzi7nOThBFvjQYuiFd1/V3G1vobfvA3CroG
	NiQjYR9go655tn2Syl6VAoqIP72nh2IlsjDN6xtzi7gdxKw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42uxa40dh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 23:32:31 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 23:32:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 23:32:30 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id DCF543F7079;
	Mon, 11 Nov 2024 23:32:29 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <lpieralisi@kernel.org>, <thomas.petazzoni@bootlin.com>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <salee@marvell.com>, <dingwei@marvell.com>,
        Jenishkumar Maheshbhai Patel
	<jpatel2@marvell.com>
Subject: [PATCH 1/1] PCI: armada8k: Fix bar assignment failure upon rescan
Date: Mon, 11 Nov 2024 23:32:27 -0800
Message-ID: <20241112073227.769814-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bC87ndm-7f21n9n3gngKeaoInBfMOENY
X-Proofpoint-ORIG-GUID: bC87ndm-7f21n9n3gngKeaoInBfMOENY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

When the attached device recovers the link from
an external reset, the following error might be
seen upon pci rescan.

On link-down event, it's not necessary to remove
the root bus. Only the child buses or devices
should be wiped off. However, the rescan operation
should be performed only when the link could be
retained. Otherwise, it should be done by a user
manually after the link is finally recovered.

~# echo 1 > /sys/bus/pci/rescan
[  322.857504] pci 0000:01:00.0: [177d:b200] type 00 class 0x028000
[  322.863682] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x007fffff 64bit pref]
[  322.871031] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x0fffffff 64bit pref]
[  322.878362] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x03ffffff 64bit pref]
[  322.886845] pci 0000:01:00.0: reg 0x244: [mem 0x00000000-0x000fffff 64bit pref]
[  322.894193] pci 0000:01:00.0: VF(n) BAR0 space: [mem 0x00000000-0x007fffff 64bit pref] (contains BAR0 for 8 VFs)
[  322.905154] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:00.0 (capable of 63.008 Gb/s with 8.0 GT/s PCIe x8 link)
[  322.921371] pcieport 0000:00:00.0: BAR 15: no space for [mem size 0x18000000 64bit pref]
[  322.929507] pcieport 0000:00:00.0: BAR 15: failed to assign [mem size 0x18000000 64bit pref]
[  322.937999] pcieport 0000:00:00.0: BAR 15: no space for [mem size 0x18000000 64bit pref]
[  322.946131] pcieport 0000:00:00.0: BAR 15: failed to assign [mem size 0x18000000 64bit pref]
[  322.954614] pci 0000:01:00.0: BAR 2: no space for [mem size 0x10000000 64bit pref]
[  322.962225] pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x10000000 64bit pref]
[  322.970193] pci 0000:01:00.0: BAR 4: no space for [mem size 0x04000000 64bit pref]
[  322.977804] pci 0000:01:00.0: BAR 4: failed to assign [mem size 0x04000000 64bit pref]
[  322.985766] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00800000 64bit pref]
[  322.993373] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00800000 64bit pref]
[  323.001331] pci 0000:01:00.0: BAR 7: no space for [mem size 0x00800000 64bit pref]
[  323.008938] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x00800000 64bit pref]
[  323.016903] pci 0000:01:00.0: BAR 2: no space for [mem size 0x10000000 64bit pref]
[  323.024511] pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x10000000 64bit pref]
[  323.032469] pci 0000:01:00.0: BAR 4: no space for [mem size 0x04000000 64bit pref]
[  323.040079] pci 0000:01:00.0: BAR 4: failed to assign [mem size 0x04000000 64bit pref]
[  323.048037] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00800000 64bit pref]
[  323.055644] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00800000 64bit pref]
[  323.063601] pci 0000:01:00.0: BAR 7: no space for [mem size 0x00800000 64bit pref]
[  323.071211] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x00800000 64bit pref]
[  323.081914] pcieport 0002:02:03.0: devices behind bridge are unusable because [bus 03] cannot be assigned for them
[  323.092384] pcieport 0002:02:07.0: devices behind bridge are unusable because [bus 04] cannot be assigned for them
[  323.102857] pcieport 0002:01:00.0: bridge has subordinate 02 but max busn 04

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index f9d6907900d1..ca2dedaa69a4 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -231,6 +231,7 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
 	struct dw_pcie_rp *pp = &pcie->pci->pp;
 	struct pci_bus *bus = pp->bridge->bus;
 	struct pci_dev *root_port;
+	struct pci_dev *child, *tmp;
 	int ret;
 
 	root_port = pci_get_slot(bus, 0);
@@ -239,7 +240,14 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
 		return;
 	}
 	pci_lock_rescan_remove();
-	pci_stop_and_remove_bus_device(root_port);
+
+	/* Remove all devices under root bus */
+	list_for_each_entry_safe(child, tmp,
+				 &root_port->subordinate->devices, bus_list) {
+		pci_stop_and_remove_bus_device(child);
+		dev_dbg(&child->dev, "removed\n");
+	}
+
 	/* Reset device if reset gpio is set */
 	if (pcie->reset_gpio) {
 		/* assert and then deassert the reset signal */
@@ -279,11 +287,12 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
 
 	/* Wait until the link becomes active again */
 	if (dw_pcie_wait_for_link(pcie->pci))
-		dev_err(pcie->pci->dev, "Link not up after reconfiguration\n");
+		goto fail;
+
+	dev_dbg(pcie->pci->dev, "%s: link has been recovered\n", __func__);
 
-	bus = NULL;
-	while ((bus = pci_find_next_bus(bus)) != NULL)
-		pci_rescan_bus(bus);
+	/* Rescan the root bus only if link is retained */
+	pci_rescan_bus(bus);
 
 fail:
 	pci_unlock_rescan_remove();
-- 
2.25.1


