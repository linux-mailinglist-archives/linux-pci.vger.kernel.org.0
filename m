Return-Path: <linux-pci+bounces-12863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B77E96E6E3
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 02:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98421C21ACA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 00:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76D7DDC3;
	Fri,  6 Sep 2024 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpuPjX3y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1491BC20;
	Fri,  6 Sep 2024 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725583087; cv=none; b=rslQL0wZ554pe/H8JNmSzrLHS5XUQATe7/ioatRRveNWYOTH6ZoIHv9KJ9yaGhSSIn9R/zm6aIzj92ROxXuC2FFrYaHoCMC5+ZgvHQ/qZFNHUeRV5vWBOFIizHBFLl/ByEXLoG7e8PFkOvYSm9VjaafBtGJhFGSm05Ao3+eq8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725583087; c=relaxed/simple;
	bh=h/bqzGls6F7f+dDC2lwmv7475uUwIOKUKCi9ByDT+Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZcoEC0MR728sGBOOmo+lWOrzaqVpcVw1BDF+zxiz8fnjDxMZ9K8/gw8a69GP6XvpI5QmbTQFD5k+8kqj8sVCoZtIlNpDA9Oo6rzLbbKpROl4GNXeZmrpp1L6kD0C/Ur840xwxDyebOy/iPo+Klj5cciuPZU295BS+C/ebfox9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpuPjX3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65758C4CEC3;
	Fri,  6 Sep 2024 00:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725583087;
	bh=h/bqzGls6F7f+dDC2lwmv7475uUwIOKUKCi9ByDT+Ww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cpuPjX3yAjmfIuD+2Ip0CWYTHwwoNGOHouPTav4d9IxNC2gGJ2RLGksGnKoTlmlRI
	 z+i+6b/l5puvb9vt1DvoBB6vQR1vaE2ZoU3SLzW6oIHaR/Mtpl2y4kwlOUr3dc8h7O
	 A7NhcJX1HrbvxYQumRE9nHwVJm/dVWzTr1EbnEvnFuMBTj0IbzT9d0CxU7Y5k/K0AW
	 YK418D1xlD/sJgakPHGgDHl713wbm2G/wdnKl8wdlvLFrUB6i75GDOdUu2V2O1xr5t
	 CCLgl2Y9HHnEgQpAqePtH28T3hLi+ADdCs2C6bioOl8UfxUrWOIWrVNZOdSfvP7dNY
	 2xEJgb+OpGORw==
Message-ID: <c979a2e5-3d81-49e3-bc58-78d8d9db2296@kernel.org>
Date: Fri, 6 Sep 2024 09:38:04 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Fix potential deadlock in pcim_intx()
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240905072556.11375-2-pstanner@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240905072556.11375-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 16:25, Philipp Stanner wrote:
> commit 25216afc9db5 ("PCI: Add managed pcim_intx()") moved the
> allocation step for pci_intx()'s device resource from
> pcim_enable_device() to pcim_intx(). As before, pcim_enable_device()
> sets pci_dev.is_managed to true; and it is never set to false again.
> 
> Due to the lifecycle of a struct pci_dev, it can happen that a second
> driver obtains the same pci_dev after a first driver ran.
> If one driver uses pcim_enable_device() and the other doesn't,
> this causes the other driver to run into managed pcim_intx(), which will
> try to allocate when called for the first time.
> 
> Allocations might sleep, so calling pci_intx() while holding spinlocks
> becomes then invalid, which causes lockdep warnings and could cause
> deadlocks:
> 
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 6.11.0-rc6+ #59 Tainted: G        W
> --------------------------------------------------------
> CPU 0/KVM/1537 just changed the state of lock:
> ffffa0f0cff965f0 (&vdev->irqlock){-...}-{2:2}, at:
> vfio_intx_handler+0x21/0xd0 [vfio_pci_core] but this lock took another,
> HARDIRQ-unsafe lock in the past: (fs_reclaim){+.+.}-{0:0}
> 
> and interrupts could create inverse lock ordering between them.
> 
> other info that might help us debug this:
>  Possible interrupt unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                local_irq_disable();
>                                lock(&vdev->irqlock);
>                                lock(fs_reclaim);
>   <Interrupt>
>     lock(&vdev->irqlock);
> 
>  *** DEADLOCK ***
> 
> Have pcim_enable_device()'s release function, pcim_disable_device(), set
> pci_dev.is_managed to false so that subsequent drivers using the same
> struct pci_dev do implicitly run into managed code.
> 
> Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: https://lore.kernel.org/all/20240903094431.63551744.alex.williamson@redhat.com/
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Tested-by: Alex Williamson <alex.williamson@redhat.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


