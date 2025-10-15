Return-Path: <linux-pci+bounces-38159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D0BDD25C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2622F35052F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 07:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E730274C;
	Wed, 15 Oct 2025 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm73rybA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDD75809;
	Wed, 15 Oct 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513898; cv=none; b=jKwj/vVRvXCbYIFbsODLclKCpXy/t2FYZGQGJv1eR688xBFb7+5J7AwyyyluZmUkvwNLHMBVEl4Mf0O8iYY+1Fj1xl/JG+lrr73Lq7rc6mra1AyU2fANG9dSUQo0Om6GYVro1wxHRiNBMhybwfCgzowPjGFyLUpMQDv6Vh/K6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513898; c=relaxed/simple;
	bh=U7zfYFj65AKb6ukgrALS6SRxw3Y19iCTGy3WE/Svwb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM/bB6gI9d+XdH8QRrIwfHFj9JP/HYrDtGaVkaO1dVUzoSP7N279KUV04zgoKBICsPFqytl07nLbJ2jNx5p3TxWRDsO3Xc16ixKgSL8ANSneFt17eAwcUDbdQ1DGU+ThyjidlD+c57yZVt17whwaBKRLUSXfn0NVJJFtx0pPVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm73rybA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EE0C4CEF8;
	Wed, 15 Oct 2025 07:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760513897;
	bh=U7zfYFj65AKb6ukgrALS6SRxw3Y19iCTGy3WE/Svwb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mm73rybAUa4liouUp1ux2SvCcrFlvCmbB7ou9O0CmAe9HGqkIoT/vce0olky2RbOa
	 9y04pz7R8H+v0zlL9W9Isda0uC3mxkDcIXfgkk3K+PcIFhfVpNPAOtLpe4R5poQCkL
	 SDrgoQ1zJ2PJL8M5pGpf4HTenh1zt1OQ2zOr08dOg4jBh4uwvzkYw0O5W3r5MvJvyQ
	 uy8r96mMmb36q8PX43BxJHoeFs0xiunSArEL1Jnmc5VyWy69wtLE83E+DwCLLwevBV
	 41u67iv0Og5LAcObaX5W6Dpfpk+yYwRLyA2I6xuhswcgj7WXTthAHTiGckNRscfWhj
	 xBldso6WyyxsQ==
Date: Wed, 15 Oct 2025 09:38:11 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 1/4] of/irq: Add msi-parent check to of_msi_xlate()
Message-ID: <aO9PY2Ze2ISkNP1Z@lpieralisi>
References: <20251014095845.1310624-2-lpieralisi@kernel.org>
 <20251014222940.GA913235@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014222940.GA913235@bhelgaas>

On Tue, Oct 14, 2025 at 05:29:40PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 14, 2025 at 11:58:42AM +0200, Lorenzo Pieralisi wrote:
> > In some legacy platforms the MSI controller for a PCI host bridge is
> > identified by an msi-parent property whose phandle points at an MSI
> > controller node with no #msi-cells property, that implicitly means
> 
> Looks like you intended to continue the sentence here?

Sigh. "that implicitly means #msi-cells == 0", the `#` caused this.

Apologies.

Lorenzo

> > For such platforms, mapping a device ID and retrieving the MSI controller
> > node becomes simply a matter of checking whether in the device hierarchy
> > there is an msi-parent property pointing at an MSI controller node with
> > such characteristics.
> > 
> > Add a helper function to of_msi_xlate() to check the msi-parent property in
> > addition to msi-map and retrieve the MSI controller node (with a 1:1 ID
> > deviceID-IN<->deviceID-OUT  mapping) to provide support for deviceID
> > mapping and MSI controller node retrieval for such platforms.

