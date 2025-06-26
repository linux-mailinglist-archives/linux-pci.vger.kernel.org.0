Return-Path: <linux-pci+bounces-30837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5537AEA888
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AB31752B7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012E25D1F1;
	Thu, 26 Jun 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjPX1Qxx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF762586DA;
	Thu, 26 Jun 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750971565; cv=none; b=JD5gT5r285xq2V3wpPt3OaWSLnWmt8R8NY2/tG1SRyYa4qdtRV7It0m+NFPsgWiLCn+haj1hU0nQXf3lU5py8Ox+J/L6ylqoUS0spiDA7NuCBVrkZ5CccD7bvlCrO6ss6ouZWp34HBho5Tx9MR84NbOAtHbUsL4VNgLoLCHEfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750971565; c=relaxed/simple;
	bh=+fhwZx4Tl0v+9+QtFE1+0FAdLLXXVavCkvZMXIFh6xc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dug73MAJF30JIYj+NZcjUkk0rr1O0sQwiVISGXX1wRLbH8fbxQUDXIpbgubo6tSzFt8YnJmnVfgf5PhI3nKtDwSaKMEcuqw8EkPL2NSpqYGgBtKh8KgTPnXSsxlWVkfdxR7GbPiy5qCLVa7r4vpfT3mzSHfziWUK2U4jQS4NDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjPX1Qxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05925C4CEEB;
	Thu, 26 Jun 2025 20:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750971565;
	bh=+fhwZx4Tl0v+9+QtFE1+0FAdLLXXVavCkvZMXIFh6xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GjPX1Qxxe9/hzEwK1CQ/VICiboIg1WQvkueWoTz2a7wMbJpN12KB2vhY2zFy+0sPI
	 5VTsEfR31ymBZaIF8BzA6pbsEEDDOLacMdnAcQzB9HMuw68pkFShVoAZg0XAn3HYup
	 23+Qn1bC38EK83cUKmvvS74W65K7P6knlmS8MqY4rFgnIZyywyQS0cDn1sN/cD5UeQ
	 vHbcRtcwXgCgi6WxSYq3IhMJDZcUGPjlYWpIxkl3Dycx6uFbNbfqGLIgYcT669MnZk
	 YZkAgI/JeCTcbjHCoeumjjALXEdZgzWLDuo1VWl7QioUV1r9WkcMiwQFKYjqhlkNhR
	 913TCbfWgL5QA==
Date: Thu, 26 Jun 2025 15:59:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 9/9] PCI: PM: Set power.strict_midlayer in
 pci_pm_init()
Message-ID: <20250626205923.GA1639790@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1952931.CQOukoFCf9@rjwysocki.net>

On Thu, Jun 26, 2025 at 08:15:05PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The PCI bus type does not expect its runtime PM callbacks,
> pci_pm_runtime_suspend() and pci_pm_runtime_resume(), to be invoked at
> any point during system-wide suspend and resume, so make it express
> that expectation by setting power.strict_midlayer for all PCI devices
> in pci_pm_prepare() and clear it in pci_pm_complete().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Previous PM-related patches in drivers/pci/ use a subject line like:

  PCI/PM: ...

Would be cool if there were hints about what
dev_pm_set_strict_midlayer() means.  Maybe the comment in
get_callback() is enough, but it takes a little work to find it.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> v1 -> v2:
>    * Set and clear the new flag in "prepare" and "complete" to allow
>      pm_runtime_force_suspend() invoked from driver remove callbacks to
>      work.
>    * Update subject and changelog.
> 
> ---
>  drivers/pci/pci-driver.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -708,6 +708,8 @@
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> +	dev_pm_set_strict_midlayer(dev, true);
> +
>  	if (pm && pm->prepare) {
>  		int error = pm->prepare(dev);
>  		if (error < 0)
> @@ -749,6 +751,8 @@
>  		if (pci_dev->current_state < pre_sleep_state)
>  			pm_request_resume(dev);
>  	}
> +
> +	dev_pm_set_strict_midlayer(dev, false);
>  }
>  
>  #else /* !CONFIG_PM_SLEEP */
> 
> 
> 

