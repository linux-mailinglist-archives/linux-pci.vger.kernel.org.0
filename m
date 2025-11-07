Return-Path: <linux-pci+bounces-40582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C52BC40620
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 15:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7FE18879F6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3231AF2C;
	Fri,  7 Nov 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dLa/oT4L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693192765C5
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526027; cv=none; b=mDe3D+fYT/gxa4l0e8w25ejzhEMVpEPwW+J1PhwGQtiZ4TGDKmel1b61sucJrzEXpmCboTI1q9R9A3tfS2CzmjjpqdfuP6JUs6SBJms6zHl4qAZei6dIh77Slm9uYTvxdupgNo2xRmlA7toKFVbbmIE3bGOhLpkXHZdF97m2hS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526027; c=relaxed/simple;
	bh=hjyBa29LvF5ke1bIbdIdjRleYwiz0qsv2bHQaxIvBTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+vGzWtuaDZGhZJJsN4q80vO6LtPSeJSssFQwx5BeeBTpRXgGtvLG3/yJyXoN1NP0p02qKV3KUL2H6QtYDFNQ9tNRnRT+oJL97CeneqJ433AB74bFG7XJWvdGbDFMB1NNXek7Dk3ABbTK7hspQ1xJ3qqs0h6lqahD7+3Iw8MvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dLa/oT4L; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c82bf86bso427781f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762526024; x=1763130824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZwooRdHB1TiRGXyDl2NtjlO6yhOj/8qnno438SS5o4=;
        b=dLa/oT4LfOxUCj6VM2szBUjNXF8ISsp9ao6TL4LXAmBLa5VzAXB5ziuq8wJl+mz10E
         ohEfVM1Dq0hQ3vu/Bqj1aicUj5YjtcI4+ri6k5F8yZDH8nFOh3LSdYk/QsR5hc5aYUF5
         0LkokKuGIZp1LvtcwOzE+bsPt40LJRIVzOxCrWzZOiDcshZOBeFuql/ycBEbHo2uOhIe
         7tnixhdRfp02aJsCJ2DG8vGZBUgt3DMjU3t1uOgXuiPzOJxDP9efDneoFD0PmOf4wwxd
         WFNCuvKpNv7Y+Fsl/Dd3S9GWuRhgtHCR9UkyPA3mfTeGSwJrYAHYrZBrgBHFell42I6S
         Xm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526024; x=1763130824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZwooRdHB1TiRGXyDl2NtjlO6yhOj/8qnno438SS5o4=;
        b=gT0ilnCeCuTF9wJHAIWQJAADPMR5DkMHtIAVmoaVgZWTzP7bLzC5Jw3EXBpXxDUg2v
         qUXUxp+qEan+qNhBJ0mjdD/ktUGaeaqo1+Vzqjsi5m43lRYZWE/rtdsoEV9yZfA94Pwg
         +2zpK6yuCMJ353qQeQEpX+DmZ4DOBHSkEkN+DkduVVSus4CLZDD6M3jelFKnmkqqDGyi
         Hvfl8PMc5Q7LlE8n3eiyEBrAk4ysKQzWYhfS7yzpKDfzoBydGtB5j+DyK7RhBtE4m1oQ
         /IQZ4RR/bTdEj4oOY5fTtXPWGJA7Jab+uuqGIaKVh4oVz56xfMWt5u1PVZwoYj8M399p
         KNXw==
X-Forwarded-Encrypted: i=1; AJvYcCXJqUU7DdAS4AsmbitGqEH/G5BGwtSq/ZsGxIPp6IlAwVI/6M7B8KO1VtkEYImgUan/PEAbfiLRK9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxupdmM7l89qdEBUv5lfl+Xtbsa9mErCMLG+Y5O8aXW62pKipjm
	gAsNGpzn0NTX+kYSsJ2SDNDyn9LFNZ3wi4qxhku5ol6o9kTgRAuBSiLYqU07bBCPs/w=
X-Gm-Gg: ASbGncvyq0QIN76I3ik534owgDY/IQXRsWuYFP0kCpW84Y9s/ef+hFoMskbGtIdeZn8
	ZMC9ShNgIRUtKAUt5Gts5/LvSMq070TnqPXxGkqQEle02e6695dccinXQziDjAqZfQIyv4LLvK0
	YbEAQFPzo3mcm4dlvQk8j8wuKNgv9FYQGKAXLel0KelJykdB3OUyXLfIIyrdB7gTiPvUaVxFvQE
	3piQFf7g6H2yMTZrsD/qqK90dxrcodt/emgiFjq52t0038bioy9F4dLYe4tuJRiSe2omHTw/Uok
	DCToaVKTC7YP7EiLHDrRhPcZtbybZdLymW7QlstjnfHy4szQtfQ57qez6cZ9fOxYaLffOtD0PcY
	9kFr+INwGqgeBLrPBBZe8JevUIOxARh6owxq1i0SmaKxQ/H7aCZIwh6euC/YiD6ZJzKCYP1xS2L
	qoJ598S/fHUWBCgzoMGW1QOrnj
X-Google-Smtp-Source: AGHT+IHKuyvTGNSoJsQ3fSAGflXQvX+4fyFLXoLOYbtCrxRpdLm0CfiflATW1SeGn2vQFdIECJYLiw==
X-Received: by 2002:a05:6000:1a8d:b0:429:cc01:c6a1 with SMTP id ffacd0b85a97d-42ae5888a25mr2897316f8f.28.1762526023562;
        Fri, 07 Nov 2025 06:33:43 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e126sm5647624f8f.16.2025.11.07.06.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:33:43 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: pnv_php: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:33:35 +0100
Message-ID: <20251107143335.242342-1-marco.crivellari@suse.com>
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
 drivers/pci/hotplug/pnv_php.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index c5345bff9a55..35f1758126c6 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -802,7 +802,7 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	}
 
 	/* Allocate workqueue for this slot's interrupt handling */
-	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
+	php_slot->wq = alloc_workqueue("pciehp-%s", WQ_PERCPU, 0, php_slot->name);
 	if (!php_slot->wq) {
 		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
 		kfree(php_slot->name);
-- 
2.51.1


