Return-Path: <linux-pci+bounces-37721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5293BC6154
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C3919E2B44
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010725FA2D;
	Wed,  8 Oct 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcd+Zt2Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5132BE7C3
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942429; cv=none; b=JJQWF5IkaFnXKi7nNqtM9lvM/WEJ2FAUxDIQSVrnVCvKfqsswZOQn0Ql+zuLcqvbzJxm2d5/SofwTwRuU7pc3qO0A3GRYlmd1DzsakAHSA/d6Dp/pe2D33XyB3Bs8ZVcgBgwzFqeyaEMcClaZ9r0WucTyYRs7HO5d+sW2qX7HvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942429; c=relaxed/simple;
	bh=ax0LWZM9J1kHeBNaFbfBnu/IapGbJsY3j062UFsnR6U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XCustYpFuIsLx9Gh+eAioBDlWG+8CQE75Fp9KWQbLvgFT7P6gcPGEA2+dAKWczXEqHoMDUo+jiCBvPAz7WVJL8vhOpK6Mby+tFm91KtJxHC0qQ0mHO9ZaiGVFIF8ZlOuVZ8uyyUcrVss+/Q8m408cSWo13CTeqNMYz24nB8wn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcd+Zt2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FD2C4CEE7;
	Wed,  8 Oct 2025 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759942427;
	bh=ax0LWZM9J1kHeBNaFbfBnu/IapGbJsY3j062UFsnR6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pcd+Zt2ZTjI92Bg3DjFOatrYu7fI7mPXMs2cQPobPwbp0QiGaB6SiWXyz5aOciMLn
	 I+xts5QNvbe6CTpDDDqAOwPhZVPPzkWOLyOAsWdzNIgy42wuR/n6tZ7onZi+dIXiIf
	 WMy6pKs4DsvVY52F9JeiBib9/L9AWEVFApUQAZfUDlnDBscfDETlpdciyavEKQGEwz
	 xQENC9hOHQbVK8wWsWFH85Fv5ajbu+Zjf0f2MQeTpJQw8Gg31QKJXy/hyLq0mkvVto
	 Q6YMfsUg2Tzqm0a1bm3dA2NydiXdaGH+oJT8vDGuu5GrTS1+l6RTrzQ7ftlP1uJTNY
	 0hhgM6pum9Mlw==
Date: Wed, 8 Oct 2025 11:53:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hui Wang <hui.wang@canonical.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
	suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Message-ID: <20251008165345.GA627277@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821163936.GA681451@bhelgaas>

Nirmal, Jonathan, can you confirm that when RRS SV is enabled for VMD
Root Ports, we should actually see the 0x0001 value when a device
downstream of VMD responds with RRS?  From the log below, it appears
that we actually get 0xffffffff when reading Device ID after a reset.

On Thu, Aug 21, 2025 at 11:39:36AM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 03, 2025 at 08:05:05AM +0800, Hui Wang wrote:
> > On 7/2/25 17:43, Hui Wang wrote:
> > > On 7/2/25 07:23, Bjorn Helgaas wrote:
> ...

> > > > Thank you!  It seems like we get 0xffffffff (probably PCIe error) for
> > > > a long time after we think the device should be able to respond with
> > > > RRS.
> > > > 
> > > > I always thought the spec required that after the delays, a device
> > > > should respond with RRS if it's not ready, but now I guess I'm not
> > > > 100% sure.  Maybe it's allowed to just do nothing, which would lead to
> > > > the Root Port timing out and logging an Unsupported Request error.
> > > > 
> > > > Can I trouble you to try the patch below?  I think we might have to
> > > > start explicitly checking for that error.  That probably would require
> > > > some setup to enable the error, check for it, and clear it.  I hacked
> > > > in some of that here, but ultimately some of it should go elsewhere.
> ...

The patch is here:
https://lore.kernel.org/r/20250701232341.GA1859056@bhelgaas
and the log with that patch is here:

> > This is the testing result and log.
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/65

> We're waiting for 01:00.0, and we're seeing the poll message for about
> 375 ms:

[   10.177356] pci 10000:00:02.0: PCI bridge to [bus 01]
[   10.182278] pci 10000:01:00.0: [8086:0a54] type 00 class 0x010802 PCIe Endpoint
[   10.195247] pci 10000:00:02.0: pci_reset_secondary_bus: PCI_BRIDGE_CTL_BUS_RESET deasserted
[   10.195464] pci 10000:00:02.0: waiting 100 ms for downstream link, after activation
[   10.195467] pci 10000:00:02.0: pcie_wait_for_link_delay: active 1 delay 100 link_active_reporting 1
[   10.229269] pci 10000:00:02.0: pcie_wait_for_link_status: LNKSTA 0xb043
[   10.334784] pci 10000:00:02.0: pcie_wait_for_link_delay: waited 100ms

>   [   10.334786] pci 10000:01:00.0: pci_dev_wait: VF- bus reset timeout 59900
>   [   10.334792] pci 10000:00:02.0: pci_dev_wait: read 0xffffffff DEVSTA 0x0000
>   ...
>   [   10.708367] pci 10000:00:02.0: pci_dev_wait: read 0xffffffff DEVSTA 0x0000
> 
> The 00:02.0 Root Port has RRS SV enabled, but the config reads of the
> 01:00.0 Vendor ID did not return the RRS value (0x0001).  Instead,
> they returned 0xffffffff, which typically means an error on PCIe.

