Return-Path: <linux-pci+bounces-11627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF79A95028E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 12:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82E81C21AEB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17519412F;
	Tue, 13 Aug 2024 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tMG2dG6W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F736194083;
	Tue, 13 Aug 2024 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545453; cv=none; b=XJ9q9dZmLP/H3tdKY4T0j1vkylH+x+1RodaMfPbX5Y4z3WfCzztMz/bvTwEM5gCi1zjA4DGDPn4IFhYNypnoY48HfeBhM/3YII8kQBR1mMEGfNzsEIJohdQiKELIq1YYoEv25YyaUh2flr/OJK0BxQYYLOI4Bma/7a+s1L1Evx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545453; c=relaxed/simple;
	bh=lW1qjs04AbAiMwjIgti1TMx0YBebE/C8dqm9HUmHRT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpQRkVCDUAhhFYQzkPO1tE31VZGEK3Kum/yIQf4Vaje2xvhv2EJ3k+MFoXZjaR/0S5Q0oILjF9K3HZx2blcAJvaCjT4MGNgSA26YH1t9S/+oGn85HV31IHMjAAAhBBGkmiqvrUuN0orUw7ThE/fxzSKrPb+AAzmrKYE63oH4z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tMG2dG6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C57BC4AF11;
	Tue, 13 Aug 2024 10:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723545453;
	bh=lW1qjs04AbAiMwjIgti1TMx0YBebE/C8dqm9HUmHRT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMG2dG6WcpEYvQzQVjVOTn6bKA8nbvWK3KodDuIY/6rJ21w9cjiEzQjG0o5RYizex
	 zeiNI4Ihgv2j7qo0zq/oFYlgfn30io3SBpq+p2UZzMATWLwU9oT3pW8zTGohq5L5Ul
	 JmdWgI0GdBXOAAgHtOntLu4ZJcNUloKMEzSilCmM=
Date: Tue, 13 Aug 2024 12:37:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>
Subject: Re: [PATCH 5.10-stable] PCI/DPC: Fix use-after-free on concurrent
 DPC and hot-removal
Message-ID: <2024081319-scruffy-faster-3311@gregkh>
References: <4d4ac43578f9aad9d7eee85a51833ae5e4b7cdb3.1722335040.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d4ac43578f9aad9d7eee85a51833ae5e4b7cdb3.1722335040.git.lukas@wunner.de>

On Tue, Jul 30, 2024 at 12:26:55PM +0200, Lukas Wunner wrote:
> commit 11a1f4bc47362700fcbde717292158873fb847ed upstream.
> 
> Keith reports a use-after-free when a DPC event occurs concurrently to
> hot-removal of the same portion of the hierarchy:
> 
> The dpc_handler() awaits readiness of the secondary bus below the
> Downstream Port where the DPC event occurred.  To do so, it polls the
> config space of the first child device on the secondary bus.  If that
> child device is concurrently removed, accesses to its struct pci_dev
> cause the kernel to oops.
> 
> That's because pci_bridge_wait_for_secondary_bus() neglects to hold a
> reference on the child device.  Before v6.3, the function was only
> called on resume from system sleep or on runtime resume.  Holding a
> reference wasn't necessary back then because the pciehp IRQ thread
> could never run concurrently.  (On resume from system sleep, IRQs are
> not enabled until after the resume_noirq phase.  And runtime resume is
> always awaited before a PCI device is removed.)
> 
> However starting with v6.3, pci_bridge_wait_for_secondary_bus() is also
> called on a DPC event.  Commit 53b54ad074de ("PCI/DPC: Await readiness
> of secondary bus after reset"), which introduced that, failed to
> appreciate that pci_bridge_wait_for_secondary_bus() now needs to hold a
> reference on the child device because dpc_handler() and pciehp may
> indeed run concurrently.  The commit was backported to v5.10+ stable
> kernels, so that's the oldest one affected.
> 
> Add the missing reference acquisition.
> 
> Abridged stack trace:
> 
>   BUG: unable to handle page fault for address: 00000000091400c0
>   CPU: 15 PID: 2464 Comm: irq/53-pcie-dpc 6.9.0
>   RIP: pci_bus_read_config_dword+0x17/0x50
>   pci_dev_wait()
>   pci_bridge_wait_for_secondary_bus()
>   dpc_reset_link()
>   pcie_do_recovery()
>   dpc_handler()
> 
> Fixes: 53b54ad074de ("PCI/DPC: Await readiness of secondary bus after reset")
> Closes: https://lore.kernel.org/r/20240612181625.3604512-3-kbusch@meta.com/
> Link: https://lore.kernel.org/linux-pci/8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de
> Reported-by: Keith Busch <kbusch@kernel.org>
> Tested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: stable@vger.kernel.org # v5.10+
> ---
>  drivers/pci/pci.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 

Both now queued up, thanks.

greg k-h

