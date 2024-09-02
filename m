Return-Path: <linux-pci+bounces-12591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF4A967F1F
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 08:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC101B20C64
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5C1547C3;
	Mon,  2 Sep 2024 06:06:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B909076048;
	Mon,  2 Sep 2024 06:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257195; cv=none; b=C4OnHpNu8D97D4r2yCE7zGazCjjLoSD2cff6BcJlo83yQnfsJQymR8yqo19dSffLRRiR1gQoYCME37fYNTkxfjV81fh4l14+BIj0w4zMKHlubZ9Yg0m48Sc3RQjR8+XZj6U/ySAbqhz4dN3FyH9ul6gs34bD8KYYfmA8VZ44u4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257195; c=relaxed/simple;
	bh=KFJ0cXGczOCV8rRltWzP1mnOn4axB/P65XGd8PT2ogE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ONNlIBOEAB4OLKpBl+VC3A3nM7ogPT4fyZ8QPkRPR+01yR30sBEjjpJoZV0JbLZ0CeFl6TmkNRJoFevmJeLvkiBW8S52tuMvlmJxspHIAEnoq8kWIe50+IEvXlTN0po2BacH/sgFR7bJCimtuF1PXGq2BnbjSCCSZIy0WOmo5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666d555e43cb-9ec8c;
	Mon, 02 Sep 2024 14:06:28 +0800 (CST)
X-RM-TRANSID:2ee666d555e43cb-9ec8c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366d555e30cb-8e572;
	Mon, 02 Sep 2024 14:06:28 +0800 (CST)
X-RM-TRANSID:2ee366d555e30cb-8e572
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: manivannan.sadhasivam@linaro.org
Cc: kw@linux.com,
	kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools: pci: rm .*.cmd when make clean
Date: Mon,  2 Sep 2024 12:12:40 +0800
Message-Id: <20240902041240.5475-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

rm .*.cmd when make clean

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/pci/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/pci/Makefile b/tools/pci/Makefile
index 57744778b518..f884471e07fe 100644
--- a/tools/pci/Makefile
+++ b/tools/pci/Makefile
@@ -42,7 +42,7 @@ $(OUTPUT)pcitest: $(PCITEST_IN)
 clean:
 	rm -f $(ALL_PROGRAMS)
 	rm -rf $(OUTPUT)include/
-	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
-- 
2.33.0




