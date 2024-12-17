Return-Path: <linux-pci+bounces-18603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C969F4ABE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 13:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE1C16F124
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 12:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49641DAC88;
	Tue, 17 Dec 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gd20w65/"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E166E4D8CE
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437588; cv=none; b=N1WivW5lr7e71GMRTnH201fSfKTaqNkmR6LaxR/pOjJbC36R9BY9FDaYzfHjOUo/qhlOKAtlUtAompen1Xm8vv1mOAfJSyim5OzEJRws/VTUKbInJwBxJL7yiA0IspbAuQ0jMtGVNYv0mEFake3Vy9BaYTZ/Fgxr9Qje71FN6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437588; c=relaxed/simple;
	bh=9qnMXPea0TMkfAUZ7DwfhizkPmA5yDstwmaR49DRQOE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=T7Cbt2OWKq0m6celLcPfuWhwl4POyNsfTlxMelfh3UXiPRc75tiVNSs5HIfJ8ODkN/tLL2vw11rHRm4LYc1ZazlWWH9a1BEtEV1qqYj/ede6SrDwCR0p03GCGInA/JcA5W1iV6YezKcI89ONrE8StDCz5MjnooDDAB+rIKoh3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gd20w65/; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=+jKgIThs09MvIq8+Vw
	z+A+qwUGnSTOUWB4siy6x5W8Q=; b=gd20w65/p5KLVhs7SOYxVm+mD4Xw9wDzae
	fKWrNj8b9S7zl6Ikr+tT/IudXPGY22yakq7aNUQC84fSVzWmRmICfRtt5g1RRzNn
	UwLGp6qDS1HH3/EzfFZvO9LodM3YcEUDnKHmy1+C455O3wx9LUwm3c44dREL7Sh/
	CB7NI1dRM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3N+SnamFnuE+xBA--.30878S2;
	Tue, 17 Dec 2024 20:12:25 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: manivannan.sadhasivam@linaro.org
Cc: kw@linux.com,
	kishon@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	inux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] misc: pci_endpoint_test: fixed pci_resource_len return value out of bounds.
Date: Tue, 17 Dec 2024 07:12:20 -0500
Message-Id: <20241217121220.19676-1-18255117159@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3N+SnamFnuE+xBA--.30878S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4kCw4xZFWDJF1DtFyftFb_yoW8Gr1kpr
	ZIkw109F4UtrWDGws2g3WkCF9YyFsrXry7XFW5Aw1avFnxAFyFyF1UGrWjgryxCF4IvF1j
	yrs8tayv9a1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUwIgUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwm3o2dfexme7QAEs-
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The return type of the API is inconsistent. Inconsistencies may
result in out-of-bounds. If the bar size of the EP device exceeds
4G, this bar_Size will be equal to 0.

For example, there is an EP device, the bar0 size is 16MB, bar1
size is 32MB, bar2 size is 8GB. When testing bar2, barno equals
BAR2. Then run pcitest -b 2, console will output "TEST FAILED".

Variable declaration of bar_size is int, the range less than or
equal 2G. The return value of pci_resource_len is resource_size_t.

Signed-off-by: Hans Zhang <18255117159@163.com>
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


