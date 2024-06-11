Return-Path: <linux-pci+bounces-8621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D0390478A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 01:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43781B2188F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 23:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D0155C9D;
	Tue, 11 Jun 2024 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLVhnnqN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA74155C92;
	Tue, 11 Jun 2024 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147544; cv=none; b=NNI/Gsf0RO/CkgpgWwhlgc/mbpmJhkLx6pW60wraq4JPzu7ZGu3dfwBVN8jMulV5uFjn0kIaFuL/MNdq3omJ+bRH7R9kflF1qTcrDL4ebhApiPQXgFjAELOxViD19QfCWuvtHuUqtU+XO9I2nDanaHnZHJkFV61xu7oBwv46DyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147544; c=relaxed/simple;
	bh=UsdPm2TbOpdpKxJjfJYBiUmIpU7Puq3pG3RypnxqySI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XpF5nXcbAOQ6dofZi+rtpZRc+cVZqsPwlE3gsYEl+FuAD8Lq0VB6AKcHtH+3BGd5WqGTdJ+KiPRDS7d5ICg7XeBPoDUodbNrzOAbXpa2OoXc+SEKkqtOMSQY73ghDXgpyV7UcSyerq6iwedXFAPz+RJWFBkYT57+hxMC5zvQdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLVhnnqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49415C2BD10;
	Tue, 11 Jun 2024 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718147544;
	bh=UsdPm2TbOpdpKxJjfJYBiUmIpU7Puq3pG3RypnxqySI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aLVhnnqN8Ug7QxoYCSqGHQFiKUMSoUhvn25NsnLs7QJBnhIFkTQVddrFVyz8977Qh
	 OpndSjRFEsWVv/ix6nQh2w1/SIU1UquEqKaysdR7QACIunDpMiS4vneLfXCf5fnvno
	 Nw7ll403GKqjDX8ITB1YhZWS/SSPnILLNCqzUVP5EH6cfU0cX3Uos/MdjMNcsRiyd2
	 ojyUqoMfwxcu3aRQEPzip626slwGzpgfca8eVhapXx4wAebF9Mw/66FKBn36wUNgvR
	 gpDE7hYQca2l9YBqmYDVS+eYaZf0J3lKwwN2qavdteHkEebb93py+1rS8Jg5ax6vqG
	 vh9h9Ft2gcWGQ==
Date: Tue, 11 Jun 2024 18:12:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] PCI: Solve two bridge window sizing issues
Message-ID: <20240611231222.GA1007067@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>

On Tue, May 07, 2024 at 01:25:15PM +0300, Ilpo Järvinen wrote:
> Hi all,
> 
> Here's a series that contains two fixes to PCI bridge window sizing
> algorithm. Together, they should enable remove & rescan cycle to work
> for a PCI bus that has PCI devices with optional resources and/or
> disparity in BAR sizes.
> 
> For the second fix, I chose to expose find_resource_space() from
> kernel/resource.c because it should increase accuracy of the cannot-fit
> decision (currently that function is called find_resource()). In order
> to do that sensibly, a few improvements seemed in order to make its
> interface and name of the function sane before exposing it. Thus, the
> few extra patches on resource side.
> 
> v3:
> - Removed "slot" wording
>         - Renamed find_empty_resource_slot() -> find_resource_space()
> - find_resource_space() returns bool instead of int
> - Added patch to convert literal 20 related to bridge win minimum
>   alignment to __ffs(SZ_1M)
> - Fixed kerneldoc missing "struct"
> - Tweaked prints (one dbg -> info, added new dbg one for success case)
> - Changelog tweaks
>         - Take account largest >> 1 (in alignment calc)
>         - Adjust to minor changes made into calculate_memsize()
>         - Take logs from more recent kernel to get rid of reg 0xXX
> 
> v2:
> - Add "typedef" to kerneldoc to get correct formatting
> - Use RESOURCE_SIZE_MAX instead of literal
> - Remove unnecessary checks for io{port/mem}_resource
> - Apply a few style tweaks from Andy
> 
> Ilpo Järvinen (8):
>   PCI: Fix resource double counting on remove & rescan
>   resource: Rename find_resource() to find_resource_space()
>   resource: Document find_resource_space() and resource_constraint
>   resource: Use typedef for alignf callback
>   resource: Handle simple alignment inside __find_resource_space()
>   resource: Export find_resource_space()
>   PCI: Make minimum bridge window alignment reference more obvious
>   PCI: Relax bridge window tail sizing rules
> 
>  drivers/pci/bus.c       | 10 +----
>  drivers/pci/setup-bus.c | 91 +++++++++++++++++++++++++++++++++++++----
>  include/linux/ioport.h  | 44 ++++++++++++++++++--
>  include/linux/pci.h     |  5 +--
>  kernel/resource.c       | 68 ++++++++++++++----------------
>  5 files changed, 157 insertions(+), 61 deletions(-)

Applied to pci/resource for v6.11, thanks!

