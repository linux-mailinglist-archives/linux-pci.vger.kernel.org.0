Return-Path: <linux-pci+bounces-17408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9049DA6D7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 12:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B1CB25C27
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39C01F6677;
	Wed, 27 Nov 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaqlscfL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4761F6671
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706587; cv=none; b=PcaRBrnPM+TZ7vF/Yq0/mBdZQ/SOgPzwdHJofzhu8eAJUZ930OJDqzwKCr/NH0UJk1yboagFSfrh63660VU5KIX/lumadgHfUQZAF2xkZtkbDzLrntOdekc/6l+aAWFN1qjiYWEO1F5V51X/uG45+JSjWs4dW7kf1TQjZZR/9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706587; c=relaxed/simple;
	bh=IT3QjReXGUjxiyzn9kspMA2iuyuQI9MXxxMUpPpC0Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9S0RJUe7gvkSf/40bMLWqsc/yQ8cVTmNkjfe8dysCEm7jNvryeFmiLfYpp/1unUW5DjOCU+UfugQFWFL63MlvAJqIZcHNe94NxEOGvj6VAZBo+YCiUiqAMkpCggDgjdpQWhxep3PP0JXNjyNu3Yw9N85y69r6Ry8y98sSnuH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaqlscfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33F0C4CECC;
	Wed, 27 Nov 2024 11:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732706587;
	bh=IT3QjReXGUjxiyzn9kspMA2iuyuQI9MXxxMUpPpC0Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaqlscfLBegiyEE4LudGyrVpnHYyW8enoocpU9CxD5U4E7gFYg5NHlJIlzBdcuII4
	 SMqHlTjP29nLeWNWSAo7f+/I2a+5y7VMTpVoEq/5R9ezr00Iz57BW6GxM1W1rDyhga
	 f1YwCzaIHTiwl7Qll9OGF9gHuIMi+ocgrgdrBLEueKCLXrZUHvjwvOT7dIf0Gqflz6
	 /nihkgF6yZ+x/HuLSfjGaR9b2wNlXX+6S3uvRdWrNd/1dSDvaGMntYanlE4A1Agpvs
	 Ne9xX20qH58cPN77AjqZa2UTKXUA8dCkNhp/UBiU7T5MIEU+pldSG1HCcochqXVkDX
	 /vnWMa1cjwnWQ==
Date: Wed, 27 Nov 2024 12:23:02 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 0/2] PCI endpoint test: Add support for capabilities
Message-ID: <Z0cBFjK1WgSmg6k5@ryzen>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241126132020.efpyad6ldvvwfaki@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126132020.efpyad6ldvvwfaki@thinkpad>

Hello Mani,

On Tue, Nov 26, 2024 at 06:50:20PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 21, 2024 at 04:23:19PM +0100, Niklas Cassel wrote:
> > Hello all,
> > 
> > The pci-epf-test driver recently moved to the pci_epc_mem_map() API.
> > This API call handle unaligned addresses seamlessly, if the EPC driver
> > being used has implemented the .align_addr callback.
> > 
> > This means that pci-epf-test no longer need any special padding to the
> > buffers that is allocated on the host side. (This was only done in order
> > to satisfy the EPC's alignment requirements.)
> > 
> > In fact, to test that the pci_epc_mem_map() API is working as intended,
> > it is important that the host side does not only provide buffers that
> > are nicely aligned.
> > 
> 
> I don't agree with the idea of testing the endpoint internal API behavior with
> the pci_endpoint_test driver. The driver is supposed to test the functionality
> of the endpoint, which it already does. By adding these kind of checks, we are
> just going to make the driver bloat.
> 
> I suppose if the API behavior is wrong, then it should be caught in the existing
> READ/WRITE tests, no?

As of today, certain EPC drivers have implemented .align_addr():
drivers/pci/controller/dwc/pcie-designware-ep.c (i.e. all DWC based EPC driver)
drivers/pci/controller/pcie-rockchip-ep.c

Drivers currently missing .align_addr():
drivers/pci/controller/cadence/pcie-cadence-ep.c
drivers/pci/controller/pcie-rcar-ep.c

For drivers that are implementing .align_addr(), there is currently nothing
that verifies that the .align_addr() is actually working
(because the host side driver unconditionally adds padding for the buffers.)

That is what this patch is trying to fix.


> 
> > However, since not all EPC drivers have implemented the .align_addr
> > callback, add support for capabilities in pci-epf-test, and if the
> > EPC driver implements the .align_addr callback, set a new
> > CAP_UNALIGNED_ACCESS capability. If CAP_UNALIGNED_ACCESS is set, do not
> > allocate overly sized buffers on the host side.
> > 
> 
> This also feels wrong to me. The host driver should care about the alignment
> restrictions of the endpoint and then allocate the buffers accordingly, not the
> other way.

In my opinion, originally the drivers/misc/pci_endpoint_test.c host side driver
had no special padding of the allocated buffers on the host side.

Then when support for an EPC which had an alignment requirement on the outbound
iATU, Kishon decided to add padding to the host side buffers in commit:
13107c60681f ("misc: pci_endpoint_test: Add support to provide aligned buffer addresses")

such that the EP could perform I/O to the host without any changes needed on EP
side. I think that this commit/approach was a mistake.

The proper solution for this would have been to add an EPC side API which maps
the "aligned" address, and then writes to an offset within that mapping.

This is what we have implemented in commits (which is now in Torvalds tree):
ce1dfe6d3289 ("PCI: endpoint: Introduce pci_epc_mem_map()/unmap()")
and
08cac1006bfc ("PCI: endpoint: test: Use pci_epc_mem_map/unmap()")


IMO, an EPF driver should be able to write to any PCI address.
(Especially since this can be solved trivially by EPF drivers simply using
pci_epc_mem_map()/unmap())

E.g. the upcoming NVMe EPF driver uses the NVMe host side driver.
This host side driver does no magic padding on host side for endpoints
(NVMe controllers) that have an iATU with outbound address alignment
restriction.

Imagine e.g. another EPF driver, for another existing protocol, e.g. AHCI.
Modifying existing generic Linux drivers (e.g. the AHCI driver), simply because
some random EPC driver has a specific outbound alignment requirement (that can
simply be ignored by using pci_epc_mem_map/unmap()) does not make sense IMO.


> 
> That being said, I really like to get rid of the hardcoded
> 'pci_endpoint_test_data::alignment' field and make the driver learn about it
> dynamically. I'm just thinking out loud here.

That would certainly be possible, by simply dedicating a new register to that
in the test BAR (struct pci_epf_test_reg). However, I think that that would be
a worse alternative compared to what this series is proposing.

The only ugliness in my opinion is that we are setting the CAP_UNALIGNED_ACCESS
capability based on if an EPC driver has implemented the .align_addr callback.

If we could simply implement .align_addr() in the two missing EPC drivers:
drivers/pci/controller/cadence/pcie-cadence-ep.c
drivers/pci/controller/pcie-rcar-ep.c

pci-epf-test.c could set the CAP_UNALIGNED_ACCESS capability unconditionally.

However, I do not have the hardware for those two drivers, so I cannot
implement .align_addr() for those myself.

So in order to be able to move forward, I think that simply letting
pci-epf-test.c check if the EPC driver which is currently in use has
implemented the .align_addr callback, is a tolerable ugliness.

Once all EPC drivers have implemented .align_addr(), we could change
pci-epf-test.c to unconditionally set the CAP_UNALIGNED_ACCESS capability.


Kind regards,
Niklas

