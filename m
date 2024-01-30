Return-Path: <linux-pci+bounces-2841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BAF842E1B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 21:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6197D1F25A6B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DF479DD3;
	Tue, 30 Jan 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3Am/ZUF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6555E6B;
	Tue, 30 Jan 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647445; cv=none; b=RIWSysdzF7yfPSW8Kvud1ZrYObdBiaJKFqxJ5RyAsxE7DTgYn0ClGVLqAe5E5VseyIGCTAdPcJgvzRfB451iNVIYug+6R4sOGflQCI4LhaMM6wtlv0kZ3Zf31wmMii9+8w23FikEVgSEIBGBeN9SbZYMfUbLQkn5GhrIudeYzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647445; c=relaxed/simple;
	bh=bPw6ruebyasCXorT1LdxWx1GajiUvbLKrTDw9DFK5FA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dHRxn6Jn+lZoPm0BJZL/P1o9RgsZjiSDL4ITbfhrSYYdbq0q/A2NLYCaoZbBPoGzYu4ImusDLta3CYEBK3oO4I/woOJ97aTjasjC+gJQ5S2YtrXXBOGBCoTue6+3kFAmGuoaPjgGryNMdn+0LY1XT/wJB23fYl+/asvyCwknga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3Am/ZUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EBFC433F1;
	Tue, 30 Jan 2024 20:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647444;
	bh=bPw6ruebyasCXorT1LdxWx1GajiUvbLKrTDw9DFK5FA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r3Am/ZUFJ5LvciFl7LpCgQQZ28jpBwPyRmGVj9C9/vS9yk40Aa7U+KC6hq/oO2B7n
	 wDQJ8uK7Ltr51lQF8BQiAA8Skty5QBeFsH0/3E1VTaUey75oUEjjsZccrwn+o0MZeE
	 Miv8UzxNckXMSMLvDHFGUgNXH0sZypZ7xRpaMpeTurT916gRzkt54hEEq2RxhsCyxH
	 s9nK0ukGPiRl9D3B/hcIKbaI2t/XGCd1zfkzJo3hNN89BP3waa48nxA5jOnij4C3r2
	 kY5KfQ5U4IsSneu4O25TjKls3lCrZLcTzm7OdlZZdjiu5xgCsOncdeDuXSXJQsxfgP
	 3wdiZdO2KG//w==
Date: Tue, 30 Jan 2024 14:44:03 -0600
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
Message-ID: <20240130204403.GA562912@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbi8WJPEUSMgjuVY@macbook>

On Tue, Jan 30, 2024 at 10:07:36AM +0100, Roger Pau Monné wrote:
> On Mon, Jan 29, 2024 at 04:01:13PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 25, 2024 at 07:17:24AM +0000, Chen, Jiqian wrote:
> > > On 2024/1/24 00:02, Bjorn Helgaas wrote:
> > > > On Tue, Jan 23, 2024 at 10:13:52AM +0000, Chen, Jiqian wrote:
> > > >> On 2024/1/23 07:37, Bjorn Helgaas wrote:
> > > >>> On Fri, Jan 05, 2024 at 02:22:17PM +0800, Jiqian Chen wrote:
> > > >>>> There is a need for some scenarios to use gsi sysfs.
> > > >>>> For example, when xen passthrough a device to dumU, it will
> > > >>>> use gsi to map pirq, but currently userspace can't get gsi
> > > >>>> number.
> > > >>>> So, add gsi sysfs for that and for other potential scenarios.
> > > >> ...
> > > > 
> > > >>> I don't know enough about Xen to know why it needs the GSI in
> > > >>> userspace.  Is this passthrough brand new functionality that can't be
> > > >>> done today because we don't expose the GSI yet?
> > 
> > I assume this must be new functionality, i.e., this kind of
> > passthrough does not work today, right?
> > 
> > > >> has ACPI support and is responsible for detecting and controlling
> > > >> the hardware, also it performs privileged operations such as the
> > > >> creation of normal (unprivileged) domains DomUs. When we give to a
> > > >> DomU direct access to a device, we need also to route the physical
> > > >> interrupts to the DomU. In order to do so Xen needs to setup and map
> > > >> the interrupts appropriately.
> > > > 
> > > > What kernel interfaces are used for this setup and mapping?
> > >
> > > For passthrough devices, the setup and mapping of routing physical
> > > interrupts to DomU are done on Xen hypervisor side, hypervisor only
> > > need userspace to provide the GSI info, see Xen code:
> > > xc_physdev_map_pirq require GSI and then will call hypercall to pass
> > > GSI into hypervisor and then hypervisor will do the mapping and
> > > routing, kernel doesn't do the setup and mapping.
> > 
> > So we have to expose the GSI to userspace not because userspace itself
> > uses it, but so userspace can turn around and pass it back into the
> > kernel?
> 
> No, the point is to pass it back to Xen, which doesn't know the
> mapping between GSIs and PCI devices because it can't execute the ACPI
> AML resource methods that provide such information.
> 
> The (Linux) kernel is just a proxy that forwards the hypercalls from
> user-space tools into Xen.

But I guess Xen knows how to interpret a GSI even though it doesn't
have access to AML?

> > It seems like it would be better for userspace to pass an identifier
> > of the PCI device itself back into the hypervisor.  Then the interface
> > could be generic and potentially work even on non-ACPI systems where
> > the GSI concept doesn't apply.
> 
> We would still need a way to pass the GSI to PCI device relation to
> the hypervisor, and then cache such data in the hypervisor.
> 
> I don't think we have any preference of where such information should
> be exposed, but given GSIs are an ACPI concept not specific to Xen
> they should be exposed by a non-Xen specific interface.

AFAIK Linux doesn't expose GSIs directly to userspace yet.  The GSI
concept relies on ACPI MADT, _MAT, _PRT, etc.  A GSI is associated
with some device (PCI in this case) and some interrupt controller
entry.  I don't understand how a GSI value is useful without knowing
something about that framework in which GSIs exist.

Obviously I know less than nothing about Xen, so I apologize for
asking all these stupid questions, but it just doesn't all make sense
to me yet.

Bjorn

