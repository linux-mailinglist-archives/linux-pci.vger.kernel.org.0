Return-Path: <linux-pci+bounces-6449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C072F8AA0CA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 19:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C94F28162F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA20C16F855;
	Thu, 18 Apr 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9OddMzf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEB15FA72;
	Thu, 18 Apr 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460213; cv=none; b=gK36kmC7sUtJ7INg4hmUyxOTNvxnK5Dn3ivRNAhptiBWv8mBO6rHakzKah5KqlxqEMC6idRPTltlSG40uWPflTvGF8CusgeZBYAjtZwAMePSQAY/2Pb2XQ7gDf78TxwRT4BAjj0k8Wuyl4rQtytMGNqnnhp7ExVjriYI6TlJvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460213; c=relaxed/simple;
	bh=kl0oAxdGo+sXqPTli9f/DOJgHUCpe4k+GtvAOTn9Q0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GC68SHefMoh9BTvpa2p1gwMAK2WY2FduXr42DGrUAqqwOpeCGH3zV+TcCw/77QxaDQLGtlyRXZ/SMov8a3CwT5nGAN4WCRxm4xc0LE3Yz372v2zjKRi2RiMxcAT2hyQlpnAMtq1GSjikJjxlHFMlUy9VDfz7gI97RuYZTbE7gZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9OddMzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B642C113CC;
	Thu, 18 Apr 2024 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713460213;
	bh=kl0oAxdGo+sXqPTli9f/DOJgHUCpe4k+GtvAOTn9Q0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h9OddMzfpmDhGWyoOoQUndZjnz5KmnKYn9fv+GuLfL5syWSxwFrRN+bMzVXigc1hF
	 UPAtrO1mw63M+0n3GUmLDymcQ3e73CHFCJtrBb15rHCLW/fizqKY86gnPQm5uJKEgT
	 HBcX/0h8QKiOOO3icqqjKS6qIF9MDZJvZTLTULI9t102r1wTghkNKtSvbKUQjIMMgA
	 YAWEjQR+FK7mRUNgEp2FpAmGoeImUmmZenGJ5F/b1uL4NaBk+NErEfCPHrSX4rnLhP
	 VXFuiPGkPOqXzA6ZprDyEEmjg9QWaFvBBQaH2DR+Cec355u0am1e9ppuFKJL0Wmdf7
	 yLlIy5XA9qdag==
Date: Thu, 18 Apr 2024 12:10:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Mateusz Kaduk <mateusz.kaduk@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, Tj <linux@iam.tj>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/pci: Skip early E820 check for ECAM region
Message-ID: <20240418171011.GA243400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f55f7e-92f9-4689-9dd8-75fb45f8afe5@linux.intel.com>

On Wed, Apr 17, 2024 at 08:10:28PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> On 4/17/24 1:40 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Arul, Mateusz, Imcarneiro91, and Aman reported a regression caused by
> > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").  On the
> > Lenovo Legion 9i laptop, that commit removes the area containing ECAM from
> > E820, which means the early E820 validation started failing, which meant we
> > didn't enable ECAM in the "early MCFG" path
> ...

> LGTM
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks for taking a look!

> > -	if (!early && !acpi_disabled) {
> > +	if (early) {
> > +
> > +		/*
> > +		 * Don't try to do this check unless configuration type 1
> > +		 * is available.  How about type 2?
> 
> I don't understand why above question is included in the comment. Do
> you think it is better to drop that part of the comment?

The "How about type 2?" questio was added by bb63b4219976 ("x86 pci:
remove checking type for mmconfig probe").  I only moved it and fixed
the capitalization and formatting.

> > -	/* Don't try to do this check unless configuration
> > -	   type 1 is available. how about type 2 ?*/
> > -	if (raw_pci_ops)
> > -		return is_mmconf_reserved(e820__mapped_all, cfg, dev,
> > -					  "E820 entry");
> > -
> >  	return false;
> >  }

