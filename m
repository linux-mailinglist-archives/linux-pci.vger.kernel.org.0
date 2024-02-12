Return-Path: <linux-pci+bounces-3336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7303A850EAB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 09:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082E9281BB7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8827379C3;
	Mon, 12 Feb 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acih2wtU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD48C11;
	Mon, 12 Feb 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725593; cv=none; b=Rr6xB9aK1R95NrM/DFmgTR7QT5cPA9jWzEHLKBY8XXLgyLnlrWKyfRRpFVX/2Kr5ZyTcAk2617Myp/hzeBpdZ4JUv1nI2+1s9DU3VodWXCZ0o+unPjEvjGArQ10CSDwHLCk8L4s4orXuYOpUonP4/dyjLD3pkJNrpR6y4eHtBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725593; c=relaxed/simple;
	bh=XMY8hQUo8ccDb9Sq56m5DaIdv4tVDtGMJ0OG5L9YX9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJg9Wl47nNVwwZeAMxzU7K4VqX8uTq6UHWKv3PfnJO1qPa6w+0r1mx8VWoX8Y6pgFf3bXCZpvw1HaIvg5QKzPP31CbG3WemXHukLpCz7vX7jk2dNL2YthTW60pZhOaOFETWA9MGVSF1htI2witUPMmkObFg5K+jEYfwrUZwUkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acih2wtU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707725592; x=1739261592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XMY8hQUo8ccDb9Sq56m5DaIdv4tVDtGMJ0OG5L9YX9E=;
  b=acih2wtU9UUlj1Bmr7M853FSCdUcA7hkvWMdZQSO/ctFF2Oiahp65UuM
   MQxbqbI0MdaKx+TmOEwxkIRqlUUSt0z53yV7hlV9r3BaxY1OC6OpzmPi7
   3wehA0fC4GCioGLTL9PhCWUdm5RnRtIkuZxY8brf0UaUM/HzzKxpTMZQN
   +2Xh04JO6f5u0WS9wWW08jAZ9aYeMBb23XnT1JkRbK9ziAFw1zRG/Wc3a
   o0z9Tw63mWGHjotbjKtgszHCi3P0VQ+ylQ0TajLpI9LloY2Ev4X2EaDJt
   Pxacfon3judwmAlRck2fcPHeM5W+2PPXuZnv3oLQF4RDPDy8gtD1tzYWx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1843897"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1843897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 00:13:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="825748126"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="825748126"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.62.245])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 00:13:08 -0800
Date: Mon, 12 Feb 2024 09:13:06 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] PCI/AER: Block runtime suspend when handling errors
Message-ID: <ZcnSgGBjpH3w9ZJa@linux.intel.com>
References: <20240209140841.1854711-1-stanislaw.gruszka@linux.intel.com>
 <64ad8d52-ba67-4156-8e36-7346605bdf48@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ad8d52-ba67-4156-8e36-7346605bdf48@linux.intel.com>

On Fri, Feb 09, 2024 at 07:45:05AM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 2/9/24 6:08 AM, Stanislaw Gruszka wrote:
> > PM runtime can be done simultaneously with AER error handling.
> > Avoid that by using pm_runtime_get_sync() before and pm_runtime_put()
> > after reset in pcie_do_recovery() for all recovering devices.
> >
> > pm_runtime_get_sync() will increase dev->power.usage_count counter
> > to prevent any possible future request to runtime suspend a device,
> > as well as resume device is was in D3hot state.
> runtime suspend a device or resume a device that was in D3hot state.

I think "or" is not proper here, since both: resume and prevention
of suspend are done. I'll reword this way:

pm_runtime_get_sync() will increase dev->power.usage_count counter
to prevent any possible future request to runtime suspend a device
It will also resume a device, if it was previously in D3hot state. 

Hope that's clearer.

Thanks
Stanislaw


