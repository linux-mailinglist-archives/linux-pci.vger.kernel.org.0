Return-Path: <linux-pci+bounces-40363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD30AC36A3D
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 17:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8536C1A42EEF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5484337104;
	Wed,  5 Nov 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aa4LlpN2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE05337B8D;
	Wed,  5 Nov 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359042; cv=none; b=CBfmb7wmwufc3H+VuqX3aWVAwhTCUOOEGumupx8DbOcX4fqd24N8KMFFYG1ojnFy+MA244ljftwE4qML1XS936gO1eW1Uu7uiHZE2d9OIpsKsMPsd6AF56iOApxPdpfpVElq0CQnRTsnvAQGUagXeIEE8X8XXQLpS5NJP9CQX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359042; c=relaxed/simple;
	bh=XYA0QT3mqjvdTOITUkYl9g9WPkydTiL2kfrfusBPpNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z03HDRRbxqW4cMTY5xEogAb5X3AwpzvwPU5D2ovcNGlOhZL1GSyoCbQxdCXipDzXVgHyHuCL+JcMqvNsihZhFg0Rabw75Fc9B+1bsfXTfQrflba/GcQ+7HJSQr9TKGZlZgKWHCyDTgMQn7PbfaI0ynwotvpvx9QeO9H+SxZ1Pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aa4LlpN2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762359041; x=1793895041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XYA0QT3mqjvdTOITUkYl9g9WPkydTiL2kfrfusBPpNU=;
  b=aa4LlpN2yOfkaUezIGabqAyathDHGILCtsFXpV9pPil0wB8Fb/CapP5R
   nuj3mW+Z82GrastbGF6EcwQ5Ap30gxl9+1CeuGTwRiaF8GedyhxppZX65
   2uiyhscojssgLA/ICn0qX4qIOEpPNmI96oODhkukC5ywxKVBC5WrkMyCR
   7CJVEy8FCs0Fy7V7QcfPeWwims5PgkjSilGMceChoARr+DJbTKMf2d6My
   MQ8tF4DAFLaQr9JrEWUObSdciWgW3CcMTP4YTByeW0gpm9e1EGKh+fiHS
   UNA7VxwmDRXkqNBdjn/+KQ8tdiTfNYEHWWe1JN0mzEQOQpuyEwGMk22Mm
   g==;
X-CSE-ConnectionGUID: oNmqnrn1SKG843Gyb5fTzg==
X-CSE-MsgGUID: fWYALw2uR9yHCMZm8SI48g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68337305"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="68337305"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 08:10:40 -0800
X-CSE-ConnectionGUID: oqAlASDJQ9ey+Wxwyv6JbA==
X-CSE-MsgGUID: fxLVxVU5SN+2XZuOAeMlng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187158870"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.242]) ([10.125.110.242])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 08:10:38 -0800
Message-ID: <3024ae89-4c19-4d29-aca4-0aef21bcd5e9@intel.com>
Date: Wed, 5 Nov 2025 09:10:37 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: "Bowman, Terry" <terry.bowman@amd.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, alison.schofield@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-24-terry.bowman@amd.com>
 <20251104184732.0000362f@huawei.com>
 <10115294-8be9-42af-a466-40a194cfa4e8@intel.com>
 <5246e21b-d226-4faf-936b-d3dffe2cc45e@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <5246e21b-d226-4faf-936b-d3dffe2cc45e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/5/25 7:59 AM, Bowman, Terry wrote:
> 
> 
> On 11/4/2025 5:43 PM, Dave Jiang wrote:
>>
>> On 11/4/25 11:47 AM, Jonathan Cameron wrote:
>>> On Tue, 4 Nov 2025 11:03:03 -0600
>>> Terry Bowman <terry.bowman@amd.com> wrote:

<snip>

>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>>> index 5bc144cde0ee..52c6f19564b6 100644
>>>> --- a/drivers/cxl/core/ras.c
>>>> +++ b/drivers/cxl/core/ras.c
>>>> @@ -259,8 +259,138 @@ static void device_unlock_if(struct device *dev, bool take)
>>>>  		device_unlock(dev);
>>>>  }
>>>>  
>>>> +/**
>>>> + * cxl_report_error_detected
>>>> + * @dev: Device being reported
>>>> + * @data: Result
>>>> + * @err_pdev: Device with initial detected error. Is locked immediately
>>>> + *            after KFIFO dequeue.
>>>> + */
>>>> +static int cxl_report_error_detected(struct device *dev, void *data, struct pci_dev *err_pdev)
>>>> +{
>>>> +	bool need_lock = (dev != &err_pdev->dev);
>>> Add a comment on why this controls need for locking.
>>> The resulting code is complex enough I'd be tempted to split the whole
>>> thing into locked and unlocked variants.
>> May not be a bad idea. Terry, can you see if this would reduce the complexity?
>>
>> DJ 
> 
> I agree and will split into 2 functions. Do you have naming suggestions for a function copy 
> without locks? Is cxl_report_error_detected_nolock() OK to go along with existing 
> cxl_report_error_detected()? 

Maybe cxl_report_error_detected_lock() vs cxl_report_error_detected().
I think there's also precedent of __cxl_report_error_detected() with no lock and indicates a raw function vs cxl_report_error_detected() with lock. 

DJ

> 
> Terry



