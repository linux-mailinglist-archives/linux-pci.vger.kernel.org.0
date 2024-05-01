Return-Path: <linux-pci+bounces-6971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475598B8F3E
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AFC283897
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75003146D53;
	Wed,  1 May 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG2moWyU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953E748D;
	Wed,  1 May 2024 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586093; cv=none; b=nd5ULpp5WoeEMgM37+xe/V7FAOcZBRA7ARlDCuEyT14ffJZHXToQmmWk8KIbne3662MIBc6XUsHwj+dYWLBYIMuBk15w+500GrIuYe6Xl6VVKz428hHdOHq80c231WG7bJ3TdTZ9kLJKs5H6FC05dOl122J1hnNCc7Co1kiY6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586093; c=relaxed/simple;
	bh=WFdaQqoj4o2t0Y5iBuDBr4d0ocjoZj27VJCeYzrFM3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nFIpg0jigSGscdoxZpS1B3xQBvn+rODA9x/h/KHMHJsBV/uw+OhD8sOMbajEIPXNA1cH+Kcm3QaGGoWiVL/wOm+CtwFJZeeQQbyWdXz42PhjAMEFVpufgu4jaLUikchEK0B/JLaIA7DHhH5xTkkTMADFywmU9a5pfATY6eafTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG2moWyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912BAC072AA;
	Wed,  1 May 2024 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714586092;
	bh=WFdaQqoj4o2t0Y5iBuDBr4d0ocjoZj27VJCeYzrFM3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EG2moWyU4kRtW+h2fEn6J4OSulwoGt2Aiom3f5PdgUtIl+GWx3d1k0IYeyAUAXEXP
	 EKXUyTl1rte6AMXwY3TT41ewi9Yoq52bfSnn2tgi9eNcdhJUDa+FaSAm3iKg57Mg3q
	 bdeLg901Tjl5f94RnMax2z6uW4wGp6UnHNY95AW4dKh8vFBS6R64USgKgIlftHtAG+
	 8tT8gJ9n3SsDzE839m19MItQ8E0nOZJo3f6Q1WGJKm6dkpUTczh6o9ewK8DHWbJlSZ
	 QoykT5amHFBR1UadJ2ZDhTMrJxRxM4JUMb+75FcH7bhfS4E0VrtUVWOApz1FfcobzN
	 y0YMFK8RK+cJg==
Date: Wed, 1 May 2024 12:54:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: PJ Waskiewicz <ppwaskie@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <20240501175450.GA866742@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5078550384a6b9be5a6d05415ea321332c7fb96.camel@kernel.org>

On Wed, May 01, 2024 at 08:28:22AM -0700, PJ Waskiewicz wrote:
> On Mon, 2024-04-29 at 11:35 -0700, Dan Williams wrote:
> > Bjorn Helgaas wrote:
> > > On Sun, Apr 28, 2024 at 10:57:13PM -0700, PJ Waskiewicz wrote:
> > > > On Tue, 2024-04-09 at 08:22 -0500, Bjorn Helgaas wrote:
> > > > > On Sun, Apr 07, 2024 at 02:05:26PM -0700,
> > > > > ppwaskie@kernel.org wrote:
> > > > > > From: PJ Waskiewicz <ppwaskie@kernel.org>
> > > > > > 
> > > > > > Currently, Type 3 CXL devices (CXL.mem) can train using
> > > > > > host CXL drivers on Emerald Rapids systems.  However, on
> > > > > > some production systems from some vendors, a buggy BIOS
> > > > > > exists that improperly populates the ACPI => PCI mappings.
> > > > > 
> > > > > Can you be more specific about what this ACPI => PCI mapping
> > > > > is?  If you already know what the problem is, I'm sure this
> > > > > is obvious, but otherwise it's not.
> > [..] 
> > > It's just a buggy BIOS that doesn't supply _UID for an ACPI0016
> > > object, so you can't locate the corresponding CEDT entry, right?
> > 
> > Correct, the problem is 100% contained to ACPI, and PCI is
> > innocent.  The ACPI bug leads to failures to associate ACPI
> > host-bridge objects with CEDT.CHBS entries.
> 
> Sorry for the confusion here!!  I was definitely not trying to blame
> PCI.  :)
>
> > ACPI to PCI association is then typical pci_root lookup, i.e.:
> > 
> >         pci_root = acpi_pci_find_root(hb->handle);
> >         bridge = pci_root->bus->bridge;
> 
> Yes, this here.  In my use case, I'm starting with a PCIe/CXL device.
> In my driver, I try to discover the host bridge, and then the ACPI _UID
> so I can look things up in the CEDT.
> 
> So I'm trying to do the programmatic equivalent of this:
> 
> Start here in my PCIe/CXL host driver:
> 
> /sys/devices/pci0000:37/firmware_node =>
> ../LNXSYSTM:00/LNXSYBUS:00/ACPI0016:02
> 
> Retrieve _UID (uid) from /sys/devices/pci0000:37/firmware_node/uid
> 
> Buggy BIOS, that above value resolves to CX02.  In fact, it *should* be
> 49.  This is very much a bug in the ACPI arena.
> 
> The kernel APIs allowing me to walk this path would fail in the
> acpi_evaluate_object() when trying to pass in the bad _UID (CX02).
> 
> Again, sorry for the confusion if it looked like I was trying to
> implicate PCI in any way.  The whole intent here was to leave some
> breadcrumbs so anyone else running into this wouldn't be left
> scratching their heads wondering wtf was going on.


No worries, I didn't suspect a PCI issue here; I just wasn't clear on
what ACPI=>PCI mapping was involved.  It sounds like there *is* no
such mapping in this picture (you find the ACPI object for a PCIe/CXL
host bridge, evaluate _UID from that object, and get a bogus value).

So the commit log text:

  However, on some production systems from some vendors, a buggy BIOS
  exists that improperly populates the ACPI => PCI mappings.

apparently refers to improper implementation of the _UID, which
doesn't return anything PCI related.

It also says:

  This leads to the cxl_acpi driver to fail probe when it cannot find
  the root port's _UID, in order to look up the device's CXL
  attributes in the CEDT.

I *think* strictly speaking this should refer to the *host bridge's*
_UID, not the Root Port's, e.g., something like this:

  However, on some production systems from some vendors, a buggy BIOS
  provides a CXL host bridge _UID that doesn't match anything in the
  CEDT.

Bjorn

