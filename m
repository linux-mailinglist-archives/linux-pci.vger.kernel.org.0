Return-Path: <linux-pci+bounces-35816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5023BB51B00
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049AE1887AC1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32120257431;
	Wed, 10 Sep 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlGc5tv/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01322472B0;
	Wed, 10 Sep 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516766; cv=none; b=hPyMdjDsgNPQAZinQmFQF4L0iVBeBPiFn1k0gljgo3QSTHQ/artLBRv5HaAXdhVE5tu3cuXgbt5SbqZtEPswHkA8O1dwcyb+Fr6Q2neVztY/uB9uDt15nOyZYrXY+awkk2dBCv/Ge1mmV0ZLdTbxlUj84Bz3ABYtKVTVdcf/Faw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516766; c=relaxed/simple;
	bh=grcDgo8FHqiTZj6gtZseY6Kax3Rrmd5r+p0clx0FBJU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JPmlfV6nLZLUSfp2mwRtHFtA5tX9k81sCT3hr3tEK2O6QDBVjPw4sdJa6vs6Dm3AZfxKKXPWKxDlPMMYcsajIh93EnEZv5j175t4EXTpGqqeJfjS8l73PdzkOLDyA2evCvPBS4g5Jmick9Sm0iR0bXh70RcaBiKCrae1+NpFiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlGc5tv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A42C4CEEB;
	Wed, 10 Sep 2025 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757516765;
	bh=grcDgo8FHqiTZj6gtZseY6Kax3Rrmd5r+p0clx0FBJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hlGc5tv/yqwHJgEvl3Nk8mNZ7sMqfEKlQ4QzvWZ5M0hFFGIugy8uutDHXNaT633tj
	 NnAO6Ul9rJpH/3xWrs1CpI+ta5bFIylpGPF9f4CP9FM87aZsUZF8XNOXZnisutZMCK
	 XEc/+PyXuU3HVDk6JGozImWkkREphrkUy1wIPt7gYqeS6HuHN/eS35Lvgk6pJ25PGg
	 MkiIqp2LhUkymkJBdHcbJ7PnTKYhlqxe85GYTRYWg58cfLppDjpGmyYIZ73jpzgjI0
	 qAUWrqltmsTL+mAGoN/13SS26mZxImd+wwBLnOhGRkZxsZE0s03y16Y5m5R9sRPKOV
	 JZA4xFpggGWMw==
Date: Wed, 10 Sep 2025 10:06:03 -0500
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
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v7 05/12] PCI/PM: Disable device wakeups when halting or
 powering off system
Message-ID: <20250910150603.GA1535543@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909191619.2580169-6-superm1@kernel.org>

On Tue, Sep 09, 2025 at 02:16:12PM -0500, Mario Limonciello (AMD) wrote:
> PCI devices can be configured as wakeup sources from low power states.
> However, when the system is halting or powering off such wakeups are
> not expected and may lead to spurious behavior.

I'm a little unclear on the nomenclature for these low power states,
so I think it would be helpful to connect to the user action, e.g.,
suspend/hibernate/etc, and the ACPI state, e.g.,

  ... when the system is hibernating (e.g., transitioning to ACPI S4
  and halting) or powering off (e.g., transitioning to ACPI S5 soft
  off), such wakeups are not expected ...

When I suspend or power off my laptop from the GUI user interface, I
want to know if keyboard or mouse activity will resume or if I need to
press the power button.

> ACPI r6.5, section 16.1.5 notes:
> 
>     "Hardware does allow a transition to S0 due to power button press
>      or a Remote Start."

Important to note here that sec 16.1.5 is specifically for "S5 Soft
Off State".

S4 is a sleeping state and presumably sec 16.1.6 ("Transitioning from
the Working to the Sleeping State") applies.  That section mentions
wakeup devices, so it's not obvious to me that PCI device wakeup
should be disabled for S4.

> This implies that wakeups from PCI devices should not be relied upon
> in these states. To align with this expectation and avoid unintended
> wakeups, disable device wakeup capability during these transitions.
> 
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v7:
>  * Reword title
>  * Reword commit
> v5:
>  * Re-order
>  * Add tags
> v4:
>  * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
> ---
>  drivers/pci/pci-driver.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 63665240ae87f..f201d298d7173 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1139,6 +1139,10 @@ static int pci_pm_poweroff(struct device *dev)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> +	if (device_may_wakeup(dev) &&
> +	    (system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF))
> +		device_set_wakeup_enable(dev, false);
> +
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
>  
> -- 
> 2.43.0
> 

