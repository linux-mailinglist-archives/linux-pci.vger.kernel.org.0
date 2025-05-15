Return-Path: <linux-pci+bounces-27797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ACBAB8724
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C407B340B
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32D298CA1;
	Thu, 15 May 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsyCy0GS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54163299935;
	Thu, 15 May 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313889; cv=none; b=lGfUrgDvAJlhPId88H2IdWWqc3+LqFdOsl25P/6+r+bEM+4eSbk6y/gQg+oT5esbZVTdeimvSVqp61G+ca/vSEadW+RYK2ZWnpIJ/iushe6FH7Lhshv8rCH+Hpl9zKJZGeAUO8JS19eiozqnshJQz9e0sEgzaGXMwO6yyOmUiNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313889; c=relaxed/simple;
	bh=YvH7l4ehAhfE5INGzdDxqi8DIwYZ/l9vZTFBUZEEEYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDwV8cUBbZskMaXEReSuw5yRSrAp0dnvg20XMIqQUfkZVSpJkiWgkAKtFjMl4wdftllzBb6IZIk7n24XcIErhHFdjQ1E9kEw2mm+4nAAsEUYimeIqMXOlaFL729izL0ePkDtAdqhfpqQQzxsMnGON/QMHseiCrkuam151za7yCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsyCy0GS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747313889; x=1778849889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YvH7l4ehAhfE5INGzdDxqi8DIwYZ/l9vZTFBUZEEEYw=;
  b=XsyCy0GSFFpnO/sxAEQtkLZIkUhYBaWfGXN0NbWGwRvku1s6NrB2VU8g
   PaLTSaawsB0gyUhjtSppf4VilaCd/nPOKsckY5IgHtkAgGZG6MgzJOtBV
   sOsCGwDiyyJejxmnPPnSgNQ1JRCDjoAVeDHRC1ZGci1sOsCEsImW5I29L
   gu7Cf8cknLI3OcNQUzlVw8+oCv6Ev3vclTqHa8ogLxO2dLf5WcihGIwzl
   aUJipErIJi0+DCMkZbsv0Fcpu0/IzaJz5J8fyAJdeesRPtPXjWdQa4sAT
   xWKa8ejBDV5nJEmo1nUzdAwYGtz9M58T1MabOaJH9J0jztNA39g1u3WeW
   A==;
X-CSE-ConnectionGUID: +ZmkQ+QUTziPcn4yhfq3ag==
X-CSE-MsgGUID: bDmbRnJIR8qszmUKVCbbFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="51883568"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="51883568"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 05:58:08 -0700
X-CSE-ConnectionGUID: 6ZGSrmLaQ4us4bwc/Y0FKA==
X-CSE-MsgGUID: KCsBCjOmTOuxzrM5KV2Dzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138863125"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 05:58:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFY9y-00000001qer-0rjK;
	Thu, 15 May 2025 15:58:02 +0300
Date: Thu, 15 May 2025 15:58:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/7] Docu: PCI: Update pcim_enable_device()
Message-ID: <aCXk2eDUJF2UbQ47@smile.fi.intel.com>
References: <20250515124604.184313-2-phasta@kernel.org>
 <20250515124604.184313-4-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515124604.184313-4-phasta@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 02:46:00PM +0200, Philipp Stanner wrote:
> pcim_enable_device() is not related anymore to switching the mode of
> operation of any functions. It merely sets up a devres callback for
> automatically disabling the PCI device on driver detach.
> 
> Adjust the function's documentation.

Is the "Docu" prefix in thew Subject aligned with the git history of this file?

-- 
With Best Regards,
Andy Shevchenko



