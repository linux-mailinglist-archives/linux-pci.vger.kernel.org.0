Return-Path: <linux-pci+bounces-13027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A43974BCF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 09:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2BE5B206AD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634C06A33B;
	Wed, 11 Sep 2024 07:50:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8E3FB1B;
	Wed, 11 Sep 2024 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041022; cv=none; b=uToF6Tkt5iVm1Tll01rNHcwl/M3GDzNQFRJH+Cg6JEWt0DNOTCbEqzppauvy16d9ynRgtMm7Iz1YyYmanB+Xs+nzZEVRJQWsj+NhqmpXk/+ZgPi08uHzrgzr9WjQQk+9fncL0zMNvq1jK/D1JI++ofHle+Rd7nzeODVoG9MXTR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041022; c=relaxed/simple;
	bh=xHt+PvkhvrriHMsAPnHrMoyfhlPZwmFuV1Gtfrfb84k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WunMGF/xGwGBS8jOu3o2xTmEBFOL8MRfHnN+ln2nxxfk+PO4SkhrqltDerVFzYqyyYu1nCf7UQn31U3NFetUjMVswNkdMDwhpBPORiYxsszHwjxLDZ/b5mLFbwUSNWMeGQTuxG0YPKJBjVxY8phrsOhByO+t0raTguDB/0AtSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366e14bb3b91-ec3a0;
	Wed, 11 Sep 2024 15:50:14 +0800 (CST)
X-RM-TRANSID:2ee366e14bb3b91-ec3a0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866e14bb5a2b-bc159;
	Wed, 11 Sep 2024 15:50:14 +0800 (CST)
X-RM-TRANSID:2ee866e14bb5a2b-bc159
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: manivannan.sadhasivam@linaro.org
Cc: kw@linux.com,
	kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools: PCI: Remove unused BILLION macro
Date: Wed, 11 Sep 2024 14:04:01 +0800
Message-Id: <20240911060401.9230-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The macro BILLION is never referenced in the code.
Just remove it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/pci/pcitest.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 441b54234635..470258009ddc 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -16,8 +16,6 @@
 
 #include <linux/pcitest.h>
 
-#define BILLION 1E9
-
 static char *result[] = { "NOT OKAY", "OKAY" };
 static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
 
-- 
2.33.0




