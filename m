Return-Path: <linux-pci+bounces-12420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B44C96408C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 11:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49B51F22DC3
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3CD148838;
	Thu, 29 Aug 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GWfMSu6V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE118DF6E;
	Thu, 29 Aug 2024 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925047; cv=none; b=Ugnx5+f8AUD1q2hWbBp/ijv3rRTyN271ApFC53BDUB5+klWRtflCATveZzcQhT2Aj7J6FXFC+dcnKGZuyzIoo2FnA2Jgliq7MVr/9lExSX7kqByKtztsd4ginCG/RI6/iAbDUowZuZG1mTegyJvJu76hKrD1ZeaXGnT95LnbxTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925047; c=relaxed/simple;
	bh=7TylQoddSxB9ZHHf9DNZGW9iD+hOgef4/KVkWYwfLMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eX/vjsOcdU4GZR9rkoGgaMvYx9UdGOGtmtYdJ9JB03ImBNME4d6sO6Bi+j68hYyBM/HCvqXhaZhio4i6JvL8iWkgr3dIai+m1iHfd00RzaYgFGKhy+GYYfEA5nxrieE69mqcBimF9J9j8m7xMgUclVjnkY8+nJvMKNL7Rz6cbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GWfMSu6V; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1724925039;
	bh=C8Ap7JInDIabgSxCYPM4pbBC80uSwTy3ex4duXRFaHU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GWfMSu6VARU88So7MMtraN3EgOAJDvgF9mYf0Q8erCpe0kqNQmMc+XxSJh9c4c3BV
	 eMZq21GXmicotFELYNW9gkQWRiQTdX6Kk2gdJygrCerQi7VyyGinskFN7S7go4Z21F
	 TXmxbqPnI8zlMTwmoPJH5i+tVfpESKFlAAeon+58=
X-QQ-mid: bizesmtp90t1724925034t64mciaj
X-QQ-Originating-IP: EJmO/ueDMiuaxusWmcU8TWgM5tfiwk54zZSXTUIcmM4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Aug 2024 17:50:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17652668555461779045
From: WangYuli <wangyuli@uniontech.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
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
Subject: [PATCH v2] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium xHCI host
Date: Thu, 29 Aug 2024 17:50:28 +0800
Message-ID: <196A709D168A9A04+20240829095028.345047-1-wangyuli@uniontech.com>
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
 drivers/usb/host/xhci-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index b5705ed01d83..fabae8420ce9 100644
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
 
+	if (pdev->vendor == PCI_VENDOR_ID_PHYTIUM ||
+	    pdev->device == PCI_DEVICE_ID_PHYTIUM_XHCI)
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+
 	/* See https://bugzilla.kernel.org/show_bug.cgi?id=79511 */
 	if (pdev->vendor == PCI_VENDOR_ID_VIA &&
 			pdev->device == 0x3432)
-- 
2.43.4


