Return-Path: <linux-pci+bounces-21936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4F1A3E8A0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 00:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C60424444
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083D2638BC;
	Thu, 20 Feb 2025 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJG1lFtg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E72B9AA;
	Thu, 20 Feb 2025 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094522; cv=none; b=TBauBJgik+ew05fOMtwD7WlUvKpDmYEen6BaeJPhJ0UBpZe/1Rs0EegMnAzaCEQ41TBWPTOfvLAPiq5JZZZNRi0TDP+Bv+b/ObbGz58BA0HlIupBVndxomThPyzE3d0T6jfzV9X7gvRLtUu431QU0Sau14rC27vZjEnd7qfNR4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094522; c=relaxed/simple;
	bh=qx23oXz/G7Sfxg9XpiXWj9tfYd9kdkfah1N61jBxKPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FvrTneWhnGD4Shze48Xh02SyWgjYHmk7hznLlk20KZofhtUAl3xFw6+H+GsA6oUfuHhslh11b2r1ZQc9Rw9nhe9MiaLlXAY6+DzzjaJOdlrZeiVpZ7Ims1mDk/6FW4QM5wDtkRWcqFocSHfOZC32bYkJayc4ICl+V7tqpcQ8IlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJG1lFtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94C7C4CED1;
	Thu, 20 Feb 2025 23:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740094521;
	bh=qx23oXz/G7Sfxg9XpiXWj9tfYd9kdkfah1N61jBxKPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SJG1lFtglAhg1Lb6+9w9qZvRxyjwQKWw+77rXmrvKgH0xs4OQhK5siRINEDkn1udx
	 XFlrjrARWNF6tr+qLZUHaeHjuNNo/M250EpTPnFf06oD+napKxWNMwNgM//YfHqh6x
	 Cfd4wSXI6BjZdW/8FnJJxXSyBDEHHq+qC/OhOfBTCrvYBuUGbz7mnN+pkSJVbmL37n
	 6UHhIxczw0gnvMK949dbCIgXPGjTEBZ7yRcDmWhgDE19C5JLp33z5fZitmaqAELjKq
	 AvIvx8hWhwZZ2SqP+QDbuTTQBgw+ZUWVS0Uzmfe/hchbegzhr1ntaKFtFhlcWVfdZm
	 2UNpB6eyEtGWw==
Date: Thu, 20 Feb 2025 17:35:20 -0600
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
Message-ID: <20250220233520.GA319453@bhelgaas>
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

> -/*
> - * Create pwrctrl device (if required) for the PCI device to handle the power
> - * state.
> - */
> -static void pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> +static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)

> +	 * Create pwrctrl device (if required) for the PCI device to handle the
> +	 * power state. If the pwrctrl device is created, then skip scanning
> +	 * further as the pwrctrl core will rescan the bus after powering on
> +	 * the device.

I know you only moved the first sentence, but I think "power state" is
likely to be confused with the D0, D1, D2, D3hot, D3cold power
management states.  Maybe we could reword this to talk about power
control, power sequencing, power supplies, power regulators or
something?

> +	 */
> +	if (pci_pwrctrl_create_device(bus, devfn))
> +		return NULL;
>  
>  	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
>  		return NULL;
> 
> -- 
> 2.25.1
> 
> 

