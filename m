Return-Path: <linux-pci+bounces-41135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8DBC58FC4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913113ABF5C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7F3364E81;
	Thu, 13 Nov 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooEGjnbM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5F363C6F;
	Thu, 13 Nov 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052015; cv=none; b=rL3xG5vlJmccB/RyYgsuZphh9RIt6LvxOyqNbG5AxdffkHdfEIVxyFqCp/r+lamms4QVufktGIGNBLQfZca02llIFHBEcrgl937eowUWW7FxY22owlvn6dMzIkkkpnEp20IV5Wyuxm8sG9kHpsvtGzu9lOjdmT3hr4Jsm3nk3x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052015; c=relaxed/simple;
	bh=ee+JYwZFiWl4rPvu1lWFozwqOKR006mY1ONvIK0qE1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LU82DUhl+3hfHbW3bUrClIzPIxq8VICk6k6o6Qh4a10l9fKA9XreWFh/EfdFnuHoQshO5yPOY0/17jJJmn+/BYweQ8MeCU09IY7vxoRPbS5ekN0bfkXQNt/27xyXm04WQJMV2XGMTTXN/6OnSR9pC1TF1BUWXpqdLJIwqKshh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooEGjnbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41ACC4CEF7;
	Thu, 13 Nov 2025 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763052014;
	bh=ee+JYwZFiWl4rPvu1lWFozwqOKR006mY1ONvIK0qE1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ooEGjnbMmSQrPkE0Ps+Q3yUSrS4YUF35htEs4f2SE24S1Uwf2aYYdJrKk5xTyAMls
	 uiLlwGyNsKBsO2swIX+g8h8SF8XbuMxw/Dul4Qiu+zHrB/C9lKYR3v2/e/yCysRGg1
	 T7n9h06pB8tY5zb+0ochXdGNCcEOdcjbC+23e1bj6bYQNrSddeZBnqyrDLtyJJDleT
	 zzZyajAp7cCIRE1nKMLfxfKgNJy7YlWdBsYAujGho1cGZ9GORYmgKBQ0zy7AkK4B/l
	 wxGABXJLJjrUQSD6S1B859/ZuyPp0NlErIwcxSnsTUViuKndFC5r0ZTk1m+AFfIpVl
	 fNBYJ0k+MYFeA==
Date: Thu, 13 Nov 2025 10:40:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, will@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com,
	vincent.guittot@linaro.org, Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v2 3/3] PCI: dwc: Check for the device presence during
 suspend and resume
Message-ID: <20251113164013.GA2285612@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107044319.8356-4-manivannan.sadhasivam@oss.qualcomm.com>

[+cc Frank]

On Fri, Nov 07, 2025 at 10:13:19AM +0530, Manivannan Sadhasivam wrote:
> If there is no device available under the Root Ports, there is no point in
> sending PME_Turn_Off and waiting for L2/L3 transition during suspend, it
> will result in a timeout. Hence, skip those steps if no device is available
> during suspend.
> 
> During resume, do not wait for the link up if there was no device connected
> before suspend. It is very unlikely that a device will get connected while
> the host system was suspended.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..5a39e7139ec9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  
>  #include "../../pci.h"
> +#include "../pci-host-common.h"
>  #include "pcie-designware.h"
>  
>  static struct pci_ops dw_pcie_ops;
> @@ -1129,6 +1130,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	u32 val;
>  	int ret;
>  
> +	if (!pci_root_ports_have_device(pci->pp.bridge->bus))
> +		goto stop_link;

This looks racy.  Maybe it's still OK, but I think it would be good to
include a comment to acknowledge that and explain why either outcome
is acceptable, e.g., if a user removes a device during suspend, it
results in a timeout but nothing more terrible.

>  	/*
>  	 * If L1SS is supported, then do not put the link into L2 as some
>  	 * devices such as NVMe expect low resume latency.
> @@ -1162,6 +1166,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	 */
>  	udelay(1);
>  
> +stop_link:
>  	dw_pcie_stop_link(pci);
>  	if (pci->pp.ops->deinit)
>  		pci->pp.ops->deinit(&pci->pp);
> @@ -1195,6 +1200,14 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * If there was no device before suspend, skip waiting for link up as
> +	 * it is bound to fail. It is very unlikely that a device will get
> +	 * connected *during* suspend.

I'm not convinced.  Unlike the suspend side, where the race window is
tiny, here the window is the entire time the system is suspended, and
at least in laptop usage, there's no reason I would hesitate to plug
something in while suspended.

Regardless, the overall behavior needs to be acceptable whether or not
a device was connected during suspend.

This is probably the same thing you said, Frank, sorry if I'm just
repeating it.

> +	if (!pci_root_ports_have_device(pci->pp.bridge->bus))
> +		return 0;
> +
>  	ret = dw_pcie_wait_for_link(pci);
>  	if (ret)
>  		return ret;
> -- 
> 2.48.1
> 

