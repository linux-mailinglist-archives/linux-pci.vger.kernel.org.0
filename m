Return-Path: <linux-pci+bounces-34375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DB0B2DB37
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBBA3A9221
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB76F26E701;
	Wed, 20 Aug 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnMhlgGI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50323C516;
	Wed, 20 Aug 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689789; cv=none; b=k0YzdNPSqMOONFagwMjCIo1W6NSZf9rSHst3vS2dv8ph9faikym2e8QqjrEwZhsHfqpzuzB/anw188qvN7u0A60hqh/xpqCLVl1pX0w7EB7zYTaeHbL09YGxfTTBCDBWXQ1cTfzbcVt0sBxtv8O4sq60PkZMR2KZ9heEodnh4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689789; c=relaxed/simple;
	bh=kveYH6xJ4b/PAXcjC6mUdes0JktzbMNXLCx/30WespA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bACJiru0ne6eOJNooAdr9iYwA+kF8TvnbeucyrBqhkZTrPdfvnTA38mKZ+gEFK7YFl09mfsOVobc4sE/tJQcp6B78qb7Uh5g6AffRkwcUiPRy+0TpEVLjbLl1zrwKgAXrEuldE7QnZiq2cDARN8f9AKUw0IA8Dzz3aF61ouDtNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnMhlgGI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755689788; x=1787225788;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kveYH6xJ4b/PAXcjC6mUdes0JktzbMNXLCx/30WespA=;
  b=KnMhlgGIaKxh8E0h04rTy5S9fq6pZDJF5YJuR1Syp8r9O+K7qPZxueyy
   VtavCp0LhpkZV/M3R5oaqKEZymdGTNVOTjXHWwbynhuHHeVOk8KH5UmPP
   feEWm5H6nZ/1jmkaV0ITszlS1pkycpwE0QejdeQvq2kBsRSChK6lYa4U2
   lr1wus5OeffAiXjA6Ds+raVDIV0208fYjvNtwAEX53QpbfpUjKK570c0B
   yA815f/gjZ+M3s5YqCeZbaS7tbtgmWZcJXMtsglZuoF+RiGmzHyDsZxP9
   TlCck/Y05wA84iTKYQrQTunDQ5KmtZYSg0AuFcq/SyvsiXcu2YLz+Q1uT
   A==;
X-CSE-ConnectionGUID: ai3UNU82Q2WxL+2zXuhTZQ==
X-CSE-MsgGUID: GASXws5uSpGw2TJKdF28gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58018496"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="58018496"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 04:36:28 -0700
X-CSE-ConnectionGUID: VyJyJYMbQYuS3662x5/ZtQ==
X-CSE-MsgGUID: d0RZ+HQbRXmjsJ2nBZOSiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167612315"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 04:36:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Aug 2025 14:36:19 +0300 (EEST)
To: Gerd Bayer <gbayer@linux.ibm.com>
cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, 
    kwilczynski@kernel.org, bhelgaas@google.com, helgaas@kernel.org, 
    jingoohan1@gmail.com, mani@kernel.org, robh@kernel.org, 
    schnelle@linux.ibm.com, Lukas Wunner <lukas@wunner.de>, arnd@kernel.org, 
    geert@linux-m68k.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v15 1/6] PCI: Clean up __pci_find_next_cap_ttl()
 readability
In-Reply-To: <353d1dc7e3c4e9b5f127ac9177a863d8a8cde39f.camel@linux.ibm.com>
Message-ID: <fb7c14c5-0aaf-6f90-caac-71d6ce6f25ae@linux.intel.com>
References: <20250813144529.303548-1-18255117159@163.com>  <20250813144529.303548-2-18255117159@163.com> <353d1dc7e3c4e9b5f127ac9177a863d8a8cde39f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 Aug 2025, Gerd Bayer wrote:

> On Wed, 2025-08-13 at 22:45 +0800, Hans Zhang wrote:
> > Refactor the __pci_find_next_cap_ttl() to improve code clarity:
> > - Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
> > - Use ALIGN_DOWN() for position alignment instead of manual bitmask.
> > - Extract PCI capability fields via FIELD_GET() with standardized masks.
> > - Add necessary headers (linux/align.h).
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Hans Zhang <18255117159@163.com>
> > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  drivers/pci/pci.c             | 9 +++++----
> >  include/uapi/linux/pci_regs.h | 3 +++
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b0f4d98036cd..40a5c87d9a6b 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -9,6 +9,7 @@
> >   */
> >  
> >  #include <linux/acpi.h>
> > +#include <linux/align.h>
> >  #include <linux/kernel.h>
> >  #include <linux/delay.h>
> >  #include <linux/dmi.h>
> > @@ -432,17 +433,17 @@ static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
> >  	pci_bus_read_config_byte(bus, devfn, pos, &pos);
> >  
> >  	while ((*ttl)--) {
> > -		if (pos < 0x40)
> > +		if (pos < PCI_STD_HEADER_SIZEOF)
> >  			break;
> > -		pos &= ~3;
> > +		pos = ALIGN_DOWN(pos, 4);
> >  		pci_bus_read_config_word(bus, devfn, pos, &ent);
> >  
> > -		id = ent & 0xff;
> > +		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
> >  		if (id == 0xff)
> >  			break;
> >  		if (id == cap)
> >  			return pos;
> > -		pos = (ent >> 8);
> > +		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
> >  	}
> >  	return 0;
> >  }
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index f5b17745de60..1bba99b46227 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -207,6 +207,9 @@
> >  
> >  /* Capability lists */
> >  
> > +#define PCI_CAP_ID_MASK		0x00ff	/* Capability ID mask */
> > +#define PCI_CAP_LIST_NEXT_MASK	0xff00	/* Next Capability Pointer mask */
> > +
> >  #define PCI_CAP_LIST_ID		0	/* Capability ID */
> >  #define  PCI_CAP_ID_PM		0x01	/* Power Management */
> >  #define  PCI_CAP_ID_AGP		0x02	/* Accelerated Graphics Port */
> 
> Hi Hans,
> 
> I like your approach to replace the magic numbers here. If you went
> further to replace the single pci_bus_read_config_word() with two
> single-byte reads at the appropriate places - for CAP_ID and
> CAP_LIST_NEXT - you could even go with the already existing offset
> defines PCI_CAP_LIST_ID and PCI_CAP_LIST_NEXT from pci_regs.h.
>
> But that might be a more intricate change and involves more HW accesses
> than what it's worth.

Hi,

As you noted, it'll be less efficient so it's undesirable to split the 
read.

It's somewhat problematic that some of the defines in 
include/uapi/linux/pci_regs.h cannot be easily used efficiently with 
multi-byte reads leading to use of literals in code.

IMO, adding the multi-byte masks like this Hans' change is IMO the correct 
way to address it.

> So feel free to add my
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> 
> Thanks,
> Gerd
> 

-- 
 i.


