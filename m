Return-Path: <linux-pci+bounces-27913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7EABAB46
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 19:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED904189D4FC
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A40205E16;
	Sat, 17 May 2025 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwQthg2y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE64C9D;
	Sat, 17 May 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747502013; cv=none; b=CkMDDPqXTsotx172HV5VfWm3ZPXJ7wUXJY6sRScWYCkXuPVAIu74Zvh0nMB9tpLBfOcg2HYR1H5L/o7MuG+76RNV7gZeInb0XC40Yf8KMX6pA5hROoBs5nz6dhQ5fN3zD0RUF3vrYw2AYikbHxALTkrAAv5ENmBhOxI1Cw6HBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747502013; c=relaxed/simple;
	bh=rrcHFaeFueUABMTSGN/TF/v2wE9MEHwCOvPTb7TnRqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7My7DKAM2oQmn3jRgbSgdAZavvJGvw6NA6tn/BzXfY/i5SgKs9uZGjPq/kKBGp++WjV0j1ntHNtvCS8dcCZ1xwnNelZQOKqGfyaz29ILFjsgdK5SmKT9RgCyM9N7skeEbt874X3CCi1DulxQw5A3tCzwlQJUTnSPPwj6NMTPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwQthg2y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747502012; x=1779038012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rrcHFaeFueUABMTSGN/TF/v2wE9MEHwCOvPTb7TnRqI=;
  b=HwQthg2ys1EaN58tf9MzuyfJvJ5XolPCv6y96Ngxl+lyA9XHN06FziX3
   CF8AlGkWtcdugQaESCSpmKFzAvn6ulMPqCeO66FKgJ4BwvKBVC7/44l0M
   4Xq0va12AC0oyT7NncbEuYvc5mUWiuL9E1X8SrTbWokcdxzzGEhyrWN8i
   pI1qFTfJpaDssAdeuiSLHLK1S2UAdGrCkmusy0gNSq3CrlG3WkcV2ETlE
   5mybmo44WkbCu0455Q9hTriYTVw6IqGJzafBi/cALcyGl/WbFZ/Qfq5lf
   Q5ee1oLRFZv3ZX+/B7zpblRA7g7J3eQoqRdjqK62S7Ls3iBAtjvCXk2DI
   g==;
X-CSE-ConnectionGUID: dI/OHUf9Tn6BbIMeH4uVQA==
X-CSE-MsgGUID: tAuEWAlZSpmQ4E78iUFpCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11436"; a="49328448"
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="49328448"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 10:13:30 -0700
X-CSE-ConnectionGUID: nYN23PSsSxqp8udO0vgfDQ==
X-CSE-MsgGUID: bg9jpyn7Rw2Leq1UZ2HkHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="139464365"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.179]) ([10.124.220.179])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 10:13:28 -0700
Message-ID: <9a0e7328-23d0-4949-b96a-2b3d07ea2c64@linux.intel.com>
Date: Sat, 17 May 2025 10:13:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] PCI: Remove hybrid-devres region requests
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Zijun Hu <quic_zijuhu@quicinc.com>,
 Yang Yingliang <yangyingliang@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250516174141.42527-1-phasta@kernel.org>
 <d399dd38-b26f-413f-ab02-49680ff87ed1@linux.intel.com>
 <aCi6aI3AmtELfr_X@smile.fi.intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aCi6aI3AmtELfr_X@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/17/25 9:33 AM, Andy Shevchenko wrote:
> On Fri, May 16, 2025 at 04:14:47PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 5/16/25 10:41 AM, Philipp Stanner wrote:
>> Looks good to me.
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
> Please, fix your tools, it's always goes two lines while it should be only a
> single one.
>

Thanks for pointing that out. I use Thunderbird, which auto-wraps lines at 72
characters by default. I've adjusted the settings so it shouldn't be a problem
anymore.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


