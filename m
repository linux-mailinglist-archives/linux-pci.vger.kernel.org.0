Return-Path: <linux-pci+bounces-19514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01FFA05509
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8CF165D0E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6F1DFD85;
	Wed,  8 Jan 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JpDtITPE"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E61DF255;
	Wed,  8 Jan 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323909; cv=none; b=XUOzsN0c7aUAhVFZuOZtkHcXF5bJgz2dAFkdNaA5X3ty5LoSkD6M7N70zwos1UtMwHLgGL4vbK+8U0Xhmld1BI6JcU31Ji4T2skASPgs1ITJpjYl9wUQuhT141Q9+n9NILiZRa7y1gbunE1fdUfpEpZf+5sYGn6TEizsXYL8JpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323909; c=relaxed/simple;
	bh=B20//Nxo7KrJRxecgE0VK6/BNTwWLzub47DZ7fWkh7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FeDGgLiDhw2iZaCMHTST5R4aaltwasvSkvRyrWrLI1286ar7qp8sz4XMxRvxVjzBAc6V41dZtgol1d4fJ4MEQR32y8knu8IrhCgjryykoAsA588WOtP9jKCSf6+rzBVXo9OeaAKe6vXa1UgGfeOLzPZ7mbIcXDneF2/9d3pIRn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JpDtITPE; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qim/k
	O5p3rdm6ZjllT4hLqqhz09hnjs6wKFbgB7TGVc=; b=JpDtITPEiO0BSma2vni70
	+F59B35+2MTz2yNymLkzkkiQp41NRW2H7d7T3eekZFbZc7D4XuP9z8zB7Rlj5L0r
	pCgQh3Iy33c7IJftL0hwxIXg6C72jblc6+AnFhEvURF46m2pgwe8E5MG/9LqOjfO
	TpBtdaZuERthJn35RQdL8Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBH9z0ZM35ntarHEg--.53777S3;
	Wed, 08 Jan 2025 16:11:09 +0800 (CST)
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
Subject: [v10 1/2] misc: pci_endpoint_test: Remove the "remainder" code
Date: Wed,  8 Jan 2025 16:09:50 +0800
Message-Id: <20250108080951.1700230-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108080951.1700230-1-18255117159@163.com>
References: <20250108080951.1700230-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH9z0ZM35ntarHEg--.53777S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww45Jw1rCr13JF4kGr4DJwb_yoW8WF4Dpr
	ZxCry0yF4jyry8Gw4xK3ZrCFyFya9rXry7JFW5Cw1FvrnIvFn5tF15GrW8Kry8CFZFvF1Y
	vanrAa1v9w17CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUYFtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx-Oo2d+Kwjf3QABsE

A BAR size is always a power of two. buf_size = min(SZ_1M, bar_size);
If the BAR size is <= 1MB, there will be 1 iteration, no remainder. If
the BAR size is > 1MB, there will be more than one iteration, but the
size will always be evenly divisible by 1MB, so no remainder.

Signed-off-by: Hans Zhang <18255117159@163.com>
Suggested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v9:
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


