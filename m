Return-Path: <linux-pci+bounces-20279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56AFA1A1E6
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 11:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1CF3AC2B9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0320DD43;
	Thu, 23 Jan 2025 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb8m9hh9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55E020DD41
	for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2025 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628302; cv=none; b=ss0cqsVnj2NjeRiS3ET15/NHrfZgqoBWZnGosRFJNjvYvKdIcLBZmLU+Mweuo6MnN98ZQPj05YTT6ejBVp+kYtNNIiAxTxtHr1Zxo+1m+8sQayq1C16q/RzsZI1QLQH51lDMDktVSIn0VusGG7lTsii66F2DcxKFimw8uWC44kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628302; c=relaxed/simple;
	bh=HXklcVYu/8dPQuBGtv6xUQJ2MexueACgOe2Auq5m210=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EQbAjMTmtHqRKk8n59Cq+X1qEQSpaOlOq4PFvb7E5ht/4+cyFBPYtSa5v2TmKvJkgO9JANxfCihyGnBa78IJ8SGL4I5/SGNDFhMVCyJLtK4FBZLkBNPy1C/EWdqyt7C7lAgzRKhBKS2QC3BxgQhzznhk8DYhnq52CQLWNY9FRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb8m9hh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A369C4CED3;
	Thu, 23 Jan 2025 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737628302;
	bh=HXklcVYu/8dPQuBGtv6xUQJ2MexueACgOe2Auq5m210=;
	h=From:To:Cc:Subject:Date:From;
	b=Gb8m9hh9w7LyE8x92wQuaE2MOt7Y35gwUM9oQt/tNnuSjc4mewGNi3aFmaQIUtHX4
	 CPJz7mbwrPe3yWBtaijwxvyRsf9PVchGmGCWMzuanIg8nvsL4RxCpgW4r0dYyjzU1j
	 H6/Th2z34zzn7uQs3XSbEpj/fgIBRSxc9q9qL6g5iHX5BaRkWa07hsTwMYouYmrX+G
	 pVHgKdfHSo2uHc/2jdIcOoPXa/HYDujL0sG2sxmaq1HzmjCcFTS+FatcLOM2VXxM9L
	 hB0wlCqX4pr0k7KClrONU+wYMQ8Yut2ybPMJnxGglD0MYJsl75BylZJvIxiZY6HgYt
	 TzTwtbU2fnKqw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] misc: pci_endpoint_test: Fix potential truncation in pci_endpoint_test_probe()
Date: Thu, 23 Jan 2025 11:31:28 +0100
Message-ID: <20250123103127.3581432-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=cassel@kernel.org; h=from:subject; bh=HXklcVYu/8dPQuBGtv6xUQJ2MexueACgOe2Auq5m210=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNInSdV7P3DmOrz+eL5qyeE3Zl/3xnm8+nppHfu9/OPHF xspiD/51VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJKM9k+O+mJHb5hsW+XQq2 Gl8P2Vw+59qdUPAye444851ds+Uv33jD8Idjhs4K5zkBtkGy9bP27dD8Y7z+hdlnV8EVlu+N0p1 tulgB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Increase the size of the string buffer to avoid potential truncation in
pci_endpoint_test_probe().

This fixes the following build warning when compiling with W=1:

drivers/misc/pci_endpoint_test.c:29:49: note: directive argument in the range [0, 2147483647]
   29 | #define DRV_MODULE_NAME                         "pci-endpoint-test"
      |                                                 ^~~~~~~~~~~~~~~~~~~
drivers/misc/pci_endpoint_test.c:998:38: note: in expansion of macro ‘DRV_MODULE_NAME’
  998 |         snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
      |                                      ^~~~~~~~~~~~~~~
drivers/misc/pci_endpoint_test.c:998:9: note: ‘snprintf’ output between 20 and 29 bytes into a destination of size 24
  998 |         snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8e48a15100f1..b0db94161d31 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -912,7 +912,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 {
 	int ret;
 	int id;
-	char name[24];
+	char name[29];
 	enum pci_barno bar;
 	void __iomem *base;
 	struct device *dev = &pdev->dev;
-- 
2.48.1


