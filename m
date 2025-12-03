Return-Path: <linux-pci+bounces-42569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AB1C9F4A4
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 15:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19F4A348A0D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1A62FC862;
	Wed,  3 Dec 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdFHP/dH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F0231A30;
	Wed,  3 Dec 2025 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772070; cv=none; b=Ls6k7eY6qtM3oxk1jv1IZ7hfX1B3ebuoGjaz369XTwzpg1+ni0HgD1c530rdu13g3xC4B8HNGEGsCL+u3KnoAwws0rlkJaPtyVEPOrk9GVd0KBZAoYs+HfPSGzcoHouSp4Tol9HwWGJpc0O72wAuaEqzxBR4f1kwPTcTma8m0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772070; c=relaxed/simple;
	bh=uH8+XeOzuW42zBq35q12r42V6im07dCsK4jjjXa+7wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq+V1953BYdhDKdFvVx1oU/ySMs6MUTasQmiJY2TK1q7AbOkMysPeVrxzSThNR7b99nEQo0k2SIjAiHYQVTwpcjMUj6VXh1qmaOtRCmDVgUimZgJJXeTdYuFnDkScXYrbo0T0IdJDnHZUEOi2gvJgTDDWfHr1RpqQOfvEd1Z14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdFHP/dH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764772069; x=1796308069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uH8+XeOzuW42zBq35q12r42V6im07dCsK4jjjXa+7wY=;
  b=QdFHP/dHA1/98gAT6Jhy+Osqk5gOzVaY9x4ZaZIWm4YZlW9+qQiukuIq
   /8PA7/h+wuyt7g52mLX7c4wCbBNM0vw5+LmsquwX1if2/evR9TnxA6jk/
   giN5NH/I01P6A+Q0O7bp2mZWi7vlvt3W1uZn8IXjJiAJh3sM5rHbGv6Z+
   df6JUU6GNrEwbrH/A8Fv563tspQJ2Wh0iW4TSVjN2FFDQEGLnv0I8bVvc
   fgYK5xS9C4KrPFCkeRS1+1PninTEjNlO5sTntNL2oLxw46u0LdVuILqDA
   WAnDeor2N2cPn17MIBkDq+G5A+3oz86KZSNLl2psf29Oqzk4eETYzxnOr
   w==;
X-CSE-ConnectionGUID: pab+TQfvS8Ouw3Xf/vg+vw==
X-CSE-MsgGUID: H6/5DVb+RNeKA3A0op/1wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65766132"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="65766132"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 06:27:48 -0800
X-CSE-ConnectionGUID: 54jQ60UnRrWObxnN06SG8g==
X-CSE-MsgGUID: X7Aevgr1Rri/MQUfRrWsAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="194725298"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 03 Dec 2025 06:27:45 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D87CEAA; Wed, 03 Dec 2025 15:27:43 +0100 (CET)
Date: Wed, 3 Dec 2025 15:27:43 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactco.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Riccardo Mottola <riccardo.mottola@libero.it>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
Message-ID: <20251203142743.GD2580184@black.igk.intel.com>
References: <20251202.174007.745614442598214100.rene@exactco.de>
 <20251202172837.GA3078292@bhelgaas>
 <aS9f-K_MN0uYUCYx@google.com>
 <aS_BYeSApI2XuPcD@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aS_BYeSApI2XuPcD@wunner.de>

Hi,

On Wed, Dec 03, 2025 at 05:49:37AM +0100, Lukas Wunner wrote:
> [cc += Mika]
> 
> On Tue, Dec 02, 2025 at 01:54:00PM -0800, Brian Norris wrote:
> > I wonder if we could take a different approach that helps straddle the
> > uncertain boundary here a bit:
> [...]
> >  2) be less aggressive about default-enabling runtime suspend / D3
> >  (i.e., only call pm_runtime_allow() in drivers/pci/pcie/portdrv.c in
> >  limited circumstances).
> [...]
> > So instead of portdrv.c calling pm_runtime_allow(), we'd leave that
> > decision to user space (i.e., udev or similar). That will help limit the
> > impact of getting #1 "wrong." And it's possible the bad systems didn't
> > really want aggressive PM anyway, so it's not worth much trouble.
> 
> I think runtime PM support in the PCIe port driver was primarily
> motivated by the need to power down Thunderbolt controllers when
> they're not in use.

That and also there are discrete GPUs that can runtime suspend when not in
use.

> A Thunderbolt controller exposes a PCIe switch.  Daisy-chained
> Thunderbolt devices are thus visible to the OS as nested switches.
> If we followed the approach you're suggesting, users would have to
> manually allow runtime PM on every Switch Upstream and Downstream Port
> as well as the Root Port and they'd have to do that upon hotplugging
> a device.  Yes, yes, users could add a udev rule to allow runtime PM
> automatically by default, but that's exactly the policy we have hardcoded
> in the kernel right now, so why the change?
> 
> I expect massive power regressions for users (not least Chromebook
> users) if we made that change.
> 
> The discrete Thunderbolt controller in my machine consumes 1.5W
> when nothing is attached.  Some laptops have multiple of these.
> Recent CPUs with integrated Thunderbolt/USB4 may fail to transition
> the package to a low power state unless the Thunderbolt ports go
> to D3hot.
> 
> So I don't think this approach is a viable option.

I agree.  If this is limited to some older RISC machines (based on the
$subject) perhaps this could be solved by adding udev rules to block
runtime PM on those certain ports?

