Return-Path: <linux-pci+bounces-21464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75415A36095
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B42C169F5E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E474A264A9C;
	Fri, 14 Feb 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CN3KP+5P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9815199A;
	Fri, 14 Feb 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543857; cv=none; b=EM0LlMO4NSq/YmxwTzTUjJU8S13H2m/1Pr8W6ulBM2kYwkSzrWN51/HDd2jKko23gRHRqjIcze3sp5s1yGdP3uznembrsp4rvzypf+LRtSPqnrJqNh0rspJIbFRVRlPa9me9lIOTeqI4wUIYVHyGpqO472dPbLEqz7qsjDN6S1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543857; c=relaxed/simple;
	bh=iP9rILo1pieoX7MujpuvZrfyhcl6FWNIG3xPCJe47D8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V8tnI2nkWkK2HzYiWurSPnAv8FUdILhYk+2uD61bhqJjh/hFXpRQ9PWBCAsBww334k2BcbQR9KZlJ8dAdVRjZ044UiUxjDVU25tWykaVaaYFDMMtEUcnMXHs/Pvo2EpD9CjiUFQDJikfNs/xm/R9gKQkFqsC4wIw+om2bXoRmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CN3KP+5P; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739543856; x=1771079856;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iP9rILo1pieoX7MujpuvZrfyhcl6FWNIG3xPCJe47D8=;
  b=CN3KP+5PtSMcPVFEYrFDskyCN3a3SSo+XiyMg0pCnTcbI5InuePlamSa
   OG2Fqc6KM0U5xKslJPTkorDffw3df7/h7Ew8/Z4ON/ZziaacxY+mMZaL5
   Mxt/1p8TWk7n/hGsV7bVHY53z9M+shU8RCMJCYp6ICzl1ceooHWB1Qwv8
   TBuHerSIV0unLVehmFozs8MuhtFX5zwnN6ZIP8KjOxYQo9zdCnsaWunME
   Kz35sUKIcx0JHYg5QrVfMkWloTvInag+4DQf2Wy3kmZ33XyNFFSN4+g51
   GJmii3SB/fbBzIj8A2uItm2+ZbtZBCp1+18Y/LpaN2RuOsH+1yB5r7ihi
   w==;
X-CSE-ConnectionGUID: GOfeAuWIRBifHbwW0tKI4g==
X-CSE-MsgGUID: +tRJ9aauRfKzXpuzk+DTGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40157595"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40157595"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:37:36 -0800
X-CSE-ConnectionGUID: qH+p86lhRk6Y+78IEsYq6g==
X-CSE-MsgGUID: uOBG/QX5SeO3uRT0KYLYGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136699809"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.228])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:37:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Feb 2025 16:37:30 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 3/4] PCI: shpchp: Cleanup logging and debug wrappers
In-Reply-To: <20250213220453.GA135512@bhelgaas>
Message-ID: <582c718e-568d-7f70-aef7-b0206600d3a3@linux.intel.com>
References: <20250213220453.GA135512@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-872026427-1739543850=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-872026427-1739543850=:944
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 13 Feb 2025, Bjorn Helgaas wrote:

> On Mon, Dec 16, 2024 at 06:10:11PM +0200, Ilpo J=C3=A4rvinen wrote:
> > The shpchp hotplug driver defines logging wrappers ctrl_*() and another
> > set of wrappers with generic names which are just duplicates of
> > existing generic printk() wrappers. Only the former are useful to
> > preserve as they handle the controller dereferencing (the latter are
> > also unused).
> >=20
> > The "shpchp_debug" module parameter is used to enable debug logging.
> > The generic ability to turn on/off debug prints dynamically covers this
> > usecase already so there is no need to module specific debug handling.
> > The ctrl_dbg() wrapper also uses a low-level pci_printk() despite
> > always using KERN_DEBUG level.
>=20
> I think it's great to get rid of the module param.  Can you include
> a hint about how users of shpchp_debug should now enable debug prints?
>=20
> The one I have in my notes is to set CONFIG_DYNAMIC_DEBUG=3Dy and boot
> with 'dyndbg=3D"file drivers/pci/* +p"'.

Sure, I'll add the info and split the change as you suggested below.

> > Convert ctrl_dbg() to use the pci_dbg() and remove "shpchp_debug" check
> > from it.
> >=20
> > Removing the non-ctrl variants of logging wrappers and "shpchp_debug"
> > module parameter as they are no longer used.
>=20
> > -#define dbg(format, arg...)=09=09=09=09=09=09\
> > -do {=09=09=09=09=09=09=09=09=09\
> > -=09if (shpchp_debug)=09=09=09=09=09=09\
> > -=09=09printk(KERN_DEBUG "%s: " format, MY_NAME, ## arg);=09\
> > -} while (0)
> > -#define err(format, arg...)=09=09=09=09=09=09\
> > -=09printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
> > -#define info(format, arg...)=09=09=09=09=09=09\
> > -=09printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
> > -#define warn(format, arg...)=09=09=09=09=09=09\
> > -=09printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
>=20
> The above are unused, aren't they?  Can we make a separate patch to
> remove these, for ease of describing and reviewing?

--=20
 i.

--8323328-872026427-1739543850=:944--

