Return-Path: <linux-pci+bounces-22417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8313AA459D4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 10:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F58A189007A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB8224222;
	Wed, 26 Feb 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdZk546r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D21E5B85;
	Wed, 26 Feb 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561606; cv=none; b=OGSixK4hGGyvnOniUMeSmuQm2Cs0osGGet/irGyTSFIjf3vt2MhVH6T1UDTQfBDUK6XpI4ErtpzX5dGpBjhJAeezc4mxgd7LuZqqdyMyPAryetZY4L0vYpcO0XSTUqaKzlBBx0ZEbQCH5Mm1NKFMU2rSBGZO/26+g22pzq6sHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561606; c=relaxed/simple;
	bh=24vtFRKNjBqptcl97/HocSl/lK2e+Ib0xTWtLuTQxVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPMSqWC5wDTcM2bpDl7cc+OruKzo00S4rAuY7Mq5wKFRXJoJ+2Criupv00XGI2ZLPgTluYAUmYfECUOzscLz1RdlWlA2Po3dv6wVkIetR0THFbJjGorkbCmRzhCdvkOdwL20mZIbKNDGUrloMAPoNTSUDVu9Exl/HS+/E3xXLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdZk546r; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740561604; x=1772097604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=24vtFRKNjBqptcl97/HocSl/lK2e+Ib0xTWtLuTQxVI=;
  b=KdZk546rRQPnBrxh49mIU9RfsvMCSFbfunvVhyQEg0UknS0M3DJEX57V
   4eblprwFnZqQdMJJJyRfEQm/SVZPxuX+rMOL4ulpPVLhGx47IG+IRQzsg
   Jl4NU93udNXxdfmlxG21RhTZfdHmxKDAwCQUjWAI6CJX/QkAT/cRik2YZ
   +K9GnmewrpLZTI1VPd6PkgxvIKK+cYht7BD+q63uHTLBqoimVCkSOKM5N
   r00UTO6b15whfr8vFfpgQ4PM3VSngK5EpluQZ9jA1upOv6+OKhvTROgbr
   rhYDPkn6Br0744yYaYcEfH/UAf/76Xvlv+ZGz3q/krJS0dIe72F2+SuiH
   w==;
X-CSE-ConnectionGUID: UWEhTeHsQgGDNqs8hk03GQ==
X-CSE-MsgGUID: Oc9c+kroR2GG4ZWiBHrCcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52034580"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52034580"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 01:20:03 -0800
X-CSE-ConnectionGUID: wKK8ga4UTGSDhn9l/jSoAA==
X-CSE-MsgGUID: PdOqyUDORV+syCxYFE6Ncw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121580275"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 26 Feb 2025 01:20:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 6183B1FF; Wed, 26 Feb 2025 11:19:58 +0200 (EET)
Date: Wed, 26 Feb 2025 11:19:58 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kenneth Crudup <kenny@panix.com>, Bjorn Helgaas <helgaas@kernel.org>,
	ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikl??vs Ko??es??ikovs <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <20250226091958.GN3713119@black.fi.intel.com>
References: <20250210210502.GA15655@bhelgaas>
 <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
 <Z77ak-4YsdAKXbHr@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z77ak-4YsdAKXbHr@wunner.de>

On Wed, Feb 26, 2025 at 10:10:43AM +0100, Lukas Wunner wrote:
> On Wed, Feb 26, 2025 at 10:44:04AM +0200, Mika Westerberg wrote:
> >   [Meteor Lake host] <--> [TB 4 dock] <--> [TB 3 NVMe]
> [...]
> > I added "no_console_suspend" to the command line and the did sysrq-w to
> > get list of blocked tasks. I've attached it just in case it is needed.
> [...]
> 
> This looks like the deadlock we've had for years when hot-removing
> nested hotplug ports.
> 
> If you attach only a single device to the host, I guess the issue
> does not occur, right?

Yes.

> Previous attempts to fix this:
> 
> https://lore.kernel.org/all/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/
> 
> https://lore.kernel.org/all/20240612181625.3604512-1-kbusch@meta.com/

Well, it does not happen if I revert the commit so isn't that a
regresssion?

