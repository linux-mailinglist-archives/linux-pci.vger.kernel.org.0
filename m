Return-Path: <linux-pci+bounces-19640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3DCA09DB8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 23:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DB7168BDB
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 22:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0620A5D1;
	Fri, 10 Jan 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ManuQbqH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B01ACEB8;
	Fri, 10 Jan 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547927; cv=none; b=uZGlix57M9ODVcGHYitFVYdEv0w9NQ2W2TVY6x/t9rZAWzrJJSKbWoFH1nt6KjBrdUwZQfHrgNmkoL7OwTPpgNPSteyta+QTHXt06fFGhH3jDZfi1MKJAkBVjVTYD+e8btjdW3wkRaGCuvxG3vR5d2NOHLedHqNuM4k1TohUK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547927; c=relaxed/simple;
	bh=DLEpLG1m5W4R6CL6+4W7/UedZGSkgthe9gS3KngxZLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N0TquMWMlQI4sr71twLou4knHCiel5iKD2XPrj83/l7HS22Lc7dZhNW28mYykK+gngvduvFYUZ0ob/PDLrSyhSUCPQ1l2EcnD/oSqgOWpBFXeFiZih8rhWq1C+KwiQ4jvXVfPGhPgdOk2RPUTcWYyopX47nvSjYDLYPXS6fJsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ManuQbqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86143C4CED6;
	Fri, 10 Jan 2025 22:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736547926;
	bh=DLEpLG1m5W4R6CL6+4W7/UedZGSkgthe9gS3KngxZLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ManuQbqHSTcactyB2Pv88RPe6kmW+6bJ70xOHlALBW8ZaApg7qihBPSgg0MB1XxDP
	 2Sfb1aSG4MEDG2Q5BWaJbM74T9R3ZKbucW1aCtqBIgQJ6t3izk5x6xLe0wm3NfyjX8
	 W6aHyWUpfVkabF0D/bh1JF5E8gC+jMNk2zr2037C54jxn6rEivGg2tfKQVt4UnprQE
	 VUAgT20jki7KtulD/31HTvryTgs5MhyhkVlz7fuqbZlVHT5Dv9ha8+/jX9lFhh1Wlz
	 EKn6/dUuT9e80byAplmUx0Kkp7RPFps29+IhXje/eJo72tFMslKD77CN5Azw1pDnvc
	 +ITR5HQSLkzzg==
Date: Fri, 10 Jan 2025 16:25:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
Message-ID: <20250110222525.GA318386@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110140152.27624-3-roger.pau@citrix.com>

Match historical subject line style for prefix and capitalization:

  PCI: vmd: Set devices to D0 before enabling PM L1 Substates
  PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKUs
  PCI: vmd: Fix indentation issue in vmd_shutdown()

On Fri, Jan 10, 2025 at 03:01:49PM +0100, Roger Pau Monne wrote:
> MSI remapping bypass (directly configuring MSI entries for devices on the VMD
> bus) won't work under Xen, as Xen is not aware of devices in such bus, and
> hence cannot configure the entries using the pIRQ interface in the PV case, and
> in the PVH case traps won't be setup for MSI entries for such devices.
> 
> Until Xen is aware of devices in the VMD bus prevent the
> VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as any
> kind of Xen guest.

Wrap to fit in 75 columns.

Can you include a hint about *why* Xen is not aware of devices below
VMD?  That will help to know whether it's a permanent unfixable
situation or something that could be done eventually.

> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
>  drivers/pci/controller/vmd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 264a180403a0..d9b7510ace29 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -965,6 +965,15 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	struct vmd_dev *vmd;
>  	int err;
>  
> +	if (xen_domain())
> +		/*
> +		 * Xen doesn't have knowledge about devices in the VMD bus.

Also here.

> +		 * Bypass of MSI remapping won't work in that case as direct
> +		 * write to the MSI entries won't result in functional
> +		 * interrupts.
> +		 */
> +		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
> +
>  	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>  		return -ENOMEM;
>  
> -- 
> 2.46.0
> 

