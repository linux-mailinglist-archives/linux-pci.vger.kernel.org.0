Return-Path: <linux-pci+bounces-33496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0823B1CF39
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 00:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F55D7A5C00
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8CB230BF6;
	Wed,  6 Aug 2025 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9Eo6sCI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046EB20A5EC;
	Wed,  6 Aug 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754521014; cv=none; b=qRLbqDr5Ml5wrS8mlZFNx1jalRTAzMTOHWA9o8qDJ/bjD6C7cVeNYT/9nEx32QCCKUQCRfw66/rvvAwgRkLkSSHlZI0NSu0Vx0RPbtAWXwz5FUY9v0IUAxwnx2LcSWwwyOCHHNew3W1OE4I/SNuzDdFTlHpxPul3WqUZvqI9h0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754521014; c=relaxed/simple;
	bh=YIu7x67uowNlvxvbIuSAgV7LPKiK8u3nyiUTMrf3TxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A9siqBboYWX3HJNjwR25JY+BB0ijn/BT3+uERgUlq09z//bCNGKASXhH/3jbiT+TEbpEgZzTnUHfgChgwGgC2t5rnb2lsr+NPmnPJc8g5UmkWytFYxDcEIgmKrayADnybDTXhkNBPV0djxxZlDV3QyZCO4jNKZWPJdK2WMp4oq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9Eo6sCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E656C4CEE7;
	Wed,  6 Aug 2025 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754521013;
	bh=YIu7x67uowNlvxvbIuSAgV7LPKiK8u3nyiUTMrf3TxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D9Eo6sCIP+eilXaycDDZVzANMX9ozHbUo4DcV7w59Wd+BN4F/i0xhKYXe8AfafkFQ
	 3ypgxWUksPNNCwvzaK9t6f/vWgG1bVdzFWjVFrGFNgxLFlWuWSZ3olijtxfmhs1GJY
	 RgjVrJWqGIoNSzZjrsIRRgvJE8zL4ld0R7frXQwd86YqnZLjhbGkdu8Sz+fmCq0PwE
	 Eyidrl4gL6i+I/Vapsw1mTe/JksfjxGg+NL1HORcBw2Y5dgUi85AZI7t3IFhyVsKzu
	 m2y3oNFSM6MWt2e+UiWVTOejVJAOcmlwdtxXEuA2BEbmpvjRKYrKqUAjtomsLuvBrk
	 lm454RsGd9KNw==
Date: Wed, 6 Aug 2025 17:56:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Use header type defines in pci_setup_device()
Message-ID: <20250806225651.GA22936@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610105820.7126-1-ilpo.jarvinen@linux.intel.com>

On Tue, Jun 10, 2025 at 01:58:18PM +0300, Ilpo Järvinen wrote:
> Replace literals with PCI_HEADER_TYPE_* defines in pci_setup_device().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

All three applied to pci/enumeration for v6.18, thanks!

> ---
>  drivers/pci/probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..c00634e5a2ed 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1985,8 +1985,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	dev->sysdata = dev->bus->sysdata;
>  	dev->dev.parent = dev->bus->bridge;
>  	dev->dev.bus = &pci_bus_type;
> -	dev->hdr_type = hdr_type & 0x7f;
> -	dev->multifunction = !!(hdr_type & 0x80);
> +	dev->hdr_type = FIELD_GET(PCI_HEADER_TYPE_MASK, hdr_type);
> +	dev->multifunction = FIELD_GET(PCI_HEADER_TYPE_MFD, hdr_type);
>  	dev->error_state = pci_channel_io_normal;
>  	set_pcie_port_type(dev);
>  
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> -- 
> 2.39.5
> 

