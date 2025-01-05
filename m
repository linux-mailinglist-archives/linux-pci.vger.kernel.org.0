Return-Path: <linux-pci+bounces-19308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21FA0187E
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 09:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8F9162867
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 08:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC771CA84;
	Sun,  5 Jan 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfh4j2WQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9510FD;
	Sun,  5 Jan 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736065525; cv=none; b=IFVYJtWILQDl3kSj4YnRWHlaH81Ik+PyzymWprJ2Bs+qSMWvOmksOJAfnrOLzLEkdS1ACJy/+xAfmX3NJ3EKWyp1oOgWb1X6EqbnEd1vHVeSdYPirXD9rjBwy4bGuU5p+Fx8QMnVkK432b7srB2XfJug7pUV1eUPkYCnbUBEu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736065525; c=relaxed/simple;
	bh=vcWHcn6d78iRsBdRFvzNcgcC2FLW4T3I3h05kztpyak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmJQIIDoTBkPI9nJDcTaFhzS2NRMXzuNRd4Ss8YAFDIGdMP14YyvjChf5V5X+MJ25gRHbt6lpGgZWSlAwfRdxDo8jAFa0Iv6rBmqRxMrQFE4lDPRF7skoU8MrzmJZ2spSwUd3dUVV0f8v/nroQaOTThwlSytRJngvozoLxHyXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfh4j2WQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736065524; x=1767601524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vcWHcn6d78iRsBdRFvzNcgcC2FLW4T3I3h05kztpyak=;
  b=jfh4j2WQjc1eB3m8PkwCtbxmWeZu8A8kDun7L6XWL5ISWsR/M+lSKSX5
   qSa9S34cXickFPSCP8RA9n7ynGGv0mPSiL49U6gFKtd/yo/eNCNoPQx3G
   UuuurOIcQdaHNlaKqRYKfDP8DwArUuzGVl1iT4i5g/IINkBudl2aNWZJz
   5FSuJ8KM3hehj/BO1WeMnqV2NMsXsAruiSDfT4IQkjHLWtRA7m1bvG2aB
   VQQyoZwfH2au2laCflmo8C/2WeDp/wWACn7ltN1azfxkpjza2/z8X/19J
   +F1brj5KzXCq/6Delff6M9rRc8uXq+B3svKdtnFv/vkB8UrqXmV43aTwA
   w==;
X-CSE-ConnectionGUID: QqCUdNxlQRCTra3Ras/HoQ==
X-CSE-MsgGUID: dHbLbuQbSJedORaig7OwrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11305"; a="36392812"
X-IronPort-AV: E=Sophos;i="6.12,290,1728975600"; 
   d="scan'208";a="36392812"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 00:25:23 -0800
X-CSE-ConnectionGUID: V9kRf1YNTJuDaBpAwrPO1g==
X-CSE-MsgGUID: 3oxBs6g9QNiOjnkhy0OhGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102009693"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 05 Jan 2025 00:25:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4B60926A; Sun, 05 Jan 2025 10:25:20 +0200 (EET)
Date: Sun, 5 Jan 2025 10:25:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Yet another quirk for PIO log size on Intel
 Raptor Lake-P
Message-ID: <20250105082520.GT3713119@black.fi.intel.com>
References: <20250102164315.7562-1-tiwai@suse.de>
 <20250103225315.GA12322@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103225315.GA12322@bhelgaas>

Hi,

On Fri, Jan 03, 2025 at 04:53:15PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 02, 2025 at 05:43:13PM +0100, Takashi Iwai wrote:
> > There is yet another PCI entry for Intel Raptor Lake-P that shows the
> >   error "DPC: RP PIO log size 0 is invalid":
> >   0000:00:07.0 PCI bridge [0604]: Intel Corporation Raptor Lake-P Thunderbolt 4 PCI Express Root Port #0 [8086:a76e]
> >   0000:00:07.2 PCI bridge [0604]: Intel Corporation Raptor Lake-P Thunderbolt 4 PCI Express Root Port #2 [8086:a72f]
> > 
> > Add the corresponding quirk entry for 8086:a72f.
> > 
> > Note that the one for 8086:a76e has been already added by the commit
> > 627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root
> > Ports").
> 
> Intel folks, what's the long-term resolution of this?  I'm kind of
> tired of adding quirks like this.  So far we have these (not including
> the current patch), dating back to Aug 2022:
> 
>   627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports")
>   3b8803494a06 ("PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports")
>   5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root Ports")
> 
> I *thought* this problem was caused by BIOS defects that were supposed
> to be fixed, but nothing seems to be happening.

As far as I know it should be fixed already. I just checked my MTLP and PTL
systems (both with integrated TBT PCIe root ports) and I don't see the
message anymore. I don't have RPL system though. This is on reference
hardware and BIOS so it is possible that the fix has not been taken into
the OEM BIOS.

