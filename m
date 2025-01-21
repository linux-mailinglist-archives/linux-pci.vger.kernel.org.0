Return-Path: <linux-pci+bounces-20181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0638A17D2D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 12:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E824C3A7189
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09B41F12E9;
	Tue, 21 Jan 2025 11:42:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03521B140D
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737459758; cv=none; b=TOnKwt08oRnGrmSMmaxptJEV2Wtok8qbk0N5KM6mquWYFv4awamSRDeUbOTa62KLy2VLkF0VjeG0Ui2k+xdqj+QknjZm7E3CAqSnw4PgR/gyXMBkaL0d3p5IiZiwOXUr8Isbp5rP7+Egb9s7wX+X0DTOUVQ5ZfJ8wL1Ui8ve++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737459758; c=relaxed/simple;
	bh=KSZmkpxQKg3ZkrQ62fdMgngv12KD0Txt//P/QmdQvxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvSWoprNK5pd1oGh7JJkJ8s9HJ9cfkD8OeIYwaipNlMy/H0lw1FTJz9ei5OT+stTb+d6gi5UxNfOUTMJD8S+TWbLqaIL+HKB+2LpSDabw/aoX/LW62g0M7+MyRR8/DAh9gEEyYFArmrq+vQ4TrdBOFMUo5ldiM3gw45ISHb/x5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.63])
	by gateway (Coremail) with SMTP id _____8Cx73MoiI9nyMBmAA--.15553S3;
	Tue, 21 Jan 2025 19:42:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.63])
	by front1 (Coremail) with SMTP id qMiowMAxvsUkiI9nIcwpAA--.19982S2;
	Tue, 21 Jan 2025 19:42:32 +0800 (CST)
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
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] PCI: loongson: Add quirk for OHCI device rev 0x02
Date: Tue, 21 Jan 2025 19:42:25 +0800
Message-ID: <20250121114225.2727684-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxvsUkiI9nIcwpAA--.19982S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4kGr1UArW7trWxWFW5CFX_yoW8Wryfpa
	9xXFZrGF4rtF15CrnIqrykG3ySvFn3CryUCFZrWw12g3Z7Ka4UXw13G3WrtFZxJF1kXFW2
	vFn8Aw4IgFZ8C3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxU466zUUUUU

The OHCI controller (rev 0x02) under LS7A PCI host has a hardware flaw.
MMIO register with offset 0x60/0x64 is treated as legacy PS2-compatible
keyboard/mouse interface, which confuse the OHCI controller. Since OHCI
only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB BAR
is wrapped around (the second 4KB BAR space is the same as the first 4KB
internally). So we can add an 4KB offset (0x1000) to the BAR resource as
a workaround.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index bc630ab8a283..977f7b15f3a7 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -32,6 +32,7 @@
 #define DEV_LS7A_CONF	0x7a10
 #define DEV_LS7A_GNET	0x7a13
 #define DEV_LS7A_EHCI	0x7a14
+#define DEV_LS7A_OHCI	0x7a24
 #define DEV_LS7A_DC2	0x7a36
 #define DEV_LS7A_HDMI	0x7a37
 
@@ -144,6 +145,13 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
 
+static void loongson_ohci_quirk(struct pci_dev *dev)
+{
+	if (dev->revision == 0x2)
+		dev->resource[0].start += 0x1000;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_OHCI, loongson_ohci_quirk);
+
 static void loongson_pci_pin_quirk(struct pci_dev *pdev)
 {
 	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
-- 
2.47.1


