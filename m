Return-Path: <linux-pci+bounces-23343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DAA59C17
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 18:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC2F3A7FA2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61E233D99;
	Mon, 10 Mar 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdyI/GPm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C41233120;
	Mon, 10 Mar 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626439; cv=none; b=d16d+aHRc3xYNmY1T6DLJ7sLVmjPkik5DaqXfXly0ERrxb884xZ5h7cqWFW69uJrLneTF4mvyyu4MlwbmSfCxBSUF45jr4gRzJQDqm0kCd+e9RO8kWN1AYCtVhH57N9p1kiYmeZh5w0UC1SAxYVkGss4D5imUl65/Ai3Cz1GA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626439; c=relaxed/simple;
	bh=qj4pXkKgx8918tBimyMxKHgPf2nAiDmK0GUSPbRonyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WG8DV2HGaYvR31Dwdi6pXdy6YgYHy3xCUZBZPD9/15uCGVdAf9Wy6Gc3P51JN3PZgdYLOEvzLDaQeCaKdsslJcY0LvGfbA3rKEikp7EwZrhUXtuaX22GZj+aPrI6oZQL3lhZsfRSpIH7BM8Kd76D4sa2xvGvjwiy4J8hDXwLWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdyI/GPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6312AC4CEEB;
	Mon, 10 Mar 2025 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741626438;
	bh=qj4pXkKgx8918tBimyMxKHgPf2nAiDmK0GUSPbRonyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cdyI/GPmP32JlBCOUh06gUEsyfWlnsQdjseBlBJT2r3Du2BTOvOAOqQ2YSpVNCj4t
	 +RpXafrx3g9RzPN1s8RkML8ybEK4zBJ7Z7i2mgvJ8DG8iRuKKSIWu+TrYv05kP1hwp
	 QYZPUixvfZ9fGoznSr2LmIQ933XTeXN6Oq+ebXfa1o7ypKGKTJ/aLlaq7AUEYz1BUz
	 4AmhlFNjtC/5R4gpU6exLDZTvzRdnGU/e6tjV7DiFtoQC60DJTDmtgmEresbpJxHj2
	 vbKH0/mpgK1L8btKkM/+ZEdyzRzcyhtFUlp8TjafUICY0XdRuH9kyBaCbDXXoka9Vr
	 F+vkRYsaxS5vw==
Date: Mon, 10 Mar 2025 12:07:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v5 3/3] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Message-ID: <20250310170717.GA556500@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224155025.782179-4-thippeswamy.havalige@amd.com>

On Mon, Feb 24, 2025 at 09:20:24PM +0530, Thippeswamy Havalige wrote:
> The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> incorporate the Coherency and PCIe Gen5 Module, specifically the
> Next-Generation Compact Module (CPM5NC).
> 
> The integrated CPM5NC block, along with the built-in bridge, can function
> as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
> rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> configuration.
> 
> Bridge errors are managed using a specific interrupt line designed for
> CPM5N. INTx interrupt support is not available.
> 
> Currently in this commit platform specific Bridge errors support is not
> added.

> @@ -478,6 +479,9 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
>  	const struct xilinx_cpm_variant *variant = port->variant;
>  
> +	if (variant->version != CPM5NC_HOST)
> +		return;

You're adding support for CPM5NC_HOST, but this changes the behavior
for all the NON-CPM5NC_HOST devices, which looks like a typo.

Should it be "variant->version == CPM5NC_HOST" instead?

>  	if (cpm_pcie_link_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");
>  	else
> @@ -578,9 +582,13 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  
>  	port->dev = dev;
>  
> -	err = xilinx_cpm_pcie_init_irq_domain(port);
> -	if (err)
> -		return err;
> +	port->variant = of_device_get_match_data(dev);
> +
> +	if (port->variant->version != CPM5NC_HOST) {
> +		err = xilinx_cpm_pcie_init_irq_domain(port);

  xilinx_cpm_pcie_init_port()
  {
    if (variant->version != CPM5NC_HOST)
      return;
    ...

  xilinx_cpm_pcie_probe()
  {
    ...
    if (port->variant->version != CPM5NC_HOST) {
      err = xilinx_cpm_pcie_init_irq_domain(port);
    ...
    xilinx_cpm_pcie_init_port();
    ...
    if (port->variant->version != CPM5NC_HOST) {
      err = xilinx_cpm_setup_irq(port);
    ...
  err_host_bridge:
    if (port->variant->version != CPM5NC_HOST)
      xilinx_cpm_free_interrupts(port);
    ...
  err_free_irq_domains:
    if (port->variant->version != CPM5NC_HOST)
      xilinx_cpm_free_irq_domains(port);

Right now one CPM5NC_HOST test is inside xilinx_cpm_pcie_init_port()
all the others are in xilinx_cpm_pcie_probe().

I think it would be nicer if the tests were inside
xilinx_cpm_pcie_init_irq_domain(), xilinx_cpm_setup_irq(),
xilinx_cpm_free_interrupts(), and xilinx_cpm_free_irq_domains() so
they're all done the same way and they're closer to the actual
differences instead of cluttering xilinx_cpm_pcie_probe().

Also, this makes it look like CPM5NC_HOST doesn't support any
interrupts at all.  No INTx, no MSI, no MSI-X.  Is that true?  If so,
what good is a host controller where interrupts don't work?

Bjorn

