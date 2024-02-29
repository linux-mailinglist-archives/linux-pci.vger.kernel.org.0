Return-Path: <linux-pci+bounces-4284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813D86D677
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 23:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DBF1C20840
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 22:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0E16D52E;
	Thu, 29 Feb 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6zGX4Fu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F96D527;
	Thu, 29 Feb 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244010; cv=none; b=YamjfDCIGt8GJLoeq8qep2QDmOiIJIeLnT//J93xRx4sOYv3XcjcqodjqIX4wiq0XeEUQMOQrro1BFWiJVGFIm9HuX3TmCUIdyGiI2HeGvV0c2XCPnRZuvVDfRU6tKayMmxE0yfEe7AczHm1msqtK4GCkwKwh069MqrVEzntCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244010; c=relaxed/simple;
	bh=JuLKuv9vi1UpgjQb6iZ/s5tKM7G8kvJpQug1R9JQik4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PTW/IhK24RiFlfn8pwfotQmsc1I2exi0hSlSKM/FiY18DGD1Zl09sWn3hmgRjH+/sKSClBFhjuVHTjWyiJJOzr6bj27aJ2/d9YuHuYSomrK0pDLkGEYxuCjp7bw2rai0GdjZSeU9J9aYsQXGSFnFUdias1dX5aobeUGSC0CNGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6zGX4Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9B5C433C7;
	Thu, 29 Feb 2024 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709244009;
	bh=JuLKuv9vi1UpgjQb6iZ/s5tKM7G8kvJpQug1R9JQik4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F6zGX4Fub1daiAOFxkzZN2JFUabRk6yUdYtB5+B5zBu/nT3JD5Hw3rwjsoaMu+6je
	 ClInbM1yPNjmIK52UWeM401vCcBXqaWjNRah6umLHUC0M29dYJDCM7CBiHGpJIAf+a
	 /CqazZmnPRVpCMWLwaHfqzkgEHdMUOGEsSCFV9QV3Ilivq8fe+epr22ob6GBkPNw05
	 tqN2L4fIr32EJ+Cx9veSeV8TQmtXDJNDzU7ZkvFPR/aKlt0Q6G/I5LiOpYGtpK3z5A
	 EVGk31enEnfhiikeNzk9tof79tL+TqL3ltxbAxS+RLlm51cLqevxeye6uEZ5oqJQNU
	 puZW2DKayaNcw==
Date: Thu, 29 Feb 2024 16:00:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: bhelgaas@google.com, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com, lukas@wunner.de,
	rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: Re: [PATCH v2] PCI / PM: Really allow runtime PM without callback
 functions
Message-ID: <20240229220008.GA364904@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227062648.16579-1-raag.jadav@intel.com>

On Tue, Feb 27, 2024 at 11:56:48AM +0530, Raag Jadav wrote:
> Commit c5eb1190074c ("PCI / PM: Allow runtime PM without callback
> functions") tried to eliminate the need for runtime PM callbacks by
> modifying pci_pm_runtime_suspend() and pci_pm_runtime_resume(), but
> didn't modify pci_pm_runtime_idle() with relevant changes, which still
> returns -ENOSYS if the driver supplies no runtime PM callbacks.
> 
> Modify pci_pm_runtime_idle() such that it allows PCI device power state
> transitions without runtime PM callbacks and complete the original
> intention of commit c5eb1190074c ("PCI / PM: Allow runtime PM without
> callback functions").
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Applied to pci/pm for v6.9, thanks!

I updated the commit log to try to clarify which drivers would be
affected.  Now that I worked through those details, I see that it was
all there from the beginning and it just took a long time to sink into
my head:

    PCI/PM: Allow runtime PM with no PM callbacks at all

    Commit c5eb1190074c ("PCI / PM: Allow runtime PM without callback
    functions") eliminated the need for PM callbacks in
    pci_pm_runtime_suspend() and pci_pm_runtime_resume(), but
    didn't do the same for pci_pm_runtime_idle().

    Therefore, runtime suspend worked as long as the driver implemented at
    least one PM callback.  But if the driver doesn't implement any PM
    callbacks at all (driver->pm is NULL), pci_pm_runtime_idle() returned
    -ENOSYS, which prevented runtime suspend.

    Modify pci_pm_runtime_idle() to allow PCI device power state transitions
    without runtime PM callbacks and complete the original intention of commit
    c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions").

Bjorn

> ---
> 
> This is not marked for linux-stable for the need of extensive testing
> and can be backported after a few releases if no issues are reported.
> 
> Changes since v1:
> - Update commit message and tags
> 
>  drivers/pci/pci-driver.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 51ec9e7e784f..bb7f6775b350 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1382,10 +1382,7 @@ static int pci_pm_runtime_idle(struct device *dev)
>  	if (!pci_dev->driver)
>  		return 0;
>  
> -	if (!pm)
> -		return -ENOSYS;
> -
> -	if (pm->runtime_idle)
> +	if (pm && pm->runtime_idle)
>  		return pm->runtime_idle(dev);
>  
>  	return 0;
> -- 
> 2.35.3
> 

