Return-Path: <linux-pci+bounces-8033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5688D39FD
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B31528ABEB
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2015AAD3;
	Wed, 29 May 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHjfbplA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB0159216
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994503; cv=none; b=J3vDrfGxEsWzf0WqK/m8sJksfhFg/WSztF3/g0bXL/xZviyCDaozslYp8zr+DvB26SviIE+3CRcMS9CZeV11Var4yyBCqpwA2HgdWY/B3nNJlRpwtTbSoaMIAWJqqYdAVF6PdIFuzXToTkfx0OHLsdoctx0Om/f0OlZ/jcd+dB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994503; c=relaxed/simple;
	bh=ucPBMN8ELSEqqPVpCWsJ2PX+3RqrGtkco4aD/+vQeDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx5KmFO9BDbNhM8RJASd2MGm9kSvesIM4WDvv9+cxEdqE8rDNpK/9lcZmJ2hI+348/LferMvcWAT5VdZlmpF5+WDzKeACBlRr1vVrLMpEwI4kZw/Lwb4S9Nb/6FHYeM1I3Ssgr/iMMvv5ESTM3As6fTJKtEWUYKngJbXkCwsgH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHjfbplA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE28C113CC;
	Wed, 29 May 2024 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716994503;
	bh=ucPBMN8ELSEqqPVpCWsJ2PX+3RqrGtkco4aD/+vQeDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHjfbplArmBCkVQK7UHhgwK54QVNsB79byIwy6v7kNtSY/BZg1wXxzYzmoeOKaU6K
	 R7nUDouk394fdI57VuqKvAWTpkJC8WUUm9dFZ+X5qwpwjj1lHzaIAfzx1T9VYiAMmi
	 CrmKK1THuK6hHQyWn3hSoDkcEtZKDKXyW2KRa8jXabTVXGduRi/GgAb3JOKNlCtu+V
	 c6A7wNrA4XLP0hxjgdJX4RvSncqFUwfc8tgTg4hZgdF7/PSo5CP20nOMx9VbBUlzNN
	 zuzzpKJ5G+aqSfWkcBWlVli8FQ9w/TaOz5uc2dkp7kysdUIzTwTlSf6ACuuPF+rCIB
	 B0Z/dkgemqw0A==
Date: Wed, 29 May 2024 16:54:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
Message-ID: <ZldBwUwyekUM-b9i@ryzen.lan>
References: <ZlYt1DvhcK-ePwXU@ryzen.lan>
 <20240528195539.GA458945@bhelgaas>
 <Zlba0OfNCGecFYj8@ryzen.lan>
 <20240529141614.GA3293@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529141614.GA3293@thinkpad>

On Wed, May 29, 2024 at 07:46:14PM +0530, Manivannan Sadhasivam wrote:
> 
> That's fine. Thanks a lot for stepping in to fix the build issue. I was on
> vacation, so couldn't act on your query/series promptly.

Welcome back ;)


> 
> Let us conclude the fix here itself as we have more than 1 threads going on.
> I did consider adding the stubs to pci-epc.h, but only the deinit API requires
> that. So I thought it will look odd to add stub for only one function, that too
> for one of the two variants (init/deinit).
> 
> So I went ahead with the ugly (yes) conditional for the deinit_notify API.
> 
> Ideally, I would've expected both dwc and EP subsystem to provide stubs for the
> APIs used by the common driver (host and EP). But since the controller drivers
> were using the conditional check to differentiate between host and EP mode,
> compilers were smart enough to spot the dead functions and removes them. So
> there were no reports so far.
> 
> But in this case, the pci_epc_deinit_notify() is called in a separate helper and
> hence the issue.
> 
> So to conclude, I think it is best if we can add stub just for
> pci_epc_deinit_notify() in pci-epc.h and get rid of the dummy
> dw_pcie_ep_init_notify() wrapper to make the init/deinit API usage consistent.
> 
> Also I do not want to remove the wrapper for dw_pcie_ep_linkup() since its
> conterpart dw_pcie_ep_linkdown() is required.

I see, sounds good.

However, if we add a stub for pci_epc_deinit_notify(), it makes sense to also
add a stub for pci_epc_init_notify(). (I'm quite sure tegra will fail to link
if you change it from dw_pcie_ep_init_notify() to pci_epc_init_notify()
otherwise.)

We should probably also address Bjorn comment:
"ls and qcom even use *both*: pci_epc_linkdown() but dw_pcie_ep_linkup()."

As far as I can tell, it is only ls (not sure why Bjorn also mentioned qcom):
drivers/pci/controller/dwc/pci-layerscape-ep.c:         pci_epc_linkdown(pci->ep.epc);
But this should probably also be fixed to use dw_pcie_ep_linkdown().


Kind regards,
Niklas

