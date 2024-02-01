Return-Path: <linux-pci+bounces-2953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F97F845F67
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 19:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 297B5B2FF58
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41DB84FAF;
	Thu,  1 Feb 2024 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsOVeeci"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DB63064;
	Thu,  1 Feb 2024 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810631; cv=none; b=OPgKzjMEACtJ8Ao8+DYXZrZGr2M2JQrYvg1WDvnPAPQ+LgCDi2R9X9Ii9jzuMiY1wFhwIfh2Ts51fJXWKbpGAEomDk0SHBdy5gDFcsLB/o2KPCWbnnRCOsspLWUfe3YrrPtRP4CtqrWd9+5ULLm5lH4mni5HWmEBCuAKesvV03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810631; c=relaxed/simple;
	bh=cimPZd7g/IjUV38GuJgS7vN9RrjhC7JdmJnDdWIPGdE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HryBn3AdJd1YptBz+r0KTktZDsBgKM+F/fZ2llkZ51wTSGzL0eMEGIx9ddW33bQmyFonqLv83lAz9O7gP3Unm5RRqBRHhXsUk3Na2le9ItFnip7cSYqoaSN3lelsLdSZZ8+yFoiXOmPhg1X4VJkUgWvE3YXGJEfV6yyMx2F3f2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsOVeeci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8A9C43399;
	Thu,  1 Feb 2024 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810631;
	bh=cimPZd7g/IjUV38GuJgS7vN9RrjhC7JdmJnDdWIPGdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gsOVeeci6sC1lNCliVkreUO4TPedFwk18sO7t/T30vKvNS0Zg7rD2DbeTjIwtEVPt
	 ikUVM3JJbX4F17FNnTGYPUB3ViQdC9YApUsK5+e+lKUP2RdM38uSTgrSp9rs3VvAzU
	 +KNQZNlRIuMFGBv8rBmnif01Y+5ngR9l8kAkGSnujr8CginKDJIJC7OWqbCXsMfAu7
	 b/oheiZR8unpNmR9Xxb14fDSDG2P02CaLT1y0LLv9I2wUkUguVLmZu3AJfgyb8YDMm
	 S1p4BxjssXNhxUBFXg2ZgZEnV6Mgxn7xu7Jacxl55DECjrDlubhQ+Bjo0XxJ/LHH4r
	 qZt8sHTzxm2xA==
Date: Thu, 1 Feb 2024 12:03:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/6] PCI: dwc: Add common send PME_Turn_Off message
 method
Message-ID: <20240201180349.GA640827@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-pme_msg-v2-6-6767052fe6a4@nxp.com>

On Thu, Feb 01, 2024 at 11:13:30AM -0500, Frank Li wrote:
> Set outbound ATU map memory write to send PCI message. So one MMIO write
> can trigger a PCI message, such as PME_Turn_Off.
> 
> Add common dw_pcie_send_pme_turn_off_by_atu() function.
> ...

> -	if (!pci->pp.ops->pme_turn_off)
> -		return 0;
> +	if (pci->pp.ops->pme_turn_off)
> +		pci->pp.ops->pme_turn_off(&pci->pp);
> +	else
> +		ret = dw_pcie_send_pme_turn_off_by_atu(pci);

I think it's nice if function names match the function pointer names.

E.g., we currently already have:

  .pme_turn_off = ls_pcie_send_turnoff_msg,
  .pme_turn_off = ls1021a_pcie_send_turnoff_msg,
  .pme_turn_off = ls1043a_pcie_send_turnoff_msg,

which is slightly annoying because it's always useful to compare
implementations, but "git grep pme_turn_off" doesn't find the actual
functions, so I wish these were named "ls_pcie_pme_turn_off()", etc.

You don't have to fix those existing layerscape ones now, but I think
the same applies to dw_pcie_send_pme_turn_off_by_atu(): it would be
nice if it were named something like "dw_pcie_pme_turn_off()" so
grep/cscope would find it easily.

Bjorn

