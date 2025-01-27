Return-Path: <linux-pci+bounces-20407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2568A1D9FC
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 16:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2E816186F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B287C126BF1;
	Mon, 27 Jan 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS7okAr2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E557C9F
	for <linux-pci@vger.kernel.org>; Mon, 27 Jan 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737993349; cv=none; b=eu47DIOkUfgn6NgZg1IL+T/4GHVlOmEKPdOh7primGJH2LVxy4gKkoE59Bv9RGgnGJ1oe6jvcr9tZtQcC4lbyXQiowyacY3xJ4i7GBzilgm50NBsie8yHzlCgid9QX4YSMk8dO6fGLYBN2LgLEAslbuw9/4YJWN7kGRRNkP396A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737993349; c=relaxed/simple;
	bh=JOU0mcFgV51WLDj0QmhBf5j3Zs7v59XLu6CrbNQ4jbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrgMKxFAM4UcphU4kfeJfMMQbaMajX4Xhy88y8PZYSHF7h4wCnh0c9FxCijnZoe6n0FSFTUcsz0sq+2f61bLylgkH5Ojo/2rJ5DdD3pBQpFI45kxsQldrYbiBWd3sGibnTyDuNfPbTGkh1ogSYdPr+fpxYd65D//EqNv0D3Zb9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS7okAr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE088C4CED2;
	Mon, 27 Jan 2025 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737993349;
	bh=JOU0mcFgV51WLDj0QmhBf5j3Zs7v59XLu6CrbNQ4jbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PS7okAr20s1RN4MWWomQGIgSaG3RIDJaNiK3palQtOy/kBqCPEeJC89dYydhrYibk
	 94wojDzj8UTOKUqJcweuGNhu7DdncKbSC/KIyslND3Zzx4ihi1c6f0yPFpLWUPZRBF
	 WqwkK20EW7ZusOJJPzX30IyS2TN6AV/d1dOQD38Ta7dW+2Qz4GQ3CSrAWDSvj/CskR
	 43CGz30AnR5VTclJCHVM7oZN6c/tcu5ku7d9UBxA/hC6Rds6DewdZuk/YwKtGbAJfP
	 sMSyUZORsPN8H6AvwSQ3+GyiyTsNptXnrf0yqZLAy9qEcoJyoxwYVO7H+cG94qsuie
	 cEtLshzO6aknQ==
Date: Mon, 27 Jan 2025 16:55:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Handle endianness properly
Message-ID: <Z5esgJXMAvORNA1N@ryzen>
References: <20250120115009.2748899-2-cassel@kernel.org>
 <20250127062647.ehadg6ji53hkbsbf@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127062647.ehadg6ji53hkbsbf@thinkpad>

On Mon, Jan 27, 2025 at 11:56:47AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 20, 2025 at 12:50:10PM +0100, Niklas Cassel wrote:
> > The struct pci_epf_test_reg is the actual data in pci-epf-test's test_reg
> > BAR (usually BAR0), which the host uses to send commands (etc.), and which
> > pci-epf-test uses to send back status codes.
> > 
> > pci-epf-test currently reads and writes this data without any endianness
> > conversion functions, which means that pci-epf-test is completely broken
> > on big-endian systems.
> 
> Not a big deal, but I'd like to mention 'big-endian endpoint systems' to clarify
> the fact that the endianess issue is with the endpoint systems.
> 
> > 
> > PCI devices are inherently little-endian, and the data stored in the PCI
> > BARs should be in little-endian.
> > 
> > Use endianness conversion functions when reading and writing data to
> > struct pci_epf_test_reg so that pci-epf-test will behave correctly on
> > big-endian systems.
> > 
> 
> Same here.
> 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> No need to respin, these can be ammended while applying.

Thank you for the review and review comments.

I'll send a V2 regardless, to make the life easier for the PCI maintainers.
(And update V1 as superseeded in patchwork.)


Kind regards,
Niklas

