Return-Path: <linux-pci+bounces-40579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5953CC40542
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 15:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408543A95AF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438A2550CA;
	Fri,  7 Nov 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P32fnPGZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C0328B79
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525535; cv=none; b=KNHI/kaIGQYWD4OJnQ7AMCWRvFyV47WiS/hEmgiMT8fkdxHcato5rnY+DNQu9RHzMiU18aF18BDPXXb3phQykbq43HrsxvsbGIjsFRiND0BT2wb5mAnPQKs1A6QAVXVKQ/Efg0Mz8L9hPuGT8NyY1dwiSZ3tFHqfe/xvi1pgdm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525535; c=relaxed/simple;
	bh=HaeGIdJqZ3psFf94Qv9C1pxEkuWWM5yYs+Xoo/xY/PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V4t/aNgZ7MGV0W8EbBopK9Vz1L8OdujSJxr+Ak0T7zwu7j7UUuqkBBoTIV1GK2bYG6+ZpWSIxqTpn7HqgelUxnzBoPK39WsT4MhlcHcfndFXgLkHyomBS7jthEWjeaan5GsKI0sDYLybiKyY43hGKCX5B+fYKv9wDVJpeki4H5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P32fnPGZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471191ac79dso9074305e9.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 06:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762525532; x=1763130332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRZZPRDUZ7lRY76avfLnVO53M//uu4xgze6C2tCsP8I=;
        b=P32fnPGZZ6DexatQm71Xl+1n2r0hUftSkW5k/KJkParcNMncTdoGMkeAbF7KfKJpdN
         0ZEMfIE3Ymce/JKbjRZZ3NtNYwzpMxuCLZVOgTbwigGOy7xVMgdmZcf3OhNWgUHFvx9k
         Omn5D7VMz+3KIpd8MSEOngwMNKCX5KW88blF9KTypxxhXj9eftlvOS1drNyFKwRpEs1C
         aSteINAHCO1fxN5opJKh1JYB3lIWWjbjlBRn+niNqbI8pjbELwcrVY48C5Bxw8vSwPKi
         pLFxW8Bk/NRVAHWDn6qnbRLosi2Dk+ezvyjP6is/+BcA8LvTgkP1bPVVTHGBoPoXUc6b
         x7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525532; x=1763130332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRZZPRDUZ7lRY76avfLnVO53M//uu4xgze6C2tCsP8I=;
        b=OnIrG2ovXQz8tNxI4RpeRcETu1GqLukZ+F2e73W5xSy31LUpv0L6ih2RX3s6o0aPYn
         WdzFUEH/p933MmHSrZkN831UxH1wiZj004FLYB6fH1A2UUVwnSC2S9EXVioFZJhVOVIf
         R8Q6tabvFBtqq4zx38uW0J7WDzyMp9IzIAKGrYpDaTY8NqpL7zhVeT9dx/xEeK5o9bzG
         N+x6clgCgTOq4xhiyzuptI1tSvLbC231ZwOOIrITfL9qR4YNvd1sYl9PzsAYW2RW50oe
         E+GWcb+NC2CrrsojlCS2dGHcRdq+vRrNrJsyDKOsSzPikOGKIYP/Ki2RTFLNWMDnwM1G
         WpJg==
X-Forwarded-Encrypted: i=1; AJvYcCVLZkDLzZsnWEYhqkuF+nZ+kQFPImOtUZLb1UPOXM29wuJ1cIFkQFufW+949GHRjZeXJv1HcgljJPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz386Zs4cCgBjxXxv7rrZNtJA9nbRm9PYj8ZxQMPnSteOkXFAjH
	uv0GHQnzw7JDorMPCCYMNXaXoxLkPxO6Pr3jQMW+SKh/xPXZwDd+5oF9bnfeQEG+FqA=
X-Gm-Gg: ASbGnctf5NSCWztMEoFCsNvYEnewCh7zrmMs6djRCjaTsop5DUXHS6NI/10VSyEURux
	lc5ghs2GdzgPIhPBro0xHhOrsjfRQezNb0YfiF0/RMuJJvYTzwRtGVPhLAUAWbTCn+fShepNXs3
	Tb9xSIbyEJWg3MBG6kn9fcJ53aslTIoGrTBOCsU+gsQfG3Dp2xeJUMPEUXZLFm49Te9BSOvLzzA
	mBOGtDmD2b+5NvqcmShwXzM3dtLUAa3PlLO/1xLKPaGLUk4IGfLdB69nr3518Ntx1x1bh2YJlGv
	14kWd+N4fgJKvZ9NS6aZZW4mmY7YIu5dpTndwGa/1jVcVSJxL5yYlldq9eS1ptOLlWNevtLInPR
	U18hOHEOLizP/hVJy0OXumz68iZtuYMa3AgGp4eG38tgkzgUcQWhzcIF8F6r4a5pg8rbh2keKti
	iABZdQibG3PSwlS+AX3Fv3xnHS
X-Google-Smtp-Source: AGHT+IE/swO0ECBwSKu80fX22MXr+gJKhInlEKy4hccqPn7CHjNPtGTEl1myfo6pa29cT5DzIn1ZtA==
X-Received: by 2002:a05:600c:4508:b0:46e:394b:49b7 with SMTP id 5b1f17b1804b1-4776bccec42mr29103625e9.37.1762525532165;
        Fri, 07 Nov 2025 06:25:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd51dfsm50624375e9.5.2025.11.07.06.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:25:31 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:25:26 +0100
Message-ID: <20251107142526.234685-1-marco.crivellari@suse.com>
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
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 5 +++--
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e01a98e74d21..5e4ae7ef6f05 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -2124,8 +2124,9 @@ static int __init epf_ntb_init(void)
 {
 	int ret;
 
-	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
-					    WQ_HIGHPRI, 0);
+	kpcintb_workqueue = alloc_workqueue("kpcintb",
+					    WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+					    0);
 	ret = pci_epf_register_driver(&epf_ntb_driver);
 	if (ret) {
 		destroy_workqueue(kpcintb_workqueue);
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4..162380ca38fb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1532,8 +1532,9 @@ static int __init epf_ntb_init(void)
 {
 	int ret;
 
-	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
-					    WQ_HIGHPRI, 0);
+	kpcintb_workqueue = alloc_workqueue("kpcintb",
+					    WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+					    0);
 	ret = pci_epf_register_driver(&epf_ntb_driver);
 	if (ret) {
 		destroy_workqueue(kpcintb_workqueue);
-- 
2.51.1


