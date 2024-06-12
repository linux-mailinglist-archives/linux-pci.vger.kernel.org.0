Return-Path: <linux-pci+bounces-8632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD7904BFD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330D91C22101
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5FD16C448;
	Wed, 12 Jun 2024 06:53:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C049169376;
	Wed, 12 Jun 2024 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175223; cv=none; b=cIry5AATkHW6zHvCz7kIOUH8phg2zbnRgFD41n38C9JjQEszSxMFxUo9GDqK4PXxBkv2D3QpfFFb13nTEtIgfTYMODm9Pk9K7RS7sePc7eGn1cyF8VdvYCToJSH4opF58P6eJDuEwAlSlviSQ0VtEJMdhetCCZRHlQapLQ2gvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175223; c=relaxed/simple;
	bh=hiCdjT7POcrsS7iqSGVKiD1ma4BKsH9HOhCpk4IO1tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UyYKdUTWMXOjZoMdUkZdHcdr+UKftKunmhNfpeRqZ5npU0whdE/OuhNVPsmlaxqxS04izHi+Tr/3TegfFnjc+Ger2FJHzDAHgQZqt+sAnPeYNNV3qx5yKRyGLLY8Ly4LDTkvPIJn/WwpZxIFdo1l+VkvaGBG5C6h3g7qEVMfdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ED2C4AF51;
	Wed, 12 Jun 2024 06:53:40 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Sheng Wu <wusheng@loongson.cn>
Subject: [PATCH] PCI: loongson: Add LS7A MSI enablement quirk
Date: Wed, 12 Jun 2024 14:53:15 +0800
Message-ID: <20240612065315.2048110-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LS7A chipset can be used as a downstream bridge which connected to a
high-level host bridge. In this case DEV_LS7A_PCIE_PORT5 is used as the
upward port. We should always enable MSI caps of this port, otherwise
downstream devices cannot use MSI.

Cc: <stable@vger.kernel.org>
Signed-off-by: Sheng Wu <wusheng@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 8b34ccff073a..ffc581605834 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -163,6 +163,18 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_HDMI, loongson_pci_pin_quirk);
 
+static void loongson_pci_msi_quirk(struct pci_dev *dev)
+{
+	u16 val, class = dev->class >> 8;
+
+	if (class == PCI_CLASS_BRIDGE_HOST) {
+		pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &val);
+		val |= PCI_MSI_FLAGS_ENABLE;
+		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, val);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;
-- 
2.43.0


