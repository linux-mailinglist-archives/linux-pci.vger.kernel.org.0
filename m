Return-Path: <linux-pci+bounces-20139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D3A16BCF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 12:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F98E162DF2
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F621DE2CC;
	Mon, 20 Jan 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0p9/hy0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26619B3CB
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373817; cv=none; b=NyesxkLZjH017kIqMSnBlhTJhcgkGtFzvzhGNZzfTSKEet10ElHhveLFB79JEmz/ui2MP3BY/A5k8MmQerVT0p11EFK25rbZ8PsMkge0fQuwY6KkB2JUHpcvnSU5PhvvYJTaOYUH+l9pwV1TpsyMy3fp20RIGLMyHI5zRL0XkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373817; c=relaxed/simple;
	bh=puKiBARuX+QQF6apq3ZmAFAxhz27j+VpaZ0rzOGssWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lh4Ysv2ZsbMr2MDFG/FfzOfj4gDElLOkpuwLkcgPTv5j4xU9LhYZvzK7lweGnjTTPseb3s7uZuy5zdQ2wTmwqCMbLi2INxsf6sEdDVYJs+do7uW5WSk45WwUptY/VBaL49HsUyJnBVh6WVZNUl90qWvOEkFrKEnIRqk3L7ObiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0p9/hy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4CBC4CEDD;
	Mon, 20 Jan 2025 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737373817;
	bh=puKiBARuX+QQF6apq3ZmAFAxhz27j+VpaZ0rzOGssWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=F0p9/hy0aTMzteus3McbSBxq74OZCs5lhxHIODInIF3Z1T501cg/5/8vWmL/OJL99
	 OKH3fR83lIORvg7Lk0aQUoZtdSI/yu4RBL5Lm3UBYXZiQc90UIXMlmdXVux+gU+n9h
	 W9Kor6pevJu2wuGfBMeWJ1DGhdq/swvYxa05LYf26pa0I1tAHe9Mhx4VVRzvb9yFl9
	 G/xTwhlo4CoFwYrKVWD2Zyd8MCa8m5OoL1G3gWgyrINL+iCEjyTHW2uHmT582Me3zf
	 dJpIJ6ihznVp5aPI4EdXb3AdQATh8LiTnkdu27TFPK7879jzja38jA77oAZ6cihCgO
	 js5asu30AGWJw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: endpoint: pci-epf-test: Handle endianness properly
Date: Mon, 20 Jan 2025 12:50:10 +0100
Message-ID: <20250120115009.2748899-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10996; i=cassel@kernel.org; h=from:subject; bh=puKiBARuX+QQF6apq3ZmAFAxhz27j+VpaZ0rzOGssWQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL7LAo/iCucl2spuPbre1VHVe6Ku+tWtMfH2DY1iLMeW DHptZJuRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYyawnD/xqDJ073HOPjvlzi 4dzmvqdcPaLsTtiehS+uTO9rZZsU7cPIcLxpdaJpkNRZ/XdTNFhnFORr2InUP3JabWTzUdJQ5lw kDwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The struct pci_epf_test_reg is the actual data in pci-epf-test's test_reg
BAR (usually BAR0), which the host uses to send commands (etc.), and which
pci-epf-test uses to send back status codes.

pci-epf-test currently reads and writes this data without any endianness
conversion functions, which means that pci-epf-test is completely broken
on big-endian systems.

PCI devices are inherently little-endian, and the data stored in the PCI
BARs should be in little-endian.

Use endianness conversion functions when reading and writing data to
struct pci_epf_test_reg so that pci-epf-test will behave correctly on
big-endian systems.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 126 ++++++++++--------
 1 file changed, 73 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ffb534a8e50a..c1359f3662ae 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -66,17 +66,17 @@ struct pci_epf_test {
 };
 
 struct pci_epf_test_reg {
-	u32	magic;
-	u32	command;
-	u32	status;
-	u64	src_addr;
-	u64	dst_addr;
-	u32	size;
-	u32	checksum;
-	u32	irq_type;
-	u32	irq_number;
-	u32	flags;
-	u32	caps;
+	__le32 magic;
+	__le32 command;
+	__le32 status;
+	__le64 src_addr;
+	__le64 dst_addr;
+	__le32 size;
+	__le32 checksum;
+	__le32 irq_type;
+	__le32 irq_number;
+	__le32 flags;
+	__le32 caps;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -324,13 +324,17 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
 	struct pci_epc_map src_map, dst_map;
-	u64 src_addr = reg->src_addr;
-	u64 dst_addr = reg->dst_addr;
-	size_t copy_size = reg->size;
+	u64 src_addr = le64_to_cpu(reg->src_addr);
+	u64 dst_addr = le64_to_cpu(reg->dst_addr);
+	size_t orig_size, copy_size;
 	ssize_t map_size = 0;
+	u32 flags = le32_to_cpu(reg->flags);
+	u32 status = 0;
 	void *copy_buf = NULL, *buf;
 
-	if (reg->flags & FLAG_USE_DMA) {
+	orig_size = copy_size = le32_to_cpu(reg->size);
+
+	if (flags & FLAG_USE_DMA) {
 		if (epf_test->dma_private) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret = -EINVAL;
@@ -350,7 +354,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 				      src_addr, copy_size, &src_map);
 		if (ret) {
 			dev_err(dev, "Failed to map source address\n");
-			reg->status = STATUS_SRC_ADDR_INVALID;
+			status = STATUS_SRC_ADDR_INVALID;
 			goto free_buf;
 		}
 
@@ -358,7 +362,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 					   dst_addr, copy_size, &dst_map);
 		if (ret) {
 			dev_err(dev, "Failed to map destination address\n");
-			reg->status = STATUS_DST_ADDR_INVALID;
+			status = STATUS_DST_ADDR_INVALID;
 			pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no,
 					  &src_map);
 			goto free_buf;
@@ -367,7 +371,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 		map_size = min_t(size_t, dst_map.pci_size, src_map.pci_size);
 
 		ktime_get_ts64(&start);
-		if (reg->flags & FLAG_USE_DMA) {
+		if (flags & FLAG_USE_DMA) {
 			ret = pci_epf_test_data_transfer(epf_test,
 					dst_map.phys_addr, src_map.phys_addr,
 					map_size, 0, DMA_MEM_TO_MEM);
@@ -391,8 +395,8 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 		map_size = 0;
 	}
 
-	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start,
-				&end, reg->flags & FLAG_USE_DMA);
+	pci_epf_test_print_rate(epf_test, "COPY", orig_size, &start, &end,
+				flags & FLAG_USE_DMA);
 
 unmap:
 	if (map_size) {
@@ -405,9 +409,10 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 
 set_status:
 	if (!ret)
-		reg->status |= STATUS_COPY_SUCCESS;
+		status |= STATUS_COPY_SUCCESS;
 	else
-		reg->status |= STATUS_COPY_FAIL;
+		status |= STATUS_COPY_FAIL;
+	reg->status = cpu_to_le32(status);
 }
 
 static void pci_epf_test_read(struct pci_epf_test *epf_test,
@@ -423,9 +428,14 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
 	struct device *dma_dev = epf->epc->dev.parent;
-	u64 src_addr = reg->src_addr;
-	size_t src_size = reg->size;
+	u64 src_addr = le64_to_cpu(reg->src_addr);
+	size_t orig_size, src_size;
 	ssize_t map_size = 0;
+	u32 flags = le32_to_cpu(reg->flags);
+	u32 checksum = le32_to_cpu(reg->checksum);
+	u32 status = 0;
+
+	orig_size = src_size = le32_to_cpu(reg->size);
 
 	src_buf = kzalloc(src_size, GFP_KERNEL);
 	if (!src_buf) {
@@ -439,12 +449,12 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
 					   src_addr, src_size, &map);
 		if (ret) {
 			dev_err(dev, "Failed to map address\n");
-			reg->status = STATUS_SRC_ADDR_INVALID;
+			status = STATUS_SRC_ADDR_INVALID;
 			goto free_buf;
 		}
 
 		map_size = map.pci_size;
-		if (reg->flags & FLAG_USE_DMA) {
+		if (flags & FLAG_USE_DMA) {
 			dst_phys_addr = dma_map_single(dma_dev, buf, map_size,
 						       DMA_FROM_DEVICE);
 			if (dma_mapping_error(dma_dev, dst_phys_addr)) {
@@ -481,11 +491,11 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
 		map_size = 0;
 	}
 
-	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start,
-				&end, reg->flags & FLAG_USE_DMA);
+	pci_epf_test_print_rate(epf_test, "READ", orig_size, &start, &end,
+				flags & FLAG_USE_DMA);
 
-	crc32 = crc32_le(~0, src_buf, reg->size);
-	if (crc32 != reg->checksum)
+	crc32 = crc32_le(~0, src_buf, orig_size);
+	if (crc32 != checksum)
 		ret = -EIO;
 
 unmap:
@@ -497,9 +507,10 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
 
 set_status:
 	if (!ret)
-		reg->status |= STATUS_READ_SUCCESS;
+		status |= STATUS_READ_SUCCESS;
 	else
-		reg->status |= STATUS_READ_FAIL;
+		status |= STATUS_READ_FAIL;
+	reg->status = cpu_to_le32(status);
 }
 
 static void pci_epf_test_write(struct pci_epf_test *epf_test,
@@ -514,9 +525,13 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
 	struct device *dma_dev = epf->epc->dev.parent;
-	u64 dst_addr = reg->dst_addr;
-	size_t dst_size = reg->size;
+	u64 dst_addr = le64_to_cpu(reg->dst_addr);
+	size_t orig_size, dst_size;
 	ssize_t map_size = 0;
+	u32 flags = le32_to_cpu(reg->flags);
+	u32 status = 0;
+
+	orig_size = dst_size = le32_to_cpu(reg->size);
 
 	dst_buf = kzalloc(dst_size, GFP_KERNEL);
 	if (!dst_buf) {
@@ -524,7 +539,7 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
 		goto set_status;
 	}
 	get_random_bytes(dst_buf, dst_size);
-	reg->checksum = crc32_le(~0, dst_buf, dst_size);
+	reg->checksum = cpu_to_le32(crc32_le(~0, dst_buf, dst_size));
 	buf = dst_buf;
 
 	while (dst_size) {
@@ -532,12 +547,12 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
 					   dst_addr, dst_size, &map);
 		if (ret) {
 			dev_err(dev, "Failed to map address\n");
-			reg->status = STATUS_DST_ADDR_INVALID;
+			status = STATUS_DST_ADDR_INVALID;
 			goto free_buf;
 		}
 
 		map_size = map.pci_size;
-		if (reg->flags & FLAG_USE_DMA) {
+		if (flags & FLAG_USE_DMA) {
 			src_phys_addr = dma_map_single(dma_dev, buf, map_size,
 						       DMA_TO_DEVICE);
 			if (dma_mapping_error(dma_dev, src_phys_addr)) {
@@ -576,8 +591,8 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
 		map_size = 0;
 	}
 
-	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start,
-				&end, reg->flags & FLAG_USE_DMA);
+	pci_epf_test_print_rate(epf_test, "WRITE", orig_size, &start, &end,
+				flags & FLAG_USE_DMA);
 
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
@@ -594,9 +609,10 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
 
 set_status:
 	if (!ret)
-		reg->status |= STATUS_WRITE_SUCCESS;
+		status |= STATUS_WRITE_SUCCESS;
 	else
-		reg->status |= STATUS_WRITE_FAIL;
+		status |= STATUS_WRITE_FAIL;
+	reg->status = cpu_to_le32(status);
 }
 
 static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
@@ -605,39 +621,42 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
-	u32 status = reg->status | STATUS_IRQ_RAISED;
+	u32 status = le32_to_cpu(reg->status);
+	u32 irq_number = le32_to_cpu(reg->irq_number);
+	u32 irq_type = le32_to_cpu(reg->irq_type);
 	int count;
 
 	/*
 	 * Set the status before raising the IRQ to ensure that the host sees
 	 * the updated value when it gets the IRQ.
 	 */
-	WRITE_ONCE(reg->status, status);
+	status |= STATUS_IRQ_RAISED;
+	WRITE_ONCE(reg->status, cpu_to_le32(status));
 
-	switch (reg->irq_type) {
+	switch (irq_type) {
 	case IRQ_TYPE_INTX:
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
 				  PCI_IRQ_INTX, 0);
 		break;
 	case IRQ_TYPE_MSI:
 		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
-		if (reg->irq_number > count || count <= 0) {
+		if (irq_number > count || count <= 0) {
 			dev_err(dev, "Invalid MSI IRQ number %d / %d\n",
-				reg->irq_number, count);
+				irq_number, count);
 			return;
 		}
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_IRQ_MSI, reg->irq_number);
+				  PCI_IRQ_MSI, irq_number);
 		break;
 	case IRQ_TYPE_MSIX:
 		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
-		if (reg->irq_number > count || count <= 0) {
+		if (irq_number > count || count <= 0) {
 			dev_err(dev, "Invalid MSIX IRQ number %d / %d\n",
-				reg->irq_number, count);
+				irq_number, count);
 			return;
 		}
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_IRQ_MSIX, reg->irq_number);
+				  PCI_IRQ_MSIX, irq_number);
 		break;
 	default:
 		dev_err(dev, "Failed to raise IRQ, unknown type\n");
@@ -654,21 +673,22 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	struct device *dev = &epf->dev;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	u32 irq_type = le32_to_cpu(reg->irq_type);
 
-	command = READ_ONCE(reg->command);
+	command = le32_to_cpu(READ_ONCE(reg->command));
 	if (!command)
 		goto reset_handler;
 
 	WRITE_ONCE(reg->command, 0);
 	WRITE_ONCE(reg->status, 0);
 
-	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
+	if ((le32_to_cpu(READ_ONCE(reg->flags)) & FLAG_USE_DMA) &&
 	    !epf_test->dma_supported) {
 		dev_err(dev, "Cannot transfer data using DMA\n");
 		goto reset_handler;
 	}
 
-	if (reg->irq_type > IRQ_TYPE_MSIX) {
+	if (irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Failed to detect IRQ type\n");
 		goto reset_handler;
 	}
-- 
2.48.1


