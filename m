Return-Path: <linux-pci+bounces-7550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AAF8C72AD
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 10:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F009281421
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 08:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8B976023;
	Thu, 16 May 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBThG/+h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F35477A
	for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847648; cv=none; b=uIUEdpgfB4hc7jlW4ijtlTciNzcYIrYD5hSpyEZcrCe2/oYyCWvEAoLZCyyhvm86yvh+XZGb6AKjTW1if4ci56cN1SjAdIG+V1LtWSQGNcVE5OL2mAEy4dM9vzkFegww/ex18X26G5UXPTO+fgMxan/tOcyAV8o87QUxJakwKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847648; c=relaxed/simple;
	bh=yTHJOz52a1/t0VjBwQJGAfDY+kbzziMgZaW5Id/Try4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kVxenGxEvgmguxZLVdmKAfiKK0Y5sFTCUJJ7lywfOkYNL4EadLRNQalqbMjOC8dMNzwrBMaw1y2gHtd0H6hVtWRL+Lgpt5tIiLtjjSflJqptad+UnQS+hftLhVImC+AZsXaxaWuJ0k/cS1OoxTe2qPTf4oTan2xX9LMt4orf7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBThG/+h; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715847646; x=1747383646;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yTHJOz52a1/t0VjBwQJGAfDY+kbzziMgZaW5Id/Try4=;
  b=HBThG/+h31dH7Vin/CBok1ZXINHFp5pmdJ/QB5jU0re9+sVnXy9MJeZn
   ukkksMJin3+bPhZkOpsaOH5WU+/XxhrXac2g5BRBF7t6lt8LPEtlqYqn5
   Ls11OpfgzmPJmVDaj5zZU7FKaLkqXPBYp5KsuqzLI3b1GMZYB/o58S0Tw
   /DYf4yekdfbOpVOs2r0daeHWEQIBOoeLLzI9fI1TUGjJYP06U7CyV8gqe
   hBvzBSpriA7dPLExqKWGFnKaQjeaxaoVYx7Re4zVZO5nMHbpUTGO6k/oT
   bPygzra7lzi3z3PIMxM2AYFnydqBBTs7KdW54QuB5SEvh4eru/uhtOTZQ
   w==;
X-CSE-ConnectionGUID: JK4NRpanT468VeZuLQ5x2A==
X-CSE-MsgGUID: ovck2mGARqaC5bvphi/Gbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29441931"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="29441931"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 01:20:46 -0700
X-CSE-ConnectionGUID: hTXuMvTDRA2JNRN2pMnizg==
X-CSE-MsgGUID: 16lx1j+5TJmyCeZoaQZB2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="36082653"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.208])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 01:20:43 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, intel-gfx@lists.freedesktop.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Subject: Re: [PATCH 0/8] drm/i915/pciids: PCI ID macro cleanups
In-Reply-To: <ad7df133-803a-4089-8ced-bf3eaf169d43@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1715340032.git.jani.nikula@intel.com>
 <87ikzlhiv8.fsf@intel.com> <8734qjcfu1.fsf@intel.com>
 <ad7df133-803a-4089-8ced-bf3eaf169d43@intel.com>
Date: Thu, 16 May 2024 11:20:37 +0300
Message-ID: <87pltmb222.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 15 May 2024, Dave Hansen <dave.hansen@intel.com> wrote:
> On 5/15/24 07:25, Jani Nikula wrote:
>> No reply from Bjorn, Cc: the x86 maintainers and list, could I get an
>> ack from you please?
>
> x86 is just a consumer of the drm/i915_pciids.h macros.  The name change
> is perfectly fine with me.  No objections.  But I really don't think you
> need our acks to move forward.
>
> Either way:
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for x86

Thanks, I know the changes are benign, but it's just that I tend to err
on the side of getting the acks rather than stepping on anyone's
toes. :)

BR,
Jani.


-- 
Jani Nikula, Intel

