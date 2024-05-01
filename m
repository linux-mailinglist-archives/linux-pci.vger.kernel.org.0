Return-Path: <linux-pci+bounces-6973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D99108B9048
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 21:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAFD1F211C6
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9D916132E;
	Wed,  1 May 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI9thRng"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94614161320
	for <linux-pci@vger.kernel.org>; Wed,  1 May 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593336; cv=none; b=cSX4oF4Pj6qwgPQ2WXRs5prt62ObwUCHIHqi9gAAI4ZKC4Wjdsf95+vjvCeoegV+RGnmVkqDgWosYxF5umqIY1eflOCMEJ7ReEcsbZNgiRRkD+FbOD0z8Ef2RFTbOC/WoQ9bfs3QbRuLhEBHO4K7IWGUs4DzBL3vYYxfM81AxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593336; c=relaxed/simple;
	bh=FC9MscbtrO8zMg/v6cHJnj25Gf7EGprE6jgVjqFHs3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eTnOLVW3isgjpVvqoMPhJhrzN8WhHM6XbBCf3JPi2RyOwdFpL4vcg9B9zijyhQf7GJ9JsextKnWUklOXAv2Vn1X0j50gDmmh4IMIxne+kkHEXTQAcTg2Imozrt1nT4Op5JGREvpAgQ7IJHQBkILPwjAB8Ap2p+XYtWm1d66r2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI9thRng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFA2C072AA;
	Wed,  1 May 2024 19:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714593336;
	bh=FC9MscbtrO8zMg/v6cHJnj25Gf7EGprE6jgVjqFHs3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TI9thRng02O4HWfHCt2cSdJrN2QK8hCddMBo+EONXqIuA6yQZQrB2jTM/zLD+omT8
	 gjikfUw56KkuTKtUMT1Z2CdJEnMFFFnZh1jfl3vsn2g/APiXHws83nxwZIyhbvxPZJ
	 bCoXBGu2oeeg0vucxM+8fLzACxhjYPlFd8kH6P3Eeru676+SQQezfJgImyN20QKaQg
	 MsUoeya55HQRgioHWqUw/gj12vcR3tzmOrlGJRDP8TLytOvqjnhLF99e4mD58q05wY
	 F/rlqkx6uDgwBAtobV8xEDxEeLqedgaWSvvrOlxqotp2TkHy4QQPNHvJfIfrDB1cX7
	 gaeL242ndnORg==
Date: Wed, 1 May 2024 14:55:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
	Peter Delevoryas <pdel@meta.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] pci: fix broadcom secondary bus reset handling
Message-ID: <20240501195534.GA853546@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501145118.2051595-1-kbusch@meta.com>

[+cc Lukas since you mentioned pciehp]

On Wed, May 01, 2024 at 07:51:18AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> After a link reset, the Broadcom / LSI PEX890xx PCIe Gen 5 Switch in synth
> mode will temporarily insert a fake place-holder device, 1000 02b2, before
> the link is actually active for the expected downstream device. Confirm
> the device's identifier matches what we expect before moving forward.
> Otherwise, the pciehp driver may unmask hotplug notifications before
> the link is actually active, which triggers an undesired device removal.

Is this a Switch that doesn't conform to the PCIe spec, or is there
something wrong with the way we're looking for a CRS completion?

In the absence of a device defect, I would not expect to need a
Broacom-specific comment in this code.

> Cc: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
> Cc: Peter Delevoryas <pdel@meta.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd42884..4dc00f7411a94 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1255,6 +1255,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  	int delay = 1;
>  	bool retrain = false;
>  	struct pci_dev *bridge;
> +	u32 vid = dev->vendor | dev->device << 16;
>  
>  	if (pci_is_pcie(dev)) {
>  		bridge = pci_upstream_bridge(dev);
> @@ -1268,17 +1269,22 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  	 * responding to them with CRS completions.  The Root Port will
>  	 * generally synthesize ~0 (PCI_ERROR_RESPONSE) data to complete
>  	 * the read (except when CRS SV is enabled and the read was for the
> -	 * Vendor ID; in that case it synthesizes 0x0001 data).
> +	 * Vendor ID; in that case it synthesizes 0x0001 data, or if the device
> +	 * is downstream a Broadcom switch, which syntesizes a fake device)

s/syntesizes/synthesizes/

>  	 * Wait for the device to return a non-CRS completion.  Read the
> -	 * Command register instead of Vendor ID so we don't have to
> -	 * contend with the CRS SV value.
> +	 * Command register instead of Vendor ID so we don't have to contend
> +	 * with the CRS SV value. But, also read the Vendor and Device ID's
> +	 * to defeat Broadcom switch's placeholder device.

s/ID's/IDs/

>  	 */
>  	for (;;) {
> -		u32 id;
> +		u32 id, l;
>  
> +		pci_read_config_dword(dev, PCI_VENDOR_ID, &l);
>  		pci_read_config_dword(dev, PCI_COMMAND, &id);
> -		if (!PCI_POSSIBLE_ERROR(id))
> +
> +		if (!PCI_POSSIBLE_ERROR(id) && !PCI_POSSIBLE_ERROR(l) &&
> +		    l == vid)
>  			break;
>  
>  		if (delay > timeout) {
> -- 
> 2.43.0
> 

