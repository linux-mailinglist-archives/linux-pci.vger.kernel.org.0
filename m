Return-Path: <linux-pci+bounces-4879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00AB87F06F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 20:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A671C20C83
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A6556762;
	Mon, 18 Mar 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsAZg1D9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7856755
	for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790267; cv=none; b=OP+Ea1JRsPsAfEnVVqT8PpphJdxkJja4bJrqkUyJuasN7/AnImmutodPDJw9Ox2IAQT4EZhi1JSrjSVltfO5WeExj9sz/HpfRfhns7Kmc+iT7sIejMyoV0nXEbgGrGOhe2ew2mA6cu876THCw8Xt/lz1Wo4Fc4GdRkkwy0Tc6S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790267; c=relaxed/simple;
	bh=ZG/7sEgGrupE4SbTG9Fe3p1IzrWq03uchSVcZIyTygE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPpKvHd50xJim7M6XmefkohbllUGrex2H9xcFbgnsv8QPPuG/MfHIJJ/ZXNbtF5ibN1AtiQ4ML5rM1rqHLgP6G6qDsxoJZQE2bwNa1I9SCPJo0akgz6HaCV+q6SzXvWK4p49gjrOg2aeUlxoEcNPoYm7NEGWX5JD+vcorxhjLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsAZg1D9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473E1C433C7;
	Mon, 18 Mar 2024 19:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710790267;
	bh=ZG/7sEgGrupE4SbTG9Fe3p1IzrWq03uchSVcZIyTygE=;
	h=From:To:Cc:Subject:Date:From;
	b=fsAZg1D9vZSDUb10uDMsmCJufEKSwZKbWKOe698BnrLe5KGCbAaRu8S1BQ5qFh30J
	 lEQz4TsF8QmiNR7HixL1bA0CxV9G2MSxmKr+qzSLcaAYmZu+1FMmmp9jIGooEp9FuD
	 AQ1oTKwstQ0g94q0QQkKjH2CMYpojRWM/9RG+H/QXtdoELsRsUlCZAl6DV7B6V9rxb
	 jzmexU8PrISAt9t5Lb37uD6pF4zp6A+Z/8v1UHLjWorOZcPzTD6zUT/YUUD3hB6Vk8
	 uuzlTGnuaGCIsFySbIQl/1+8r4vyjJ90JPiNmX9b3bRVyKee11WC7mn3Qt/YP2F+Vi
	 48t+SUtsFEQ2A==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] misc: pci_endpoint_test: Use memcpy_toio()/memcpy_fromio() for BAR tests
Date: Mon, 18 Mar 2024 20:30:19 +0100
Message-ID: <20240318193019.123795-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code uses writel()/readl(), which has an implicit memory
barrier for every single readl()/writel().

Additionally, reading 4 bytes at a time over the PCI bus is not really
optimal, considering that this code is running in an ioctl handler.

Use memcpy_toio()/memcpy_fromio() for BAR tests.

Before patch with a 4MB BAR:
$ time /usr/bin/pcitest -b 1
BAR1:           OKAY
real    0m 1.56s

After patch with a 4MB BAR:
$ time /usr/bin/pcitest -b 1
BAR1:           OKAY
real    0m 0.54s

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 52 ++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 705029ad8eb5..cb6c9ccf3a5f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -272,31 +272,59 @@ static const u32 bar_test_pattern[] = {
 	0xA5A5A5A5,
 };
 
+static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
+					enum pci_barno barno, int offset,
+					void *write_buf, void *read_buf,
+					int size)
+{
+	memset(write_buf, bar_test_pattern[barno], size);
+	memcpy_toio(test->bar[barno] + offset, write_buf, size);
+
+	/* Make sure that reads are performed after writes. */
+	mb();
+	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
+
+	return memcmp(write_buf, read_buf, size);
+}
+
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
-	int j;
-	u32 val;
-	int size;
+	int j, bar_size, buf_size, iters, remain;
+	void *write_buf;
+	void *read_buf;
 	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
 
 	if (!test->bar[barno])
 		return false;
 
-	size = pci_resource_len(pdev, barno);
+	bar_size = pci_resource_len(pdev, barno);
 
 	if (barno == test->test_reg_bar)
-		size = 0x4;
+		bar_size = 0x4;
 
-	for (j = 0; j < size; j += 4)
-		pci_endpoint_test_bar_writel(test, barno, j,
-					     bar_test_pattern[barno]);
+	buf_size = min(SZ_1M, bar_size);
 
-	for (j = 0; j < size; j += 4) {
-		val = pci_endpoint_test_bar_readl(test, barno, j);
-		if (val != bar_test_pattern[barno])
+	write_buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!write_buf)
+		return false;
+
+	read_buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!read_buf)
+		return false;
+
+	iters = bar_size / buf_size;
+	for (j = 0; j < iters; j++)
+		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
+						 write_buf, read_buf, buf_size))
+			return false;
+
+	remain = bar_size % buf_size;
+	if (remain)
+		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
+						 write_buf, read_buf, remain))
 			return false;
-	}
 
 	return true;
 }
-- 
2.44.0


