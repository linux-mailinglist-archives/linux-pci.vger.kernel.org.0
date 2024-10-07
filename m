Return-Path: <linux-pci+bounces-13908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEFF992357
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABC21F22910
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245AC3C2F;
	Mon,  7 Oct 2024 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxiAnkaB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A644430
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273816; cv=none; b=qwtgOdUxca6U5s0BR1rqZ7oVhiU0UzrRoIeVNeIz6i4isAEZim/q76jQWkQoeMON2zbebfHls5Gyof2CYscuWDAsfe/+1t/Nv2iWPm8Jm+VUPTasiZbAGm/Z9lyjJBhMk40ocKlT64YRoc8JI4FPyQJCxY4mM+0BmyxiBgKYeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273816; c=relaxed/simple;
	bh=z1T4GvXAzBQMx0pdZObj1tDkhM6X+SAMlzpX3rMFcqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImjZhBNMEXqn8iwr1geXbTfE55QFwUUIb7E9PRJOhdldPemYVnXMkZEvcq+Yo7XzL1Pq44vokn4A8DeFHhlyNyyVRA838H/QQXbmEh7aQCHsDVnjKzocGpFe9pZTBq06Q2qvS8kFkyGdLKYZJ6Gep3tCaDD2SWCS4Qh0QmKLT7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxiAnkaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0FDC4CED4;
	Mon,  7 Oct 2024 04:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728273815;
	bh=z1T4GvXAzBQMx0pdZObj1tDkhM6X+SAMlzpX3rMFcqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxiAnkaBDnV3DJvbxX7o0TJZbTfw33rxRtZHiAFPOARWfazLg+MM9X8pULyuOWizh
	 k5ByxgagsX+G0XCB+noeRjJj7hhNskA5NKI2ZOaJpv8l41aZosOnkwDuFWA4h9Lcau
	 UJgyEtab+PCF5PydW0Il8OA2nNtw++sRQTUy03C/Ahv7zsg1na4FHPEhOdb5J2r7MK
	 uFLd6v4wVwGutyjG78qxys5DTLuhyurOk8J1w6qzVcwV8caakGVVvbHlQGsQWojNin
	 XJvn3lTAZn8kGbbfuPGpTdM5JV2j2h+NK5J8DWxtk4ZzkrH25KQszkSoHvgDudeJTP
	 6qZDM9PcHhP+A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 6/7] PCI: endpoint: test: Use pci_epc_mem_map/unmap()
Date: Mon,  7 Oct 2024 13:03:18 +0900
Message-ID: <20241007040319.157412-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007040319.157412-1-dlemoal@kernel.org>
References: <20241007040319.157412-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the endpoint test driver to use the functions pci_epc_mem_map()
and pci_epc_mem_unmap() for the read, write and copy tests. For each
test case, the transfer (dma or mmio) are executed in a loop to ensure
that potentially partial mappings returned by pci_epc_mem_map() are
correctly handled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 372 +++++++++---------
 1 file changed, 193 insertions(+), 179 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7c2ed6eae53a..a73bc0771d35 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -317,91 +317,92 @@ static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
 static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 			      struct pci_epf_test_reg *reg)
 {
-	int ret;
-	void __iomem *src_addr;
-	void __iomem *dst_addr;
-	phys_addr_t src_phys_addr;
-	phys_addr_t dst_phys_addr;
+	int ret = 0;
 	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
-	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct pci_epc_map src_map, dst_map;
+	u64 src_addr = reg->src_addr;
+	u64 dst_addr = reg->dst_addr;
+	size_t copy_size = reg->size;
+	ssize_t map_size = 0;
+	void *copy_buf = NULL, *buf;
 
-	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
-	if (!src_addr) {
-		dev_err(dev, "Failed to allocate source address\n");
-		reg->status = STATUS_SRC_ADDR_INVALID;
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr,
-			       reg->src_addr, reg->size);
-	if (ret) {
-		dev_err(dev, "Failed to map source address\n");
-		reg->status = STATUS_SRC_ADDR_INVALID;
-		goto err_src_addr;
-	}
-
-	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
-	if (!dst_addr) {
-		dev_err(dev, "Failed to allocate destination address\n");
-		reg->status = STATUS_DST_ADDR_INVALID;
-		ret = -ENOMEM;
-		goto err_src_map_addr;
-	}
-
-	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr,
-			       reg->dst_addr, reg->size);
-	if (ret) {
-		dev_err(dev, "Failed to map destination address\n");
-		reg->status = STATUS_DST_ADDR_INVALID;
-		goto err_dst_addr;
-	}
-
-	ktime_get_ts64(&start);
 	if (reg->flags & FLAG_USE_DMA) {
 		if (epf_test->dma_private) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret = -EINVAL;
-			goto err_map_addr;
+			goto set_status;
 		}
-
-		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 src_phys_addr, reg->size, 0,
-						 DMA_MEM_TO_MEM);
-		if (ret)
-			dev_err(dev, "Data transfer failed\n");
 	} else {
-		void *buf;
-
-		buf = kzalloc(reg->size, GFP_KERNEL);
-		if (!buf) {
+		copy_buf = kzalloc(copy_size, GFP_KERNEL);
+		if (!copy_buf) {
 			ret = -ENOMEM;
-			goto err_map_addr;
+			goto set_status;
 		}
-
-		memcpy_fromio(buf, src_addr, reg->size);
-		memcpy_toio(dst_addr, buf, reg->size);
-		kfree(buf);
+		buf = copy_buf;
 	}
-	ktime_get_ts64(&end);
-	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start, &end,
-				reg->flags & FLAG_USE_DMA);
 
-err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
+	while (copy_size) {
+		ret = pci_epc_mem_map(epc, epf->func_no, epf->vfunc_no,
+				      src_addr, copy_size, &src_map);
+		if (ret) {
+			dev_err(dev, "Failed to map source address\n");
+			reg->status = STATUS_SRC_ADDR_INVALID;
+			goto free_buf;
+		}
+
+		ret = pci_epc_mem_map(epf->epc, epf->func_no, epf->vfunc_no,
+					   dst_addr, copy_size, &dst_map);
+		if (ret) {
+			dev_err(dev, "Failed to map destination address\n");
+			reg->status = STATUS_DST_ADDR_INVALID;
+			pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no,
+					  &src_map);
+			goto free_buf;
+		}
+
+		map_size = min_t(size_t, dst_map.pci_size, src_map.pci_size);
+
+		ktime_get_ts64(&start);
+		if (reg->flags & FLAG_USE_DMA) {
+			ret = pci_epf_test_data_transfer(epf_test,
+					dst_map.phys_addr, src_map.phys_addr,
+					map_size, 0, DMA_MEM_TO_MEM);
+			if (ret) {
+				dev_err(dev, "Data transfer failed\n");
+				goto unmap;
+			}
+		} else {
+			memcpy_fromio(buf, src_map.virt_addr, map_size);
+			memcpy_toio(dst_map.virt_addr, buf, map_size);
+			buf += map_size;
+		}
+		ktime_get_ts64(&end);
 
-err_dst_addr:
-	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
+		copy_size -= map_size;
+		src_addr += map_size;
+		dst_addr += map_size;
 
-err_src_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr);
+		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &dst_map);
+		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &src_map);
+		map_size = 0;
+	}
 
-err_src_addr:
-	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
+	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start,
+				&end, reg->flags & FLAG_USE_DMA);
 
-err:
+unmap:
+	if (map_size) {
+		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &dst_map);
+		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &src_map);
+	}
+
+free_buf:
+	kfree(copy_buf);
+
+set_status:
 	if (!ret)
 		reg->status |= STATUS_COPY_SUCCESS;
 	else
@@ -411,82 +412,89 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 static void pci_epf_test_read(struct pci_epf_test *epf_test,
 			      struct pci_epf_test_reg *reg)
 {
-	int ret;
-	void __iomem *src_addr;
-	void *buf;
+	int ret = 0;
+	void *src_buf, *buf;
 	u32 crc32;
-	phys_addr_t phys_addr;
+	struct pci_epc_map map;
 	phys_addr_t dst_phys_addr;
 	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
-	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
 	struct device *dma_dev = epf->epc->dev.parent;
+	u64 src_addr = reg->src_addr;
+	size_t src_size = reg->size;
+	ssize_t map_size = 0;
 
-	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
-	if (!src_addr) {
-		dev_err(dev, "Failed to allocate address\n");
-		reg->status = STATUS_SRC_ADDR_INVALID;
+	src_buf = kzalloc(src_size, GFP_KERNEL);
+	if (!src_buf) {
 		ret = -ENOMEM;
-		goto err;
+		goto set_status;
 	}
+	buf = src_buf;
 
-	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
-			       reg->src_addr, reg->size);
-	if (ret) {
-		dev_err(dev, "Failed to map address\n");
-		reg->status = STATUS_SRC_ADDR_INVALID;
-		goto err_addr;
-	}
-
-	buf = kzalloc(reg->size, GFP_KERNEL);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto err_map_addr;
-	}
+	while (src_size) {
+		ret = pci_epc_mem_map(epc, epf->func_no, epf->vfunc_no,
+					   src_addr, src_size, &map);
+		if (ret) {
+			dev_err(dev, "Failed to map address\n");
+			reg->status = STATUS_SRC_ADDR_INVALID;
+			goto free_buf;
+		}
 
-	if (reg->flags & FLAG_USE_DMA) {
-		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
-					       DMA_FROM_DEVICE);
-		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
-			dev_err(dev, "Failed to map destination buffer addr\n");
-			ret = -ENOMEM;
-			goto err_dma_map;
+		map_size = map.pci_size;
+		if (reg->flags & FLAG_USE_DMA) {
+			dst_phys_addr = dma_map_single(dma_dev, buf, map_size,
+						       DMA_FROM_DEVICE);
+			if (dma_mapping_error(dma_dev, dst_phys_addr)) {
+				dev_err(dev,
+					"Failed to map destination buffer addr\n");
+				ret = -ENOMEM;
+				goto unmap;
+			}
+
+			ktime_get_ts64(&start);
+			ret = pci_epf_test_data_transfer(epf_test,
+					dst_phys_addr, map.phys_addr,
+					map_size, src_addr, DMA_DEV_TO_MEM);
+			if (ret)
+				dev_err(dev, "Data transfer failed\n");
+			ktime_get_ts64(&end);
+
+			dma_unmap_single(dma_dev, dst_phys_addr, map_size,
+					 DMA_FROM_DEVICE);
+
+			if (ret)
+				goto unmap;
+		} else {
+			ktime_get_ts64(&start);
+			memcpy_fromio(buf, map.virt_addr, map_size);
+			ktime_get_ts64(&end);
 		}
 
-		ktime_get_ts64(&start);
-		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 phys_addr, reg->size,
-						 reg->src_addr, DMA_DEV_TO_MEM);
-		if (ret)
-			dev_err(dev, "Data transfer failed\n");
-		ktime_get_ts64(&end);
+		src_size -= map_size;
+		src_addr += map_size;
+		buf += map_size;
 
-		dma_unmap_single(dma_dev, dst_phys_addr, reg->size,
-				 DMA_FROM_DEVICE);
-	} else {
-		ktime_get_ts64(&start);
-		memcpy_fromio(buf, src_addr, reg->size);
-		ktime_get_ts64(&end);
+		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
+		map_size = 0;
 	}
 
-	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start, &end,
-				reg->flags & FLAG_USE_DMA);
+	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start,
+				&end, reg->flags & FLAG_USE_DMA);
 
-	crc32 = crc32_le(~0, buf, reg->size);
+	crc32 = crc32_le(~0, src_buf, reg->size);
 	if (crc32 != reg->checksum)
 		ret = -EIO;
 
-err_dma_map:
-	kfree(buf);
-
-err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
+unmap:
+	if (map_size)
+		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
 
-err_addr:
-	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
+free_buf:
+	kfree(src_buf);
 
-err:
+set_status:
 	if (!ret)
 		reg->status |= STATUS_READ_SUCCESS;
 	else
@@ -496,71 +504,79 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
 static void pci_epf_test_write(struct pci_epf_test *epf_test,
 			       struct pci_epf_test_reg *reg)
 {
-	int ret;
-	void __iomem *dst_addr;
-	void *buf;
-	phys_addr_t phys_addr;
+	int ret = 0;
+	void *dst_buf, *buf;
+	struct pci_epc_map map;
 	phys_addr_t src_phys_addr;
 	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
-	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
 	struct device *dma_dev = epf->epc->dev.parent;
+	u64 dst_addr = reg->dst_addr;
+	size_t dst_size = reg->size;
+	ssize_t map_size = 0;
 
-	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
-	if (!dst_addr) {
-		dev_err(dev, "Failed to allocate address\n");
-		reg->status = STATUS_DST_ADDR_INVALID;
+	dst_buf = kzalloc(dst_size, GFP_KERNEL);
+	if (!dst_buf) {
 		ret = -ENOMEM;
-		goto err;
+		goto set_status;
 	}
+	get_random_bytes(dst_buf, dst_size);
+	reg->checksum = crc32_le(~0, dst_buf, dst_size);
+	buf = dst_buf;
 
-	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
-			       reg->dst_addr, reg->size);
-	if (ret) {
-		dev_err(dev, "Failed to map address\n");
-		reg->status = STATUS_DST_ADDR_INVALID;
-		goto err_addr;
-	}
-
-	buf = kzalloc(reg->size, GFP_KERNEL);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto err_map_addr;
-	}
-
-	get_random_bytes(buf, reg->size);
-	reg->checksum = crc32_le(~0, buf, reg->size);
-
-	if (reg->flags & FLAG_USE_DMA) {
-		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
-					       DMA_TO_DEVICE);
-		if (dma_mapping_error(dma_dev, src_phys_addr)) {
-			dev_err(dev, "Failed to map source buffer addr\n");
-			ret = -ENOMEM;
-			goto err_dma_map;
+	while (dst_size) {
+		ret = pci_epc_mem_map(epc, epf->func_no, epf->vfunc_no,
+					   dst_addr, dst_size, &map);
+		if (ret) {
+			dev_err(dev, "Failed to map address\n");
+			reg->status = STATUS_DST_ADDR_INVALID;
+			goto free_buf;
 		}
 
-		ktime_get_ts64(&start);
+		map_size = map.pci_size;
+		if (reg->flags & FLAG_USE_DMA) {
+			src_phys_addr = dma_map_single(dma_dev, buf, map_size,
+						       DMA_TO_DEVICE);
+			if (dma_mapping_error(dma_dev, src_phys_addr)) {
+				dev_err(dev,
+					"Failed to map source buffer addr\n");
+				ret = -ENOMEM;
+				goto unmap;
+			}
+
+			ktime_get_ts64(&start);
+
+			ret = pci_epf_test_data_transfer(epf_test,
+						map.phys_addr, src_phys_addr,
+						map_size, dst_addr,
+						DMA_MEM_TO_DEV);
+			if (ret)
+				dev_err(dev, "Data transfer failed\n");
+			ktime_get_ts64(&end);
+
+			dma_unmap_single(dma_dev, src_phys_addr, map_size,
+					 DMA_TO_DEVICE);
+
+			if (ret)
+				goto unmap;
+		} else {
+			ktime_get_ts64(&start);
+			memcpy_toio(map.virt_addr, buf, map_size);
+			ktime_get_ts64(&end);
+		}
 
-		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
-						 src_phys_addr, reg->size,
-						 reg->dst_addr,
-						 DMA_MEM_TO_DEV);
-		if (ret)
-			dev_err(dev, "Data transfer failed\n");
-		ktime_get_ts64(&end);
+		dst_size -= map_size;
+		dst_addr += map_size;
+		buf += map_size;
 
-		dma_unmap_single(dma_dev, src_phys_addr, reg->size,
-				 DMA_TO_DEVICE);
-	} else {
-		ktime_get_ts64(&start);
-		memcpy_toio(dst_addr, buf, reg->size);
-		ktime_get_ts64(&end);
+		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
+		map_size = 0;
 	}
 
-	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start, &end,
-				reg->flags & FLAG_USE_DMA);
+	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start,
+				&end, reg->flags & FLAG_USE_DMA);
 
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
@@ -568,16 +584,14 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
 	 */
 	usleep_range(1000, 2000);
 
-err_dma_map:
-	kfree(buf);
-
-err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
+unmap:
+	if (map_size)
+		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
 
-err_addr:
-	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
+free_buf:
+	kfree(dst_buf);
 
-err:
+set_status:
 	if (!ret)
 		reg->status |= STATUS_WRITE_SUCCESS;
 	else
-- 
2.46.2


