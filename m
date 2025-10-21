Return-Path: <linux-pci+bounces-38906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDA4BF722E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 16:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D7D400307
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF2E33B968;
	Tue, 21 Oct 2025 14:41:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A1333B957;
	Tue, 21 Oct 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057667; cv=none; b=sctpzHUvODH/8xwDLuFOn4+/tOEFwTmAZSpLWXagrhRrqAaQL8JWajbHMKryuldANPHYxa+gGf/ktdKe7FbvnStAuY+7Ma+PSmfsmEtx6UpQx9YzAgCiBeAGJjJewMTuOgPEmfzyX7HhnSP08rnVo4RIhhYSM1g0TvWODbd+bYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057667; c=relaxed/simple;
	bh=psNfBZyyNJC/BgyLpkpbbZ23QMFeN9l9ZAGSUVtrzLc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cnH43N49ZCIETITb1hNHJ+rUNeKfO+7+vtSX8lVS2Vfg6ahWSTJDBk7IB/SxDrYQn+WB6/f+GJN/t0mMUVIn5a5LdsIkJWOCTN44a0CyTx9BelCI7BTVfb5khys2rCxdrCh6tvJDBS3Pdukk4zWLwpdcZ4swEYWQIyIyK736kmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E587992009C; Tue, 21 Oct 2025 16:41:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DF88192009B;
	Tue, 21 Oct 2025 15:41:01 +0100 (BST)
Date: Tue, 21 Oct 2025 15:41:01 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-pci@vger.kernel.org, 
    Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] MIPS: Malta: Use pcibios_align_resource() to
 block io range
In-Reply-To: <9ff182b0-076b-78fd-adec-99ae7ea5341f@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2510211536330.8377@angie.orcam.me.uk>
References: <20251020223714.GA1165320@bhelgaas> <alpine.DEB.2.21.2510210145260.8377@angie.orcam.me.uk> <9ff182b0-076b-78fd-adec-99ae7ea5341f@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 21 Oct 2025, Ilpo Järvinen wrote:

> > > If the missing resource reservations (dma1, tiger, dma page reg)
> > > mentioned by Maciej are an issue or can be fixed up, let me know and
> > > we can amend this.
> > 
> >  NB this comes from `plat_mem_setup' in arch/mips/mti-malta/malta-setup.c 
> > iterating over `standard_io_resources'.  ISTR now this being my original 
> > reason to come up with the approach taken with commit aa0980b80908 rather 
> > than using PCIBIOS_MIN_IO.  Since the ranges are now owned by the PCI host 
> > bridge, calls to `request_resource' referring `ioport_resource' fail.
> 
> So this platform would actually need multiple root bus IO resources to 
> cover PIIX4 range without capturing non-PCI ranges?

 I've got it covered now; will send patches shortly.  It was easier than I 
thought, phew!

  Maciej

