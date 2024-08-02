Return-Path: <linux-pci+bounces-11195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 888089461A7
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 18:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D84DB25393
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081E51A83B6;
	Fri,  2 Aug 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="k5ayIbUi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67C166F2E;
	Fri,  2 Aug 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615250; cv=none; b=cqqL1JfeLvOjBw+vRrM4u3nsJ4aSRQ2WdNvEeJUayxF9ArZLFoHbuYPFyoxJfg7ShifZwiPoX3UMBA10vbsH00cAv2kfobSJRQ6kbYGCfxf/RTrgl4XOGXRxLszN5avU27O1PfNhJLGIChyDAnpI7nU22NSWUljYkGqN+qIqiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615250; c=relaxed/simple;
	bh=7sCSXjk0kKxYzaCMC+RgwACo41h3WnpDWPFDeNoutj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chtn7RghEQXqBTcMJyPWlwlx5ueWDfp/Gjxya3GCZ881NmhybrTu7EZWBpWxKzGihnczjVveA8Q6s9D3Emf0i6BV58EQI/06Jh1vhTNNcSnQ5CvMFi0gYpxNkz1QmwJiQ+Ml0zj8K+VRo36+sWYY7nCB8u67zJqnO03Yng5M5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=k5ayIbUi; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1722615115;
	bh=o7kEQYLQyljSLraqYcnSwcOesk1zWEYaqOjNpRLHXHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=k5ayIbUiyu6YMZ5jJLCuzsxYDpBaNiDAYROweR9M57GybXQBe3AqVjDqhU+r7DmYe
	 nbmbeYhzNcV+L6mBLA8qXIfFrC7qi0pt7DyRAJIRPFqlVWRV0u2FuNlITDBmds6yyQ
	 JvtQRBj7UR6gRVKWFGzvvbkMa/1e9+zuOX3gocPw=
X-QQ-mid: bizesmtp82t1722615092tz25dnlq
X-QQ-Originating-IP: WJS9rCXdtSElBMKBt8/rhaRnoONKese1XrFEBESY2FM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 03 Aug 2024 00:11:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12327301821540536056
From: WangYuli <wangyuli@uniontech.com>
To: bhelgaas@google.com,
	siyuli@glenfly.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	linux@horizon.com,
	pat-lkml@erley.org,
	alex.williamson@redhat.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] PCI: Add function 0 DMA alias quirk for Glenfly arise chip
Date: Sat,  3 Aug 2024 00:11:09 +0800
Message-ID: <DB918DA5CBA08DE8+20240802161109.240191-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Add DMA support for audio function of Glenfly arise chip,
which uses request id of function 0.

Signed-off-by: SiyuLi <siyuli@glenfly.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/pci/quirks.c    | 6 ++++++
 include/linux/pci_ids.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2ce4e08edf5..a6cb8b314fae 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4246,6 +4246,12 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe832, quirk_dma_func0_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
 
+/*
+ * Some Glenfly chips use function 0 as the PCIe requester ID for DMA too.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, PCI_DEVICE_ID_GLENFLY_ARISE10C0_AUDIO, quirk_dma_func0_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, PCI_DEVICE_ID_GLENFLY_ARISE1020_AUDIO, quirk_dma_func0_alias);
+
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e388c8b1cbc2..35d2314cc433 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1654,6 +1654,10 @@
 #define PCI_DEVICE_ID_RICOH_R5C832	0x0832
 #define PCI_DEVICE_ID_RICOH_R5C843	0x0843
 
+#define PCI_VENDOR_ID_GLENFLY	    0x6766
+#define PCI_DEVICE_ID_GLENFLY_ARISE10C0_AUDIO	 0x3D40
+#define PCI_DEVICE_ID_GLENFLY_ARISE1020_AUDIO	 0x3D41
+
 #define PCI_VENDOR_ID_DLINK		0x1186
 #define PCI_DEVICE_ID_DLINK_DGE510T	0x4c00
 
-- 
2.43.4


