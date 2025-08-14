Return-Path: <linux-pci+bounces-34023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9857FB25A89
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 06:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1197582484
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 04:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68701FE47C;
	Thu, 14 Aug 2025 04:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ccgle0SX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE552FF673;
	Thu, 14 Aug 2025 04:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755146277; cv=none; b=SZzDEI+F/4aj25mJvNq7BHy+P//z682S+k8t/JeviNGTSOZx/NJTJ4+MgHo3ahgfSzv11wqrlJGJLXCovmiCbgNArWSMwaJ40CHdtb3lnobicmeAn3TtHrF/hPki+nze3mvClMllJhbmqVzVRGE3x8+IVeU9KGSr+z5BOt0Pyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755146277; c=relaxed/simple;
	bh=jMST5i3v+XXoZ1+Ls/2LiNBHlpGQC3dHOuYcYNo6CpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA9nxxmsBFLNqeDemU3YtCKxkdSW8mwPq3whEsyabxUXwoGzgdWALW8mstTgoLpsc/oAAO+p9xBW8+4NnNBAarf23whx/9Gw3NKHAasNm/Sff+1oyyCIJKK5EFuLt0uuvgClDYmnfuj02GVLRRgdHKy4DSpY5NQNTKJTXFPHtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ccgle0SX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755146277; x=1786682277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jMST5i3v+XXoZ1+Ls/2LiNBHlpGQC3dHOuYcYNo6CpE=;
  b=Ccgle0SXl30JkHdP43EVRNRO7jIbu2y3H6HzPL0BrrFf8zmvhBrmnUKf
   nti+McCuYTFKE/AJp2RTPavcBxFS4eKidLmzgInqU0/8lSxejwtLJm+dL
   x2Jpq0QZWqAKpptuqSpCGFL25tIRZMKykqxib5fiWX/7DW4jMMwS1ai3Q
   bchg/Y6wMK6VjwhM478hvIxTSwkGzgUgsOQyY8wBTt5cju8g0/dRxNwJS
   jJFZUeJiVylr5tbuYFH+AZIlEZXMOZTe0pShl6eGHCbayVj/On7yulawH
   U9GUpzu0lajhzdFa32hCLAHbwXez/jEF4dO6h7yNn6NECWwRaQwYMBU+I
   A==;
X-CSE-ConnectionGUID: r6cc/F1rQbmGBIWujfFGfg==
X-CSE-MsgGUID: v7rmjGQlTEyyUhvpHFDC+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57534151"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57534151"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 21:37:56 -0700
X-CSE-ConnectionGUID: /PCG9uQ/TQGIiXty5Gbkiw==
X-CSE-MsgGUID: REcfPZmJQaqVDagKX95v6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166572485"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 13 Aug 2025 21:37:54 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 816B993; Thu, 14 Aug 2025 06:37:52 +0200 (CEST)
Date: Thu, 14 Aug 2025 06:37:52 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Mika Westerberg <westeri@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Use is_pciehp instead of is_hotplug_bridge
Message-ID: <20250814043752.GB476609@black.igk.intel.com>
References: <5632086b8436bc2f9a43e3573acf7a090615b52f.1755005459.git.lukas@wunner.de>
 <20250813172552.GA279834@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813172552.GA279834@bhelgaas>

On Wed, Aug 13, 2025 at 12:25:52PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 12, 2025 at 03:42:29PM +0200, Lukas Wunner wrote:
> > The thunderbolt driver sets up device link dependencies from hotplug ports
> > to the Host Router (aka Native Host Interface, NHI).  When resuming from
> > system sleep, this allows the Host Router to re-establish tunnels to
> > attached Thunderbolt devices before the hotplug ports resume.
> > 
> > To identify the hotplug ports, the driver utilizes the is_hotplug_bridge
> > flag which also encompasses ACPI slots handled by the ACPI hotplug driver.
> > 
> > Thunderbolt hotplug ports are always Hot-Plug Capable PCIe ports, so it is
> > more apt to identify them with the is_pciehp flag.
> > 
> > Similarly, hotplug ports on older Thunderbolt controllers have broken MSI
> > support and are quirked to use legacy INTx interrupts instead.  The quirk
> > identifies them with is_hotplug_bridge, even though all affected ports are
> > also matched by is_pciehp.  So use is_pciehp here as well.
> > 
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to thunderbolt.git/next, thanks!

