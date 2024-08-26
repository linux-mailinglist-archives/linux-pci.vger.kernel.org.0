Return-Path: <linux-pci+bounces-12185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645995E801
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 07:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999D41F2164E
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F957406F;
	Mon, 26 Aug 2024 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCaiuLts"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092FC8C11;
	Mon, 26 Aug 2024 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650870; cv=none; b=APLVVfjE676nXOsNZ+D0m73akViCGM4KIrI4qbvlhtXs3zRdQGvzwcasnrL3EdJcIFOsNHOeIPpAp6e+0utIoghlE+1GdqDN1DF/IK0YWrdxufP0SMgbnM2WleEqtMyCDKatDZFUOZ6P9zh6Kg0LHI98RimHt1UWg+rmVBTkgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650870; c=relaxed/simple;
	bh=ZgjdB7aPaO1sypANcAKJaeJod4EofF9iB1KGwas0yWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tadFPCfJqushYAMBYyK6otGC+9SD7FldNop9K3krIstQKxWUCiotfITe246FgwUVF4y/68mtdcLuXyNvXuhMLbfOBGglP97L4A5dg0Dk52lK5K9Vs5ONyiFUVq7O4vg80LDWFSbPfyr8LdNPRhfQu+4iwUgWtYzhj66HQlq6SVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCaiuLts; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724650868; x=1756186868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZgjdB7aPaO1sypANcAKJaeJod4EofF9iB1KGwas0yWg=;
  b=ZCaiuLtskpRtBy7+FFycH8lqrxxvkUPEsOKskyRGERX2zkHo9+ABUOCL
   DyjZwi/OWEUhHWvpD/wC9JDhqpwTFVSOJF5pezrROIcUnuWx66v1e3o9h
   x4eFGVM45cYs2IJq6qPPMluI4sYULJ/CDohXpMMefCK8wzYFbxuKvTDi3
   gCm2RA39EtGLK/ijqqRfn+iQpPbniG+QyOhvMD2bLLoQll5WIDM0eqhvS
   BGVc9kvOXYAZaZ/GRE6mV09KSLDACQjdCXHk6Zt9F23OHnwk3Blv3cxHY
   rGB8pcb7e68XoxBoddyLXeKshSEw+mzN7kkuikLvSxhdnQYFLThMbFS8s
   g==;
X-CSE-ConnectionGUID: fC82BljUQWSbj9qr8RSkWQ==
X-CSE-MsgGUID: Antjn2j2SsWlJbAGT7kdww==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="40562237"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="40562237"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 22:41:07 -0700
X-CSE-ConnectionGUID: rLXI0cuYQyWoNSIeCC2JIA==
X-CSE-MsgGUID: 1u0SR9TsRjybyBfIM1YaOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="85585990"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 25 Aug 2024 22:41:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 18106444; Mon, 26 Aug 2024 08:41:03 +0300 (EEST)
Date: Mon, 26 Aug 2024 08:41:03 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240826054103.GO1532424@black.fi.intel.com>
References: <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
 <20240516083017.GA1421138@black.fi.intel.com>
 <20240516100315.GC1421138@black.fi.intel.com>
 <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
 <ZnvWTo1M_z0Am1QC@wunner.de>
 <20240626085945.GA1532424@black.fi.intel.com>
 <ZqZmleIHv1q3WvsO@wunner.de>
 <20240729080441.GG1532424@black.fi.intel.com>
 <Zss_zqsJOZKes1Dp@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zss_zqsJOZKes1Dp@wunner.de>

Hi Lukas,

On Sun, Aug 25, 2024 at 04:29:34PM +0200, Lukas Wunner wrote:
> On Mon, Jul 29, 2024 at 11:04:41AM +0300, Mika Westerberg wrote:
> > On Sun, Jul 28, 2024 at 05:41:09PM +0200, Lukas Wunner wrote:
> > > Do the DROMs on ICM root switches generally lack PCIe Upstream and
> > > Downstream Adapter Entries?
> > 
> > My guess is that they are not populated for ICM host router DROM
> > entries. These are pretty much Apple stuff and USB4 dropped them
> > completely in favour of the router operations.
> 
> I note that Microsoft specifies a "usb4-port-number" for PCIe Downstream
> Adapters as well as DP and USB ports:
> 
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> 
> Presumably the "usb4-port-number" allows for associating a
> pci_dev with a tb_port.  So that's a third way to do that,
> on top of DROM entries and the USB4 router operation.

It matches the "USB4 port" number of the host router.

> What I don't quite understand is whether the "usb4-port-number"
> is only present on PCIe Adapters of the Host Router or whether
> it can also exist on PCIe Adapters of Device Routers?

It is is only present on host router and only for PCIe and USB ports
(I'ven not seen it been used with DisplayPort).

> I would also like to know whether "usb4-port-number" is set on
> the machines that Esther's quirk seeks to fix?

This is only present in USB4 software connection manager systems so not
on any of those as far as I can tell.

