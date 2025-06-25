Return-Path: <linux-pci+bounces-30583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D1DAE7AAF
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630B31BC0479
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD128DF3D;
	Wed, 25 Jun 2025 08:45:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501828A1D4;
	Wed, 25 Jun 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841144; cv=none; b=gt6qPTOJ3U9pXjTPEyxwFAG+eN9AtXALV08NPyXDe8arMO+qdRiSY3uSEaBxAJI87CbndXWXo2wW+PDeVoRnV8GqRfUOy1axH7xT6LcLYoKle8wTrS6i8FmleaqApGfmL0/aZ3C4NPIYB9Ym0zvBQyEDU0M3HmVINU/S3LRJ170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841144; c=relaxed/simple;
	bh=C1O7OsyYahrbb5xTlS/F31FLcQAAo/jwL30cSWQC9g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8RLUSU5huk8Ds4ZQCwcOmIp1mXSs18eI2cn+4TDx9/2/KpLWLhBdMkoiXbAhGccIFxNL1zbEZxMvvYvsrXMa9HxfgoyOqoCMc+d4m3jQia/KqRRJvZLRk8B1etB3imF9YeBoBqcd/jFsnMNphMUqYn02+QZzL1eS6CzsZkehVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 904BB2C05264;
	Wed, 25 Jun 2025 10:45:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 477423B709D; Wed, 25 Jun 2025 10:45:38 +0200 (CEST)
Date: Wed, 25 Jun 2025 10:45:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with
 broken
Message-ID: <aFu3Mg9SqlaDTw9z@wunner.de>
References: <20250618201722.GA1220739@bhelgaas>
 <1155677312.1313623.1750361373491.JavaMail.zimbra@raptorengineeringinc.com>
 <aFUTV87SMdpHRbt8@wunner.de>
 <318974284.1316210.1750437945118.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <318974284.1316210.1750437945118.JavaMail.zimbra@raptorengineeringinc.com>

On Fri, Jun 20, 2025 at 11:45:45AM -0500, Timothy Pearson wrote:
> From: "Lukas Wunner" <lukas@wunner.de>
> > I don't know how much PCIe hotplug on PowerNV differs from native,
> > spec-compliant PCIe hotplug.  If the differences are vast (and I
> > get the feeling they might be if I read terms like "PHB" and
> > "EEH unfreeze", which sound completely foreign to me), it might
> > be easier to refactor pnv_php.c and copy patterns or code from
> > pciehp, than to integrate the functionality from pnv_php.c into
> > pciehp.
> 
> The differences at the root level (PHB) are quite significant -- the
> controller is more advanced in many ways than standard PCIe root
> complexes [1] -- and those differences need very special handling.
> Once we are looking at devices downstream of the root complex,
> standard PCIe hotplug and AER specifications apply, so we're in a
> strange spot of really wanting to use pciehp (to handle all nested
> downstream bridges), but pciehp still needs to understand how to deal
> with our unqiue root complex.
> 
> One idea I had was to use the existing modularity of pciehp's source
> and add a new pciehp_powernv.c file with all of our root complex
> handling methods.  We could then #ifdef swap the assocated root complex
> calls to that external file when compiled in PowerNV mode.

We've traditionally dealt with such issues by inserting pcibios_*()
hooks in generic code, with a __weak implementation (which is usually
an empty stub) and a custom implementation in arch/powerpc/.

The linker then chooses the custom implementation over the __weak one.

You can find the existing hooks with:

git grep "__weak .*pcibios" -- drivers/pci
git grep pcibios -- arch/powerpc

An alternative method is to add a callback to struct pci_host_bridge.

> > One thing I don't quite understand is, it sounds like you've
> > attached a PCIe switch to a Root Port and the hotplug ports
> > are on the PCIe switch.  Aren't those hotplug ports just
> > bog-standard ones that can be driven by pciehp?  My expectation
> > would have been that a PowerNV-specific hotplug driver would
> > only be necessary for hotplug-capable Root Ports.
> 
> That's the problem -- the pciehp driver assumes x86 root ports,

Nah, there's nothing x86-specific about it.  pciehp is used on all
kinds of arches, it's just an implementation of the PCIe Base Spec.

> and the powernv driver ends up duplicating (badly) parts of the pciehp
> functionality for downstream bridges.  That's one reason I'd like to
> abstract the root port handling in pciehp and eventually move the
> PowerNV root port handling into that module.

Sounds like you're currently describing the Switch Downstream Ports with
an "ibm,ioda-phb2" compatible string in the devicetree?  That would feel
wrong since they're not host bridges.

> [1] Among other interesting differences, it is both capable of and has
> been tested to properly block and report all invalid accesses from a
> PCIe device to system memory.  This breaks assumptions in many PCIe
> device drivers, but is also a significant security advantage.
> EEH freeze is effectively this security mechanism kicking in -- on
> detecting an invalid access, the PHB itself will block the access and
> put the PE into a frozen state where no PCIe traffic is permitted.

That sounds somewhat similar to what the PCIe Access Control Services
Capability provides.  I think at least some IOMMUs support raising an
exception on illegal accesses, so the EEH functionality is probably not
*that* special.

Thanks,

Lukas

