Return-Path: <linux-pci+bounces-19601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2187DA07212
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 10:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511537A21CE
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9A219A70;
	Thu,  9 Jan 2025 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hf30FJTy"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5E5218EBD;
	Thu,  9 Jan 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415989; cv=none; b=hGCP6qrUddCgrv19VZX8Pi7HZYh506ZbVWvk4XuukQwagCcDXCmhu8/agjuuoFi9KWsS7KsKIN32k2Yc6lR+jJUk+ydsC0Jz+4wfFpkz4q9pWsMqWrNvwg5QrlCkXjVxxYlLmHEQOpJBXoEU3siDJCTlauS8QD90AkcrWa7rNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415989; c=relaxed/simple;
	bh=0EHq9dnHa3RePe47elKr8iVapjS/Yb6yjGxe6SjiRz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmCF3oi6higYKlUYlbxES8svkxh7DpNq3HGRjCYrKMARuOgChxdvQKQ/bh0R/PvvBLDF10Yfy6o0VAuYOxVp7W7vOFgu9uGnBx/TSC5GWlCVGyjm7Q52iUUIldbf4rv2buwxoi26Xu5Mh5Mcfa2hAdz39XplfS1YjYn6Lc0QVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hf30FJTy; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2KkwN
	vTms8tc/ou5IFjWkPFbYSQYerIwTcfjHGS9w5Y=; b=Hf30FJTyZoBFc4g5D3+fb
	YygPHdFFQpnppfGbQoNHK2TP9pZFZrYwc1gZj6vWcKWbHhf2gFfwuFMR6CPOzIo4
	8fDfPPA/m+kkGuQJZs59e1Vulz71xuOACoQEYWLQj6i4wGBkyG1KFBDuUR9rhxuF
	i3cB71RpB59SbrT2ztrGv4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3t7rYmn9nRKzYEw--.38788S3;
	Thu, 09 Jan 2025 17:46:01 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: manivannan.sadhasivam@linaro.org
Cc: kw@linux.com,
	kishon@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [v11 1/2] misc: pci_endpoint_test: Remove the "remainder" code
Date: Thu,  9 Jan 2025 17:45:55 +0800
Message-Id: <20250109094556.1724663-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250109094556.1724663-1-18255117159@163.com>
References: <20250109094556.1724663-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t7rYmn9nRKzYEw--.38788S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww45Jw1rCr13JF4kJw1kKrg_yoW8Wr4Dpr
	ZxCry0yF4jyry8Gw4xK3ZrCFyFyFZrXry7JFW5Cw1FvrnxAFn5tF1UGrW8Kry8CFZFvF1Y
	ya1DAa1v9w12kFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXo7_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDw7Po2d-kzQzswAFsX

A BAR size is always a power of two. buf_size = min(SZ_1M, bar_size);
If the BAR size is <= 1MB, there will be 1 iteration, no remainder. If
the BAR size is > 1MB, there will be more than one iteration, but the
size will always be evenly divisible by 1MB, so no remainder.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v9-v10:
https://lore.kernel.org/linux-pci/20250108072504.1696532-2-18255117159@163.com

- Remove the remain variable declaration.
---
 drivers/misc/pci_endpoint_test.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee..f78c7540c52c 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -280,7 +280,7 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
-	int j, bar_size, buf_size, iters, remain;
+	int j, bar_size, buf_size, iters;
 	void *write_buf __free(kfree) = NULL;
 	void *read_buf __free(kfree) = NULL;
 	struct pci_dev *pdev = test->pdev;
@@ -313,12 +313,6 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 						 write_buf, read_buf, buf_size))
 			return false;
 
-	remain = bar_size % buf_size;
-	if (remain)
-		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
-						 write_buf, read_buf, remain))
-			return false;
-
 	return true;
 }
 
-- 
2.25.1


