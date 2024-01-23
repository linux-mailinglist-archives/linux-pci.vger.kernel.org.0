Return-Path: <linux-pci+bounces-2493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA01839679
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 18:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21501C272D1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415CD8004C;
	Tue, 23 Jan 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ua6xuyLQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D780047
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031197; cv=none; b=pDRMYcdJJ/1E5dpoJOyl+vZEemKr9eVb/sjtSFlaW9mmHq4k8DVSs7BGmokGQGyfWDtGkW30LrQC1y6XXfxqbwtMEH77KwcUN3AO3RBhbJ/0OCPAgBPYKHD2i+iH8tGwmM/cyMPjAgjOt82AHWb8nv/H1tDvhOpAB187Mt/rkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031197; c=relaxed/simple;
	bh=JXkTPS3QFT83mAH3b+X6kEVG9h0vym3H1T72WAQuz+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6lG61onkkUCWyvSmrFTut3v/cLkejyJ7WWpdOmKJBanwAnB7uL3qKBYKbanVC5TD+ShKb9doPSoRUOjOepJxKd3bvmoFwxRVH89IxVmkNEEKkPLQrlC8UJkngcBTjzfPZH2cNxKn83jY4wnLsXSzGKRBRgX5V5ZgLmSFzEZgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ua6xuyLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C91C43394;
	Tue, 23 Jan 2024 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706031196;
	bh=JXkTPS3QFT83mAH3b+X6kEVG9h0vym3H1T72WAQuz+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ua6xuyLQ1SOXVev77HAA8rvPX3/erDZv8thiirBsvEbh23/JADSTObIBBBC0cFH4q
	 ot0YoRy3vouYLMeVgOPt/6OiaKmfE5AgAs51MZL9zyb6W/qtC8WTkIdcb4p5Q3sr+v
	 x14Po8Z299vaM6tJ2A9O7BaIdVBGtv7tC7GIqafIUV5jX8LKGuuqfV1fnR9aOeE4F+
	 UxHq8uVq/wUkfthRhOdqoObXvODox6u1nuehE4JexWW1yUDdss/gp7tBFMyd5QszFW
	 4IMjE2XGfZA3af4u/PitMXCT+cmtBx7iFVHuxIQ7fGezU2/wT9lhdvQY/LAtJCiH7w
	 xDfdfxi5w6bpg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rSKeP-000000000Bc-2Mbv;
	Tue, 23 Jan 2024 18:33:30 +0100
Date: Tue, 23 Jan 2024 18:33:29 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [bug report] Revert "PCI/ASPM: Remove
 pcie_aspm_pm_state_change()"
Message-ID: <Za_4aY93mWFzp9A4@hovoldconsulting.com>
References: <29ee741c-7fbd-4061-87c6-c4ae46c372c1@moroto.mountain>
 <20240122182849.GA277265@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122182849.GA277265@bhelgaas>

On Mon, Jan 22, 2024 at 12:28:49PM -0600, Bjorn Helgaas wrote:
> [+cc Johan, Kai-Heng]
> 
> On Mon, Jan 22, 2024 at 05:43:09PM +0300, Dan Carpenter wrote:
> > Hello Bjorn Helgaas,
> > 
> > The patch f93e71aea6c6: "Revert "PCI/ASPM: Remove
> > pcie_aspm_pm_state_change()"" from Jan 1, 2024 (linux-next), leads to
> > the following Smatch static checker warning:
> > 
> > 	drivers/pci/pcie/aspm.c:1017 pcie_aspm_pm_state_change()
> > 	warn: sleeping in atomic context
> 
> Thanks Dan, this is probably related to the lockdep issue Johan
> reported here:
> https://lore.kernel.org/r/ZZu0qx2cmn7IwTyQ@hovoldconsulting.com

This looks like a separate issue actually.

> > drivers/pci/pcie/aspm.c
> >     1007 void pcie_aspm_pm_state_change(struct pci_dev *pdev)
> >     1008 {
> >     1009         struct pcie_link_state *link = pdev->link_state;
> >     1010 
> >     1011         if (aspm_disabled || !link)
> >     1012                 return;
> >     1013         /*
> >     1014          * Devices changed PM state, we should recheck if latency
> >     1015          * meets all functions' requirement
> >     1016          */
> > --> 1017         down_read(&pci_bus_sem);
> > 
> > This is a revert from a patch from 2022 which was before I had written
> > this "sleeping in atomic" static checker thing.
> > 
> >     1018         mutex_lock(&aspm_lock);
> >     1019         pcie_update_aspm_capable(link->root);
> >     1020         pcie_config_aspm_path(link);
> >     1021         mutex_unlock(&aspm_lock);
> >     1022         up_read(&pci_bus_sem);
> >     1023 }
> > 
> > The call trees that Smatch is complaining about are:
> > 
> > vortex_boomerang_interrupt() <- disables preempt
> > -> _vortex_interrupt()
> > -> _boomerang_interrupt()
> >    -> vortex_error()
> >       -> vortex_up()
> > velocity_suspend() <- disables preempt
> > -> velocity_set_power_state()
> >          -> pci_set_power_state()
> >             -> pci_set_low_power_state()
> >                -> pcie_aspm_pm_state_change()

Based on a very quick look, I don't think it has ever been valid to call
pci_set_power_state() from atomic context as it for, for example, can
call pci_bus_set_current_state() which also takes the bus semaphore.

Johan

