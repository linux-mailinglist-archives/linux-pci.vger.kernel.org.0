Return-Path: <linux-pci+bounces-17335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E719D9596
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 11:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56220B25772
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABFC1CDA15;
	Tue, 26 Nov 2024 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADBBkBdi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4821C4A24;
	Tue, 26 Nov 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616827; cv=none; b=hhzMbk6gspgJRKLAGTrKPSiPtA/JsqboXubrfGTEXcOVeMDEAIJsUD3fkXFu99n9NtkeGGcL323BMj3Fo/Fot/6HPNsHYXFeJf31eXYTT1c6WhVSopcxGTFf5soi4QpMPm6EJuKY+dubhbl9sCLgKGG9gYmhr0llR8myigitfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616827; c=relaxed/simple;
	bh=8yD+7qp8fEbXME2L4sxjUo1tkAIWbTe4iL3xiOmwJmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGqqvEhtr0J6w3cquJ8mYuZ3G4aYaasrobV3XCyENfsGnYK73y9aRNhWJxPL0Gp32jTYaC3Xt6V4uRZ/oZE1VJydJHSxoGOVmymC6lXPSRghWTO1cyF57ovd0h8Ya6Nxr/8liYSOZ3s4t/iiOjxvduG9b7VP+QSbvwkARBUi2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADBBkBdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB44DC4CECF;
	Tue, 26 Nov 2024 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732616826;
	bh=8yD+7qp8fEbXME2L4sxjUo1tkAIWbTe4iL3xiOmwJmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADBBkBdiZgDnaWhhgBxz4pL2/tU+re6/UzgnAWYVdWIZJOHMKi1NIeVphYaRLXLbl
	 KL3WMAB3eJSRJLayxrzOjVktQHM8USz0JWC5i7fmb/Z2Q7G/stckKtw4X6HAnVOaTw
	 xUb1v3tlzqbtKf2gPZBAKQGQ+wAmzwfqrmcAACORTQavY4CwINSnsjFw76ISVoPTyl
	 NfHgfsfakdqoTplnsjP4dj5lR1AHaxDs/bzrmCdWhoydZyN5JRYaVZaBWNESzcAhCF
	 VL6pjqufjTr6v9eS6ezFZUMWwoYXrUv3yfq0A99sUELu1bpu93OWI5xmEZ/pm9F8Ms
	 D5mDnxOwjUfIA==
Date: Tue, 26 Nov 2024 11:27:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v8 3/6] PCI: endpoint: Add pci_epf_align_addr() helper
 for address alignment
Message-ID: <Z0Widd3IZNV4DGS_@ryzen>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-3-6f1f68ffd1bb@nxp.com>
 <20241124073239.5yl5zsmrrcrhmibh@thinkpad>
 <Z0TOb0ErwuGQwF8G@lizhi-Precision-Tower-5810>
 <20241126041903.lq6zunvzoc2mmgbl@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126041903.lq6zunvzoc2mmgbl@thinkpad>

On Tue, Nov 26, 2024 at 09:49:03AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 25, 2024 at 02:22:23PM -0500, Frank Li wrote:
> > On Sun, Nov 24, 2024 at 01:02:39PM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, Nov 16, 2024 at 09:40:43AM -0500, Frank Li wrote:
> > > > +static inline int pci_epf_align_inbound_addr_lo_hi(struct pci_epf *epf, enum pci_barno bar,
> > > > +						   u32 low, u32 high, u64 *base, size_t *off)
> > >
> > > Why can't you just use pci_epf_align_inbound_addr() directly? Or the caller
> > > could pass u64 address directly.
> > 
> > 
> > msi message sperate low32 and high32.  (h << 32 | low) is quite easy to
> > cause build warning.  it should be ((u64) h << 32) | low. Avoid copy this
> > logic code at many EPF places.
> > 
> 
> There is absolutely no overhead in doing so. Also the concern for me is,
> pci_epf_align_inbound_addr() is exported but only used within
> pci_epf_align_inbound_addr_lo_hi(). This causes confusion. So I'd prefer to have
> a single exported API that is used by the callers.

Yes, other EPF drivers will need to copy the line:
pci_epf_align_inbound_addr(..., ((u64) h << 32) | low, ...)
instead of:
pci_epf_align_inbound_addr_lo_hi(..., low, high, ...)

which I think is fine to be honest.

Probably simplest thing is just to kill
pci_epf_align_inbound_addr_lo_hi().


Kind regards,
Niklas


