Return-Path: <linux-pci+bounces-12972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F4C972D22
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 11:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF67282999
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45825188002;
	Tue, 10 Sep 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2bKFIaw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81358186E4B;
	Tue, 10 Sep 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959616; cv=none; b=D8is7BeLrr8sgEVAWmiPxOrfXekIp2o0OVREEuR+ps6sCMGditFX3F8xmaI/xqg/ZqOmHDJMdQJWk61ZU8unS8Z1ZKG1s8nSNKNevcmElNzfEXK3itoPSzNy0CnIve+v05cneNDs3bG1Sfy/b0JmPznnd9zhCpv1ZAfh3JX64FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959616; c=relaxed/simple;
	bh=YINo2g1H0Op1NpkCuXXnppwfgjGpy5ajXOb4LCsVAZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1c358P0nnUy2ZbSSeF4FtJJR80Nq8FM4XFCb15CSZ0cra9VbyOIb8N2F429kcezV0r0q6oTwgcygHLv/AjkZN/vQUA3h/rBXsGHt/EwQa+xoK0nBCa8KnOJtoYC9t7uZG2N+ULjEiUbF61Qn3Ds0qPcyu7qzwqIS0oN5U5YNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2bKFIaw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725959615; x=1757495615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YINo2g1H0Op1NpkCuXXnppwfgjGpy5ajXOb4LCsVAZY=;
  b=f2bKFIawRYPxlgoALOyzl/0bqVdaCGsI34R4clUFmy6Xol2WqSXghQEM
   XJP04uvF0TdkQNEF0M8CvXrDYktnT4bNOWMh4USuHSDgWmpcFpy5wePl6
   2EY3bwIaQzLN9kuyBC+oFaIZBBMeZnUcXbDrEBx+LA3egqOW0oQbSXpW9
   BQ4moR6laTSCBS8EUGbC+s9JVknSvv1Fb2+7c8CPCBE8L+H45bKwP1RSN
   dUrQ8jjBzoCjGmqYbAO1Bpx79bfjihyaOtJJFUQG0D7UcCHoWgEM8CjrM
   Y+IPnHuE7c7/dHMlUUjK2PLnaoiqJdIfmPiJo2DKKyg5s8Km7IjIRG+Hp
   w==;
X-CSE-ConnectionGUID: G52eIM+GQreFjZb/6oSmWw==
X-CSE-MsgGUID: uFVuNQp4T4KwSkNDk/eAiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="47210552"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="47210552"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 02:13:34 -0700
X-CSE-ConnectionGUID: HXDW64PPTlm42dqy064KGw==
X-CSE-MsgGUID: so8cop4WRbyQJo57SG7cqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="67256093"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 10 Sep 2024 02:13:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0EC5520B; Tue, 10 Sep 2024 12:13:30 +0300 (EEST)
Date: Tue, 10 Sep 2024 12:13:29 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Gary Li <Gary.Li@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
Message-ID: <20240910091329.GI275077@black.fi.intel.com>
References: <20240903182509.GA260253@bhelgaas>
 <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>
 <20240904120545.GF1532424@black.fi.intel.com>
 <2bf715fb-509b-4b00-a28d-1cc83c0bb588@amd.com>
 <20240905093325.GJ1532424@black.fi.intel.com>
 <b4237bef-809f-4d78-8a70-d962e7eb467b@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4237bef-809f-4d78-8a70-d962e7eb467b@amd.com>

Hi,

On Mon, Sep 09, 2024 at 03:40:54PM -0500, Mario Limonciello wrote:
> > Few additional side paths here, though. This is supposed to work so that
> > once the host router sleep bit is set the driver is supposed to allow
> > the domain to enter sleep (e.g it should not be waken up before it is
> > fully transitioned). That's what we do:
> > 
> > 1. All tunneled PCIe Root/Downstream ports are in D3.
> > 2. All tunneled USB 3.x ports are in U3.
> > 3. No DisplayPort is tunneled.
> > 4. Thunderbolt driver enables wakes.
> > 5. Thunderbolt driver writes sleep ready bit of the host router.
> > 6. Thunderbolt driver runtime suspend is complete.
> > 7. ACPI method is called (_PS3 or _PR3.OFF) that will trigger the "Sleep
> > Event".
> > 
> > If between 5 and 7 there is device connected, it should not "abort" the
> > sequence. Unfortunately this is not explict in the USB4 spec but the
> > connection manager guide has similar note. Even if the connect happens
> > there the "Sleep Event" should happen but after that it can trigger
> > normal wakeup which will then bring everything back.
> > 
> > Would it be possible to enable tracing around these steps so that we
> > could see if there is hotplug notification somewhere there that is not
> > expected? Here are instructions how to get pretty accurate trace:
> > 
> > https://github.com/intel/tbtools?tab=readme-ov-file#tracing
> > 
> > Please also take full dmesg.
> 
> Sure, here is the dmesg with tracing enabled:
> 
> https://gist.github.com/superm1/5186e0023c8a5d2ecd75c50fd2168308

Thanks! I meant also enable control channel tracing as explained in the
above linked page so we could maybe see the hotplug packet coming from
the lane adapter too. Anyhow,

[  560.789681] thunderbolt 0-2: device disconnected
[  560.789771] thunderbolt 0000:e5:00.5: bandwidth consumption changed, re-calculating estimated bandwidth
[  560.789775] thunderbolt 0000:e5:00.5: bandwidth re-calculation done
[  560.789778] thunderbolt 0000:e5:00.5: looking for DP IN <-> DP OUT pairs:
[  560.789800] thunderbolt 0000:e5:00.5: 0:6: DP IN available
[  560.789803] thunderbolt 0000:e5:00.5: 0:6: no suitable DP OUT adapter available, not tunneling
[  560.790484] thunderbolt 0000:e5:00.5: 0:7: DP IN available
[  560.790487] thunderbolt 0000:e5:00.5: 0:7: no suitable DP OUT adapter available, not tunneling
...
[  578.677640] thunderbolt 0000:e5:00.5: nhi_runtime_suspend() - enter, pdev->current_state = 0
[  578.677648] thunderbolt 0000:e5:00.5: 0: suspending switch
[  578.677653] thunderbolt 0000:e5:00.5: 0: enabling wakeup: 0x3f
[  578.678248] thunderbolt 0000:e5:00.5: stopping RX ring 0
[  578.678256] thunderbolt 0000:e5:00.5: disabling interrupt at register 0x38200 bit 3 (0x9 -> 0x1)
[  578.678272] thunderbolt 0000:e5:00.5: stopping TX ring 0
[  578.678277] thunderbolt 0000:e5:00.5: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[  578.678287] thunderbolt 0000:e5:00.5: control channel stopped
...
pci_pm_runtime_resume()
  pci_pm_default_resume_early(pci_dev);
    pci_pm_power_up_and_verify_state(pci_dev);
      pci_power_up(pci_dev);
        platform_pci_set_power_state(dev, PCI_D0);
	// here we should see acpi_pci_set_power_state() printing "xxx: power
	// state changed by ACPI to D0" but we don't.
	//
	// also pdev->current_state is set to PCI_D0
      pci_update_current_state(pci_dev, PCI_D0);
        // this one reads it back, it should be 0..
  pm->runtime_resume(dev);
    nhi_runtime_resume(dev)
[  578.773503] thunderbolt 0000:e5:00.5: nhi_runtime_resume() - enter, pdev->current_state = 3

// .. but it is not. It seems to be powered off, D3cold.

[  578.773516] thunderbolt 0000:e5:00.5: control channel starting...
[  578.773518] thunderbolt 0000:e5:00.5: starting TX ring 0
[  578.773524] thunderbolt 0000:e5:00.5: enabling interrupt at register 0x38200 bit 0 (0xffffffff -> 0xffffffff)

// As here too.

It would be interesting to see what ACPI does here, I mean enabling
dynamic debugging of acpi_device_set_power() and friends. One suspect is
that when the runtime suspends happens, the power resource or _PS3()
gets called to put the device into D3cold and it has some sort of
Sleep() inside. This allows the OS to relese the CPU to do other things
too according to ACPI spec (and Linux does this) so now when you plug in
the device the GPE triggers wake and Linux starts processing that one.
We see the above runtime resume but then the Sleep() in the _PS3()
completes and cuts the power from the NHI while we are in the middle of
resuming it already (or something along those lines).

We saw similar "context switch" happening when PCIe L2 failed, BIOS
implemented the timeout using Sleep() that allowed Linux to process
other things which resulted unexpected wake (not the same as here
though).

So one thing to check too is how the ACPI methods get called and
especially if they somehow end up messing with each other.

> > It is entirely possible that this has nothing to do with the issue but I
> > think it is worth checking.
> > 
> > The second thing we could try is to check the wake status bits after
> > this has happened, like:
> > 
> >    # tbdump -r 0 -a <ADAPTER> -vv -N 1 PORT_CS_18
> > 
> > (where <ADAPTER> is the lane 0 adapter of the USB4 port the device was
> > connected).
> > 
> 
> Unfortunately the adapter is in such a bad state at this time that tbdump
> doesn't work.

Oh, indeed it is.

> > The third thing to try is to comment out TB_WAKE_ON_CONNECT in
> > tb_switch_suspend(). This should result no wake even if the device is
> > connected. This tells us that it is really the connect on USB4 port that
> > triggered the wake.
> 
> Yup that's correct; there is no action on the hotplug with this change.

Okay thanks for checking.

