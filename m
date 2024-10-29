Return-Path: <linux-pci+bounces-15517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE69B46CB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 11:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A48284FED
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC4204F65;
	Tue, 29 Oct 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8KMnie4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896472040A2
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197545; cv=none; b=RnYMS0PP8+cQrX/7z9VbMEs3kmJAIjh4I4DOM2BcX9zKjXVnsEjSaNiqEYl/qjB3TEvYrHWjZQnkuuFy9z8C/toGU5iF+oTU1J2jegyBdu2qp3bekiKslvJcK9Ua28ls95jLSK0avVKXnPoE1P2Fmx404ZAR9Tt3JfrOGtSG6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197545; c=relaxed/simple;
	bh=lyUAad6degwnlTtGnXPaSzAz+JtALpBZlhi/Siilvok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFVpdw/7VtRtnIRpb5JiCnBPjVCeVO/J+0V8y7ruZ1gle8SyHdHSDlp5iRHi7c2KzixZX95YApl9ibdh/o9YtFaSSBn/UT4wUvr3+qtpK4qa+G9Ob63uIXajs9AUUSnHGyQfff5gK3Ui5u4Cvd+zUCnOhkOgxVA0g1p2n9lslUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8KMnie4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C49DC4CECD;
	Tue, 29 Oct 2024 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730197545;
	bh=lyUAad6degwnlTtGnXPaSzAz+JtALpBZlhi/Siilvok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8KMnie4fsw06AqniYkxvQ7i75zOrb2KsgGzBXar8p82clfKTNQtYHOmKqRLaKnh6
	 I03gGP/5pW4EfyNyaLFWRvCI2DBUiOyx54tcYUCIsYWdDPmMYbVaiYxTMx/Pq737Ic
	 UrIcYQ+z0pFaJJVZ3pJ+oBVy661reneKgW+PZoXj28fgqozeVCoh9/bTQNPksjKGOt
	 mAMFevoevTOyVh3xCFhSzZIh1rM5jCFzp4LCmpckwrMnFAbTDF9DUlyRhxF7U1zNeC
	 PDND1YZC9eBA3IvpBE0aEdO3LNOqf4s0PKlBRIl8VwYpKqBcN+ps1qE0PrYgaBALM5
	 SZoVLcEbHzCNg==
Date: Tue, 29 Oct 2024 11:25:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: dwc: ep: Minor alignment cleanups
Message-ID: <ZyC4JM59rpvk8V6d@ryzen>
References: <20241017132052.4014605-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017132052.4014605-4-cassel@kernel.org>

On Thu, Oct 17, 2024 at 03:20:53PM +0200, Niklas Cassel wrote:
> Hello all,
> 
> Here comes minor cleanups related to the new address alignment APIs.
> 
> Kind regards,
> Niklas
> 
> Niklas Cassel (2):
>   PCI: dwc: ep: Fix dw_pcie_ep_align_addr()
>   PCI: dwc: ep: Use align addr function for
>     dw_pcie_ep_raise_{msi,msix}_irq()
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> -- 
> 2.47.0
> 

This series has been reviewed by two different people.

What is the hold up? :)


Kind regards,
Niklas

