Return-Path: <linux-pci+bounces-15738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4022B9B80B6
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FE61C21978
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73551BD03C;
	Thu, 31 Oct 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyhUhu/e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DFF1A0B00;
	Thu, 31 Oct 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393903; cv=none; b=eF6WnUh5cHgcX4yYbnGBM+xeIhvUSstCXlQ2Ui72LRiR5P4MAX3PB2UfhLCHrycxAzuQWTFffMMyzyCarT2kIeC27pFdc3bDSyx/kaIrj2dmCa8uSbDpilE9j2i3hfML9miennmGTwhltFdHIXq+DOwDF5h+FrjhIPHyUM++UHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393903; c=relaxed/simple;
	bh=1HncyWhQX+kDpPii6v7Lt+fPnDDyCcdt6X02irdfR2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B37o8aSnjmFLa9v04eHpK70Rjp5dv00QEUj4oCGL5ZeE39Kt6TnADxNDo6eS5HzvdL64i1g20yv6X8MtkHsK2W0C1Elzbh1KRq93RrNxSWofKaN8uXbqEHQ6CuVWDudZ5mkJx0Vh6LqxL1eFaZhXq5isNIp1xd2tRDzjdDFLX/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyhUhu/e; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730393902; x=1761929902;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1HncyWhQX+kDpPii6v7Lt+fPnDDyCcdt6X02irdfR2Y=;
  b=nyhUhu/eby95G3/f+dQ0qHlhm3baG4Hg7d2UNAe8YGn/5JCAEpfT9NO9
   bP9sJIns9REBOueD5Rz2BpIoBHl22sMj8W+u9srI4g1+6rY1/SGe7PzxG
   q+CbSQbbR99xvBlHvbDLkRlCADaxDiT//WWJec1/LaFscdg/Xngc5tcOQ
   s4auUB6kLzhqLXGil74sSI64U2VcxZbeXC6NModvsP71OVlEesA0JnQaN
   P4wJyPpNANi4FLsoPihPryv0RyEgTqzZqBwZHLXJjuwzh6yFkNzLB+Kcy
   Ch68On9xBoGIrQbJYiEMfBss1/clqbuG9k90r1XOSF91w0LHvYLKn32I3
   w==;
X-CSE-ConnectionGUID: 6QzwaYO/TZqNmX2XBLfdXA==
X-CSE-MsgGUID: sMhwhECLRoCtYZeZ0Y4ZuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30038410"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30038410"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:58:21 -0700
X-CSE-ConnectionGUID: N5oowuxYQiSyqKRwpvdciQ==
X-CSE-MsgGUID: phjvXgHVRhKxrIQnjAaPHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87278858"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.232]) ([10.125.108.232])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:58:19 -0700
Message-ID: <77b60d4e-2792-4e00-a91c-d2892c091050@intel.com>
Date: Thu, 31 Oct 2024 09:58:18 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe port devices
To: Terry Bowman <terry.bowman@amd.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-7-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241025210305.27499-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:02 PM, Terry Bowman wrote:
> The AER service driver's aer_get_device_error_info() function doesn't read
> uncorrectable (UCE) fatal error status from PCIe upstream port devices,
> including CXL upstream switch ports. As a result, fatal errors are not
> logged or handled as needed for CXL PCIe upstream switch port devices.
> 
> Update the aer_get_device_error_info() function to read the UCE fatal
> status for all CXL PCIe port devices.
> 
> The fatal error status will be used in future patches implementing
> CXL PCIe port uncorrectable error handling and logging.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/pci/pcie/aer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 1d3e5b929661..d772f123c6a2 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1250,6 +1250,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>  		   type == PCI_EXP_TYPE_RC_EC ||
>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
> +		   type == PCI_EXP_TYPE_UPSTREAM ||

At minimal we probably should do something like
(pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)
instead so we don't regress the original PCI behavior?
    
>  		   info->severity == AER_NONFATAL) {
>  
>  		/* Link is still healthy for IO reads */


