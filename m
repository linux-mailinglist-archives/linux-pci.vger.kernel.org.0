Return-Path: <linux-pci+bounces-12409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77BA963D04
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CC71F2259A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC51891CF;
	Thu, 29 Aug 2024 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="doZP7xNs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD09189BBD;
	Thu, 29 Aug 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916628; cv=none; b=UqVsoMW32IGPx9vF6dl/a164j0Yj36rA69w4eoG7lbEfqe4S6KGGD1vbbBWwKslRgNilx+j8xgFtUqHaMRF5uzXTCyU1nBzj/m9y+wZpWLLfGacoemcokS9KbB/pDUjaiW29Jk3wTPAgE2zHkFl0doldHWkGVMNrXp+RXtM2nDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916628; c=relaxed/simple;
	bh=LyEMVh4RLCp2HjxapIF7Tq+5ikLws1y4KEPU3klkGN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCiFqjvIBr48CzNTBjYFoogy9KbOtDkPo9aDOhX9xjueXfqvALyb0IrI1i2M1OWnlbP+NWFGkK9VfLY4u+EHH7wBIoCFwft0EgR+R5me3L03QLFnNk1heW0BwCN/NtWIK33+22L6CE5bGyOdaO2zghA1C+ars9aV8ikoW9z7s3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=doZP7xNs; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1724916614;
	bh=dAJ8ztKTv9lIJL1qRsZJt5YWdjQ1q7wv2JIz9gJfdcI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=doZP7xNsVsFUD/UtQm6RFYSF/pTMW0qzh/4k2vUxAM9I86i18/z4ZOgR4B+g67NgZ
	 cL2LuwmpnOqQ19aDtPmAP0l3L7Tu4AWnu+MLIlZiDyBdOZjfgWde2XZqfue4zqEpnn
	 DPDSbP2SOoHtICK4sa5/UIe7CKnF54cm0B5ZmGjU=
X-QQ-mid: bizesmtp87t1724916610td1la1ss
X-QQ-Originating-IP: k3Vx3kPdv4++iXJufQYQJD+NYUDo2mSAC6TuiRzZhRA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Aug 2024 15:30:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 939266593025190656
From: WangYuli <wangyuli@uniontech.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org,
	bhelgaas@google.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Chen Baozi <chenbaozi@phytium.com.cn>,
	Wang Zhimin <wangzhimin1179@phytium.com.cn>,
	Chen Zhenhua <chenzhenhua@phytium.com.cn>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Subject: [PATCH] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium xHCI host
Date: Thu, 29 Aug 2024 15:30:05 +0800
Message-ID: <59E000092FD56E43+20240829073005.304698-1-wangyuli@uniontech.com>
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
 drivers/usb/host/xhci-pci.c | 6 ++++++
 include/linux/pci_ids.h     | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index b5705ed01d83..af967644489c 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -55,6 +55,8 @@
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
 
+#define PCI_DEVICE_ID_PHYTIUM_XHCI			0xdc27
+
 /* Thunderbolt */
 #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
@@ -407,6 +409,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_VIA)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 
+	if (pdev->vendor == PCI_VENDOR_ID_PHYTIUM ||
+	    pdev->device == PCI_DEVICE_ID_PHYTIUM_XHCI)
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+
 	/* See https://bugzilla.kernel.org/show_bug.cgi?id=79511 */
 	if (pdev->vendor == PCI_VENDOR_ID_VIA &&
 			pdev->device == 0x3432)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e388c8b1cbc2..25fff4130503 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2605,6 +2605,8 @@
 
 #define PCI_VENDOR_ID_FUNGIBLE		0x1dad
 
+#define PCI_VENDOR_ID_PHYTIUM		0x1db7
+
 #define PCI_VENDOR_ID_HXT		0x1dbf
 
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
-- 
2.43.4


