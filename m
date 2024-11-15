Return-Path: <linux-pci+bounces-16806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8019CD598
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 03:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77A6B213B5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 02:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F4542A8C;
	Fri, 15 Nov 2024 02:46:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0C28EF;
	Fri, 15 Nov 2024 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731638816; cv=none; b=gnZK5LmmWybXDs/gxb/Pv2LneGJ6qyOrNddZ19mps/6gvGo3OsLIBd89Bg3pApYxvzriZYd2KPhwQZ06upumiZs8d65UtMwUdLhe3BL3w8HBkKo6ELOEBzlhXMFKka+Px1iLD+jPPKOK7ZtWHM7C/f44rCK6YsoLorb4qLZ1MEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731638816; c=relaxed/simple;
	bh=IAiuFyp3E8W9vuvfCCVnB6Wz9h8JSHrPyDRUJkzoI38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XM8md1ZyDYxbMIBSbNUe7PhI6dXE4U3Y51dwBkB9l2MW1MyT06BPlIy++a+pe9+0vfeUnAmQtI7Wzf6uFXtlQHUctO/NjSnl86U+LwsreTK/N5W+h+ctiaGss3cQi6M5V1iy53g3eEzPBw/AiTzHna0rwPxi1StqoXSLu1sDa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz13t1731638776tf26ak
X-QQ-Originating-IP: m+FaQT7FrJXF6yKa4W3dcPGuEsWgqna6Tk5+0LWIfnY=
Received: from localhost.localdomain ( [115.206.160.29])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Nov 2024 10:46:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10350192324756698958
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: linux-pci@vger.kernel.org
Cc: netdev@vger.kernel.org,
	helgaas@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH PCI v2] PCI: Add ACS quirk for Wangxun FF5XXX NICS
Date: Fri, 15 Nov 2024 10:46:04 +0800
Message-ID: <E16053DB2B80E9A5+20241115024604.30493-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M9NnLm3GdbLblnwuwzDh1lvvan46j55EdPu/Tw3UrgSnUAYJ/p8hyr8g
	DygslxdDA8OtNC0stBCDeLvxGrXPFYfzfMulV64nFA7pw3wMLjvyDr+deG8Afagy5hxzw8i
	1UC34bWkeRMjWgM9a3cDL3bhQvJ5Y2pxO/+uaLEuIu/yIP9mslbMryP6ql+qszqFqEq5kZ1
	x4VaF3AyUuRaoEEkgrz30nPVV5aVMGN5/l81TXZMmuseKkf708681kfEy0krfJvLKv+7vNt
	2MkRKa0efpixwGXx+sCcc9RSnsDdgM/NLdfpcxjSQz49yQ4XMjcXulbAQ5Wffg69umFeplh
	wSAnq1pBK+VqrcjBNo71Iwux0ikMCspRm4GapMzTEL2YmTMaLHx0Mxy15p6C17410+96oqG
	hpLBUtIxmk1sn1kIIA6ul/U0QUy2e7gi9RZ8xZxuyMkzaC0LAPTnv2xcR9bWYV3cHxDGZPL
	LFSjuE/5XaYTyQHRXJVNSSSsbCZYybVW0aCXr/DhS+oXhq5Pdt5bevT0AnUM2gvphLwCrCb
	YHcklIq0dIKCihv3PRCREPGUMZbHG32X/0kIcYmPdThgSY6BCWa1fuFLl0k524zK5a4tLXg
	bZg+iM11MZx6RAvaLLxyX0/rkN1BI04spyrQT4i92rCMDEej6Myguy0OWYG50WsJXHN2AUY
	DYp00sdwtWzpa3gykcyShQgjSUMKCzIt30ufdLPFMt00Dmb0q5VEjbfi6/DXk5/GoqU+wgE
	FUcVscM/HsYeYiRqlYLJ298T1Hcd/YIIaNuOvRD3DMQ6eLr5Sy928JXu9iyxKSVsaY1r99n
	agKyVYzfdwd/F8LXrACJv5YrSvm7DDQk2YY8JvLMZvLLUOhKr+MeQG+CkATF207Ru/wx6nQ
	054wQ9YNSxi29f0gs/x+ajc53/dtzMPXwJe50DE4PEnusFpsQhI4hIajUK7IM3YywPBKnPy
	h2DkjAe4A3WlBS4oMi0iFWLUxHhcK47/t93wwjQ2KQRXRNDO78eoDJO/8
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Wangxun FF5xxx NICs are similar to SFxxx, RP1000 and RP2000 NICs.
They may be multi-function devices, but they do not advertise an ACS
capability.

But the hardware does isolate FF5xxx functions as though it had an
ACS capability and PCI_ACS_RR and PCI_ACS_CR were set in the ACS
Control register, i.e., all peer-to-peer traffic is directed
upstream instead of being routed internally.

Add ACS quirk for FF5xxx NICs in pci_quirk_wangxun_nic_acs() so the
functions can be in independent IOMMU groups.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---

v2:
- Update commit and comment logs.
v1:
https://lore.kernel.org/linux-pci/3D914272-CFAE-4B37-A07B-36CA77210110@net-swift.com/T/#t

 drivers/pci/quirks.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dccb60c1d9cc..8103bc24a54e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4996,18 +4996,21 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
 }
 
 /*
- * Wangxun 10G/1G NICs have no ACS capability, and on multi-function
- * devices, peer-to-peer transactions are not be used between the functions.
- * So add an ACS quirk for below devices to isolate functions.
+ * Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
+ * multi-function devices, the hardware isolates the functions by
+ * directing all peer-to-peer traffic upstream as though PCI_ACS_RR and
+ * PCI_ACS_CR were set.
  * SFxxx 1G NICs(em).
  * RP1000/RP2000 10G NICs(sp).
+ * FF5xxx 40G/25G/10G NICs(aml).
  */
 static int  pci_quirk_wangxun_nic_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	switch (dev->device) {
-	case 0x0100 ... 0x010F:
-	case 0x1001:
-	case 0x2001:
+	case 0x0100 ... 0x010F: /* EM */
+	case 0x1001: case 0x2001: /* SP */
+	case 0x5010: case 0x5025: case 0x5040: /* AML */
+	case 0x5110: case 0x5125: case 0x5140: /* AML */
 		return pci_acs_ctrl_enabled(acs_flags,
 			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 	}
-- 
2.43.2


