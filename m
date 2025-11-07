Return-Path: <linux-pci+bounces-40585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8419C40930
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 16:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727EE423D95
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522562C3258;
	Fri,  7 Nov 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRF8DAfe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997943AA6;
	Fri,  7 Nov 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529149; cv=none; b=YGgsdp8YON6KnIruL6LYPFa9NXAM115Ao10DhpNoII3XpIF10uo/yXsm4Bc5dSpi2I7MCUK1ZKQpDpwZEN95mW/4eKzgzwuxANk4X8CwHq+awIZ10NYqi+s33vNEW2AOZhp8tHIo9GSnsrRzR5NUS0d/pSsQ5H1gWs/tNDMCAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529149; c=relaxed/simple;
	bh=02om1vHeyZwGMIMBSLhYVHI4vekhj/hDXVqaAGTaRb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M/Bomj6AS3nZtlxeq4sn4kklEPgKWP+ug3ZRkhHgkB0HHku5kHh1k2tXlRxTjid4m1zqYeC9OEwB6aj2+fsKJV0NAAGJCRZcMsFyFex92rGXHnq64XkQfiCon5rVO0IiuEanfY2RsgjIfzN8SMW5Ak9Ryi/AK99JqBnkmT8pIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRF8DAfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D386C4CEF7;
	Fri,  7 Nov 2025 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762529148;
	bh=02om1vHeyZwGMIMBSLhYVHI4vekhj/hDXVqaAGTaRb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TRF8DAfeP1FRnLZkPGRCooI/SbGKUFf2sXqBTy73FxI/w3uLNiqGlPB+YtdbErEsa
	 FHRT1EOCI6FKIbyMgcZ2/SXRLgCJYzp+WMYUOzVgogq2g3nwOpQbATUK0HyFPKZAOa
	 ack/Hw+l6Q1CA7z0AEmf9VKR9RmqeLvueeeGZxbkXvsWLez6kF1k3C1vwzMEa3j1fh
	 NIGCLKlGbK7ouBbayfER4k4Ut0siSqxMUBjE2JGMZ3LD7M+xGRjA003CGeCxO40iyQ
	 IyBKh0XDj4WwUyHH6AfmSWs0kvtDXjtesPcIelaInaCOWNpMhAm1+FTFJgG8E2lb1S
	 U7y5SY5hM/XcQ==
Date: Fri, 7 Nov 2025 09:25:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Cache Link Capabilities so quirks can
 override them
Message-ID: <20251107152547.GA1998555@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ2EXqDvnxjyXq_7@wunner.de>

On Fri, Nov 07, 2025 at 06:32:14AM +0100, Lukas Wunner wrote:
> On Thu, Nov 06, 2025 at 12:36:38PM -0600, Bjorn Helgaas wrote:
> > Cache the PCIe Link Capabilities register in struct pci_dev so quirks can
> > remove features to avoid hardware defects.  The idea is:
> > 
> >   - set_pcie_port_type() reads PCIe Link Capabilities and caches it in
> >     dev->lnkcap
> > 
> >   - HEADER quirks can update the cached dev->lnkcap to remove advertised
> >     features that don't work correctly
> > 
> >   - pcie_aspm_cap_init() relies on dev->lnkcap and ignores any features not
> >     advertised there
> 
> I realize that memory is cheap, but it still feels a bit wasteful
> to cache the entire 32-bit register wholesale.  It contains
> reserved bits as of PCIe r7.0, various uninteresting bits and
> portions of it are already cached elsewhere and thus now duplicated.
> I'm wondering if it would make sense to instead only cache the ASPM bits
> that are relevant here?  That's the approach we've followed so far.

My first try (which I didn't post) cached only the two bits we need
for this.  It's not awful, and the aspm.c patch was smaller, so maybe
it's the right approach, at least for v6.18.

One thing I didn't like about pci_disable_aspm_cap() (which I know you
said you *did* like :)) is that it adds a layer of indirection.  I
like having PCI_EXP_LNKCAP_ASPM_L0S in the quirk because it's more
directly connected to the spec and the hardware register, and grep
works better for code readers.

But if we only cache the ASPM cap bits, we would need
pci_disable_aspm_cap() to manage converting PCI_EXP_LNKCAP_ASPM_L0S or
PCIE_LINK_STATE_L0S to the right place.

(A bit of a tangent, but I've never liked the PCIE_LINK_STATE_* bits
because they look like they ought to be register bits, but they're
not.  I think the code would be improved overall if we could remove
them.)

> You're initializing the link_active_reporting bit from the newly
> cached lnkcap register, I'd prefer having a static inline instead
> which extracts the bit from the cached register on demand,
> thus obviating the need to have a duplicate cached copy of the bit.
> 
> pci_set_bus_speed() caches bus->max_bus_speed from the Link
> Capabilities register and isn't converted by this patch to use
> the cached register.  There are various others, e.g.
> get_port_device_capability() in drivers/pci/pcie/portdrv.c
> could also get PCI_EXP_LNKCAP_LBNC from the cached lnkcap
> register.  Same for pcie_get_supported_speeds().  If the
> intention is to convert these in a separate step in v6.19,
> it would be good to mention that in the changelog.

I agree with all of that, and there are several other PCI_EXP_LNKCAP
reads that could be replaced, but that would have to be for v6.19.

Bjorn

