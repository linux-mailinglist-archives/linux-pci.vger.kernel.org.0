Return-Path: <linux-pci+bounces-13058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4493E975AA9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 21:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7757A1C23177
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE5E1B3B08;
	Wed, 11 Sep 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9lDfpTn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4BA762EB;
	Wed, 11 Sep 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081519; cv=none; b=RQ0T98d7B62qt21IQSS4bK4gBevgKhwFBAfppVWS8mn5EHIZ6iglVyzRFU3/klqfcmc14XcEPY7Y1OQS4EHoc0Ju7UKyTOTsQcI1VfkC6iwtUwqsQPzo3J1XV0ay/5wS/dBlJdJlomx9X/x0/aHPLNMSJUJqNnSxAoDNCobl3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081519; c=relaxed/simple;
	bh=0D6HKZtwwVTLn2g82F7IMTiNI9WZKYvVIf++vYQyoVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rfdU7ascJc3c3qeR3aBm/a3ebKBKy4CnMqx5i91CAvP9LniY0SFJjegDwj50C2aTT6L3JCOFuhT1A/v+vPh2ENCRZDxDTqGIYVSHMVSZcItWpvRLRMW0UplrgG8zCjiGT/R1oKTnihpJuAdes/5oRi6WyC3ey06Wim3fhOCE0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9lDfpTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE11CC4CEC0;
	Wed, 11 Sep 2024 19:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726081519;
	bh=0D6HKZtwwVTLn2g82F7IMTiNI9WZKYvVIf++vYQyoVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C9lDfpTn6FaD8EY3GnDtWdqF8qz5r5Y0ZkLfeM3C+5v1qNaMiVekK+llbVTW5pXQH
	 NCqI5NOK6WpXnXyfyznbsIZ2bHxvpznh8mc2wGd0mMNHhAISGzPDJQB4wMbm9F1zJZ
	 ORIC2zgNocbXuz0Dy3P0vzcUL+DuXvrAkrS7cMv6i7M6cly6rKoDiwOfJAOxNmPGQl
	 PuGlR4lEhaqiymPFhpm8VYlxjNBstWt3npxeShaf/32cxUafNE3Xxk0cEUuE7eRvn9
	 LIeUNGjtVaIZ1kzyhb8K0EylMHlDgZ9Ii8RiBf87+1yxCSa/kTz+Iozc2NIsUvit0/
	 /c0V2Twcm/veA==
Date: Wed, 11 Sep 2024 14:05:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, mario.limonciello@amd.com,
	mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
Message-ID: <20240911190516.GA644336@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712062411.35732-1-kai.heng.feng@canonical.com>

On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> connected.
> 
> The following error message can be found during shutdown:
> pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> pcieport 0000:09:04.0:    [ 7] BadDLLP
> 
> Calling aer_remove() during shutdown can quiesce the error message,
> however the spurious wakeup still happens.
> 
> The issue won't happen if the device is in D3 before system shutdown, so
> putting device to low power state before shutdown to solve the issue.
> 
> I don't have a sniffer so this is purely guesswork, however I believe
> putting device to low power state it's the right thing to do.

My objection here is that we don't have an explanation of why this
should matter or a pointer to any spec language about this situation,
so it feels a little bit random.

I suppose the problem wouldn't happen if AER interrupts were disabled?
We already do disable them in aer_suspend(), but maybe that's not used
in the shutdown path?

My understanding is that .shutdown() should turn off device interrupts
and stop DMA.  So maybe we need an aer_shutdown() that disables
interrupts?

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pci-driver.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index af2996d0d17f..4c6f66f3eb54 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>  	if (drv && drv->shutdown)
>  		drv->shutdown(pci_dev);
>  
> +	/*
> +	 * If driver already changed device's power state, it can mean the
> +	 * wakeup setting is in place, or a workaround is used. Hence keep it
> +	 * as is.
> +	 */
> +	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
> +		pci_prepare_to_sleep(pci_dev);
> +
>  	/*
>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>  	 * device to tell it to not continue to do DMA. Don't touch
> -- 
> 2.43.0
> 

