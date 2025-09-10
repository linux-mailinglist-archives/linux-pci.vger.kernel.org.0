Return-Path: <linux-pci+bounces-35818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E79CB51B60
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A8416E251
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256A6255F53;
	Wed, 10 Sep 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahGOrzwu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435118871F;
	Wed, 10 Sep 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517518; cv=none; b=WAmvipqVgh+CTh9yXzRjUACVl9swHBYLRB1koNdsNnwyLU7NC7qBSrNp9iuCpkX0HQD9hrZKb3ZE13UszFQQto+W62ftD59HXGqu1MoW19bDDArDmrrhL7/b8cnxUZf+ZSpJm0kZwIkurBO5FtQNRT3twE4IaknZSnMnFji8+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517518; c=relaxed/simple;
	bh=0uSCp23NvXz2hqHp/yS8FBYbn/cdIneP8YL/ZnCmcUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DIUGfnfWmOYHo4i9hRiZ27b6UFBjf1AlLRB9tQHTG7YJjR5+EoK2pPk2gZtQn8CKJsOBVnnbxXgJFC6CEv48zYzp7J2wwSQZkzETbdH36cPKeMA/+mVU/IJS2eull/6gqC9jyNcKZUE1nkzf1jlyLPcQpXAT1VR/er9wKlrIpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahGOrzwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBF3C4CEEB;
	Wed, 10 Sep 2025 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757517517;
	bh=0uSCp23NvXz2hqHp/yS8FBYbn/cdIneP8YL/ZnCmcUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ahGOrzwuhX9CBWzkao0VsZrDeUgXAGaATsukNto6O3QzeHDmkfiuxJvh+6DPAin2B
	 1HC5a3v3pW1bS8mc4JaKFZVhsOxsb74sDYfEfwV+Uh3DY36qvJmMA6Rz0nxAz2aoUw
	 5hoVr0rgmmHjir7QvWrodXujPsN70tleBK9gUAodzR7anFALHxkjrDKOQEirFI7/m/
	 qp2zMCcToTXnu/HDkCBizXniqC7ZCnNFGt1AMGAUr1t2GOov9qIdDorDNFTouT2V6Q
	 pLXvsFeyOkxuP20BDSIFiADuqwuH6TyxaEGEOx9Fp+3v/0RjSBUCN0M74v0gA5TfTs
	 CkUfNTyNFNkWA==
Date: Wed, 10 Sep 2025 10:18:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH v7 11/12] PM: Use hibernate flows for system power off
Message-ID: <20250910151836.GA1536103@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250909191619.2580169-12-superm1@kernel.org>

On Tue, Sep 09, 2025 at 02:16:18PM -0500, Mario Limonciello (AMD) wrote:
> When the system is powered off the kernel will call device_shutdown()
> which will issue callbacks into PCI core to wake up a device and call
> it's shutdown() callback.  This will leave devices in ACPI D0 which can
> cause some devices to misbehave with spurious wakeups and also leave some
> devices on which will consume power needlessly.

The connection between this change and spurious wakeups seems pretty
tenuous.  If we don't want wakeups, powering off the device seems like
a sledgehammer approach.

s/it's/its/

> The issue won't happen if the device is in D3 before system shutdown, so
> putting device to low power state before shutdown solves the issue.
> 
> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
> compatible with the current Power Resource states. In other words, all
> devices are in the D3 state when the system state is S4."

Re patch 05/12, also interesting that this section mentions "devices
that are enabled to wake the system and that can do so from their
device state in S4 can initiate a hardware event that transitions the
system state to S0."

So it looks like wakeup from S4 should work in at least some cases.

> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
> state is similar to the S4 state except that OSPM does not save any
> context." so it's safe to assume devices should be at D3 for S5.
> 
> To accomplish this, use the PMSG_POWEROFF event to call all the device
> hibernate callbacks when the kernel is compiled with hibernate support.
> If compiled without hibernate support or hibernate fails fall back into
> the previous shutdown flow.
> 
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Merthan Karakaş <m3rthn.k@gmail.com>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Tested-by: Denis Benato <benato.denis96@gmail.com>
> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/
> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v5:
>  * split to multiple commits, re-order
> v4:
>  * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
> v3:
>  * Add new PMSG_POWEROFF and PM_EVENT_POWEROFF which alias to poweroff
>    callbacks
>  * Don't try to cleanup on dpm_suspend_start() or dpm_suspend_end() failures
>    Jump right into normal shutdown flow instead.
>  * https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kernel.org/T/#me6db0fb946e3d604a8f3d455128844ed802c82bb
> ---
>  kernel/reboot.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index ec087827c85cd..c8835f8e5f271 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -13,6 +13,7 @@
>  #include <linux/kexec.h>
>  #include <linux/kmod.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/pm.h>
>  #include <linux/reboot.h>
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
> @@ -305,6 +306,11 @@ static void kernel_shutdown_prepare(enum system_states state)
>  		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
>  	system_state = state;
>  	usermodehelper_disable();
> +#ifdef CONFIG_HIBERNATE_CALLBACKS
> +	if (!dpm_suspend_start(PMSG_POWEROFF) && !dpm_suspend_end(PMSG_POWEROFF))
> +		return;
> +	pr_emerg("Failed to power off devices, using shutdown instead.\n");
> +#endif
>  	device_shutdown();
>  }
>  /**
> -- 
> 2.43.0
> 

