Return-Path: <linux-pci+bounces-25185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D61BCA7910B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 16:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F330172DC5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFBC23AE6D;
	Wed,  2 Apr 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyHvY81E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BD23A99E;
	Wed,  2 Apr 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603666; cv=none; b=ufqih+RVG1uheMdFwbQR9K2W09YxZr4dxY1caNiyVT40Fs7i8Ex+4+rs5ztmDFRiChY3w9vLaVjeZACl8tpD27nbCzcxhmXpHCrkXRZHiig/NPczFzdhYenF2p1uOvkopdeGCWpbiMXpkewisKNsq2weaVCgc43ykYXX+nHcqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603666; c=relaxed/simple;
	bh=vXYuaE+21XA2be2/349r2NDERz2RvN86SNY7hnpjASQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=km4oXk0kXxRwgT1PVCnCLtSnoyQBbckTCXpJnJgGb7qF+tpCR581U5QwWqVyfE7wbDDqYrwK+5X8UaaLMo+Q4jfhDL1ry/YcAUU0KlY5AvbvXuLHQ5eSIvp84BbTNJs5Lx/2VEc6mzqJmo4S+6F4USZ68VH+sAmwyMR90LNhoMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyHvY81E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4DDC4CEDD;
	Wed,  2 Apr 2025 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743603665;
	bh=vXYuaE+21XA2be2/349r2NDERz2RvN86SNY7hnpjASQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JyHvY81ESxf/VPFrmMbV/Rns8Q+G6ATqZr3mKW4H3z7qVW2qox6WIkRnyi2RZZPGH
	 84ft40LkaRr1iw2W9W+cpgDYJ0/4XnuIaNIrKV7er7c1J0jzasiOkFpxtlNC8LSVdS
	 ZtmgRAIK51Bmqqo4r7W2xQcjc4p50JSN5JXeHxzONN+vl7UasTpzBtSXemgPeIAgMg
	 WwcP66MibNl4WAHVGNDGphNt6dPRx/BLKutAjGNeM+wFWItEg3MQkdMePamdeAfm4k
	 G1hAPEXmO/Wxtcl6T1AGt8QuxgB84Si0PrS4X4Ng/PPqQw6EtC4ucHt0nbn2TVdfUj
	 eg4KVdiKU/hQg==
Date: Wed, 2 Apr 2025 09:21:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Anshuman Gupta <anshuman.gupta@intel.com>,
	intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com, badal.nilawar@intel.com,
	varun.gupta@intel.com, ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: Re: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Message-ID: <20250402142104.GA1714299@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hN1qRzU96uAGf1+BoQyqF-1=C4XbCcPA-0xtGt8gj7qQ@mail.gmail.com>

On Wed, Apr 02, 2025 at 01:06:42PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 1, 2025 at 5:36 PM Anshuman Gupta <anshuman.gupta@intel.com> wrote:
> >
> > Implement _DSM Method 11 as per PCI firmware specs
> > section 4.6.11 Rev 3.3.

> > +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
> > +{
> > +       union acpi_object in_obj = {
> > +               .integer.type = ACPI_TYPE_INTEGER,
> > +               .integer.value = delay_us,
> > +       };
> > +
> > +       union acpi_object *out_obj;
> > +       acpi_handle handle;
> > +       int result, ret = -EINVAL;
> > +
> > +       if (!dev || !ACPI_HANDLE(&dev->dev))
> > +               return -EINVAL;
> > +
> > +       handle = ACPI_HANDLE(&dev->dev);
> > +
> > +       out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
> 
> This is something I haven't noticed in the previous patch, but also
> applies to it.
> 
> Why is rev 4 of the interface hard-coded here?

Thanks for asking this because it's related to the whole _DSM revision
question that I don't understand.

If we didn't use rev 4 here, what should we use?  The PCI Firmware
spec, r3.3, sec 4.6.11, documents this interface and says "lowest
valid Revision ID value is 4", so that's the source of the 4.

My argument is that the spec documents rev 4, the kernel code was
tested with rev 4, so what would be the benefit of using a different
revision here?

> > +                                         DSM_PCI_PERST_ASSERTION_DELAY,
> > +                                         &in_obj, ACPI_TYPE_INTEGER);

