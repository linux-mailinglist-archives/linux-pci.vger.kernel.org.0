Return-Path: <linux-pci+bounces-14247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C248999579
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 00:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725D81C230A2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823551E4121;
	Thu, 10 Oct 2024 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKnwMb+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972614D6F9;
	Thu, 10 Oct 2024 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600849; cv=none; b=NSSzw+brO8+0UNxVAIMhnX6Ix4pGN6AvDExVd2CA97+NPSg+NuR4np0diSH5Fn3yStfi1uXJ5ph+9GipkRAh8XXZ/MoakD9HMt1bPQJevRttDQwqJATC/Z6OFk3Q+FTbXeRePaqwpWm3bIRiynXyaRXAphckEjnzDC3D8MHzJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600849; c=relaxed/simple;
	bh=9X2zQpOQIw6eNhBpfK+ND2D98IUUMluiPAYQiBV/oeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LI4rCs0k+klz8VqM9jMVQBcjRo0VIyFOleW+C92zWzZU4pdBiNT9FVSRzY7pDsKU7T/sctu1rwBgeF+48mUQQjHtzC0rvuBAz1L1objQ9YBerLXr9DRLd6aQFOvnPtnGNbU2SjLX/NprgGgIoRAc83HYu1dThnQ13lRAY9pqvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKnwMb+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91057C4CEC5;
	Thu, 10 Oct 2024 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728600848;
	bh=9X2zQpOQIw6eNhBpfK+ND2D98IUUMluiPAYQiBV/oeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tKnwMb+8MI3u940JMicIAOEiaLklrHsFHI+hJHDxkRRzI5OOKu+x1kicHSxaNQ6Nj
	 GmBAQa0bUP7XNunv0H/+sTSo0VCFbM0+TJ3VwfuaDxFipdMG3lm4mnQcYWTQtTA3Cp
	 G9KDy5RuEAgIlD4dbNSkcex5OfvwxQmIhFW/YxYiGSRIlrDJB3IRJfKsngrjfnaa9q
	 5iEuxzw3MZPFxNRkAcUFiN0VE7FXwD+wh8pRbGEsQGPT9h82rOgDTcu2SMX0iX0f0V
	 zmHSTwxzBHq0nIT5IlFkkAP3U36cr59WKq/z66peevLbKhCi4nOoSADFQclxA/GEtv
	 hWDUYuaaayPLQ==
Date: Thu, 10 Oct 2024 17:54:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v4 1/3] of: address: Add parent_bus_addr to struct
 of_pci_range
Message-ID: <20241010225406.GA583899@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwhX8I1SIpbRA1OU@lizhi-Precision-Tower-5810>

On Thu, Oct 10, 2024 at 06:40:48PM -0400, Frank Li wrote:
> On Thu, Oct 10, 2024 at 04:57:45PM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 08, 2024 at 03:53:58PM -0400, Frank Li wrote:
> > > Introduce field 'parent_bus_addr' in of_pci_range to retrieve untranslated
> > > CPU address information.

> It is "untranslated CPU address", previous patch use cpu_untranslate_addr.
> Rob suggest change to parent_bus_addr.
> 
> Is it better change to "to retrieve the address at bus fabric port" instead
> of *untranslated* CPU address

"parent_bus_addr" will hold an untranslated CPU address in some cases,
but not all.  I think it's better to use a generic term like "parent
bus addres" here because that is accurate in all cases.

> > and this "ranges":
> >
> >   ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> >            <0x80000000 0x0 0x70000000 0x10000000>;
> >
> > means:
> >
> >   (IA 0x5f000000, CPU 0x0 0x5f000000, length 0x21000000)
> >   (IA 0x80000000, CPU 0x0 0x70000000, length 0x10000000)
> >
> > which would mean:
> >
> >   CPU 0x0_5f000000-0x0_7fffffff -> IA 0x5f000000-0x7fffffff
> >   CPU 0x0_70000000-0x0_7fffffff -> IA 0x80000000-0x8fffffff
> 
> Yes,
> 
> > I must be misunderstanding something because this would mean CPU addr
> > 0x70000000 would translate to IA addr 0x70000000 via the first range
> > and to IA addr 0x80000000 via the second range, which doesn't make
> > sense.
> 
> Yes, it is my mistake, first length should reduce to 0x0100_0000 from
> 0x21000000. It works because dt convert IA to CPU, instead of CPU to
> IA.  for example, input IA: 0x80000000, match second one, convert to
> CPU address 0x0_70000000.

Great, if we can omit 0x5f000000 completely that will avoid the
confusion.  I hope the actual DT doesn't have this error.

Bjorn

