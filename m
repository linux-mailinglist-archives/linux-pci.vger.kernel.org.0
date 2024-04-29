Return-Path: <linux-pci+bounces-6794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC048B5DC2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 17:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A7328A5F6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BFE7F487;
	Mon, 29 Apr 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luPes51P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088B535A2;
	Mon, 29 Apr 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404701; cv=none; b=mhXhGqB0nrdXpcwVKYwJjnLYnmNnYD9XRmHlT3cxIeVsLQbaAxClCsStApGSKiyZ8VdUY8UI95RUrmiXhfNCCl8k/6o7AT1TcIrL0gKSM/hddpPiCNcR0bzEQYmJcCibVhdsT9zkJXOyDpZwTaP68OsQkCz4cmiEO+v7h5Wdl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404701; c=relaxed/simple;
	bh=/9YTeG0w6gYl+eydHKUSlpYoBIZTOwQTVIFsx2kf/j4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k0kmqEefAmE6vOm4s3VcgjdakmEjHdZTbR2SUdsHYBTGFd8uhMIjb/gX1/qnTfp2y8PKQRi29EnAoKl3tCBl2eHsDtgE/lN/DYaYVwMYH9NNyWrm4hVvGp6EZOZWGfakJ4JcRHxGfP9+zxz3MK3TZ1pzW66clZVR53X+aaWpmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luPes51P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7E1C113CD;
	Mon, 29 Apr 2024 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714404700;
	bh=/9YTeG0w6gYl+eydHKUSlpYoBIZTOwQTVIFsx2kf/j4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=luPes51P2bUJxJsaSYDwuDqji1yIE3ASyfJUO6YOonA0364hcBRW599DoqpCIuLWh
	 8v+RzxctF9zsRzSfq7Ca6K61AK/YZHnJ1/+YFA5Gu3j3VG8nXZF1IlOdl0OcoFQM8l
	 FyOh3XNUsk6uyXdNSpyFRAYfyU1bXaZ9AuLdL3gPb193r/rdGZlYJPBhIDTBFL11Bz
	 FvOgvbu2zOs//fpWhCWdg9ngSse4DCg6Wh+S26Pcc3RVDNiO0+90dhF09SFhORLwcq
	 n24VlIo6gFZR905m6EpjUiHgmVtU0MjhjbzS+NGU7yVpYiVJtK+mx4f5fnU7cLDaA1
	 1Kj+OmPPpH3Ww==
Date: Mon, 29 Apr 2024 10:31:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: PJ Waskiewicz <ppwaskie@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <20240429153138.GA681245@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce49c67c24f57ffab166d688a1c9e3139733f412.camel@kernel.org>

On Sun, Apr 28, 2024 at 10:57:13PM -0700, PJ Waskiewicz wrote:
> On Tue, 2024-04-09 at 08:22 -0500, Bjorn Helgaas wrote:
> > On Sun, Apr 07, 2024 at 02:05:26PM -0700, ppwaskie@kernel.org wrote:
> > > From: PJ Waskiewicz <ppwaskie@kernel.org>
> > > 
> > > Currently, Type 3 CXL devices (CXL.mem) can train using host CXL
> > > drivers on Emerald Rapids systems.  However, on some production
> > > systems from some vendors, a buggy BIOS exists that improperly
> > > populates the ACPI => PCI mappings.
> > 
> > Can you be more specific about what this ACPI => PCI mapping is?
> > If you already know what the problem is, I'm sure this is obvious,
> > but
> > otherwise it's not.
> 
> Apologies for the delay in response.  Things got a bit busy with travel
> and whatnot...
> 
> On one of these particular hosts, in /sys/bus/acpi/devices/ACPI0016:00,
> for example, the UID would be something like CX01.  It isn't an u64 at
> all, and there's no atoi() or other conversions that would match what
> the UID should be.
> 
> In my case, /sys/bus/acpi/devices/ACPI0016:02/ is my CXL device in
> question. The UID that is presented from enumeration was CX02. 
> However, if I scour the CEDT manually, the UID of my particular CXL
> device is really UID 49.
> 
> So, if I went from the PCI/CXL device side, and called something along
> the lines of to_cxl_host_bridge() and tried to go from the pci_dev to
> the acpi_handle, I'd get CX02 back.  Then trying to use that to call
> acpi_table_parse_cedt() would fail.
> 
> The BIOS fix from the vendor corrected the UID enumeration on the ACPI
> side.  This allowed things to properly line up when traversing through
> the kernel APIs and parsing the ACPI tables.

IIUC, _HID ACPI0016 indicates a CXL host bridge.  ACPI r6.5, sec
6.5.11, says "The _UID object is required in order to allow OSPM to
match entries in the CEDT to devices present in the ACPI namespace."

I don't see anything about a requirement to map an ACPI0016 devices to
a PCI device.  At least in the non-CXL world, there *is* no way to map
a PNP0A08 device to a PCI device because a host bridge is not a PCI
devices itself (it has an unspecified non-PCI primary interface and a
PCI secondary interface).

So from the patch and the ACPI/CXL specs, it looks like the problem
doesn't involve PCI at all; it just looks like an ACPI0016 object is
required to contain a _UID, and on this buggy BIOS it doesn't.

My question was just prompted by the "ACPI => PCI mapping" in the
commit log.  Since PCI doesn't seem involved, maybe just drop that
reference?

It's just a buggy BIOS that doesn't supply _UID for an ACPI0016
object, so you can't locate the corresponding CEDT entry, right?

Bjorn

