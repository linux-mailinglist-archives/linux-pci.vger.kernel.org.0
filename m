Return-Path: <linux-pci+bounces-38894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7FBBF68C2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7731E18859D4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1F1332EA2;
	Tue, 21 Oct 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJYd11Az"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DF18DB01;
	Tue, 21 Oct 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051079; cv=none; b=MgPRzIGEmX3VV4apGgNUyf0F/ZnjHCsyK++08KFrq9dmnfmuCWHh5iDGKOo69Nr7xr+u12IarM74fnF4LFxN6lLxlB0wXF+79eob+ejxkF+/pcfAfEkUMH30xejlt+bPHmI4Wl/F+NjLLFhVynJMMSxbbQ7uhL/2weazoy/KJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051079; c=relaxed/simple;
	bh=iBaEpS9tsmM3BLuEMwdZUtVD02xo8Z1H1drCBAehBPw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Hy4f5yQ21hK9uLp/5XR19JzTnw1i+F0M7gB/fVVF8KM3k7C2HaJEH6PDn1S2BQouJRM7TD3lgxYoT7BZUvKuHfhWhuc/Em/gAOKInJK1Joves0A+rFItk1/+qQ0bY5F3ya3GAHWagZRVXW9sWtxZiHtqsLrT/tlyygQQcwki64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJYd11Az; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761051077; x=1792587077;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iBaEpS9tsmM3BLuEMwdZUtVD02xo8Z1H1drCBAehBPw=;
  b=MJYd11AzGUwMc8Ca/lkpJq2Ucf2wB36EuEcdlm76A9wR86z4oUduLIF2
   1DD7QYTbwzVz12UMvwjwAi/+IMpAThdPdQerlOKmq/ru/wS3rpmrKd9NA
   N99jwRLFyyePjkwnEszZPUVWopdTeai72Q3OqfDLgHxoDD7FWYqyMbksn
   gCIYH0Ob8JOGd3OEXoWsSrg5PJKqIDrmx0fG+suOUB3LokaLIfcOPLFW2
   +qGUV1kiEHbDitxf7PVByZuY48zOSELE1Nwmmaez/TRxeXRlH+XEqQMQL
   S3tS6GEtYJVHWNFdGfs4yqu4jVJYC9PQBemljDcjTgOvIel0iG4/7SeoF
   g==;
X-CSE-ConnectionGUID: wbEj31CHRM+YYk8954vsJA==
X-CSE-MsgGUID: s2BNCi8LTC+lseCTYlcDVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74294543"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="74294543"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:51:17 -0700
X-CSE-ConnectionGUID: fUQcL98RSPyebu7ZpRILAg==
X-CSE-MsgGUID: LkEiCw6NR1ib1mB6xCDC2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="183613203"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:51:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Oct 2025 15:51:09 +0300 (EEST)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-pci@vger.kernel.org, 
    Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] MIPS: Malta: Use pcibios_align_resource() to
 block io range
In-Reply-To: <alpine.DEB.2.21.2510210145260.8377@angie.orcam.me.uk>
Message-ID: <9ff182b0-076b-78fd-adec-99ae7ea5341f@linux.intel.com>
References: <20251020223714.GA1165320@bhelgaas> <alpine.DEB.2.21.2510210145260.8377@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Oct 2025, Maciej W. Rozycki wrote:

> On Mon, 20 Oct 2025, Bjorn Helgaas wrote:
> 
> > > Since ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()") came
> > > through the PCI tree, I'd be happy to merge this as well, given your
> > > ack, Thomas.  It would be ideal to have a tested-by from Guenter.
> > > 
> > > I provisionally put it on pci/for-linus to facilitate testing.  If it
> > > doesn't solve the problem or you'd rather take it, Thomas, I'll be
> > > glad to drop it.
> > 
> > Added:
> > 
> >   Tested-by: Guenter Roeck <linux@roeck-us.net>
> >   Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
> >   Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > 
> > and dropped the Fixes: aa0980b80908 ("Fixes for system controllers for
> > Atlas/Malta core cards.")
> > 
> > If the missing resource reservations (dma1, tiger, dma page reg)
> > mentioned by Maciej are an issue or can be fixed up, let me know and
> > we can amend this.
> 
>  NB this comes from `plat_mem_setup' in arch/mips/mti-malta/malta-setup.c 
> iterating over `standard_io_resources'.  ISTR now this being my original 
> reason to come up with the approach taken with commit aa0980b80908 rather 
> than using PCIBIOS_MIN_IO.  Since the ranges are now owned by the PCI host 
> bridge, calls to `request_resource' referring `ioport_resource' fail.

So this platform would actually need multiple root bus IO resources to 
cover PIIX4 range without capturing non-PCI ranges?

>  I'm not sure offhand how to get a hold on the right handle under the new 
> arrangement in this platform code, but clearly it must be doable as x86 
> gets it right (and conversely Alpha gets it totally wrong).
> 
>  Also I think we should reserve the PCI port I/O window in the MMIO space 
> as well; something that I pondered back those 20 years ago already.  For 
> the system I've used here that'd show up as:
> 
> 10000000-1affffff : MSC PCI MEM
>   10000000-100fffff : 0000:00:0b.0
>   [...]
>   10142080-1014209f : 0000:00:0b.0
> 1b000000-1bffffff : MSC PCI I/O
> 1e000000-1e3fffff : 1e000000.flash flash@1e000000
> 
> Most non-x86 PCI host bridges have one, but I haven't come across a Linux
> platform that would report it.
> 
>   Maciej
> 

-- 
 i.


