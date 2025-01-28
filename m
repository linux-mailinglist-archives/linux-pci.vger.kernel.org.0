Return-Path: <linux-pci+bounces-20447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A6A2084E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 11:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7F43A6F69
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7135D156669;
	Tue, 28 Jan 2025 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiQSrlwf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146A199EAD;
	Tue, 28 Jan 2025 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059218; cv=none; b=DarFVLFmFSFBoDQlRYLOycPMIEHcG/IlRWtOkYM1Xy+8fi5RPyTLJGcuNkFdegTzXDm9BH2pc+uyqRPkR1wyTIppppizGChRQyrjcEKSya9EaqF8QJmcrvlgtxzN157Mj8Yrpa++57uGzlBaF942iO1kcsx2MOkq1TK1NA03RIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059218; c=relaxed/simple;
	bh=1qvep6qV8/gFcvok0MOTuQwodYrTCqAKbR88OJveQ4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/Q+/G3PrJ1hORDW9LZAXmanibdpH8A8Y8Q5DfHg/CwH9Hexf+iM65D0Czq+hqlc6eRZzV5HHxZasxZRhKwA7HEgKVfq/R50aqlnKSbRWwprrClxe9TdvhW01y0tJ47pWXloydZvy6j6rzPFLyvPHVGcZ8NFiLl/O+v9xLYXZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiQSrlwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6BDC4CEDF;
	Tue, 28 Jan 2025 10:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738059217;
	bh=1qvep6qV8/gFcvok0MOTuQwodYrTCqAKbR88OJveQ4c=;
	h=From:To:Cc:Subject:Date:From;
	b=qiQSrlwfMbF0OaBgU1ce7nQ6swwq+eoBBl+rHLcbAal4oo1jNcAKkJZ7HHrfgEckW
	 amnpUwKQwktxOj36TxmldI/IBGktQf2+OQpxP+M7uwTe8JNg9KacjrtcpTzjVnszgx
	 0+NCkDqpVgfZr5uW4lXN9VlUpTquZk8w9l9C2/bKk76uA/qJ/djj0VDcLafYO8OJ+Q
	 51d8fFVKk7tWHMEACMMJHBRf9ifnNICjF+kNe1bX/PdvXOJ7enwvt5ajrAqVO6F455
	 GmzfsYp3EtpGj/ESpVPPgujCfJA9az/Kg2gnv1Gsk46T3EkRAr+7TF1QtOnKShXSPW
	 A39P+CkK19EWw==
From: Philipp Stanner <phasta@kernel.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Philipp Stanner <phasta@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: Remove deprecated PCI API calls
Date: Tue, 28 Jan 2025 11:11:57 +0100
Message-ID: <20250128101156.77868-2-phasta@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel-thc-hid reintroduced the already deprecated PCI API functions

	pcim_iomap_table(),
	pcim_iomap_regions(),
	pcim_iounmap_regions(),

none of which should be used anymore.

Furthermore, calling managed (pcim_*) functions in remove() and probe()
for cleanup is not necessary, since the managed functions clean up
automatically.

Replace / remove the deprecated functions.

Fixes: 61bb2714dc3a1 ("HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C driver skeleton")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Hi,

I'm trying to remove this API since a year. Please pay attention to the
docstrings in PCI which mark certain functions as deprecated.

Thanks
P.
---
 .../intel-thc-hid/intel-quicki2c/pci-quicki2c.c    | 14 +++++---------
 .../intel-thc-hid/intel-quickspi/pci-quickspi.c    | 14 +++++---------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 2de93f4a25ca..fa51155ebe39 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -557,20 +557,19 @@ static int quicki2c_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	ret = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
+	mem_addr = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
+	ret = PTR_ERR_OR_ZERO(mem_addr);
 	if (ret) {
 		dev_err_once(&pdev->dev, "Failed to get PCI regions, ret = %d.\n", ret);
 		goto disable_pci_device;
 	}
 
-	mem_addr = pcim_iomap_table(pdev)[0];
-
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
 		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			dev_err_once(&pdev->dev, "No usable DMA configuration %d\n", ret);
-			goto unmap_io_region;
+			goto disable_pci_device;
 		}
 	}
 
@@ -578,7 +577,7 @@ static int quicki2c_probe(struct pci_dev *pdev,
 	if (ret < 0) {
 		dev_err_once(&pdev->dev,
 			     "Failed to allocate IRQ vectors. ret = %d\n", ret);
-		goto unmap_io_region;
+		goto disable_pci_device;
 	}
 
 	pdev->irq = pci_irq_vector(pdev, 0);
@@ -587,7 +586,7 @@ static int quicki2c_probe(struct pci_dev *pdev,
 	if (IS_ERR(qcdev)) {
 		dev_err_once(&pdev->dev, "QuickI2C device init failed\n");
 		ret = PTR_ERR(qcdev);
-		goto unmap_io_region;
+		goto disable_pci_device;
 	}
 
 	pci_set_drvdata(pdev, qcdev);
@@ -666,8 +665,6 @@ static int quicki2c_probe(struct pci_dev *pdev,
 	quicki2c_dma_deinit(qcdev);
 dev_deinit:
 	quicki2c_dev_deinit(qcdev);
-unmap_io_region:
-	pcim_iounmap_regions(pdev, BIT(0));
 disable_pci_device:
 	pci_clear_master(pdev);
 
@@ -697,7 +694,6 @@ static void quicki2c_remove(struct pci_dev *pdev)
 
 	quicki2c_dev_deinit(qcdev);
 
-	pcim_iounmap_regions(pdev, BIT(0));
 	pci_clear_master(pdev);
 }
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 4641e818dfa4..514b199cb884 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -575,20 +575,19 @@ static int quickspi_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	ret = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
+	mem_addr = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
+	ret = PTR_ERR_OR_ZERO(mem_addr);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to get PCI regions, ret = %d.\n", ret);
 		goto disable_pci_device;
 	}
 
-	mem_addr = pcim_iomap_table(pdev)[0];
-
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
 		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			dev_err(&pdev->dev, "No usable DMA configuration %d\n", ret);
-			goto unmap_io_region;
+			goto disable_pci_device;
 		}
 	}
 
@@ -596,7 +595,7 @@ static int quickspi_probe(struct pci_dev *pdev,
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Failed to allocate IRQ vectors. ret = %d\n", ret);
-		goto unmap_io_region;
+		goto disable_pci_device;
 	}
 
 	pdev->irq = pci_irq_vector(pdev, 0);
@@ -605,7 +604,7 @@ static int quickspi_probe(struct pci_dev *pdev,
 	if (IS_ERR(qsdev)) {
 		dev_err(&pdev->dev, "QuickSPI device init failed\n");
 		ret = PTR_ERR(qsdev);
-		goto unmap_io_region;
+		goto disable_pci_device;
 	}
 
 	pci_set_drvdata(pdev, qsdev);
@@ -668,8 +667,6 @@ static int quickspi_probe(struct pci_dev *pdev,
 	quickspi_dma_deinit(qsdev);
 dev_deinit:
 	quickspi_dev_deinit(qsdev);
-unmap_io_region:
-	pcim_iounmap_regions(pdev, BIT(0));
 disable_pci_device:
 	pci_clear_master(pdev);
 
@@ -699,7 +696,6 @@ static void quickspi_remove(struct pci_dev *pdev)
 
 	quickspi_dev_deinit(qsdev);
 
-	pcim_iounmap_regions(pdev, BIT(0));
 	pci_clear_master(pdev);
 }
 
-- 
2.47.1


