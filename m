Return-Path: <linux-pci+bounces-21935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15C3A3E85E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 00:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F237171D61
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D339C266F12;
	Thu, 20 Feb 2025 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Olu8l8es"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B41EC00B;
	Thu, 20 Feb 2025 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093894; cv=none; b=V4wMKZ8ISglbA8Qe1A/+DH8eyFtY4sJpo0NtbWepEaWy2/D3rhA58a4zQwGAT1ehq6wAR5FiHigivu3G9zNOtlkyMBBmFLsDrwK4NCSMVGXIG9p3eK/GzakCt6h8AMigG9p/Hp9adezC5dU9Zs/ICsTiR3P2QEi6u63EIRjzUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093894; c=relaxed/simple;
	bh=ZyttVobKG2y7/soTPyt5YW5aoum/3JGi3vZhxppF9o8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gyX2bhiE6Ctg0pbX+GeIgG6yFBp214YXAVZrFvHzGE7QwRL12tmMPTcLOad7V/P5Cuqh4HGZg4C8lIdg2Sm1RDCBfHEFkym/ZSsaaw3WbfJ1aEmNcK12j6Vfw6eiThkRd18dS7qlS2v3p56v4PjbRihD4hmmAPcaz4+FFSLfq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Olu8l8es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED05CC4CED1;
	Thu, 20 Feb 2025 23:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740093893;
	bh=ZyttVobKG2y7/soTPyt5YW5aoum/3JGi3vZhxppF9o8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Olu8l8es8p+80cokVDQ0ZNZEqMhR3jqWWqvcMXT/I4UlcRyHXLT8fqOIw5gqj2aM0
	 DTZSDNAcVJjt9Ny1j48nv0pFtYf028KOE0pgeMY8lOHbNqv/Ka9hSOSFAOnYadUf9N
	 0iRGMZ4Zg/GcxiHUJHmkYT9UwrxPR45loHYBS/Rs7LctIWOQnPsoKbeKHkUtnnyZ0P
	 ifdKZ1fy6EWV5eo6HnOsH/8Hlrx6I98z9GfKiXzGsF7yclMeX7UIB0eWy+3qZqVmer
	 pjd6tM4GNJitMXiH6hzcm/s8CN1fX0MS355FqSUWtK0VSIRhcXz96tZZV84XjR1/Jm
	 Qc/CZ9gzWWq4A==
Date: Thu, 20 Feb 2025 17:24:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Message-ID: <20250220232451.GA319309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org>

On Thu, Jan 16, 2025 at 07:39:13PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> The pwrctrl core will rescan the bus once the device is powered on. So
> there is no need to continue scanning for the device further.

> @@ -2487,7 +2487,14 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	struct pci_dev *dev;
>  	u32 l;
>  
> -	pci_pwrctrl_create_device(bus, devfn);
> +	/*
> +	 * Create pwrctrl device (if required) for the PCI device to handle the
> +	 * power state. If the pwrctrl device is created, then skip scanning
> +	 * further as the pwrctrl core will rescan the bus after powering on
> +	 * the device.
> +	 */
> +	if (pci_pwrctrl_create_device(bus, devfn))
> +		return NULL;

I assume it's possible for the PCI device to already be powered on
even if there's a pwrctrl device for it?

Does this change the enumeration order in that case?  It sounds like
it may delay enumeration of the PCI device until the pwrctrl core
rescans the bus?

I hope that the enumeration order of all devices that are already
powered on at boot time is unchanged.

>  	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
>  		return NULL;
> 
> -- 
> 2.25.1
> 
> 

