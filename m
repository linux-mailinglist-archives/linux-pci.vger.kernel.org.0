Return-Path: <linux-pci+bounces-3752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF285B899
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 11:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB011F22181
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 10:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDE060EE9;
	Tue, 20 Feb 2024 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdlkta8K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34CE62148;
	Tue, 20 Feb 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423707; cv=none; b=jEtR8j9pbIpl2Wqh+r+9XFsbeCUnIquqmsS3pC7oZeqLvb4a7QHV0b25kq45Q/3TxJHwtXbtD95eXCMZghQNs+KYZDlVY2XFYCSWL+t46ury3uIp9ubW2P4Xz+iWWbBMLJflz8SiT95iW7Gqkd+/515juJGki0dsrKFGiIRhQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423707; c=relaxed/simple;
	bh=ZiVDo9VjxqacGWKKWwvnL3dNkMzx/y7612DJv1ebiD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDx8VkQXto2mzObkAxiwwSxdH02fbcF01PaqTkGer40SgH7hst3yicM3TOFI+yUtKmkEaEf3yjkAbMlsSN2OexWRDfLnhy9uaPhsrqSYC2Z4pxP3rcsvmHSY/+NZZVtK3m15pq81VbfliZBBO6zGYRYicWXFDd6dKu7xhyVnLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdlkta8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41E9C433C7;
	Tue, 20 Feb 2024 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423705;
	bh=ZiVDo9VjxqacGWKKWwvnL3dNkMzx/y7612DJv1ebiD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdlkta8KkwOy+GdYSnGEFJ/ZYtpmteSlrZ8NRw4lId6hdGN496C+J3poq6SKFJvKf
	 SkIc/LqK4NdAi0wULLCrdC4V8UYCRnHrEYALqzh7Dw8cMNRqm4jF9ysgNFlQRjjohl
	 alVl7OvWrtNAXlHN8FBxjJ7DL0DpeOiRkz/UYkWAp3M4HW7qAlVpPkAdbIgXzVcZLa
	 OdHj3Wisz1zx8erSKfbJN+QdNF0wB76HcuKshYmaSbeVytUgKGyXBm+nySVP4d5AHf
	 xZky2Nxt3SpIgc3jwCr8tQP1W3hjnhIKXkZz3NZ4aTAyCs1grTSP3OG2zWP1qJiyUR
	 RbiubdGag3n3w==
Date: Tue, 20 Feb 2024 11:08:17 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v10 00/14] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <ZdR6EUOv6hzLEmUa@lpieralisi>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <ZdNvsdao8jbB/52L@lizhi-Precision-Tower-5810>
 <20240219161208.GE3281@thinkpad>
 <ZdN/OyNpw0Xa7qXG@lizhi-Precision-Tower-5810>
 <ZdR2FRQ9Fe8hhK9I@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdR2FRQ9Fe8hhK9I@x1-carbon>

On Tue, Feb 20, 2024 at 10:51:17AM +0100, Niklas Cassel wrote:
> On Mon, Feb 19, 2024 at 11:18:03AM -0500, Frank Li wrote:
> > On Mon, Feb 19, 2024 at 09:42:08PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Feb 19, 2024 at 10:11:45AM -0500, Frank Li wrote:
> > > > On Mon, Feb 05, 2024 at 12:33:21PM -0500, Frank Li wrote:
> > > > > first 6 patches use drvdata: flags to simplify some switch-case code.
> > > > > Improve maintaince and easy to read code.
> > > > > 
> > > > 
> > > > @Lorenzo Pieralisi:
> > > > 
> > > > 	Do you have chance to look other patches?
> > > > 	Mani's apply EP side change. 
> > > 
> > > Even though the controller is for the endpoint, it is still a controller
> > > driver. So all the patches should go through Lorenzo.
> > > 
> > > I only merge patches under drivers/pci/endpoint. Hope this clarifies.
> > 
> > Sorry. It confused everyone. My means was that Mani applied Niklas Cassel's
> > patches, which cause my 14th patch build failure.
> 
> Hello Frank,
> 
> Patch 14, which adds this:
> 
> +static const struct pci_epc_features imx95_pcie_epc_features = {
> +       .msi_capable = true,
> +       .bar_fixed_size[1] = SZ_64K,
> +       .align = SZ_4K,
> +};
> 
> 
> Should, after rebasing on Mani's pci/endpoint branch, instead look like this:
> 
> +static const struct pci_epc_features imx95_pcie_epc_features = {
> +       .msi_capable = true,
> +       .bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
> +       .align = SZ_4K,
> +};
> 
> 
> > 
> > I asked if I need update my 14th patch or applied 1-13 only. 
> 
> I see, you want the maintainers to apply 1-13, and simply drop patch 14
> instead of you sending out a rebased series.
> 
> I assume that the maintainers will be fine with your suggested approach.

If patch 14 has no dependencies on 1-13 yes; if it does we need to
coordinate the merge between branches in the PCI tree.

Lorenzo

