Return-Path: <linux-pci+bounces-6962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4268B8DAF
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1A428595C
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D412FF9B;
	Wed,  1 May 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0nH744m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8412FF97;
	Wed,  1 May 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579460; cv=none; b=tTR49Q1nERm4yrNL6uF8BuhcdwGFenOy1KT0ugNcQD9tQYuP8P+dkS5VP1b1CsukTBfRs+60+fzT56SVOtmh/FqQtehNZAUJBknb4+6Mum71fZ+WDISdlcIhT0P5b43cwU5Q0JQMYng5pGOSx5ReKYCSO2nIVUncgraHpd2YumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579460; c=relaxed/simple;
	bh=kJhqCD+P7/r+w1S7vjp750geKtz9+y9ntnIRXHWddEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlP/dxHbxcRtJ4zZUWJRkoz0eedgzUR9x9LFV+1oriDQnF4QwwEpI7HBSzvauhxPpjJ+awy7EP1e5cUQBOyewTnjvAabNLRcPpxnlZY/tudj/iERakW0joDTVExWergloRwh96LhahbtwwXgYBfM4gzG1hjEVsRE582jgQ8A6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0nH744m; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714579459; x=1746115459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kJhqCD+P7/r+w1S7vjp750geKtz9+y9ntnIRXHWddEo=;
  b=Y0nH744mfbbBp5uPCtiVqO0I37H5BQuKJ3ez8kOypAphm79tkqZCW5Hl
   VqHBlb+yJdXrFDdtbp8ZP1cRu/9cCn1VXHDWUtB3d/dBqnrtJ8sUpMGgM
   TTnvDHTsBX2HzqJfwlNZ4X4WCx2K/FCUtze/yIoPRcpWJSA97LrLXg6ou
   uLlV/CmzsMuuYQkF12NBdjn2L8VZWYeGziLL5HbDMP1LOyob1qZXKphqX
   tW5QLJGy9piC7BOMXgmwamD3XBsAI+3r+SVfMllXW0TFeytu3Kf8fPWqV
   e9d8GEk12hctqcf88buHsAxZQSR9zJ3iNFVPVlg/h9MUAsAH3KN5j2/pz
   w==;
X-CSE-ConnectionGUID: IrrrohwuSWivJXYY9WthkQ==
X-CSE-MsgGUID: N4T0MFCHTx+KqD3b+F/ZCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10486757"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="10486757"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 09:04:18 -0700
X-CSE-ConnectionGUID: baoEEEVOSGS0nLHI47++VA==
X-CSE-MsgGUID: DOk9mVCtRCGkEr4L/k2mhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="26837461"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.124.221.175]) ([10.124.221.175])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 09:04:17 -0700
Message-ID: <0c7663b0-b812-4f41-a29d-f56b7cda81e6@intel.com>
Date: Wed, 1 May 2024 09:04:16 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] PCI/cxl: Move PCI CXL vendor Id to a common
 location from CXL subsystem
To: PJ Waskiewicz <ppwaskie@kernel.org>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 bhelgaas@google.com, lukas@wunner.de, Bjorn Helgaas <helgaas@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240429223610.1341811-1-dave.jiang@intel.com>
 <20240429223610.1341811-2-dave.jiang@intel.com>
 <91fe797284f433a76bdc1f804a6d86e0077a905f.camel@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <91fe797284f433a76bdc1f804a6d86e0077a905f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/1/24 8:37 AM, PJ Waskiewicz wrote:
> On Mon, 2024-04-29 at 15:35 -0700, Dave Jiang wrote:
>> Move PCI_DVSEC_VENDOR_ID_CXL in CXL private code to PCI_VENDOR_ID_CXL
>> in
>> pci_ids.h in order to be utilized in PCI subsystem.
>>
>> When uplevelling PCI_DVSEC_VENDOR_ID_CXL to a common locatoin Bjorn
>> suggested making it a proper PCI_VENDOR_ID_* define in
>> include/linux/pci_ids.h. While it is not in the PCI IDs database it
>> is a
>> reserved value and Linux treats it as a 'vendor id' for all intents
>> and
>> purposes [1].
> 
> Would you consider a patch, after this series merges, to upstream
> pciutils to sync up lspci's name of this value as well?  It would be
> less confusing to anyone looking at both codebases and trying to line
> up #define's.
> 

Yes I can look into doing that. 

> -PJ

