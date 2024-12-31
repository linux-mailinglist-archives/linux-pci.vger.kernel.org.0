Return-Path: <linux-pci+bounces-19108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4D49FED62
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 07:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7249C7A04B1
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 06:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D52C187849;
	Tue, 31 Dec 2024 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R0pb96Yy"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E9D145A0B;
	Tue, 31 Dec 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735628183; cv=none; b=V9JgnamCJubB+t505pSbAoHjaFFlQkYv8xEHEFoTZ2Zg6FtZuHw3pxhn7Tvx3W8q5ODNiNLPJgRZOH3HTTmoFGcISsql71isybMQguX6Rtnxou3RuKYc73UGR/Pw0NFtiGHH1VmzllLiNocQX+VOiUOnNp/RdmDjSjvzW+txvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735628183; c=relaxed/simple;
	bh=sO0Qci5Cnt1Tc4MR3/b8pZGHEf9RWcUs3/pgT1H8QF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GQI+RMrLBwP6lKFcWEQfzrCLXBfRdkk5tRQu3jiGCaLf55sLwBHwwWeVmtWPfEMOpa1b2hkRtQYWTuOiGhSHritUBsreN6vChQTgHiyn7jO+pLvfxpDbUbrtCAxKHuuM0IPMXY7GiSAqLODA6R7tHwpizlv/bFxTedxYtViFN/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R0pb96Yy; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RUOGB
	C7/ES982YptCRByVRYml78k86HbLIf7svU1uh0=; b=R0pb96YyO8PJbzKvXg60S
	or4gySkLdhkCwMem831MbIDR2NRCSsl82qu0NOxzvvfJRIwvxxfb5gX+ZaamU1m2
	u38lydld0xogZkSfTmklFCiI8pdrfbWlk3hM+9W2nksHK1t71vZrgv1BBeGpiP7t
	kSzuoTF/ljT0dVRZGaeUQA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3LHtFlXNnOTMICw--.44446S2;
	Tue, 31 Dec 2024 14:55:02 +0800 (CST)
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
Subject: [v4] misc: pci_endpoint_test: Fix overflow of bar_size
Date: Tue, 31 Dec 2024 14:55:00 +0800
Message-Id: <20241231065500.168799-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3LHtFlXNnOTMICw--.44446S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw18Gw1ruw4DJrWxAF43Jrb_yoW8Aw1kpF
	Wakw10vF4Utry8GFs7G3ZrCFZYya9rJry2gFZ8Cw1SvFnxZFn5tF1UKrWY9rnrCFZF9F1a
	y3ZIy3Wvgw1jyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uymh7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxbGo2dzj5ejQwAAsQ

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

The return value of the `pci_resource_len` interface is not an integer.
Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
overflow.
Change the data type of bar_size from integer to resource_size_t, to fix
the above issue.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

---
Changes since v3:
https://lore.kernel.org/linux-pci/20241221141009.27317-1-18255117159@163.com/
- The patch subject were modified.

Changes since v2:
https://lore.kernel.org/linux-pci/20241220075253.16791-1-18255117159@163.com/

- Fix "changes" part goes below the --- line
- The patch commit message were modified.

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
2.25.1


