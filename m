Return-Path: <linux-pci+bounces-21170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9DA313AE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E03A206A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1CF15D5B6;
	Tue, 11 Feb 2025 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="wG+QOZrJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD759261567
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297041; cv=none; b=WpVwCB+hbW9DLmw+ptdhm37fw1KAkrRKTwLOf1MyekRjxPsgBy1lMuyTJl6LUyNrcG87GDbit1eyVt4gu1TDe6XDarKJmsa9AUfgDeq8FhaQv5LSfviSsYqsZCKnYpe0wpxpnbhzr1U5Ld8dLmtQ2zZW4gr5OIinZ4uGFXfKAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297041; c=relaxed/simple;
	bh=KIGMM0N6CjroaMsYOJVZszQPqE6VQrNKHRuRyjP98tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LKC5RHSbWZjZVhNQkS3HFsRssfBz36ULm0XV9vWkMeWeVsAeg8oTt8BwNfSkPTyUMGAFNb7PKnQjF66Ffo3KAYNPqi/WLjwWGJQlpdF3KsTiH6hp8cfmjlVAJQNrYwtUI8d7Y4NtCjYbZQ9eR66w/FOnbkaqreZ2YnYvHmjsMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=wG+QOZrJ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739297036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K7JSfZdCEP3Idl5kDO+G+sKH9a6eATwp8CEJF2PUE6A=;
	b=wG+QOZrJgyf8kOiCuxbSd81Ul9W3l+YWYL9xzSUpZdMTGoFB+lA7rZPwVRAeSTA74Ce+co
	W9NlcvAa1N/tlaUyLwvMtqB/N2+StzfdK5sMDcKrUsqE/xX+XK+RcjWwXngj9Ha0V9vpl/
	24JHYnd/F1A1gSlvpOs7qYD0noTe0CCu7qi+6wiJ0lldR3+Ua2qcvF5EJbaR5v4TJCEzsX
	lXAvkvqTz1OLcCw6Hipn9cHFMfnzV2CH6GB3xdO4mSU+Uj8doA4GtgSRdk4FGVfezo7pKG
	3bCREP4lGaewknee7s8C2JxrzngsC0XrJWqmas+9xrp55G+G8egDlwTkoVwsqQ==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 13:03:52 -0500
Subject: [PATCH] PCI: apple: Add depends on PAGE_SIZE_16KB
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-pci-16k-v1-1-7fc7b34327f2@rosenzweig.io>
X-B4-Tracking: v=1; b=H4sIAAeRq2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ND3YLkTF1Ds2xdk2RjS8NE05TkFEMLJaDqgqLUtMwKsEnRsbW1APp
 RW3lZAAAA
X-Change-ID: 20250211-pci-16k-4c391a5dcd18
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=NOORioVOFXRhJhVOwEZ7Ua7BZ7jOxcm6+yMrVQKAGoA=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq5EKeLrT3LblCbuJhwHVOCOfPajQEfi9SV9ul
 OV42I36hq+JAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uRCgAKCRD+/lBaCvVY
 DUphD/9vh+Jv6BuOz5cCHuMvYDvxMRsLIjMm1sizoGEuaCyc4g0Degsbxm7KUyxAC2daMaZOP68
 XjPWE+2IkralTqsVfs68dh1ncwtjofl/WygKOO1rIR6QYItwI6ckcfml5F7MFowzjFpVuTbqz4+
 bH029VJPf/NdHEKhAWtDLJK3DkS/9d4v7XLzrSDoQukpCmFEuDhVngRagqw27sI8aIuuqQ6wn0W
 jKmNMaMuzbDpXhBGfDv/IpGOTQHHzoL1HbX6oGH7xGE6hH5z9zp3DpPxJWlvsw1v4Ue2rRMpeDe
 kuzC0sBVvNSxRhsLYS5DilbsHxPSwD6Jb8froX+al3Z8NDFPXJkx+DUAnQtDLj/XGwVbYXTmbK/
 XMaOHzw1Mf/heCxBvzkaN+pibK42wgTtow6MkNGYSZyy+Yf0W2kjriRgyInQtrrcaVXM1aBHJTP
 nnPJF0k22cZVteyP4sHzzoexo2wtNic2M1jf9h9VIY3wU1eja8O4JY4xRGYXtQ1qN2EsdboT1q/
 W9FlVScJfaIWhUZ4jz9lRG5RxHmwYKGCQjfOTkFUpslGpVUFm+yDfv1Kb6Yk+9eYls1dvaawMOa
 51qMBLICHwEzOZdZnI9ZvWywTNw/POOlTJu6mIMtJ6BXF7EGxTmeTHz3b/61cYDFh94gWuNxH6k
 jy2jF1q2CUyUMaQ==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

From: Janne Grunau <j@jannau.net>

The iommu on Apple's M1 and M2 supports only a page size of 16kB and is
mandatory for PCIe devices. Mismatched page sizes will render devices
useless due to non-working DMA. While the iommu prints a warning in this
scenario, it seems a common and hard to debug problem, so prevent it at
build-time.

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/pci/controller/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 9800b768105402d6dd1ba4b134c2ec23da6e4201..507e6ac5d65257578e4eec74b459f6605c9c2907 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -39,6 +39,7 @@ config PCIE_APPLE
 	depends on ARCH_APPLE || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI
+	depends on PAGE_SIZE_16KB || COMPILE_TEST
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want to enable PCIe controller support on Apple

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-pci-16k-4c391a5dcd18

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


