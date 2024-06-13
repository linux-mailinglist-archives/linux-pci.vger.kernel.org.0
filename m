Return-Path: <linux-pci+bounces-8698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D308590633A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 07:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDAF1C22413
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 04:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38C7135A51;
	Thu, 13 Jun 2024 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0UalRpS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE1135A4B
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254790; cv=none; b=K5pxWiSVXtwv0Rzfj4eX99/LQ+SUskHwTVol0Rk0homMGDgVut6q2aCfkEZJW84t4SVMUEARlD0CPrJQwwzja9+GOM2wEJdlQTznq8xpgorZ8DlmAkhk1B0/uy22KLaznZWViSDfwtKyANQ9exu5kE1jV5JqUZb5WjyWi4FCTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254790; c=relaxed/simple;
	bh=V8dLypkcp5xQxsStqf+DKspRtOxwD1f4T+BQAhzBgr8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W5cip2TfmfyUECXBMi8UFiJi09LwdC+iGmMrzUU5bbjtz/uJ0QSCqPP2Nq3xE+5U4Dm/AnpBPKmr1XltoHp3iE07avbTS+0b2gwQILv400gRTzr4usmDYduqYbufcWzYy+75nv1xqFQvTZ2dS0J/UNr115h77W0bfZMZNpJ8rng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0UalRpS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718254790; x=1749790790;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=V8dLypkcp5xQxsStqf+DKspRtOxwD1f4T+BQAhzBgr8=;
  b=U0UalRpSsOu7XvrGduc5QqGpjj7SyS19iMGNnK6a/VHDa1jpjfb2rhwS
   KgY4+UUvVecYpWra+ZXKIWchl2vKJD/GT8Dtfwmf7fBvLLNh1oQulmkeY
   D6QN9FqL4sT0hhsZbjG57e4tCTdn5n3mBt8/U8XV7CLQC6WCAAZ+1Rub6
   M/G1DH0O8epWUmRAgfl8iidxCGJHJ/cnwAqtNHS8MIZxH9wTME/XGmruu
   FBsiFyQbrZq2gb1iLNvU2KAmVopMtLBjx2q+gKDJPXX0uJ/tdPKewnjmd
   llzDrS/g5caz9vBhDc+JM+zsaZujJJvzmy2cGNDJ73qzavJ7yjdyrUDum
   A==;
X-CSE-ConnectionGUID: Af0kgTltTAWvgUwGuY4qXg==
X-CSE-MsgGUID: n4+fFbLkTAiHH0lPFGV0QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12047616"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12047616"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 21:59:49 -0700
X-CSE-ConnectionGUID: OlBiDGCZRui7Jm1Ng2skjw==
X-CSE-MsgGUID: M4o1H2zJQVGnLeBJCEcdmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="63191562"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.246.108]) ([10.245.246.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 21:59:47 -0700
Message-ID: <d1baeec6-87f5-4784-8cbf-b26a9de441e9@linux.intel.com>
Date: Thu, 13 Jun 2024 06:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ASoC: SOF: Intel: add initial support for PTL
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20240612065858.53041-1-pierre-louis.bossart@linux.intel.com>
 <20240612065858.53041-3-pierre-louis.bossart@linux.intel.com>
 <ZmnGWdZ0GrE9lnk2@finisterre.sirena.org.uk>
 <c835bf25-39b8-4f7a-9c77-33367085670e@linux.intel.com>
Content-Language: en-US
In-Reply-To: <c835bf25-39b8-4f7a-9c77-33367085670e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/12/24 18:08, Pierre-Louis Bossart wrote:
> 
> 
> On 6/12/24 18:01, Mark Brown wrote:
>> On Wed, Jun 12, 2024 at 08:58:55AM +0200, Pierre-Louis Bossart wrote:
>>> Clone LNL for now.
>>
>> There's a dependency somewhere I think:
>>
>> In file included from /build/stage/linux/sound/soc/sof/intel/pci-ptl.c:10:
>> /build/stage/linux/include/linux/pci.h:1063:51: error: ‘PCI_DEVICE_ID_INTEL_HDA_
>> PTL’ undeclared here (not in a function); did you mean ‘PCI_DEVICE_ID_INTEL_HDA_
>> MTL’?
>>  1063 |         .vendor = PCI_VENDOR_ID_##vend, .device = PCI_DEVICE_ID_##vend##
>> _##dev, \
>>       |                                                   ^~~~~~~~~~~~~~
>> /build/stage/linux/sound/soc/sof/intel/pci-ptl.c:52:11: note: in expansion of ma
>> cro ‘PCI_DEVICE_DATA’
>>    52 |         { PCI_DEVICE_DATA(INTEL, HDA_PTL, &ptl_desc) }, /* PTL */>       |           ^~~~~~~~~~~~~~~
> 
> Yes indeed there is a dependency, I mentioned it in the cover letter
> 
> 
> "
> This patchset depends on the first patch of "[PATCH 0/3] ALSA/PCI: add
> PantherLake audio support"
> "
> 
> We don't add PCI IDs every week but when we do we'll need an update of
> pci_ids.h prior to ALSA- and ASoC-specific patches.

There's another problem reported by the Intel build bot

https://lore.kernel.org/oe-kbuild-all/202406131144.L6gW0I47-lkp@intel.com/

When I modified the order of patches I broke the intermediate
compilation. The ACPI machine definition needs to come first.
I'll send a v2, sorry about that.

