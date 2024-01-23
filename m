Return-Path: <linux-pci+bounces-2486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 429448393FE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 16:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5551C265FD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CEC6166C;
	Tue, 23 Jan 2024 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwNmB4AN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FB6166B
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025563; cv=none; b=njBHHRz4uSv0oZlDEmaal9DKzrDMKNyHnUK6HfhhvQh37SNfRQTKgOghHs/lmRdXgYEWMRxVyizFs8yLg/0KGtr1aZ4VVrWoM1F9T9GP/glocczEdKY/vaXsfYOIQz3HCzlycql7K8Dg7oQVmvdOIjdswP3mLBs6BXRyyCZKH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025563; c=relaxed/simple;
	bh=Z1ewUysKuYxCB6wsq+stpRYzm1t4ED2X8HpS7b/6Wnw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HXEnggPXg3eP/qQ7oEss4NxwmcHBy53ufV6yd6xsSwpM62F2GTTEbz1Xr0KRmpxZyw+Bzm6MXB3JRAKiXQohCCErdhaX/IpioC22nQlDRLM/2XwrS77tM3Sw/T1nurja/MZKaMCjVmvOo3x6Y9ehFN4qZ6VJyPCxXncv7mz5O1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwNmB4AN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF1CC433F1;
	Tue, 23 Jan 2024 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706025563;
	bh=Z1ewUysKuYxCB6wsq+stpRYzm1t4ED2X8HpS7b/6Wnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mwNmB4ANi3uCwpdZPUUyfQ8E43Jdbh5XE+tMg7qW19cV07XGiIK5wUY+7IIqiKUOF
	 sHJ44Jvub1aLZ4bgNeexXw8X8+f0BEp85nZ9LiVknTPbuWoT4kVq284B8B4OjU7/DN
	 jhI6FbLruMMvTZyS9mkYNHIFfcnrEm76iuSNayOkaswa6OmgPmqdZKiAx+jj3L25uU
	 B+ADQPZwnA/zO7bIg22B0bd4ZtSvWtimGckNGZySFVVfUtRa557vfjhQUO223lXzIX
	 5jcy8NE+7GTMnjaepfNafr9sUQbx8wch9gOMjPX6SJTBm923Otpc+agJYnDLlEB+wU
	 Y5NHfYXGZbNfA==
Date: Tue, 23 Jan 2024 09:59:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Matthew W Carlis <mattc@purestorage.com>, bhelgaas@google.com,
	kbusch@kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de,
	mika.westerberg@linux.intel.com
Subject: Re: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER
 natively.
Message-ID: <20240123155921.GA316585@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97e2a24-80b3-4f0f-ab46-65f20cc811d8@linux.intel.com>

On Mon, Jan 22, 2024 at 06:37:48PM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 1/22/24 11:32 AM, Bjorn Helgaas wrote:
> > On Mon, Jan 08, 2024 at 05:15:08PM -0700, Matthew W Carlis wrote:
> >> A small part is probably historical; we've been using DPC on PCIe
> >> switches since before there was any EDR support in the kernel. It
> >> looks like there was a PCIe DPC ECN as early as Feb 2012, but this
> >> EDR/DPC fw ECN didn't come in till Jan 2019 & kernel support for ECN
> >> was even later. Its not immediately clear I would want to use EDR in
> >> my newer architecures & then there are also the older architecures
> >> still requiring support. When I submitted this patch I came at it
> >> with the approach of trying to keep the old behavior & still support
> >> the newer EDR behavior. Bjorns patch from Dec 28 2023 would seem to
> >> change the behavior for both root ports & switch ports, requiring
> >> them to set _OSC Control Field bit 7 (DPC) and _OSC Support Field
> >> bit 7 (EDR) or a kernel command line value. I think no matter what,
> >> we want to ensure that PCIe Root Ports and PCIe switches arrive at
> >> the same policy here.
> > Is there an approved DPC ECN to the PCI Firmware spec that adds DPC
> > control negotiation, but does *not* add the EDR requirement?
> >
> > I'm looking at
> > https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/12888, which
> > seems to be the final "Downstream Port Containment Related
> > Enhancements" ECN, which is dated 1/28/2019 and applies to the PCI
> > Firmware spec r3.2.
> >
> > It adds bit 7, "PCI Express Downstream Port Containment Configuration
> > control", to the passed-in _OSC Control field, which indicates that
> > the OS supports both "native OS control and firmware ownership models
> > (i.e. Error Disconnect Recover notification) of Downstream Port
> > Containment."
> >
> > It also adds the dependency that "If the OS sets bit 7 of the Control
> > field, it must set bit 7 of the Support field, indicating support for
> > the Error Disconnect Recover event."
> >
> > So I'm trying to figure out if the "support DPC but not EDR" situation
> > was ever a valid place to be.  Maybe it's a mistake to have separate
> > CONFIG_PCIE_DPC and CONFIG_PCIE_EDR options.
> 
> My understanding is also similar. I have raised the same point in
> https://lore.kernel.org/all/3c02a6d6-917e-486c-ad41-bdf176639ff2@linux.intel.com/

Ah, sorry, I missed that.

> IMO, we don't need a separate config for EDR. I don't think user can
> gain anything with disabling EDR and enabling DPC. As long as
> firmware does not user EDR support, just compiling the code should
> be harmless.
> 
> So we can either remove it, or select it by default if user selects
> DPC config.
> 
> > CONFIG_PCIE_EDR depends on CONFIG_ACPI, so the situation is a little
> > bit murky on non-ACPI systems that support DPC.
> 
> If we are going to remove the EDR config, it might need #ifdef
> CONFIG_ACPI changes in edr.c to not compile ACPI specific code.
> Alternative choice is to compile edr.c with CONFIG_ACPI.

Right.  I think we should probably remove CONFIG_PCIE_EDR completely
and make everything controlled by CONFIG_PCIE_DPC.

edr.c only provides two interfaces: pci_acpi_add_edr_notifier() and
pci_acpi_remove_edr_notifier(), which are only used by pci-acpi.c,
which is only compiled if CONFIG_ACPI, so we could probably also
compile edr.c only if CONFIG_ACPI.

And the declarations in include/linux/pci-acpi.h could probably be
moved to drivers/pci/pci.h since they're never used outside
drivers/pci/.

Bjorn

