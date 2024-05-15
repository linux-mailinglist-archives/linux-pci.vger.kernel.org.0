Return-Path: <linux-pci+bounces-7538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C68C6DBB
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 23:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3DF283460
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 21:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CFC15B145;
	Wed, 15 May 2024 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOFYVpIw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA27155A57;
	Wed, 15 May 2024 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715808084; cv=none; b=BX87LWRaSKnA9k/A7pM9wdvD5WgWvktq1TkrxXmbI9zQxxxZm6irmfHHtjgg+hFsAI+T7zPLOOY3rt7iw7K6WBlWTADTPwXbmiMkl52igA5kOi2RDPi1eN3KBCnawg2Wh34JnO3EaZDDiRgo/JyOm9pKNwvTTV7JODEyrEszDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715808084; c=relaxed/simple;
	bh=b6wgjbekzvDHVf0wUf2osyNkUYGGqJyKP5fQkIeZQv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oXlJ3QZAPHqbL1k7NcNET4VZXL7DuPFn9e9akR4o+3HvLnfgR0vxmMIADV6aEje7lLL/cJHT3b7kctcf0Q/Dny736Xno71fiX1vf8dsDWvtc8utcfZ9B47+XuIRTvI4M9kaj4m4/ViCKUsPft2FlBNa2jzrj45XtZiVKa1O09Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOFYVpIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA9DC116B1;
	Wed, 15 May 2024 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715808084;
	bh=b6wgjbekzvDHVf0wUf2osyNkUYGGqJyKP5fQkIeZQv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KOFYVpIw0J24StddEEc8pTucfvanCv8oYjOE/ZeTxDwV61ADspea16Rpxdt8NspgF
	 kOdKcynPdJc5f6s8CWlMnhx66wHQTksTsD0q7U7BC+46nm5gJNIwS87N8HNB/Mz8Um
	 qQXDLY4clXx0InfBcfIqQ5w/5qmzSOSDGcqqjxBnUxRn7Q/Kf3h70NPwuvw/21NaPX
	 3Ki9IYFXisyMqhzXr62C/FmuuLnlEtYNkE5CdMir0pj3gCx78Mf0AdrqXOEfwNy48/
	 xhmwW1kvv44+SHX//Pdu7f2SjCvy9Dk0MobzN+ZmpinGBYOquR/Wghm+r9lkXK0wCL
	 i3MZ4g5O8Idbg==
Date: Wed, 15 May 2024 16:21:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH V2] PCI: tegra194: Set EP alignment restriction for
 inbound ATU
Message-ID: <20240515212122.GA2139389@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjtFg83RjyKQA82S@ryzen.lan>

On Wed, May 08, 2024 at 11:27:31AM +0200, Niklas Cassel wrote:
> On Wed, May 08, 2024 at 10:22:07AM +0100, Jon Hunter wrote:
> > Tegra194 and Tegra234 PCIe EP controllers have 64K alignment
> > restriction for the inbound ATU. Set the endpoint inbound ATU alignment to
> > 64kB in the Tegra194 PCIe driver.
> > 
> > Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> > Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Applied by Krzysztof to pci/controller/tegra194, but his outgoing mail
queue was stuck.  Trying to squeeze into v6.10.

> > ---
> > Changes since V1: Updated commit message.
> > 
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 93f5433c5c55..4537313ef37a 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -2015,6 +2015,7 @@ static const struct pci_epc_features tegra_pcie_epc_features = {
> >  	.bar[BAR_3] = { .type = BAR_RESERVED, },
> >  	.bar[BAR_4] = { .type = BAR_RESERVED, },
> >  	.bar[BAR_5] = { .type = BAR_RESERVED, },
> > +	.align = SZ_64K,
> >  };
> >  
> >  static const struct pci_epc_features*
> > -- 
> > 2.34.1
> > 
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

