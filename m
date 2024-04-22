Return-Path: <linux-pci+bounces-6512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F818AC631
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 10:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228D3B210B3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED514D599;
	Mon, 22 Apr 2024 08:00:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274D4C637
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772848; cv=none; b=n5vKT3R9vfZbPMlU2EG3DhJqhTAjxVypk1Qmue8zNHDREF7QpSWn+qmFWnRmIH98znDwd3pGQBZyqYTg+DKzyW2QIvUvjtJ8PBnkVQYA4ciSFdLZ4RuIeINPrtS4RwA1p43Rq33X6/kiysBwxLuTrmY4zj/YduMrd98uGicul30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772848; c=relaxed/simple;
	bh=f0yd3qigJhx90p0yxgPbw6HH1vaR/nNVChrBqreGcLg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5RP5Y/MYao7d8+QcCxQHiZtU1BXPPNptV6lHxlk4vNPSa4exUKCNV2zs2qg0EvZD6sKw4ZlcNBdQytatEmXUOV0x1WKyRGCDu/K484JpDR9uI5N/dSFrNXZ/+hoYGBZ0uswfy4UKoORJVkAgaP9Gj2hHrYLUzCPPCSSUmPIxAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6b0fe1b6-007e-11ef-abf4-005056bdd08f;
	Mon, 22 Apr 2024 11:00:43 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 11:00:43 +0300
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: local bus enumeration beyond a PCI device
Message-ID: <ZiYZK9Jb-4qiGQ7C@surfacebook.localdomain>
References: <bad63409-ed2b-4cef-988b-3c143636e9fa@alliedtelesis.co.nz>
 <20240418184531.GA245970@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418184531.GA245970@bhelgaas>

Thu, Apr 18, 2024 at 01:45:31PM -0500, Bjorn Helgaas kirjoitti:
> On Thu, Apr 18, 2024 at 12:24:06AM +0000, Chris Packham wrote:

> > We've got a custom x86_64 based design that is using an ASIX9100 to 
> > provide a PCI to local bus bridge. Attached to that local bus is an FPGA 
> > which mostly provides some GPIOs accessed via registers on the local 
> > bus. Right now we've got a custom driver that bundles everything 
> > together so effectively we've got a PCI device that provides GPIOs.
> 
> What's the local bus?  The ASIX9100 (for which Google doesn't find any
> details) would have a PCI interface on the primary (upstream) side.
> What's the local bus on the secondary (downstream) side?  Below you
> mention "PCI bridge", which normally means both the primary and
> secondary sides are PCI buses.
> 
> If the local bus is not PCI, I guess the ASIX9100 would look to the OS
> like an endpoint, i.e., PCI_HEADER_TYPE_NORMAL, and the ASIX9100
> driver would handle any "bridge" functionality completely internally?
> 
> Maybe Herve's work at
> https://lore.kernel.org/r/20240325153919.199337-1-herve.codina@bootlin.com
> would be relevant?

+1 here. Thought the same when seeing the original message from Chris.

> > But as things can change based on the FPGA program I'd like some 
> > flexibility to treat it separately from the PCI bridge. So really I'd 
> > like to have a PCI device driver for the ASIX9100 that provides a local 
> > bus controller and a (platform?) driver for the FPGA that provides the 
> > GPIOs where I can have different compatibles for the different 
> > implementations.
> > 
> > Then in the ACPI overlay I'd have something like
> > 
> >      Scope (\_SB.PCI0.D0B0)
> >      {
> >          Device (ASIX)
> >          {
> >              Name (_ADR, 0x0000)
> > 
> >              Device (FPGA)
> >              {
> >                          Name (_HID, "PRP0001")
> >                          Name (_DSD, Package ()
> >                          {
> > ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >                                      Package ()
> >                                      {
> >                                                  Package () { 
> > "compatible", "my-platform-driver-for-fpga" },
> >                                      }
> >                          })
> >              }
> >          }
> >      }
> > 
> >     Scope(\_SB)
> >     {
> >          Device(OTHR)
> >          {
> >              GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly, 
> > "\\_SB.PCI0.D0B0.ASIX.FPGA",) { 0 }
> >          }
> >     }
> > 
> > Is it even possible to register a host controller for another platform bus?

-- 
With Best Regards,
Andy Shevchenko



