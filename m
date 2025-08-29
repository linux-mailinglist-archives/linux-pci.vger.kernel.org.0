Return-Path: <linux-pci+bounces-35129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 647E7B3BFF6
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A85E189CC8A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C51340D81;
	Fri, 29 Aug 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFF9W1uG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72B33EB18;
	Fri, 29 Aug 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482558; cv=none; b=Hx2aalPfyNDu931gTH6UaXJ2nY++/uZ9ncQ4GRL7XGD3nftGuZ09Sh0SlV7cuSft0U/eJzkakB2YfuU3haB5W/4yGlOF/zHqCIPnXiCVmMOBSUIFqDtYbrK1iCcPLlYXLHOvhPgx5W+hj4gTvR8FWCqPd16/Hz4IMBrv9sq1iT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482558; c=relaxed/simple;
	bh=fj8C83YhLE6FVgaWV6fkmpAqQbVfAMlK0gEymOT9gl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJho/AJxbjbTvMbpF7f5xAO+tQabP7zg38HVdAMTyMRrKFRNZXiu2Sbjjt7dGxJQ2vERpjceD19SzSbPt3SAyHOn/mwx9Cdq+BJmSi8JnYA7dP1qXWPklRSXEoJQei6cpwIEjUmMSrJFJ8f9bVSZj2pnX85Jl7ljryhkIs/3PUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFF9W1uG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBCFC4CEF7;
	Fri, 29 Aug 2025 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482558;
	bh=fj8C83YhLE6FVgaWV6fkmpAqQbVfAMlK0gEymOT9gl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFF9W1uGjPYgj0n35MA8v1QzRUdZ+VVTyx8RusAg7FgrCvSIk6zL8oauUs/qFiW0P
	 voQjtxTbTk5yq5dtTj98FLtFUgy7U9qhEMGF2Cm2P7IahY06mY10MrVoGIkfMu2bzS
	 wRyaOyHwaXAo9YTRjgvnPzgZ9vamh+HvnJGxQdf8nD6RAKcZbp7WzVWMgEQ2/utKJa
	 aFWbSzBN6zRS+Gjx9slQQcSA6EL/hLmkFts81Gq0H30pbIZVbae3uR9gkV7gtwd8sy
	 osVhH/eOO9DE3SeQHJguu0L39A2HQ3a69dYC7Haedvm5juGOV8zD580yoqYrPo1QDy
	 QMgKVCGHDcKoA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 20/33] PCI: Remove superfluous HK_TYPE_WQ check
Date: Fri, 29 Aug 2025 17:48:01 +0200
Message-ID: <20250829154814.47015-21-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It doesn't make sense to use nohz_full without also isolating the
related CPUs from the domain topology, either through the use of
isolcpus= or cpuset isolated partitions.

And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.

This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_WQ is only an
alias) is always a superset of HK_TYPE_DOMAIN.

Therefore:

	HK_TYPE_KERNEL_NOISE & HK_TYPE_DOMAIN = HK_TYPE_DOMAIN

Simplify the PCI probe target election accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/pci/pci-driver.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index cf2b83004886..326112ec516e 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -382,23 +382,14 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	    pci_physfn_is_probed(dev)) {
 		error = local_pci_probe(&ddi);
 	} else {
-		cpumask_var_t wq_domain_mask;
 		struct pci_probe_arg arg = { .ddi = &ddi };
 
 		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
 
-		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
-			error = -ENOMEM;
-			goto out;
-		}
-
 		rcu_read_lock();
-		cpumask_and(wq_domain_mask,
-			    housekeeping_cpumask(HK_TYPE_WQ),
-			    housekeeping_cpumask(HK_TYPE_DOMAIN));
-
 		cpu = cpumask_any_and(cpumask_of_node(node),
-				      wq_domain_mask);
+				      housekeeping_cpumask(HK_TYPE_DOMAIN));
+
 		if (cpu < nr_cpu_ids) {
 			schedule_work_on(cpu, &arg.work);
 			rcu_read_unlock();
@@ -409,10 +400,9 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			error = local_pci_probe(&ddi);
 		}
 
-		free_cpumask_var(wq_domain_mask);
 		destroy_work_on_stack(&arg.work);
 	}
-out:
+
 	dev->is_probed = 0;
 	cpu_hotplug_enable();
 	return error;
-- 
2.51.0


