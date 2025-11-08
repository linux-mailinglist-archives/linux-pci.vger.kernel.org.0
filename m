Return-Path: <linux-pci+bounces-40638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C44C42FE4
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 17:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 556D74E04E9
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60CA23496F;
	Sat,  8 Nov 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUOqwWgE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3F1A9FBD
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762619408; cv=none; b=PpNJR+3WsH2N594K++ZyC4q64YlNa80h6/cBjjuGX30aX2v8gugtDiMCeJvMi2gu+GxrNVRMMCq7ru55+Hu2ile9XkZpsP3AMFU7y0kMvEkwSla+AaihWpZ4qls9YEhb+FOeR7L/fL6P3zr7BDXMVY1HZIODLXI+0OL7vqJTYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762619408; c=relaxed/simple;
	bh=KLATWUqwVXbxBZdEjJ7uo2sQ3g7+y5KId9IwBrf7ewg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip/Z7lodA4oNX+x3TW2IcCUrgJZ5mWlkUVmOIE0aqxJnQgTyMv2W5h8StcmHbQ/n7MuOpKlIodRrbLgYjpyKTKqzZQgva/dv5URhR3jQsHrmIUwWUXm0A4IdQ20bwLQB4GEj/3xXkMFfiZ5Y9emc2GU8DSmm3qE/1j2xKMJKoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUOqwWgE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762619407; x=1794155407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KLATWUqwVXbxBZdEjJ7uo2sQ3g7+y5KId9IwBrf7ewg=;
  b=nUOqwWgE1MyyEakVr1CnycqrskRA/bstB6UjX2VrQOIUEC9MvKwsv/hV
   w99gtxQy1ICDf3gCND6De65vybURs472qpahCUDjA7P7zvOqEq8A3uI45
   bD98W8m+OSQnTFWaY4v57M8NUPrvk4LsoFHc8x1O0oQ+yudFRKmFsgNtt
   LjDP58GO4CA+3eRrmyk3klsvYpDRDySp8qmSCFf6V+eidFT1yDvPW49t6
   93RnYeDK9iI/TQoMWDcLPWcKVZUka3DFx2vfj8ekQSm8hDm9EWhfDXAZX
   ozjK11AK5pRg/0DXEdPt9xQQJyI5nmp96oHIxCD+FJMELmEM64SZpd02v
   A==;
X-CSE-ConnectionGUID: RJsVMY1UQ+6iwYt1LxACTA==
X-CSE-MsgGUID: 3zIIeyOuSEWG3kvvg/iEYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="82140511"
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="82140511"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 08:30:06 -0800
X-CSE-ConnectionGUID: xty1xsjLTHCr/+TF0W3FVA==
X-CSE-MsgGUID: GmMbBg13Te2Tg8IoY3ThUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="211728746"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 08 Nov 2025 08:30:04 -0800
Date: Sun, 9 Nov 2025 00:15:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 2/9] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <aQ9ss3oK7ds4Srd9@yilunxu-OptiPlex-7050>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
 <20251031212902.2256310-3-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031212902.2256310-3-dan.j.williams@intel.com>

On Fri, Oct 31, 2025 at 02:28:54PM -0700, Dan Williams wrote:
> Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
> 7.9.26 IDE Extended Capability".
> 
> It is both a standalone port + endpoint capability, and a building block
> for the security protocol defined by "PCIe r7.0 section 11 TEE Device
> Interface Security Protocol (TDISP)". That protocol coordinates device
> security setup between a platform TSM (TEE Security Manager) and a
> device DSM (Device Security Manager). While the platform TSM can
> allocate resources like Stream ID and manage keys, it still requires
> system software to manage the IDE capability register block.
> 
> Add register definitions and basic enumeration in preparation for
> Selective IDE Stream establishment. A follow on change selects the new
> CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
> both a point-to-point "Link Stream" and a Root Port to endpoint
> "Selective Stream", only "Selective Stream" is considered for Linux as
> that is the predominant mode expected by Trusted Execution Environment
> Security Managers (TSMs), and it is the security model that limits the
> number of PCI components within the TCB in a PCIe topology with
> switches.
> 
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

