Return-Path: <linux-pci+bounces-6475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E329D8AA7CE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 06:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957C5281729
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 04:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5396C8BE2;
	Fri, 19 Apr 2024 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYw7ECwj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F38029A2;
	Fri, 19 Apr 2024 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713502192; cv=none; b=gHyh41LFtROcOrCWIIwudy2rUY1ahjoGLXLF8dkxaHVsTkvQ/+MaTcYM2SjIXlCpYTjpX9ABwsRP6cD0e57+SpgxrafsnELCqOfsKQNmOLZKv4q+c4vR6P2JYHQh+Z51dsUe9sc1vhXDAkTbzGut/cJ15LwVQMi+PzaOPA0pSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713502192; c=relaxed/simple;
	bh=ywLpntLIjzzq+kvvOLjtm+MThHrtTAjorMuXcYJc6g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQZ1gpM6hB2WearV7rOeka2rRngGaL5MiFz7ZXnF9HBbE+GdAvzxCWFsdCv8P8JbqLYNCYRwvShJRQNIwpbgc7EMKRErjKlI2acPHNGqZUBDHNtN+6cHto7Pjfjn9bUpiAHsUt5Ov/KiE4YfNDCxnyfxk0/yil4Oj1bnc3pDUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYw7ECwj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713502191; x=1745038191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ywLpntLIjzzq+kvvOLjtm+MThHrtTAjorMuXcYJc6g8=;
  b=lYw7ECwjYVL4/qKVq4prT1PJDKhl5gpBZWkU9rCNz/QJvAP4UQvee/7R
   Kg3S0P4RLzdZTh6N9lF4yM1oQyUnMtWwIPX2Es06xx1Ji6wGhMRC9Ji85
   Kto0TjpFEYJ4qc1QIlsqWfj9tEzxulZa6Ga7jO5yhZggkG141HexqO7QV
   iFFfJmW1tPyY2YQBqIhmbS7zxZu9T/ETPn6qRfCEgzEZHf0Wr4hg/t5zY
   lGopGIpt6N5WAj1/UyfbsSNgFTUxsEgxq5gN2mrIAD9NxFQ3+PSTxOsQJ
   jdE9X8w0pbTR24BYqp39Tfg2p447dCjoFurNMpnrk6vrMzy+CKmSWcpxm
   A==;
X-CSE-ConnectionGUID: ib90uHpUQ/SsThVQ6oJ26Q==
X-CSE-MsgGUID: 2YZxhgcxSTCC9bR2XptzOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="34484224"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="34484224"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 21:49:49 -0700
X-CSE-ConnectionGUID: Z5HZc5dGQZ+4vcbl3Wk/BA==
X-CSE-MsgGUID: b1VsuKx8SAmM9KC+ZjhyUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="60649115"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 18 Apr 2024 21:49:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 9167E18F; Fri, 19 Apr 2024 07:49:45 +0300 (EEST)
Date: Fri, 19 Apr 2024 07:49:45 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240419044945.GR112498@black.fi.intel.com>
References: <ZalOCPrVA52wyFfv@google.com>
 <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com>
 <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com>
 <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>

Hi,

On Thu, Apr 18, 2024 at 03:43:08PM -0400, Esther Shimanovich wrote:
> Thank you for your response! It is very much appreciated.
> 
> On the Tiger Lake device I was testing on, the usb4-host-interface
> value is NOT listed in its ACPI.
> 
> I then decided to query the ACPI values collected from devices in my
> office, to see if this issue is limited to my device.
> Ice Lake - 4 devices, none had "usb4-host-interface"
> Tiger Lake - 31 devices, none have "usb4-host-interface"
> Alder Lake - 32 devices, I see that 15 of them have
> "usb4-host-interface" in their ACPI
> Raptor Lake - 1 device, does not have "usb4-host-interface"
> 
> It looks like only Alder Lake has usb4-host-interface  listed in its
> ACPI for whatever reason.

The reason is that it is there only for "software connection manager"
systems. That's Chrome TGL and then all ADL and beyond (with integrated
Thunderbolt/USB4).

> It seems like I cannot use usb4-host-interface as a determinant
> whether the CPU has Thunderbolt capabilities (thus not needing a
> discrete Thunderbolt chip).
> ExternalFacingPort is listed in devices that don't have CPUs with
> Thunderbolts, so that can't be a determinant.
> 
> Am I missing something?

"ExternalFacingPort" is there for all firmware and software connection
manager systems but only if they use IOMMU for DMA security (also
/sys/bus/thunderbolt/devices/domainX/iommu_dma_protection == 1). So this
is all integrated (Ice Lake+), then Alpine Ridge, Titan Ridge and Maple
Ridge based recent systems.

That leaves out still older systems with firmware connection manager
with the "legacy" security settings. This is pretty much Alpine and
Titan Ridge and I think those you can identify using their PCI IDs
directly as the list will not be too big. Something like this taken from
the drivers/thunderbolt/nhi.h:

#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_BRIDGE      0x15c0
#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE    0x15d3
#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_BRIDGE    0x15da
#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE       0x15e7
#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE       0x15ea
#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE       0x15ef

In addition to this some of the systems used the BIOS "assisted"
enumeration which means that the controller is actually only present if
you have either USB or Thunderbolt device connected. Othertimes it is
not present at all (not sure if you want to label these differently
though).

In summary if you want to find out if the CPU has an integrated
Thunderbolt/USB4 controller (I think this is what you ask above) then
the best bet would be to use "ExternalFacingPort" because that is
present in all those systems.

