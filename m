Return-Path: <linux-pci+bounces-24516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F388CA6D8C1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 12:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED3B16A011
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851310A3E;
	Mon, 24 Mar 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jr/oRkwB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135C2E337E;
	Mon, 24 Mar 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814041; cv=none; b=ebnfiwOnw9kc/eeysDYwhJXfVLEGnVW4y3L9AkNieFjdrCzEmFa/1IvYPVhirHQSlMu0xskf4YVaegp/P8yjhOhqvANudzas0tUUYVXbgmCaN24xSiSWAnk2xEHE0KnYCPBUy1eRJZWxlHrhse6ObEJvZoT+tKvFw0QXMueZthU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814041; c=relaxed/simple;
	bh=EjvNWj2bu9mDgzWHLlrFrR4A2jejj1JVVbCwu0bDSig=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f5RGYaCw6OEuknxCSJpyCCM3odLvTV1Jm0TRzhboKKLstOU0kOAnR+98rArxABua+gKXJezZXQ7ko123OsGMFu8Rh3dpfbPuixw+WuWBoa2dgZXmoB7W9bHG1aLElQ0sOjUDiIcQGQiMuSxp590KEd80rcwjsDCZpssG3EYeCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jr/oRkwB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742814040; x=1774350040;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EjvNWj2bu9mDgzWHLlrFrR4A2jejj1JVVbCwu0bDSig=;
  b=Jr/oRkwBaiDtaH9UrCPqAk4Akd1MpVDw8q3wSakKBO6cynJuL30QZU2l
   hK7sAsb6ajcl+tlM1TsjkEcm38i6/HX9N45nlMIL8mMJ4kans7zZHmzTv
   GjDPlHuORMBcayeG43B3aEqEaPvzzPelSN/+NqmbMi7ruVgRTKGxQ6u+e
   nhb3yUEOXLuTPn6LtV5TH/a+RlyCbgXKQFJ5x2VKUVQswZpGFJigPwY4r
   Xn3vgNX8aykJxtSG1dLtXGfQ+HiiZNPqqe/hcXMwgqIZZD+oymXZm3QcD
   lM2mT4z6wLklKHSRgVkl6usdR7USbreb37FW0DgvAeB5MJSq26Nky7QkR
   w==;
X-CSE-ConnectionGUID: 9/4d2/hcQTejOj97wZW5Kg==
X-CSE-MsgGUID: jcS4b/mTQVuQl+RaOgJkhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="54676231"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="54676231"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 04:00:39 -0700
X-CSE-ConnectionGUID: rm+Udpj5SPKxIK5tTJfTVA==
X-CSE-MsgGUID: S/auv3rTQMSOodTCW+mPtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="124024087"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.251])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 04:00:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Mar 2025 13:00:33 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Don't enable HPIE in poll mode
In-Reply-To: <20250321205114.GA1144421@bhelgaas>
Message-ID: <005837ad-e7dd-85c8-b0d3-ce5aa0257354@linux.intel.com>
References: <20250321205114.GA1144421@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 21 Mar 2025, Bjorn Helgaas wrote:

> On Fri, Mar 21, 2025 at 07:07:47PM +0100, Lukas Wunner wrote:
> > On Fri, Mar 21, 2025 at 12:09:19PM -0500, Bjorn Helgaas wrote:
> > ...
> 
> > >   - It's annoying that pcie_enable_interrupt() and
> > >     pcie_disable_interrupt() are global symbols, a consequence of
> > >     pciehp being split across five files instead of being one, which
> > >     is also a nuisance for code browsing.
> > 
> > Roughly,
> > pciehp_core.c contains the interface to the PCI hotplug core
> >   (registering the hotplug_slot_ops etc),

This is at least oneway as it contains only static functions if 
init func is not counted.

But it has things like pciehp_check_presence() and set_attention_status()
that aren't about interfacing to the hp core.

> > pciehp_hpc.c contains the interaction with hardware registers,
> > pciehp_core.c contains the state machine,

pciehp_ctrl.c is full of PCI_EXP_* usage so it definitely is deeply 
intertwined with hardware registers and does HW related waits, etc.
Thus, the split between hpc and ctrl feels especially artificial and
that's where the back and forth calls also are.

> > pciehp_pci.c contains the interaction with the PCI core
> >   (enumeration / de-enumeration of devices on slot bringup / bringdown).

+ it plays with the reset_lock deep down in the long call chain. It's
also a very short file.

> > The only reason I've refrained from making major adjustments to this
> > structure in the past was that it would make "git blame" a little more
> > difficult and applying fixes to stable kernels would also become somewhat
> > more painful as it would require backporting.
> 
> Yeah, that's the main reason I haven't tried to do anything either.
> On the other hand, the browsing nuisance is an everyday thing forever
> if we leave it as-is.

I get half mad every time I need to browse code under hotplug/. I even 
started doing:

  cat ./pciehp*.[hc] | less -S 

...to workaround the constant need to jump between those files. I 
certainly would like to see the split gone especially between ctrl and 
hpc.

There are also some forward declaration within a file which are mostly not 
needed I think if the functions are shuffled around.

> I did consolidate portdrv.c a couple years ago
> and don't regret it.  But moving things definitely makes "git blame" a
> bit of a hassle; my notes are full of things like this:
> 
>   a1ccd3d91138 ("PCI/portdrv: Squash into portdrv.c")
>     squash drivers/pci/pcie/portdrv_pci.c and portdrv_core.c into portdrv.c
>   950bf6388bc2 ("PCI: Move DesignWare IP support to new drivers/pci/dwc/ directory")
>     mv drivers/pci/host/pci-imx6.c drivers/pci/dwc/pci-imx6.c
>   6e0832fa432e ("PCI: Collect all native drivers under drivers/pci/controller/")
>     mv drivers/pci/dwc/pci-imx6.c drivers/pci/controller/dwc/pci-imx6.c

Can't git blame be given -M -C to deal with this? Or are those truly lines 
that were introduced by the consolidation commit?

I usually need to look older changes as well since there is plenty of API 
reworks and other noise beyond such consolidations, so I tend to end up 
doing this a lot while browing the history of some code fragment with 
increasingly old commit IDs:

git annotate a1ccd3d911382^ portdrv_core.c

...to find the next points of interest in the history. So those commits 
don't stand out as much for me.

-- 
 i.

> > >   - I forgot why we have both pcie_write_cmd() and
> > >     pcie_write_cmd_nowait() and how to decide which to use.
> > 
> > pcie_write_cmd_nowait() is the "fire and forget" variant,
> > whereas pcie_write_cmd() can be thought of as the "_sync" variant,
> > i.e. the control flow doesn't continue until the command has been
> > processed by the slot.
> > 
> > E.g. pciehp_power_on_slot() waits for the slot command to complete
> > before making sure the Link Disable bit is clear.  It wouldn't make
> > much sense to do the latter when the former hasn't been completed yet.
> 
> Right, I know what the difference is; I guess I just don't know how to
> figure out when pcie_write_cmd_nowait() is safe.
> 
> Bjorn
> 


