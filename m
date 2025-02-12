Return-Path: <linux-pci+bounces-21327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D075A33361
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426C71670B9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C91209F4F;
	Wed, 12 Feb 2025 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvRg5a0y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0EC1D5143;
	Wed, 12 Feb 2025 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403049; cv=none; b=EeqT9FnFWzY2xifA2BQlkV4zdsU1f6F5k5Fmod4W3pE4PULPlMrG4J9J8whtZzdyYNnWxybq5ASN1hKqA6jRUA0spgLExHDwmpGDHfM04jbtSDdfb1kYU7rDlMa6rGMOiHPAlo7D5z7FD0DZZunlXoGcjb+uUhASKzPjs8/XRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403049; c=relaxed/simple;
	bh=Gky+ek+f6dQ1foZALEI0/TAWTKqzdPow3GkeyJofb+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpLrP8laLpL1Ocb5EmENf4/o4N3uu8fckGhv2NdP6Ic+vmqJf8ENDnzagFvn+lxZsQfjFx2/jLO0Jy1dV0gk5OXF0gijkugHGnDyCp5Jn2AOoEG3sW4ZxeNg3Gz9OEgUZhs6gP4kXWPu88AISZYCjsfSzDt7mF/PtIDxv+Bq6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvRg5a0y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739403048; x=1770939048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gky+ek+f6dQ1foZALEI0/TAWTKqzdPow3GkeyJofb+U=;
  b=JvRg5a0yg1dJNmeWBJSNIOUX3d1dZpwD5vBRe2NCU2NrOlHp6l3tfx/U
   WAQKwlox8Cg7guVZI0lbcvulUsf7h4xfRysIZEdET1k3IymSmkb+YlOwd
   Axb0n6YSTdGQ9Ye/e2nDtlXMjLXGPmdiiMSulG1G+rYmYD0so2vC8JEZf
   zfW3tW05aBPKBxR1b22oXSnLdURVW7ZvcnykrdLsLme45hI1k6MI5ihkW
   1wpmcJ669weqhkgIXQtQpFJe9SoXCyeFb/Bx//hYBaBzONBQqlacI8PRv
   Un1BOqgnc9D32Mii2bW6NIpL8/og6ezDSIQQxTI2iXL3YteyswD1iC3or
   g==;
X-CSE-ConnectionGUID: 78dOxnzpSVWQ5Qqgc5sPnw==
X-CSE-MsgGUID: DTkHK4VlQtyBw+mCAnqApQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40118303"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="40118303"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 15:30:47 -0800
X-CSE-ConnectionGUID: gTqfFyaFSginqyhtZ0OSWQ==
X-CSE-MsgGUID: Px8W/QkFRmGKFN5OaIUw0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118142063"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.123])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 15:30:46 -0800
Date: Wed, 12 Feb 2025 15:30:45 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	lukas@wunner.de, ming.li@zohomail.com,
	PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 14/17] cxl/pci: Update CXL Port RAS logging to also
 display PCIe SBDF
Message-ID: <Z60vJYIJQxJ7Cu9d@aschofie-mobl2.lan>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-15-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-15-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:41PM -0600, Terry Bowman wrote:
> CXL RAS errors are currently logged using the associated CXL port's name
> returned from devname(). They are typically named with 'port1', 'port2',
> etc. to indicate the hierarchial location in the CXL topology. But, this
> doesn't clearly indicate the CXL card or slot reporting the error.
> 
> Update the logging to also log the corresponding PCIe devname. This will
> give a PCIe SBDF or ACPI object name (in case of CXL HB). This will provide
> details helping users understand which physical slot and card has the
> error.
> 
> Below is example output after making these changes.
> 
> Correctable error example output:
> cxl_port_aer_correctable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status='Received Error From Physical Layer'
> 
> Uncorrectable error example output:
> cxl_port_aer_uncorrectable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Error'

snip
> 
>  
>  TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(dev, status, fe, hl),
> +	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(cxl_dev, pcie_dev, status, fe, hl),
>  	TP_STRUCT__entry(
> -		__string(devname, dev_name(dev))
> -		__string(parent, dev_name(dev->parent))
> +		__string(cxl_name, dev_name(cxl_dev))
> +		__string(cxl_parent_name, dev_name(cxl_dev->parent))
> +		__string(pcie_name, dev_name(pcie_dev))
> +		__string(pcie_parent_name, dev_name(pcie_dev->parent))

I get the rename of devname->cxl_name and parent->cxl_parent_name
since now we have pcie names too.  How about making those changes
in the previous patch where devname and parent are introduced. Then
this patch doesn't have any changes other than adding the pcie names.

Having said that, should/can this merge with the patch before it?


snip

