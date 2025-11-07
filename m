Return-Path: <linux-pci+bounces-40583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4037C4066B
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 15:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0573A465F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A541F5437;
	Fri,  7 Nov 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PCzMHG7O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F83252912
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526196; cv=none; b=LaESknAiV9iCum0LPvaEG24i4N65NlEw2a4oql3bX/GZ5rC2yCrJQOsGss3NNMpj7JmTkL0jE7cOBXB7gYB5m//fHzHhrZnPK+pHmx8WZyok4/kpvA/Sr/QFXvkictaYyn/YnZK3PB7gCCd09O/62BbpVLCxh/zxudWkn4kfG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526196; c=relaxed/simple;
	bh=pdHuz77C77QQbe4jiVt9Kjyj6f+b9ix2y21sqpxtAxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AA32uEK3vOQ8JJBL19SzQGHs3uYXrV3GpDlaAD7GuBM9TiQufM//vi+NMZLEZmrC6xW2N+pzcEHX+mGV5PkTtK+EQNzc8xT3nNjmhRyXMwfEulYEavUVlIyAR01Z8ewnfH/5UDWtVmO000/u7uAkHmj8SH+yJ4tjUP1TeU6GeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PCzMHG7O; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4710665e7deso3866025e9.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 06:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762526193; x=1763130993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFwY4O/H3CLtrImG4wiLUJMhAuKJ/ASp7QcQ+wm2Eik=;
        b=PCzMHG7OMUW9AAhRiqsz9lZ1+jFQIQjlHxf1iEXw3nXkDIWTaB8mKMEDw+1HKUgup4
         9H2w9BgaJaimo+agAWCfiscnV85E1jucTu1UTfcGGJHJRiRaLkdgSyAI600G7xDbBQBc
         aMvxb89vq/iatTJzeu/LeqavLqaXuy9iYcn46ZXruCgFFeTLaS4RWDiwjWNklNotM8HK
         TNTgl+WUK0vJL/nTUVO2gddvoYiqtuoZ+UcLbfGHdG3l5nMANq/8I0p9z1v6i0O1khzh
         PMJ8L+sCoPy604RIbjq1MPFvc7lQ2St3lQPuch8Lr7OSCOBPZEYG7H0O3KRcfI2xoR8g
         fipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526193; x=1763130993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFwY4O/H3CLtrImG4wiLUJMhAuKJ/ASp7QcQ+wm2Eik=;
        b=Pnfy/1Z0Y1Iw+K9ACDN/3gHENj4tmDS83CfTsnxVGYiPrbTSOAyI3clYdprG6JDMzk
         xLH/KX1rLo++Pq0dRQekRwvE1IdRewr+FKMa4MLHmyLldNi7zqhIOEjiFjr6n9eU/DF5
         KPSoOZFBeWrhPy9kT/SjPY/y5qm6B54ockiYsjZYoNfNV9LIQIDe7r5nVb1y58tA7J5V
         sK5hj4UXOQlirfrqIp688A9aGAD4lUFUkhJGvB15qB7CJ+ed/xGAU8XhxGMyT7Pg/6H6
         T6XOfaiiHmU1IvrzpbdVWbr9BPsCdmVSRFYIEnaIr/a4s6vg4gW1hpecEnc5WbzdCDaJ
         jKZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2GNp7H1di9hZT4hyc5NYOrR6nKBuLhXp7kVde6h+nAI7MQAK3aLtGHiy7uwvK3eQ5aovO+mM/H8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+bvuYGDamKQU1xXytwh0GikJAEqq2UP1CADUBjSUy3WSpFAI
	5h8RkwQ3qYQ/+9hUZWSrC792GrUjmG3o5NY9kt4vRk67l1qfWVniFIaQ4pY0dr3zPsA=
X-Gm-Gg: ASbGncu/G8O+Un0TymmN7ELpM089PO1bK+Wist+05b3jlrgZq3RiRovhls7IesdbV92
	xTQasJRjERQ0ICuZmjDPlQBvh4fd3syBZL9g6c/IuoeAx8E9mC2Rgt+5tQ/dO+prj+HMhaXAMd8
	hw6dYkvmA5fZuEivfEVy5cLYNyT2XmdmO3t7IZM2YGF8aWB+LD32ehSLesVMN11PFF1uqlaE3WP
	2P26LrPggP0vaBKEAgsz4Jfv13chPGPBZy0C6yXXmU4BWb3ljd4VgyogdDkfvenE9qAqHh11y3u
	1GEBWVaVfW0oTNMZQ7Fdw3GuvO99Nj2lmT4d1Qq8/8JMWPfWJ5RhlKgIPZAYaTifFe2HM4hLr8g
	uyTzm0lOE8HDAv9p1yRKwPaDWurE8OJlC6/GkL2H3xaJsIXHcg+BQ3nJKr3uGw95ewNWFV1jEAe
	w5Y3IJE63T4YRf/oANw5QOfnsk
X-Google-Smtp-Source: AGHT+IHL2HFnWDwMb99ufUmB+DUpAFr4iCYh9KkrH1cwe+zCzO13bcOb9zFiLCvpx2y50z1jrx5Ykg==
X-Received: by 2002:a05:600c:46ce:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-4776bcd5a8cmr21733555e9.26.1762526192667;
        Fri, 07 Nov 2025 06:36:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd08834sm52478435e9.15.2025.11.07.06.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:36:32 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] PCI: shpchp: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:36:24 +0100
Message-ID: <20251107143624.244978-1-marco.crivellari@suse.com>
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
 drivers/pci/hotplug/shpchp_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 0c341453afc6..56308515ecba 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -80,7 +80,8 @@ static int init_slots(struct controller *ctrl)
 		slot->device = ctrl->slot_device_offset + i;
 		slot->number = ctrl->first_slot + (ctrl->slot_num_inc * i);
 
-		slot->wq = alloc_workqueue("shpchp-%d", 0, 0, slot->number);
+		slot->wq = alloc_workqueue("shpchp-%d", WQ_PERCPU, 0,
+					   slot->number);
 		if (!slot->wq) {
 			retval = -ENOMEM;
 			goto error_slot;
-- 
2.51.1


