Return-Path: <linux-pci+bounces-27057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B8AA5A40
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 06:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F9A4E0C3F
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 04:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427FF1EE7DC;
	Thu,  1 May 2025 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdKEY60V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A36D1E5718;
	Thu,  1 May 2025 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746073317; cv=none; b=Xa5TA6ZoGNwcVEYiOn+KjPUj+sJIu0kOnFE3zh0nqPKJQHQFqM89tKp3cZxtMwcps5W97jZ4+4ujTJS/GeGF+PQpRCoP1/6KVy6NIbF6wGZiDli2eMPZ9eZVE+nNdNRFLZczFVWb3WkRCUE19POnx7QWZKyNS+NltzndHuMy0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746073317; c=relaxed/simple;
	bh=aqeI3rlQCdQaQe8pGSUPe1rCmviIqCU+MOwdAWaw+ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxDKPKYjarOjgQ9s3LdjodYJaTiMYJjjgyPkUOLuLioD7DkLA72gIB/PbR3Qm47H2HLmzJ5AXjCtReiIab+DS1GSAEnSLfBmK2Y1pHinXZQaDvC41ogCv5AbhOE+PXY55GFCJEspw4lak/BkFSKKg5i/sIoHzooT9x9MChbNYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdKEY60V; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746073315; x=1777609315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aqeI3rlQCdQaQe8pGSUPe1rCmviIqCU+MOwdAWaw+ig=;
  b=kdKEY60VcAT4t6dkdml58SWs2G/aPmohEok5iZYk6k4aHmyaZuiZaNuU
   atCG9xGAoxrCK19PCkvFr94GlKA8/kZN9ACxzjmbNzQMnCvBBwH64FKgD
   KA59fdbAId53WChwPA3cwHPld4TbwkhQ87BvqgOqE2EIkaDjoaE2eYZtH
   pEBIqgvOIKm/w6nlEPbc6rv/qabFQXtXMDbdwS+CC+jlAHnyYHFB6t1n3
   GdWnE6VjcVgE824Bn8F814zWZMSxJTYcVP/jxNsy5oSDZ60HXOTY8tFnX
   r6n40tAAvsgwzRHo3XN5sXcAGFpoabayL3Uw8sDRpA3nfafUpP69k2WMd
   w==;
X-CSE-ConnectionGUID: aYAczGTJSlKdYEHufsWhiQ==
X-CSE-MsgGUID: 7wFebmKXQnKYX+4p8TBFvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47889026"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="47889026"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 21:21:52 -0700
X-CSE-ConnectionGUID: +5qhL7bkR4W24F9yok7XtQ==
X-CSE-MsgGUID: vB84Ls+sR9q10h+TuvjOlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="134240048"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 21:21:48 -0700
Message-ID: <e232d563-a4db-4c33-8c3e-f47436dfceb8@linux.intel.com>
Date: Thu, 1 May 2025 12:17:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 rc] iommu: Skip PASID validation for devices without
 PASID capability
To: Tushar Dave <tdave@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, jgg@nvidia.com,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250430025426.976139-1-tdave@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250430025426.976139-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/25 10:54, Tushar Dave wrote:
> Generally PASID support requires ACS settings that usually create
> single device groups, but there are some niche cases where we can get
> multi-device groups and still have working PASID support. The primary
> issue is that PCI switches are not required to treat PASID tagged TLPs
> specially so appropriate ACS settings are required to route all TLPs to
> the host bridge if PASID is going to work properly.
> 
> pci_enable_pasid() does check that each device that will use PASID has
> the proper ACS settings to achieve this routing.
> 
> However, no-PASID devices can be combined with PASID capable devices
> within the same topology using non-uniform ACS settings. In this case
> the no-PASID devices may not have strict route to host ACS flags and
> end up being grouped with the PASID devices.
> 
> This configuration fails to allow use of the PASID within the iommu
> core code which wrongly checks if the no-PASID device supports PASID.
> 
> Fix this by ignoring no-PASID devices during the PASID validation. They
> will never issue a PASID TLP anyhow so they can be ignored.
> 
> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
> Cc:stable@vger.kernel.org
> Signed-off-by: Tushar Dave<tdave@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

