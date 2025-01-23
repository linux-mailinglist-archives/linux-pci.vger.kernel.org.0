Return-Path: <linux-pci+bounces-20278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1794AA1A157
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 10:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB853AB4F0
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C611120D4F6;
	Thu, 23 Jan 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk3gArT8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B441C54BB
	for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737626352; cv=none; b=RbxCBZDM11w7tSBFlp9D0NdGA0Cyn5mxF5kk/n8yyaxn3XiZf4kEE3QSNg5BEi8UifY7EV9JpytwOiaG58wCX9qk8bsgu+yaFyrWwNGegZuGD1LDPj9O0PStN09Qt5DJkdWRqtiYs4dtyEEdjU54NGJFLNL41uj2MfNZIZFSpVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737626352; c=relaxed/simple;
	bh=KV417X9LvkzaRugoHAOJ2YXbcMdt1QATdpo87XYNsG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNkdzkdTn2NN4f34/Cmpj3Z2IScqAxJvAjdb052zr+CqiNRPefgRz44ncF78WbnsSdgTWJTtEOe8CATf7c9fvFfreQlUUHoDNM+gq3b7YrzTJs8JlVVT9R6GDvwplwAG/S7JhixGjX+SX+qROiOqLYRw0q8cMt38t8PJmiebxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk3gArT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067BCC4CED3;
	Thu, 23 Jan 2025 09:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737626352;
	bh=KV417X9LvkzaRugoHAOJ2YXbcMdt1QATdpo87XYNsG0=;
	h=From:To:Cc:Subject:Date:From;
	b=lk3gArT8nIOoWq6rL4ENxCava7ezNNPsNIreRBRlven7LUyP63FI5tu5/kkLZ5vlL
	 9HHf1ecuBmHEWziLw5JJbNBvEIO4M6WFY2LA0JxlvnYi9BZHTpsqzigFOxS5NxHJM4
	 6fPtpbVdIDNw4pzGw2kVFXatVZPiPlk7BbhyzFOQXPiaqawPnKkfuJt1ooW71G0TEZ
	 BXufKE+MlxdkG30OxleXVF8k/7faauo4SMf05C2r4gpzLF4xCEvshUHJwUuwtF65B4
	 PJhNJCvQHqKa+eERkZ9b2KbVvNjnQ7vG07tZjVxewEHVhW/ZsG1e6MOTKmqPKHtc1/
	 jHfJAl2rO+9Tw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] misc: pci_endpoint_test: Handle BAR sizes larger than INT_MAX
Date: Thu, 23 Jan 2025 10:59:07 +0100
Message-ID: <20250123095906.3578241-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2581; i=cassel@kernel.org; h=from:subject; bh=KV417X9LvkzaRugoHAOJ2YXbcMdt1QATdpo87XYNsG0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNInCb1SkzBZd6juEJuYWXhmlP2Ch0XXjv+Y8JLvwdnlx uuSy117OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRS5sZGc7wzHG+GJ54Yu2c fR1vVwq4Ts4T/upc+c1jtubda/uYuQ8xMpwJ3M4gwcX1U8BBptEh/LWfyJWkgu8Pn3adcLFpjGS dzQUA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
is e.g. 8 GB.

The return value of the pci_resource_len() macro can be larger than that
of a signed integer type. Thus, when using 'pcitest' with an 8 GB BAR,
the bar_size of the integer type will overflow.

Change bar_size from integer to resource_size_t to prevent integer
overflow for large BAR sizes with 32-bit compilers.

Co-developed-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Hans submitted a patch for this that was reverted because apparently some
gcc-7 arm32 compiler doesn't like div_u64(). In order to avoid debugging
gcc-7 arm32 compiler issues, simply replace the division with addition,
which arguably makes the code simpler as well.

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


