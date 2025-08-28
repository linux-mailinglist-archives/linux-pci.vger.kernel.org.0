Return-Path: <linux-pci+bounces-34968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180BFB393C0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 08:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4936D1BA32FF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D21EEA5D;
	Thu, 28 Aug 2025 06:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzdFEfTp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE41CAB3
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362300; cv=none; b=krrjdfY/BPX4+/41phRppewVkkA/bO/fjhskP3Q4rvmN2Lpd5EwQqRj3EAwNP6vQTrT/8oh+trrZvGA1/RYWNKx5Qhuo5IWJ5lWIAXg5I44vVlv98hpQNJ9US/HYEqJnXjaFuHvqWKs40ohJIVMomASm37zZNZ5MOCWNyO1RyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362300; c=relaxed/simple;
	bh=deoEk5vCJZCxUFiKzZOaYR266hd0dsxCcyXwke4xQLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZuGpQpzX7wIwXmr58M2Njc/OgoNBriV2toAPAFN239g20zfZYXoVDV7T3ZBNOSGbArRGdO5pzLILyZxujBW9F2wAxRGrYZaLOVEkQByc9LE5sHk5Ma4N3BAwWJAhT8jMvp//WvPkXJ785nciCIvCHuNGvrSWsqHrPAtGNXxkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzdFEfTp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756362298; x=1787898298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=deoEk5vCJZCxUFiKzZOaYR266hd0dsxCcyXwke4xQLQ=;
  b=OzdFEfTpLj2tKwrh9mQ2REis70ReSIs+FanKF+Cg4gVoJMgCiC7VQ2sY
   dpwsxExAP7N0b8T5evEXxENfxXkOuP11N4UgvSuhxFI4zu65FH05un1xq
   8PWVoeepIUKLIf/RcR5BDlSQ7msRhxfMsxuwlI2F8UXDjlurvC5069Rit
   utHvzcFbxQJwmMwuxw1FHFauchHeFa3nWZLhLfXRd7Pe2vQY3HttmcflR
   3FYeYENCjHZKOUWITvTwqEwk8d3ZzDkV+f3FkueD0qWvodcVR8tcZXBdX
   IOG9wuCOMaAnabe005IkTmIrFCr3Ygxjmo5lq/8UrSXE+bif9Tjfk8dqi
   Q==;
X-CSE-ConnectionGUID: YYCPQlhSQmS/QzjY4w3Ngg==
X-CSE-MsgGUID: cn7V2gKNS3ScEKH4WzWNgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70061472"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70061472"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:24:58 -0700
X-CSE-ConnectionGUID: ydw6WkglS+q8Ly7dXL+kKg==
X-CSE-MsgGUID: RJvJNFHXTI6Ts8TpK5ryNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="193684744"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:24:57 -0700
Received: from [10.124.220.49] (unknown [10.124.220.49])
	by linux.intel.com (Postfix) with ESMTP id 95E2220B571C;
	Wed, 27 Aug 2025 23:24:56 -0700 (PDT)
Message-ID: <19e7d95c-d7b7-4188-9a55-a8fa10ee1b21@linux.intel.com>
Date: Wed, 27 Aug 2025 23:24:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Support errors introduced by PCIe r6.0
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
References: <21f1875b18d4078c99353378f37dcd6b994f6d4e.1756301211.git.lukas@wunner.de>
 <64a661bd-cb64-4850-90d8-f34de9457173@linux.intel.com>
 <aK_uqHGw3B4vtx66@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aK_uqHGw3B4vtx66@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/27/25 10:52 PM, Lukas Wunner wrote:
> On Wed, Aug 27, 2025 at 12:56:41PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 8/27/25 6:41 AM, Lukas Wunner wrote:
>>> PCIe r6.0 defined five additional errors in the Uncorrectable Error
>>> Status, Mask and Severity Registers (PCIe r7.0 sec 7.8.4.2ff).
>> is 2ff a typo ?
> "ff" means "and following" (pages, etc), according to:
> https://en.wiktionary.org/wiki/ff
>
> Section 7.8.4.2 is the Status Register.  The Mask and Severity Registers
> are specified in the following sections 7.8.4.3 and 7.8.4.4.

Got it, thanks for clarifying. I wasn’t familiar with the "ff" notation.



>
> Thanks,
>
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


