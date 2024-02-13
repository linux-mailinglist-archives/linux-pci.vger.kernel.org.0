Return-Path: <linux-pci+bounces-3411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7042E853BE4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 21:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD5128278C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CD66089E;
	Tue, 13 Feb 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzOuvNFC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8C60B80;
	Tue, 13 Feb 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854810; cv=none; b=G1BAwd+jAsqhjQWJ4CD6wZS9r4bhjvmEeJCO4DXOEbMcM1WLVZp1yJFvoRg/b+4WZorzhhdg7QEMP7v5yr+ljrSTKUEsaHYsstbCwmhEVnfRfhzxyNo0zppdpmKJGrS2L9tcfpqrdLOdQ7YXlkIik9rNVVvy6IQUeJZzorisqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854810; c=relaxed/simple;
	bh=RzFf6vbxBZCp7I/zmIIZfylRvNPWVW5m73wNUuf/KTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d3KMCNvwsSE0MxQFvdXPjdX8nnsUzGDIA40ztjCz+03ZuE8YKSXy8mAV91tS/nv0hoQI1ASAl46loo4A7l8qMvMfxtQKr7VRGpYg6Il74qYhYEILQVgMyxhDGANYjJEd78Gj43WyhWzBEBOp9HGC+cIxAexOuE/D38KnXqAfZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzOuvNFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A698DC433F1;
	Tue, 13 Feb 2024 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707854810;
	bh=RzFf6vbxBZCp7I/zmIIZfylRvNPWVW5m73wNUuf/KTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YzOuvNFCgNTVxBos7zSGMPQvUzsw6Yv3J3Sg9RgEpq6nzmFjdZXt41tSNXKofGJJP
	 l51fvJDjrLZmRveZZi53xDZ360E9ZPL5+kcrXOT0g7ca5VMrbqN2uRQ9zYN/fdypsh
	 ApM62ix+PjJHq29YU0P15tzNLa4doqXtZxnILUuO7qAmIlnm2YpkAC6lOzcT3hDgcv
	 psDsTv6zjf6Y4E1x3njmPo3t2D5WAN4/5XUM+jgQkLGqA28RlcJw8vWa1wHvudnvik
	 w1st1rjo2oyZihNQ7g4ggUPY43U8ZU+gPwQlULn8qXTCSlXJjB7+p1PJ0FXJzR8QXH
	 XiQ0Z6H8NRArA==
Date: Tue, 13 Feb 2024 14:06:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: bhelgaas@google.com, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com, lukas@wunner.de,
	rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback
 functions
Message-ID: <20240213200648.GA1219964@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212063233.5599-1-raag.jadav@intel.com>

On Mon, Feb 12, 2024 at 12:02:33PM +0530, Raag Jadav wrote:
> Commit c5eb1190074c ("PCI / PM: Allow runtime PM without callback
> functions") tried to eliminate the need for runtime PM callbacks
> by modifying pci_pm_runtime_suspend() and pci_pm_runtime_resume(),
> but didn't modify pci_pm_runtime_idle() with relevant changes, which
> still returns -ENOSYS if the driver supplies no runtime PM callbacks.
> 
> Fix this by modifying pci_pm_runtime_idle() such that it allows PCI
> device power state transitions without runtime PM callbacks.
> 
>  0)               |  pm_runtime_work() {
>  0)               |    rpm_idle() {
>  0)               |      rpm_check_suspend_allowed() {
>  0)   1.500 us    |        __dev_pm_qos_resume_latency(); /* = 0x7fffffff */
>  0)   4.840 us    |      } /* rpm_check_suspend_allowed = 0x0 */
>  0)   1.550 us    |      __rpm_get_callback(); /* = 0xffffffffb4bc84f0 */
>  0)   1.800 us    |      pci_pm_runtime_idle(); /* = -38 */
>  0) + 17.070 us   |    } /* rpm_idle = -38 */
>  0) + 22.450 us   |  } /* pm_runtime_work = -38 */

What is this timing information telling me?

> Debugged-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Sounds like this resolves a problem report?  Is there a URL we can
cite?  If not, at least a mention of what the user-visible problem is?

From the c5eb1190074c commit log, it sounds like maybe this allows
devices to be autosuspended when they previously could not be?

Possibly this should have "Fixes: c5eb1190074c ("PCI / PM: Allow
runtime PM without callback functions")" since it sounds like it goes
with it?

> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
> 
> This is not marked for linux-stable for the need of extensive testing
> and can be backported after a few releases if no issues are reported.

If you think this should not get backported to stable, you'll have to
watch the backports to prevent it.  Lots of stuff gets auto-backported
even though not explicitly marked for stable.  This comment won't
prevent it (and won't even appear in the commit log).

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

