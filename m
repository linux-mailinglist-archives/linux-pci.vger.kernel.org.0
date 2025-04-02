Return-Path: <linux-pci+bounces-25111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B6A787CC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 08:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1EB3AC0FC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 06:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7441EB9F3;
	Wed,  2 Apr 2025 06:04:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C996136A;
	Wed,  2 Apr 2025 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743573860; cv=none; b=uvR1+xj2iMv91/NgR94wem4CjgstlXzMLotQpBasjTel9nOv0Niw58m94D5ApJ9QJl7f9aQ6DTuCRp/+iaa+gMIDj4okkMblO3GzQCOB30SaK9aveoV2xlSD2gGlqP2e0xzZuxfLvWK8vpeLHpv/CtnoJi4Imx/Ra3Ev4LVLOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743573860; c=relaxed/simple;
	bh=d+daxh2bZDgEgIdduOHqJgn8DkbjEegI3Wmts69NkXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dc+RCGPxjFSraZ3fgyzQPY9Eu/vXfrCsSjCTYmkiX4qRn1jjXGXFwxsVp2aOBOEUnDpzeyl5/tEM9JscUX6/YgALXE4+Wd7vbf4xPZ1gKUT2P/WIbh3fiKUor+Rxg0V4dgAAy6ffnkVKS3Kd5fxt6udGMn5pJyfsDKqquL+D5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8CxG6xc0+xnRLOuAA--.62434S3;
	Wed, 02 Apr 2025 14:04:12 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowMCxKcRY0+xnrexrAA--.28983S2;
	Wed, 02 Apr 2025 14:04:11 +0800 (CST)
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
Subject: [PATCH] PCI: Add ACS quirk for Loongson PCIe
Date: Wed,  2 Apr 2025 14:03:54 +0800
Message-ID: <20250402060354.4061578-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxKcRY0+xnrexrAA--.28983S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr45Kw1fZw4xAF48Gr1Dtwc_yoW8CFyrpF
	W3Cr92kr48Wr42ywn8X34UGryrAFykJ342gFW7Aas0ganxAas8ZFyxCFyrtF4akFWxXF1x
	Xa1DCr1UuayjkwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==

Loongson PCIe Root Ports don't advertise an ACS capability, but they do
not allow peer-to-peer transactions between Root Ports. Add an ACS quirk
so each Root Port can be in a separate IOMMU group.

Cc: stable@vger.kernel.org
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8d610c17e0f2..d52ec85f3382 100644
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
@@ -5128,6 +5140,9 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
+	/* Loongson PCIe Root Ports */
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C09, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C19, pci_quirk_loongson_acs },
 	/* Amazon Annapurna Labs */
 	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
 	/* Zhaoxin multi-function devices */
-- 
2.47.1


