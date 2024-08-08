Return-Path: <linux-pci+bounces-11472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815C94B60A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 07:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EEC1F23495
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 05:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C844364A9;
	Thu,  8 Aug 2024 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDAvEHEy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B02F50;
	Thu,  8 Aug 2024 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723093298; cv=none; b=GUHBcAf+2Nxt/Xfjm6jCA7Aw4OyznARc1opX4058j78PJ+Pq+Uur6RTTOqOtdeVsJ7mErzb/UhPidbsd751hTnwERtBW/WkdRTcO7JWonJs0wo7w9KvGikwvPrRGJNDT2H2oueKdCq/44o4KywkqQOb4/wTjqiGlpwhlywfKOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723093298; c=relaxed/simple;
	bh=G3sgS5q4eiVEN7w6r8N3dkLqx6e0gncm6B4Vd/IoTl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/NZ+FkRkgo42T2KAQcUXAEiZcmha49+YS9fUmrzl2DmK3PIiDT4oVZPWSZ+oUmOibRWRuKoblNXo3AVdSsi6ybGYgEEcOxYtUyAqUzaBSI5cJPIFfrpO1RHe7BTbwFj9imzjA7/9qAKLOsGGeUQGcaKkTA8pD9okWq1aTVjOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDAvEHEy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723093297; x=1754629297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=G3sgS5q4eiVEN7w6r8N3dkLqx6e0gncm6B4Vd/IoTl8=;
  b=TDAvEHEyqfpPoxMGAthzgTZmMlGY6tdCwJ8KBENBIWV5Ml4VWKZSMu0r
   8j6U/XbYB13TBXpuYjNj4JMkcu08hMBXHU+79YNfdXInELI6+Bl21qzFY
   1esQJe8Xv0lign+WKXr5eFu0BrftdU/zFPW9/1az4OxSiscQjIDfVRQ18
   Fdtv4B+kZfCj6QtfEiq4FsN9OPxjSw1h09MXKt3y7cuXWiEGwAXCOu2AR
   538OwllMT0Lqttw0SnHIGzkZfwWSxrlmHmolYzA4D5/ZoBDwxOpxNy/w+
   a//m7DpIz/qI8pyhC4hmZ7CjciZy7QT/SW6+XWe3k4zUDZoa5eBg3XP0u
   w==;
X-CSE-ConnectionGUID: iFr7HgiqQDCDpsJ8yXl7Hg==
X-CSE-MsgGUID: A9Av1PHBTXSa5AEa4U3ZLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="43717895"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="43717895"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 22:01:35 -0700
X-CSE-ConnectionGUID: r0UJzV/LTQ6j+1OzkVBtPA==
X-CSE-MsgGUID: +B++XpNVS9u15drNbjLKJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="56766182"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 07 Aug 2024 22:01:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A1B91206; Thu, 08 Aug 2024 08:01:29 +0300 (EEST)
Date: Thu, 8 Aug 2024 08:01:29 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] PCI: Detect and trust built-in TBT chips
Message-ID: <20240808050129.GH1532424@black.fi.intel.com>
References: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org>
 <20240807071740.GF1532424@black.fi.intel.com>
 <CA+Y6NJE0QB-W7hBOD_S1XwoSosg3Hh1FH0a8Um16g3Ex_1V9=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Y6NJE0QB-W7hBOD_S1XwoSosg3Hh1FH0a8Um16g3Ex_1V9=w@mail.gmail.com>

On Wed, Aug 07, 2024 at 05:15:36PM -0400, Esther Shimanovich wrote:
> On Wed, Aug 7, 2024 at 3:17 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > I suggest opening the heuristic here a bit more.
> 
> Could you clarify what you mean by "opening the heuristic"?
> What details should I remove?

I mean not to remove anything but open up how we "detect" the built-in
controlllers.

> And add the links to
> > the Microsoft firmware document somewhere. These:
> >
> > https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> > https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> Is it good enough to have them in the commit message? Or should they
> be linked in probe.c?

IMHO they can be in the commit message.

