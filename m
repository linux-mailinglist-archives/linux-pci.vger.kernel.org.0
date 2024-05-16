Return-Path: <linux-pci+bounces-7552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDE38C72F6
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 10:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BEF4B21F63
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32B4133401;
	Thu, 16 May 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KiGuGY/3"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3F7829C;
	Thu, 16 May 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848634; cv=none; b=r0aGPjP1eK5+e/tRDMU83ih0S0E0gxPmT4oj37cTYqGtu5y53BP8sgJeZ31CSfAFbRDD4R43U8SUJWGzrhSI3PeQNYXn5Ot53Bq38UePBi2ruj3X0tyo7KREg6vCe2keU6YHRdFb5HVeQsH1wvuJs0hmC6B/14pjyFFkikyqCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848634; c=relaxed/simple;
	bh=p1TDTHB+gDApLl2JnMKdQtfTOQu61TwnB5cs/mE/78s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UncwS6J6onCMf3X5NgvWF1Fk2a5+bkLr3QkaBOAsxICRE3GAqx18xd4FogdvU0Sxm/DBifYh8DXPqB1ZSgXR5ZbWknpTZsC+PMHT3Sza+r6hjBbByZzCwVNSEeWCQYy0jgPNOQdo+kVrI94UBL4Bg9uFBnAEguzR3V79TDVaj70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KiGuGY/3; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715848623; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Nn0VvhjDzqkUVvey0Nz7TX61fwgUMsXmbLHYFkVl6ic=;
	b=KiGuGY/3TRTvqhvwre+fkhQCzLkMI2NOBrpQtJdt4MQQ4+AoCD9HSBlOoPKaX/pkvWAuQLZtuFGvXnhPKtsIoeKHYq25BqmY/ZDSIOpsoz+zvQGXWFva4tHDNr/9lZsqjz4Q8RY/fLP5ck31O3YZ+HU+k6tqL7Mm65nll9u9oA4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6arX-m_1715848616;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W6arX-m_1715848616)
          by smtp.aliyun-inc.com;
          Thu, 16 May 2024 16:37:03 +0800
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
Subject: [PATCH] misc: pci_endpoint_test: Remove some unused functions
Date: Thu, 16 May 2024 16:36:54 +0800
Message-Id: <20240516083654.44087-1-jiapeng.chong@linux.alibaba.com>
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
 drivers/misc/pci_endpoint_test.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 4f3ec1f2ba9f..5d98b82da17a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -141,18 +141,6 @@ static inline void pci_endpoint_test_writel(struct pci_endpoint_test *test,
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


