Return-Path: <linux-pci+bounces-3478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48132855CAE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 09:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9CCFB30D8C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358D11183;
	Thu, 15 Feb 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BWXspkJo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB75134C3
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986234; cv=none; b=X1ZprqoGq4Wk6Cm/gfLe+U36KI27KzsE9Vg9Rt7wZDLhpShAgJ6rN2nIV0w0pDGINHHf78/pHS171pI1BMSw3QP0q75OV6B9Q3wh4PuUhJJqiW9wg/Bn2NjShvwWHhVdIJ+O+/5zRu6XjSwCyN6Z9lTni0ky55rkLco6Q8v2Sg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986234; c=relaxed/simple;
	bh=aD4TuNBSfrmec1g1U2kSzpEwzyiwxJCOb5xx42bvHGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pst50VIXLjyHCkvGGtb5PQBLhIZ+ZVkRtcxfIhVEwMYp54cvKqLvFfzOIy2AOqPno5tgujsu24b5wg5M0FhqWf2ChET5rh3+0ZLRy2Xmr3DsKWQyBrAjkVHScVGGAZV9LmJ+qdI162DfDK4gpP2x7+5ddTqnxXxNYhGceMgd0S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=BWXspkJo; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0e521de4eso7007751fa.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 00:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1707986231; x=1708591031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p0Tr3DlNIUsbNl7Zybl/OUv7Beh0KoEzVQNaV1wEscA=;
        b=BWXspkJoYt26/GW5ODk2Pc8EEht/yohjO98jASlXvyJrZpKVep3orRf2hIm2dK1UOG
         5p6H1rY/FJR68brh4GPG69nnU9bUd/7R07Q9i1dqcQUsT5ILCGM1A4LjRgR7KFDekC8x
         bSy0WAud39Na6SBEyS5GVFCPxmhhZIXTmrdEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707986231; x=1708591031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0Tr3DlNIUsbNl7Zybl/OUv7Beh0KoEzVQNaV1wEscA=;
        b=DRUlyoAEfy4rd0CvDL8vSQZB48GaUAOMrtTonc2ir9nWYYz8+939IDcDeYSIUGOz1r
         BoHEY02vUjerKAV6djGPCBYDWRBomTa37B1FPblvh3aK6UlMqO+yDlh1yZovyBPkQceI
         hhYQ2c5PEMoUVO8DnLsp+PUA9N6cr/7m3jvShffWmlSSDhuxBgvtVjlpuIp+ZUSEZtBm
         aIlA8R0rUuTB7k1J4uy+bOoXWmUe5w9l+DqRgaT7sXgQtnSjStJeZkQi7PzwvNMxL8qK
         VK2bK7OrNcPl/HrCsO5JLDwetn78/NjoH/YLv40vbYQuz7h/URwXX7IjqCcB9rgUrstx
         cZaw==
X-Forwarded-Encrypted: i=1; AJvYcCXE9ydpZBvC+sK+V1NXRLBAt8uURVs2fah0mMEObG+bIKsVTSjwnBQCSQBOCiunzoX2YfqYnNk5d29VyKn0Qdg0Uica3gla7awd
X-Gm-Message-State: AOJu0YxNptP1VewERvOmIzZGca5spMBbebuvRdyulX54bWfHwgAS9ibq
	GO9xTq2XZEOUT3WUEbjfYHvSkBKouQPVNnc5eExFMo1UgPpdjC+SElCWgiPsP8E=
X-Google-Smtp-Source: AGHT+IG6L8UDyDxpMu9X27hfF38b95OqoJaWrWoeoQPrfZTqYcZ+N/S/qJDlQGyYvbnfKjPT22kAlw==
X-Received: by 2002:a2e:a9a0:0:b0:2d0:fe83:bc87 with SMTP id x32-20020a2ea9a0000000b002d0fe83bc87mr1234033ljq.10.1707986230631;
        Thu, 15 Feb 2024 00:37:10 -0800 (PST)
Received: from localhost ([213.195.118.74])
        by smtp.gmail.com with ESMTPSA id g8-20020a05620a108800b00785d6c811cdsm420962qkk.70.2024.02.15.00.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 00:37:10 -0800 (PST)
Date: Thu, 15 Feb 2024 09:37:08 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <Zc3NNOEN-NPR9jjI@macbook>
References: <ZcnhOEjnTgbYFPVl@macbook>
 <20240212191858.GA1137351@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212191858.GA1137351@bhelgaas>

On Mon, Feb 12, 2024 at 01:18:58PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 12, 2024 at 10:13:28AM +0100, Roger Pau Monné wrote:
> > On Fri, Feb 09, 2024 at 03:05:49PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Feb 01, 2024 at 09:39:49AM +0100, Roger Pau Monné wrote:
> > > > On Wed, Jan 31, 2024 at 01:00:14PM -0600, Bjorn Helgaas wrote:
> > > > > On Wed, Jan 31, 2024 at 09:58:19AM +0100, Roger Pau Monné wrote:
> > > > > > On Tue, Jan 30, 2024 at 02:44:03PM -0600, Bjorn Helgaas wrote:
> > > > > > > On Tue, Jan 30, 2024 at 10:07:36AM +0100, Roger Pau Monné wrote:
> > > > > > > > On Mon, Jan 29, 2024 at 04:01:13PM -0600, Bjorn Helgaas wrote:
> > > > > > > > > On Thu, Jan 25, 2024 at 07:17:24AM +0000, Chen, Jiqian wrote:
> > > > > > > > > > On 2024/1/24 00:02, Bjorn Helgaas wrote:
> > > > > > > > > > > On Tue, Jan 23, 2024 at 10:13:52AM +0000, Chen, Jiqian wrote:
> > > > > > > > > > >> On 2024/1/23 07:37, Bjorn Helgaas wrote:
> > > > > > > > > > >>> On Fri, Jan 05, 2024 at 02:22:17PM +0800, Jiqian Chen wrote:
> > > > > > > > > > >>>> There is a need for some scenarios to use gsi sysfs.
> > > > > > > > > > >>>> For example, when xen passthrough a device to dumU, it will
> > > > > > > > > > >>>> use gsi to map pirq, but currently userspace can't get gsi
> > > > > > > > > > >>>> number.
> > > > > > > > > > >>>> So, add gsi sysfs for that and for other potential scenarios.
> > > > > > > > > > >> ...
> > > > > > > > > > > 
> > > > > > > > > > >>> I don't know enough about Xen to know why it needs the GSI in
> > > > > > > > > > >>> userspace.  Is this passthrough brand new functionality that can't be
> > > > > > > > > > >>> done today because we don't expose the GSI yet?
> > > > > > > > > 
> > > > > > > > > I assume this must be new functionality, i.e., this kind of
> > > > > > > > > passthrough does not work today, right?
> > > > > > > > > 
> > > > > > > > > > >> has ACPI support and is responsible for detecting and controlling
> > > > > > > > > > >> the hardware, also it performs privileged operations such as the
> > > > > > > > > > >> creation of normal (unprivileged) domains DomUs. When we give to a
> > > > > > > > > > >> DomU direct access to a device, we need also to route the physical
> > > > > > > > > > >> interrupts to the DomU. In order to do so Xen needs to setup and map
> > > > > > > > > > >> the interrupts appropriately.
> > > > > > > > > > > 
> > > > > > > > > > > What kernel interfaces are used for this setup and mapping?
> > > > > > > > > >
> > > > > > > > > > For passthrough devices, the setup and mapping of routing physical
> > > > > > > > > > interrupts to DomU are done on Xen hypervisor side, hypervisor only
> > > > > > > > > > need userspace to provide the GSI info, see Xen code:
> > > > > > > > > > xc_physdev_map_pirq require GSI and then will call hypercall to pass
> > > > > > > > > > GSI into hypervisor and then hypervisor will do the mapping and
> > > > > > > > > > routing, kernel doesn't do the setup and mapping.
> > > > > > > > > 
> > > > > > > > > So we have to expose the GSI to userspace not because userspace itself
> > > > > > > > > uses it, but so userspace can turn around and pass it back into the
> > > > > > > > > kernel?
> > > > > > > > 
> > > > > > > > No, the point is to pass it back to Xen, which doesn't know the
> > > > > > > > mapping between GSIs and PCI devices because it can't execute the ACPI
> > > > > > > > AML resource methods that provide such information.
> > > > > > > > 
> > > > > > > > The (Linux) kernel is just a proxy that forwards the hypercalls from
> > > > > > > > user-space tools into Xen.
> > > > > > > 
> > > > > > > But I guess Xen knows how to interpret a GSI even though it doesn't
> > > > > > > have access to AML?
> > > > > > 
> > > > > > On x86 Xen does know how to map a GSI into an IO-APIC pin, in order
> > > > > > configure the RTE as requested.
> > > > > 
> > > > > IIUC, mapping a GSI to an IO-APIC pin requires information from the
> > > > > MADT.  So I guess Xen does use the static ACPI tables, but not the AML
> > > > > _PRT methods that would connect a GSI with a PCI device?
> > > > 
> > > > Yes, Xen can parse the static tables, and knows the base GSI of
> > > > IO-APICs from the MADT.
> > > > 
> > > > > I guess this means Xen would not be able to deal with _MAT methods,
> > > > > which also contains MADT entries?  I don't know the implications of
> > > > > this -- maybe it means Xen might not be able to use with hot-added
> > > > > devices?
> > > > 
> > > > It's my understanding _MAT will only be present on some very specific
> > > > devices (IO-APIC or CPU objects).  Xen doesn't support hotplug of
> > > > IO-APICs, but hotplug of CPUs should in principle be supported with
> > > > cooperation from the control domain OS (albeit it's not something that
> > > > we tests on our CI).  I don't expect however that a CPU object _MAT
> > > > method will return IO APIC entries.
> > > > 
> > > > > The tables (including DSDT and SSDTS that contain the AML) are exposed
> > > > > to userspace via /sys/firmware/acpi/tables/, but of course that
> > > > > doesn't mean Xen knows how to interpret the AML, and even if it did,
> > > > > Xen probably wouldn't be able to *evaluate* it since that could
> > > > > conflict with the host kernel's use of AML.
> > > > 
> > > > Indeed, there can only be a single OSPM, and that's the dom0 OS (Linux
> > > > in our context).
> > > > 
> > > > Getting back to our context though, what would be a suitable place for
> > > > exposing the GSI assigned to each device?
> > > 
> > > IIUC, the Xen hypervisor:
> > > 
> > >   - Interprets /sys/firmware/acpi/tables/APIC (or gets this via
> > >     something running on the Dom0 kernel) to find the physical base
> > >     address and GSI base, e.g., from I/O APIC, I/O SAPIC.
> > 
> > No, Xen parses the MADT directly from memory, before stating dom0.
> > That's a static table so it's fine for Xen to parse it and obtain the
> > I/O APIC GSI base.
> 
> It's an interesting split to consume ACPI static tables directly but
> put the AML interpreter elsewhere.

Well, static tables can be consumed by Xen, because thye don't require
an AML parser (obviously), and parsing them doesn't have any
side-effects that would prevent dom0 from being the OSPM (no methods
or similar are evaluated).

> I doubt the ACPI spec envisioned
> that, which makes me wonder what other things we could trip over, but
> that's just a tangent.

Indeed, ACPI is not be best interface for the Xen/dom0 split model.

> > >   - Needs the GSI to locate the APIC and pin within the APIC.  The
> > >     Dom0 kernel is the OSPM, so only it can evaluate the AML _PRT to
> > >     learn the PCI device -> GSI mapping.
> > 
> > Yes, Xen doesn't know the PCI device -> GSI mapping.  Dom0 needs to
> > parse the ACPI methods and signal Xen to configure a GSI with a
> > given trigger and polarity.
> > 
> > >   - Has direct access to the APIC physical base address to program the
> > >     Redirection Table.
> > 
> > Yes, the hardware (native) I/O APIC is owned by Xen, and not directly
> > accessible by dom0.
> > 
> > > The patch seems a little messy to me because the PCI core has to keep
> > > track of the GSI even though it doesn't need it itself.  And the
> > > current patch exposes it on all arches, even non-ACPI ones or when
> > > ACPI is disabled (easily fixable).
> > > 
> > > We only call acpi_pci_irq_enable() in the pci_enable_device() path, so
> > > we don't know the GSI unless a Dom0 driver has claimed the device and
> > > called pci_enable_device() for it, which seems like it might not be
> > > desirable.
> > 
> > I think that's always the case, as on dom0 devices to be passed
> > through are handled by pciback which does enable them.
> 
> pcistub_init_device() labels the pci_enable_device() as a "HACK"
> related to determining the IRQ, which makes me think there's not
> really a requirement for the device to be *enabled* (BAR decoding
> enabled) by dom0.

No, there's no need for memory decoding to be enabled for getting the
GSI from the ACPI method I would assume.  I'm confused by that
pci_enable_device() call.  Is maybe the purpose to make sure the
device is powered up so that reading the PCI header Interrupt Line and
Pin fields returns valid values?  No idea whether reading those fields
requires the device to be in certain (active) power states.

> > I agree it might be best to not tie exposing the node to
> > pci_enable_device() having been called.  Is _PRT only evaluated as
> > part of acpi_pci_irq_enable()? (or pci_enable_device()).
> 
> Yes.  AFAICT, acpi_pci_irq_enable() is the only path that evaluates
> _PRT (except for a debugger interface).  I don't think it *needs* to
> be that way, and the fact that we do it per-device like that means we
> evaluate _PRT many times even though I think the results never change.
> 
> I could imagine evaluating _PRT once as part of enumerating a PCI host
> bridge (and maybe PCI-PCI bridge, per acpi_pci_irq_find_prt_entry()
> comment), but that looks like a fair bit of work to implement.  And of
> course it doesn't really affect the question of how to expose the
> result, although it does suggest /sys/bus/acpi/devices/PNP0A03:00/ as
> a possible location.

So you suggest exposing the GSI as part of the PCI host bridge?  I'm
afraid I'm not following how we could then map PCI SBDFs from devices
to their assigned GSI.

Thanks, Roger.

