Return-Path: <linux-pci+bounces-15595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 124909B61D9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 12:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A237EB23D78
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F29C1EABB5;
	Wed, 30 Oct 2024 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4MpXqDw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2491E5726;
	Wed, 30 Oct 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287886; cv=none; b=gZoSs2sQY8OIg1+8LWz/iXBfqrYiUhUtYlqjRDOkUlmY+7iYLjiFnDED3NCkhYlHd3ecm8ETnMzyMpP+aSqtuPvPhZd7t65i8JPGwO0TQbnElV46R+X6PGoC8ePAbuH9UxrjuRbN4JMKUbiPENTgd6kqZ/9uOA7M70l6ZffpDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287886; c=relaxed/simple;
	bh=jGdZDsx0s9g6rg3dnMU2BE+xkNj1ngNNFczgoy6gzvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeAkU4CJ/sTVpUvs0pydgzKiqiIVn6NtuAe81lE9AqUweSL6Y2clEhw4oy6IlDOBXFESK4hWLkiIg2rs2VOkio/zI3+k5AkHBWFIl65/qteiutPFf9iwXUEMu/fzTknJR+1mTxrKNwjCYZsfNXKF5pDX2L5Q7V9iCl7YNPtd82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4MpXqDw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730287884; x=1761823884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jGdZDsx0s9g6rg3dnMU2BE+xkNj1ngNNFczgoy6gzvM=;
  b=n4MpXqDw6a/FVdRhc+7iJeNCH6fs+STQ0NgHU+8X13WkyocOWiV3Pmap
   9MHCYnEeyUAlA+Bdq2KRCxJYUrQrGjcDwL2QH4KiS8w4s1FM1rl5AyJrD
   jE/+6VoIEg/cGiW6yyKLVpMqhsGidnqoEJzxmRRHLp/6k6tR3TZ3cnb0m
   i4H049Jr7gkUP6CjsxcLSIuW5eeL3oU+74pfSMhlPPli1xRmnRKAdQCQ6
   gpevNJdMZzbGvMKQJGcRUuhPwdsR4RvjVvj51eFD+NO1a41BwgxFHFfiB
   t9OlxOgzFH0feMYAx7mm4N8DvlccIJcqHp2umTg69yjPhbqwg/1pBnGlD
   A==;
X-CSE-ConnectionGUID: yNyayGJQTTCHRYy5q9l/9A==
X-CSE-MsgGUID: OZmA69O8TTOZ2zqdwt/wug==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="40589394"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="40589394"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 04:31:24 -0700
X-CSE-ConnectionGUID: NTZUZfUTSQSodWopAYiw2g==
X-CSE-MsgGUID: TuXwUavjSwue7XGiLvWGCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="81936772"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 04:31:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 64AAF275; Wed, 30 Oct 2024 13:31:08 +0200 (EET)
Date: Wed, 30 Oct 2024 13:31:08 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20241030113108.GT275077@black.fi.intel.com>
References: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org>
 <20241030001524.GA1180712@bhelgaas>
 <ZyIUZfFuUdAbVf25@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyIUZfFuUdAbVf25@wunner.de>

On Wed, Oct 30, 2024 at 12:11:33PM +0100, Lukas Wunner wrote:
> On Tue, Oct 29, 2024 at 07:15:24PM -0500, Bjorn Helgaas wrote:
> > I asked on the v4 patch whether we really need to make all this
> > ACPI specific, and I'm still curious about that, since we don't
> > actually use any ACPI interfaces directly.
> 
> The patch works around a deficiency in a Microsoft spec which is
> specifically for ACPI-based systems, not devicetree-based systems:
> 
>    "ACPI Interface: Device Specific Data (_DSD) for PCIe Root Ports
>     In Windows 10 (Version 1803), new ACPI _DSD methods have been added
>     to support Modern Standby and PCI hot plug scenarios."
> 
>     https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> 
> The deficiency is that Microsoft says the ExternalFacingPort property
> must be below the Root Port...
> 
>    "This ACPI object enables the operating system to identify externally
>     exposed PCIe hierarchies, such as Thunderbolt. This object must be
>     implemented in the Root Port ACPI device scope."
> 
> ...but on the systems in question, external-facing ports do not
> originate from the Root Port, but from Downstream Ports.
> So there's the Root Port (with the external facing property),
> below that an Upstream Port and below that a Downstream Port
> (which is the actual external facing port).
> 
> I'm not sure if Windows on ARM systems use ACPI or devicetree.
> I'm also not sure whether the Qualcomm SnapDragon SoCs they use
> have Thunderbolt built-in, in which case they won't need a
> discrete Thunderbolt controller.  If they don't use discrete
> Thunderbolt controllers or if they don't use ACPI, they can't
> exhibit the problem.
> 
> In any case I haven't heard of any Windows on ARM systems being
> affected by the issue.

Well they can do whatever they want without us knowing ;-) This problem
does not happen even in x86 Windows probably because they do something
similar than this patch.

> So it boils down to:  Should we compile the quirk in just in case
> ARM-based ACPI systems with discrete Thunderbolt controllers and
> problematic ACPI tables show up, or should we constrain it to x86,
> which is the only known architecture that actually needs it right now.
> 
> My recommendation would be the latter because it's easy to move
> code around in the tree, should other arches become affected,
> but in the meantime we save memory and compile time on anything
> not x86.

IMHO this should be made generic enough that allows device tree based
systems to take advantage of this right from the get-go. Note also there
is already "external-facing" device tree property that matches the ACPI
one defined in Documentation/devicetree/bindings/pci/pci.txt.

