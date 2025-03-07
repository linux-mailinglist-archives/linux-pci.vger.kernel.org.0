Return-Path: <linux-pci+bounces-23133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81430A56E0C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 17:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C32AA7A5B8F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE7A24395E;
	Fri,  7 Mar 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxojAVdI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9224394B;
	Fri,  7 Mar 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365560; cv=none; b=hDDJudWgm+IR9LKPHtVZOUe7AYmz1VgPK65L/yxRZHDIfeJgAykHG+tspjL/7uWYXNdgedaU1Ibh3Voas0RskzYOjGhKo9dzEzU0NQWAFAE+CbKcLn4NRE7J0YLgcUj5CIX/y77EWw4zVmqqXYO1XhPknJX1Gao/zBb2btC6f9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365560; c=relaxed/simple;
	bh=mj8HNa4tB4btRP0QMutMC9u6X27Sph7ff1QsvL0G+98=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iFtyd+a1oVX0dJIsY26zmnpsGTBiR6TGJpitSjrmoYM1D/PoJjyjRhQnXCzbMj2WT7MOOGRNM6U3aA67A1sg7fpwEhTksvyALm3RIjdqySVdVnvuTp//dBKS28DuT+Q0UK12+woGZJgS/cpgLXhO9F4ICdjeGaTdIOYDUzKSyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxojAVdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2858C4CEE2;
	Fri,  7 Mar 2025 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741365560;
	bh=mj8HNa4tB4btRP0QMutMC9u6X27Sph7ff1QsvL0G+98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BxojAVdI/xVUpTcp5ntWty/Ewi3UiZNzaLXlgQ1CA5IrsGxvRTlc2bO36rGNV493o
	 dNdw+BQlzdAHgKdyTrp81QiIsi6duQLQQ47QioI61pIDK7dA46eLWEtEdVfNZS467g
	 aOxaUJCIdoEQxNKCOOYkhds9nDxl+RnMoS3/cvyyTwyqrfK2rrfcF1Hiqe+TNC0cbu
	 9X+tVhJnpHWCfCF5VxTX+Wo5CVdPndXrFsCFHNYzVbHKcPG3Bub9/Bfpx1OVURXHdj
	 sSLsTWQQNET5Z1344L48n07FfZSHweXKsbbFKYV6k/ObppxxmZhP/YzJF47da8zhdm
	 UU05cNfLvrJtA==
Date: Fri, 7 Mar 2025 10:39:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <20250307163918.GA410256@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef29ceb3-9aa6-f4ca-014e-3f005a9b4beb@linux.intel.com>

On Fri, Mar 07, 2025 at 03:06:31PM +0200, Ilpo Järvinen wrote:
> On Tue, 4 Mar 2025, Bjorn Helgaas wrote:
> > On Tue, Mar 04, 2025 at 03:51:08PM +0200, Ilpo Järvinen wrote:
> > > Disallow Extended Tags and Max Read Request Size (MRRS) larger than
> > > 128B for devices under Xeon 6 Root Ports if the Root Port is bifurcated
> > > to x2. Also, 10-Bit Tag Requester should be disallowed for device
> > > underneath these Root Ports but there is currently no 10-Bit Tag
> > > support in the kernel.
> > > 
> > > The normal path that writes MRRS is through
> > > pcie_bus_configure_settings() -> pcie_bus_configure_set() ->
> > > pcie_write_mrrs() and contains a few early returns that are based on
> > > the value of pcie_bus_config. Overriding such checks with the host
> > > bridge flag check on each level seems messy. Thus, simply ensure MRRS
> > > is always written in pci_configure_device() if a device requiring the
> > > quirk is detected.
> > 
> > This is kind of weird.  It's apparently not an erratum in the sense
> > that something doesn't *work*, just something for "optimized PCIe
> > performance"?
> > 
> > What are we supposed to do with this?  Add similar quirks for every
> > random PCI controller?  Scratching my head about what this means for
> > the future.
> > 
> > What bad things happen if we *don't* do this?  Is this something we
> > could/should rely on BIOS to configure for us?
> 
> Even if BIOS configures this (I'm under impression they already do, I 
> had problem in finding a configuration in our lab on which this patch
> had some effect). But my kernel was built with CONFIG_PCIE_BUS_DEFAULT, if 
> I set that to CONFIG_PCIE_BUS_PERFORMANCE, what BIOS did will be 
> overwritten.

I despise those CONFIG_PCIE_BUS_* options, but have never managed to
get rid of them.  Unfortunate that something named "*_PERFORMANCE"
will apparently result in *worse* performance in this respect.

