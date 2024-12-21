Return-Path: <linux-pci+bounces-18931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6989FA0ED
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 15:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E89A169C96
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4801C1F37B3;
	Sat, 21 Dec 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lyrgBtf7"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3231A3BD7;
	Sat, 21 Dec 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734790310; cv=none; b=simYIGKDGeZAsut/OcLIABPUpJWVeE2KAzPVvtWUnzcXhcCMp5nUcBq2IG1D7brdzq3khePdPbJuXAAQR3ZTsRWD6ynKEeEAbmFSxg+GR/g2aBn9g5+KRb8P2uyij0weOp8gELfrReYwwFpue5cxxEo1YWJOZOPeXu5ZbpA2Ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734790310; c=relaxed/simple;
	bh=4OAX6nZP1YQ45HXw3GzIduMUTIazI8OHiD5eDcNZOE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hR60dv22+B3AyRTdHc2JRQ36015/GJuuFDPcYrKcIQ/mOELHWHGh+8b2lSkfT+nVZQvdR60j4IZB0MweVzNK+IpPSZViq+t13t1L7jPCcDZvuCznzK1oTaiIEaa2tIxMo8sTbBFj7eco8bKo5Io9jf5SvVEUWxoIBbQNMhOXpBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lyrgBtf7; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ErDre
	KwpHAXR5aeq+4ClwKZe6oaWNwwvRPfAt9lEDi4=; b=lyrgBtf7BdUAUjSEM570M
	iuGaOJ7wknReYoFASUTvztBwdcMtOEQjXQYr4/YRChy2gW9SIXlT4dWCyDkqEuow
	QNf8VJHCbu8X0/ZfCGhJCcAsncuYZQ2NxwpFU59npxRAdLiwmG50T+WFpkcRMSpM
	HbN+bj/XiPP4vdxZwP7u8o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXrx5RzGZnp_LeAg--.13848S2;
	Sat, 21 Dec 2024 22:10:26 +0800 (CST)
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
Subject: [v3] misc: pci_endpoint_test: Fix return resource_size_t from pci_resource_len
Date: Sat, 21 Dec 2024 22:10:09 +0800
Message-Id: <20241221141009.27317-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXrx5RzGZnp_LeAg--.13848S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw18Gw1ruw4DJrWxAF43Jrb_yoW8Wr15pF
	ZIkw10vF4Utry8Ga1xK3WDCFZYka9rXry7Wa98Aw1SvFnxZFn5t3WUK3yYkrnrCFsF9a12
	y3ZIya1vgw12kFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziMq2_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxy8o2dmyog1MQAAsL

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

The return value of the `pci_resource_len` interface is not an integer.
Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
overflow.
Change the data type of bar_size from integer to resource_size_t, to fix
the above issue.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>

---
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


