Return-Path: <linux-pci+bounces-25202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB5A79ABA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 06:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AAB188CA52
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 04:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60E51898F8;
	Thu,  3 Apr 2025 04:08:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E62CA6;
	Thu,  3 Apr 2025 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743653297; cv=none; b=dXQooj6f5/5PE0OyJisIh+pVxs9keaLbzSRhybwZA12jLa6iRhyafOE0dncM0bKrYTsEDlo0gEf81ixMjCPe3/KNIOAKd8bXaySOElI/FgQ4CAvk+MTdw4TcGtjPUlOze1H2eEiAxZcwe7qcxPgTFfA17P8TYRBJGHZ1B8lfdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743653297; c=relaxed/simple;
	bh=LvcBl0KnY0rHS0+2sFt/mQyPKZ5eFqfZE7GqNKwSm84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zru4eBYFdNA/us2G/gPe9TY365UaTbyjcKZUf6YHaiXsIoVulK4ebYgU8M995kOxVw4fGKgyVyfKcf9m48wT0XLeCZnPt9NkOo80jpxFp8GjB0MVvLJfToeQl6oaw/g1VPqUw/utPnfDO1RepYzUFhtwt7kbX74uWuAdB05M0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8CxaWqpCe5nnNavAA--.32558S3;
	Thu, 03 Apr 2025 12:08:09 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowMAxSsSlCe5nJjZtAA--.29844S2;
	Thu, 03 Apr 2025 12:08:08 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH V2] PCI: Add ACS quirk for Loongson PCIe
Date: Thu,  3 Apr 2025 12:07:56 +0800
Message-ID: <20250403040756.720409-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxSsSlCe5nJjZtAA--.29844S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr45Kw1fZw4xAF48Gry8Zwc_yoW5JF1Upr
	13CrsrKF4rtr4jvrn5Ja4UGrn5ZFWkA3429FW7Ca4Yga1fAas8Xry2kF1rKF4ayFZ7Xr1x
	Z3yDur1UuayqywbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxUc0eHDUUUU

Loongson PCIe Root Ports don't advertise an ACS capability, but they do
not allow peer-to-peer transactions between Root Ports. Add an ACS quirk
so each Root Port can be in a separate IOMMU group.

Cc: stable@vger.kernel.org
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Add more device ids.

 drivers/pci/quirks.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8d610c17e0f2..eee96ad03614 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4995,6 +4995,18 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
 		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 }
 
+static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * Loongson PCIe Root Ports don't advertise an ACS capability, but
+	 * they do not allow peer-to-peer transactions between Root Ports.
+	 * Allow each Root Port to be in a separate IOMMU group by masking
+	 * SV/RR/CR/UF bits.
+	 */
+	return pci_acs_ctrl_enabled(acs_flags,
+		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+}
+
 /*
  * Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
  * multi-function devices, the hardware isolates the functions by
@@ -5128,6 +5140,17 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
+	/* Loongson PCIe Root Ports */
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C09, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C19, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C29, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A09, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A19, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A29, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A39, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A49, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A59, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A69, pci_quirk_loongson_acs },
 	/* Amazon Annapurna Labs */
 	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
 	/* Zhaoxin multi-function devices */
-- 
2.47.1


