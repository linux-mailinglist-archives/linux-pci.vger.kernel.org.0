Return-Path: <linux-pci+bounces-14239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3289999502
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 00:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A50EB2162C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C4C1BC9F3;
	Thu, 10 Oct 2024 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOjDNuJb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6573719A2A3;
	Thu, 10 Oct 2024 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598592; cv=none; b=HdOGsLMgD1/iR+bWJZxHqumrd1o9Z3TrUr5aZVoWQ/r32oegNgZIkHvFFnkOoICIFMgGn29eMr7BeaLfqgMK7bEerjPOFYjStt7wmnrRiPjsLFsjLJYSFi0Bba7/nShircNGaMRPD7nTNb+Qqw4rViD0XnrAkePy2lsGupDaEiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598592; c=relaxed/simple;
	bh=/fSUe/XuT4djq6U2zM2gzmBo0xFuuCYD1/zFnLdp/QU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YRshi/AN7o4onSPp5SG7VJ4iEEuGVFIToean06fX97KAFtJskKfiix9Qfu38U5I/CdRtSPQuEtJGRDZTKpYCv7eCyUsFuDd3x0HXlXi9YrYPfCz5tJtjfnM2D/+gbAASKUm4xWpF/3cLlCW38xWB3Ivorl/5pUw/qMCQrKvBAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOjDNuJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5136C4CEC5;
	Thu, 10 Oct 2024 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728598591;
	bh=/fSUe/XuT4djq6U2zM2gzmBo0xFuuCYD1/zFnLdp/QU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZOjDNuJbForY00J9ZrwYA99p1VYOnT3JUgWwXgRVQ+fBnZSIImFd/K5x70FlGYEes
	 wxEgP7tEOGaV6XBtHdmT9Wmr+22/QRGErM6dJHTul27R+qBAZdP0FuJh3u+6JUtF9V
	 DH5nuDkADPqJIhdVztudOAEOJnYXxfQojAf4LS0/T/nBYEY4pnWfKesRyHZWlTofXM
	 hLHC+etVaffbIFf1e5ig9awUHBcozyvz0Qunn+jvE/JHfmAzUOrHbHa80HDzwrryAy
	 rPaHfkMotx9Shw+x8Fdj8iOoWejgiINbyZt1xoL64kOllpaxC8LahQftjfSmT/Nw3c
	 wCPSNp9T/68mQ==
Date: Thu, 10 Oct 2024 17:16:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, lukas@wunner.de,
	dan.j.williams@intel.com, bhelgaas@google.com, dave@stgolabs.net,
	dave.jiang@intel.com, vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] PCI/DOE: Poll DOE Busy bit for up to 1 second in
 pci_doe_send_req
Message-ID: <20241010221628.GA580128@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004162828.314-1-gourry@gourry.net>

On Fri, Oct 04, 2024 at 12:28:28PM -0400, Gregory Price wrote:
> During initial device probe, the PCI DOE busy bit for some CXL
> devices may be left set for a longer period than expected by the
> current driver logic. Despite local comments stating DOE Busy is
> unlikely to be detected, it appears commonly specifically during
> boot when CXL devices are being probed.
> 
> This was observed on a single socket AMD platform with 2 CXL memory
> expanders attached to the single socket. It was not the case that
> concurrent accesses were being made, as validated by monitoring
> mailbox commands on the device side.
> 
> This behavior has been observed with multiple CXL memory expanders
> from different vendors - so it appears unrelated to the model.
> 
> In all observed tests, only a small period of the retry window is
> actually used - typically only a handful of loop iterations.
> 
> Polling on the PCI DOE Busy Bit for (at max) one PCI DOE timeout
> interval (1 second), resolves this issues cleanly.
> 
> Per PCIe r6.2 sec 6.30.3, the DOE Busy Bit being cleared does not
> raise an interrupt, so polling is the best option in this scenario.
> 
> Subsqeuent code in doe_statemachine_work and abort paths also wait
> for up to 1 PCI DOE timeout interval, so this order of (potential)
> additional delay is presumed acceptable.

I provisionally applied this to pci/doe for v6.13 with Lukas and
Jonathan's reviewed-by.  

Can we include a sample of any dmesg logging or other errors users
would see because of this problem?  I'll update the commit log with
any of this information to help users connect an issue with this fix.

> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/pci/doe.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 652d63df9d22..27ba5d281384 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -149,14 +149,26 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  	size_t length, remainder;
>  	u32 val;
>  	int i;
> +	unsigned long timeout_jiffies;
>  
>  	/*
>  	 * Check the DOE busy bit is not set. If it is set, this could indicate
>  	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
>  	 * it is expected that firmware and OS will negotiate access rights via
>  	 * an, as yet to be defined, method.
> +	 *
> +	 * Wait up to one PCI_DOE_TIMEOUT period to allow the prior command to
> +	 * finish. Otherwise, simply error out as unable to field the request.
> +	 *
> +	 * PCIe r6.2 sec 6.30.3 states no interrupt is raised when the DOE Busy
> +	 * bit is cleared, so polling here is our best option for the moment.
>  	 */
> -	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
> +	do {
> +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	} while (FIELD_GET(PCI_DOE_STATUS_BUSY, val) &&
> +		 !time_after(jiffies, timeout_jiffies));
> +
>  	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
>  		return -EBUSY;
>  
> -- 
> 2.43.0
> 

