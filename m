Return-Path: <linux-pci+bounces-3301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BD884FE1F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 22:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7595B1C23E30
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEF616410;
	Fri,  9 Feb 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwQK9UoM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3907DF55;
	Fri,  9 Feb 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512752; cv=none; b=lfjvpmxRoOoMfJnxUiWRU9JR02VC2t4UneRnpMEia4VTFXYAH665x2vezOmiCsELOte9C1HHBpeA5kJ4L+ZVtsMo8gekEaQzaAwbBuanJ5yN18LLABW/KRD2Zo97OlQNiIiKe7eFoR1sFnBCKR7+PcsVCvN/QPcwyIXWPO1DdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512752; c=relaxed/simple;
	bh=rjVvpgkdjij/VYXtLbzigiHQtkw04AlRvlQ3kPwWPAA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CFP5AwL2L0W3iYXEu43s/ADWv7w19SbB43/jZfV3pICmfpYc/38E7TseFSk26zZVV6t5BgyrHQMuW8zeGzt+EuWjOoF5pxIMZ9gheBEGue1nvJjiudgibv3TX4uoO8A7uZjTPWss8gsZtOfQnzJjxu5DC1Al7zbs6+ZVinNb8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwQK9UoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F711C433C7;
	Fri,  9 Feb 2024 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707512751;
	bh=rjVvpgkdjij/VYXtLbzigiHQtkw04AlRvlQ3kPwWPAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kwQK9UoMLNlCNW4mnILL/fjh6js/5cqzhXmOYR58/NZ49GCoEo35noV1N0Rexcjxg
	 lAo1KlEs60klZiyOyPrxgCKJTJAnrWYuu+tl+4qSVBQtv8xU+/SujJcpOgyxKVu+sh
	 KmtcuwLxpMN1rKL4twh466o9n/Qy3jLRTlt/hdebS8LRqcnolN4XCPDOcKoHGhNyf4
	 g7NULVMt5QtAfP+Hj7xejLKShQinuhM6827OqwAbYFZM0Y8BKAxgPkOfVHljo5k/4h
	 Z2HqW/rZs2uP/V42MoFVA1hXFtNXb0Zhp+pPSPlH//BjNALkVszex5H72/M+Iy1IJB
	 QpisPIJPit19w==
Date: Fri, 9 Feb 2024 15:05:49 -0600
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
Message-ID: <20240209210549.GA884438@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbtY1R15pYZz3F3B@macbook>

On Thu, Feb 01, 2024 at 09:39:49AM +0100, Roger Pau Monné wrote:
> On Wed, Jan 31, 2024 at 01:00:14PM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 31, 2024 at 09:58:19AM +0100, Roger Pau Monné wrote:
> > > On Tue, Jan 30, 2024 at 02:44:03PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Jan 30, 2024 at 10:07:36AM +0100, Roger Pau Monné wrote:
> > > > > On Mon, Jan 29, 2024 at 04:01:13PM -0600, Bjorn Helgaas wrote:
> > > > > > On Thu, Jan 25, 2024 at 07:17:24AM +0000, Chen, Jiqian wrote:
> > > > > > > On 2024/1/24 00:02, Bjorn Helgaas wrote:
> > > > > > > > On Tue, Jan 23, 2024 at 10:13:52AM +0000, Chen, Jiqian wrote:
> > > > > > > >> On 2024/1/23 07:37, Bjorn Helgaas wrote:
> > > > > > > >>> On Fri, Jan 05, 2024 at 02:22:17PM +0800, Jiqian Chen wrote:
> > > > > > > >>>> There is a need for some scenarios to use gsi sysfs.
> > > > > > > >>>> For example, when xen passthrough a device to dumU, it will
> > > > > > > >>>> use gsi to map pirq, but currently userspace can't get gsi
> > > > > > > >>>> number.
> > > > > > > >>>> So, add gsi sysfs for that and for other potential scenarios.
> > > > > > > >> ...
> > > > > > > > 
> > > > > > > >>> I don't know enough about Xen to know why it needs the GSI in
> > > > > > > >>> userspace.  Is this passthrough brand new functionality that can't be
> > > > > > > >>> done today because we don't expose the GSI yet?
> > > > > > 
> > > > > > I assume this must be new functionality, i.e., this kind of
> > > > > > passthrough does not work today, right?
> > > > > > 
> > > > > > > >> has ACPI support and is responsible for detecting and controlling
> > > > > > > >> the hardware, also it performs privileged operations such as the
> > > > > > > >> creation of normal (unprivileged) domains DomUs. When we give to a
> > > > > > > >> DomU direct access to a device, we need also to route the physical
> > > > > > > >> interrupts to the DomU. In order to do so Xen needs to setup and map
> > > > > > > >> the interrupts appropriately.
> > > > > > > > 
> > > > > > > > What kernel interfaces are used for this setup and mapping?
> > > > > > >
> > > > > > > For passthrough devices, the setup and mapping of routing physical
> > > > > > > interrupts to DomU are done on Xen hypervisor side, hypervisor only
> > > > > > > need userspace to provide the GSI info, see Xen code:
> > > > > > > xc_physdev_map_pirq require GSI and then will call hypercall to pass
> > > > > > > GSI into hypervisor and then hypervisor will do the mapping and
> > > > > > > routing, kernel doesn't do the setup and mapping.
> > > > > > 
> > > > > > So we have to expose the GSI to userspace not because userspace itself
> > > > > > uses it, but so userspace can turn around and pass it back into the
> > > > > > kernel?
> > > > > 
> > > > > No, the point is to pass it back to Xen, which doesn't know the
> > > > > mapping between GSIs and PCI devices because it can't execute the ACPI
> > > > > AML resource methods that provide such information.
> > > > > 
> > > > > The (Linux) kernel is just a proxy that forwards the hypercalls from
> > > > > user-space tools into Xen.
> > > > 
> > > > But I guess Xen knows how to interpret a GSI even though it doesn't
> > > > have access to AML?
> > > 
> > > On x86 Xen does know how to map a GSI into an IO-APIC pin, in order
> > > configure the RTE as requested.
> > 
> > IIUC, mapping a GSI to an IO-APIC pin requires information from the
> > MADT.  So I guess Xen does use the static ACPI tables, but not the AML
> > _PRT methods that would connect a GSI with a PCI device?
> 
> Yes, Xen can parse the static tables, and knows the base GSI of
> IO-APICs from the MADT.
> 
> > I guess this means Xen would not be able to deal with _MAT methods,
> > which also contains MADT entries?  I don't know the implications of
> > this -- maybe it means Xen might not be able to use with hot-added
> > devices?
> 
> It's my understanding _MAT will only be present on some very specific
> devices (IO-APIC or CPU objects).  Xen doesn't support hotplug of
> IO-APICs, but hotplug of CPUs should in principle be supported with
> cooperation from the control domain OS (albeit it's not something that
> we tests on our CI).  I don't expect however that a CPU object _MAT
> method will return IO APIC entries.
> 
> > The tables (including DSDT and SSDTS that contain the AML) are exposed
> > to userspace via /sys/firmware/acpi/tables/, but of course that
> > doesn't mean Xen knows how to interpret the AML, and even if it did,
> > Xen probably wouldn't be able to *evaluate* it since that could
> > conflict with the host kernel's use of AML.
> 
> Indeed, there can only be a single OSPM, and that's the dom0 OS (Linux
> in our context).
> 
> Getting back to our context though, what would be a suitable place for
> exposing the GSI assigned to each device?

IIUC, the Xen hypervisor:

  - Interprets /sys/firmware/acpi/tables/APIC (or gets this via
    something running on the Dom0 kernel) to find the physical base
    address and GSI base, e.g., from I/O APIC, I/O SAPIC.

  - Needs the GSI to locate the APIC and pin within the APIC.  The
    Dom0 kernel is the OSPM, so only it can evaluate the AML _PRT to
    learn the PCI device -> GSI mapping.

  - Has direct access to the APIC physical base address to program the
    Redirection Table.

The patch seems a little messy to me because the PCI core has to keep
track of the GSI even though it doesn't need it itself.  And the
current patch exposes it on all arches, even non-ACPI ones or when
ACPI is disabled (easily fixable).

We only call acpi_pci_irq_enable() in the pci_enable_device() path, so
we don't know the GSI unless a Dom0 driver has claimed the device and
called pci_enable_device() for it, which seems like it might not be
desirable.

I was hoping we could put it in /sys/firmware/acpi/interrupts, but
that looks like it's only for SCI statistics.  I guess we could moot a
new /sys/firmware/acpi/gsi/ directory, but then each file there would
have to identify a device, which might not be as convenient as the
/sys/devices/ directory that already exists.  I guess there may be
GSIs for things other than PCI devices; will you ever care about any
of those?

Bjorn

