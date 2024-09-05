Return-Path: <linux-pci+bounces-12802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F296CD96
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 06:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629111F27216
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 04:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574D714B06A;
	Thu,  5 Sep 2024 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NpoyBOQx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E3614BFB0;
	Thu,  5 Sep 2024 04:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509407; cv=none; b=PtrwS/GXZvoD2JayeC5fl8fPYaBXQSS4ItVpCEXXbVt4mH2pQe2zItl5deaUPRRgFOHuZE+CZL9tza3gJ3H4IBsSkMer2uAtMidMjV1Ij25fWos1wYKaTnmQW/koAoXDGtx5oC1Il6rWrso1GwwttN9qLc50En1Yr7pu7G8/Mfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509407; c=relaxed/simple;
	bh=G65og403rtSMdTteQVGCLcJapT90sVFDZwyL1ekh7NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccLTNWeKrSiGpV3rGvQY53CS+xY6j+sHOGbpD/pyacAcHaBSkEBs3FloHMWGcNzTijQSxuECgRTXv98ft+dcZrwfck0tHhnxwbE5sw1Uam4KhrDnCzmpUerXGHFMJ6vQ19bOi6CJiBR1hFBzJ2hOkMPD/LFDRA2HP3V4X6pJk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NpoyBOQx; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725509386;
	bh=Wvfr2Y6nFS6ZVKiutKRs2eU7/DfVbTdIA2yJgUR7wMQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NpoyBOQxqCjD9s8dGPMjCwXEOmMrGf63UHRvcd6LRoXZ2sYZ78QBBQay+J4Yr1RSp
	 TblAuGUR1rrr1MqA4nNJXeuh1ZbHNchjG/V1/ZT481zPMM0XQ7sGbpC/QlaV5xXqJ0
	 zbYSeiBFUhz64kv+lzTDEH846nh7GDrhVDfMzyeU=
X-QQ-mid: bizesmtp91t1725509363tnx67fe2
X-QQ-Originating-IP: jPbWgPxXdZG9YClnvv/RtHcDOKMmFYN1H9EF+2bSNno=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Sep 2024 12:09:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10599983041081818894
From: WangYuli <wangyuli@uniontech.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org,
	sergei.shtylyov@gmail.com,
	helgaas@kernel.org,
	yuzenghui@huawei.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Chen Baozi <chenbaozi@phytium.com.cn>,
	Wang Zhimin <wangzhimin1179@phytium.com.cn>,
	Chen Zhenhua <chenzhenhua@phytium.com.cn>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Subject: [PATCH v4] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium xHCI host
Date: Thu,  5 Sep 2024 12:09:16 +0800
Message-ID: <2C1FDC3BB34715BE+20240905040916.63199-1-wangyuli@uniontech.com>
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

The resume operation of Phytium Px210 xHCI host would failed
to restore state. Use the XHCI_RESET_ON_RESUME quirk to skip
it and reset the controller after resume.

Co-developed-by: Chen Baozi <chenbaozi@phytium.com.cn>
Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
Co-developed-by: Wang Zhimin <wangzhimin1179@phytium.com.cn>
Signed-off-by: Wang Zhimin <wangzhimin1179@phytium.com.cn>
Co-developed-by: Chen Zhenhua <chenzhenhua@phytium.com.cn>
Signed-off-by: Chen Zhenhua <chenzhenhua@phytium.com.cn>
Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Co-developed-by: Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Signed-off-by: Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
Changlog:
 *v1 -> v2: Move the PCI_VENDOR_ID_PHYTIUM form pci_ids.h to xhci-pci.c
  v2 -> v3: Change "||" to "&&", that was a mistake.
  v3 -> v4: Correct the commit-msg format.
---
 drivers/usb/host/xhci-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index b5705ed01d83..bfb8f0699475 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -55,6 +55,9 @@
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
 
+#define PCI_VENDOR_ID_PHYTIUM		0x1db7
+#define PCI_DEVICE_ID_PHYTIUM_XHCI			0xdc27
+
 /* Thunderbolt */
 #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
@@ -407,6 +410,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_VIA)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 
+	if (pdev->vendor == PCI_VENDOR_ID_PHYTIUM &&
+	    pdev->device == PCI_DEVICE_ID_PHYTIUM_XHCI)
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+
 	/* See https://bugzilla.kernel.org/show_bug.cgi?id=79511 */
 	if (pdev->vendor == PCI_VENDOR_ID_VIA &&
 			pdev->device == 0x3432)
-- 
2.43.4


