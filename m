Return-Path: <linux-pci+bounces-32961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C95B12605
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 23:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66D1587562
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65725D20D;
	Fri, 25 Jul 2025 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeXGADP4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AD925CC75;
	Fri, 25 Jul 2025 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477763; cv=none; b=Dt2ywL8rSEG7QCLw6QJIyb5Bqwa4GfzMBU2Zd7LIei7sd5yYoIkuN3cxvmHTevstyv+2k+P6w4buvMbykQEIldjEnQ2FbpKZaNs5D9dJH2u/qsQAmqseqtjd6SmaN8UeVWafDjFCA33JDjRMSpzGCr5zebeBnSpZqNOb0ecE8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477763; c=relaxed/simple;
	bh=sKZPH5aGqoMpNfxgwrfhIX0s6sqAPGYcI0cyVH7GSeU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sBcUwOLMmoonzyhIFv7iQH0eds1AN07CLZEcK2owTEyJEGUYSGiMKE1sU231HFgJrPdNcHWRRzmQObOk3U4cMsAqXD3glI40zNYvr4BkL51ojuq0Kj8318Ox2a224tTk4iWArMMc7F7rMP7mPqrQTIRqJrIrFOx4xAzypfRprX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeXGADP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9B7C4CEE7;
	Fri, 25 Jul 2025 21:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753477763;
	bh=sKZPH5aGqoMpNfxgwrfhIX0s6sqAPGYcI0cyVH7GSeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UeXGADP4I3UDVgDL6nXtFYDXECgC6KSMcjKec5PIjsOq3OgF+gpP+c/BRZ0Uujq+m
	 lpWOEqHqzDTh6vEDAzHAfaA+KnS/WZ/9AhacYNGkmi4ILau+Mjqhu4p6f1P+3osQHu
	 mfYfNL67QwCX9PaPRn2Q5Ootac+8ve8BhWxgdn7ZAs1vynrEoPiF1G6XzCNAeUkUXj
	 TK0PHhyQ2zOlWzofx/4GEpxXgQzJu+cvQ3pTk/YYlGU9JWQejlpEv+1d0enEvQQeHQ
	 gcY4R3E/0jANufYCoczZa+96ktJja3fjVnrKCrXBKOy6CLXgwJ5GC8b7NeOwJkH8pz
	 lZB3TlQr2a8Bg==
Date: Fri, 25 Jul 2025 16:09:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	mattc@purestorage.com, Jonathan.Cameron@huawei.com,
	bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
	anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
	peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
Message-ID: <20250725210921.GA3131414@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723033108.61587-3-xueshuai@linux.alibaba.com>

On Wed, Jul 23, 2025 at 11:31:08AM +0800, Shuai Xue wrote:
> PCIe link speed degradation directly impacts system performance and
> often indicates hardware issues such as faulty devices, physical layer
> problems, or configuration errors.
> 
> To this end, add a RAS tracepoint to monitor link speed changes,
> enabling proactive health checks and diagnostic analysis.
> 
> The output is like below:
> 
> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_link_event/enable
> $ cat /sys/kernel/debug/tracing/trace_pipe
> cat /sys/kernel/debug/tracing/trace_pipe
>            <...>-119     [002] .....   125.776171: pci_hp_event: 0000:00:03.0 slot:30, event:CARD_PRESENT
> 
>            <...>-119     [002] .....   125.776197: pci_hp_event: 0000:00:03.0 slot:30, event:LINK_UP
> 
>    irq/57-pciehp-119     [002] .....   125.904335: pcie_link_event: 0000:00:03.0 type:4, reason:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA
> 
>    irq/57-pciehp-119     [002] .....   125.907051: pcie_link_event: 0000:00:03.0 type:4, reason:0, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA

I guess this example would actually require both of these enables, right?

  echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
  echo 1 > /sys/kernel/debug/tracing/events/pci/pci_link_event/enable

> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>

I don't think I've suggested anything that really warrants this ;)

> ...
> @@ -292,7 +292,7 @@ int pciehp_check_link_status(struct controller *ctrl)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	bool found;
> -	u16 lnk_status, linksta2;
> +	u16 lnk_status;
>  
>  	if (!pcie_wait_for_link(pdev, true)) {
>  		ctrl_info(ctrl, "Slot(%s): No link\n", slot_name(ctrl));
> @@ -319,8 +319,7 @@ int pciehp_check_link_status(struct controller *ctrl)
>  		return -1;
>  	}
>  
> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
> -	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, linksta2);
> +	pcie_update_link_speed(ctrl->pcie->port->subordinate, PCIE_HOTPLUG);

It kind of bugs me that the hot-add flow reads LNKSTA three times and
generates both pci_hp_event LINK_UP and link_event tracepoints:

  pciehp_handle_presence_or_link_change
    link_active = pciehp_check_link_active()
      pcie_capability_read_word(PCI_EXP_LNKSTA)
    if (link_active)
      ctrl_info(ctrl, "Slot(%s): Link Up\n")
      trace_pci_hp_event(PCI_HOTPLUG_LINK_UP)
      pciehp_enable_slot
        __pciehp_enable_slot
          board_added
            pciehp_check_link_status
              pcie_capability_read_word(PCI_EXP_LNKSTA)
              pcie_update_link_speed
                pcie_capability_read_word(PCI_EXP_LNKSTA)
                pcie_capability_read_word(PCI_EXP_LNKSTA2)
                trace_pcie_link_event(<REASON>)

Maybe there are good reasons for reading LNKSTA three times, but it
does make me raise my eyebrows.  Not that this is a performance path,
but it just offends my sense of propriety.

And maybe we need both a bare LINK_UP event and a link_event with all
the details, but again it seems a little weird to me that there are
two tracepoints when there's really only one event and we know all the
link_event information from the very first LNKSTA read.

Bjorn

