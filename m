Return-Path: <linux-pci+bounces-16016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA89BC1A5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 00:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0AA282D49
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0891FDFB8;
	Mon,  4 Nov 2024 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ntrz21As"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D951A76A4;
	Mon,  4 Nov 2024 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764179; cv=none; b=T8nCAooRoyNh4SaIYLHu9fjvc4C9FdX01UycZUE3NXpg+1OUC2rFzzHnCkV7OXI072P4T/PlGE3wIOTLthzU1n1OGqWA0oA9CC2uCyS28m6L0FIs/liFoY4uoFxrFUPBJysOfyqwaw6nCm7iSRc05qX/d+hi+jb7jEBHI5gty2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764179; c=relaxed/simple;
	bh=iYZ8xQtA17SG7eVmEIV4S/I2ob0ny1CVlXDrXQZre+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HvRLr7gyLwB8yAJdeSBCXmOCgza8bI7d9wGxH/EIzxjyu44IGecOC9dc6HYkcQXMlnMGeOJjZK1GQbOTm7r4E7fClABPCaH8sSZCEOHBeE0gImlfp2pITKWTIGOfRL1pl57d30Sq1EZ/qro5JJg6uEWZON9GrEZfpyNgKPzoowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ntrz21As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3E8C4CECE;
	Mon,  4 Nov 2024 23:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730764178;
	bh=iYZ8xQtA17SG7eVmEIV4S/I2ob0ny1CVlXDrXQZre+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ntrz21As60vacLFu5p1uAmxmcX96c07NNHqwAPllOOJB9RJXakyrOXNdt4fbBnjUm
	 DV1PpoHYRCz1U5qcb4iU4W17QW/fCzR0CO/c+y6/IZYExhQq+wESmOvX3jZyHl72DG
	 wxwE5FARzswPmdhMRSY+monukJehqVG7Et9RHSf3aO0Qwy1N1ppG8tSBMV3PkZbqms
	 2ZZqYtYByX9TfJTPlUtGAes7++oKDqQVSGVDp7m0JWypWvGw8UHnrPwduSWpiBhj2o
	 EN1anG73X1epeNiI1zoJE7//PnviSJH5pFTTFJ5hYGwgsPutn7QyP3uBWPS03aAmzh
	 lVNPTZyXfzscQ==
Date: Mon, 4 Nov 2024 17:49:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 05/12] PCI: of_property: Assign PCI instead of CPU bus
 address to dynamic bridge nodes
Message-ID: <20241104234937.GA1446920@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104150521.r4hbsurw4dbzlxpg@thinkpad>

On Mon, Nov 04, 2024 at 08:35:21PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 04, 2024 at 09:54:57AM +0100, Andrea della Porta wrote:
> > On 22:39 Sat 02 Nov     , Manivannan Sadhasivam wrote:
> > > On Mon, Oct 28, 2024 at 03:07:22PM +0100, Andrea della Porta wrote:
> > > > When populating "ranges" property for a PCI bridge, of_pci_prop_ranges()
> > > > incorrectly use the CPU bus address of the resource. Since this is a PCI-PCI
> > > > bridge, the window should instead be in PCI address space. Call
> > > > pci_bus_address() on the resource in order to obtain the PCI bus
> > > > address.
> > > 
> > > of_pci_prop_ranges() could be called for PCI devices also (not just PCI
> > > bridges), right?
> > 
> > Correct. Please note however that while the PCI-PCI bridge has the parent
> > address in CPU space, an endpoint device has it in PCI space: here we're
> > focusing on the bridge part. It probably used to work before since in many
> > cases the CPU and PCI address are the same, but it breaks down when they
> > differ.
> 
> When you say 'focusing', you are specifically referring to the
> bridge part of this API I believe. But I don't see a check for the
> bridge in your change, which is what concerning me. Am I missing
> something?

I think we want this change for all devices in the PCI address
domain, including PCI-PCI bridges and endpoints, don't we?  All those
"ranges" addresses should be in the PCI domain.

Bjorn

