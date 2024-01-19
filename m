Return-Path: <linux-pci+bounces-2336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F215832553
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 08:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7599B21271
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51911D52A;
	Fri, 19 Jan 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hf3GLcw1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25CBD51D;
	Fri, 19 Jan 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651107; cv=none; b=BrO3kYXz/Q81gRGoCnzkqaSjh2hVQLBbGd5Xyf7oGYE2l36JLC/8Tn2OpJ5UzLnFMfpkQ3UbcQ8r+XjOJcHEpBG/2wCqOdKl/hEt/AYkRsVhZUM0kTcRRtkeeAabfYkb8CT3ZC0/HYAtWhG1GSTKhW/jSlC5cuZW3CKjXmKVnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651107; c=relaxed/simple;
	bh=XfipyyIGq/R+X/vdsGIcSi03h8tMqB6s/DePqcWm/0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIDdSQEVfefp6KH1m2+AZTKRAS5IT1Il9IwoJJUtSXrl3Ee78inQCs2IVYBRRoscrD5t1hZaQm1ezmSPD0Hd6Gp7e+MVavylYnGk34mZq4jxiW1LbVHyh5Inc20lTzbuePx76+D0TUGLfK+f9qKhDFVm9JLAMTmkTtv2cHRL5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hf3GLcw1; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705651105; x=1737187105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XfipyyIGq/R+X/vdsGIcSi03h8tMqB6s/DePqcWm/0I=;
  b=Hf3GLcw1sUKlh4umzq904PUtC24yhbDeHJFAhmDfAkPkWRDNtw+RhJKu
   gwlhsQ6UzHhd7IZWZDgZKBVIHpK2QifK/W+vjXVuGlsERTAIHF6WFe7FY
   l94jGfa7j3Wel87qj3UI4hD+KTSJaKhPaLYFyRzuptGI/X1EAnL2N9zN7
   5ZbDd2FgzxZ2chSEhymEI5xY0GBOfOmsmtL8JHIE1pXsji39MvHGswWLc
   Q8M1j4nNR0thKBOZ0ThAjGkaHwadcXTjtpXTNA6GRplLc51sVwxVTiilZ
   7mEb0czrxqnkbVIRwxkB9eiuQvym+IMSkShb9gFzW/Mkm9hcR80nNJ8zM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="391126288"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="391126288"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 23:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="904083616"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="904083616"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2024 23:58:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id F1E0035E; Fri, 19 Jan 2024 09:48:29 +0200 (EET)
Date: Fri, 19 Jan 2024 09:48:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240119074829.GD2543524@black.fi.intel.com>
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
 <20231228132517.GA12586@wunner.de>
 <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com>
 <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com>
 <20240119053756.GC2543524@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240119053756.GC2543524@black.fi.intel.com>

On Fri, Jan 19, 2024 at 07:37:56AM +0200, Mika Westerberg wrote:
> On Thu, Jan 18, 2024 at 08:12:56AM -0800, Dmitry Torokhov wrote:
> > On Thu, Jan 18, 2024 at 09:47:07AM -0600, Mario Limonciello wrote:
> > > On 1/18/2024 00:00, Mika Westerberg wrote:
> > > > > Before my patch, you see that the JHL6540 controller is inaccurately
> > > > > labeled “removable”:
> > > > > $ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
> > > > > {removable} -e {device} -e {vendor} -e looking
> > > > >    looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
> > > > >      ATTR{device}=="0x15d3"
> > > > >      ATTR{removable}=="removable"
> > > > >      ATTR{vendor}=="0x8086"
> > > > 
> > > > This is actually accurate. The Thunderbolt controller is itself
> > > > hot-removable and that BTW happens to be hot-removed when fwupd applies
> > > > firmware upgrades to the device.
> > 
> > This is quite interesting take. Does fwupd rip the controller out of the
> > box to update it? By that account your touchpad is also removable as it
> > may stop functioning when its firmware gets updated.
> 
> The Thunderbolt controller is connected to a hotpluggable PCIe root port
> so it will be dissappear from the userspace so that "removable" in that
> sense is accurate.

There are systems as well where the Thunderbolt (and/or xHCI) controller
only appears if there is anything plugged to the physical Type-C ports
and it gets removed pretty soon after the physical device gets
unplugged. These are also the same Alpine Ridge and Titan Ridge
controllers that this patch is dealing with.

I tried to think about some sort of more generic heuristic how to figure
out that the controller is actually inside the physical system but there
is a problem that the same controller can appear on the bus as well, eg.
you plug in Thunderbolt dock and that one has xHCI controller too. That
device should definitely be "removable". With the "software CM" systems
we have a couple of additional hints in the ACPI tables that can be used
to identify the "tunneled" ports but this does not apply to the older
systems I'm afraid.

Now if I understand the reason behind this patch is actually not about
"removability" that much than about identifying a trusted vs. untrusted
device and attaching a driver to those. I was under impression that
there is already a solution to this in ChromeOS kernel. It has an
allowlist of drivers that are allowed to attach these devices and that
includes the PCIe port drivers, xhci_hcd and the thunderbolt driver,
possibly something else too. Is this not working for your case?

