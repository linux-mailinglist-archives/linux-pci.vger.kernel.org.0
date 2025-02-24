Return-Path: <linux-pci+bounces-22200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AC8A42057
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD3D169C1F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6ED23BD07;
	Mon, 24 Feb 2025 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq4jUOfP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA4204C19;
	Mon, 24 Feb 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403192; cv=none; b=Y4EmcimX8f/rdaiLSvfBH/Z4Uf3+89BTzixiP1w2srQzgCh+6YFzJH6buXCtBEjIDzZwzqzllCWspZ7BDd7tyZQHaxi9sASHVE+ltlXIKhFpBA8diILm0UuIeYGSXhdvIYQXdmMe6bO+r3Y49Z+MhNRrLm3pXhBKIuqDHzgdwTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403192; c=relaxed/simple;
	bh=y9P+mQuhoslmJ1+Iv0GlyHBRSvmzQLGAjFv9AKXzQ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyr13jTYi+geESebAqU+ev9W7XoXUtkUFa0I2jsAoDwS38Dlmqlwg69FeCZhiqKJMS0YA4HpXBsToa4wikIK9/6+zIaKus3Bu4WDcfgXWLAsZJS8sKz5bTv2Hi/nNDFu9XdrSubgCQFwzjwqZ2Sqi/e1BtzcyhopqWBXLplhYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq4jUOfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A614EC4CED6;
	Mon, 24 Feb 2025 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740403191;
	bh=y9P+mQuhoslmJ1+Iv0GlyHBRSvmzQLGAjFv9AKXzQ+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jq4jUOfP50nQgpqG26YiGxmHkXpjvjG9gRdilnbbfMo454vyjSKJJLi/9u/cOlByQ
	 X2f1YAunRdDYYCMhUw5scIn9ne4zkrd3r4Lf+y+t9cF0BEe6sh+xOrWU+jVmjG8ZtQ
	 Hmr0z6iXvVW5T1ydf4IuNHNEGqzXQgKx34NbaMJbxDgYvOa4p3uAG77jbIBGR3ZB4t
	 kwEOUR19Terhs6nIsSp66ly8sd0lrad/FDL3vDLuCLSnXObMPnYwzaEwJvQt5s+Hbv
	 PtNqdz+UaQvEsJl1cK+LR1ePbr6N7pv2dBxtu+mrJZeRb0kzQVkO5EsOXcQXzqU3zF
	 OP+zUJ8nJ/5Wg==
Date: Mon, 24 Feb 2025 14:19:45 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Sai Krishna Musham <sai.krishna.musham@amd.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Message-ID: <Z7xx8ZxpD011oCCj@ryzen>
References: <20250224063046.1438006-1-sai.krishna.musham@amd.com>
 <20250224063046.1438006-3-sai.krishna.musham@amd.com>
 <20250224070236.nhowwz3uwk2rx4qi@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224070236.nhowwz3uwk2rx4qi@thinkpad>

On Mon, Feb 24, 2025 at 12:32:36PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 24, 2025 at 12:00:46PM +0530, Sai Krishna Musham wrote:
> > Add GPIO-based control for the PCIe Root Port PERST# signal.
> > 
> > According to section 2.2 of the PCIe Electromechanical Specification
> > (Revision 6.0), PERST# signal has to be deasserted after a delay of
> > 100 ms (TPVPERL) to ensure proper reset sequencing during PCIe
> > initialization.
> > 
> > Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> > ---
> > This patch depends on the following patch series.
> > https://lore.kernel.org/all/20250217072713.635643-3-thippeswamy.havalige@amd.com/
> > ---
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> > index 81e8bfae53d0..0e31b85658e6 100644
> > --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > @@ -6,6 +6,8 @@
> >   */
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> >  #include <linux/irqchip.h>
> > @@ -568,8 +570,29 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct pci_host_bridge *bridge;
> >  	struct resource_entry *bus;
> > +	struct gpio_desc *reset_gpio;
> >  	int err;
> >  
> > +	/* Request the GPIO for PCIe reset signal */
> > +	reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> 
> You've defined the polarity as 0x1 in the binding. Which corresponds to
> GPIO_ACTIVE_LOW. So if you request the GPIO as GPIOD_OUT_LOW, it means the host
> is going to drive the PERST# line as 'high', which corresponds to PERST#
> deassert. I don't think you'd want that and if that is what is really happening,
> the endpoint state machine would be broken. So I suspect that the polarity of
> your PERST# line is wrong.
> 
> - Mani
> 
> > +	if (IS_ERR(reset_gpio)) {
> > +		dev_err(dev, "Failed to request reset GPIO\n");
> > +		return PTR_ERR(reset_gpio);
> > +	}
> > +
> > +	/* Assert the reset signal */
> > +	gpiod_set_value(reset_gpio, 0);
> > +
> > +	/*
> > +	 * As per section 2.2 of the PCI Express Card Electromechanical
> > +	 * Specification (Revision 6.0), the deassertion of the PERST# signal
> > +	 * should be delayed by 100 ms (TPVPERL).
> > +	 */
> > +	msleep(100);
> > +
> > +	/* Deassert the reset signal */
> > +	gpiod_set_value(reset_gpio, 1);
> > +

Since you are adding PERST# to your DT binding, please make sure that you
define it properly (as active low) in the DT binding.

Then in the driver things should look like this and nothing else:
devm_gpiod_get(..., GPIOD_OUT_HIGH); // will assert PERST#
gpiod_set_value(reset_gpio, 1); // assert PERST# (will be a no-op since PERST# is already asserted)
msleep(100);
gpiod_set_value(reset_gpio, 0); // deassert PERST#



Kind regards,
Niklas

