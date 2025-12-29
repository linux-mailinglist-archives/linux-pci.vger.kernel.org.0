Return-Path: <linux-pci+bounces-43807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C85CE7ADA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 17:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E19B301DB9C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61969347C6;
	Mon, 29 Dec 2025 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLkNdk4h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD6CA5A;
	Mon, 29 Dec 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026342; cv=none; b=gw4r8HHSLbIt6LtSq9pnyHkhz/5eMJKLl4WO83REaPpqBI6AofUrEud8l4+rhzp1u1RAMEyultsqR+Ukoo/qms4W1NBMTeV/dwTxDKPcOBph3p23fwxorlj2MSI+JVrHP6/yfvQIQLjDavI55NBvJ5Br6WxUDHBJ7RzhOnVyVd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026342; c=relaxed/simple;
	bh=GpifLfwkiu9eoC3V+KocP5lCF2mgL1SywA1OCMccwi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=btUJfmG0yhBrayQA3hDGiJLvEGq9Xvze3Yys/KTcba4nYaMJilIdqDYYvg/79NmxleYZU60aOeN0x0E6vIF6XtxcsdOnImatbKT0RZwxmn8oiJOVJFVgBxWTyvhbWd8yPoiJGt34RpgxB9WbhMo+nZWc1EPiKarF4X9JmnCrSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLkNdk4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5B3C4CEF7;
	Mon, 29 Dec 2025 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767026339;
	bh=GpifLfwkiu9eoC3V+KocP5lCF2mgL1SywA1OCMccwi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HLkNdk4hdwpfIXAI2Ox8hJv88WpG39J80SwhesPDoJ8n+Bzn38A0UaHPEnUuOMeVU
	 BvWpV7oD+nueOW4XtOhACKEFN0CB5X2IQ9kpSGPrJSGJLhgrV2OHwlFEhhsgQBJRnN
	 RSpc353okdJRve6qkaSCdQC8AQouDVQ/5FHMdvQ9dWGnzY7hjxDfq4BTxCRGeSyOFU
	 uefrw/XXHOYS++YnbEK0t6qyqtfM6vWkI/sJ/VYuPA+aStojG6sWrdmHvOs4a14SjF
	 +nUh2sdJbwKuRKX2QXYtz6rZzlBNGXC3VDf/nguI5vBfyVxxZQE7Q9SNd8kp4/SLz0
	 MQXpxA7/s5ywg==
Date: Mon, 29 Dec 2025 10:38:58 -0600
From: Bjorn Helgaas <healgaas@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: pnv_php: add WQ_PERCPU to alloc_workqueue users
Message-ID: <20251229163858.GA63361@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107143335.242342-1-marco.crivellari@suse.com>

On Fri, Nov 07, 2025 at 03:33:35PM +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.

Thanks for these patches.  We have:

  [PATCH] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
  [PATCH] PCI: endpoint: epf-mhi: add WQ_PERCPU to alloc_workqueue users
  [PATCH] PCI: endpoint: pci-epf-test: add WQ_PERCPU to alloc_workqueue users
  [PATCH] PCI: pnv_php: add WQ_PERCPU to alloc_workqueue users
  [PATCH] PCI: shpchp: add WQ_PERCPU to alloc_workqueue users
  [PATCH] PCI: endpoint: replace use of system_wq with system_percpu_wq

IIUC these are all part of the same effort to refactor the workqueue
API and don't really have anything to do with the endpoint or hotplug
drivers themselves.

So I put these all on pci/workqueue and squashed the WQ_PERCPU patches
together because they do the same thing, they have the same commit
log, and there's not really any point in reviewing them separately.

> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/pci/hotplug/pnv_php.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index c5345bff9a55..35f1758126c6 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -802,7 +802,7 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
>  	}
>  
>  	/* Allocate workqueue for this slot's interrupt handling */
> -	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
> +	php_slot->wq = alloc_workqueue("pciehp-%s", WQ_PERCPU, 0, php_slot->name);
>  	if (!php_slot->wq) {
>  		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
>  		kfree(php_slot->name);
> -- 
> 2.51.1
> 

