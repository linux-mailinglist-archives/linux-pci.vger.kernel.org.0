Return-Path: <linux-pci+bounces-20897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D068FA2C41C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05D3188B863
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741181F63F9;
	Fri,  7 Feb 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu8nr7/I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1313BAE4;
	Fri,  7 Feb 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936221; cv=none; b=gaypW9TeRiK6NNfNA7fALKMsn+1lS/M1tlOFnA6Tm557Ec+gHRz+dUOtcJ0K1XwXxCFmn8j7PzkloUMvSogVLgIP5ToClShvxnvnqwGGSZ/EMPNj0xNhG47PJzZEriOCmnNiHoUfw5kX7Xufo/sKztydpzAXdg+0l/oQY6sT5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936221; c=relaxed/simple;
	bh=HdiibnTlxgzZttepD4t7cwMKLWgurPZtGPoNMkNkJvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG3irscNe4fV52ISasKzodVkQ3Cgjbm+V+43b4Jo+dAcTzYlPwmDKKspuyyPUVkmB9wfbxzBjszB7vJ2N2/UkMxTiOKhG9wr3dnQLep7620mns5dHQ7stSO4fhSodjExSJ3bGQve3e+s0rov4xkSUAe4shj3Nx8uH3J0maWpJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu8nr7/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DA0C4CEDF;
	Fri,  7 Feb 2025 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936220;
	bh=HdiibnTlxgzZttepD4t7cwMKLWgurPZtGPoNMkNkJvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tu8nr7/IxuTd2BWH0Dbgn6A+XDj+X7Z8VZ+Aay8gfc5EAKtdu4IuPC5ppicUgfuI2
	 YPSoKaQZAsx/kiHe3iZCICYPa1qpYpXcD13lJWtnpVYPRqIXkP78bU6Xk7yXJLwuMT
	 o+AhUqQWVZgt77ZwqPu0imfZ0lTUUgb+CVNdSH2cvUY5HQGzATQHeGWngL0sqCTl5I
	 Mcgp2xZdsG/hk1UM+P9zEdHJUXszjoIXsD64VBzLKIXcmBRcRunLPJZ15/JVkFpB1s
	 uLq0kTkmN/ffgKcBTw7gUuL2hJa7NZxBUF4VOGoUlcOiTAECkrFS1PCAbko0xHsTRp
	 dCpfZ1c5btsfQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tgOkX-000000000xd-1lBk;
	Fri, 07 Feb 2025 14:50:29 +0100
Date: Fri, 7 Feb 2025 14:50:29 +0100
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
Message-ID: <Z6YPpbRF_U0TxAbf@hovoldconsulting.com>
References: <12619233.O9o76ZdvQC@rjwysocki.net>
 <1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com>

On Fri, Feb 07, 2025 at 01:38:58PM +0000, Jon Hunter wrote:
> On 28/01/2025 19:24, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the
> > resume phase") overlooked the case in which the parent of a device with
> > DPM_FLAG_SMART_SUSPEND set did not use that flag and could be runtime-
> > suspended before a transition into a system-wide sleep state.  In that
> > case, if the child is resumed during the subsequent transition from
> > that state into the working state, its runtime PM status will be set to
> > RPM_ACTIVE, but the runtime PM status of the parent will not be updated
> > accordingly, even though the parent will be resumed too, because of the
> > dev_pm_skip_suspend() check in device_resume_noirq().
> > 
> > Address this problem by tracking the need to set the runtime PM status
> > to RPM_ACTIVE during system-wide resume transitions for devices with
> > DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by them.
> > 
> > Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
> > Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldconsulting.com/
> > Reported-by: Johan Hovold <johan@kernel.org>
> > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> I am seeing the following crash during suspend on a couple of our boards (with mainline/next) and bisect is pointing to this commit ...
> 
> [  216.311009] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000

> [  216.468986] Call trace:
> [  216.471179]  simple_pm_bus_runtime_suspend+0x14/0x48 (P)
> [  216.476775]  pm_generic_runtime_suspend+0x2c/0x44
> [  216.481499]  pm_runtime_force_suspend+0x54/0x14c
> [  216.486049]  device_suspend_noirq+0x6c/0x278
> [  216.490253]  dpm_suspend_noirq+0xc0/0x198
> [  216.494278]  suspend_devices_and_enter+0x210/0x4c0
> [  216.499348]  pm_suspend+0x164/0x1c8
> [  216.503023]  state_store+0x8c/0xfc
> [  216.506260]  kobj_attr_store+0x18/0x2c
> [  216.509940]  sysfs_kf_write+0x44/0x54
> [  216.513699]  kernfs_fop_write_iter+0x118/0x1a8
> [  216.518163]  vfs_write+0x2b0/0x35c
> [  216.521399]  ksys_write+0x68/0xfc
> [  216.524810]  __arm64_sys_write+0x1c/0x28
> [  216.528574]  invoke_syscall+0x48/0x110
> [  216.532253]  el0_svc_common.constprop.0+0x40/0xe8
> [  216.536628]  do_el0_svc+0x20/0x2c
> [  216.540299]  el0_svc+0x30/0xd0
> [  216.543016]  el0t_64_sync_handler+0x144/0x168
> [  216.547736]  el0t_64_sync+0x198/0x19c
> [  216.551327] Code: a9be7bfd 910003fd a90153f3 f9403c00 (f9400014)
> [  216.557197] ---[ end trace 0000000000000000 ]---
> 
> I have not looked any further, but if you have any thoughts, let me know.

Yeah, I hit something like this yesterday as well and did confirm that
reverting this commit makes the problem go away. Haven't had time to dig
much further.

[  110.522368] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  110.531751] Mem abort info:
[  110.534785]   ESR = 0x0000000096000004
[  110.538799]   EC = 0x25: DABT (current EL), IL = 32 bits
[  110.544421]   SET = 0, FnV = 0
[  110.547716]   EA = 0, S1PTW = 0
[  110.551097]   FSC = 0x04: level 0 translation fault
[  110.556274] Data abort info:
[  110.559385]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  110.565188]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  110.570536]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  110.576157] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000892256000
[  110.582946] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  110.590348] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
...
[  110.742358] CPU: 2 UID: 0 PID: 420 Comm: suspend-test.sh Not tainted 6.13.0 #118
[  110.750067] Hardware name: Qualcomm CRD, BIOS 6.0.231221.BOOT.MXF.2.4-00348.1-HAMOA-1 12/21/2023
[  110.759198] pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  110.766462] pc : simple_pm_bus_runtime_suspend+0x14/0x48
[  110.772048] lr : pm_generic_runtime_suspend+0x2c/0x44
[  110.777352] sp : ffff8000839d3a20
[  110.780866] x29: ffff8000839d3a20 x28: ffff0edf80fff810 x27: ffffa2dc2d1f1d30
[  110.788303] x26: ffffa2dc2dd82000 x25: 0000000000000002 x24: ffffa2dc2cc7aca0
[  110.795741] x23: ffffa2dc2dd1e000 x22: 0000000000000000 x21: ffffa2dc2d090e50
[  110.803177] x20: ffffa2dc2c612498 x19: ffff0edf80fff810 x18: 0000000000000030
[  110.810615] x17: 0005002c00000000 x16: ffffa2dc2c614ce4 x15: ffffffffffffffff
[  110.818052] x14: 0000000000000000 x13: ffff0edf80fff980 x12: 705f64706e65675f
[  110.825490] x11: ffffa2dc2d9c5890 x10: 0000000000000000 x9 : 0000000000000000
[  110.832927] x8 : ffffa2dc2d2af000 x7 : ffff8000839d3a10 x6 : ffff8000839d39b0
[  110.840364] x5 : ffff8000839d4000 x4 : 0000000000000004 x3 : ffff0edf953e0000
[  110.847801] x2 : ffffa2dc2c4e5784 x1 : 0000000000000000 x0 : 0000000000000000
[  110.855238] Call trace:
[  110.857861]  simple_pm_bus_runtime_suspend+0x14/0x48 (P)
[  110.863425]  pm_generic_runtime_suspend+0x2c/0x44
[  110.868362]  pm_runtime_force_suspend+0x54/0x100
[  110.873217]  dpm_run_callback+0xb4/0x228
[  110.877347]  device_suspend_noirq+0x70/0x2a8
[  110.881844]  dpm_noirq_suspend_devices+0xe0/0x230
[  110.886778]  dpm_suspend_noirq+0x24/0x98
[  110.890904]  suspend_devices_and_enter+0x368/0x678
[  110.895941]  pm_suspend+0x1b4/0x348
[  110.899627]  state_store+0x8c/0xfc
[  110.903228]  kobj_attr_store+0x18/0x2c
[  110.907195]  sysfs_kf_write+0x4c/0x78
[  110.911074]  kernfs_fop_write_iter+0x120/0x1b4
[  110.915735]  vfs_write+0x2ac/0x358
[  110.919352]  ksys_write+0x68/0xfc
[  110.922873]  __arm64_sys_write+0x1c/0x28
[  110.927002]  invoke_syscall+0x48/0x110
[  110.930969]  el0_svc_common.constprop.0+0x40/0xe0
[  110.935907]  do_el0_svc+0x1c/0x28
[  110.939427]  el0_svc+0x48/0x114
[  110.942769]  el0t_64_sync_handler+0xc8/0xcc
[  110.947180]  el0t_64_sync+0x198/0x19c
[  110.951059] Code: a9be7bfd 910003fd a90153f3 f9403c00 (f9400014)
[  110.957428] ---[ end trace 0000000000000000 ]---

Johan

