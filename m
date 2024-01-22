Return-Path: <linux-pci+bounces-2436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC65837163
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 19:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E05B1C29F9F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436AF3FB12;
	Mon, 22 Jan 2024 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmoNOs/z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201753FB10
	for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948133; cv=none; b=PZrW5kAIhdzKQIn83q9QyhzI6GZH487SphZeD0II4fW8/eK/xatBUI7b0o5sEPvBJf0W+krgKowkmK90Rpuc9I+UGvcuC6UpERGK5wStRVUKttOY1EYReGogBfrO1htN494sKO05CpnczvOtElvvcN3/nUDnYK59F8aPvKSr88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948133; c=relaxed/simple;
	bh=Gxrj3RinyAwxp2VAysXILL2r0IZ3ZCqP9A9eSM4h23E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IBU2qH5YBb7Wwtjg9DhJxs7q1yhKH1VkTKmbqolxJu1fSn+c2X+25ttcrSyxIJwPIQoqn7BU/gVRAkigohPvaFEUXWbldGM/ZKkdoh2SYKZOjbRenjlTwRgJB7oR0r8u4JgeOD/SSnJi7yDhabcopqsFMeMTyNgSYOTqPVlaSZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmoNOs/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B30C433F1;
	Mon, 22 Jan 2024 18:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705948131;
	bh=Gxrj3RinyAwxp2VAysXILL2r0IZ3ZCqP9A9eSM4h23E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QmoNOs/ztgu28QIu02gqNCUN+QCbxFQOjLSe7TpvTQHUnTsPFBfnlFU/gleJ6CGTQ
	 9oblOkAG8FZrvahatFuwClhStrAdCTegoS+L9szYspxwd0iU37SYvwaRBRv6CLN3zL
	 Y2t0/tnuNH9RHi6GP9QCUOXxwZ09baT771jgFZo1BKrefgS/idyKASFpt8pIY/Uwdv
	 u584lAxeggWvEWB1QjuQ0Vb9Qo7L7q7HFPT5zyaJr3Q8JF/ZipfnTy7F9Qj+06UNWx
	 9HKmJC+74CORyKH7tlTQONfysHe29IyksCrQeuqEj9WjXWYQsh4uYWRoqkP6SyxX2S
	 r+bb0tSbpZljw==
Date: Mon, 22 Jan 2024 12:28:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [bug report] Revert "PCI/ASPM: Remove
 pcie_aspm_pm_state_change()"
Message-ID: <20240122182849.GA277265@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ee741c-7fbd-4061-87c6-c4ae46c372c1@moroto.mountain>

[+cc Johan, Kai-Heng]

On Mon, Jan 22, 2024 at 05:43:09PM +0300, Dan Carpenter wrote:
> Hello Bjorn Helgaas,
> 
> The patch f93e71aea6c6: "Revert "PCI/ASPM: Remove
> pcie_aspm_pm_state_change()"" from Jan 1, 2024 (linux-next), leads to
> the following Smatch static checker warning:
> 
> 	drivers/pci/pcie/aspm.c:1017 pcie_aspm_pm_state_change()
> 	warn: sleeping in atomic context

Thanks Dan, this is probably related to the lockdep issue Johan
reported here:
https://lore.kernel.org/r/ZZu0qx2cmn7IwTyQ@hovoldconsulting.com

This is definitely an open issue that should be resolved.

Bjorn

> drivers/pci/pcie/aspm.c
>     1007 void pcie_aspm_pm_state_change(struct pci_dev *pdev)
>     1008 {
>     1009         struct pcie_link_state *link = pdev->link_state;
>     1010 
>     1011         if (aspm_disabled || !link)
>     1012                 return;
>     1013         /*
>     1014          * Devices changed PM state, we should recheck if latency
>     1015          * meets all functions' requirement
>     1016          */
> --> 1017         down_read(&pci_bus_sem);
> 
> This is a revert from a patch from 2022 which was before I had written
> this "sleeping in atomic" static checker thing.
> 
>     1018         mutex_lock(&aspm_lock);
>     1019         pcie_update_aspm_capable(link->root);
>     1020         pcie_config_aspm_path(link);
>     1021         mutex_unlock(&aspm_lock);
>     1022         up_read(&pci_bus_sem);
>     1023 }
> 
> The call trees that Smatch is complaining about are:
> 
> vortex_boomerang_interrupt() <- disables preempt
> -> _vortex_interrupt()
> -> _boomerang_interrupt()
>    -> vortex_error()
>       -> vortex_up()
> velocity_suspend() <- disables preempt
> -> velocity_set_power_state()
>          -> pci_set_power_state()
>             -> pci_set_low_power_state()
>                -> pcie_aspm_pm_state_change()
> 
> So what Smatch is saying is the vortex_boomerang_interrupt() and
> velocity_suspend() hold spin locks and then set the power state.  The
> call trees are quite long so I'm not really able to be sure if this is
> a false positive or not...  I wish this warning were more useful.
> 
> These emails are a one time thing.  Just reply if it's a false positive
> and I'll note it down.  Otherwise feel free to ignore it.
> 
> regards,
> dan carpenter

