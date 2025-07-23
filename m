Return-Path: <linux-pci+bounces-32852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9260EB0FC92
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 00:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76879968449
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7C1213E7B;
	Wed, 23 Jul 2025 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzAtPbF9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE71C84D0;
	Wed, 23 Jul 2025 22:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308962; cv=none; b=Wq2fA0LvwoC0dSmJcZ2FKLvRZ8O55Bck2mGk3sjm/jwlInEM2EAuTQ6XmvZ1tBPy+DS1G7uUfBeKoZs6mRxEPB43lYdW86I0WH90kMiQq+OqNGfRFAqNQ8v1g7uS13t30rdLNG9TdbfKbXt+h6S9qsgl9wrekTqgBg0o/EZegX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308962; c=relaxed/simple;
	bh=6Uh2ZoT+nzrN+UxFuEeO4jkzeN5g5kZnBtnFt9jWryI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDFduneyck1Lo9J2SHKg+O6qHuelxviCzb/nuHz/CkVgoIgEzTsl5qFS83acgCVUTss1PJdMZqSm6MPfFxiD+ziZsoVvTQc1GxJm8ptjNixwW7o6al/1ctTTl7YNXG1Z3f2XTayGaVdMErLEyw8MsI6BxcrqT9iqtB8GzaBqOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzAtPbF9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753308961; x=1784844961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6Uh2ZoT+nzrN+UxFuEeO4jkzeN5g5kZnBtnFt9jWryI=;
  b=UzAtPbF9svJ9Qk5oVN4l6t2uL3EPzrLH6AtO6Afq5lWpUF2vdgQe1Ur9
   fST0LaJ/eF01caNE6JUqExtB3Vy89pIlhIqliCFXlJxADuqmBkYlbhyVV
   hSTCZ/b85aBDbE/nM9bGM6yEsCtSGdbi+RkoakGy8/PhHCCaMKkpQPTH1
   Hrr8P1ipvFEQ0jbHwiNKGycJiLMDsWSnLY3RqPSQGY8q7zwCUnKTwpzWn
   uaKid/ctTEdjeTzhDzelKPJ8WgdZ2zab1Uu/sPvvV5BjbLm4pnkotaPld
   6MjTflJArC19y8hrunwg75i7Nu+0UwhHU/ICyViQiQpTA9BbqrLu1LEND
   A==;
X-CSE-ConnectionGUID: qxlSzH7NTi697NcgOXksYQ==
X-CSE-MsgGUID: e9Trq0BPTsmj9/NG3deAEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59410217"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="59410217"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:16:00 -0700
X-CSE-ConnectionGUID: v+LFLybnQ9+S2TzEPWDA7Q==
X-CSE-MsgGUID: K2dhdmlzTPiSs/No4zmq8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="160492501"
Received: from dustinle-mobl1.gar.corp.intel.com (HELO [10.247.118.179]) ([10.247.118.179])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:15:50 -0700
Message-ID: <9fe4744e-390a-4cf8-827b-a6299b50afce@intel.com>
Date: Wed, 23 Jul 2025 15:15:45 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/17] cxl/pci: Remove unnecessary CXL Endpoint
 handling helper functions
To: dan.j.williams@intel.com, Terry Bowman <terry.bowman@amd.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-2-terry.bowman@amd.com>
 <68815b0f224d6_134cc7100e7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <68815b0f224d6_134cc7100e7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/25 2:58 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
>> are unnecessary helper functions used only for Endpoints. Remove these
>> functions as they are not common for all CXL devices and do not provide
>> value for EP handling.
>>
>> Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
>> to cxl_handle_cor_ras().
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Looks good to me:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Perhaps this and any other pure cleanups can go into a topic branch for
> 6.17 so that it does not need to be sent again if this set gets respun.
> Dave?

Sure. I can pick them up once you are done reviewing this series. Probably should cut things off by end of this week though. 

