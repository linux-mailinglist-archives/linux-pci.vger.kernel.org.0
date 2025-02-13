Return-Path: <linux-pci+bounces-21388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B8A350A1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BB13ADD33
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556B24169C;
	Thu, 13 Feb 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDVYB6ZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9141714B7;
	Thu, 13 Feb 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483181; cv=none; b=Lo4AfRmojvHEVZCJRDBaY8yAjXcxM2WNCOnbYk0v1Y8UXz5yU20pj3PtajPVvT6+pMxwxKtfxvFWOwzEtT9xETOtxseTrdbodcuduVv+I1WcuxlFRa40aqjrLA7f+cZs1T66p4jjaeaMTsyW73mZfZK+I9B9tcJn3q9sS7V/lBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483181; c=relaxed/simple;
	bh=WN1izrHpHS8vpC+8IvMWIbDSUAEMyvQrALWFdqnuBdo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D2WEihNHY8YjuYWB+7ywhDjdKvGn3WUzdqRIACNWdCyLiO9yjqUo9pjj7YQejBl47UkAXom+9VxLULfLG5IlYxPxu46rw82B5JZne3yUTVKn9LTMPQMCc/vb596/QhGDmTG1WPlgN1fgG1tjYoJFQyAX+L5qNHvg7GahgX+z93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDVYB6ZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE65C4CEE9;
	Thu, 13 Feb 2025 21:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739483180;
	bh=WN1izrHpHS8vpC+8IvMWIbDSUAEMyvQrALWFdqnuBdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nDVYB6ZP3BEivt/jaDZwf8tWnqX/1BhpDuW0zGcXfyiiAWUtNGI1V9IIi53/EBI1i
	 cKAeJH/MJ1g/86kibrbANTYDqvZu+VR/jRolfljZikAhxGkS47yEQzAj4H5G34ETnQ
	 ebT48FZDQ2CzM7IqfJ9t7iaLXOZyCDvUnqJls+sHELbPfi8tPZkMO3D16Nh/v0z+9K
	 zkd5HDws1HGebBHv1uk8zq9Tdk2hG1l+a/v9L8f0yVP2798Y7yRFn9vscL/x2nnMin
	 eBYGyRylU7JexwdNHLNCt9EoAnmRw4YYpLTZsxYaL4LYDSDwzS9LwvLDXgsqR2Tw+k
	 ROHTo44WTzr5g==
Date: Thu, 13 Feb 2025 15:46:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 00/25] PCI: Resource fitting/assignment fixes and cleanups
Message-ID: <20250213214618.GA131855@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>

On Mon, Dec 16, 2024 at 07:56:07PM +0200, Ilpo Järvinen wrote:
> Hi all,
> 
> This series focuses on PCI resource fitting and assignment algorithms.
> I've further changes in works to enable handling resizable BARs better
> during resource fitting built on top of these, but that's still WIP and
> this series seems way too large as is to have more stuff included.
> 
> First there are small tweaks and fixes to the relaxed tail alignment
> code and applying the lessons learned to other similar cases. They are
> sort of independent of the rest. Then a large set of pure cleanups and
> refactoring that are not intended to make any functional changes.
> Finally, starting from "PCI: Extend enable to check for any optional
> resource" are again patches that aim to make behavioral changes to fix
> bridge window sizing to consider expansion ROM as an optional resource
> (to fix a remove/rescan cycle issue) and improve resource fitting
> algorithm in general.
> 
> The series includes one of the change from Michał Winiarski
> <michal.winiarski@intel.com> as these changes also touch the same IOV
> checks.
> 
> Please let me know if you'd prefer me to order the changes differently
> or split it into smaller chunks.
> 
> 
> I've extensively tested this series over the hosts in our lab which
> have quite heterogeneous PCI setup each. There were no losses of any
> important resource. Without pci=realloc, there's some churn in which of
> the disabled expansion ROMs gets a scarce memory space assigned (with
> pci=realloc, they are all assigned large enough bridge window).
> 
> 
> Ilpo Järvinen (24):
>   PCI: Remove add_align overwrite unrelated to size0
>   PCI: size0 is unrelated to add_align
>   PCI: Simplify size1 assignment logic
>   PCI: Optional bridge window size too may need relaxing
>   PCI: Fix old_size lower bound in calculate_iosize() too
>   PCI: Use SZ_* instead of literals in setup-bus.c
>   PCI: resource_set_range/size() conversions
>   PCI: Check resource_size() separately
>   PCI: Add pci_resource_num() helper
>   PCI: Add dev & res local variables to resource assignment funcs
>   PCI: Converge return paths in __assign_resources_sorted()
>   PCI: Refactor pdev_sort_resources() & __dev_sort_resources()
>   PCI: Use while loop and break instead of gotos
>   PCI: Rename retval to ret
>   PCI: Consolidate assignment loop next round preparation
>   PCI: Remove wrong comment from pci_reassign_resource()
>   PCI: Add restore_dev_resource()
>   PCI: Extend enable to check for any optional resource
>   PCI: Always have realloc_head in __assign_resources_sorted()
>   PCI: Indicate optional resource assignment failures
>   PCI: Add debug print when releasing resources before retry
>   PCI: Use res->parent to check is resource is assigned
>   PCI: Perform reset_resource() and build fail list in sync
>   PCI: Rework optional resource handling
> 
> Michał Winiarski (1):
>   PCI: Add a helper to identify IOV resources
> 
>  drivers/pci/pci.h       |  44 +++-
>  drivers/pci/setup-bus.c | 566 +++++++++++++++++++++++-----------------
>  drivers/pci/setup-res.c |   8 +-
>  3 files changed, 364 insertions(+), 254 deletions(-)

Applied to pci/resource for v6.15, thanks, Ilpo!

