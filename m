Return-Path: <linux-pci+bounces-34530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B85B311A5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 10:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F35C1CC0D35
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536272EBB8C;
	Fri, 22 Aug 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="j6JP2Gcc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963C26656D;
	Fri, 22 Aug 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850793; cv=none; b=R59TkpTyHoZqA5ntmsH3Qpd1bwi5+Ykhpovzp+GhflFZrWaD2+e0o8PZ7H1ww9+01jkkN2RNFkNLn9L0WAOONqEFuc42N5+2M+2UmLfGwZguwZqZckiey8Bat3UUzT1PQMK8cRigs9wk4v7YallqiA9idShLgJT9fEMUmMfce8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850793; c=relaxed/simple;
	bh=60ouIOMZNI4fWnOHSbMHCMjtcFdSJqT/Ab/afS1Y3Mw=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=ZXyN+ubhp0EzMFsackww4xhJLrqpTht5z6C01IOnPVfz8QBskrUSmTsJM7V/z0JXusKr51qz4+VaVRxs41P72eBUsUqWtDig7ftjhxB0ohnLtDC0F685TAcSelfwsuF91RMYx9adMSxKjNkVB0JSo6G9VBRBpvjCs8/6BqmpmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=j6JP2Gcc; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755850760;
	bh=W7YCuvCPw9irUhaTiH73c5zU7lbnLuDOyxSvUUqMIn4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=j6JP2GccDJteZxnoJt9uQbF0ew89mYn7uGfGLdsCKIa9Ga/e349GLYwEU0lG2SnVj
	 cf80nbV/ESwbgtIOFrdjec6HKpNsry8D6z7Rp/csxKKpZapDPXfujCmiaduc4+SwW1
	 nRBc/aGRl9FavqWIZjrXszaWBWe3vdE7X20HfRkY=
X-QQ-mid: esmtpgz16t1755850751t6f1767cb
X-QQ-Originating-IP: YQyxchHu0ua4Ds3I/SkKn4MXnSly7xSc9+Jbp9oLNbs=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 16:18:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18263725170358339871
EX-QQ-RecipientCnt: 10
Message-ID: <A6EC60FB84292EDF+4c8a74f7-6a65-47ee-bc0b-01ba77065ee8@uniontech.com>
Date: Fri, 22 Aug 2025 16:18:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zi Yao <liziyao@uniontech.com>
Subject: [PATCH] PCI: Override PCIe bridge supported speeds for older Loongson
 3C6000 series steppings
References: <>
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, loongarch@lists.linux.dev,
 =?UTF-8?B?6IGC6K+a?= <niecheng1@uniontech.com>,
 Jun Zhan <zhanjun@uniontech.com>, linux-kernel@vger.kernel.org,
 Lain Fearyncess Yang <fsf@live.com>, Mingcong Bai <baimingcong@aosc.io>,
 Ayden Meng <aydenmeng@yeah.net>, Guan Wentao <guanwentao@uniontech.com>
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NbLMjDNEDlGtK6XyVh+w8Wy8MdGiMW/Z9wqOYiE/7jZ0zd/gS0FSJPI2
	+UxcphMSOh2+xEKggFcgFQ9fYpAkDm2b0GO8wuRyx218By/M3CZS74NO0VnCtzK/fFhOEdq
	3Z1lO0YWHC/fAJsaCZbklFxiIAA1zHFMgH7JzzLnoJ6FFQDdq6MGW4LQQCFPoamV+eXJFEY
	N2WpP3fR7zqaoq9NnDbtmHgiUMFwUbKG2cJWEwF0leeFPqUwynmlWt0LbsJP9np7IZW9nl8
	mDpA/O+WqGaClFj4OV5l4LfKH+6NNh6HdK5zPjd5P4lETERqWSxV0Rw+DRn5WeiuUa3ni4q
	rK0dQJ+lSq2t6eY/BFA6YJUebpSKq5Xk6Gb5hxFjWG+6i3+acsFPdAwQcUqhumS25ibHXzt
	7pUiT0niu/s9+7M/9DsJ9LB/mO1O142uvGOmp03lxh7GdSlOapMFDlp+9c8pUMq7cGZKn3D
	/sLDBfY82dOI74kIH5hoxw0HWx80ejNHlnDxnimcylRbGwUTWymPpMO5rqdYHlWZKaqVpN+
	qtXcaIyZQc2+J4brQDJXmfF27ukthztu4UsRCZPyRPPZJlzdwBIlFDQAeAOnjjwb9ptOwZi
	gOP+RN5Yls+R/0NBYX1hnlwNK/DyyWHt7x2ibNn0OIGvY59e6E4se3e/985JCit9/EEo21v
	Ga4Dn8uJfW/G+waJBu7lkJL6Y7AbAIpxcBq4U2zIH5OAjXXbrIZWm9jBZ598KXfjD8pPjRx
	TGMOG0gSYCzEbOaMxxHqAqrDy89mzKOuxtDDliDSsAhXyklp+STQUpu2gweB/hVtu9DuPUB
	/+La3t48Ljhwan23YGdESEWNQhWogTVrvrBkgtRYgCPl7tEopjlLhkepAjFKRNB5S2H0WdJ
	6xd7J+8ZK3QuQXJlUOLxLsfPNZPeK9qufEHx+iuJ7yHFS0TCkHba/E+f+EBDyZGwiHe+VUT
	4ktrmW13++2km2r+PuvbO5WXRsVrSlDE30hTO4h3NTX3/r/AEMGc90N3Pu2xMXzXLyYuqrm
	l4U9aLoqynhYD0NpOjk/L2sDVEjMRD5wcHs3jZMlz+sSo2drEYDp9Ex91F2Zk=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0


Older steppings of the Loongson 3C6000 series incorrectly report the
supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
up to 16 GT/s.

As a result, certain PCIe devices would be incorrectly probed as a Gen1-
only, even if higher link speeds are supported, harming performance and
prevents dynamic link speed functionality from being enabled in drivers
such as amdgpu.

Manually override the `supported_speeds` field for affected PCIe bridges
with those found on the upstream bus to correctly reflect the supported
link speeds.

This patch is found from AOSC OS[1].

Link: https://github.com/AOSC-Tracking/linux/pull/2 #1
Tested-by: Lain Fearyncess Yang <fsf@live.com>
Tested-by: Mingcong Bai <baimingcong@aosc.io>
Tested-by: Ayden Meng <aydenmeng@yeah.net>
Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
Signed-off-by: Zi Yao <liziyao@uniontech.com>
---
  drivers/pci/quirks.c | 24 ++++++++++++++++++++++++
  1 file changed, 24 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 
d97335a401930fe8204e7ca91a8474b6b02554c1..8d29b130f45854d2bff8c47e6529a41a3231221e 
100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1956,6 +1956,30 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 
PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
   DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, 
PCI_CLASS_BRIDGE_PCI, 8, quirk_pcie_mch);
  +/*
+ * Older steppings of the Loongson 3C6000 series incorrectly report the
+ * supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
+ * only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
+ * up to 16 GT/s.
+ */
+static void quirk_loongson_pci_bridge_supported_speeds(struct pci_dev 
*pdev)
+{
+	switch (pdev->bus->max_bus_speed) {
+	case PCIE_SPEED_16_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
+	case PCIE_SPEED_8_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
+	case PCIE_SPEED_5_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
+	case PCIE_SPEED_2_5GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
+	default:
+		break;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, 
quirk_loongson_secondary_bridge_supported_speeds);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, 
quirk_loongson_secondary_bridge_supported_speeds);
+
  /*
   * HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
   * actually on the AMBA bus. These fake PCI devices can support SVA via

---
base-commit: 3957a5720157264dcc41415fbec7c51c4000fc2d
change-id: 20250822-loongson-pci-0cca9e050843

Best regards,
-- 
Zi Yao <liziyao@uniontech.com>


