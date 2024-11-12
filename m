Return-Path: <linux-pci+bounces-16523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8C09C5686
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 12:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264061F255EE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A640121314D;
	Tue, 12 Nov 2024 11:18:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890202139DB;
	Tue, 12 Nov 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410325; cv=none; b=hLpoFN4HNqZFZZ+/unXl/h2ZK7dZLZDtjLXOsMwG+/ruz6HWlg7UQxMY3pCjP0oR0QYECKwQg00L4l469Yk3jyCG7eDj0MMR+2n+LrGuDzW2BqSNWehzGZaoH1oMkcyhf+AQ16qzmD4h4PcxCrHiGYs1Tdroz21TZudxwDd5mOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410325; c=relaxed/simple;
	bh=jZthwTSLsOjzv5ZTQ2UfOQI4o6Jk5yWjtqlrbVwOvGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbk/qIHMwSt9S038aUge8IPTXwwwgRzfCzwzQ04vqkbz3J2uSq9mpXuMwu7sW6TFVKezBqs3IGwaQ1NpeZbNDbcnt/vYkfuU+op7zHyEHOObR2+tVPrCreHLOiLgzt1mHPeSxK73sDbCy1D2w5QFuKuBgxHUdXdo0PaekS1jKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz9t1731410309td154f1
X-QQ-Originating-IP: HWcrMM4+bOiBpzi2kQe89tlroy2ScWGvVS9Gv+mrfq0=
Received: from localhost.localdomain ( [115.200.246.212])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Nov 2024 19:18:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1789351152307213282
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: linux-pci@vger.kernel.org
Cc: netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH PCI] PCI: Add ACS quirk for Wangxun FF5XXX NICS
Date: Tue, 12 Nov 2024 19:18:16 +0800
Message-ID: <B12683A3B81C24B5+20241112111816.37290-1-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: MyhNtuNETreesyKkCM7/TAIf/JZ+7eQC5QC8RKUFIaqxOgxXld8X7C05
	lOapbeL6YL/5oO788LJCIfJpxhyv1+Wn2OiYRFBwhz1AOwdJYW6BWhYfPKnm7d+/1rZJOGw
	oj2BUalRSRCkQjYC1v5/l7fXO5yfBuFhyh1+mcR269UgMZIr9za/XH7M2WeKiHYaOZbXxf5
	39vOjS99JtjPwiR70+b0A5NFy+AHpj9jQcVEiRW3L+NLaTQqGc2lgBq3bF/luMqDMbYqn2a
	zfY9yrotqvkp1bjJTV01VGLydIV0ZE+oXt8Y9Yetxf718z9XHuRJq4W2vFwHehltFxEorjG
	iATYFeWEgXn7gRH4s0XxzyvqO2MvWitowafcit+zPCk5yFITc8c5TKQBUbHtjYXx7aHury8
	f3HwXKYTLoVE/80yXDoUcmH7+7QkPG6P8ObJN/ZeNfkYGR1aajCtC01PiOfxmNCAjuoXczP
	zgmPgBNazWASiandFFFABb8EN07PKMB2+zw+iCSuVPBdBCB2Cxe2zisAIMrIP1+q4TkUVnO
	GD/rDZalb/BmTlB9yVUxnJn6fpxeIADOhnYF057kGhPnIHiaW/MoEuuM6RQdGion4u/sUpi
	uLRYYp8c4gQ3cuw61qauG74dyCE+8q+/YvnlFaQ5r1kvay04Cp/cvWDMmGMeZClllf41h/v
	y4NCWHzyzmJpysSh8Gt9RXdYH1GZ+J893BgJeVwrKrFTLc0+EbcUSUJaplVHKwCG4CfYXuJ
	lwMJFw6hRBI3HsMJPcBzNoNn/c3rDnsPI/uvv3umHtwwd9XNfK2h8tBY6yn7wGA2+atCOCw
	SvN+3m/DYJKJBBK/Xk2vaOGAJcAFQMs0dNSBlVBO5CnSyu02jgHehxyKdTagSZKc7tlIxMJ
	4p+uS9bA+FYsCmW0cn/HM6mcjaLsHEgrRCGorcFQEfbFk/BuP5d27IwyLDnBDrbppZJSBtW
	duya+jjJejuoKRy+tJ4egO/f8kLe2ztuPSnnWq/2082chPK6xZ0odqDF7oWtfibj32TY=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Wangxun FF5XXX NICs are same as selection of SFxxx, RP1000 and
RP2000 NICS. They may be multi-function devices, but the hardware
does not advertise ACS capability.

Add this ACS quirk for FF5XXX NICs in pci_quirk_wangxun_nic_acs
so the functions can be in independent IOMMU groups.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/pci/quirks.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dccb60c1d9cc..d1973a8fd70c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4996,18 +4996,20 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
 }
 
 /*
- * Wangxun 10G/1G NICs have no ACS capability, and on multi-function
+ * Wangxun 40G/25G/10G/1G NICs have no ACS capability, and on multi-function
  * devices, peer-to-peer transactions are not be used between the functions.
  * So add an ACS quirk for below devices to isolate functions.
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


