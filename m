Return-Path: <linux-pci+bounces-4631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009AF875B5C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 01:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B381F228B8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 00:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8316E4C65;
	Fri,  8 Mar 2024 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u76TEF7q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59838A2A;
	Fri,  8 Mar 2024 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856047; cv=none; b=nEfK0rE1TSX53eG7c8ImmdtAcd917+U+/yOuL2y/uCoWrAJGrelMQSofYxzg+NOmVju37nlXneowCQ3TNl2sEr5NDLOmukUYlkVBglAf00EBoT8KoXFSWtF8EeH/kLaVdXznxFSSDOEiKVNdQU7frTC5mypTL0AMwxj8/nQ7+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856047; c=relaxed/simple;
	bh=yR/e48Pc+suYhx1b+nutwrcjLsHghjjeWmizES3kOJc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lUwXN4+xip6yH4Vg7VRP6u12rd+B8lRZE8aFwj0pBF/G7aLcaL2kIL4w42WPXCbrLgcERrcaoY8SlWdNZ/mW62t8XVFnr5czMCIthMh6BXj0qScEtyuba0P7wkZQH8eYVQFe+Run228mYQOdIse5wfWycyv97Uxb6fwo9N+aXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u76TEF7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACFBC433F1;
	Fri,  8 Mar 2024 00:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709856045;
	bh=yR/e48Pc+suYhx1b+nutwrcjLsHghjjeWmizES3kOJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u76TEF7qloryJyegAGaXSgrQVz+arxecm/2CuYk8k/pu9oBl6Ww7oEbRGsD/dZdVN
	 rMM0hZrmruNRR6zdCLQvqRcNRTPFBAPoNyChysNPTb2PF+VeqVHx2Bqa2bJPPAX5EZ
	 zjU6+au2xC2AC2sRo9vNgViMzOpgciH1XujysJ4BBC5VeMr7w2N51CJs4KrTF/8Dx5
	 RtU9RHwC59JpTHB5t+9vis5yt1IP0nTXy3hx6dhYS5H98Tohgx9s2L6JlKXh0XmdRj
	 aJ5U+EX0PO7LP3Tunk5tEP4HQuKGyjNwxN3IQ7XdM8irNLDloSRaRGykpj11I9Ojxm
	 Cqh6SHocXEbrg==
Date: Thu, 7 Mar 2024 18:00:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v3] PCI/AER: Block runtime suspend when handling errors
Message-ID: <20240308000043.GA662251@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212120135.146068-1-stanislaw.gruszka@linux.intel.com>

On Mon, Feb 12, 2024 at 01:01:35PM +0100, Stanislaw Gruszka wrote:
> PM runtime can be done simultaneously with AER error handling.
> Avoid that by using pm_runtime_get_sync() before and pm_runtime_put()
> after reset in pcie_do_recovery() for all recovering devices.
> 
> pm_runtime_get_sync() will increase dev->power.usage_count counter
> to prevent any possible future request to runtime suspend a device.
> It will also resume a device, if it was previously in D3hot state.
> 
> I tested with igc device by doing simultaneous aer_inject and
> rpm suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control
> and can reproduce:
> 
> igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
> pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
> pcieport 0000:00:1c.2: AER: subordinate device reset failed
> pcieport 0000:00:1c.2: AER: device recovery failed
> igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> 
> The problem disappears when applied this patch.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Applied to pci/aer for v6.9, thanks!

> ---
>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> RFC -> v1:
>  add runtime callbacks to pcie_do_recovery(), this covers DPC case
>  as well as case of recovering multiple devices under same port.
> 
> v1 -> v2:
>  - add R-b, A-b, cc-stable tags
>  - tweak commit message
> 
> v2 -> v3:
>  - fix mangled commit message
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 59c90d04a609..705893b5f7b0 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -13,6 +13,7 @@
>  #define dev_fmt(fmt) "AER: " fmt
>  
>  #include <linux/pci.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> @@ -85,6 +86,18 @@ static int report_error_detected(struct pci_dev *dev,
>  	return 0;
>  }
>  
> +static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
> +{
> +	pm_runtime_get_sync(&pdev->dev);
> +	return 0;
> +}
> +
> +static int pci_pm_runtime_put(struct pci_dev *pdev, void *data)
> +{
> +	pm_runtime_put(&pdev->dev);
> +	return 0;
> +}
> +
>  static int report_frozen_detected(struct pci_dev *dev, void *data)
>  {
>  	return report_error_detected(dev, pci_channel_io_frozen, data);
> @@ -207,6 +220,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	else
>  		bridge = pci_upstream_bridge(dev);
>  
> +	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
> +
>  	pci_dbg(bridge, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bridge(bridge, report_frozen_detected, &status);
> @@ -251,10 +266,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pcie_clear_device_status(dev);
>  		pci_aer_clear_nonfatal_status(dev);
>  	}
> +
> +	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> +
>  	pci_info(bridge, "device recovery successful\n");
>  	return status;
>  
>  failed:
> +	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> +
>  	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
>  
>  	/* TODO: Should kernel panic here? */
> -- 
> 2.34.1
> 

