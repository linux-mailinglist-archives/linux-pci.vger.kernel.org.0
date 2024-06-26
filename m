Return-Path: <linux-pci+bounces-9271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB312917A2E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659462825AB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C515D5CF;
	Wed, 26 Jun 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RM6M8uLa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023015B55D;
	Wed, 26 Jun 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388427; cv=none; b=e5KMXzVyDmF+tni/jCWvJf1siRhNFDEHmJT9cY0q75ZkK83MWuDZ3Muahg879vfUQ/0fLWSGnGRiMVxLLGfQrXT7sodSvPAqFNOekuFrvpR9I7kd8jfV5JWZbm0JfbPlwnVJwjoMfNM8h8usiO5pGU8BgmSKX87BTw+rKF2/O6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388427; c=relaxed/simple;
	bh=fsRwahzF+DAn3/q4k6IPtufQdWLhcg2lFAnXar2y644=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsVRLkqohJDqWfqk2gF5lIQLgdjSAQTvlERMuS+Kb8kUPntcv1vi/tCQ2h351bQIpW81JKLsE1GFD6PKnt74s2YFoyrlinbBRmNuZ9vkR/ReBjJZ3K0432G3I1AxhkIOVnX6PjUcdFNP4ZswkcMhfiXD3uxp/KfCRYA0+DT0ndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RM6M8uLa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719388426; x=1750924426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fsRwahzF+DAn3/q4k6IPtufQdWLhcg2lFAnXar2y644=;
  b=RM6M8uLaVXenjM8Fi7IQSaeuNEGXWuTZHjEEpxfFckCy8g63wRWs3h0f
   mokruKoTEQ2jLdBSnACoWtaEmrwa4axGmLrCSySJXxJNvUOAFTgwh4HIE
   TgtrGqhfu+qd4VvYlF0iLndfIv5veR5ZI/XSt8cTy+i/E2d3g/kd9i8/q
   P6NZuHUNcyyp7HgyCl2qCE5zJ7byZ/5ljE2sRH5xFWEVXvCniWCRJrbY2
   2xbBSQDCgYXut8bGaUYLRmmiyPO0mSYwYwKb4urr/LvMAmnx6JBJe+Hfo
   Z1iGvyF/q2yqmiztkj5JsC0H0REzc498o0+Ei7L1Gxw0p+J7UlsvWlI34
   g==;
X-CSE-ConnectionGUID: VZq/so0xT5mxkpHui2/boQ==
X-CSE-MsgGUID: RDxSzAbFSEmWBthBq4kriQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16669603"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16669603"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 00:53:45 -0700
X-CSE-ConnectionGUID: DdDVk+asRuCOixyJq2FVXQ==
X-CSE-MsgGUID: WeSwgWUCTXqIyWlzFtOimw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="49088979"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 26 Jun 2024 00:53:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 64B56346; Wed, 26 Jun 2024 10:53:41 +0300 (EEST)
Date: Wed, 26 Jun 2024 10:53:41 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>
Subject: Re: [PATCH 0/4] Verify devices transition from D3cold to D0
Message-ID: <20240626075341.GY1532424@black.fi.intel.com>
References: <20240613054204.5850-1-mario.limonciello@amd.com>
 <20240618131452.GC1532424@black.fi.intel.com>
 <9f465ec4-32b9-4cd8-89de-a57a99880360@amd.com>
 <20240619052927.GF1532424@black.fi.intel.com>
 <5a04e554-9f18-43c0-8095-d3e0c83db76d@amd.com>
 <a9436f1c-330b-469d-bb93-3e89102b09b9@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9436f1c-330b-469d-bb93-3e89102b09b9@amd.com>

On Tue, Jun 25, 2024 at 10:43:20AM -0500, Mario Limonciello wrote:
> On 6/19/2024 13:50, Mario Limonciello wrote:
> > On 6/19/2024 00:29, Mika Westerberg wrote:
> > > On Tue, Jun 18, 2024 at 11:56:50AM -0500, Mario Limonciello wrote:
> > > > On 6/18/2024 08:14, Mika Westerberg wrote:
> > > > > Hi Mario,
> > > > > 
> > > > > On Thu, Jun 13, 2024 at 12:42:00AM -0500, Mario Limonciello wrote:
> > > > > > Gary has reported that when a dock is plugged into a
> > > > > > system at the same
> > > > > > time the autosuspend delay has tripped that the USB4
> > > > > > stack malfunctions.
> > > > > > 
> > > > > > Messages show up like this:
> > > > > > 
> > > > > > ```
> > > > > > thunderbolt 0000:e5:00.6: ring_interrupt_active:
> > > > > > interrupt for TX ring 0 is already enabled
> > > > > > ```
> > > > > > 
> > > > > > Furthermore the USB4 router is non-functional at this point.
> > > > > 
> > > > > Once the USB4 domain starts the sleep transition, it cannot be
> > > > > interrupted by anything so it always should go through full sleep
> > > > > transition and only then back from sleep.
> > > > > 
> > > > > > Those messages happen because the device is still in
> > > > > > D3cold at the time
> > > > > > that the PCI core handed control back to the USB4 connection manager
> > > > > > (thunderbolt).
> > > > > 
> > > > > This is weird. Yes we should be getting the wake from the hotplug but
> > > > > that should happen only after the domain is fully in sleep
> > > > > (D3cold). The
> > > > > BIOS ACPI code is supposed to deal with this.
> > > > 
> > > > Is that from from experience or do you mean there is a spec behavior?
> > > > 
> > > > IE I'm wondering if we have different "expectations" from different
> > > > company's hardware designers.
> > > 
> > > The spec and the CM guide "imply" this behaviour as far as I can tell,
> > > so that the "sleep event" is done completely once started. I guess this
> > > can be interpreted differently too because it is not explicitly said
> > > there.
> > > 
> > > Can you ask AMD HW folks if this is their interpretation too? Basically
> > > when we get "Sleep Ready" bit set for all the routers in the domain and
> > > turn off power (send PERST) there cannot be wake events until that is
> > > fully completed.
> > > 
> > > There is typically a timeout mechanism in the BIOS side (part of the
> > > power off method) that waits for the PCIe links to enter L2 before it
> > > triggers PERST. We have seen an issue on our side that if this L2
> > > transition is not completed in time a wake event triggered but that was
> > > a BIOS issue.
> > 
> > Sure thing.  I'll discuss it with them and get back with the results.
> 
> From the hardware team they describe this as an abnormal state that they
> don't expect.  I don't believe there is anything in the BIOS to prevent it
> though.

Okay thanks for checking.

> 
> I could discuss options for this with the BIOS team in the future for the
> USB4 router ACPI device, but as this "seems" to be the same problem as XHCI
> controllers going back at least 5 generations with those quirks I put
> reverts in this series I think a general kernel solution to make "sure" that
> devices have transitioned is the better way to go.

Agreed.

