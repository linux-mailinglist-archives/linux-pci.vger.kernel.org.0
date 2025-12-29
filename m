Return-Path: <linux-pci+bounces-43808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1FCE7A2C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 17:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AFB130019FE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F7145B27;
	Mon, 29 Dec 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCrOUkxD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEDC3A1E66;
	Mon, 29 Dec 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026461; cv=none; b=MN8KW5aPKxVRShIKw+FBhw5yzKXXjjOSnGmxfsauJlGCP4ltHdS08ZFsNSc1kIiuNAtCD7vMZDgbpk0X+7SlVPi2CiKf6AYx4a41AD5Cb8ermks8HEoLaiTUhfrIAq691KtsDXTL07/SaXEcmE/o80aZOncWZRDPO5b0wmB0UeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026461; c=relaxed/simple;
	bh=TCOm2rpJ9OfMmoFF8qLCjdeSTuH9rwbAp36mqtKXFwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hZFUcRHgdt/WmCSBLR+fBonu6HrJT9ZA4VYVux4c8u32WhkBmFoUgNVdXBJqUjgZx1CZh/YZSX8ci0wevgoq8VSAsFkimY+RWNUMfoVNfWoRwcFAyNHJeZeUBBANR3hGgIgjBqOfQzQBZ06ZrIpUtLBmIO7RucTNUgIeH+ZurQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCrOUkxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0601BC4CEF7;
	Mon, 29 Dec 2025 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767026461;
	bh=TCOm2rpJ9OfMmoFF8qLCjdeSTuH9rwbAp36mqtKXFwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SCrOUkxD/fqe0Uj8Z+gIaxo/OAcM/I9RZS+8x8Vu+ElHvSFcWZmxRskuec642feIa
	 5LxlBqlU/HOd0Rd+36uLnThkwZOJJmgB69EAL6ZDXCEfOGcNccFO0QQEc4E4mLEuis
	 S+QKquV301HMvyIhtfeoc/NzhcvkozHh46JJWZE/QpjfwGji5/0Ktbt+oitQ7IcgQr
	 fsSSWipTaUZBwkCHwUg9Dx5XUcTOIOZkmk2W6AjtQzBUZVqHhCTRTMhFB9F20mSpvq
	 8nixt/vMYZTrZ+7tupsy2yVsYaGSlpmW1DUOQV6xXcN7Umw43vktAdOauB1dCA2whX
	 jMoyrB/lCVr8w==
Date: Mon, 29 Dec 2025 10:40:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI: shpchp: add WQ_PERCPU to alloc_workqueue users
Message-ID: <20251229164059.GA65997@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107143624.244978-1-marco.crivellari@suse.com>

[+cc Mani]

On Fri, Nov 07, 2025 at 03:36:24PM +0100, Marco Crivellari wrote:
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
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Squashed with similar patches [1] and applied on pci/workqueue for
v6.20, thanks!

See https://lore.kernel.org/r/20251229163858.GA63361@bhelgaas

> ---
>  drivers/pci/hotplug/shpchp_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
> index 0c341453afc6..56308515ecba 100644
> --- a/drivers/pci/hotplug/shpchp_core.c
> +++ b/drivers/pci/hotplug/shpchp_core.c
> @@ -80,7 +80,8 @@ static int init_slots(struct controller *ctrl)
>  		slot->device = ctrl->slot_device_offset + i;
>  		slot->number = ctrl->first_slot + (ctrl->slot_num_inc * i);
>  
> -		slot->wq = alloc_workqueue("shpchp-%d", 0, 0, slot->number);
> +		slot->wq = alloc_workqueue("shpchp-%d", WQ_PERCPU, 0,
> +					   slot->number);
>  		if (!slot->wq) {
>  			retval = -ENOMEM;
>  			goto error_slot;
> -- 
> 2.51.1
> 

