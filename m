Return-Path: <linux-pci+bounces-22466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048C8A46E2A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 23:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528033AF42B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 22:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D9126B2D3;
	Wed, 26 Feb 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1fPqfqK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC2926B08D;
	Wed, 26 Feb 2025 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607619; cv=none; b=Ujk8pJciuCU6iqOPffWroE2jFNfBGTsENJ54BCwWm+3O6NgJDi83V6ab4MQmm8kRPumaYZi6ha6ae/EQZd9/rBvArjNSRvYSnU6Y132WyNBNnL3bXssL27M3f6qyyWFDD0SbPnIhimZyc8LyUW/76HN57X0/0NSdjztqmVSE/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607619; c=relaxed/simple;
	bh=YB0RjGNoksbKbFFqGOioUkcV8GHAMiCICWPvfuOYWT0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Iae2IQmHHbHMIkkWjcIb+Qv1+fz2Dyl3GsvMKEShWuUkqgzOiYYraKPIWcsPtHdS8H7IrmWJQl7ZHMoDkn8NppC9QZF19D432e2qaYpENOE4czKSt11aJify3o022+MpJ59ZKwftJO1b6L9Dekl1FZWa8Hfokxi8mdz4utigCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1fPqfqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0236C4CED6;
	Wed, 26 Feb 2025 22:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740607618;
	bh=YB0RjGNoksbKbFFqGOioUkcV8GHAMiCICWPvfuOYWT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i1fPqfqKA+Kac68vYf7CO3u0NVTGK5sMY0dArhm5aEVrBNG3EEoqXDE82a4yqx4lt
	 G7rRHBw6EfpnS82Qjn9Gr3WfKlKdaYWQRiKIFZ+7SiR3SUVENRFAVwgLT86MyFIAZp
	 R1OvbUxomRKq+eypZuLMfRHm0+MIp/ytjOJX6MipnMngbXKQ26WYJ58lPoV5WXgjxB
	 H1bspIfl0FqQet5FVS3mKjTi82HVJBD2R0SJbU6jmwbcd+D7rqB/n2y2U8CckUj8YJ
	 mB1H6gOSRm9CL25D5BZ2Y4X/lfxESWxrLYCTevRRrXsDL+TcIRbxLTRrgLL3XT0SCg
	 kOofrYRQq7iGg==
Date: Wed, 26 Feb 2025 16:06:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Message-ID: <20250226220653.GA561472@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124358.88227-3-sai.krishna.musham@amd.com>

On Wed, Feb 26, 2025 at 06:13:58PM +0530, Sai Krishna Musham wrote:
> Add GPIO-based control for the PCIe Root Port PERST# signal.
> 
> According to section 2.2 of the PCIe Electromechanical Specification
> (Revision 6.0), PERST# signal has to be deasserted after a delay of
> 100 ms (TPVPERL) to ensure proper reset sequencing during PCIe
> initialization.
> 
> Adapt to use the GPIO framework and make reset optional to keep DTB
> backward compatibility.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> This patch depends on the following patch series.
> https://lore.kernel.org/all/20250217072713.635643-3-thippeswamy.havalige@amd.com/
> 
> Changes for v2:
> - Make the request GPIO optional.
> - Correct the reset sequence as per PERST#
> - Update commit message
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..aa0c61d30049 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -6,6 +6,8 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
> @@ -568,8 +570,29 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct pci_host_bridge *bridge;
>  	struct resource_entry *bus;
> +	struct gpio_desc *reset_gpio;
>  	int err;
>  
> +	/* Request the GPIO for PCIe reset signal */
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio)) {
> +		dev_err(dev, "Failed to request reset GPIO\n");
> +		return PTR_ERR(reset_gpio);
> +	}
> +
> +	/* Assert the reset signal */
> +	gpiod_set_value(reset_gpio, 1);
> +
> +	/*
> +	 * As per section 2.2 of the PCI Express Card Electromechanical
> +	 * Specification (Revision 6.0), the deassertion of the PERST# signal
> +	 * should be delayed by 100 ms (TPVPERL).
> +	 */
> +	msleep(100);

Use PCIE_T_PVPERL_MS.  The comment at that #define is probably enough.

> +	/* Deassert the reset signal */
> +	gpiod_set_value(reset_gpio, 0);
> +
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
>  	if (!bridge)
>  		return -ENODEV;
> -- 
> 2.44.1
> 

