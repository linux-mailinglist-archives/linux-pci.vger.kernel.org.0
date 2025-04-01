Return-Path: <linux-pci+bounces-25101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882AEA784BE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 00:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DE31891AAA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BAB20E713;
	Tue,  1 Apr 2025 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UusZ7dGe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879541EF378;
	Tue,  1 Apr 2025 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743546905; cv=none; b=Ea9okI7a4hLCCl7inc/Qxh5J1T+UFD2sPs5aIh7rq8TtelFmwSszY4mz7oOJCemSXNj/PJS+un9xv7i0I/doU6yFQfrvz7gZulc+N+S2qVSF/CJ8tUgekuM9xs3uuW+in7Jko69h6zFTXv3H0+C8jEH8F7hdW8pKxOAoCsiJCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743546905; c=relaxed/simple;
	bh=wT0CH3/Qb+9cxLpxMMOsoXMAg1sIrUgDOVAp5HYpYm4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BbVXFnoaq7rtX4oPHQ9vhRI+IaasT+z5z0ddLtEoCKr2pmNMhGU6Ct44uPMHoziai4YUh/B60clIFa6n/C2Ku9lS0JHZQRmg/+o1/kTRTHlvTBVrc/7NkbLqmw2UxK0Z9mhhPN1kFOEZl2M9AzVuv9oIweZNNR5s90Vx84QsALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UusZ7dGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA58BC4CEE4;
	Tue,  1 Apr 2025 22:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743546905;
	bh=wT0CH3/Qb+9cxLpxMMOsoXMAg1sIrUgDOVAp5HYpYm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UusZ7dGedEcpHUWVqIXcxyhVgZOaTP6kGwi5CU5wNgcC3cg1oZYszk0s8Hps9lcSc
	 U1vTiNZ7//YAqQltCDoKU4Up6gq471onC+apiVRfPfIpDj0NOC/Z7KRLRXJIF3dd0Q
	 3pnexRZ33sYr3GSKfz9dp8/3QV8PyLnsnfGkNbhQdzj/zwJo7CbvCqYE0OphAVRKiR
	 skcDIQdbxaUjAstBf/gx61lSP4y5TwW4urH6henw+VsWHxPHY9KaPOffVwpunssgWV
	 phJmyo1ep9x6i17ef+RYmYaEHXYOJqoqzfkT7blG6m7XkEFfLf6mF7ki6vts5ci8gJ
	 UVXRRBYxaEsrQ==
Date: Tue, 1 Apr 2025 17:35:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: PCI VPD checksum ambiguity
Message-ID: <20250401223503.GA1686962@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b37b02ec-59fb-4b3b-8e51-ae866eb8ecc9@gmail.com>

On Tue, Apr 01, 2025 at 11:51:07PM +0200, Heiner Kallweit wrote:
> On 01.04.2025 22:55, Bjorn Helgaas wrote:
> > Hi,
> > 
> > The PCIe spec is ambiguous about how the VPD checksum should be
> > computed, and resolving this ambiguity might break drivers.
> > 
> > PCIe r6.0 sec 6.27 says only the VPD-R list should be included in the
> > checksum:
> > 
> >   One VPD-R (10h) tag is used as a header for the read-only keywords.
> >   The VPD-R list (including tag and length) must checksum to zero.
> 
> This requirement I don't find in the PCI 3.0 spec, not sure with which
> version it was added. 

I think it's there; that same text is in PCI r3.0, Appendix I, about
five lines before I.1.

> Interestingly this doesn't even require the presence of a RV
> keyword. Or the presence of the RV keyword is implicitly assumed.

I.3.1.1 says RV is required, and I guess it has to be last in VPD-R to
cover any reserved space (as needed, I suppose to align to the VPD-W
area, which might be in a different chip).

> Maybe this part isn't meant literally. I can imagine they wanted to
> clarify that checksum calculation excludes the VPD-W area.
> And unfortunately they weren't precise enough, and introduced the
> ambiguity you found.
> 
> > But sec 6.27.2.2 says "all bytes in VPD ... up to the checksum byte":
> > 
> >   RV   The first byte of this item is a checksum byte. The checksum is
> >        correct if the sum of all bytes in VPD (from VPD address 0 up
> >        to and including this byte) is zero.
> 
> This one can be found identically in the PCI v3.0 spec already:
> 
> The checksum is correct if the sum of all bytes in VPD (from
> VPD address 0 up to and including this byte) is zero.
> 
> I don't think they want to break backwards-compatibility, therefore
> this requirement should still be valid.

Yes, and I think the RV description is more specific and is what I
would have used to implement it.

> > These are obviously different unless VPD-R happens to be the first
> > item in VPD.  But sec 6.27 and 6.27.2.1 suggest that the Identifier
> > String item should be the first item, preceding the VPD-R list:
> > 
> >   The first VPD tag is the Identifier String (02h) and provides the
> >   product name of the device. [6.27]
> > 
> >   Large resource type Identifier String (02h)
> > 
> >     This tag is the first item in the VPD storage component. It
> >     contains the name of the add-in card in alphanumeric characters.
> >     [6.27.2.1, Table 6-23]
> > 
> > I think pci_vpd_check_csum() follows sec 6.27.2.2: it sums all the
> > bytes in the buffer up to and including the checksum byte of the RV
> > keyword.  The range starts at 0, not at the beginning of the VPD-R
> > read-only list, so it likely includes the Identifier String.
> > 
> > As far as I can tell, only the broadcom/tg3 and chelsio/cxgb4/t4
> > drivers use pci_vpd_check_csum().  Of course, other drivers might
> > compute the checksum themselves.
> > 
> > Any thoughts on how this spec ambiguity should be resolved?
> > 
> > Any idea how devices in the field populate their VPD?
> > 
> > Can you share any VPD dumps from devices that include an RV keyword
> > item?
> 
> I have only very dated devices which likely date back to before
> the existence of PCIe r6.0. So their VPD dump may not really help.
> 
> IIRC there's an ongoing discussion regarding making VPD content
> user-readable on mlx5 devices. Maybe check with the Mellanox/Nvidia
> guys how they interpret the spec and implemented VPD checksumming.

Good idea, cc'd.

