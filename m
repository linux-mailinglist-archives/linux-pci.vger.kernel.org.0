Return-Path: <linux-pci+bounces-2893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F938447A9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 20:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25081F24B93
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412333CFD;
	Wed, 31 Jan 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIRJHCGN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639333986;
	Wed, 31 Jan 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727617; cv=none; b=e/3gufGBzG+B/JKMelw3XjnXaq17rpGrczVrOX1twQEy1Fzchea43qxHb28D19KeWEQB8HBUPPJCXQsA2yPTamtIp8sGUMq0ZSV5vWZos8WZGDVL/HxjtAmyo/SpdIJWfSqhsxBtIYe7h/jcr+NvrdSYTSWLdL0YMkmusafEGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727617; c=relaxed/simple;
	bh=RZdHkRM3P7+WME/mIEGs7U7h1w50IFiQNWO97QIu6Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G4HJwACEeHLyWJSoq9kkL5Bl+Y1hE0D282DkNGTS2LXAf5PHdu04Bn3diTZLU0UbD5o0FSlHTVz/aweeVg7zrPADpETUCJKtFUSaitTZ2cJ8bobY1MG4Xshafox93Z3wfDqGO0nnvP52VYY7Gazb92E986jWphz+8FKKK5qWPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIRJHCGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AACC433C7;
	Wed, 31 Jan 2024 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706727616;
	bh=RZdHkRM3P7+WME/mIEGs7U7h1w50IFiQNWO97QIu6Z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SIRJHCGNDMqwVTzRAiLrMLdW+dkYsjK+l0LHXCGERVCfoMi4e2t93JIYx850Va7QT
	 BGvQ2bGkqPTQRCl08dsckmMG7/8X12XOBXbK/ovMyyVPfJWNUVnHe4dp7gy6ykv8CN
	 bbmRt1hMy9UMLho79aKU5ClxkjxcbodVDj4H68/s0G4OCEb5EFsiQ6G/TjsjcS9XwS
	 0JDjS+avkmcF/DbbTUZyvaT110hm0lLajDCvJQVQb3ZcwFKSKf215b+9OYbl+q+WsI
	 O7PdE1/KIhQ2AvACX37JV3KKiBwj+QSeRJjr5YGhPc8ajcZCnRUiVvuGrGs5L+oyeo
	 DyWkc5iLaAjQg==
Date: Wed, 31 Jan 2024 13:00:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: "Chen, Jiqian" <Jiqian.Chen@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>
Subject: Re: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Message-ID: <20240131190014.GA593286@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZboLq6kZhwpUC_c3@macbook>

On Wed, Jan 31, 2024 at 09:58:19AM +0100, Roger Pau Monné wrote:
> On Tue, Jan 30, 2024 at 02:44:03PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 30, 2024 at 10:07:36AM +0100, Roger Pau Monné wrote:
> > > On Mon, Jan 29, 2024 at 04:01:13PM -0600, Bjorn Helgaas wrote:
> > > > On Thu, Jan 25, 2024 at 07:17:24AM +0000, Chen, Jiqian wrote:
> > > > > On 2024/1/24 00:02, Bjorn Helgaas wrote:
> > > > > > On Tue, Jan 23, 2024 at 10:13:52AM +0000, Chen, Jiqian wrote:
> > > > > >> On 2024/1/23 07:37, Bjorn Helgaas wrote:
> > > > > >>> On Fri, Jan 05, 2024 at 02:22:17PM +0800, Jiqian Chen wrote:
> > > > > >>>> There is a need for some scenarios to use gsi sysfs.
> > > > > >>>> For example, when xen passthrough a device to dumU, it will
> > > > > >>>> use gsi to map pirq, but currently userspace can't get gsi
> > > > > >>>> number.
> > > > > >>>> So, add gsi sysfs for that and for other potential scenarios.
> > > > > >> ...
> > > > > > 
> > > > > >>> I don't know enough about Xen to know why it needs the GSI in
> > > > > >>> userspace.  Is this passthrough brand new functionality that can't be
> > > > > >>> done today because we don't expose the GSI yet?
> > > > 
> > > > I assume this must be new functionality, i.e., this kind of
> > > > passthrough does not work today, right?
> > > > 
> > > > > >> has ACPI support and is responsible for detecting and controlling
> > > > > >> the hardware, also it performs privileged operations such as the
> > > > > >> creation of normal (unprivileged) domains DomUs. When we give to a
> > > > > >> DomU direct access to a device, we need also to route the physical
> > > > > >> interrupts to the DomU. In order to do so Xen needs to setup and map
> > > > > >> the interrupts appropriately.
> > > > > > 
> > > > > > What kernel interfaces are used for this setup and mapping?
> > > > >
> > > > > For passthrough devices, the setup and mapping of routing physical
> > > > > interrupts to DomU are done on Xen hypervisor side, hypervisor only
> > > > > need userspace to provide the GSI info, see Xen code:
> > > > > xc_physdev_map_pirq require GSI and then will call hypercall to pass
> > > > > GSI into hypervisor and then hypervisor will do the mapping and
> > > > > routing, kernel doesn't do the setup and mapping.
> > > > 
> > > > So we have to expose the GSI to userspace not because userspace itself
> > > > uses it, but so userspace can turn around and pass it back into the
> > > > kernel?
> > > 
> > > No, the point is to pass it back to Xen, which doesn't know the
> > > mapping between GSIs and PCI devices because it can't execute the ACPI
> > > AML resource methods that provide such information.
> > > 
> > > The (Linux) kernel is just a proxy that forwards the hypercalls from
> > > user-space tools into Xen.
> > 
> > But I guess Xen knows how to interpret a GSI even though it doesn't
> > have access to AML?
> 
> On x86 Xen does know how to map a GSI into an IO-APIC pin, in order
> configure the RTE as requested.

IIUC, mapping a GSI to an IO-APIC pin requires information from the
MADT.  So I guess Xen does use the static ACPI tables, but not the AML
_PRT methods that would connect a GSI with a PCI device?

I guess this means Xen would not be able to deal with _MAT methods,
which also contains MADT entries?  I don't know the implications of
this -- maybe it means Xen might not be able to use with hot-added
devices?

The tables (including DSDT and SSDTS that contain the AML) are exposed
to userspace via /sys/firmware/acpi/tables/, but of course that
doesn't mean Xen knows how to interpret the AML, and even if it did,
Xen probably wouldn't be able to *evaluate* it since that could
conflict with the host kernel's use of AML.

Bjorn

