Return-Path: <linux-pci+bounces-20229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0193AA18D5F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 09:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B6B188B349
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 08:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ACE1C1F19;
	Wed, 22 Jan 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fuJAswUu"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A381C4609;
	Wed, 22 Jan 2025 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737533270; cv=none; b=Ie+v4AOK7LDxfB47ZpEY1AQ9o015xgOJsmmtQGBPKI+cWdlMGLTf2YIm8EaEvTdHoPbO1PgYE26Kf9x95rxXNnxXrkYJM2LvfpFrSVe9G8QM/gnMzHGoLoRnEoN0TyOsobZ222a5Jdjji0kixtOl2qZ+QtXdG0zYN6IK+zfQbjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737533270; c=relaxed/simple;
	bh=Gthb5eARQ6O5W92EXeyFd40fJ0qWoonB7+HdhozRUZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nx2BjDBmnsaioW7Xp/Pa5v/M2ovc0MZlyzJpYQqpP3KSjpj89Kpm9HmPHubKWF2Glz17QBVacIbNuL1H+K9ll2NQF0x+UyfecLtE4jzw8Nn563/n9L6nMq9Y7Xyq/e7iKA/XT4SoUF75C5uqEEY66gBIawZizaBlTBZZ1MHATaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fuJAswUu; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=RP1iXDxEpZIMCI/dmi9pkUOgaQdEJXOqkzrn2Zhl/lA=;
	b=fuJAswUuzz7m5iINkuCfgok9ZwNafWAP0tMBqOBlPUu/kl8w2GmQebeshbnXvU
	9o4WOfBPpFhddRyIOE/AAjBg21kiIv7cF4FDW2OxmN0fUXgIbe5SHO1obE1pFsf5
	bzlMhxeA7FngXzG0HivOGPa2sVc0ZEJa91pJbr8BbEc5A=
Received: from jiwei-VirtualBox.lenovo.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXX9ATp5Bn1JblHg--.23736S3;
	Wed, 22 Jan 2025 16:06:44 +0800 (CST)
From: Jiwei Sun <sjiwei@163.com>
To: macro@orcam.me.uk,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	helgaas@kernel.org,
	lukas@wunner.de,
	ahuang12@lenovo.com,
	sunjw10@lenovo.com,
	jiwei.sun.bj@qq.com,
	sunjw10@outlook.com
Subject: [PATCH v3 1/2] PCI: Fix the wrong reading of register fields
Date: Wed, 22 Jan 2025 16:06:09 +0800
Message-Id: <20250122080610.902706-2-sjiwei@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122080610.902706-1-sjiwei@163.com>
References: <20250122080610.902706-1-sjiwei@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX9ATp5Bn1JblHg--.23736S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4rtFWDWw15uw1kAFWDArb_yoW5Zw4Up3
	W3uryYyrW8Cw47C3s5Was7Xa4IqFn3CF1j9rnrWr98XFyfJ3s5AF1I9r9Iqry7Ar4jkry8
	X3srXr43Cw12kFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzwZ7UUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiDxTcmWeQpngQDgAAsp

From: Jiwei Sun <sunjw10@lenovo.com>

The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just use
the link speed field of the registers. However, there are many other
different function fields in the Link Control 2 Register or the Link
Capabilities Register. If the register value is directly used by the two
macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).

In order to avoid the above-mentioned potential issue, only keep link speed
field of the two registers before using.

Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..c571f5943f3d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -337,12 +337,14 @@ void pci_bus_put(struct pci_bus *bus);
 
 #define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
 ({									\
-	((lnkcap) == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
+	u32 __lnkcap = (lnkcap) & PCI_EXP_LNKCAP_SLS;			\
+									\
+	(__lnkcap == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
+	 __lnkcap == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
+	 __lnkcap == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
+	 __lnkcap == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
+	 __lnkcap == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
+	 __lnkcap == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
 	 PCI_SPEED_UNKNOWN);						\
 })
 
@@ -357,13 +359,17 @@ void pci_bus_put(struct pci_bus *bus);
 	 PCI_SPEED_UNKNOWN)
 
 #define PCIE_LNKCTL2_TLS2SPEED(lnkctl2) \
-	((lnkctl2) == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
-	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
-	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
-	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
-	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
-	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
-	 PCI_SPEED_UNKNOWN)
+({									\
+	u16 __lnkctl2 = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;		\
+									\
+	(__lnkctl2 == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
+	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT :	\
+	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT :	\
+	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT :	\
+	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT :	\
+	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT :	\
+	 PCI_SPEED_UNKNOWN);						\
+})
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-- 
2.34.1


