Return-Path: <linux-pci+bounces-22635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9B9A497C0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 11:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7933BC799
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E580C25D218;
	Fri, 28 Feb 2025 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmYLxoiz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D31B4250;
	Fri, 28 Feb 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739771; cv=none; b=VAKR9FJwdAc6FkSDyKQV3oCKjrAphw/ZU3WQ2WUOU/edqmW5Tk68YivnEIrBRFWUSJRgdf1Nyn4ePOqHa00gT5P37nRHTXUE6c77dyObwOWjwdgaeNq9vHhOyk3oZV3gVzpu5Iss1elkFqo0+/P1PlTchbIj2fljgHdQmWeMjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739771; c=relaxed/simple;
	bh=6Gf+WSPrlbTAJ/XWPWj3WRZAIjUVfEvP8NxsUg6aEE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnHnWqsOJZOxGhoO6JKsjO3e4SqDgFYRhVl5/xCspu6+CH41RUG6bYNVFvQsbXmMwd2Npb5+80+ceqtl3qY2qAWHFNpsF6+0wXQMwmgDw0efK1KDMwr87EvME2vZRpyG2CvE5FvcJypESEYZKX6JRGer/uUAiUCx04Geyc1nxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmYLxoiz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740739771; x=1772275771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Gf+WSPrlbTAJ/XWPWj3WRZAIjUVfEvP8NxsUg6aEE0=;
  b=YmYLxoizPvtxsDJzK+zC19+1+4rJjdwoPXoUgYR1dyeGLMn5J8shh5ZD
   0PAJrHx0a37EdXXeHDd2cyqb36kaCTo2/wguOXb2cxkOeCsITjXJnmZml
   HaFDf8xYnPiLSxc7K4MoaFS48gbpgWFof+pHbwXmFh1KVZ8Ggl+wEcBZ6
   YKXlqxCp+j9QT+GCxuBwbchNV1c686VZFRWXq8iWK5SDJIIxaYyfa8Ky/
   E3bBThkbYojRqDTMbatVq9w6tJ6B1c3b0FNRFuRLU/F3/kgpIYSXcpXmH
   cFODrbCLhCcRnvIuRhtjze7sLcVyaYRQlQWtqYorxiIkwP/RSOgoMhvcX
   g==;
X-CSE-ConnectionGUID: hBcgigImTXq7dPYiYH211w==
X-CSE-MsgGUID: Dn5Nj/t0TCiWRfnXz4rqjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52299045"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="52299045"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:49:30 -0800
X-CSE-ConnectionGUID: HiJu018vS+iwtbxZmJFI0w==
X-CSE-MsgGUID: H9o4/NGjRDq4QGER7HElmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="121913710"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 28 Feb 2025 02:49:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 9DF31297; Fri, 28 Feb 2025 12:49:25 +0200 (EET)
Date: Fri, 28 Feb 2025 12:49:25 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kenneth Crudup <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <20250228104925.GO3713119@black.fi.intel.com>
References: <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
 <b6eff06e-1a8c-48c3-b536-39b567015d0c@panix.com>
 <5c131927-87c1-4e21-90f8-8e3a34cd6dbf@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c131927-87c1-4e21-90f8-8e3a34cd6dbf@panix.com>

Hi,

On Thu, Feb 27, 2025 at 09:46:07AM -0800, Kenneth Crudup wrote:
> So I think, the failure mode may be related in some part to DP/Tunneling,
> too- I finally got another lockup (this time, after a hibernate, which I
> guess is some of the same facility) but what was different about this time
> where I couldn't reproduce the lockups (and what happens when I use my
> CalDigit dock) was I had an external USB-C monitor connected when I resumed,
> and when I'm home (where I sometimes forget to remove the NVMe USB4 adaptor)
> I always have my monitor connected to the dock.

It would be good to stick with a "proven" use-case so that the steps are
always the same. This may involve several issues in various parts of the
kernel and we need to track them one by one. If you change the steps in the
middle then we may end up finding completely different issues and it is not
helping the debugging effort.

The steps at the moment would be simply this:

1. Boot the system up, nothing connected.
2. Connect Thunderbolt dock and make sure UI authorizes it.
3. Connect Thunderbolt NVMe to the Thunderbolt dock and make sure UI authorizes it.
4. Verify that the devices behind PCIe tunnels are visible and functional (lspci for example)
5. Suspend the laptop by closing lid.
6. Unplug the dock (and the NVMe).
7. Resume the laptop by opening the lid.

Expectation: The system resumes just fine, finds the devices gone and stays functional.
Actual result: The system does not resume properly, seems to crash and burn the screen
	       is black.

Please correct me if I got something wrong. This is essentially that you go
from work to home, unplugging the dock and then resuming it at home.

The other thing is that in the pstore I see these:

thunderbolt 0000:00:0d.2: 0:5: __tb_path_deactivate_hop(): 401

but there is no such log in the mainline. If you have done some local
changes I suggest to drop all them to make sure we are looking at the same
source code.

> See attached dump log. I'm using the (somewhat still experimental) Xe
> display driver, but I've seen this same lockup happen with i915.

Please also keep using tha same graphics driver.

> In any case, I've now reverted 9d573d19, and when I get back to my CalDigit
> I can try instrumenting the code paths in the commit and see exactly where
> we're locking up.

No need to add any changes. Just try with the revert and see if that at
least makes the system resume properly. If it does then there could be
other issues but then you can take full dmesg and send to us instead of
those pstore snippets.

