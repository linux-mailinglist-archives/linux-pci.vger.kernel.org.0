Return-Path: <linux-pci+bounces-27628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F96AB5299
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 12:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE1F4A6B0E
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0652C255250;
	Tue, 13 May 2025 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDIRe6nL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F12550BA;
	Tue, 13 May 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131441; cv=none; b=VbPBD1Eoja/tUh+MS7SSM71c+CSj2EzN6dkEaly0IVyb9HZP5cI4TXBcwTVdyTeyG9jP1XycDET6pmNyl/oqBUqqcZ8okP3UDM+KOtndMbyX4Sjgvotm5N9ubNsVqDGPYzMGlq8uDeZ8gSU2Wy0ZrePg/EgPZSAzzghLy1T716I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131441; c=relaxed/simple;
	bh=hY6JMq7THSkphVKJ2fISJVvqScuKDYpOKS5qPPVopS0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kv/2nPK2WMp37hpA7VIbNNXaaABqs1OwfAVIJxvYbcgb9eambCq2AafkVaZ41G6dlOGF/cB9GOU5jnSaDrITqgyppP23UDbRNgVsF6UGrlZh5lwBeoX9R3/fMNk5Ve1hFjH5VYIhnS+phYbC4d/zdZqcqa4VEkvM187nMNaECjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDIRe6nL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747131440; x=1778667440;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=hY6JMq7THSkphVKJ2fISJVvqScuKDYpOKS5qPPVopS0=;
  b=KDIRe6nLFrFAjexiJsseNsqydHuPDH1DNDU1DeNxqbHSVt0FNwD9IzxQ
   zxwsWPeK/QM1PkF3W1ODls88dklCJ0JzJ8CwdOGgVH/q/D+yyhhRzROLh
   1fMSUK0nNpp8g9CxANt06DNnHQlTy86Em8HAX2ddOJJrVJrVx/Xp8YxwC
   Ixad7OjJuN/rwiDdmFt1azEOiX8e+Qj4kwXGRMmSGdu4eoQhOwfNkEa45
   6acEGGkc3kDNsll2bOBjUME6YmuOPImPL3Kp/RRAdIZqJ0ej/QQUHmMnJ
   x7K90mdM9SbGQRHWMAYemMeowmdSK8gTfYEmoEJ3RSai4hunlg2aU6GTJ
   g==;
X-CSE-ConnectionGUID: Zg/UqpuSSxucpbj1LVHVvQ==
X-CSE-MsgGUID: 3hyUFr7ySS+3bwiA85eSSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52770695"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="52770695"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:17:19 -0700
X-CSE-ConnectionGUID: 2OkGwFL6RHmF5mC+jShRFw==
X-CSE-MsgGUID: /dYZXNteR2qXU5fv6V4NFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="138178180"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.168]) ([10.245.246.168])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:17:17 -0700
Message-ID: <e7032baf-2742-450a-ab3d-5cb34bd22152@linux.intel.com>
Date: Tue, 13 May 2025 13:18:28 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] ASoC/SOF/PCI/Intel: add Wildcat Lake support
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 guennadi.liakhovetski@linux.intel.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
 <0b01a3ae-4766-490e-939d-1d16c2748644@linux.dev>
 <c95dec28-b77d-47ff-95a3-d103991180ed@linux.intel.com>
Content-Language: en-US
In-Reply-To: <c95dec28-b77d-47ff-95a3-d103991180ed@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 13/05/2025 09:21, Péter Ujfalusi wrote:
> 
> 
> On 12/05/2025 15:59, Pierre-Louis Bossart wrote:
>>
>>> The audio IP in Wildcat Lake (WCL) is largely identical to the one in
>>> Panther Lake, the main difference is the number of DSP cores, memory
>>> and clocking.
>>> It is based on the same ACE3 architecture.
>>>
>>> In SOF the PTL topologies can be re-used for WCL to reduce duplication
>>> of code and topology files. 
>>
>> Is this really true? I thought topology files are precisely the place where a specific pipeline is assigned to a specific core. If the number of cores is lower, then a PTL topology could fail when used on a WCL DSP, no?
> 
> Yes, that is true, however for generic (sdw, HDA) topologies this is not
> an issue as we don't spread the modules (there is no customization per
> platform).
> When it comes to product topologies, they can still be named as PTL/WCL
> if needed and have tailored core use.
> 
> Fwiw, in case of soundwire we are moving to a even more generic function
> topology split, where all SDW device can us generic function fragments
> stitched together to create a complete topology.
> Those will have to be compatible with all platforms

My line of thinking was:
sof-tgl topologies: TGL (4 cores), TGL-H (2 cores)
sof-adl topologies: ADL/ADL-N (4 cores), ADL-S (2 cores)
sof-arl topologies: ARL (3 cores), ARL-S (2 cores)

the PTL vs WCL is not much of a difference apart from the fact that the
produce code-name is not a postfixed one:
sof-ptl topologies: PTL (5 cores), WCL (3 cores)

-- 
Péter


