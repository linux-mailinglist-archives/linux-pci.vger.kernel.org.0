Return-Path: <linux-pci+bounces-40581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DEBC40617
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69C024F46B9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBA02F60A7;
	Fri,  7 Nov 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CE+rONLp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151F2550AD
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525880; cv=none; b=nnxSf2lWq2+IEQJcAgN9wq3l+5/MpKtL9QSw5mcFcd/Gq0XyoH7Fm10syfxNR1JBJAQEn4gC9QuP1zJM9DgulfA/WPe6bP+mZ8lRZpnlKtoSoLUW60MuX23OFiYDDX534166r8bPZFTteO7Pj5v+yIexY6CEyxWL8cf/A9edEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525880; c=relaxed/simple;
	bh=cSdDnIXxswzbdqa2gav6B3GuVmFeRkspqdWD/8dhg5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mFAJ/RIJldXsNHTkCOKb2Q8YHPFiD6T9jA8nGZVzst6E+QzWiPsHceIbgQGc1QbKeGi5X7hA3dFLUHRI80dnhn2mcH8SN2d22J2V4dZ51QtxWHbOux4Qsv2MI3rCUK7+jM5i29ii7nQyddj/NXyMWTWjeJdDucj+lOlKZOrO/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CE+rONLp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so4528885e9.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 06:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762525877; x=1763130677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUBmSzOMW1hVmBvLVfhS6unxv5YlCb/+J2qrVLMEhjI=;
        b=CE+rONLpD5X7mbnF4JMh5VVhIeZ85Z/nRhUVIxDy3k17s1C2rsXJsA7noCRQRvVNVT
         gk9uS9IDoOkEI34dJjSTcRdkKscfGMl/erD9cqTg3l3G2eS32w4WwE1kstF95LOjNPu2
         NMjGb4oyc9irAyC+rNhoBLkSVD0xyrPB9ub7ivovW3Lpa6dYBKWJzzfIbOGVjqRosasO
         nrimhCt/M4jHLyQIHf55ThQZZWWbC2nfSZJIJ8SjKJSfSQiXQjukxJdz0f+W/ED+BtSJ
         KskOjSZ3lIg+Me2thlTvC/GKd6l1yIhvP0NUHSvypEe9QsQajg3xo5IvvFZQHDjpgBkV
         gnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525877; x=1763130677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUBmSzOMW1hVmBvLVfhS6unxv5YlCb/+J2qrVLMEhjI=;
        b=iWukn+5Kvc8DvLpDaBpALTx8anCJ3K3FyfGY2XnFnZ2XcD6gxlAXkRCxk8+Szkdne2
         Eq4fbRJ5CcICMoLzMEZS5g7B8LVzbmtO3yJI+seJqhLCfSkbJpJQy2HvRDp1oSkfIirO
         m2W1iXpibqdoDSiiKq3vasA7WdWI6CUSd6Nvh7u6cnLCkSsOp+YpBwhP18FaXAW4J2QY
         vYEALVc1WFLNpU5B8gIsaAjwE1ydlNVQEbPZ+InlMcni13cYj9j12ilZj0Lo+KVoPf+s
         FsPnApb5T0b6J9KBr6ockeUiqP+7nDMDYl7rDSZKmImA9Q9TXlThjuubEVlH21x/c62c
         RDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOwEGQkSFlgM/hhozcthavuk6z2qOCUtbZtop5tnOLJcvaTdbynUcbPj8yAL+Jwf89mTe3OiaQCmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XwPAcilpa4qYq6DInKC9M2hGmLxl2/jJHf5Mlg3O3CU+X2CZ
	HZ+ul37bIkGB2XzcBsQeFftQHlZ2yu3RVilgGVvg1hlRS0g4BfBs5TM/TV/XIJ9m0Wc=
X-Gm-Gg: ASbGncvihQxhgE9+0oVZ8PN1JNV+8l1ZzFA3OAt21QRljPvmCKW174xHnYljE/yl4ue
	j9y3OUMEXg1E94VeTboD8dOunWcyznG9XtIRu3Iq6CiYBgt13+UWxWuBH2oJoY4oWupK4cZvB2a
	3VscIBpbq2gc9904GT+WbIYkIam/7Ozue9krRJnY95ui8vROVVihwhTv5/MENoHJ8TweV31Qb2/
	RCwE5Ei3jPj1ztB8Xn7rDhCiZGKeiMDVVXx3dNsDpAdIHTg0Zk/iQKNEBjLm4DCSAy+dh1f+I8W
	OgFc9tyu7ACLzazO+2kr2Kynz6bwY9mOjmh1CRNiui/zVzW3vNyQ8mGsa0gIsAYVze7Y+yLrnvT
	7EKoHm+QNbp2q10M4b1RUS5CK4qQoTqgtQXM0Wnp/jNCyEGOVVyNyw51QcFR9eYKuI1jP1cHLOP
	mUmOVcFemqpRvwN1fL5SQowQNivyalBaG5Dgc=
X-Google-Smtp-Source: AGHT+IGSY6yDLTu3hRcVf/k/pttfkC0OQRPyNDQ0Wl+wJKGkdFmqGU/QfjbxpsGop8pwcaivmOt2vw==
X-Received: by 2002:a05:600c:a4b:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-4776bcde4d5mr31145925e9.29.1762525876714;
        Fri, 07 Nov 2025 06:31:16 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcfd2e5sm52355795e9.13.2025.11.07.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:31:16 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: endpoint: pci-epf-test: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:31:08 +0100
Message-ID: <20251107143108.240025-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 31617772ad51..46e684c0e496 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -1188,7 +1188,8 @@ static int __init pci_epf_test_init(void)
 	int ret;
 
 	kpcitest_workqueue = alloc_workqueue("kpcitest",
-					     WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+					     WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+					     0);
 	if (!kpcitest_workqueue) {
 		pr_err("Failed to allocate the kpcitest work queue\n");
 		return -ENOMEM;
-- 
2.51.1


