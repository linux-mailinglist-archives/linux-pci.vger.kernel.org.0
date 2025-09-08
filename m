Return-Path: <linux-pci+bounces-35694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33E3B49C45
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AD43B50E7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEB62E03F1;
	Mon,  8 Sep 2025 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG0xsGVK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378BB2DFA38;
	Mon,  8 Sep 2025 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367278; cv=none; b=nVNfJWvnHOzYXVDxEBjYU/Rkj8MVXMYhWROCovjGIWzh5eqtMpfOueGR4LMu9Q1fP8ig/skHcszk8xV9uIxuFeWIPJT89IVPXqyMfB1WvDT7c/M/ffUYBtE9kc1uqEttz0hJQ6S4AQq4YbJgxJPzNnJ65r+g4BFFe2Vk0C2shxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367278; c=relaxed/simple;
	bh=NzbMSMpQ4f3Do6KUVa9pmwGpe4Sd68+LnHSAddc02hc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B1s4PIkGbgBYJr+ScN37qa1B35KItZg55lRHCDkHlxlCSOPAJAKuhnJ+CCHoCxip6HB5Gysg0vTmwvsRiWoRQfsbUGxntRcqh8nXPnAvHPsWxIvYnXjq1Bva68l59KnV3oBwipvkfY3bOCKoq0nOLmIUNJ+w7vESvmYadOtLQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG0xsGVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95884C4CEF1;
	Mon,  8 Sep 2025 21:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757367277;
	bh=NzbMSMpQ4f3Do6KUVa9pmwGpe4Sd68+LnHSAddc02hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KG0xsGVKP50g/2MEAKc7sN+1zhMxdzclu/RHx9bMUgGoudP8nnKRnjTGCvWakiHcD
	 7BhxiVTC6Xp/z989LDquWV9Mqeppxh8onBPSxzNPfFi29SBSOmyvb17FABTwAshXqa
	 pfRK2KiQ1GzMrYFZLhZFEcd+vQ5OQx1EOaHKahYYZWahdltSQDUS70YkkRyA5uqDhg
	 NQ+tiTpyReOIBucvYBR86yByR8r2tWIzuHishUj92EgsVC8pcxC53NrnFtSOLaViZo
	 9s7opjqTUVpPIxAgNzXNUP6kVgIcE2AQGGdPA8X9cgOLETH5L5lx6WVFIEHiioBIzq
	 ZEYlJbuyV5RfA==
Date: Mon, 8 Sep 2025 16:34:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
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
	Eric Naim <dnaim@cachyos.org>
Subject: Re: [PATCH v6 05/11] PCI: PM: Disable device wakeups when halting
 system through S4 flow
Message-ID: <20250908213436.GA1465429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818020101.3619237-6-superm1@kernel.org>

In subject, s|PCI: PM:|PCI/PM:| to follow previous practice.

On Sun, Aug 17, 2025 at 09:00:55PM -0500, Mario Limonciello (AMD) wrote:
> PCI devices can be programmed as a wakeup source from low power states
> by sysfs.  However when using the S4 flow to go into S5 these wakeup
> sources should be disabled to avoid what users would perceive as
> spurious wakeup events.

Is the "can be programmed vis sysfs" part relevant here?

I think S4 and S5 are ACPI sleep states not applicable to all
platforms.  Is it relevant that we got here via ACPI?

I assume non-ACPI systems can also exercise this path.  Is there a way
to describe this scenario in a way that would apply to all systems?

I'm not sure what "using the S4 flow to go in to S5" means.

It would be nice to have a spec reference or some sort of rationale
for the requirement to disable all wakeup sources in SYSTEM_HALT and
SYSTEM_POWER_OFF.

> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
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

I guess the suggestion is that we can't wake up at all from
SYSTEM_HALT or SYSTEM_POWER_OFF?  Would both be considered S5?

Does this mean we need a physical power button push to start up again?
I guess ACPI r6.5, sec 16.1.5 kind of suggests that: "hardware does
allow a transition to S0 due to power button press or a Remote Start."

>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
>  
> -- 
> 2.43.0
> 

