Return-Path: <linux-pci+bounces-16513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69FB9C5181
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 10:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF752820C1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F4220BB48;
	Tue, 12 Nov 2024 09:09:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0292209F4A;
	Tue, 12 Nov 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402589; cv=none; b=qf8re7Jlc04p5HgYGB+ob8ceUiW1ow846YpvSUvZ9+pNfpyH+lLSX198iMaAspWLeu/k6tHOHhS3gloq37girOW8/6kp9zVOqcZT9+7HppEpVq5sUj0Ox4ANHTmVVbdf9hpa9tuu7FxrLgEAPq2eJqjtNfzgiGX6HvndB3RcSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402589; c=relaxed/simple;
	bh=QOfIF/AW2EDodN6nhJ+3FHMgE8gfcr523gSgAKkFVYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=frJKRoEwFYIbnEKaxl3U2QM4R3YOD9DjbgNOZwleH6twQ1pGq5tHJYMMRVY1c0agoIi7xwAnmjiem8yepXtfCthbFbdQNX1G937H+ifw+c/Bigxg9PTde6+7tgD6QX5tTX7LbWDoU93Stph8y6sK/hNYqg+D9LUdT4W1vGdEbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee867331b50a1d-49a68;
	Tue, 12 Nov 2024 17:09:38 +0800 (CST)
X-RM-TRANSID:2ee867331b50a1d-49a68
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee667331b518fd-5c23b;
	Tue, 12 Nov 2024 17:09:38 +0800 (CST)
X-RM-TRANSID:2ee667331b518fd-5c23b
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: helgaas@kernel.org,
	manivannan.sadhasivam@linaro.org,
	kw@linux.com,
	kishon@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] tools: PCI: Fix several incorrect format specifiers
Date: Tue, 12 Nov 2024 17:09:24 +0800
Message-Id: <20241112090924.287056-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a minor change to eliminate static checker warnings. Fix several
incorrect format specifiers that misused signed and unsigned versions.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/pci/pcitest.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 470258009..7b530d838 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -95,7 +95,7 @@ static int run_test(struct pci_test *test)
 
 	if (test->msinum > 0 && test->msinum <= 32) {
 		ret = ioctl(fd, PCITEST_MSI, test->msinum);
-		fprintf(stdout, "MSI%d:\t\t", test->msinum);
+		fprintf(stdout, "MSI%u:\t\t", test->msinum);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
 		else
@@ -104,7 +104,7 @@ static int run_test(struct pci_test *test)
 
 	if (test->msixnum > 0 && test->msixnum <= 2048) {
 		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
-		fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
+		fprintf(stdout, "MSI-X%u:\t\t", test->msixnum);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
 		else
@@ -116,7 +116,7 @@ static int run_test(struct pci_test *test)
 		if (test->use_dma)
 			param.flags = PCITEST_FLAGS_USE_DMA;
 		ret = ioctl(fd, PCITEST_WRITE, &param);
-		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
+		fprintf(stdout, "WRITE (%7lu bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
 		else
@@ -128,7 +128,7 @@ static int run_test(struct pci_test *test)
 		if (test->use_dma)
 			param.flags = PCITEST_FLAGS_USE_DMA;
 		ret = ioctl(fd, PCITEST_READ, &param);
-		fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
+		fprintf(stdout, "READ (%7lu bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
 		else
@@ -140,7 +140,7 @@ static int run_test(struct pci_test *test)
 		if (test->use_dma)
 			param.flags = PCITEST_FLAGS_USE_DMA;
 		ret = ioctl(fd, PCITEST_COPY, &param);
-		fprintf(stdout, "COPY (%7ld bytes):\t\t", test->size);
+		fprintf(stdout, "COPY (%7lu bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
 		else
-- 
2.27.0




