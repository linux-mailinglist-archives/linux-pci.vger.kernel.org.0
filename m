Return-Path: <linux-pci+bounces-9549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD75791ED89
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 05:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB241C21A97
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 03:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BE4182DA;
	Tue,  2 Jul 2024 03:57:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-5.us.a.mail.aliyun.com (out198-5.us.a.mail.aliyun.com [47.90.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C377801;
	Tue,  2 Jul 2024 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719892635; cv=none; b=gdnyvOm4ECQkzsHg5s8oEesH2lrcqL+jMuw82RPi17BAa8mApMkrw1t/aXvIqcK5P2if4LkIMpsUz9uM3cV/7FiWaYFdHX2+L2GqkZGmRSZ9KhM3R+XY2sm4oORyCDotgjWNsUrhl5SnlNLQ1Jrp/y5CcrqIyEhS8oZrmH65mgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719892635; c=relaxed/simple;
	bh=6L//tL6snjw3XG6uDl5X7hVQvPpkjw9I6A6kHOsg5kM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZyBnNHVBH5jkv2I1JGACTcrg3am+MNWtMOZy0/YLyXY1gE05NG1HkK9pL3AHpyPBDmDCqsZJh6mLAloXK1vl/57xeUH0scDv3uELVbK2UNNyCZY1m6aAIebaknOgTJ1tc2Gf5Yxe3BvZC8BzkhqB8FcwNhM4mUSUwGvHU6B/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=47.90.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1156118|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0117572-0.00035777-0.987885;FP=0|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037088118;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.YEnuEv._1719892611;
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.YEnuEv._1719892611)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 11:56:52 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lkp@intel.com,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	zhoushengqing@ttyinfo.com
Subject: [PATCH v4] Subject: PCI: Enable io space 1k granularity for intel cpu root port
Date: Tue,  2 Jul 2024 03:56:49 +0000
Message-Id: <20240702035649.26039-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701210656.GA16926@bhelgaas>
References: <20240701210656.GA16926@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch add 1k granularity for intel root port bridge. Intel latest
server CPU support 1K granularity, And there is an BIOS setup item named
"EN1K", but linux doesn't support it. if an IIO has 5 IOU (SPR has 5 IOUs)
all are bifurcated 2x8.In a 2P server system,There are 20 P2P bridges
present. if keep 4K granularity allocation,it need 20*4=80k io space,
exceeding 64k. I test it in a 16*nvidia 4090s system under intel eaglestrem
platform. There are six 4090s that cannot be allocated I/O resources.
So I applied this patch. And I found a similar implementation in quirks.c,
but it only targets the Intel P64H2 platform.

Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
---
 drivers/pci/quirks.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 568410e64ce6..f30083d51e15 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2562,6 +2562,36 @@ static void quirk_p64h2_1k_io(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1460, quirk_p64h2_1k_io);
 
+/* Enable 1k I/O space granularity on the intel root port */
+static void quirk_intel_rootport_1k_io(struct pci_dev *dev)
+{
+	struct pci_dev *d = NULL;
+	u16 en1k = 0;
+	struct pci_dev *root_port = pcie_find_root_port(dev);
+
+	if (!root_port)
+		return;
+
+	/*
+	 * Per intel sever CPU EDS vol2(register) spec,
+	 * Intel Memory Map/Intel VT-d configuration space,
+	 * IIO MISC Control (IIOMISCCTRL_1_5_0_CFG) — Offset 1C0h
+	 * bit 2.
+	 * Enable 1K (EN1K):
+	 * This bit when set, enables 1K granularity for I/O space decode
+	 * in each of the virtual P2P bridges
+	 * corresponding to root ports, and DMI ports.
+	 */
+	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
+		pci_read_config_word(d, 0x1c0, &en1k);
+		if (en1k & 0x4) {
+			pci_info(d, "INTEL: System should support 1k io window\n");
+			dev->io_window_1k = 1;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,	quirk_intel_rootport_1k_io);
+
 /*
  * Under some circumstances, AER is not linked with extended capabilities.
  * Force it to be linked by setting the corresponding control bit in the
-- 
2.39.2


