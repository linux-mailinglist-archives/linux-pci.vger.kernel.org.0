Return-Path: <linux-pci+bounces-13040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F8D97553B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 16:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B221F26000
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EBA19E96A;
	Wed, 11 Sep 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5xPkGWa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E719C549;
	Wed, 11 Sep 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064837; cv=none; b=AD5k7q/42fgbfL/fBhkHXS09QSPVoDGGtrEOkG90uE1GD9pnRPumBf7Kl0b5Pq0icrgCvJIOyj6T8KuRxmzyo63AQa70hKy77c3bbhzeyOBu7pW7Qh9NiO7utK43Og2u21zJQ3kqjKIjI0bVDD1AQMl8ykS/RZ/FAmR+EG2Qdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064837; c=relaxed/simple;
	bh=FaOwNupyl9iAIlCSstUPhKFSdOd6TxiIQxicMnmypzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i1wwfh8Sm4WNXrxuuayR+pg1nPHGidXh0pyD2wr0QAJ2IbcYc9LRPEf5AY+43f/Q++FSsFgCfbzBMiE3j+0QcOV9yL5sZoFYKLmpOzv+G3j+kT1MG92d0Bzpwfyej+7mIucL+tSfSkTC2A09IbIrq6yFA1tTHvrU7aIVeQErPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5xPkGWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC87C4CEC0;
	Wed, 11 Sep 2024 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726064837;
	bh=FaOwNupyl9iAIlCSstUPhKFSdOd6TxiIQxicMnmypzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T5xPkGWap9jxKexIvUS7sty9qun3N17h+2CyAVNokPp58NdbQZv44vbEG44tPp3Wn
	 BGJbAzyBajZppT9ftEb4YABZahmYsHC1JmBbkz8HPQ4Hz9wTClqmN9xmeDeoxl3FvG
	 uWMfXkjW7xCILQ5N3GSlC3DjZyFUFpakLoeAk+cBB1y648jL1/D8f+bsi/3rHBVoIW
	 JBVzZaDaMGWp7y4zfDmDe8R/1Xw4dK/SRwFVR5s+sqtl0jh4lxPNII/5uFY5o6Xy1S
	 oOUPuwKhIAzv8+IQbsvi4pM+zg4G0XTWxMhuVmzFRj9+bno/UoGjXt7eP50Y5yQ34P
	 ClzXMB39W1IbQ==
Date: Wed, 11 Sep 2024 09:27:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2] PCI: Fix potential deadlock in pcim_intx()
Message-ID: <20240911142715.GA633951@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905072556.11375-2-pstanner@redhat.com>

On Thu, Sep 05, 2024 at 09:25:57AM +0200, Philipp Stanner wrote:
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
> ---
> @Bjorn:
> This problem was introduced in the v6.11 merge window. So one might
> consider getting it into mainline before v6.11.0 gets tagged.

Applied with Damien's Reviewed-by to pci/for-linus for v6.11, thanks.

> ---
>  drivers/pci/devres.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 3780a9f9ec00..c7affbbf73ab 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -483,6 +483,8 @@ static void pcim_disable_device(void *pdev_raw)
>  
>  	if (!pdev->pinned)
>  		pci_disable_device(pdev);
> +
> +	pdev->is_managed = false;
>  }
>  
>  /**
> -- 
> 2.46.0
> 

