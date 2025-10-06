Return-Path: <linux-pci+bounces-37615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E65BBE3B6
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 15:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9458E4EBA90
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E745B2D374E;
	Mon,  6 Oct 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7HV3MDd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55D27F19F;
	Mon,  6 Oct 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758748; cv=none; b=jT/JAL3NKaZUxz9gAF+4FZ5MSvH/mLwcohhVib3wq9kDNq+ZnOhnYKgMdvAILzF9Z798Hxf1fEhDaPamRWxMQqg62E/xqIF/vf9feEUgh+cvBlQyqe/AiMNrLG9ZqxlHFVV6yl0I38QmcSVJtoCnG3vJk3fC3sH8RNqp3PwailA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758748; c=relaxed/simple;
	bh=4IBVQkaNlJQeL/7kwoMR2W+EtGDZZF8s1gjkN1ztlQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/Heai8rPr7ruPDgle3pUDovyb74IWkhYS46sm5QeoeV1eOxaFnIg8znFM+eAontou8KKPyf7NsKhFBoGO1TzvP2mYnKOQYYxi+TBp1EDo5zX5RLcUw7jK/DVW9K1lNVWx98QD1k60n9ENSGHBQnl/uM9gtWVRb9nKuq9b6ETeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7HV3MDd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759758747; x=1791294747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IBVQkaNlJQeL/7kwoMR2W+EtGDZZF8s1gjkN1ztlQo=;
  b=O7HV3MDdjI5Q4po7Fp2ev7UX64pZ3O4fLw2xtKlTqDno1vVHKbvy0zoe
   NPgPp3HeeostlKvo4HmAzeDH1M5A2MFGddBmKocZumjvQ9cbFe7PH7ITV
   t2rP9e92HGJJDaW93UVGySUQHm3TmK0xwvEO5bQdpnkZ6w7NffRF9ozJG
   kHRep43j/ddkgJ7VCjNEIcQGzL4l/EaP+uOQGDLgecD1wJNSUvbJ6RsWD
   0ZeXYvl8NeMDyeuDxr5NiGBokSxt5+KQFO4DEFj2hZEUcIhE1bjIlYLIB
   kPxwqmQclI4HDVb6Kbjr1oPOoiXXQAZiE93fr5nj8JtmqQQu7O8Fh+u/A
   w==;
X-CSE-ConnectionGUID: 9hEX/jZ6R1K/ym3tK9wOLw==
X-CSE-MsgGUID: 88uAAA+PRL6QxpMzJ0L8wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="64549511"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="64549511"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 06:52:26 -0700
X-CSE-ConnectionGUID: Nr5aZJQfTgitbiz4KLiTlg==
X-CSE-MsgGUID: FNCCBtwYRXKwAfPz0lGLSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="179160338"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 06 Oct 2025 06:52:24 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9F51295; Mon, 06 Oct 2025 15:52:22 +0200 (CEST)
Date: Mon, 6 Oct 2025 15:52:22 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Brian Norris <briannorris@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <20251006135222.GD2912318@black.igk.intel.com>
References: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>

Hi,

On Fri, Oct 03, 2025 at 03:40:09PM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> When transitioning to D3cold, __pci_set_power_state() will first
> transition a device to D3hot. If the device was already in D3hot, this
> will add excess work:
> (a) read/modify/write PMCSR; and
> (b) excess delay (pci_dev_d3_sleep()).

How come the device is already in D3hot when __pci_set_power_state() is
called? IIRC PCI core will transition the device to low power state so that
it passes there the deepest possible state, and at that point the device is
still in D0. Then __pci_set_power_state() puts it into D3hot and then turns
if the power resource -> D3cold.

What I'm missing here?

> For (b), we already performed the necessary delay on the previous D3hot
> entry; this was extra noticeable when evaluating runtime PM transition
> latency.
> 
> Check whether we're already in the target state before continuing.
> 
> Note that __pci_set_power_state() already does this same check for other
> state transitions, but D3cold is special because __pci_set_power_state()
> converts it to D3hot for the purposes of PMCSR.
> 
> This seems to be an oversight in commit 0aacdc957401 ("PCI/PM: Clean up
> pci_set_low_power_state()").
> 
> Fixes: 0aacdc957401 ("PCI/PM: Clean up pci_set_low_power_state()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

BTW, I think only one SoB from you is enough ;-)

