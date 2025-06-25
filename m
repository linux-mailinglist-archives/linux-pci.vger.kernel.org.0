Return-Path: <linux-pci+bounces-30596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C5AAE7CD0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26D1174CE0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57B929C35B;
	Wed, 25 Jun 2025 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omf8+w7B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0261285CB8
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843247; cv=none; b=gNg9OD/MJ6mj60XxZJmzsenUSlKhKvXIfWNLPwcqmmS3D3O83Cc8MImm8ANyeo11C3g4MQ5NXFPCX4YE2209G2cPtXwTFS3B09qOLSBmokoVY0eorj9a+niOjC1E0NRfUW6ygpZiE1TQ5fOgtJ7wP00PWBKhFXu+UvTOHm2cBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843247; c=relaxed/simple;
	bh=aEBjPXPcPwoVNNOdnlfwqR/Jx37FItOViMFjLEr1c4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+qtWycsjCvLAoGK7nC0h/f9jRCGgFIiBxUpX5f9zIYYGfb5b0GMgSSkutrKcCXK78AorM3jSvWdCyVxeYnOpi5kV3sHuUE2w6gLyjlhYe4xPJ+qwwQoBeEgbRq/ru7otGFGj9ZAjCY1mPE0LQqYEGLudqucWRw8xxVDDRfgC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omf8+w7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE0EC4CEEA;
	Wed, 25 Jun 2025 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750843247;
	bh=aEBjPXPcPwoVNNOdnlfwqR/Jx37FItOViMFjLEr1c4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Omf8+w7BGWNO6EY4Dt6DrH2YHdSB2L6rw8t16C/aUMuyy6a8gbNmgeJMuKgviCsb7
	 PvxTyrXVSUD+H4CJKxfNCBSpd5UbHBshKrtRsr9T4S3eFdSUtBp4gurHfKXF5MfXHg
	 Xl8toSWckgXeBIbvnTgnAFmZf6DlQXVnzZH3ssG7HUPnFawHVH3VxQN+RhukeKOZBA
	 rl5xKbrofjPuRWa4Rhi6wH3qHqE6Ei2sm2duRHyecrnvXKKdiHOztcXAwyjVl69ZjG
	 Yjp2B0Fdd2edYxNX+rluUgm+6xZRe3GB5JVxNVjrO9Z5u6u6GNMZ3pd2s4c9I/2vyq
	 ejTdHcs1jaQKA==
Date: Wed, 25 Jun 2025 11:20:42 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 5/6] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <aFu_aokbo37tqfZH@ryzen>
References: <20250613124839.2197945-8-cassel@kernel.org>
 <20250613124839.2197945-13-cassel@kernel.org>
 <hmkx6vjoqshthk5rqakcyzneredcg6q45tqhnaoqvmvs36zmsk@tzd7f44qkydq>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hmkx6vjoqshthk5rqakcyzneredcg6q45tqhnaoqvmvs36zmsk@tzd7f44qkydq>

On Mon, Jun 23, 2025 at 08:28:55AM -0600, Manivannan Sadhasivam wrote:
> On Fri, Jun 13, 2025 at 02:48:44PM +0200, Niklas Cassel wrote:
> > As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> > greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> > training completes before sending a Configuration Request.
> > 
> > Add this delay in dw_pcie_wait_for_link(), after the link is reported as
> > up. The delay will only be performed in the success case where the link
> > came up.
> > 
> > DWC glue drivers that have a link up IRQ (drivers that set
> > use_linkup_irq = true) do not call dw_pcie_wait_for_link(), instead they
> > perform this delay in their threaded link up IRQ handler.
> > 
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 4d794964fa0f..24903f67d724 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -714,6 +714,13 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >  		return -ETIMEDOUT;
> >  	}
> >  
> > +	/*
> > +	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
> > +	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
> > +	 * after Link training completes before sending a Configuration Request.
> > +	 */
> 
> As the comment clearly states, we should only wait if the downstream port
> supports link speed > 5.0 GT/s. So you should have the below check:
> 
> 	if (pci->max_link_speed > 1)
> 		msleep(PCIE_RESET_CONFIG_WAIT_MS);

PCIe 1.0 has 2.5 GT/s
PCIe 2.0 has 5.0 GT/s

Thus will assume that you actually meant:

if (pci->max_link_speed > 2)


Kind regards,
Niklas

