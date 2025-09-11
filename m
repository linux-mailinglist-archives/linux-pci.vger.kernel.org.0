Return-Path: <linux-pci+bounces-35890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DBDB52D5D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 11:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B441C85722
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698D2E9735;
	Thu, 11 Sep 2025 09:33:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95222E8B61
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583215; cv=none; b=k5JxeU2jGCeREF0vKMFIDSRTg+htAsRpRXqJUAdC2Yz7z5BmQefGIAP5+CgsUwHDh4DlBC3LCo7lCOARiJbOTeTBX6mxtQqh4YyCVpYOZJ9kCp5lzFLZd+OzzGBu+1O3lxsP5W7HzlMGB/N5AEyZEJoZlWYQ5cwoW55lg387/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583215; c=relaxed/simple;
	bh=oL7C1B2/D20JAtRB6vupdKOlaQDH4AP8vfILkMJO1Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAnxs1N3p0YryaXqwIPw0xoyLC6PfwvbFbR/FfXPChCwQdUNH1rDtS0W2GIvoJXV1BJ8I+z1ARI7fNbmACRocXenLlt44yKW7Zy7NmdCDGTSthBUuDWF+LCq/xd5Pa4P5fbP5WKjXf6oW539AHAiGygOU895G2l5Fhzo+n14HgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 9BEDC72C8CC;
	Thu, 11 Sep 2025 12:24:45 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 9179236D0196;
	Thu, 11 Sep 2025 12:24:45 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id 68A2E360D68F; Thu, 11 Sep 2025 12:24:45 +0300 (MSK)
Date: Thu, 11 Sep 2025 12:24:45 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hui Wang <hui.wang@canonical.com>, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, raphael.norwitz@nutanix.com, alay.shah@nutanix.com, 
	suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick <jonathan.derrick@linux.dev>, 
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Message-ID: <ryrirg2yqwnkqaw3rk56p75tdn@altlinux.org>
References: <16f95861-6e71-49e4-b8f5-6d874e7db700@canonical.com>
 <20250811230445.GA168752@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811230445.GA168752@bhelgaas>

Bjorn,

On Mon, Aug 11, 2025 at 06:04:45PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 08, 2025 at 10:23:45AM +0800, Hui Wang wrote:
> > Hi Bjorn,
> > 
> > Any progress on this issue, do we have a fix for this now? The
> > ubuntu users are waiting for a fix :-).
> 
> Not yet, but thanks for the reminder.  Keep bugging me!

Other distributions' users waiting for the fix too!

Thanks,

> 
> PCIe r7.0, sec 2.3.1, makes it clear that devices are permitted to
> return RRS after FLR:
> 
>   ◦ For Configuration Requests only, if Device Readiness Status is not
>     supported, following reset it is permitted for a Function to
>     terminate the request and indicate that it is temporarily unable
>     to process the Request, but will be able to process the Request in
>     the future - in this case, the Request Retry Status (RRS)
>     Completion Status must be used (see § Section 6.6). Valid reset
>     conditions after which a device/Function is permitted to return
>     RRS in response to a Configuration Request are:
> 
>     ▪ FLRs
> 
>     ...
> 
> But I am a little bit concerned because sec 2.3.2, which talks about
> how a Root Complex handles that RRS and the RRS Software Visiblity
> feature, says (note the "system reset" period):
> 
>   Root Complex handling of a Completion with Request Retry Status for
>   a Configuration Request is implementation specific, except for the
>   period following SYSTEM RESET (see § Section 6.6). For Root
>   Complexes that support Configuration RRS Software Visibility, the
>   following rules apply:
> 
>     ◦ If Configuration RRS Software Visibility is enabled:
> 
>       ▪ For a Configuration Read Request that includes both bytes of
> 	the Vendor ID field of a device Function's Configuration Space
> 	Header, the Root Complex must complete the Request to the host
> 	by returning a read-data value of 0001h for the Vendor ID
> 	field and all 1's for any additional bytes included in the
> 	request.
> 
> So I'm worried that the Software Visibility feature might work after
> *system reset*, but not necessarily after an FLR.  That might make
> sense because I don't think the RC can tell when we are doing an FLR
> to a device.
> 
> It seems that after FLR, most RCs *do* make RRS visible via SV.  But
> if we can't rely on that, I don't know how we're supposed to learn
> when a device becomes ready.
> 
> Bjorn
> 
> > On 7/3/25 08:05, Hui Wang wrote:
> > > On 7/2/25 17:43, Hui Wang wrote:
> > > > On 7/2/25 07:23, Bjorn Helgaas wrote:
> > > > > On Tue, Jun 24, 2025 at 08:58:57AM +0800, Hui Wang wrote:
> > > > > > Sorry for late response, I was OOO the past week.
> > > > > > 
> > > > > > This is the log after applied your patch:
> > > > > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/61
> > > > > > 
> > > > > > Looks like the "retry" makes the nvme work.
> > > > >
> > > > > Thank you!  It seems like we get 0xffffffff (probably PCIe
> > > > > error) for a long time after we think the device should be
> > > > > able to respond with RRS.
> > > > > 
> > > > > I always thought the spec required that after the delays, a
> > > > > device should respond with RRS if it's not ready, but now I
> > > > > guess I'm not 100% sure.  Maybe it's allowed to just do
> > > > > nothing, which would lead to the Root Port timing out and
> > > > > logging an Unsupported Request error.
> > > > > 
> > > > > Can I trouble you to try the patch below?  I think we might
> > > > > have to start explicitly checking for that error.  That
> > > > > probably would require some setup to enable the error, check
> > > > > for it, and clear it.  I hacked in some of that here, but
> > > > > ultimately some of it should go elsewhere.
> > ...

