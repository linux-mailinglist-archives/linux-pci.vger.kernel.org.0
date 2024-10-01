Return-Path: <linux-pci+bounces-13702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D69C98C957
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 01:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E8028B62B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 23:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E82194AD1;
	Tue,  1 Oct 2024 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxbyntyu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5B1CF5D2
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727824353; cv=none; b=CNWFbhyJmMOoUbgKUiWI1hRCnJ5jSrVeQACkpP68SOVl7oJH1Z3BajgXJAjwAILtnUHcs63A1woObAQ8Tp/+ZXTnAl9mzZzRpzIqb1EZyDUs8+J9DlPxkjdCSNrLVp7nJ+fwrNHRYwF0oRGjQSDF1k86n4HbkycOBjC+tQ9pjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727824353; c=relaxed/simple;
	bh=UJEo7ZbVngp//T9WAn3g+kIQ8hS525iGbt6hspN/biQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t1+gxie8TrRD28wButJgodmADRNKbBxV0TGZm1V6m5AquWp1X5yl+fRLoIKmGdX7nfzhaRe1S9t5AUVsZDpmd71Tgdzbde8RfEDkelC1XKrgybhuyhn3RmQHPHvqUeUBNXyPGNCDFQN3vhumXPO9l1AeD3Fy25MCrCDCmEbmlns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxbyntyu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2078e8b1458so65983235ad.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 16:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727824350; x=1728429150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yfKsYMpaU7VvuhLl70RiS1jJf8XNvJoYo4Hby8DN+CU=;
        b=fxbyntyuQ0rm7BLDzlyhZnTYzekqbZ3ujfeORgKNPJRBlKqKWMv+gwCTbJVSUf3ceQ
         t0h2ITk5INCXIqNg2w5EoYWx7jNQ46Dna1c6ZI/CKKZ92V1KNjfZaDfRmTJuKdrNUxmY
         XivHRZmEy/1fwJk3xUBoHg/j+wB5DWnwj0WSns5J6/kmzvHQJdFm5aVgqUbuNFvf2eUO
         oLwwONBaDPIwfTh0bHJJv6diJQWRZFaoLau6AjFMKJq/G+AppVGhnJ7+0NHbEH04hVOP
         Nafz5bTyyPcTK3OUdP+ZK0jteuxUyjAQD2o4OZbECRgyO+wIOghUxmFN1/3lSqtYQujw
         5mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727824350; x=1728429150;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfKsYMpaU7VvuhLl70RiS1jJf8XNvJoYo4Hby8DN+CU=;
        b=o65iRvS4leNeqUy9RAP5TI6q7hx2Z2tywzYCYIP2HPY6VYstNe+FcM4rUgMXsSqoT1
         vqZ1N/wqkg/vJmSWYO6NHIFOLDJmVu1O5whXj6JkT6IpSp2Lt/fOuRbAEBZoyv+g7m59
         1j+Ca7MzRduYV9kMOvLgRIcdIj+vX3X8IzfGPzZtYyLNwS/pnv3pTzXIsdUZvTMjzY9G
         /mQWIdy5F0bFF8yW7uKOcCRytlu1oTcjZAVvkYvb2nQg5IJpowO/sUXWviuNTwDtr0n1
         5m2xtcjEcwbwJ4BnvcjQPrebTcetdijQED6xjb1XI3NYshTQsrCqYUWLXmbbRNS3NPjE
         oRTg==
X-Forwarded-Encrypted: i=1; AJvYcCWA/15OGue/mheOqevOhzPaC36VYhhQcv/PwxV9QL+zfY6xpH4FcccJYE3y0jjxUtHHyGAdXxBfi10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyynwJ8ulP1IOIBbYDn8zWTExf2KPiakqLtNF4x3GfO/Ng+Cko2
	eeNI8FzscuJHHx4UHeRTWu9hJyX6OybcoCf1Lev1ANlKRkz7REr3QFWVbmNvK3iD9x5sFPWGxQ=
	=
X-Google-Smtp-Source: AGHT+IFYlrcOGsDvZLY/eGYCzs70AYjmWagZL0Cjjfxx6fUGcCl923aS8j/xVPRRR+iJEaJLcWnUjAtpBg==
X-Received: from avak.c.googlers.com ([fda3:e722:ac3:cc00:ef:85c8:ac13:4199])
 (user=tkjos job=sendgmr) by 2002:a17:903:41c9:b0:20b:bc4b:2bc4 with SMTP id
 d9443c01a7336-20bc5a599f2mr78285ad.10.1727824349757; Tue, 01 Oct 2024
 16:12:29 -0700 (PDT)
Date: Tue,  1 Oct 2024 23:11:47 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241001231147.3583649-1-tkjos@google.com>
Subject: [PATCH] PCI: fix memory leak in reset_method_store()
From: Todd Kjos <tkjos@google.com>
To: kernel-team@android.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

In reset_method_store(), a string is allocated via kstrndup()
and assigned to the local "options". options is then used
in with strsep() to find spaces:

  while ((name = strsep(&options, " ")) != NULL) {

If there are no remaining spaces, then options is set to NULL
by strsep(), so the subsequent kfree(options) doesn't free the
memory allocated via kstrndup().

Fix by using a separate tmp_options to iterate with
strsep() so options is preserved.

Fixes: d88f521da3ef ("PCI: Allow userspace to query and set device reset mechanism")
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/pci/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2..0e6562ff3dcf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5244,7 +5244,7 @@ static ssize_t reset_method_store(struct device *dev,
 				  const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	char *options, *name;
+	char *options, *tmp_options, *name;
 	int m, n;
 	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
 
@@ -5264,7 +5264,8 @@ static ssize_t reset_method_store(struct device *dev,
 		return -ENOMEM;
 
 	n = 0;
-	while ((name = strsep(&options, " ")) != NULL) {
+	tmp_options = options;
+	while ((name = strsep(&tmp_options, " ")) != NULL) {
 		if (sysfs_streq(name, ""))
 			continue;
 
-- 
2.46.1.824.gd892dcdcdd-goog


