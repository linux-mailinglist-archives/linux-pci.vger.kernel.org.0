Return-Path: <linux-pci+bounces-40351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F9C365D0
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 16:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5928566A40
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F332ED3A;
	Wed,  5 Nov 2025 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NX11r/Hv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B7D335579
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355819; cv=none; b=Yuf+hAJHBeS5dGj9w3P5/l8W6HWVIQDleAeFjQ6z11d0hMXgevn/uaDxUZcC54ayELO7HDeDPbf848xO/7yqY71eiPn9E6qZ5OjtgSMOzQoDChKgT49Zj5TMCbGxqBmGPF1KRyHibhGXgVu9l/IWjnOg5MG/AtS9tN/g4iJaG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355819; c=relaxed/simple;
	bh=8YeZygjza8/7gRfw/A9FL79bGlwhSzrkGSMfOyDO/R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6Zu8Y6SDBYwzstlyiIOa4oGZVXH6bhf/epI2kmxC9JY6fOOgGjaMYat9RvS8LUNkdkriFvqo2lVFwisa4zmdJJekdYM6DfYXlwAzn0Ry1bLf77UIpjAZey8xsQzyr7GFQZqboK2CopOG2zdjEv8lxHxNRRncBIBkNoIMPbxd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NX11r/Hv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710665e7deso31938655e9.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 07:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762355816; x=1762960616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26j0ekeJAt+MjPT8JhPGkZNYOpU999yhGjBkXTB65Qo=;
        b=NX11r/Hvp2U92XTzpGNXNfLPt5I28tLBPE6Hc2d/WnyIuinFRPqHYT1qypQLmRpgGO
         J377X2lmkcpyg16pIQjONq//XRWEk1eGFA7GxdZgtRDD6IFof9Te7DGbnzVIVZ03WWxz
         29fRO5HziVz4WsMgJ0aay9UkZVd6DRYpWAxzFuPVGc9pwUQA1rLBnSbXIPJ00kGcpSaj
         8W89HRzPWXFbto1H2DfiCzIL2YKF7gr1uJbkb6vUjkVI40e1tRRRjwcW8GfPEHiF0M3M
         8uNu3flLpM2dT2vYrlQcbALrgJ0CmBQgd9kujfECJS0VTJV4flNiFvy1v0AO+qyZq0sN
         YfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355816; x=1762960616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26j0ekeJAt+MjPT8JhPGkZNYOpU999yhGjBkXTB65Qo=;
        b=aTz/UGRiUO6M2RiFyJmPoAINRanIn5+QL9Ige1bJJ2cP5KzP2tbQum9Ui+6+eSLDda
         gk4/HAFpfi+WfEHvvy0v54C22K2N1ua/FE7oY7Bgf11keBYNRSPSzAs2QJGdonpIY21K
         cwuuI/K6u3G792KK9FBKtkbv5K3Po4sab6sIuAJRiGNiqW1A6p4fBOsAPtoSEpo9M+/Y
         NoMGjVxDJNLJolVU50W6uNpNet7c0SwXPfelj+yB5dxv3vADHOcF9hUwkVf0LAGaFVzh
         4uZBZ97M5rtIg7HWbV3NeEoglmoyiV0i26UpUDa95sYvn+vazdPYe6E+W7npahtkkGMl
         W0fw==
X-Forwarded-Encrypted: i=1; AJvYcCUWfeQrkONNXfrXjusG+GKOJbZNfxyluD5TBpmqcHCYtfWL9gGAa28KAwN8vR863MQskMGv8PfnKtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQAFC38G13wl8vT5mZhRVb/ibDVCI1hQArTiokWUmE4Japb/i
	CXY0cpbsOL+5rDiDz3bQ8tSy6QRCar3b6MGeuaTUZT6cEA0VTkWBweHC+DGsQPnJcvI=
X-Gm-Gg: ASbGncsPYim8u1yVgZiBbEAPVlPucvRfYeQzfv5mzlI42PEuFUmII1W/6kXN/P+Qy0t
	k2tbggoh2MuzlP3vdK37jUtOi9wZz5zkb70XfqdGL3Z/ll8fXV15TbdfkzcpbNAGqXMPmIoz90y
	c5ddBSmG94LiFGcCl0xI8KIwZwObuTJApFBIzD1XSsb20/x2H2U6nEKcZAifl7Vn1j+GG+xmNVq
	YTTEcrRQiWgHEBG050FGzDUKCR2FX6QVeVFO48DTuVKNN/v43AIQN0NKbCCLB7XhIa1gQiTsWlF
	tOFwPaqXua8n0fF8RK7E4Scdp++Y2MFirS2bqNI9WHA89UgOjwnWiSnvI+drmoi5+sC+jHJYJgH
	KaK5peU/JgZhSBIBylLULTGMBLsTav5ldpOkROq8oqWH28W8gzWOqHF99bkcF93A6KsKNeES/qa
	rU6F4HBzp6JS2hy1PV68f2VTw=
X-Google-Smtp-Source: AGHT+IF6f24h0/KL2PYW2pfErFRR5yf/pq/jG7ooPFf+nzfOgo7C0RcnE+SZ+CriuvilRfh56OZTBw==
X-Received: by 2002:a05:600c:524d:b0:46e:37af:f90e with SMTP id 5b1f17b1804b1-4775cdad6e9mr35742065e9.6.1762355815648;
        Wed, 05 Nov 2025 07:16:55 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cddf87asm53993655e9.11.2025.11.05.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:16:55 -0800 (PST)
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [PATCH] PCI: endpoint: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 16:16:49 +0100
Message-ID: <20251105151649.256274-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Replace system_wq with system_percpu_wq, keeping the same behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index ef50c82e647f..c787ce59d9de 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -638,7 +638,7 @@ static struct config_group *pci_epf_make(struct config_group *group,
 	kfree(epf_name);
 
 	INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
-	queue_delayed_work(system_wq, &epf_group->cfs_work,
+	queue_delayed_work(system_percpu_wq, &epf_group->cfs_work,
 			   msecs_to_jiffies(1));
 
 	return &epf_group->group;
-- 
2.51.1


