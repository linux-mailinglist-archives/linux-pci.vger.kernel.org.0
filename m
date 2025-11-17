Return-Path: <linux-pci+bounces-41387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B6DC63C00
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 12:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BEB04EC7A1
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 11:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBFA32E721;
	Mon, 17 Nov 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ca5Uao0h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC432E720;
	Mon, 17 Nov 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377657; cv=none; b=NgEaDK9WjA1tCxcvilV3l/5f6ut+7JlL4c2jCOXWUmLfe+wcFIn2W74DhDmY+KH3mY1c14+KGkk0jG4WujNbtDTkyY7iZmYq5BXRn5O0EEJ2d9aqm+fCiq3+d9BKVN+iwCcMlfmWkO9XgsY95FH46aNkHWKUg1H70KvwxrnX6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377657; c=relaxed/simple;
	bh=LEyrxl4QS+kEdy/vpDyW520f3/aAumrkRubXSa997dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JarNK2MDBQLmPSIlFQlBdSFdfNvFZ3ldadZUCwpvMGAwzaA6DRxaMwcRea30nrG9cqpAaji8iZgibynEJJ8jW7CMYHcXi2Ux7KN4Htm0syc+Qco9VRj5rjMicvHVZgRfMj/xZLCTUobWOV30IgeQ2X0m7PhhIZNGHqYbxqGnDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ca5Uao0h; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763377656; x=1794913656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LEyrxl4QS+kEdy/vpDyW520f3/aAumrkRubXSa997dY=;
  b=ca5Uao0hKrl3bxzs7l+28eYi4C4GF9yhx9+Ut7HpkONxz3RA4eW4PhLo
   huKalFJTE+UuT3nAIovJkYgvj08wPjnhd5D0g/X6p412V5SdjN6canbTz
   rNLnlLsoro/D+oPEEz+j3/2c4omynN+rNLnNyEuQmYgV6MehovPQoweiF
   KLQrDjCzcBIFqG3QogesY0cJaH+3KWkDmK1MEmzu2/1gsbadKxY1TMtG1
   XYITl1iXHYCDv3odFdf7qGlTZfDEQAyrUw6FEq/yRgtQKrdT1WdzRh2mU
   cL14xIYGNYMIjAjC4ZBMYVg26LqA7RKYwTiYdOzKzzSLtL6848ZI6JrLd
   A==;
X-CSE-ConnectionGUID: GfCBGdyXSQaQyYV9vXznAQ==
X-CSE-MsgGUID: Mre1kJW8RwCgU81f+y7//A==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="75694325"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="75694325"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 03:07:35 -0800
X-CSE-ConnectionGUID: ZWbehllxSqyNkhtbBeS3LQ==
X-CSE-MsgGUID: QHvt4iHUQx6O/94XQaaGSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="190864594"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO [10.245.246.29]) ([10.245.246.29])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 03:07:32 -0800
Message-ID: <31e9fd17-2632-455b-9a68-b0c2034874c4@linux.intel.com>
Date: Mon, 17 Nov 2025 13:07:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] ASoC/SOF/PCI/Intel: Support for Nova Lake S
To: Takashi Iwai <tiwai@suse.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kw@linux.com
References: <20251104121650.21872-1-peter.ujfalusi@linux.intel.com>
 <19a3db41-0d39-40eb-948f-3288fbe3cac8@linux.intel.com>
 <877bvohqbf.wl-tiwai@suse.de>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <877bvohqbf.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/11/2025 13:05, Takashi Iwai wrote:
> On Mon, 17 Nov 2025 11:11:21 +0100,
> Péter Ujfalusi wrote:
>>
>> Hi Takashi,
>>
>> On 04/11/2025 14:16, Peter Ujfalusi wrote:
>>> Hi,
>>>
>>> Changes since v1:
>>> - Add information for the users of the PCI ID
>>> - Add Acked-by tag for the pci_ids.h from Bjorn
>>> - Add Acked-by tags from Mark for the ASoC patches
>>>
>>> This series adds initial support for NVL-S from the Nova Lake family.
>>> NVL-S includes ACE4 audio subsystem, it has 2 DSP cores.
>>
>> Would you consider to pick up this series for 6.19?
> 
> I wasn't in Cc and it was ASoC subject prefix, so I overlooked this
> series.  Now pull to for-next branch.

Oh, I'm sorry, it really appears to be the case, thank you and sorry for
the mistake.

-- 
Péter


