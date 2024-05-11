Return-Path: <linux-pci+bounces-7375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10608C2FB7
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 07:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7378E2843F9
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 05:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9174779D;
	Sat, 11 May 2024 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iw272+cO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055ED2CCBE;
	Sat, 11 May 2024 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715406208; cv=none; b=SYBG2WmXGgQaWraj1z2/UsZodcCy9A5KqMc2ffj7inNwM4pbWGBGVe10NbN9sAyZd1S6Mi7KFxC0R4MOBulcSA1Eg/6gmjOOoQ8MHqX5YV6yGsD1EFN1TaN1WOjNKxNpkpkXcKGduwNvJaWT00Bio19aQp+4v45otrsGIoYA1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715406208; c=relaxed/simple;
	bh=iRSHi53yMQGCRXrNB6EM00y4XP9wpNOAPEeLanCrHAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFF8zgXTGrURDNv4idPl11hRa+aXxWFd0ptXSCPkvu08qsJGCtpEcl4iDKoPCaJMfram6P0XyKf9Pr/WPEgsP23DbFm7q3DuQHk2sKIcT7OEqMiMqc9SAj6ScvFANxMcL9FqSh+onr/6Vs4Yg03Bejx2nnps0WImUE0UPouqL5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iw272+cO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715406207; x=1746942207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iRSHi53yMQGCRXrNB6EM00y4XP9wpNOAPEeLanCrHAw=;
  b=iw272+cOAktUul07YG/T0y4IXpU6I3aQc/es70VCIYRVlcZr3mHvp7Xr
   d+Wq0Lp9iKXVW7PwE5c0VqbnpBtRg4gbeA3sxNoyTwVU3bPyTo5OaQ+yF
   B2PTEmjJ0WZeReph3rrfACUJbssRDgqd1QXLXJBb+JYw8JTcZOdBA1L07
   wuv1CnLOq9uNxIWLsgWgofl4988Q8oc7np8/n5qybvNocpa5e//3zvvsn
   clcvBK4Vzqo2ex0UE+nPkyplD0mhbiJX86HrPN9fLccayJYBWcYXjVTKw
   2GfEu64NfPRI6ISW4xX6sv9uU8xeaTaBVp3xcJGjiHGi8rskJMA+L6Yod
   Q==;
X-CSE-ConnectionGUID: 0HOq+M2FRv2x050Ee8cJ9Q==
X-CSE-MsgGUID: RHp2ihN2TO6jMCkrWCe5dw==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11576824"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="11576824"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:43:26 -0700
X-CSE-ConnectionGUID: zMq2KCiWT7u5bx9ur+SyBw==
X-CSE-MsgGUID: rgENKgccRbi+iIoZutlNJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="34376789"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 10 May 2024 22:43:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 51684142; Sat, 11 May 2024 08:43:23 +0300 (EEST)
Date: Sat, 11 May 2024 08:43:23 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240511054323.GE4162345@black.fi.intel.com>
References: <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de>
 <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511043832.GD4162345@black.fi.intel.com>

On Sat, May 11, 2024 at 07:38:32AM +0300, Mika Westerberg wrote:
> They are not integrated Thunderbolt PCIe root ports.

For the clarity, Intel integrated Thunderbolt 3 controller first in Ice
Lake, then Thunderbolt 4 controller in Tiger Lake and forward (Alder
Lake, Raptor Lake, Meteor Lake). Anything else, including Comet Lake and
the like are using discrete controllers such as Alpine Ridge, Titan
Ridge (both Thunderbolt 3) and Maple Ridge (Thunderbolt 4), and Barlow
Ridge (Thunderbolt 5) where the controller is either soldered on the
motherboard or connected to a PCIe slot.

Sorry for not opening this up earlier.

There are some combinations where the integrated controller is disabled
and a discrete one is being used but again that should match the second
"rule".

