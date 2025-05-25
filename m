Return-Path: <linux-pci+bounces-28383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01336AC32B5
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90A1177589
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEC71CCEC8;
	Sun, 25 May 2025 07:22:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D625D1C5F06;
	Sun, 25 May 2025 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748157735; cv=none; b=h6Kw4UjHioLYyawmO3f/i+dr0Pzudu1psK9uqCFH/6Ou+ivR/Fif4eY7gFAYsyHVpXNpyHaY36PmZE4d0OI2XzEzMDm5erfKa+3lpfz9aX+UVBEthzMH4RuBG2kOPazpER4tV4IddRfazZKMgMf/ZvBB7s5Vf4tepv/owZ88W0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748157735; c=relaxed/simple;
	bh=XUKZXLxBeMYpwBbEFFQ7/EGjqrrt6ioFksh1y0vEqkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li0TKVzCKr5r2gqrWwYgcCtHGa/1oDfo9aZw8D8DZlfYe/Yt0WAYPU9hueZQNSXWEiWsUWu+IhQ6IGQerwRWopfrzY0RdKTJFw2coVNPAL6cztLVMVwyA0ShtPho2s9dMffQVub8Lb58OC+N60/tj4C6pkgiDKwBxFxjFN0pVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8E6DB20091A3;
	Sun, 25 May 2025 09:22:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7442F6FEEF; Sun, 25 May 2025 09:22:03 +0200 (CEST)
Date: Sun, 25 May 2025 09:22:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, cassel@kernel.org,
	wilfred.mallawa@wdc.com
Subject: Re: [PATCH 1/2] PCI: Save and restore root port config space in
 pcibios_reset_secondary_bus()
Message-ID: <aDLFG06J-kXnvckG@wunner.de>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
 <20250524185304.26698-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524185304.26698-2-manivannan.sadhasivam@linaro.org>

On Sun, May 25, 2025 at 12:23:03AM +0530, Manivannan Sadhasivam wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4985,10 +4985,19 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  	int ret;
>  
> -	if (host->reset_slot) {
> +	if (pci_is_root_bus(dev->bus) && host->reset_slot) {
> +		/*
> +		 * Save the config space of the root port before doing the
> +		 * reset, since the state could be lost. The device state
> +		 * should've been saved by the caller.
> +		 */
> +		pci_save_state(dev);
>  		ret = host->reset_slot(host, dev);

Nit:  Capitalize terms as the PCIe Base Spec does, i.e. "Root Port".

"The device state" is ambiguous as the Root Port is a device itself
and even referred to by the "dev" variable.  I think what you mean
is "The Endpoint state".

Thanks,

Lukas

