Return-Path: <linux-pci+bounces-20904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AB3A2C5CC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 15:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D72416A053
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB27D23ED6E;
	Fri,  7 Feb 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyZzT7ie"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887861DED42;
	Fri,  7 Feb 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939524; cv=none; b=Z7J/iaRBP/GAxKHXIJ8rayddHcVeX7d/zAMVNkCKI6UBcPgCNnDKVCwFWc6kClPqHQmZytwhkcsLB82bb1sdB7Ab82TQnMFz0c1C7j+UQXfnFCgQ8c79nAKxrCAoMhOJnE29wkUwsKVIHXySdZSYbXM7TKSruwofMAa4FeaSKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939524; c=relaxed/simple;
	bh=5DOXsTBCLWDukYgXDGE7HUsUDmPI33tceJtDhzkYxaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI5qljOUP83w/DUNmSWpsmbZT8X1aRvmzYEVRFNnJVbU084fPygrlyhQKI3ihvJ0QDVUg6GmCz5RGLS74IdRXaoLom0RS0ZiAILJHiaGTP/ADpa9lFYHg3CtZvRNBr9gyUcuglmcU4WqmkkVclBp/zE+o188TCc723tsteAK3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyZzT7ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE8BC4CED1;
	Fri,  7 Feb 2025 14:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738939524;
	bh=5DOXsTBCLWDukYgXDGE7HUsUDmPI33tceJtDhzkYxaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyZzT7iez1xN+DTFavfHdH1dfXEpqOsmB/Gk5ZpxqfU5k3kQIzhTXOQXdYSAqrWuw
	 9sEo23k5ZSjUkyhf6srq7WSDcAWRzR2bSpOzcmy1UzwNI8NSM4FI/reI8+DruZZApy
	 ayHVjGBIjHHHMR4e2w3MNdt890O+3vY5zjYbBirNu7lOxAe9veMmkEalf8eBKDoOwT
	 6AL/ApI4B4anv5Xnf+tky5Zoubv+i9I10bUN+XvFDwoXyd19Xm2ghHA0ZfZIhnvdka
	 d1HSmRWs7SBsMXQXlS3r5GWHEe1L/NkKvKA3ndJF1fWJqzO924DwQZVtma/NF+rLnG
	 dN39uY/uwuwDg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tgPbo-0000000076Y-0mEN;
	Fri, 07 Feb 2025 15:45:32 +0100
Date: Fri, 7 Feb 2025 15:45:32 +0100
From: Johan Hovold <johan@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
Message-ID: <Z6YcjFBWAVVVANf2@hovoldconsulting.com>
References: <12619233.O9o76ZdvQC@rjwysocki.net>
 <1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com>
 <Z6YPpbRF_U0TxAbf@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6YPpbRF_U0TxAbf@hovoldconsulting.com>

On Fri, Feb 07, 2025 at 02:50:29PM +0100, Johan Hovold wrote:

> Yeah, I hit something like this yesterday as well and did confirm that
> reverting this commit makes the problem go away. Haven't had time to dig
> much further.
> 
> [  110.522368] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000

> [  110.855238] Call trace:
> [  110.857861]  simple_pm_bus_runtime_suspend+0x14/0x48 (P)
> [  110.863425]  pm_generic_runtime_suspend+0x2c/0x44
> [  110.868362]  pm_runtime_force_suspend+0x54/0x100
> [  110.873217]  dpm_run_callback+0xb4/0x228
> [  110.877347]  device_suspend_noirq+0x70/0x2a8
> [  110.881844]  dpm_noirq_suspend_devices+0xe0/0x230
> [  110.886778]  dpm_suspend_noirq+0x24/0x98
> [  110.890904]  suspend_devices_and_enter+0x368/0x678
> [  110.895941]  pm_suspend+0x1b4/0x348
> [  110.899627]  state_store+0x8c/0xfc
> [  110.903228]  kobj_attr_store+0x18/0x2c
> [  110.907195]  sysfs_kf_write+0x4c/0x78
> [  110.911074]  kernfs_fop_write_iter+0x120/0x1b4
> [  110.915735]  vfs_write+0x2ac/0x358
> [  110.919352]  ksys_write+0x68/0xfc
> [  110.922873]  __arm64_sys_write+0x1c/0x28
> [  110.927002]  invoke_syscall+0x48/0x110
> [  110.930969]  el0_svc_common.constprop.0+0x40/0xe0
> [  110.935907]  do_el0_svc+0x1c/0x28
> [  110.939427]  el0_svc+0x48/0x114
> [  110.942769]  el0t_64_sync_handler+0xc8/0xcc
> [  110.947180]  el0t_64_sync+0x198/0x19c
> [  110.951059] Code: a9be7bfd 910003fd a90153f3 f9403c00 (f9400014)
> [  110.957428] ---[ end trace 0000000000000000 ]---

Ok, so the driver data is never set and runtime PM is never enabled for
this simple bus device, which uses pm_runtime_force_suspend() for system
sleep.

This used to work as the runtime PM state was left at 'suspended', which
makes pm_runtime_force_suspend() return early, but now we can end up
with a call to the driver runtime PM ops that dereference the NULL
driver data.

Johan

