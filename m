Return-Path: <linux-pci+bounces-13330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5DA97D76D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 17:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7355AB21D8E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F266156F2B;
	Fri, 20 Sep 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+OTZgaM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929CDC13B;
	Fri, 20 Sep 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846011; cv=none; b=PnFGzXLtUl6fpT0Zd0IWGQn/U6om1dISZG3erM+hGRa7bLLDzr2sEQYCyYypRyIdlgTTpXFNUsStS6vPjFD+UR0TxRAWqva9/hLUQ4fCYZFiJrGkzLDCVjTp9NhCzDVP8g42LDMvulkRooRAjgkaU9RMLTHnHUD+E3a/fJ4BasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846011; c=relaxed/simple;
	bh=chACH4WRHn+akX62/Tjn9TTs39+T5HAfNHQczpmJWb0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E14rNOCnHNDggnHDQFJqTlCJUktOXLRL56jkCzdi4wceD+Uy7R+llaeShcmISvVrT5poWx2d2CZKf9aYwsNsN2SByE82EcVDSfFW8rr+X1yrRT1as3me9R4++mP9vYh/Q+NF1whIdJTLdp70yO85iwP+cIZwAG58K4brct9WE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+OTZgaM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726846010; x=1758382010;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=chACH4WRHn+akX62/Tjn9TTs39+T5HAfNHQczpmJWb0=;
  b=X+OTZgaMOk556xpT4lYAEGaaTCJNfyqdupsOvHbTCAVfWmyvw1IjUbKz
   61vMSuYdAHJmDZh7KzhTRdRRGQ5La+MV2jNJtN7jP2jaNQeXrUvF9VHP5
   8DdiYdVqW77zWviA8O/nVFGoj6ZO+e/9HgymhySMN5gErLHWWacdN/5KN
   QCeYZl/g/dDZgHO6otpysYSQwto5cE6X2cljp+RgQcRZt2hAArvnff2C+
   FrZHL1Ht3WktdHNelw8Dp8LZeIYf9JHjGnfJUUaXfr6dTKB0UkF+wNd8h
   x6zjCQfhsGwMKArql+Av4dpRMuwnL0sBatV7Cn/xlI2eduW3FJXIaH5S7
   g==;
X-CSE-ConnectionGUID: /XphNNj9Q6u9na6X9ztK7Q==
X-CSE-MsgGUID: k8t7qNjsRTWPcxPpennAxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="28752540"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="28752540"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:26:43 -0700
X-CSE-ConnectionGUID: Uv4qBKzbQn6mHbUNnllnZA==
X-CSE-MsgGUID: fYGpBIJdQwe/2OwE+HtFAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70475427"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:26:43 -0700
Date: Fri, 20 Sep 2024 08:26:43 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
To: Rob Herring <robh@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
    krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org, 
    joyce.ooi@intel.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: PCI: altera: Convert to YAML
In-Reply-To: <CAL_JsqJg_ahW451sBht1k5SxP9s4dE09F-EWrgdXdDpUPFDfcQ@mail.gmail.com>
Message-ID: <5edb1ea6-63e-8bfb-aaa5-a333d5987339@linux.intel.com>
References: <20240809151213.94533-1-matthew.gerlach@linux.intel.com> <20240809151213.94533-2-matthew.gerlach@linux.intel.com> <20240809181401.GA973841-robh@kernel.org> <98185d65-805f-f09d-789-6eda61c4b36d@linux.intel.com>
 <CAL_JsqJg_ahW451sBht1k5SxP9s4dE09F-EWrgdXdDpUPFDfcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-788480230-1726846003=:3046662"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-788480230-1726846003=:3046662
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 9 Aug 2024, Rob Herring wrote:

> On Fri, Aug 9, 2024 at 12:43 PM <matthew.gerlach@linux.intel.com> wrote:
>> On Fri, 9 Aug 2024, Rob Herring wrote:
>>
>>> On Fri, Aug 09, 2024 at 10:12:07AM -0500, matthew.gerlach@linux.intel.com wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Convert the device tree bindings for the Altera Root Port PCIe controller
>>>> from text to YAML. Update the entries in the interrupt-map field to have
>>>> the correct number of address cells for the interrupt parent.
>>>>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>> ---
>>>> v8:
>>>
>>> v2 or v8 or ??? I'm confused and tools will be too.
>>
>> Sorry for the confusion. Patch 1 and patch 2 were individually reviewed
>> previously. Patch 1 was previously reviewed up to v8, and I included them
>> in the greater patch set for convience and completeness, and this is v2 of
>> the entire patch set.
>>
>> How should this be handled for better clarity? Would it be better to not
>> to include Patch 1 and 2 in the patch set and refer to them, or would it
>> better to remove the history in patch 1 and 2, or something else?
>
> Generally, if you added new patches you keep the versioning and say
> "vN: new patch" in the new patches.

Thanks for the clarification on the proper way to handle this.

>
> If this was 2 prior series, combined, there's not really a good answer
> other than don't do that.

Understood, I won't combine prior series in the future.

>
> Rob
>

Krzysztof Wilczyński has applied patch 1 and patch 2 to linux-next. Should 
I resubmit the patch set minus patch 1 and 2? There would be no changes to 
patches 3-7. Do I keep the v2, or should it be bumped to v3?

Thanks,
Matthew Gerlach

--8323329-788480230-1726846003=:3046662--

