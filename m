Return-Path: <linux-pci+bounces-20324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9BA1B2A9
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862E33A8341
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991C01D417C;
	Fri, 24 Jan 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNHPeuRg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BCE23A0
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711186; cv=none; b=mBWRM2RnUbfPHf+uJR0fE9QLzz4GogmdpiXUNPzned1QAeS8ijDKe6UpuzYJLRGcb7uv8JiiTdGPpfwqYyK5YJGHOpO9T2lE5OoM9bEyul87zepMeJ8KX1VB/k/tMYaqZdM2O3t6ba/A2wMY/FJAEqUl4MGZP3Koood+IIEaApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711186; c=relaxed/simple;
	bh=lhztTSuFmyr0wxDvsbY5/F+/4AQtRTxxTucS/qEDPus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPNHxTY16Rh2hmvRfriX3H97ZeIYau4O/MBkbVpC/xvyJmbhb4I2yzMCj6cGJZQfUWX43nDmC0PrFhYX6tgeUlGDUQd4Q3XJf641haMrZdBJmdS+y1YG4VBBj3QZlLQ8fmn2BJKM+4+TVny3jYAShNp9PCUfOht0aXtekFngKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNHPeuRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE79C4CEDD;
	Fri, 24 Jan 2025 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737711185;
	bh=lhztTSuFmyr0wxDvsbY5/F+/4AQtRTxxTucS/qEDPus=;
	h=From:To:Cc:Subject:Date:From;
	b=MNHPeuRgikyX7L7rNxiT3h8TY4Wf4Kl1bc0M+fqLHVD7qvEPrDgd1UshDhndV53Yp
	 E96yestQt8ze2wDdLlzeX/JQT+wfrX8pCzs85a5mOoWlZqAyZ5SUOEzk3bNG1o9EN6
	 QQOVcfcT3hzSs3ISZtHxJwXR3ZHo6vtJDyIr0I5YHmkeIFLlX+K2HKzznnR1N22vKn
	 J6Rkn/swF+C/CPcNK0sM6nWwu6v7k72zWn/dD186SeH5B4kzmHl3m/77lz183b6xy3
	 bt2nrquPsGSPAMfuq9ijpoPslzukUsemktaZP9yGzoGp7BogmUE0r5Lt3OYKiUfTaF
	 r6A7QEA3LFRbQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Frank Li <Frank.li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] misc: pci_endpoint_test: Handle BAR sizes larger than INT_MAX
Date: Fri, 24 Jan 2025 10:33:01 +0100
Message-ID: <20250124093300.3629624-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; i=cassel@kernel.org; h=from:subject; bh=lhztTSuFmyr0wxDvsbY5/F+/4AQtRTxxTucS/qEDPus=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNInx/m0F9ir8EZ1bQry/dMsZbZWa9+Bt6cz1vvOuhAvF nqRdVFPRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZiacfIcOUKb72yX5b0tNnV BwoX/r4vez2ubbLNM9WvTxiXOD/IeMDIcG+plILkHJa5L/rNpt36oHltTcne/yKvj76Mmreb+1y UHwcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
is e.g. 8 GB.

The return value of the pci_resource_len() macro can be larger than that
of a signed integer type. Thus, when using 'pcitest' with an 8 GB BAR,
the bar_size of the integer type will overflow.

Change bar_size from integer to resource_size_t to prevent integer
overflow for large BAR sizes with 32-bit compilers.

In order to handle 64-bit resource_type_t on 32-bit platforms, we would
have needed to use a function like div_u64() or similar. Instead, change
the code to use addition instead of division. This avoids the need for
div_u64() or similar, while also simplifying the code.

Co-developed-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Add reason for why division was changed to addition in commit log.

 drivers/misc/pci_endpoint_test.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d5ac71a49386..8e48a15100f1 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -272,9 +272,9 @@ static const u32 bar_test_pattern[] = {
 };
 
 static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
-					enum pci_barno barno, int offset,
-					void *write_buf, void *read_buf,
-					int size)
+					enum pci_barno barno,
+					resource_size_t offset, void *write_buf,
+					void *read_buf, int size)
 {
 	memset(write_buf, bar_test_pattern[barno], size);
 	memcpy_toio(test->bar[barno] + offset, write_buf, size);
@@ -287,10 +287,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
 static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
-	int j, bar_size, buf_size, iters;
+	resource_size_t bar_size, offset = 0;
 	void *write_buf __free(kfree) = NULL;
 	void *read_buf __free(kfree) = NULL;
 	struct pci_dev *pdev = test->pdev;
+	int buf_size;
 
 	if (!test->bar[barno])
 		return -ENOMEM;
@@ -314,11 +315,12 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	if (!read_buf)
 		return -ENOMEM;
 
-	iters = bar_size / buf_size;
-	for (j = 0; j < iters; j++)
-		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
-						 write_buf, read_buf, buf_size))
+	while (offset < bar_size) {
+		if (pci_endpoint_test_bar_memcmp(test, barno, offset, write_buf,
+						 read_buf, buf_size))
 			return -EIO;
+		offset += buf_size;
+	}
 
 	return 0;
 }
-- 
2.48.1


