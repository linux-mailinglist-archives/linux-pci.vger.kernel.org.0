Return-Path: <linux-pci+bounces-27912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5E4ABAB2C
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863181B605A3
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42932080C0;
	Sat, 17 May 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPptJyvP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6819E967;
	Sat, 17 May 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499632; cv=none; b=b7aoT4aba+fEBuWd06CLVYySHzRMypsny5EBT8OPcSVcZmvb3IxEry6HIKmsY/0mzX/pQ4S4dpq7HMPVo/jom5kk5ng4f500Pw5QJ372qqkJXTgcq4NEqsX85eW2zKGmMfv1vlqPvJVjgTmWnCS/jU1DfWbOCsytpu0AIZYc71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499632; c=relaxed/simple;
	bh=CAjSF0tqJzN8Uqpu8sDf6/DdDP0po6ZjIZckTQoKnGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbA45IqX43nlAPGVClaSRiVMYgQo2nubxlS+OghwMlQyNBuFV/aNxnipPokk/WBNc2j3uxOAIZ1+cj72ApN7e3bKPZPeityPxrUOorsKRqh4UbiCQ5OoXN5mN1/gcle1HMroJmfoODhjb9bTHLF6NL8AZ0EzrmlS8/iGW3FW71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPptJyvP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747499631; x=1779035631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CAjSF0tqJzN8Uqpu8sDf6/DdDP0po6ZjIZckTQoKnGo=;
  b=EPptJyvPsBdGCZcEQgBWsq7AXozv0OBmoa3hYAglBibw0zr8KaqpZmV/
   7G7FylZt2scpyglKDA2LvO+0J1NtFhEM8qL2O6BTkdhlipYRnT3ah7TgV
   EyHbxJHETsCSi2qf63s2bWL6RJXFot1VuWPwChrcIAtLH3PV5NWW5d3Yk
   0reV3V8caMxbCpAGpvjeHUU5Hn8JSXi6yh4vd88KqYlWfRsEoZrAlpv5V
   AqpW8eNXwSI/Re6qMaWH4eGUk+UUpTQgIUp3FbVEEUbzRftoHJdh6/D3J
   vfIAV7wxJVf6JhUGI41WTsKJJ2LjnXlZpKBUdoUdLGPKQ/5i314a49FHn
   g==;
X-CSE-ConnectionGUID: puCIiUiwSnyVZAvzl9qumw==
X-CSE-MsgGUID: aBtQGEODRVeO6eAUprx4XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11436"; a="48562532"
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="48562532"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 09:33:50 -0700
X-CSE-ConnectionGUID: wTYgRjL2TbqCO6VOcEuwUQ==
X-CSE-MsgGUID: gymAWzDmRAedWSnOwYeRyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="144094324"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 09:33:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uGKTo-00000002TjW-2TyR;
	Sat, 17 May 2025 19:33:44 +0300
Date: Sat, 17 May 2025 19:33:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: Remove hybrid-devres region requests
Message-ID: <aCi6aI3AmtELfr_X@smile.fi.intel.com>
References: <20250516174141.42527-1-phasta@kernel.org>
 <d399dd38-b26f-413f-ab02-49680ff87ed1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d399dd38-b26f-413f-ab02-49680ff87ed1@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 16, 2025 at 04:14:47PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 5/16/25 10:41 AM, Philipp Stanner wrote:

> Looks good to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>

Please, fix your tools, it's always goes two lines while it should be only a
single one.

-- 
With Best Regards,
Andy Shevchenko



