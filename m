Return-Path: <linux-pci+bounces-23514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2701AA5E134
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 16:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D3E17B5BA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7B2505CA;
	Wed, 12 Mar 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1jmuiHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07878198E76
	for <linux-pci@vger.kernel.org>; Wed, 12 Mar 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794949; cv=none; b=kPum85AgUAiyvSzI0PqHktXVVQ3ihC4+pbopYA/pebtqXMXSYpxaUGA+Xtdya+MX7gRPCFTGgwTuRRUE0sF01sLDP2hAdWWjET8CcsBzAOtWhMQ8dvIPVVa8D/NfQnLmrW8RHSYCwj8CsGmIe6uLDLej+IQVu+rX1nogmbG6WIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794949; c=relaxed/simple;
	bh=gNUCu/HfCKabfNHq333gUOCSHKVbcv1QSQE9zC3qAnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dP7rxlHWGG4USBCbmSwYCyxGFzp0OV5RSTIm0St5eodCfpbE3L3ie5OvsB0rwsOI8u6LM67KF+3M+HO+ABWmtIFB+W+Sl/bzxmeLMzK5B82TFCf3EoN0S6jE2qDLS6RfT9pg0Tz4NkZJGkWRvGgsX4K5fbsx7XvlouxTJe4ziO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1jmuiHs; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741794948; x=1773330948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gNUCu/HfCKabfNHq333gUOCSHKVbcv1QSQE9zC3qAnM=;
  b=U1jmuiHsclSDoteo4ThGuFo26EmHlvwtROAwTNGeuD2AROpojHPXaS06
   020aMYqD1okJK/vI/BR5qs8Bms/dhkslCQapNJILLv1yZOeT3flxKK17y
   yD+DUUXeM2ggtAwTaAWQNX97ex+d3HXC3oYPVZZEcQDgBHcUBbC5sXCE5
   5hESaKBKlEuYuV81+Q8co69UpU/cgGk/wWVkweQr4WCZmr3sUImTdomY8
   JXAWbEN5ENKh/GMeyWsiB5DR+6wv5KzWB8sh5DDEPeLBKQX6ZLsRNcHc/
   72jd6E6oE0D69wjDtevFMGn6AeVX77ApeXCe9A07mPjObQcimO9CUp6up
   A==;
X-CSE-ConnectionGUID: pyfvIf9uQBCMHDpeO8E6LQ==
X-CSE-MsgGUID: UAm6b6U5TbKQ2HL2vPZmHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43063087"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="43063087"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:55:46 -0700
X-CSE-ConnectionGUID: SJp2Ha2gRCucE3wUjD8A5Q==
X-CSE-MsgGUID: WVJELzpGSGu8FI18yNQfug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120649146"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 12 Mar 2025 08:55:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id BD5C01F2; Wed, 12 Mar 2025 17:55:43 +0200 (EET)
Date: Wed, 12 Mar 2025 17:55:43 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Kenneth Crudup <kenny@panix.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Ricky Wu <ricky_wu@realtek.com>
Subject: Re: [PATCH] PCI: pciehp: Avoid unnecessary device replacement check
Message-ID: <20250312155543.GH3713119@black.fi.intel.com>
References: <02f166e24c87d6cde4085865cce9adfdfd969688.1741674172.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02f166e24c87d6cde4085865cce9adfdfd969688.1741674172.git.lukas@wunner.de>

On Tue, Mar 11, 2025 at 07:27:32AM +0100, Lukas Wunner wrote:
> Hot-removal of nested PCI hotplug ports suffers from a long-standing
> race condition which can lead to a deadlock:  A parent hotplug port
> acquires pci_lock_rescan_remove(), then waits for pciehp to unbind
> from a child hotplug port.  Meanwhile that child hotplug port tries to
> acquire pci_lock_rescan_remove() as well in order to remove its own
> children.
> 
> The deadlock only occurs if the parent acquires pci_lock_rescan_remove()
> first, not if the child happens to acquire it first.
> 
> Several workarounds to avoid the issue have been proposed and discarded
> over the years, e.g.:
> 
> https://lore.kernel.org/r/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/
> 
> A proper fix is being worked on, but needs more time as it is nontrivial
> and necessarily intrusive.
> 
> Recent commit 9d573d19547b ("PCI: pciehp: Detect device replacement
> during system sleep") provokes more frequent occurrence of the deadlock
> when removing more than one Thunderbolt device during system sleep.
> The commit sought to detect device replacement, but also triggered on
> device removal.  Differentiating reliably between replacement and
> removal is impossible because pci_get_dsn() returns 0 both if the device
> was removed, as well as if it was replaced with one lacking a Device
> Serial Number.
> 
> Avoid the more frequent occurrence of the deadlock by checking whether
> the hotplug port itself was hot-removed.  If so, there's no sense in
> checking whether its child device was replaced.
> 
> This works because the ->resume_noirq() callback is invoked in top-down
> order for the entire hierarchy:  A parent hotplug port detecting device
> replacement (or removal) marks all children as removed using
> pci_dev_set_disconnected() and a child hotplug port can then reliably
> detect being removed.
> 
> Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Closes: https://lore.kernel.org/r/83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com/
> Reported-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> Closes: https://lore.kernel.org/r/20240926125909.2362244-1-acelan.kao@canonical.com/
> Tested-by: Kenneth Crudup <kenny@panix.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Also,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

