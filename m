Return-Path: <linux-pci+bounces-6511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8114A8AC627
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B8AB22625
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 07:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B834D599;
	Mon, 22 Apr 2024 07:59:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D84AEE0
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772794; cv=none; b=NouYCmZVOqqT0rNBBf0Cnm6iEdJfPE5fbu54bAoaTfel0ai0xC8/lAvB1rWGABeDWvYQMawbPsAJBxvhRgoCwZZn1CMH7WECvv/Cg1TZV1m1Zqn+4O7xp4ybZilfwcxDwL6pyLfEpcfcgdIyzsFoD9EZyEBQ3G5T1fYP2PWnNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772794; c=relaxed/simple;
	bh=Ucs5NG4ai/fTXTYwHyUVq+98IqHNGHHonW53H87PMV0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB+aX5ZoDBSBSy1L5grjETEHX3n4qBT0uVuCA9C+fOmC9QpWQJFm33MtaMwoJ0VQ14yXNETp4j/e5t4p0wWlTEEf2JN23eEortIavRzpFhoKy+0JJA5v06e0uDIMagvuhVOB38PEIZxtaP582gq2HoVJJOMO8nDlgkp8ZdC/hKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 4b5bdb2a-007e-11ef-b3cf-005056bd6ce9;
	Mon, 22 Apr 2024 10:59:50 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 10:59:50 +0300
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: local bus enumeration beyond a PCI device
Message-ID: <ZiYY9u7uL7hnetFU@surfacebook.localdomain>
References: <bad63409-ed2b-4cef-988b-3c143636e9fa@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bad63409-ed2b-4cef-988b-3c143636e9fa@alliedtelesis.co.nz>

Thu, Apr 18, 2024 at 12:24:06AM +0000, Chris Packham kirjoitti:
> Hi,
> 
> We've got a custom x86_64 based design that is using an ASIX9100 to 
> provide a PCI to local bus bridge. Attached to that local bus is an FPGA 
> which mostly provides some GPIOs accessed via registers on the local 
> bus. Right now we've got a custom driver that bundles everything 
> together so effectively we've got a PCI device that provides GPIOs.
> 
> But as things can change based on the FPGA program I'd like some 
> flexibility to treat it separately from the PCI bridge.

Why? AFAIU the architecture, you have an FPGA with a real PCI bridge / switch,
no? If it's the case, the software shouldn't care if the respective IP comes
from FPGA or SoC.

> So really I'd 
> like to have a PCI device driver for the ASIX9100 that provides a local 
> bus controller and a (platform?) driver for the FPGA that provides the 
> GPIOs where I can have different compatibles for the different 
> implementations.
> 
> Then in the ACPI overlay I'd have something like
> 
>      Scope (\_SB.PCI0.D0B0)
>      {
>          Device (ASIX)
>          {
>              Name (_ADR, 0x0000)
> 
>              Device (FPGA)
>              {
>                          Name (_HID, "PRP0001")
>                          Name (_DSD, Package ()
>                          {
> ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                                      Package ()
>                                      {
>                                                  Package () { 
> "compatible", "my-platform-driver-for-fpga" },
>                                      }
>                          })
>              }
>          }
>      }
> 
>     Scope(\_SB)
>     {
>          Device(OTHR)
>          {
>              GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly, 
> "\\_SB.PCI0.D0B0.ASIX.FPGA",) { 0 }
>          }
>     }
> 
> Is it even possible to register a host controller for another platform bus?

AFAIK there is an FPGA framework in the kernel and the idea is that each FPGA
configuration provides a complimentary DT to describe the hardware setup. As
Bjorn Cc'ed this to Herve you may get the answer on what's going on there much
better as I'm not involved in the development of that topic.

-- 
With Best Regards,
Andy Shevchenko



