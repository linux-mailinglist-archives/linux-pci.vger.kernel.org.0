Return-Path: <linux-pci+bounces-10201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A0D92F904
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 12:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B834B1C220F8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0915444E;
	Fri, 12 Jul 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQUQDzEq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229FBD512;
	Fri, 12 Jul 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780449; cv=none; b=rwZp9b971IqL9PPj6zmw+saeHMvk5puH+r2ckJcbuzNEPZuqN+HPCONWGQm1sbgR0u8V5HsyV9yUqITJSmCAshdzOrDOfVheCByJ6tJjoc15YIjCY7XYWEgbqktfIjr8BWYLg1CXXU8faFD8sGSSTQ8Ylz5u1wQ7flSWVBtf7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780449; c=relaxed/simple;
	bh=tq4rb/Jo7ZVGqX1PpVuZm2HtEQ+odwrnEVHLJeesCkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCmmZpy2ASjl7S0eijrd1mpx+5pGHJWYKHNQgljV3ArdobRUmXLvZcWqxP23KsnzG3G7JTQzjqrobg290kUaPfETNeroQl6c1lSy+sDqNY9EBJQo1wrWprwMku67abO7jQLIx4dYVfOMx81DHBCl2kDc2USArjJFq10hdz54DcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQUQDzEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B89C32782;
	Fri, 12 Jul 2024 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720780448;
	bh=tq4rb/Jo7ZVGqX1PpVuZm2HtEQ+odwrnEVHLJeesCkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQUQDzEqJFDg6VE7+0eam/OnRwDGVW8EAE41L2coocaKPQ5ATP0tbuL179yoxWYc4
	 X/XAY3K8xQdsPDGmuZbvNK2UPGs7y+/8I0wb9ASkfdLUfBJXMw4BBac8Xhu8qJjcMa
	 +7En0bRkb9xnk302rcp5OWKUssdx1keqSAu8mwVJxEl2IkeNJwLuUgMcrmx9Gv5iRU
	 KnWRvsXJgoIg6wNo2ZqUN3DqwoD8dXxe+eq1P14ropnaEl/2R5xfsdufwiatEa8GS6
	 +Wu7t4+JhfW7/Mk6P3YReJ0+ikRL687DST6tdNStph8mPjgwYzP0FABf7xLaeR8ED7
	 579x8rdhOCTWA==
Date: Fri, 12 Jul 2024 12:34:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/2] PCI: ti: k3: Fix TI J721E PERST# polarity
Message-ID: <ZpEGmeJUJxrDFQWa@ryzen.lan>
References: <20240703100036.17896-1-francesco@dolcini.it>
 <Zo_qbspq0vA_p8VC@ryzen.lan>
 <20240711152531.GA35875@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711152531.GA35875@francesco-nb>

On Thu, Jul 11, 2024 at 05:25:31PM +0200, Francesco Dolcini wrote:
> Hello Niklas,
> 
> On Thu, Jul 11, 2024 at 04:21:34PM +0200, Niklas Cassel wrote:
> > On Wed, Jul 03, 2024 at 12:00:34PM +0200, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > Fix PCIe PERST# signal polarity in TI J721E used on TI K3 machines.
> > > 
> > > PCIe PERST# needs to be de-asserted for PCIe to work, however, the driver is
> > > doing the opposite and the device tree files are defining the signal with the
> > > wrong polarity to cope with that. Fix both the driver and the affected DT
> > > files.
> > 
> > While I understand why you want to fix this,
> > I'm not sure if you can actually do so without breaking device tree backwards
> > compatibility.
> 
> I understand this, and at the same time I know that this was done in the
> past for exactly the same reason, see for example commit 87620512681a
> ("PCI: apple: Fix PERST# polarity").

If you knew about it, I think that you should have stated that your are
breaking DT compatibility in the commit message, while also explaining it
is acceptable in your specific case.

I didn't know that there were other examples of drivers doing this.
Looking at your example, it seems that both:
1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
and
87620512681a ("PCI: apple: Fix PERST# polarity")

were first included in v5.16, so there was never a kernel release
with only one of the commits.

Anyway, I will eagerly await the DT maintainers feedback on this series.


Kind regards,
Niklas

