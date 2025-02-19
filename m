Return-Path: <linux-pci+bounces-21821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732B5A3C6B7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9403AA014
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED261FECAE;
	Wed, 19 Feb 2025 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMViZhKJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA71AF0D3;
	Wed, 19 Feb 2025 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987491; cv=none; b=qM7DWFLxo807/mf1u4txrQn/QPcjsodS9MZqWHtPLBMLQT6vS3Gw2iTPQv22NbSm54j05joqfiXqkKF438l/w2dTWTzLUHGqCAorGJL4nVl4P7cVusXoNZ8eZ40A2j/p+PH5ojAyLRZc4awmN5hG+y3gDI7NZMSm0OuYpLi/UC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987491; c=relaxed/simple;
	bh=H5/3Y209ghOxqgg6POxPe1hvZOewNiPPmcfKtVsdFGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6wJVnLdPHo+oFHLUR2U+Bbd/qxGl14+u4U8mabUE+J2y1zB5qX5j1KG0KY/dTf7MqMTKD3xZnog8QNbmvrlZ+Pjp7CQVWtBm0qQUgvXC6i6BnjaOItbR1cRLLMs7utE8ghhZ66eo1jtGndUk7FpCwxf1bzq7co1pEDW97rE94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMViZhKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89815C4CED1;
	Wed, 19 Feb 2025 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987491;
	bh=H5/3Y209ghOxqgg6POxPe1hvZOewNiPPmcfKtVsdFGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMViZhKJG+IIBBzxumfv7bsA8LcTpXBCk66MtLx4tF4HdLTSzyaF4S3os6qkx+MSI
	 aMcFB660Ro18FmMNHC0WdCMZSGkozVlHwCYhYIwYBr03Aews/K1jrDujiwiecIq2lJ
	 3xO2CaeMG31qkI74EKXctu9YjtjHEYxCgDm4dIJS/avqWtrB9OJuwtO3LozGC+X0LT
	 hQK2iPK9RjJCQrTX4UANqdK381MeXWCX9ro8Ct0RJi7VwQLtuC+iy7t53ZELsxMeVK
	 FPioMQ2OzJ8T3ECCctvVHa6R693Pbwl0M5bFDupJz2Q7cc0MhQpUxb+GZX/EgxDJHj
	 tdsDREETlNePw==
Date: Wed, 19 Feb 2025 23:21:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Tsai Sung-Fu <danielsftsai@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Chant <achant@google.com>, Sajid Dalvi <sdalvi@google.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
Message-ID: <20250219175119.vjfdgvltutpzyyp5@thinkpad>
References: <20250115083215.2781310-1-danielsftsai@google.com>
 <20250127100740.fqvg2bflu4fpqbr5@thinkpad>
 <CAK7fddC6eivmD0-CbK5bbwCUGUKv2m9a75=iL3db=CRZy+A5sg@mail.gmail.com>
 <20250211075654.zxjownqe5guwzdlf@thinkpad>
 <CAK7fddDkQX1aj5ZyTjh1_Pk+XME3AY=m5ouEFRgmLuJjBJytbA@mail.gmail.com>
 <20250214071552.l4fufap6q5latcit@thinkpad>
 <Z6-fjJv3LXTir1Yj@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6-fjJv3LXTir1Yj@google.com>

On Fri, Feb 14, 2025 at 11:54:52AM -0800, Brian Norris wrote:
> On Fri, Feb 14, 2025 at 12:45:52PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Feb 11, 2025 at 04:23:53PM +0800, Tsai Sung-Fu wrote:
> > > >Because you cannot set affinity for chained MSIs as these MSIs are muxed to
> > > >another parent interrupt. Since the IRQ affinity is all about changing which CPU
> > > >gets the IRQ, affinity setting is only possible for the MSI parent.
> > > 
> > > So if we can find the MSI parent by making use of chained
> > > relationships (32 MSI vectors muxed to 1 parent),
> > > is it possible that we can add that implementation back ?
> > > We have another patch that would like to add the
> > > dw_pci_msi_set_affinity feature.
> > > Would it be a possible try from your perspective ?
> > > 
> > 
> > This question was brought up plenty of times and the concern from the irqchip
> > maintainer Marc was that if you change the affinity of the parent when the child
> > MSI affinity changes, it tends to break the userspace ABI of the parent.
> > 
> > See below links:
> > 
> > https://lore.kernel.org/all/87mtg0i8m8.wl-maz@kernel.org/
> > https://lore.kernel.org/all/874k0bf7f7.wl-maz@kernel.org/
> 
> It's hard to meaningfully talk about a patch that hasn't been posted
> yet, but the implementation we have at least attempts to make *some*
> kind of resolution to those ABI questions. For one, it rejects affinity
> changes that are incompatible (by some definition) with affinities
> requested by other virqs shared on the same parent line. It also updates
> their effective affinities upon changes.
> 
> Those replies seem to over-focus on dynamic, user-space initiated
> changes too. But how about for "managed-affinity" interrupts? Those are
> requested by drivers internally to the kernel (a la
> pci_alloc_irq_vectors_affinity()), and can't be changed by user space
> afterward. It seems like there'd be room for supporting that, provided
> we don't allow conflicting/non-overlapping configurations.
> 
> I do see that Marc sketched out a complex sysfs/hierarchy API in some of
> his replies. I'm not sure that would provide too much value to the
> managed-affinity cases we're interested in, but I get the appeal for
> user-managed affinity.
> 

Whatever your proposal is, please get it reviewed by Marc.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

