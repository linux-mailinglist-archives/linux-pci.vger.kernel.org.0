Return-Path: <linux-pci+bounces-27917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F2CABB4F8
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 08:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C46318940B2
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 06:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB4B24469C;
	Mon, 19 May 2025 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcjB5R5L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23163243374;
	Mon, 19 May 2025 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747635454; cv=none; b=caKKyajQB88xnL66glYNM74IMUjj4Mk7WVzMwUyAvu1zD6ImeB4JhvQiIZ7sqyxcYaxJE+o2x+vqv5P1KIL4LtUzgG8NHmsHJE8C5zwsk++1TeaQ1PyOW9EXWWoyXKIG24w+uTUyCZuzWXRAznKFoDemlxt8cB2Y3J23rGP2kpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747635454; c=relaxed/simple;
	bh=AsaBNs4kioFtrIJ7t739fMEgCPnoIPz41+KWg4JpbjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH9CaxgJWWdZxXNmCKwad+K92++tzxE8uO6n2cFRFvsdkzMFF+fcCJUTFzUpXAqYJlw0aLMkRjEooxxEELAk+IwdMyUUS4KgwLgvPnWOVZcFqcIeZSesMMR5Hh2rjcWLCHswAQDh/K+462ZmfJf4/euX9GXzIcU0TVWZ2hmxMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcjB5R5L; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747635453; x=1779171453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AsaBNs4kioFtrIJ7t739fMEgCPnoIPz41+KWg4JpbjM=;
  b=WcjB5R5LUE6UU3iFEYKNlwtnoWk+yvHe6WURHzgy6XpWMF+5CSPOchuT
   m6ec3X5SPkdXIQSqSdT4ZU+Ns+5SiSc5qy7K7PrjhsoDTTGYEAmz8LMJA
   keBYxRfcML7N+Ou4dSJj6iGH6wpGVVfRZ/fOoYQxVhMRf4TH4D/dIc8FI
   Xvs7DPQ86IhFOgWYIQMbIti80Y2aKYTEDoBsfFdBUXNpKGWB2z+3MayiR
   v4nGEwa6LMh9t2hEqMFebL33boDgGDnV32cCBVsBUaQB8bl0DfWaHPqJG
   lYlhZ+v29qfHH8oEYhojQObY+KGplAB9jXMzG0MQxUAWkmEt5slqUtyk8
   w==;
X-CSE-ConnectionGUID: VzfId4MtTJKoUM71oXW4hg==
X-CSE-MsgGUID: C8tuxtPwRQui2VxE+SUNbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49221150"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49221150"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 23:17:32 -0700
X-CSE-ConnectionGUID: 38vCFrusSRunSaoridHHng==
X-CSE-MsgGUID: mAkClPmLT1Wq5WLSgxJbhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="144246992"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO [10.245.246.4]) ([10.245.246.4])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 23:17:28 -0700
Message-ID: <da6da5ec-53a4-4e47-aac0-3ddcb3a1e8b9@linux.intel.com>
Date: Mon, 19 May 2025 09:18:40 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] PCI: pci_ids: add INTEL_HDA_WCL
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 guennadi.liakhovetski@linux.intel.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
 <20250508180240.11282-2-peter.ujfalusi@linux.intel.com>
 <20250515170318.GA1507459@rocinante>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20250515170318.GA1507459@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/05/2025 20:03, Krzysztof Wilczyński wrote:
> Hello,
> 
> Just a few small nitpicks.
> 
> Consider an update to the subject to match the history, e.g.,
> 
>   PCI: Add Intel Wildcat Lake audio Device ID

I have looked up the history and used the previous audio IP ID addition
commit as template:

a1f7b7ff0e10 ("PCI: pci_ids: add INTEL_HDA_PTL_H")

PCI: pci_ids: add INTEL_HDA_PTL_H

Add Intel PTL-H audio Device ID.

I will update and stick with the suggested suggestion for the future.
>> Add PCI id for Wildcat Lake audio.
> 
> Also, for consistency with other such commits:
> 
>   Add Wildcat Lake (WCL) audio Device ID.
> 
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> Acked-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> 
> Thank you!
> 
> 	Krzysztof

-- 
Péter


