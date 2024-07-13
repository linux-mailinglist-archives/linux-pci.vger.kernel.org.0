Return-Path: <linux-pci+bounces-10230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC49304AC
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 11:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3DAB2283D
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39305381D9;
	Sat, 13 Jul 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ngn.tf header.i=@ngn.tf header.b="jP9Oj8k3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ngn.tf (ngn.tf [193.106.196.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC931BC57;
	Sat, 13 Jul 2024 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.106.196.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720862113; cv=none; b=twt2UnASQfC3zvHTvQXC0Sj9rMrTl3nUaNXvEhUvURR1Y/dmwAFwDad0wY6jMZqVTjRgjQ7BQ/BsJeLpY/nxC9WUDDBKu42shZ87M3aebsfB5RxZ6m0Howw47dU4QhmazIhosfOUr2LKkfU1+BM66aDuriaJSIdeXtarRL1URj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720862113; c=relaxed/simple;
	bh=cXVQENL6ezEh/B8TnMDQ24J2n6O8LNrqU9d5J6TC008=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCPabPwLfHCUD90nfFXjoYsYaaxB1Cvyp3ccIaeplIBOArqQsO5r055+xbYkEA4VeCw17mF8BPyNCj7oD7UEiR5xRssMWFEPdf+ENCOjEAOansVIbyr3noUMxsm91kQSVxEOchV3fqbGat9us1yy4Rioab9Je4G3C+MZacPx7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ngn.tf; spf=pass smtp.mailfrom=ngn.tf; dkim=pass (2048-bit key) header.d=ngn.tf header.i=@ngn.tf header.b=jP9Oj8k3; arc=none smtp.client-ip=193.106.196.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ngn.tf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ngn.tf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ngn.tf; s=mail;
	t=1720861556; bh=cXVQENL6ezEh/B8TnMDQ24J2n6O8LNrqU9d5J6TC008=;
	h=From:To:Cc:Subject:References:In-Reply-To;
	b=jP9Oj8k35UX5FcuG37gd1FW4f/OGF4fqSonMjwyGqyEz9341ad7sRjPl+sYgdVHR2
	 DBTZguo55T55fZJw3MDVbp+qskevuKmN0/Pd/vsS6k4yLAvIUyiFKo5TJAm4okrsDl
	 SHznMpXspePp7/PxM6w5hjB/5QxXOLjWYwROXKtcxOoOIjZpaE5QJLTdmCOWjjU1Tj
	 +h4wSv+zYYSftEzhYA+HiF6FlZty9/ANVgoNNTqF10R5X2dxVNeP64mrDj/KSeUl+u
	 Aiv5OGHK3hE4f5v9qr8AiS9mAMYNP7/NpBBOXKBMQ2rN5jcCiNFD/qqYDgGqnCaDuh
	 s5cZMM1kOz5VA==
Date: Sat, 13 Jul 2024 12:05:32 +0300
From: ngn <ngn@ngn.tf>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: shpchp: Remove hpc_ops
Message-ID: <ZpJDXNtOQWSqG0mi@archbtw>
References: <abb0f57ee513af545be761988fa9ad5ce5703060.1718949042.git.ngn@ngn.tf>
 <20240712224425.GA351076@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712224425.GA351076@bhelgaas>

On Fri, Jul 12, 2024 at 05:44:25PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 21, 2024 at 09:35:00AM +0300, ngn wrote:
> > fix checpatch warnings and call hpc_ops functions directly, this has been
> > also done in pciehp with commit 82a9e79ef132
> 
> Trivial changes like checkpatch fixes should be in a separate patch
> from substantive things.  This helps make both easier to review.
> 
> It *might* be worthwhile to remove hpc_ops, although shpchp is pretty
> old and dusty by now, and it's hard to justify touching things like
> that because the risk of breaking something is relatively high and the
> benefit is relatively low.
> 
> The fact that shpchp is the only user of hpc_ops does make me a little
> more sympathetic to the idea of removing it, though.
> 

Thanks for the reply! I'll just remove hpc_ops then, and I'll send a separate
patch.

