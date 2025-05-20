Return-Path: <linux-pci+bounces-28135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 440AAABE304
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 20:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9F81BC21B2
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50562820A5;
	Tue, 20 May 2025 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkESjV87"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A9A28151E;
	Tue, 20 May 2025 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766584; cv=none; b=p9+PTg+F8xbXTiV6SwgHn2g8DHhRkD21UCWwlHAyNEQSHpnxvnlQ5ss0czAJrTLA5kGcsCSkVQ1HqLrFRlVQRD8K3cwfAN5mz5eFYWiZE8U1sQ93geFr3wt6qtDA7TWoqSecPz7cMAcMg7cwJ+TvOWfmJRGxVAjjqYL93Cc312U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766584; c=relaxed/simple;
	bh=RzRcyyxnsvIp9rQq1aJgSFL7GqkqlgKUiiG/uQNBHq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaZ6K4E5ejvbLK+aXSR+xeueQmlHRdql+apsoPSlYxbSiZbk/utXn5uhLZQoyW/m862ZShsTEQI6Oy2Aw69SDe3M8LPIVPl9x2Ld0z6gVLkFWVWASRCPR1OCBnCI0bMvKqNrTshHbpq2V3q/lyBdaeGUNM9CfryhjAQ2E9LSVWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkESjV87; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747766583; x=1779302583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RzRcyyxnsvIp9rQq1aJgSFL7GqkqlgKUiiG/uQNBHq8=;
  b=hkESjV87WfH7q9w2Yk9Q1oQ//3/2/Lx4ZoyyLziiCkIbzf1pWvh9GrtX
   xymz6jwiDIzjtcOd/C6k6FbTy9jYx4sBgboL8hBZKc/q+bSOwEAD/csTY
   FMR+SXGU7RMTRbrEQsn8z1lKIV1IXmSfXCXNSo1FLY2ou4WJxUzZSgY/f
   /krWX3ApMbsO13dq2BxgeE2TL3L54h6zzCVzBMNWVxzSADHGGuHsf3WGr
   JJAWbbrzKTjb11lOsyCJPkyyuEsEzjC2R5q2ecPfzLeLoq8/m0jfuWlWE
   UKEv5EM8vJf9M29gHASRqsKCzxvhZ2fdWQX2mNGPgSZQ2/F3rEwLK+HE9
   Q==;
X-CSE-ConnectionGUID: nHgGVxBZRb26Y0cgxrvqdA==
X-CSE-MsgGUID: 8nnZsU6MRum2HSRjfHmIYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="61110790"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="61110790"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:43:02 -0700
X-CSE-ConnectionGUID: g6zN9/HZT2Sl8gVW2+1uDg==
X-CSE-MsgGUID: r5vPL/OUSpeWOV4yHn0pLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144519254"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:42:59 -0700
Date: Tue, 20 May 2025 21:42:55 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>, rafael@kernel.org,
	mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aCzNL9uXGbBSdF2S@black.fi.intel.com>
References: <20250519102808.4130271-1-raag.jadav@intel.com>
 <aCsK743YSuahPtnH@black.fi.intel.com>
 <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
 <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
 <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com>
 <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>
 <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>

On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:
> On 5/20/2025 12:22 PM, Denis Benato wrote:
> > On 5/20/25 17:49, Mario Limonciello wrote:
> > > On 5/20/2025 10:47 AM, Raag Jadav wrote:
> > > > On Tue, May 20, 2025 at 10:23:57AM -0500, Mario Limonciello wrote:
> > > > > On 5/20/2025 4:48 AM, Raag Jadav wrote:
> > > > > > On Mon, May 19, 2025 at 11:42:31PM +0200, Denis Benato wrote:
> > > > > > > On 5/19/25 12:41, Raag Jadav wrote:
> > > > > > > > On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jadav wrote:
> > > > > > > > > If error status is set on an AER capable device, most likely either the
> > > > > > > > > device recovery is in progress or has already failed. Neither of the
> > > > > > > > > cases are well suited for power state transition of the device, since
> > > > > > > > > this can lead to unpredictable consequences like resume failure, or in
> > > > > > > > > worst case the device is lost because of it. Leave the device in its
> > > > > > > > > existing power state to avoid such issues.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > > > > > > ---
> > > > > > > > > 
> > > > > > > > > v2: Synchronize AER handling with PCI PM (Rafael)
> > > > > > > > > v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
> > > > > > > > >        Elaborate "why" (Bjorn)
> > > > > > > > > v4: Rely on error status instead of device status
> > > > > > > > >        Condense comment (Lukas)
> > > > > > > > Since pci_aer_in_progress() is changed I've not included Rafael's tag with
> > > > > > > > my understanding of this needing a revisit. If this was a mistake, please
> > > > > > > > let me know.
> > > > > > > > 
> > > > > > > > Denis, Mario, does this fix your issue?
> > > > > > > > 
> > > > > > > Hello,
> > > > > > > 
> > > > > > > Unfortunately no, I have prepared a dmesg but had to remove the bootup process because it was too long of a few kb: https://pastebin.com/1uBEA1FL
> > > > > > 
> > > > > > Thanks for the test. It seems there's no hotplug event this time around
> > > > > > and endpoint device is still intact without any PCI related failure.
> > > > > > 
> > > > > > Also,
> > > > > > 
> > > > > > amdgpu 0000:09:00.0: PCI PM: Suspend power state: D3hot
> > > > > > 
> > > > > > Which means whatever you're facing is either not related to this patch,
> > > > > > or at best exposed some nasty side-effect that's not handled correctly
> > > > > > by the driver.
> > > > > > 
> > > > > > I'd say amdgpu folks would be of better help for your case.
> > > > > > 
> > > > > > Raag
> > > > > 
> > > > > So according to the logs Denis shared with v4
> > > > > (https://pastebin.com/1uBEA1FL) the GPU should have been going to BOCO. This
> > > > > stands for "Bus off Chip Off"
> > > > > 
> > > > > amdgpu 0000:09:00.0: amdgpu: Using BOCO for runtime pm
> > > > > 
> > > > > If it's going to D3hot - that's not going to be BOCO, it should be going to
> > > > > D3cold.
> > > > 
> > > > Yes, because upstream port is in D0 for some reason (might be this patch
> > > > but not sure) and so will be the root port.
> > > > 
> > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D0
> > > > pcieport 0000:07:00.0: PCI PM: Skipped
> > > > 
> > > > and my best guess is the driver is not able to cope with the lack of D3cold.
> > > 
> > > Yes; if the driver is configured to expect BOCO (D3cold) if it doesn't get it, chaos ensues.
> > > 
> > > I guess let's double check the behavior with CONFIG_PCI_DEBUG to verify this patch is what is changing that upstream port behavior.
> > 
> > 
> > This is the very same exact kernel, minus the patch in question:  https://pastebin.com/rwMYgG7C
> > 
> > 
> > Both previous kernel and this one have CONFIG_PCI_DEBUG=y.
> > 
> > Removed the initial bootup sequence to be able to use pastebin.
> 
> Thanks - this confirms that the problem is the root port not going to D3.
> This new log shows:
> 
> pcieport 0000:07:00.0: PCI PM: Suspend power state: D3hot
> 
> So I feel we should fixate on solving that.

Which means what you're looking for is error flag being set somewhere in
the hierarchy that is preventing suspend.

But regardless of it, my understanding is that root port suspend depends
on a lot of factors (now errors flags being one of them with this patch)
and endpoint driver can't possibly enforce or guarantee it - the best it
can do is try.

What's probably needed is D3cold failure handling on driver side, but I'm
no PCI PM expert and perhaps Rafael can comment on it.

Raag

