Return-Path: <linux-pci+bounces-8424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C475B8FF82F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 01:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F7C1F218C3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1F13E3F2;
	Thu,  6 Jun 2024 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IloYaVmr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DD13E404;
	Thu,  6 Jun 2024 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716454; cv=none; b=CDBoV/xIzCI3b506Vwli95MM22dBP0S5tvpAMKHvlN58+g4YBuLle3P7hvdvOeeHR26VUrI0zFhawJC6XWWq5CAU7SDVyJlhnhODabA9GtSfkq/Us4+nnW7wkTspsf0FgcDH9Nk6ZeY3MY+3pS/BBvOVaNocRmfvDZqn093aI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716454; c=relaxed/simple;
	bh=hv1ntvWaukOvDfj3RLXI/mAN+g2czYVW/d5siVX4uxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5pF81X0kr+16VzJNpnzu+ijDsDBTcjlRHozzocnAlNn2ma6Pc8m0alrSbIxKm4oNAg6nMwYTLk8A1rt763QgTAxYl/i2RnWRyU5aT5tGNDQvcH/LUZjnC3BuNlO93PAywtkFe3KnE8Am4z1CgFPu9Z6DfA6DyzpuKE2zGjkqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IloYaVmr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717716452; x=1749252452;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hv1ntvWaukOvDfj3RLXI/mAN+g2czYVW/d5siVX4uxc=;
  b=IloYaVmrFbXnbbopn9trqTmD/mwzLF6FLO+4TfAEfQ4r19QHe6tBqyv1
   SQ+Tr3v9/FTFgrpQWf4MmCN2p9Uopi2KbJyJy13xk1Y/0wYX/MSEce1kB
   TLtI8ttDdQ/+nkxIkqRs5fddAYvdkRuNQwxPpXZ9H+7ISdFLVvuzltH0B
   /tnstn16Agu2dlcYREQn7wMN0YEr3LgRnfO+4lQS1tluULgYgCWwaz/FR
   gVunyxUoixnbLv4sOnZEk/sGD/D9rahPhXW6DaCzIN8ailm+2t/zIop2D
   du1x5UfjFXkLsxrqmylIJUOc1ml3pNbOQ/6sjIsEdIAJOgeN+v+eYUJkM
   A==;
X-CSE-ConnectionGUID: OEkpjD4TT2CDqL42JOI+3Q==
X-CSE-MsgGUID: HuLf2mmxRnCqfrBbDqZGEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14645544"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14645544"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:27:31 -0700
X-CSE-ConnectionGUID: 8H+ZrvTvSTmB/t7xREWTLA==
X-CSE-MsgGUID: oyQmMKc/R02hrEFXy2JQRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="69304432"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.168]) ([10.125.109.168])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:27:31 -0700
Message-ID: <bdbabe95-6a2c-4069-b6af-eafbaa770400@intel.com>
Date: Thu, 6 Jun 2024 16:27:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cxl: Region bandwidth calculation for targets with
 shared upstream link
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240529214357.1193417-1-dave.jiang@intel.com>
 <ZmCwrk5MGnnHxmKV@aschofie-mobl2>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZmCwrk5MGnnHxmKV@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/24 11:38 AM, Alison Schofield wrote:
> On Wed, May 29, 2024 at 02:38:56PM -0700, Dave Jiang wrote:
>> This series provides recalculation of the CXL region bandwidth when the targets have
>> shared upstream link by walking the toplogy from bottom up and clamp the bandwdith
>> as the code trasverses up the tree. An example topology:
>>
>>  An example topology from Jonathan:
>>
>>                  CFMWS 0
>>                    |
>>           _________|_________
>>          |                   |
>>    GP0/HB0/ACPI0017-0  GP1/HB1/ACPI0017-1
>>      |          |        |           |
>>     RP0        RP1      RP2         RP3
>>      |          |        |           |
>>    SW 0       SW 1     SW 2        SW 3
>>    |   |      |   |    |   |       |   |
>>   EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
> 
> Are the ACPI0017 labels a typo?
> Expected host bridges to be labelled as ACPI0016's.
> 
> That's all, just did a drive-by on the art today.

It would be something like below in this case:
        GP0/ACPI0017-0
        HB0/ACPI0016-0
           |     |
          RP0   RP1

or

        GP0/ACPI0017-0
HB0/ACPI0016-0  HB1/ACPI0016-1
      |               |
     RP0             RP1




> 
> -- Alison

