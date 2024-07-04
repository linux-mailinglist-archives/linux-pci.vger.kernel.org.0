Return-Path: <linux-pci+bounces-9772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF258926D76
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 04:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7B51C214A4
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 02:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E51D101EE;
	Thu,  4 Jul 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BVcow7ke"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9C746E;
	Thu,  4 Jul 2024 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060385; cv=none; b=WV+rAtRLoTwfF5up76XhIxFXjXiRbIuYIswqgfh3K5jhpCiexI/LVssmYpzTRrlrE7hgr6mo11C/BPj5lIwXn5WBKvZPgM8Yd+9yCanx1gDu/0lTvDxWuO3HWqSm6jwy4N0ViCo+CzDpmjGshW1OdjCwtuQoS7bdWgfFbGikrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060385; c=relaxed/simple;
	bh=ee02O+++14K9GHm/mKtEx9cc77z4K/DFrk+DlL0bo7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cT3R/+2/wl/HRoGni20qTotHQlhI3F0ndLFu2JyWboNe9NrsZY7O3ZgOmZsKwCMmsOHM6a6CinFAihSHexw59z5yEdQ8aAZPQ3a7MSfsR5goPfrqz8KsHSkYrjy2Wk2n8c+5kyiQqIA+H7JfilXLb4qT1hx76o0YQiJdahDjqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BVcow7ke; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720060373; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=78YGsjOOGo0zio08x8OYFbINkIOfsuQX7MZ4oX6IlWg=;
	b=BVcow7kekEYzpid/Thne1QqjwMrgbeEwQyZXwOJcwIsglC9Q242WUTZBIdvNzNEN8FYr8exrs13eIs6DpWCTWbgOl+K/QVlkBWI7fEvTE0GuWx8luJ6nI6yPnVXlbagBY1hLpwzYhAFBCCSIyiG9ISU9s0IGc/WIvuV3MJCr8D4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9ohDOj_1720060351;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W9ohDOj_1720060351)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 10:32:53 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: manivannan.sadhasivam@linaro.org
Cc: kw@linux.com,
	kishon@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] misc: pci_endpoint_test: Remove some unused functions
Date: Thu,  4 Jul 2024 10:32:27 +0800
Message-Id: <20240704023227.87039-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions are defined in the pci_endpoint_test.c file, but not
called elsewhere, so delete these unused functions.

drivers/misc/pci_endpoint_test.c:144:19: warning: unused function 'pci_endpoint_test_bar_readl'.
drivers/misc/pci_endpoint_test.c:150:20: warning: unused function 'pci_endpoint_test_bar_writel'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9064
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Modify the branch name in the topic. 

 drivers/misc/pci_endpoint_test.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index edced893221e..3aaaf47fa4ee 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -144,18 +144,6 @@ static inline void pci_endpoint_test_writel(struct pci_endpoint_test *test,
 	writel(value, test->base + offset);
 }
 
-static inline u32 pci_endpoint_test_bar_readl(struct pci_endpoint_test *test,
-					      int bar, int offset)
-{
-	return readl(test->bar[bar] + offset);
-}
-
-static inline void pci_endpoint_test_bar_writel(struct pci_endpoint_test *test,
-						int bar, u32 offset, u32 value)
-{
-	writel(value, test->bar[bar] + offset);
-}
-
 static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
 {
 	struct pci_endpoint_test *test = dev_id;
-- 
2.20.1.7.g153144c


