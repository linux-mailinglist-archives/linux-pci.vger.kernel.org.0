Return-Path: <linux-pci+bounces-30473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FAAE5B8E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 06:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5563B069B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 04:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E431A2253EE;
	Tue, 24 Jun 2025 04:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwdNlFnv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EFB21B9F6
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 04:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750740138; cv=none; b=MoWs7qp4f9TbTi6fuHrIvMCZxYUFvzFg8/k2B67k4jfJvHVUd7I9umyTXrRHEHKZduWEq0YmSVlIz2oNuDSJ2SYbXZxmaAJR19NB4Z3O9Oh6fu7yhOh0jIu20N9x/dsdKPKTuYUH5GcC3zYTw9SAxHNLL3aoaWauX5h2FeOdU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750740138; c=relaxed/simple;
	bh=ODU4jJItg+QGmO7Iwq9xVFXyh13W+yU1dp1f37ZoWM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmQy0n6pH9lzdkkjnUzjs+eBrcnJjaXpeM9H2bzwP4pCSH9QU3s9AURp+FxSjHMX2jgenULSNGAH5b+AGED1xNUf3Wm/aMTdhXb2WHwzvjuZK98jgNBqHfzr6kxZw7VLZi1v7AXjm/6oDs0rP8DcwGpTKdmkbeEcVMu2QAHdptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwdNlFnv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750740138; x=1782276138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODU4jJItg+QGmO7Iwq9xVFXyh13W+yU1dp1f37ZoWM8=;
  b=YwdNlFnv95M7ATH0bglDh6/Xy6Gq4pfC/hN8VUQ5Jogy+LCFa39rGTUE
   0E0udl/Io0fKmQd1hiWWUXlkOcBh/xXQ/6GqYP6Ulio+HfMB+IqoVxs+c
   20NANUD+1GAOOCmB/8uKt4uESBI1bbnvHDbpuxtyjNC/HIqcF3N9KW1ZH
   nh7hTGCHjwLBDNBKvDzxkxrCZcFhrpWaAp5RIGiodPpWHrDeBrS/33i4C
   TKtAxDQPZzGaG08ki2QpBIDB+XGw36iH8+ntF1uENdUBT6Xpx2cNtD4OH
   uj9ezEZ1fNjD74paFy+tq512fuZIkZtQlOQIrAR5+f1Ru/wDE9ngX1Mnu
   g==;
X-CSE-ConnectionGUID: 5/9YO6lRS6en4tyTGvfHxA==
X-CSE-MsgGUID: xW4kka51QZW/vJvwcw6vmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52681568"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52681568"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 21:42:17 -0700
X-CSE-ConnectionGUID: felMlOWLTKuKNtNuzawB8w==
X-CSE-MsgGUID: UuxEOzMhTrypWlUtsOu6wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157291935"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jun 2025 21:42:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4DA30138; Tue, 24 Jun 2025 07:42:13 +0300 (EEST)
Date: Tue, 24 Jun 2025 07:42:13 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
Message-ID: <20250624044213.GZ2824380@black.fi.intel.com>
References: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>

On Mon, Jun 23, 2025 at 07:08:20PM +0200, Lukas Wunner wrote:
> pcie_portdrv_probe() and pcie_portdrv_remove() both call
> pci_bridge_d3_possible() to determine whether to use runtime power
> management.  The underlying assumption is that pci_bridge_d3_possible()
> always returns the same value because otherwise a runtime PM reference
> imbalance occurs.
> 
> That assumption falls apart if the device is inaccessible on ->remove()
> due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
> which accesses Config Space to determine whether the device is Hot-Plug
> Capable.   An inaccessible device returns "all ones", which is converted
> to "all zeroes" by pcie_capability_read_dword().  Hence the device no
> longer seems Hot-Plug Capable on ->remove() even though it was on
> ->probe().
> 
> The resulting runtime PM ref imbalance causes errors such as:
> 
>   pcieport 0000:02:04.0: Runtime PM usage count underflow!
> 
> The Hot-Plug Capable bit is cached in pci_dev->is_hotplug_bridge.
> pci_bridge_d3_possible() only calls pciehp_is_native() if that flag is
> set.  Re-checking the bit in pciehp_is_native() is thus unnecessary.
> 
> However pciehp_is_native() is also called from hotplug_is_native().  Move
> the Config Space access to that function.  The function is only invoked
> from acpiphp_glue.c, so move it there instead of keeping it in a publicly
> visible header.
> 
> Fixes: 5352a44a561d ("PCI: pciehp: Make pciehp_is_native() stricter")
> Reported-by: Laurent Bigonville <bigon@bigon.be>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220216
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Closes: https://lore.kernel.org/r/20250609020223.269407-3-superm1@kernel.org/
> Link: https://lore.kernel.org/all/20250620025535.3425049-3-superm1@kernel.org/T/#u
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.18+

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

