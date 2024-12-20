Return-Path: <linux-pci+bounces-18862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A69F8D7C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 08:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49239189384B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 07:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3557219992E;
	Fri, 20 Dec 2024 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WE7jpOS4"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D2A8634F;
	Fri, 20 Dec 2024 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734681285; cv=none; b=auDGKApK8HE4Ehm367DDh+cL5hc9LlPmSBTdcUORy/FdqFLseZBfvsrhj/2z6aeHuLaGSoOHV6t0sypir/933no4nhn8CwvyU4Vx9QzsmYE2zhAC2JFVsXaJwfeC1BWFiZEmqXRhEYwEUqHLkyEnbNf2FWmcX56x9sxI33wzHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734681285; c=relaxed/simple;
	bh=rTGxQIDmKA9G2HRmAkMfQyfAxZ+Y7vzOfn1ymprfzQE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=K26Szk6BspeJB3XXv+0szVwS/3JBWVkx7zUrVRwCM8uPUHTtCZSyYH6fp/W/IJ4yCTewjcfN5jE/cgMqGhOpbf18rcsEsz3TmaY+6yItqsLch/Adv/8QkwKo3THHKxmkyIlIwtdtL/LONd3+WhBe6hTX9isOfM5VHo6LAK1T1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WE7jpOS4; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=OjJ428VfChl1JSIraZ
	FFv7dkml0KQ2wq8E5GCtkeFIk=; b=WE7jpOS4mcxach6iA9JOFCcQGILU7FenYI
	wBwQADUMeAWNKx8ueWCPnMpJ7vfOp7kj19P4KjsPepHg2BDCA9A5zvgZawSTvrxt
	p+uQccvk7GcRaMS8dTn0vtYDn0cWAqa5Ed8Ct71td2KWmZIUMN3IAEXiOrw2iiwj
	Wz4zUtRsA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAnnipZImVnv+a6AQ--.45715S2;
	Fri, 20 Dec 2024 15:52:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: manivannan.sadhasivam@linaro.org
Cc: kw@linux.com,
	kishon@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>
Subject: [v2] misc: pci_endpoint_test: Fix return resource_size_t from pci_resource_len
Date: Fri, 20 Dec 2024 15:52:53 +0800
Message-Id: <20241220075253.16791-1-18255117159@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wAnnipZImVnv+a6AQ--.45715S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw18Gw1ruw4DJrWxCw17Jrb_yoW8JFWkpF
	ZIkr10vF4jqry8Ga1Ig3WDCF1FyFZrXry2ga98Cw1SvFnxZF9YqF1UGry5Krn7CFsFvF4j
	y3Z8AanYg3W2kF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8Ma5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwO7o2dlHv9jYgAAsi
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

The return value of the `pci_resource_len` interface is not an integer.
Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
overflow.
Changing the integer to resource_size_t bar_size resolves this issue.

Signed-off-by: Hans Zhang <18255117159@163.com>

Changes since v1:
https://lore.kernel.org/linux-pci/20241217121220.19676-1-18255117159@163.com/

- The patch subject and commit message were modified.
---
 drivers/misc/pci_endpoint_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee..414c4e55fb0a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
-	int j, bar_size, buf_size, iters, remain;
 	void *write_buf __free(kfree) = NULL;
 	void *read_buf __free(kfree) = NULL;
 	struct pci_dev *pdev = test->pdev;
+	int j, buf_size, iters, remain;
+	resource_size_t bar_size;
 
 	if (!test->bar[barno])
 		return false;
-- 
2.17.1


