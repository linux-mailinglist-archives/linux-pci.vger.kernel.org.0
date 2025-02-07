Return-Path: <linux-pci+bounces-20895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D01A2C3E8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF703A4529
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C215E1F417A;
	Fri,  7 Feb 2025 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8keFPHi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350891D61AC;
	Fri,  7 Feb 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935676; cv=none; b=FUD5d1rUjJvzWGZy6RkxdR/VClH4nkDVo7xIaV9nLrSeiO1P3UKow+k184lOmqtnf1dL2H1+KyLZNYCGNmyj8J+Ydwp2N+fd10MPabT6oOYv1al1+o+7GeSz/nM9dv0JQakxkQnExSXFmaoaRgTClYQbfRAhT4SY22l8pxeTtqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935676; c=relaxed/simple;
	bh=DVhuDK56jFHQaEvFXFTvW7N3oqzH9vN5MkrlzTfQ7pQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ptF/Vufw6faVQd1fspuMJmm/yEDj4X5kkOEmPi3sPY/ZW5iVt8LSzbx84AshAeqzj4fLkowjRhjS1tEuhH5hNmbTHVYJaIlQ8pyTPjDgmv7P9G/tY7evMYdSvUNzOPQQHna5LWy9ZGB4mJTFj7d9UuehpjDda9n95lLyT0gjVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8keFPHi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738935675; x=1770471675;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DVhuDK56jFHQaEvFXFTvW7N3oqzH9vN5MkrlzTfQ7pQ=;
  b=V8keFPHiIMR8Sgkm97Olc4PrHUTv0vN7n8psIvrxKBvQDU2FV093nbMB
   dh6IAUubtFpa0pkoHZSsucfHfWzn4eHwhVvehzimcCHqpfVyHABkk6SSq
   nNRMWHcvQeP86j5OvXQdZeQz1HNZIkPhrdGfH+S4YSuIPNw7h1Yx6bPEP
   sd/nRFUY9BptbHxvP7URhOat1PMSiAMx54H3UkQ0igyj3dn6ALSbhhlNr
   jx6puw3gPoGymAtZRhQrHHPQuEaxctJIvaSay8RvG3s183Ak3r/Z9MLoh
   fGu9oRkNYxabViF+lLPhhlkKPfLp1ZaSrSKWW0FyE9EWLORqUwqKW6Qbn
   A==;
X-CSE-ConnectionGUID: xH/ooRo2Rh2ifOosOQjAZw==
X-CSE-MsgGUID: XyJ35utjRS6LWLupOfgH5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38805323"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="38805323"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:41:14 -0800
X-CSE-ConnectionGUID: 0c66oyQZRumw5fZ85etKlg==
X-CSE-MsgGUID: 7vqOUHQVSmyZCqDRNsUP7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115616385"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.246.100]) ([10.245.246.100])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:41:11 -0800
Message-ID: <ef0da9dc-3fc8-477c-9605-8951fd9aabec@linux.intel.com>
Date: Fri, 7 Feb 2025 15:41:38 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ASoC/SOF/PCI/Intel: add PantherLake H support
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.dev, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>
References: <20250207133736.4591-1-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20250207133736.4591-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/02/2025 15:37, Peter Ujfalusi wrote:
> Hi,
> 
> The audio IP in PTL-H is identical to the already supported PTL but the
> PCI-ID has been changes due to the differences in the product's
> configuration outside of audio.
> 
> To support PTL-H we really just need to wire up the new ID.

Somehow I have missed Takashi-san from recipients list...
Cc-d in here, sorry.

> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (1):
>   ASoC: SOF: Intel: pci-ptl: Add support for PTL-H
> 
> Pierre-Louis Bossart (3):
>   PCI: pci_ids: add INTEL_HDA_PTL_H
>   ALSA: hda: intel-dsp-config: Add PTL-H support
>   ALSA: hda: hda-intel: add Panther Lake-H support
> 
>  include/linux/pci_ids.h       | 1 +
>  sound/hda/intel-dsp-config.c  | 5 +++++
>  sound/pci/hda/hda_intel.c     | 2 ++
>  sound/soc/sof/intel/pci-ptl.c | 1 +
>  4 files changed, 9 insertions(+)
> 

-- 
Péter


