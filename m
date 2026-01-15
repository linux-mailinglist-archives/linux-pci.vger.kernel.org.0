Return-Path: <linux-pci+bounces-44893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73FD22A66
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D197F3010F9B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 06:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062430AD15;
	Thu, 15 Jan 2026 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4QDjJlM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04730AD11
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459902; cv=none; b=tTioihZPhUMrKzX0dgPqyCrUmB8He1CYrs4eWt9GbSC8UPPsO11TPZzKbpbbvQcgkAGKjVTZUAJyId5sU3SCO3n6WYFtPiLcVVheHZVq2bddgRiRuWRDCjIDb17FV6h4ssDLqIHxxvdtT1IcgGzdPudvQUW/yJpez//b8y4S+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459902; c=relaxed/simple;
	bh=krcwkRyA/OkDlIF+vLNpkYYr7LP+cp1CUDN0vKH6hYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqj8I15iMreyQz0UT3THpG5CafCiy+SdEhcmwfhBY27Ac2Dw+DgxkgEizgSwPG0OFUd8vSODjLI8vYvR1tz68lxf6R3s4vDomcjCIpa/tooDx1QzYDmZCUar9hZpM4GGDwidUpNz/1ragxzrxa8LTohgHxqyVNs4YdU6DySALMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4QDjJlM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81345800791so364448b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 22:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768459898; x=1769064698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRSrJXNvsYHwr4VvhkeEJyLglskxUKq6CBZCDhkjpfc=;
        b=k4QDjJlM+Q74FMoqCNocr8m7U1b9UGCwLcoe5042QNxkrnp9s6uXx3sVMEkmdmHYR1
         8P5Ez+kpivWQk9m2Ptm503ZagfwBeF2mDStSaXZ4+BdaNmwiKCBwKlz106x3XbKiQwd0
         VcvoHfv1WizDlUQO/FwuOzw7jVZdMJIJrvspnwSf2/fXXCfdVMBBcebVwbGRiEP2BFzt
         f76ICDNbQw9UJSBa8ewlOGDRpvE21d0rZ2NJZnjTgk0NyYgYyTaElVrapNXXGHxD8fhP
         wlFr/9FuPPRSMRaqr2aZGPoBoX7aj3JWP7MqNNF2FM3Y660G4gnu8HDCDEBgNGudyCMs
         DPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459898; x=1769064698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRSrJXNvsYHwr4VvhkeEJyLglskxUKq6CBZCDhkjpfc=;
        b=I7+rjQiTpC9+QTlZ8nWYgKX3r6rwvFmpRblM1v17wedTvIEF7kRoFd4NSdRn/DQSrB
         58gXigiNTBVU4keh8vV1WVXXxoCdmxm6FkWfv8G1D6Qzi9CkfB48INSUgC/uc+9lx/1p
         Liw+dhR3gdnc6KULOExpXPm9jUSAsHgdxDgjSwivIWPNi7n4atcGAFZJrGxKc6+iwVfq
         hZay+D8Rh3TJkPqkTdxVxAzVtiv6yMDd025bzF1JNBNDZCEFtl8UaluCq3fUH5GALYri
         gkWUXCNOmrGAY7eIDRfOvAcuzmMsmKJSBHg/OYTvE7xlnDAtWVaPiLB5Ub1WTg1d25SE
         62aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsAz8B8NIu4qNUq1PC352ssMIEaU3TcljW4Ta+JLGdkgBmEB8kaeuRcVvpgoEWsBouKHHllEpN6IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/1ZILyuk9EbcrJg5AfzpusM5X4ddUs5yxSYRqQpArNnXj+Mxu
	qB2HPfa75a0AYTGv+vimpcl/kIqIa1FNthwKkWQfKxQzbc54FOuGKfGQ
X-Gm-Gg: AY/fxX7Wef+t3fqfsrRv+ch7ABCSItb4ys3E7g72fSsKkS1iOedEbrEVpumfToTLU6u
	HJeo5vZ9GtKD4Fz05MQ5ojaf+dS+DQMTAPcGFyGmpVWErQiZOckESadhMl7jdi8jD8jfIV4zSef
	Onlj6RWx4qN5ZNsyYWrvPUpSg77QSPb6CbKsVbGGAisj20JDwLqlE0QHj/S27FywNTbJ95CaesF
	0JQ2hDSeuwqle/KeSsCY9cf7NbkDHfHVEzBJi0YxIxqnCwdETrWLuP8jWeR7p4+1htRc3jBC+2D
	jq8BlKhYhZeoufhB/KqBXHvROVjN5F+YLFu2yv7OWEtnE7AEymv19S8+yWBfaPJDVWnDrZd7e0S
	eMKYvbbPeeS5q5fnI23dXDOoW/0nWKZ3eAjirnx0BdrwgI+9+mW68jrgSWpu74Fai+LA18j91Xt
	NFYvWnB6C2PCvRpSOa92sZq5T25MsV
X-Received: by 2002:a05:6a00:4098:b0:7e8:4471:8d9 with SMTP id d2e1a72fcca58-81f81fffc7dmr4523165b3a.58.1768459897843;
        Wed, 14 Jan 2026 22:51:37 -0800 (PST)
Received: from DESKTOP-TIT0J8O.localdomain ([49.47.198.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e4b6ca9sm1452437b3a.4.2026.01.14.22.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:51:37 -0800 (PST)
Date: Thu, 15 Jan 2026 10:50:55 +0400
From: Ahmed Naseef <naseefkm@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] pci_read_bridge_bases: skip prefetch window if
 pref_window not set?
Message-ID: <aWiOT0Q2rCMHXsIx@DESKTOP-TIT0J8O.localdomain>
References: <aWdG/9N2C/7L5sFQ@DESKTOP-TIT0J8O.localdomain>
 <20260114175550.GA825847@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114175550.GA825847@bhelgaas>

On Wed, Jan 14, 2026 at 11:55:50AM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 14, 2026 at 11:34:23AM +0400, Ahmed Naseef wrote:
> > On Tue, Jan 13, 2026 at 03:02:59PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Jan 12, 2026 at 01:41:00PM +0400, Ahmed Naseef wrote:
> > > >   [  160.238227] mtk-pcie 1fb83000.pcie: EN7528: port1 link trained to Gen2
> > > 
> > > Can we look forward to a patch to add support for EN7528?
> > 
> > Definitely. Someone else is working on PCIe support for EN751221
> > (same SoC family). Once everything is consolidated, we plan to submit
> > a unified patch to drivers/pci/controller/pcie-mediatek.c.
> 
> Great, will watch for that!
> 
> > > > PCI_PREF_MEMORY_LIMIT which both return 0x0000. This results in base = 0
> > > > and limit = 0. The condition "if (base <= limit)" evaluates to true
> > > > (since 0 <= 0), so a bogus prefetch window [mem 0x00000000-0x000fffff pref]
> > > > is created.
> > > 
> > > It's too bad we didn't log this in dmesg.  It looks like we claimed
> > > there was a [mem 0x28100000-0x282fffff pref] window.
> > 
> > Should I add logging for this as part of the patch? If so, could you
> > suggest where and what format would be appropriate?
> 
> Apparently there's a place where we figured out that 01:00.0 has a
> prefetchable window at [mem 0x28100000-0x282fffff pref]:
> 
>   [  160.546094] pci 0001:00:01.0:   bridge window [mem 0x28100000-0x282fffff pref]
> 
> I don't know how we figured that out if PCI_PREF_MEMORY_BASE and
> PCI_PREF_MEMORY_LIMIT are hardwired to zero.  Another mystery worth
> exploring.
> 
> In any event, it sounds like there's another place later where we make
> a bogus [mem 0x00000000-0x000fffff pref] window?  That point, where we
> change the window, is where I would think about adding a message.
> 

If my understanding of the code flow is correct (please correct me if
I'm mistaken), the order is actually reversed - the bogus window is
created first, then the proper assignment happens later:

1. pci_read_bridge_windows() tests register writability and finds
pref_window is not supported (pref_window=0)

2. Later, pci_read_bridge_bases() unconditionally calls
pci_read_bridge_mmio_pref() with log=false. Since the registers
return 0, we get base=0, limit=0, and (0 <= 0) creates the bogus
window [mem 0x0-0xfffff pref]. This sets res->flags with
IORESOURCE_PREFETCH and res->start=0, res->end=0xfffff. But because
log=false, this is not logged to dmesg.

3. Then pci_assign_unassigned_root_bus_resources() sizes and assigns
bridge windows based on downstream device BAR requirements. The mt7615e
(device 14c3:7663) has prefetchable BARs:

	[  160.332147] pci 0001:01:00.0: [14c3:7663] type 00 class 0x000280 PCIe Endpoint
	[  160.339730] pci 0001:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit pref]
	[  160.346757] pci 0001:01:00.0: BAR 2 [mem 0x00000000-0x00003fff 64bit pref]
	[  160.353833] pci 0001:01:00.0: BAR 4 [mem 0x00000000-0x00000fff 64bit pref]

 The bridge prefetch resource already has IORESOURCE_PREFETCH flag set
from step 2. The sizing phase calculates the required window size based
on these device BARs. Then the assignment phase allocates addresses from
the available address space, overwriting the bogus res->start and
res->end with proper values.

	[  160.487241] pci 0001:00:01.0: bridge window [mem 0x28100000-0x282fffff pref]: assigned

4. Finally, pci_setup_bridge_mmio_pref() attempts to program the bridge
registers and logs the window address. However, since the registers
are hardwired to zero, the values won't stick.

	[  160.546094] pci 0001:00:01.0:   bridge window [mem 0x28100000-0x282fffff pref]

The reason for the confusion is that step 2 (bogus window creation) has
log=false, so it's silent in dmesg, while steps 3 and 4 log the proper
window address. This makes it appear as if the proper window came first.

In contrast, the mt7603 (device 14c3:7603) on port 0 has no pref flags:

	pci 0000:01:00.0: [14c3:7603] type 00 class 0x028000 PCIe Endpoint
	pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff]

Since mt7603 has no prefetchable BAR requirements, no prefetch bridge
window assignment is needed for that port and it works without any issues.

> > From: Ahmed Naseef <naseefkm@gmail.com>
> > Subject: [PATCH] PCI: Skip bridge window reads when window is not supported
> > 
> > pci_read_bridge_io() and pci_read_bridge_mmio_pref() read bridge window
> > registers unconditionally. If the registers are hardwired to zero
> > (not implemented), both base and limit will be 0. Since (0 <= 0) is
> > true, a bogus window [mem 0x00000000-0x000fffff] or [io 0x0000-0x0fff]
> > gets created.
> > 
> > pci_read_bridge_windows() already detects unsupported windows by
> > testing register writability and sets io_window/pref_window flags
> > accordingly. Check these flags at the start of pci_read_bridge_io()
> > and pci_read_bridge_mmio_pref() to skip reading registers when the
> > window is not supported.
> > 
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
> > ---
> > 
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -351,6 +351,9 @@ static void pci_read_bridge_io(struct pc
> >         unsigned long io_mask, io_granularity, base, limit;
> >         struct pci_bus_region region;
> > 
> > +       if (!dev->io_window)
> > +               return;
> > +
> >         io_mask = PCI_IO_RANGE_MASK;
> >         io_granularity = 0x1000;
> >         if (dev->io_window_1k) {
> > @@ -412,6 +415,9 @@ static void pci_read_bridge_mmio_pref(st
> >         pci_bus_addr_t base, limit;
> >         struct pci_bus_region region;
> > 
> > +       if (!dev->pref_window)
> > +               return;
> > +
> >         pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
> >         pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
> >         base64 = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
> 
> This looks good.  But I guess I would like to understand better how we
> figured out the addresses for the prefetchable window.  Things like
> that niggle at me.
> 

Does above explanation clarify the flow? I'm still learning the PCI subsystem internals,
so please let me know if any part of my understanding is incorrect.

Best regards,
Ahmed Naseef

