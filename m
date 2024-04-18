Return-Path: <linux-pci+bounces-6448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCCB8A9FB8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852B5286AB0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CBD16F906;
	Thu, 18 Apr 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iE+QD7BL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879C23D7;
	Thu, 18 Apr 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456732; cv=none; b=H1Rgl7mnsICXKKdnnAEt4Wrfa61zMhIACVtS5Ib/ItG0HoayTEl+0gSmrtz8oQCbvb1LQDHhFBnMu/9QQDEXt+lojcUAfHbn1zQ249St4wNP7e3VUJWXOfuXeh74bwR7MLU8CSG1V9Co5HvpIoC+a+o2Gp9/sIs3EnAgEyay+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456732; c=relaxed/simple;
	bh=eRwB3YCw2t/w180tUcjZCYanbt8cMadquiphPHE1TiA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jZD1eXFAoY/jMxKPYDUvpmNxcKgmwAnQXTPldh4r115dTkYnJdIteQPaR+GD0mrIyOlIdClX7MmOwBdKLB9v9lc/L03VLxyvDYVYCvmpUuFsFwFKl2Rm56kfFuNHKSEe+w06AHn4UH325xqwOe6agOnCD1zpPth0LK65/kuxmYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iE+QD7BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8ABC3277B;
	Thu, 18 Apr 2024 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713456731;
	bh=eRwB3YCw2t/w180tUcjZCYanbt8cMadquiphPHE1TiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iE+QD7BLSB9x6TGqXDdv4Zdg0SxEzUneBlr02PnQCY9J93OeWYeFLE7Z2izfpbo9V
	 7/+xMMaxc5o490jmdY8cyBOuAqJvTrU/lKvPAybVUs1PzpSi1j4spg6tN01mYU9IRH
	 Xma2PLYFuPx07sHGMvWD9p0LAv85X0uQGQx595NQQWssB09z18Cu7PlY9Fsqij/gxM
	 j5iY0NBTID0B8Te4oEcr54uWMWuqbqCy/bZLKQthJgZYhSc2nQYHjmWac4O7HdRbSE
	 +FVfiKdrXzgdjmNmwwDyTTudYOePPw6pyTJvqzQRQ3ccMjXHdY0PUdgphryOjC2tsn
	 tInUT5nAvtNhg==
Date: Thu, 18 Apr 2024 11:12:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 3/9] PCI: endpoint: Rename BME to Bus Master Enable
Message-ID: <20240418161209.GA239309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pci-epf-rework-v3-3-222a5d1ed2e5@linaro.org>

On Thu, Apr 18, 2024 at 05:28:31PM +0530, Manivannan Sadhasivam wrote:
> BME which stands for 'Bus Master Enable' is not defined in the PCIe base
> spec even though it is commonly referred in many places (vendor docs). But
> to align with the spec, let's rename it to its expansion 'Bus Master
> Enable'.

Thanks for doing this.  I'm always in favor of using terms from the
spec.

> -		dev_dbg(dev, "Received BME event. Link is enabled!\n");
> +		dev_dbg(dev, "Received Bus Master Enable event. Link is enabled!\n");

Nothing to do with *this* patch, but this message reads a little weird
to me because setting Bus Master Enable has nothing to do with link
enablement.

Also incidental: some of these messages and comments refer to a "Bus
Master Enable *event*".  Does "event" here refer to the act of the
host setting the Bus Master Enable bit in the Command register?  This
is in qcom_pcie_ep_global_irq_thread(), so I assume there's something
in the endpoint hardware that generates an IRQ when the Command
register is written?

> - * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
> - *			  the BME event from the Root complex
> - * @epc: the EPC device that received the BME event
> + * pci_epc_bus_master_enable_notify() - Notify the EPF device that the EPC
> + *					device has received the Bus Master
> + *					Enable event from the Root complex
> + * @epc: the EPC device that received the Bus Master Enable event
>   *
>   * Invoke to Notify the EPF device that the EPC device has received the Bus
> - * Master Enable (BME) event from the Root complex
> + * Master Enable event from the Root complex

There's no "set Bus Master Enable" transaction that would appear on
the PCIe link, so I assume "the Bus Master Enable event from the Root
Complex" is a way of saying something like "host has written the
Command register to set the Bus Master Enable bit"?

Bjorn

