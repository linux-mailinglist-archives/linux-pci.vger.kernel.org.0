Return-Path: <linux-pci+bounces-21345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C2AA34087
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9993A8F97
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DE370830;
	Thu, 13 Feb 2025 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+dkZpsR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7AA227EB5
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453964; cv=none; b=WqX7BVBGGb0sfJK8NaD/eE1TGybm6VZHTC1Geggmmdr11br0ppmLcmhwHlq8HjrLa3kWo45+TProcwKZptcGRGcEIXad7WBvEq66ajrcd88xVu1VtjRcFE0MRvFi6HmL+K6ICXu9XVm+DbToZG1CmRCUzsESajpv88IycImDGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453964; c=relaxed/simple;
	bh=3Y8JAMvGwkl0I4uP/Jr71t7t/vUuJfYtZWoM6GgZXfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxmB1Yi9c8NeFTMT98rr14m7wGI/frtXijWb5G3tO1JMuDv94c4j0RJ9SjMrmIfnYlx2VKpeiICIjYdmoaBPA2/sjK6FXCEoWzPdvKj6sRwHBUc/zuEneKSkcB9bEfOGM9WXhnGin/U3h5+EnW+z51fAWBR5C3AcAztHSOjqtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+dkZpsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777A4C4CED1;
	Thu, 13 Feb 2025 13:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739453963;
	bh=3Y8JAMvGwkl0I4uP/Jr71t7t/vUuJfYtZWoM6GgZXfI=;
	h=From:To:Cc:Subject:Date:From;
	b=k+dkZpsRhp0RUgGSypGaPL2P7+yUHGHbYQhDQzszjajGNYsLVZ26a+KEq069YNC74
	 GILZOeDumDo+dnn5znYbB8XpqPGVJvJxsmXy7BFhTK2Co5MFaIh46mG/+O6uFl7i/f
	 vHY4CEmCOdCP+GS8kVC7mezRGIooOLNp+e0AFlda4Uyk7g5YTYqGGsGsaWyt76qwRs
	 3yne3+9IQWbuMHrg/G29Mk80MfZvFSqIpsNPp24Qta5zUowlzXuBIYFZdJ6nCvSqTJ
	 2eLcNoXgcr+pQAWXbagKuau8vlu4DFsPx4QES82IHJQjz3beCoO+d/Fky16thmmvZn
	 8QtGQdtlS9CYA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3] misc: pci_endpoint_test: Handle BAR sizes larger than INT_MAX
Date: Thu, 13 Feb 2025 14:39:14 +0100
Message-ID: <20250213133913.17391-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2867; i=cassel@kernel.org; h=from:subject; bh=3Y8JAMvGwkl0I4uP/Jr71t7t/vUuJfYtZWoM6GgZXfI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLXfmOc/Kdq9m7PwuCuB1qP4/5mbdl18dHOl1aHlxUuS 54p6NE3raOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQAT2WfGyHBENcDzQ1CjuccJ U+bnkydbn7F+/eKMwfrPnUY2/y6f1drE8L8sIl50y23VLX8nHfn2QDFrh5z6Fd2mq3K7o1dkPw+ /94IZAA==
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

Fixes: cda370ec6d1f ("misc: pci_endpoint_test: Avoid using hard-coded BAR sizes")
Co-developed-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v2:
-Add Fixes: tag.

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


