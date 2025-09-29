Return-Path: <linux-pci+bounces-37223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BC3BAA3BC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E5816880F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E1221544;
	Mon, 29 Sep 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6Aw+r6B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474317736;
	Mon, 29 Sep 2025 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168445; cv=none; b=hZSqu2GRfbusDN8QwKUJqRMDBHn0AJFw7Njwj7jEhhmQs/Zao9+NRpbiV0OS6ZGZM/jGvPBbF4pgq1p11ni54aDICox9zkoQhBI4+X9WS4cWxdVmlor85BZN0ZH5EYNdKtiOYF1FLDXKKqRGdavgkWDhzum8C+SZue1/EQGE59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168445; c=relaxed/simple;
	bh=PCBsGpd6X+jILembqK+s34pLQKhI31Q5FYULNljasxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5H/T8T/WBa2Nfw1BEASPMFeV78PRZoINN2qN+YEEyfJ/bs5lET92HKGj/yGl5CUEi5DduD1haMKB8cSCCZ0eq+mMtGaM+3Gz714bDsoreKqB5m2rkCNu0i5IS8fKyhKgsdWx27cam6+LGVP14swYByUpeWekLbED4pAAuM1WE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6Aw+r6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8505C4CEF4;
	Mon, 29 Sep 2025 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759168444;
	bh=PCBsGpd6X+jILembqK+s34pLQKhI31Q5FYULNljasxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6Aw+r6BjzzxfKFcBe/Nv0S1rnnX5W58Hs1c3XgOomQENJXR8Zwnc4g6/gnZT8uu3
	 wx0Mczsv+HtV0RRh4kxOtbuBN4XMxTBxp51zweJaOjVsMU7jVtvzxOUAw2pdotgqdY
	 DKqPGjpxCGTMRC/WMpEZaUg+E3kuBSvo9UBDojsUi5o5L2oCC0W89+i7sNuU5adssl
	 tRtPn8vOb1Q8s5khRimhywdBN8/9pqqogd6LRfbV3fNHLW/6MbobM2KtzFNuVX+rk4
	 DAIR/yA9yeK76Pj77KA0UO8RaloXMWp+poUjrknigQfLqAimNS5QjmlTG0rE8jngn8
	 VvMthvBQl2MSg==
Date: Mon, 29 Sep 2025 23:23:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Fix sleeping function being
 called from atomic context
Message-ID: <te2mzunvwphcoiypwdb6oee3m54jquxk4br6f4tjxlp625whbr@kzzhai5eg2xv>
References: <20250917161817.15776-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917161817.15776-1-bhanuseshukumar@gmail.com>

On Wed, Sep 17, 2025 at 09:48:17PM +0530, Bhanu Seshu Kumar Valluri wrote:
> When Root Complex(RC) triggers a Doorbell MSI interrupt to Endpoint(EP) it triggers a warning
> in the EP. pci_endpoint kselftest target is compiled and used to run the Doorbell test in RC.
> 
> [  474.686193] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:271
> [  474.694656] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
> [  474.702473] preempt_count: 10001, expected: 0
> [  474.706819] RCU nest depth: 0, expected: 0
> [  474.710913] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc5-g7aac71907bde #12 PREEMPT
> [  474.710926] Hardware name: Texas Instruments AM642 EVM (DT)
> [  474.710934] Call trace:
> [  474.710940]  show_stack+0x20/0x38 (C)
> [  474.710969]  dump_stack_lvl+0x70/0x88
> [  474.710984]  dump_stack+0x18/0x28
> [  474.710995]  __might_resched+0x130/0x158
> [  474.711011]  __might_sleep+0x70/0x88
> [  474.711023]  mutex_lock+0x2c/0x80
> [  474.711036]  pci_epc_get_msi+0x78/0xd8
> [  474.711052]  pci_epf_test_raise_irq.isra.0+0x74/0x138
> [  474.711063]  pci_epf_test_doorbell_handler+0x34/0x50
> [  474.711072]  __handle_irq_event_percpu+0xac/0x1f0
> [  474.711086]  handle_irq_event+0x54/0xb8
> [  474.711096]  handle_fasteoi_irq+0x150/0x220
> [  474.711110]  handle_irq_desc+0x48/0x68
> [  474.711121]  generic_handle_domain_irq+0x24/0x38
> [  474.711131]  gic_handle_irq+0x4c/0xc8
> [  474.711141]  call_on_irq_stack+0x30/0x70
> [  474.711151]  do_interrupt_handler+0x70/0x98
> [  474.711163]  el1_interrupt+0x34/0x68
> [  474.711176]  el1h_64_irq_handler+0x18/0x28
> [  474.711189]  el1h_64_irq+0x6c/0x70
> [  474.711198]  default_idle_call+0x10c/0x120 (P)
> [  474.711208]  do_idle+0x128/0x268
> [  474.711220]  cpu_startup_entry+0x3c/0x48
> [  474.711231]  rest_init+0xe0/0xe8
> [  474.711240]  start_kernel+0x6d4/0x760
> [  474.711255]  __primary_switched+0x88/0x98
> 

You do not need to use full call trace. Refer:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17#n761

> Warnings can be reproduced by following steps below.
> *On EP side:
> 1. Configure the pci-epf-test function using steps given below
>    mount -t configfs none /sys/kernel/config
>    cd /sys/kernel/config/pci_ep/
>    mkdir functions/pci_epf_test/func1
>    echo 0x104c > functions/pci_epf_test/func1/vendorid
>    echo 0xb010 > functions/pci_epf_test/func1/deviceid
>    echo 32 > functions/pci_epf_test/func1/msi_interrupts
>    echo 2048 > functions/pci_epf_test/func1/msix_interrupts
>    ln -s functions/pci_epf_test/func1 controllers/f102000.pcie-ep/
>    echo 1 > controllers/f102000.pcie-ep/start
> 
> *On RC side:
> 1. Once EP side configuration is done do pci rescan.
>    echo 1 > /sys/bus/pci/rescan
> 2. Run Doorbell MSI test using pci_endpoint_test kselftest app.
>   ./pci_endpoint_test -r pcie_ep_doorbell.DOORBELL_TEST

This info is already part of the kernel documentation. So it is redundant here.
It could be probably added in the comment section (where you added the Note).

>   Note: Kernel is compiled with CONFIG_DEBUG_KERNEL enabled.
> 
> The BUG arises because the EP's Doorbell MSI hard interrupt handler is making an
> indirect call to pci_epc_get_msi, which uses mutex inside, from interrupt context.
> 
> This patch converts hard irq handler to a threaded irq handler to allow it
> to call functions that can sleep during bottom half execution. The threaded
> irq handler is registered with IRQF_ONESHOT and keeps interrupt line disabled
> until the threaded irq handler completes execution.
> 
> Fixes: eff0c286aa916221a69126 ("PCI: endpoint: pci-epf-test: Add doorbell test support")

Use 12 char commit SHA.

> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---
>  Note : It is compiled and tested on TI am642 board.
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e091193bd..b9c1ad931 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -680,7 +680,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	}
>  }
>  
> -static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
> +static irqreturn_t pci_epf_test_doorbell_irq_thread(int irq, void *data)

No need to change the function name.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

