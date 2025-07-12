Return-Path: <linux-pci+bounces-31993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1543B02AA9
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 13:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30E67A1C02
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896162222A0;
	Sat, 12 Jul 2025 11:44:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0272A1A4;
	Sat, 12 Jul 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752320682; cv=none; b=lnFBUx+XfA/RyKYpgbhNovnxBAvSZ8Dd91IhRTRlceCTY4vAg8fBvUdieK0FZpKTW7eLBdknr673XpKKtFgstlHOh425CTDF4+Tomq3gc9HrKaoowo4rNKVK/2D/pBKhOkmeV3GhmpMcnX4/LitmYMXG+3Pa1EeCNzJtFY+PD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752320682; c=relaxed/simple;
	bh=jQiSSWw4zkWpd1yfceGxZU0VVeisw94LzKe1t+rg4/s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Csp+eK/kJLsUGPfy3vsfBwbRvaxIszOMYF81zDORvXyaQ2I6Lep4q0Y8spLO9id9JluJT4X39h27R+WxB8Axw1mNzISs5BX0ToS+49mSzNWvdD8zY2J4dZkpZB7e72rK2moaAyZuRePXg62SZ1KmbdLY9Itnz/DeF9xUp3PfF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bfRTP0lDxzXf73;
	Sat, 12 Jul 2025 19:40:09 +0800 (CST)
Received: from kwepemk500010.china.huawei.com (unknown [7.202.194.95])
	by mail.maildlp.com (Postfix) with ESMTPS id 40EE8180B2C;
	Sat, 12 Jul 2025 19:44:36 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemk500010.china.huawei.com (7.202.194.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Jul 2025 19:44:35 +0800
From: Weili Qian <qianweili@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>, <qianweili@huawei.com>
Subject: [PATCH] PCI: Add device-specific reset for Kunpeng virtual functions
Date: Sat, 12 Jul 2025 19:30:28 +0800
Message-ID: <20250712113028.15682-1-qianweili@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500010.china.huawei.com (7.202.194.95)

Prior to commit d591f6804e7e ("PCI: Wait for device readiness with
Configuration RRS"), pci_dev_wait() polls PCI_COMMAND register until
its value is not ~0(i.e., PCI_ERROR_RESPONSE). After d591f6804e7e,
if the Configuration Request Retry Status Software Visibility (RRS SV)
is enabled, pci_dev_wait() polls PCI_VENDOR_ID register until its value
is not the reserved Vendor ID value 0x0001.

On Kunpeng accelerator devices, RRS SV is enabled. However,
when the virtual function's FLR (Function Level Reset) is not
ready, the pci_dev_wait() reads the PCI_VENDOR_ID register and gets
the value 0xffff instead of 0x0001. It then incorrectly assumes this
is a valid Vendor ID and concludes the device is ready, returning
successfully. In reality, the function may not be fully ready, leading
to the device becoming unavailable.

A 100ms wait period is already implemented before calling pci_dev_wait().
In most cases, FLR completes within 100ms. However, to eliminate the
risk of function being unavailable due to an incomplete FLR, a
device-specific reset is added. After pcie_flr(), the function continues
to poll PCI_COMMAND register until its value is no longer ~0.

Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/pci/quirks.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d7f4ee634263..1df1756257d2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4205,6 +4205,36 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+#define KUNPENG_OPERATION_WAIT_CNT	3000
+#define KUNPENG_RESET_WAIT_TIME		20
+
+/* Device-specific reset method for Kunpeng accelerator virtual functions */
+static int reset_kunpeng_acc_vf_dev(struct pci_dev *pdev, bool probe)
+{
+	u32 wait_cnt = 0;
+	u32 cmd;
+
+	if (probe)
+		return 0;
+
+	pcie_flr(pdev);
+
+	do {
+		pci_read_config_dword(pdev, PCI_COMMAND, &cmd);
+		if (!PCI_POSSIBLE_ERROR(cmd))
+			break;
+
+		if (++wait_cnt > KUNPENG_OPERATION_WAIT_CNT) {
+			pci_warn(pdev, "wait for FLR ready timeout; giving up\n");
+			return -ENOTTY;
+		}
+
+		msleep(KUNPENG_RESET_WAIT_TIME);
+	} while (true);
+
+	return 0;
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4220,6 +4250,12 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_ZIP_VF,
+		reset_kunpeng_acc_vf_dev },
+	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_SEC_VF,
+		reset_kunpeng_acc_vf_dev },
+	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_HPRE_VF,
+		reset_kunpeng_acc_vf_dev },
 	{ 0 }
 };
 
-- 
2.33.0


